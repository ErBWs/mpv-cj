/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

import std.collection.HashMap

public class Media <: Equatable<Media> {
    /**
     * Media uri.
     */
    public var uri: String
    /**
     * HTTP headers.
     */
    public var httpHeaders: ?HashMap<String, String>
    /**
     * Media start position.
     */
    public var start: ?Duration
    /**
     * Media end position.
     */
    public var end: ?Duration

    /**
     * Creates a media for playback.
     *
     * @param uri           Media uri.
     * @param httpHeaders   HTTP headers, optional.
     * @param start         Media start position, optional.
     * @param end           Media end position, optional.
     */
    public init(
        uri: String,
        httpHeaders!: ?HashMap<String, String> = None,
        start!: ?Duration = None,
        end!: ?Duration = None
    ) {
        this.uri = uri
        this.httpHeaders = httpHeaders
        this.start = start
        this.end = end
    }

    public operator func ==(other: Media): Bool {
        uri == other.uri
    }
}
