/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj

import std.sync.Mutex
import std.collection.ArrayList
import std.collection.HashMap
import ohos_app_cangjie_mpvcj.native.NativePlayer
import ohos_app_cangjie_mpvcj.native.MpvNodeUnion
import ohos_app_cangjie_mpvcj.models.PlayerState
import ohos_app_cangjie_mpvcj.models.PlayerStream
import ohos_app_cangjie_mpvcj.models.PlayerConfig
import ohos_app_cangjie_mpvcj.models.Media
import ohos_app_cangjie_mpvcj.models.Playlist
import ohos_app_cangjie_mpvcj.models.PlaylistMode
import ohos_app_cangjie_mpvcj.models.VideoTrack
import ohos_app_cangjie_mpvcj.models.AudioTrack
import ohos_app_cangjie_mpvcj.models.SubtitleTrack
import ohos_app_cangjie_mpvcj.erbws_logger.erbwsLogger
import kit.PerformanceAnalysisKit.Hilog
import kit.UIKit.XComponentController
import kit.UIKit.SurfaceRect
import kit.ImageKit.PixelMap
import kit.ImageKit.createPixelMap
import kit.ImageKit.InitializationOptions
import kit.ImageKit.Size

public class Player <: XComponentController {
    private let mtx = Mutex()

    public let native: NativePlayer

    /**
     * Initializes mpv player.
     *
     * let player = Player(config: PlayerConfig(
     *     vo: "gpu-next"
     * ))
     *
     * @param config    Player configuration.
     */
    public init(config!: PlayerConfig = PlayerConfig()) {
        native = NativePlayer(config)
    }

    /**
     * Current player state.
     */
    public prop state: PlayerState {
        get() {
            synchronized(mtx) { native.state }
        }
    }

    /**
     * Player event streams.
     */
    public prop stream: PlayerStream {
        get() {
            synchronized(mtx) { native.stream }
        }
    }

    /**
     * Opens a media.
     *
     * player.open(Media("https://www.example.com/sample.mp4"))
     *
     * @param media     Media item to open.
     * @param play      Whether to start playback immediately.
     */
    public func open(media: Media, play!: Bool = true) {
        synchronized(mtx) {
            let playlist = Playlist(ArrayList<Media>([media]), index: 0)
            open(playlist, play: play)
        }
    }

    /**
     * Opens a playlist.
     *
     * player.open(Playlist(ArrayList<Media>([
     *     Media("https://www.example.com/sample1.mp4")
     *     Media("https://www.example.com/sample2.mp4")
     *     Media("https://www.example.com/sample3.mp4")
     * ]), index: 0)
     *
     * @param playlist  Playlist to open.
     * @param play      Whether to start playback immediately.
     */
    public func open(playlist: Playlist, play!: Bool = true) {
        synchronized(mtx) {
            if (playlist.medias.isEmpty()) {
            	@erbwsLogger[e]("Playlist media should not be empty")
                return
            }

            native.state.playlist = playlist
            native.stream.playlist.add(playlist)

            native.command(["stop"])
            native.command(["playlist-clear"])
            native.command(["playlist-play-index", "none"])

            native.setProperty("pause", true)

            for (media in playlist.medias) {
                let options = HashMap<String, MpvNodeUnion>()

                if (let Some(httpHeaders) <- media.httpHeaders && !httpHeaders.isEmpty()) {
                    let headers = ArrayList<String>()
                    for ((name, value) in httpHeaders) {
                        let header = "${name}: ${value}"
                        headers.add("%${header.size}%${header}")
                    }
                    options["http-header-fields"] = MpvNodeUnion.MpvString(
                        String.join(headers.toArray(), delimiter: ",")
                    )
                }
                if (let Some(start) <- media.start) {
                    options["start"] = MpvNodeUnion.MpvString(
                        "${Float64(start.toMilliseconds()) / 1000.0}"
                    )
                }
                if (let Some(end) <- media.end) {
                    options["end"] = MpvNodeUnion.MpvString(
                        "${Float64(end.toMilliseconds()) / 1000.0}"
                    )
                }

                native.commandWithReturn(MpvNodeUnion.MpvArray([
                    MpvNodeUnion.MpvString("loadfile"),
                    MpvNodeUnion.MpvString(media.uri),
                    MpvNodeUnion.MpvString("append"),
                    MpvNodeUnion.MpvInt64(-1),
                    MpvNodeUnion.MpvMap(options)
                ]))
            }

            native.setProperty("playlist-pos", playlist.index)

            if (play) {
                native.setProperty("pause", false)
                native.state.playing = true
                native.stream.playing.add(true)
            }
        }
    }

