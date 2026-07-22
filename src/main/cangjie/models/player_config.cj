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
    public let onReady: () -> Unit

    /**
     * Player configurations.
     *
     * @param configDir     Directory of mpv configuration files, optional.
     * @param vo            Video output backend, optional.
     * @param osc           Whether to load the on-screen-controller, optional.
     * @param osd           Whether to load the on-screen-display, optional.
     * @param gpuContext    Graphics APIs, can be "ohos" (OpenGL) or "ohosvk" (Vulkan), optional.
     * @param alang         A prioritized list of audio languages to use, as IETF language tags, optional.
     * @param slang         A prioritized list of subtitle languages to use, as IETF language tags, optional.
     * @param hwdec         Whether to enable hardware acceleration, optional.
     * @param deinterlace   Whether to enable deinterlace, optional.
     * @param logLevel      Log level of mpv, optional.
     * @param onReady       Callback invoked when mpv player is initialized and ready for playback, optional.
     */
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
        onReady!: () -> Unit = { => }
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
        this.onReady = onReady
    }
}

public enum MpvLogLevel {
    /**
     * Disable absolutely all messages.
     */
    | None
    /**
     * Critical/aborting errors.
     */
    | Fatal
    /**
     * Simple errors.
     */
    | Error
    /**
     * Possible problems.
     */
    | Warn
    /**
     * Informational message.
     */
    | Info
    /**
     * Noisy informational message.
     */
    | V
    /**
     * Very noisy technical information.
     */
    | Debug
    /**
     * Extremely noisy.
     */
    | Trace
}
