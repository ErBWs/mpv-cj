/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.native

import std.collection.HashMap
import std.collection.ArrayList
import kit.PerformanceAnalysisKit.Hilog
import ohos_app_cangjie_mpvcj.erbws_logger.erbwsLogger
import ohos_app_cangjie_mpvcj.models.PlayerState
import ohos_app_cangjie_mpvcj.models.PlayerStream
import ohos_app_cangjie_mpvcj.models.PlayerConfig
import ohos_app_cangjie_mpvcj.models.MpvLogLevel
import ohos_app_cangjie_mpvcj.models.PlayerLog
import ohos_app_cangjie_mpvcj.models.Playlist
import ohos_app_cangjie_mpvcj.models.Tracks
import ohos_app_cangjie_mpvcj.models.Track
import ohos_app_cangjie_mpvcj.models.VideoTrack
import ohos_app_cangjie_mpvcj.models.AudioTrack
import ohos_app_cangjie_mpvcj.models.SubtitleTrack
import ohos_app_cangjie_mpvcj.models.Chapter
import ohos_app_cangjie_mpvcj.models.VideoParams
import ohos_app_cangjie_mpvcj.models.AudioParams
import ohos_app_cangjie_mpvcj.utils.kIsDebug

public class NativePlayer {
    private var handle: CPointer<mpv_handle>
    private var thread: ?Future<Unit> = None
    private var observerKey: UInt64 = 1
    private var observerKeys = HashMap<String, UInt64>()
    private var observedProperties = HashMap<String, (String) -> Unit>()
    private var observedEvents = HashMap<UInt32, (UInt32) -> Unit>()
    private let config: PlayerConfig

    public var state = PlayerState()
    public var stream = PlayerStream()