    /**
     * Stops playback.
     */
    public func stop() {
        synchronized(mtx) {
            native.command(["stop"])
            native.command(["playlist-clear"])
            native.command(["playlist-play-index", "none"])

            let previous = native.state
            let reset = PlayerState()
            reset.volume = previous.volume
            reset.speed = previous.speed
            reset.playlistMode = previous.playlistMode
            reset.buffering = false
            native.state = reset

            native.stream.playlist.add(reset.playlist)
            native.stream.playing.add(reset.playing)
            native.stream.eof.add(reset.eof)
            native.stream.duration.add(reset.duration)
            native.stream.position.add(reset.position)
            native.stream.buffering.add(reset.buffering)
            native.stream.bufferingPercentage.add(reset.bufferingPercentage)
            native.stream.buffer.add(reset.buffer)
            native.stream.track.add(reset.track)
            native.stream.tracks.add(reset.tracks)
            native.stream.chapters.add(reset.chapters)
            native.stream.videoParams.add(reset.videoParams)
            native.stream.videoBitrate.add(reset.videoBitrate)
            native.stream.audioParams.add(reset.audioParams)
            native.stream.audioBitrate.add(reset.audioBitrate)
        }
    }

    /**
     * Destroys mpv player.
     */
    public func destroy() {
        synchronized(mtx) {
            stop()
            native.destroy()
        }
    }

    /**
     * Starts or resumes playback.
     */
    public func play() {
        synchronized(mtx) {
            if (native.state.eof) {
                seek(Duration.Zero)
                native.setProperty("playlist-pos", 0)
            }
            native.setProperty("pause", false)
        }
    }

    /**
     * Pauses playback.
     */
    public func pause() {
        synchronized(mtx) {
            native.setProperty("pause", true)
        }
    }

    /**
     * Toggles between playing and paused states.
     */
    public func playOrPause() {
        synchronized(mtx) {
            native.command(["cycle", "pause"])
        }
    }

    /**
     * Seeks to an absolute playback position.
     *
     * @param duration  Absolute playback position.
     */
    public func seek(duration: Duration) {
        synchronized(mtx) {
            let seconds = Float64(duration.toMilliseconds()) / 1000.0
            native.command(["seek", "${seconds}", "absolute"])
            native.state.eof = false
            native.stream.eof.add(false)
        }
    }

    /**
     * Advances to the next playlist item.
     */
    public func next() {
        synchronized(mtx) {
            play()
            native.command(["playlist-next"])
        }
    }

    /**
     * Returns to the previous playlist item.
     */
    public func previous() {
        synchronized(mtx) {
            play()
            native.command(["playlist-prev"])
        }
    }

    /**
     * Jumps to the the specified playlist item.
     *
     * @param index     Playlist item index.
     */
    public func jump(index: Int64) {
        synchronized(mtx) {
            if (index < 0 || index >= native.state.playlist.medias.size) {
                @erbwsLogger[e]("Playlist index ${index} is out of range")
                return
            }

            play()
            native.setProperty("playlist-pos", index)
        }
    }

    /**
     * Sets the playlist playback mode.
     *
     * @param mode  Playlist playback mode.
     */
    public func setPlaylistMode(mode: PlaylistMode) {
        synchronized(mtx) {
            match (mode) {
                case PlaylistMode.None =>
                    native.command(["playlist-unshuffle"])
                    native.setProperty("loop-file", "no")
                    native.setProperty("loop-playlist", "no")
                case PlaylistMode.File =>
                    native.command(["playlist-unshuffle"])
                    native.setProperty("loop-file", "inf")
                    native.setProperty("loop-playlist", "no")
                case PlaylistMode.Playlist =>
                    native.command(["playlist-unshuffle"])
                    native.setProperty("loop-file", "no")
                    native.setProperty("loop-playlist", "inf")
                case PlaylistMode.Random =>
                    native.setProperty("loop-file", "no")
                    native.setProperty("loop-playlist", "no")
                    native.command(["playlist-shuffle"])
            }
            native.state.playlistMode = mode
            native.stream.playlistMode.add(mode)
        }
    }

