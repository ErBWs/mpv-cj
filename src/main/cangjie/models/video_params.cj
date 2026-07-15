/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public class VideoParams {
    /**
    * The pixel format as string. This uses the same names as used in other places of mpv.
    */
    public var pixelFormat = "";
    /**
    * The underlying pixel format as string. This is relevant for some cases of hardware decoding and unavailable otherwise.
    */
    public var hwPixelFormat = "";
    /**
    * Video size as integers, with no aspect correction applied.
    */
    public var w = 0;
    /**
    * Video size as integers, with no aspect correction applied.
    */
    public var h = 0;
    /**
    * Video size as integers, scaled for correct aspect ratio.
    */
    public var dw = 0;
    /**
    * Video size as integers, scaled for correct aspect ratio.
    */
    public var dh = 0;
    /**
    * Display aspect ratio as double.
    */
    public var aspect = 0.0;
    /**
    * Pixel aspect ratio.
    */
    public var par = 0.0;
    /**
    * Storage aspect ratio.
    */
    public var sar = 0.0;
    /**
    * The colormatrix in use as string. (Exact values subject to change.)
    */
    public var colormatrix = "";
    /**
    * The color levels as string. (Exact values subject to change.)
    */
    public var colorLevels = "";
    /**
    * The primaries in use as string. (Exact values subject to change.)
    */
    public var primaries = "";
    /**
    * The gamma function in use as string. (Exact values subject to change.)
    */
    public var gamma = "";
    /**
    * The light type in use as a string. (Exact values subject to change.)
    */
    public var light = "";
    /**
    * Chroma location as string. (Exact values subject to change.)
    */
    public var chromaLocation = "";
    /**
    * Intended display rotation in degrees (clockwise).
    */
    public var rotate = 0;
    /**
    * Source file stereo 3D mode.
    */
    public var stereoIn = "";
    /**
    * Average bits-per-pixel as integer. Subsampled planar formats use a different resolution, which is the reason this value can sometimes be odd or confusing. Can be unavailable with some formats.
    */
    public var averageBpp = 0;
    /**
    * Alpha type. If the format has no alpha channel, this will be unavailable (but in future releases, it could change to no). If alpha is present, this is set to straight or premul.
    */
    public var alpha = "";
}
