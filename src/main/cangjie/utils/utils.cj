/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.utils

import std.collection.*

protected class Utils {
    protected static func sanitizeUri(uri: String): String {
        if (!uri.startsWith("file://")) {
            return uri
        }

        let fileUri = decode(uri.removePrefix("file://"))

        if (fileUri.startsWith("docs/storage/Users/currentUser/")) {
            return fileUri.removePrefix("docs")
        }

        if (fileUri.startsWith("media/")) {
            return fileUri.replace("media/", "/data/storage/el2/media/")
        }

        if (let Some(separator) <- fileUri.indexOf("/")) {
            if (separator > 0) {
                let bundleName = fileUri[0..separator]
                let sandboxPath = fileUri[separator..fileUri.size]
                    .removePrefix("/data/storage/el2/base/")
                let appDataPrefix =
                    "/storage/Users/currentUser/appdata/el2/base/${bundleName}"
                return "${appDataPrefix}/${sandboxPath}"
            }
        }

        uri
    }

    private static func hexToDec(b: UInt8): UInt8 {
        match {
            case b'0' <= b && b <= b'9' => b - b'0'
            case b'a' <= b && b <= b'f' => b - b'a' + 10
            case b'A' <= b && b <= b'F' => b - b'A' + 10
            case _ => UInt8(0)
        }
    }

    private static func decode(str: String): String {
        let decoded = ArrayList<UInt8>()
        var i: Int64 = 0

        while (i < str.size) {
            if (str[i] == b'%') {
                if (i + 2 >= str.size) {
                    return str
                }

                let high = hexToDec(str[i + 1])
                let low = hexToDec(str[i + 2])
                decoded.add(high << 4 | low)
                i += 3
                continue
            }

            decoded.add(str[i])
            i++
        }

        String.fromUtf8(decoded.toArray())
    }
}

