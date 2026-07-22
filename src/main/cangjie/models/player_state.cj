/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models
import std.collection.ArrayList

public class PlayerState {
    /**
    * Currently opened files.
    */
    public var playlist = Playlist(ArrayList<Media>())
    /**
    * Whether player is playing.
    */
    public var playing = false
    /**
    * Whether end of file reached.
    */
    public var eof = false
    /**
    * Current playback duration in seconds (0.000).
    */
    public var duration = -1 * Duration.second
    /**
    * Current playback position in seconds (0.000).
    */
    public var position = -1 * Duration.second
    /**
    * Current volume (0-130).
    */
    public var volume = 100.0
    /**
    * Current playback speed.
    */
    public var speed = 1.0
    /**
    * Whether playback is paused because of waiting for the cache.
    */
    public var buffering = true
    /**
    * The percentage (0-100) of the cache fill status until the player will unpause. (related to buffering).
    */
    public var bufferingPercentage = 0.0
    /**
    * Current buffer position in seconds.
    */
    public var buffer = -1 * Duration.second
    /**
    * Current playlist or file loop mode.
    */
    public var playlistMode = PlaylistMode.None
    /**
    * Currently selected video, audio and subtitle track.
    */
    public var track = Track()
    /**
    * Available video, audio and subtitle tracks.
    */
    public var tracks = Tracks()
    /**
    * Available chapters.
    */
    public var chapters = ArrayList<Chapter>()
    /**
    * Video params.
    */
    public var videoParams = VideoParams()
    /**
    * Video bitrate.
    */
    public var videoBitrate = 0.0
    /**
    * Audio params.
    */
    public var audioParams = AudioParams()
    /**
    * Audio bitrate.
    */
    public var audioBitrate = 0.0
}