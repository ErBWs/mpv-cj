/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

import std.collection.ArrayList

public class Playlist <: Equatable<Playlist> {
    /**
     * Media list.
     */
    public var medias: ArrayList<Media>

    /**
     * Currently playing Media index.
     */
    public var index: Int64

    /**
     * Creates a media playlist for playback.
     *
     * @param medias    Medias.
     * @param index     Start playback from customized index, optional.
     */
    public init(medias: ArrayList<Media>, index!: Int64 = 0) {
        this.medias = medias
        this.index = index
    }

    public operator func ==(other: Playlist): Bool {
        medias == other.medias &&
            index == other.index
    }
}
