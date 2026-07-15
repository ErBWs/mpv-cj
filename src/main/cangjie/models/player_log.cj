/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public class PlayerLog <: ToString & Equatable<PlayerLog> {
    public let prefix: String
    public let level: String
    public let text: String

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
