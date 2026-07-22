/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public class PlayerLog <: ToString & Equatable<PlayerLog> {
    /**
     * The module prefix, identifies the sender of the message.
     */
    public let prefix: String
    /**
     * The log level as string.
     */
    public let level: String
    /**
     * The log message.
     */
    public let text: String

    /**
     * Log message from mpv. You should NEVER create a PlayerLog yourself
     */
    public init(
        prefix: String,
        level: String,
        text: String,
    ) {
    	this.prefix = prefix
        this.level = level
        this.text = text
    }

    override public func toString(): String {
    	"[${prefix}:${level}] ${text}"
    }

    public operator func ==(other: PlayerLog): Bool {
        prefix == other.prefix &&
            level == other.level &&
            text == other.text
    }
}
