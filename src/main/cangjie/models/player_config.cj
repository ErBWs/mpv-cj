/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public class PlayerConfig {
    public let configDir: String
    public let vo: String
    public let osc: Bool
    public let osd: Bool
    public let gpuContext: String
    public let alang: String
    public let slang: String
    public let hwdec: Bool
    public let deinterlace: Bool
    public let logLevel: MpvLogLevel

    public PlayerConfig(
        configDir!: String = "",
        vo!: String = "gpu-next",
        osc!: Bool = false,
        osd!: Bool = true,
        gpuContext!: String = "ohos",
        alang!: String = "chi",
        slang!: String = "chi",
        hwdec!: Bool = true,
        deinterlace!: Bool = false,
        logLevel!: MpvLogLevel = MpvLogLevel.None,
    ) {
        this.configDir = configDir
        this.vo = vo
        this.osc = osc
        this.osd = osd
        this.gpuContext = gpuContext
        this.alang = alang
        this.slang = slang
        this.hwdec = hwdec
        this.deinterlace = deinterlace
        this.logLevel = logLevel
    }
}

public enum MpvLogLevel {
    | None
    | Fatal
    | Error
    | Warn
    | Info
    | V
    | Debug
    | Trace
}