    public init(config: PlayerConfig) {
        this.config = config

    	unsafe {
            handle = mpv_create()
            if (handle.isNull()) {
                @erbwsLogger[e]("mpv create failed")
                return
            }

            let logLevel: ?String
            match (config.logLevel) {
            	case MpvLogLevel.None => logLevel = None
            	case MpvLogLevel.Fatal => logLevel = "fatal"
            	case MpvLogLevel.Error => logLevel = "error"
            	case MpvLogLevel.Warn => logLevel = "warn"
            	case MpvLogLevel.Info => logLevel = "info"
            	case MpvLogLevel.V => logLevel = "v"
            	case MpvLogLevel.Debug => logLevel = "debug"
            	case MpvLogLevel.Trace => logLevel = "trace"
            }
            if (let Some(level) <- logLevel) {
                let str = LibC.mallocCString(level)
                mpv_request_log_messages(handle, str)
                LibC.free(str)
            }

            let options = ArrayList<(String, String)>([
                ("config", "yes"),
                ("profile", "fast"),
                ("idle", "yes"),
                ("input-builtin-bindings", "no"),
                ("watch-later-options", "start,vid,aid,sid")
            ])
            options.add(("config-dir", config.configDir))
            for ((name, opts) in options) {
            	setOptionString(name, opts)
            }

            mpv_initialize(handle)
        }

        thread = spawn { threadEvent() }

        let configs = ArrayList<(String, String)>([
            ("keep-open", "yes"),
            ("hr-seek", "yes"),
            ("hr-seek-framedrop", "no"),
            ("hwdec-codecs", "h264,hevc,mpeg2video,mpeg4,h263,vvc"),
            ("hwdec-software-fallback", "yes"),
            ("video-sync", "display-resample"),
            ("target-colorspace-hint", "yes"),
            ("interpolation", "yes"),
            ("correct-downscaling", "no"),
            ("sigmoid-upscaling", "no"),
            ("dither-depth", "no"),
            ("demuxer-max-bytes", "1024MiB"),
            ("demuxer-max-back-bytes", "512MiB"),
            ("volume", "100"),
            ("sub-scale-with-window", "no"),
            ("sub-use-margins", "no"),
            ("sub-auto", "fuzzy"),
            ("sub-file-paths", "sub:subtitles"),
            ("subs-fallback", "yes"),
            ("osd-font", "HarmonyOS Sans"),
            ("osd-scale-by-window", "no"),
            ("sub-font-size", "38"),
            ("sub-color", "#ffffffff"),
            ("sub-outline-size", "2"),
            ("sub-outline-color", "#ff000000"),
            ("sub-bold", "yes"),
            ("sub-italic", "no"),
            ("sub-blur", "2")
        ])
        configs.add(("vo", config.vo))
        configs.add(("gpu-context", config.gpuContext))
        configs.add(("hwdec", if (config.hwdec) { "ohcodec" } else { "no" }))
        if (config.gpuContext == "ohos") {
            configs.add(("opengl-es", "yes"))
            configs.add(("egl-output-format", "rgba8"))
        }
        configs.add(("osc", if (config.osc) { "yes" } else { "no" }))
        configs.add(("osd-level", if (config.osd) { "1" } else { "0" }))
        configs.add(("deinterlace", if (config.deinterlace) { "yes" } else { "no" }))
        configs.add(("alang", config.alang))
        configs.add(("slang", config.slang))
        for ((name, property) in configs) {
            setProperty(name, property)
        }

        let properies: Array<(String, mpv_format)> = [
            ("time-pos/full", MPV_FORMAT_DOUBLE),
            ("duration/full", MPV_FORMAT_DOUBLE),
            ("playlist-playing-pos", MPV_FORMAT_INT64),
            ("track-list", MPV_FORMAT_NODE),
            ("chapter-list", MPV_FORMAT_NODE),
            ("video-params", MPV_FORMAT_NODE),
            ("audio-params", MPV_FORMAT_NODE),
            ("video-bitrate", MPV_FORMAT_DOUBLE),
            ("audio-bitrate", MPV_FORMAT_DOUBLE),
            ("pause", MPV_FORMAT_FLAG),
            ("paused-for-cache", MPV_FORMAT_FLAG),
            ("volume", MPV_FORMAT_DOUBLE),
            ("speed", MPV_FORMAT_DOUBLE),
            ("eof-reached", MPV_FORMAT_FLAG),
            ("cache-buffering-state", MPV_FORMAT_DOUBLE),
            ("demuxer-cache-time", MPV_FORMAT_INT64)
        ]
        for ((name, format) in properies) {
            _observeProperty(name, format)
        }
    }

    public func destroy() {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is already destroyed")
            return
        }

        stream.destroy()
        state = PlayerState()

