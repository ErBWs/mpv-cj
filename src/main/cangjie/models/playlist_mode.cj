/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public enum PlaylistMode {
    /**
     * End playback when end of playlist is reached.
     */
    | None
    /**
     * Loop over currently playing file.
     */
    | File
    /**
     * Loop over the playlist.
     */
    | Playlist
    /**
     * Play files in random order.
     */
    | Random
}