    /**
     * Sets the playback volume.
     *
     * @param volume    Playback volume.
     */
    public func setVolume(volume: Float64) {
        synchronized(mtx) {
            native.setProperty("volume", volume)
        }
    }

    /**
     * Sets the playback speed.
     *
     * @param speed     Playback speed.
     */
    public func setSpeed(speed: Float64) {
        synchronized(mtx) {
            if (speed <= 0.0) {
                @erbwsLogger[e]("speed must be greater than 0.0")
                return
            }
            native.setProperty("speed", speed)
        }
    }

    /**
     * Selects the video track.
     *
     * @param track     Video track.
     */
    public func setVideoTrack(track: VideoTrack) {
        synchronized(mtx) {
            native.setProperty("vid", track.id)
            native.state.track.video = track
            native.stream.track.add(native.state.track)
        }
    }

    /**
     * Selects the audio track or loads an external audio track.
     *
     * player.setAudioTrack(
     *     AudioTrack.uri(
     *         "https://www.iandevlin.com/html5test/webvtt/v/upc-tobymanley.mp4",
     *         lang: "chi",
     *         title: "external"
     *     )
     * )
     *
     * @param track     Audio track.
     */
    public func setAudioTrack(track: AudioTrack) {
        synchronized(mtx) {
            if (track.isUri) {
                native.command([
                    "audio-add",
                    track.id,
                    "select",
                    if (track.title.isEmpty()) { "external" } else { track.title },
                    if (track.lang.isEmpty()) { "auto" } else { track.lang }
                ])
            } else {
                native.setProperty("aid", track.id)
            }
            native.state.track.audio = track
            native.stream.track.add(native.state.track)
        }
    }

    /**
     * Selects the subtitle track or loads an external subtitle track.
     *
     * player.setSubtitleTrack(
     *     SubtitleTrack.uri(
     *         "https://www.iandevlin.com/html5test/webvtt/upc-video-subtitles-en.vtt",
     *         lang: "chi",
     *         title: "external"
     *     )
     * )
     *
     * @param track     Subtitle track.
     */
    public func setSubtitleTrack(track: SubtitleTrack) {
        synchronized(mtx) {
            if (track.isUri) {
                native.command([
                    "sub-add",
                    track.id,
                    "select",
                    if (track.title.isEmpty()) { "external" } else { track.title },
                    if (track.lang.isEmpty()) { "auto" } else { track.lang }
                ])
            } else {
                native.setProperty("sid", track.id)
            }
            native.state.track.subs = track
            native.stream.track.add(native.state.track)
        }
    }

    /**
     * Captures the current video frame as a PixelMap.
     *
     * @param withSub   Whether to include subtitles.
     *
     * @return Captured video frame.
     */
    public func screenshot(withSub!: Bool = true): PixelMap {
        synchronized(mtx) {
            let raw = native.commandWithReturn([
                "screenshot-raw",
                if (withSub) { "subtitles" } else { "video" },
                "bgra"
            ])
            let imageOptions = InitializationOptions(
                size: Size(
                    width: Int32(raw["w"].asInt64() ?? 1),
                    height: Int32(raw["h"].asInt64() ?? 1)
                )
            )
            createPixelMap(raw["data"].asByteArray() ?? [], imageOptions)
        }
    }

    override protected func onSurfaceCreated(id: String): Unit {
        synchronized(mtx) {
            native.setProperty("wid", id)
        }
    }

    override protected func onSurfaceChanged(id: String, rect: SurfaceRect): Unit {
        synchronized(mtx) {
            native.setProperty("ohos-surface-size", "${UInt64(rect.surfaceWidth)}x${UInt64(rect.surfaceHeight)}")
        }
    }

    override protected func onSurfaceDestroyed(_: String): Unit {
        synchronized(mtx) {
            native.setProperty("wid", "0")
        }
    }
}
