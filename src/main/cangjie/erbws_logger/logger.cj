/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

macro package ohos_app_cangjie_mpvcj.erbws_logger

import std.ast.Tokens
import std.ast.ToTokens

private const DOMAIN: UInt32 = 0x0250;
private const TAG: String = "ERBWS_LOG";

public macro erbwsLogger(level: Tokens, msg: Tokens) {
    match (level.toString()) {
        case "d" | "debug" => return quote(Hilog.debug($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
        case "i" | "info" => return quote(Hilog.info($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
        case "w" | "warn" => return quote(Hilog.warn($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
        case "e" | "error" => return quote(Hilog.error($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
        case "f" | "fatal" => return quote(Hilog.fatal($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
        case _ => return quote(Hilog.info($(DOMAIN), $(TAG), "[" + @sourceFile() + "] " + $(msg)))
    }
}
