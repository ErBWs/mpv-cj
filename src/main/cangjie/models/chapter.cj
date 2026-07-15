/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.models

public class Chapter <: Equatable<Chapter> {
    /**
    * Chapter title as stored in the file. Not always available.
    */
    public var title = ""
    /**
    * Chapter start time in seconds as float.
    */
    public var time = 0 * Duration.second

    public operator func ==(other: Chapter): Bool {
        title == other.title &&
            time == other.time
    }
}
