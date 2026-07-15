/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models
import std.collection.ArrayList
import ohos_app_cangjie_mpvcj.utils.Stream

public class PlayerStream {
    /**
    * Called once when mpv initialization is completed.
    */
    public var ready = Stream<Bool>()
    /**
    * Currently opened files.
    */
    public var playlist = Stream<Playlist> {
        pre, cur => pre == cur
    }
    /**
    * Whether player is playing.
    */
    public var playing = Stream<Bool> {
        pre, cur => pre == cur
    }
    /**
    * Whether end of file reached.
    */
    public var eof = Stream<Bool> {
        pre, cur => pre == cur
    }
    /**
    * Current playback duration in seconds (0.000).
    */
    public var duration = Stream<Duration> {
        pre, cur => pre == cur
    }
    /**
    * Current playback position in seconds (0.000).
    */
    public var position = Stream<Duration> {
        pre, cur => pre == cur
    }
    /**
    * Current volume (0-130).
    */
    public var volume = Stream<Float64> {
        pre, cur => pre == cur
    }
    /**
    * Current playback speed.
    */
    public var speed = Stream<Float64> {
        pre, cur => pre == cur
    }
    /**
    * Whether playback is paused because of waiting for the cache.
    */
    public var buffering = Stream<Bool> {
        pre, cur => pre == cur
    }
    /**
    * The percentage (0-100) of the cache fill status until the player will unpause. (related to buffering).
    */
    public var bufferingPercentage = Stream<Float64> {
        pre, cur => pre == cur
    }
    /**
    * Current buffer position in seconds.
    */
    public var buffer = Stream<Duration> {
        pre, cur => pre == cur
    }
    /**
    * Current playlist or file loop mode.
    */
    public var playlistMode = Stream<PlaylistMode>()
    /**
    * Currently selected video, audio and subtitle track.
    */
    public var track = Stream<Track> {
        pre, cur => pre == cur
    }
    /**
    * Available video, audio and subtitle tracks.
    */
    public var tracks = Stream<Tracks> {
        pre, cur => pre == cur
    }
    /**
    * Available chapters.
    */
    public var chapters = Stream<ArrayList<Chapter>> {
        pre, cur => pre == cur
    }
    /**
    * Video params.
    */
    public var videoParams = Stream<VideoParams>()
    /**
    * Video bitrate.
    */
    public var videoBitrate = Stream<Float64> {
        pre, cur => pre == cur
    }
    /**
    * Audio params.
    */
    public var audioParams = Stream<AudioParams>()
    /**
    * Audio bitrate.
    */
    public var audioBitrate = Stream<Float64> {
        pre, cur => pre == cur
    }
    /**
    * Stream of mpv log.
    */
    public var log = Stream<PlayerLog> {
        pre, cur => pre == cur
    }
    /**
    * Internal error stream.
    */
    public var error = Stream<String>()

    public func destroy() {
        ready.close()
        playlist.close()
        playing.close()
        eof.close()
        duration.close()
        position.close()
        volume.close()
        speed.close()
        buffering.close()
        bufferingPercentage.close()
        buffer.close()
        playlistMode.close()
        track.close()
        tracks.close()
        chapters.close()
        videoParams.close()
        videoBitrate.close()
        audioParams.close()
        audioBitrate.close()
        log.close()
        error.close()
    }
}
