/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj

import kit.UIKit.*
import ohos.state_macro_manage.*
import ohos.state_manage.*

@Component
public class PlayerSurface {
    @Prop
    var player: Player

    @State
    var radius: Length = 0

    func build() {
        XComponent(
            id: "player",
            `type`: XComponentType.SURFACE,
            controller: player
        )
        .width(100.percent)
        .height(100.percent)
        .borderRadius(radius)
    }
}