        unsafe {
            if (let Some(thread) <- thread) { thread.cancel() }
            mpv_wakeup(handle)
            if (let Some(thread) <- thread) { thread.get() }
            thread = None
            mpv_terminate_destroy(handle)
            handle = CPointer<mpv_handle>()
        }
    }

    /**
     * Invoke mpv command.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#list-of-input-commands.
     *
     * @param commands  mpv commands.
     *
     * @return Union of mpv_node
     */
    public func command(commands: Array<String>) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        if (commands.isEmpty()) {
            @erbwsLogger[e]("commands must not be empty")
            return
        }

        unsafe {
            let cstrs = commands.map { s => LibC.mallocCString(s) }

            let ptr = LibC.malloc<CString>(count: cstrs.size + 1)
            for (i in 0..cstrs.size) {
                ptr.write(i, cstrs[i])
            }

            CPointer<UIntNative>(ptr + commands.size).write(0)

            mpv_command(handle, ptr)

            for (cstr in cstrs) {
                LibC.free(cstr)
            }
            LibC.free(ptr)
        }
    }

    /**
     * Invoke mpv command with a mpv_node returned.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#list-of-input-commands.
     *
     * @param commands  mpv commands.
     *
     * @return Union of mpv_node
     */
    public func commandWithReturn(commands: Array<String>): MpvNodeUnion {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return MpvNodeUnion.MpvNull
        }

        if (commands.isEmpty()) {
            @erbwsLogger[e]("commands must not be empty")
            return MpvNodeUnion.MpvNull
        }

        unsafe {
            let cstrs = commands.map { s => LibC.mallocCString(s) }

            let ptr = LibC.malloc<CString>(count: cstrs.size + 1)
            for (i in 0..cstrs.size) {
                ptr.write(i, cstrs[i])
            }

            CPointer<UIntNative>(ptr + commands.size).write(0)

            let res = LibC.malloc<mpv_node>()
            res.write(mpvNodeUnionToMpvNode(MpvNodeUnion.MpvNull))

            let status = mpv_command_ret(handle, ptr, res)

            for (cstr in cstrs) {
                LibC.free(cstr)
            }
            LibC.free(ptr)

            var ret: MpvNodeUnion = MpvNodeUnion.MpvNull
            if (status >= 0) {
                ret = mpvNodeToMpvNodeUnion(res.read())
                mpv_free_node_contents(res)
            } else {
                let error = mpv_error_string(status).toString()
                @erbwsLogger[e]("mpv command failed: ${error}")
            }
            LibC.free(res)
            ret
        }
    }

    /**
     * Invoke an mpv command represented by an mpv node.
     *
     * @param command   Command and arguments represented by an mpv node.
     *
     * @return Union of the returned mpv_node.
     */
    public func commandWithReturn(command: MpvNodeUnion): MpvNodeUnion {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return MpvNodeUnion.MpvNull
        }

        unsafe {
            let args = LibC.malloc<mpv_node>()
            args.write(mpvNodeUnionToMpvNode(command))

            let res = LibC.malloc<mpv_node>()
            res.write(mpvNodeUnionToMpvNode(MpvNodeUnion.MpvNull))

            let status = mpv_command_node(handle, args, res)

            freeMpvNode(args.read())
            LibC.free(args)

            var ret: MpvNodeUnion = MpvNodeUnion.MpvNull
            if (status >= 0) {
                ret = mpvNodeToMpvNodeUnion(res.read())
                mpv_free_node_contents(res)
            } else {
                let error = mpv_error_string(status).toString()
                @erbwsLogger[e]("mpv command failed: ${error}")
            }
            LibC.free(res)
            ret
        }
    }

    /**
     * Reads property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     *
     * @return Float64 property value.
     */
    public func getPropertyFloat64(property: String): Float64 {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return 0.0
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var res = 0.0
            mpv_get_property(handle, name, MPV_FORMAT_DOUBLE, CPointer<Unit>(inout res))
            LibC.free(name)
            res
        }
    }

    /**
     * Reads property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     *
     * @return Int64 property value.
     */
    public func getPropertyInt64(property: String): Int64 {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return 0
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var res = 0
            mpv_get_property(handle, name, MPV_FORMAT_INT64, CPointer<Unit>(inout res))
            LibC.free(name)
            res
        }
    }

    /**
     * Reads property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     *
     * @return Bool property value.
     */
    public func getPropertyBool(property: String): Bool {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return false
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var res = 0
            mpv_get_property(handle, name, MPV_FORMAT_FLAG, CPointer<Unit>(inout res))
            LibC.free(name)
            res != 0
        }
    }

    /**
     * Reads property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     *
     * @return String property value.
     */
    public func getPropertyString(property: String): String {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return ""
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var res = mpv_get_property_string(handle, name)
            LibC.free(name)

            if (res.isNull()) {
                return ""
            }

            let ret = res.toString()
            mpv_free(CPointer<Unit>(res.getChars()))
            ret
        }
    }

    /**
     * Sets property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param value     Property value.
     */
    public func setProperty(property: String, value: Int64) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var val = value
            mpv_set_property(handle, name, MPV_FORMAT_INT64, CPointer<Unit>(inout val))
            LibC.free(name)
        }
    }

    /**
     * Sets property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param value     Property value.
     */
    public func setProperty(property: String, value: Float64) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var val = value
            mpv_set_property(handle, name, MPV_FORMAT_DOUBLE, CPointer<Unit>(inout val))
            LibC.free(name)
        }
    }

    /**
     * Sets property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param value     Property value.
     */
    public func setProperty(property: String, value: Bool) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var val = if (value) { 1 } else { 0 }
            mpv_set_property(handle, name, MPV_FORMAT_FLAG, CPointer<Unit>(inout val))
            LibC.free(name)
        }
    }

    /**
     * Sets property.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param value     Property value.
     */
    public func setProperty(property: String, value: String) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            var val = LibC.mallocCString(value)
            mpv_set_property_string(handle, name, val)
            LibC.free(name)
            LibC.free(val)
        }
    }

    /**
     * Observes property change.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param callback  Callback invoked when the property changes.
     */
    public func observeProperty(property: String, callback: (String) -> Unit) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        if (observedProperties.contains(property) || observerKeys.contains(property)) {
        	@erbwsLogger[e]("${property} already observed")
            return
        }

        observedProperties[property] = callback
        observerKeys[property] = observerKey
        observerKey++
        _observeProperty(property, MPV_FORMAT_NONE, key: observerKeys[property])
    }

    /**
     * Unobserves property change.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#options
     * - https://mpv.io/manual/master/#property-list
     *
     * @param property  Property name.
     * @param callback  Callback invoked when the property changes.
     */
    public func unobserveProperty(property: String) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        if (!observedProperties.contains(property) && !observerKeys.contains(property)) {
        	@erbwsLogger[e]("${property} is not observed")
            return
        }

        _unobserveProperty(property, observerKeys[property])
        if (observedProperties.contains(property)) {
            observedProperties.remove(property)
        }
        if (observerKeys.contains(property)) {
            observerKeys.remove(property)
        }
    }

    /**
     * Observes mpv event.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#list-of-events
     *
     * @param event     Event id.
     * @param callback  Callback invoked when the event happens.
     */
    public func observeEvent(event: UInt32, callback: (UInt32) -> Unit): Unit {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        if (observedEvents.contains(event)) {
        	@erbwsLogger[e]("${event} already observed")
            return
        }

        observedEvents[event] = callback
        unsafe { mpv_request_event(handle, event, 1) }
    }

    /**
     * Unobserves mpv event.
     * Please use this method only if you know what you are doing.
     * See
     * - https://mpv.io/manual/master/#list-of-events
     *
     * @param event     Event id.
     * @param callback  Callback invoked when the event happens.
     */
    public func unobserveEvent(event: UInt32) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe { mpv_request_event(handle, event, 0) }

        if (observedEvents.contains(event)) {
            observedEvents.remove(event)
        }
    }

    private func setOptionString(option: String, value: String) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(option)
            let val = LibC.mallocCString(value)
            mpv_set_option_string(handle, name, val)
            LibC.free(name)
            LibC.free(val)
        }
    }

    private func _observeProperty(property: String, format: mpv_format, key!: UInt64 = 0) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            mpv_observe_property(handle, key, name, format)
            LibC.free(name)
        }
    }

    private func _unobserveProperty(property: String, key: UInt64) {
        if (handle.isNull()) {
            @erbwsLogger[e]("mpv handle is unavailable")
            return
        }

        unsafe {
            let name = LibC.mallocCString(property)
            mpv_unobserve_property(handle, key)
            LibC.free(name)
        }
    }

    private func threadEvent() {
        while (true) {
            if (Thread.currentThread.hasPendingCancellation) {
                break
            }

            unsafe {
                let event = mpv_wait_event(handle, -1.0)

                if (event.read().event_id == MPV_EVENT_NONE) {
                    continue
                }

                handleEvents(event.read())
            }
        }
    }

    private unsafe func handleEvents(event: mpv_event) {
        if (let Some(fn) <- observedEvents.get(event.event_id)) {
        	fn(event.event_id)
        }

        match (event.event_id) {
            case id where id == MPV_EVENT_LOG_MESSAGE =>
                let msg = CPointer<mpv_event_log_message>(event.data).read()
                let log = PlayerLog(msg.prefix.toString(), msg.level.toString(), msg.text.toString())
                if (kIsDebug) {
                    match (log.level) {
                    	case "fatal" => Hilog.fatal(0, "mpv", log.toString())
                    	case "error" => Hilog.error(0, "mpv", log.toString())
                    	case "warn" => Hilog.warn(0, "mpv", log.toString())
                    	case _ => Hilog.debug(0, "mpv", log.toString())
                    }
                }
                stream.log.add(log)
                if (msg.level.toString() == "error") {
                    stream.error.add(msg.text.toString())
                }
            case id where id == MPV_EVENT_PROPERTY_CHANGE =>
                let property = CPointer<mpv_event_property>(event.data).read()
                let name = property.name.toString()

                if (property.format == MPV_FORMAT_NONE) {
                    if (let Some(fn) <- observedProperties.get(name)) {
	                    fn(getPropertyString(name))
	                }
                    return
                }

                match (name) {
                    case "time-pos/full" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.position = CPointer<Float64>(property.data).read() * Duration.second
                            stream.position.add(state.position)
                        }
                    case "duration/full" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.duration = CPointer<Float64>(property.data).read() * Duration.second
                            stream.duration.add(state.duration)
                        }
                    case "playlist-playing-pos" =>
                        if (property.format == MPV_FORMAT_INT64) {
                            state.playlist.index = CPointer<Int64>(property.data).read()
                            stream.playlist.add(state.playlist)
                        }
                    case "track-list" =>
                        if (property.format == MPV_FORMAT_NODE) {
                            let node = mpvNodeToMpvNodeUnion(CPointer<mpv_node>(property.data).read())
                            if (let Some(values) <- node.asArray()) {
                                let tracks = Tracks()
                                for (value in values) {
                                    let id = value["id"].asInt64() ?? 0
                                    let trackType = value["type"].asString() ?? ""
                                    let codec = value["codec"].asString() ?? ""
                                    let lang = value["lang"].asString() ?? ""
                                    let title = value["title"].asString() ?? ""
                                    match (trackType) {
                                        case "video" => tracks.video.add(VideoTrack("${id}", codec: codec, lang: lang, title: title))
                                        case "audio" => tracks.audio.add(AudioTrack("${id}", codec: codec, lang: lang, title: title))
                                        case "sub" => tracks.subs.add(SubtitleTrack("${id}", codec: codec, lang: lang, title: title))
                                        case _ => continue
                                    }
                                }
                                state.tracks = tracks
                                stream.tracks.add(tracks)
                            }
                        }
                    case "chapter-list" =>
                        if (property.format == MPV_FORMAT_NODE) {
                            let node = mpvNodeToMpvNodeUnion(CPointer<mpv_node>(property.data).read())
                            if (let Some(values) <- node.asArray()) {
                                let chapters = ArrayList<Chapter>()
                                for (value in values) {
                                    let chapter = Chapter()
                                    chapter.title = value["title"].asString() ?? ""
                                    chapter.time = (value["time"].asFloat64() ?? 0.0) * Duration.second
                                    chapters.add(chapter)
                                }
                                state.chapters = chapters
                                stream.chapters.add(chapters)
                            }
                        }
                    case "video-params" =>
                        if (property.format == MPV_FORMAT_NODE) {
                            let node = mpvNodeToMpvNodeUnion(CPointer<mpv_node>(property.data).read())
                            let params = VideoParams()
                            params.pixelFormat = node["pixelformat"].asString() ?? ""
                            params.hwPixelFormat = node["hw-pixelformat"].asString() ?? ""
                            params.w = node["w"].asInt64() ?? 0
                            params.h = node["h"].asInt64() ?? 0
                            params.dw = node["dw"].asInt64() ?? 0
                            params.dh = node["dh"].asInt64() ?? 0
                            params.aspect = node["aspect"].asFloat64() ?? 0.0
                            params.par = node["par"].asFloat64() ?? 0.0
                            params.sar = node["sar"].asFloat64() ?? 0.0
                            params.colormatrix = node["colormatrix"].asString() ?? ""
                            params.colorLevels = node["colorlevels"].asString() ?? ""
                            params.primaries = node["primaries"].asString() ?? ""
                            params.gamma = node["gamma"].asString() ?? ""
                            params.light = node["light"].asString() ?? ""
                            params.chromaLocation = node["chroma-location"].asString() ?? ""
                            params.rotate = node["rotate"].asInt64() ?? 0
                            params.stereoIn = node["stereo-in"].asString() ?? ""
                            params.averageBpp = node["average-bpp"].asInt64() ?? 0
                            params.alpha = node["alpha"].asString() ?? ""
                            state.videoParams = params
                            stream.videoParams.add(params)
                        }
                    case "audio-params" =>
                        if (property.format == MPV_FORMAT_NODE) {
                            let node = mpvNodeToMpvNodeUnion(CPointer<mpv_node>(property.data).read())
                            let params = AudioParams()
                            params.format = node["format"].asString() ?? ""
                            params.samplerate = node["samplerate"].asInt64() ?? 0
                            params.channels = node["channels"].asString() ?? ""
                            state.audioParams = params
                            stream.audioParams.add(params)
                        }
                    case "video-bitrate" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.videoBitrate = CPointer<Float64>(property.data).read()
                            stream.videoBitrate.add(state.videoBitrate)
                        }
                    case "audio-bitrate" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.audioBitrate = CPointer<Float64>(property.data).read()
                            stream.audioBitrate.add(state.audioBitrate)
                        }
                    case "pause" =>
                        if (property.format == MPV_FORMAT_FLAG) {
                            state.playing = CPointer<Int32>(property.data).read() == 0
                            stream.playing.add(state.playing)
                        }
                    case "paused-for-cache" =>
                        if (property.format == MPV_FORMAT_FLAG) {
                            state.buffering = CPointer<Int32>(property.data).read() != 0
                            stream.buffering.add(state.buffering)
                        }
                    case "volume" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.volume = CPointer<Float64>(property.data).read()
                            stream.volume.add(state.volume)
                        }
                    case "speed" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.speed = CPointer<Float64>(property.data).read()
                            stream.speed.add(state.speed)
                        }
                    case "eof-reached" =>
                        if (property.format == MPV_FORMAT_FLAG) {
                            state.eof = CPointer<Int32>(property.data).read() != 0
                            stream.eof.add(state.eof)
                            if (state.eof) {
                                state.playing = false
                                state.buffering = false
                                state.track = Track()
                                state.tracks = Tracks()
                                stream.playing.add(false)
                                stream.buffering.add(false)
                                stream.track.add(state.track)
                                stream.tracks.add(state.tracks)
                            }
                        }
                    case "cache-buffering-state" =>
                        if (property.format == MPV_FORMAT_DOUBLE) {
                            state.bufferingPercentage = CPointer<Float64>(property.data).read()
                            stream.bufferingPercentage.add(state.bufferingPercentage)
                        }
                    case "demuxer-cache-time" =>
                        if (property.format == MPV_FORMAT_INT64) {
                            state.buffer = CPointer<Int64>(property.data).read() * Duration.second
                            stream.buffer.add(state.buffer)
                        }
                    case _ => ()
                }
            case _ =>
                if (event.event_id == MPV_EVENT_START_FILE) {
                	state.playing = true
                	state.eof = false
                	state.buffering = true
                	stream.playing.add(true)
                	stream.eof.add(false)
                	stream.buffering.add(true)
                }
                if (kIsDebug) {
                    let name = mpv_event_name(event.event_id).toString()
                    Hilog.debug(0, "mpv", "[event] " + name)
                }
        }
    }
}
