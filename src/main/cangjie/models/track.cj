/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models
import std.collection.ArrayList

sealed abstract class _Track <: Equatable<_Track> {
    /**
    * Track id, could be sid/aid/vid, auto, no or uri.
    */
    public var id = "auto"
    /**
    * The codec name used by this track, for example h264. Unavailable in some rare cases.
    */
    public var codec = ""
    /**
    * Track language as identified by the file. Not always available.
    */
    public var lang = ""
    /**
    * Track title as it is stored in the file. Not always available.
    */
    public var title = ""

    public operator func ==(other: _Track): Bool {
        id == other.id &&
            codec == other.codec &&
            lang == other.lang &&
            title == other.title
    }
}

public class VideoTrack <: _Track & Equatable<VideoTrack> {
    public init(
        id: String,
        codec!: String = "",
        lang!: String = "",
        title!: String = ""
    ) {
        super.id = id
        super.codec = codec
        super.lang = lang
        super.title = title
    }

    public static func no(): VideoTrack {
        VideoTrack("no")
    }

    public static func auto(): VideoTrack {
        VideoTrack("auto")
    }

    public operator func ==(other: VideoTrack): Bool {
        (this as _Track) == (other as _Track)
    }
}

public class AudioTrack <: _Track & Equatable<AudioTrack> {
    public let isUri: Bool

    public init(
        id: String,
        codec!: String = "",
        lang!: String = "",
        title!: String = "",
        isUri!: Bool = false
    ) {
        super.id = id
        super.codec = codec
        super.lang = lang
        super.title = title
        this.isUri = isUri
    }

    public static func no(): AudioTrack {
        AudioTrack("no")
    }

    public static func auto(): AudioTrack {
        AudioTrack("auto")
    }

    public static func uri(
        uri: String,
        codec!: String = "",
        lang!: String = "",
        title!: String = ""
    ): AudioTrack {
        AudioTrack(
            uri,
            codec: codec,
            lang: lang,
            title: title,
            isUri: true
        )
    }

    public operator func ==(other: AudioTrack): Bool {
        (this as _Track) == (other as _Track)
    }
}

public class SubtitleTrack <: _Track & Equatable<SubtitleTrack> {
    public let isUri: Bool

    public init(
        id: String,
        codec!: String = "",
        lang!: String = "",
        title!: String = "",
        isUri!: Bool = false
    ) {
        super.id = id
        super.codec = codec
        super.lang = lang
        super.title = title
        this.isUri = isUri
    }

    public static func no(): SubtitleTrack {
        SubtitleTrack("no")
    }

    public static func auto(): SubtitleTrack {
        SubtitleTrack("auto")
    }

    public static func uri(
        uri: String,
        codec!: String = "",
        lang!: String = "",
        title!: String = ""
    ): SubtitleTrack {
        SubtitleTrack(
            uri,
            codec: codec,
            lang: lang,
            title: title,
            isUri: true
        )
    }

    public operator func ==(other: SubtitleTrack): Bool {
        (this as _Track) == (other as _Track)
    }
}

public class Track <: Equatable<Track> {
    /**
    * Currently selected video track.
    */
    public var video = VideoTrack.auto()
    /**
    * Currently selected audio track.
    */
    public var audio = AudioTrack.auto()
    /**
    * Currently selected subtitle track.
    */
    public var subs = SubtitleTrack.auto()

    public operator func ==(other: Track): Bool {
        video == other.video &&
            audio == other.audio &&
            subs == other.subs
    }
}

public class Tracks <: Equatable<Tracks> {
    /**
    * Available video tracks.
    */
    public var video = ArrayList<VideoTrack>()
    /**
    * Available audio tracks.
    */
    public var audio = ArrayList<AudioTrack>()
    /**
    * Available subtitle tracks.
    */
    public var subs = ArrayList<SubtitleTrack>()

    public operator func ==(other: Tracks): Bool {
        video == other.video &&
            audio == other.audio &&
            subs == other.subs
    }
}
