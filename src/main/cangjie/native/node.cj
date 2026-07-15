/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.native

import std.collection.*

public enum MpvNodeUnion {
    | MpvNull
    | MpvString(String)
    | MpvBoolean(Bool)
    | MpvInt64(Int64)
    | MpvFloat64(Float64)
    | MpvArray(Array<MpvNodeUnion>)
    | MpvMap(HashMap<String, MpvNodeUnion>)
    | MpvArrayBuffer(Array<UInt8>)

    public operator func [](key: String): MpvNodeUnion {
        if (let MpvMap(value) <- this) {
            value.get(key) ?? MpvNull
        }
        MpvNull
    }

    public operator func [](index: Int64): MpvNodeUnion {
        if (let MpvArray(value) <- this && index >= 0 && index < value.size) {
            value[index]
        }
        MpvNull
    }

    public func asString(): ?String {
        if (let MpvString(value) <- this) {
            value
        }
        None
    }

    public func asBool(): ?Bool {
        if (let MpvBoolean(value) <- this) {
            value
        }
        None
    }

    public func asInt64(): ?Int64 {
        if (let MpvInt64(value) <- this) {
            value
        }
        None
    }

    public func asFloat64(): ?Float64 {
        if (let MpvFloat64(value) <- this) {
            value
        }
        None
    }

    public func asArray(): ?Array<MpvNodeUnion> {
        if (let MpvArray(value) <- this) {
            value
        }
        None
    }

    public func asMap(): ?HashMap<String, MpvNodeUnion> {
        if (let MpvMap(value) <- this) {
            value
        }
        None
    }

    public func asByteArray(): ?Array<UInt8> {
        if (let MpvArrayBuffer(value) <- this) {
            value
        }
        None
    }
}

public unsafe func mpvNodeToMpvNodeUnion(node: mpv_node_mpv_node): MpvNodeUnion {
    match (node.format) {
        case fmt where fmt == mpv_format_MPV_FORMAT_STRING =>
            MpvString(node.u.string().toString())

        case fmt where fmt == mpv_format_MPV_FORMAT_FLAG =>
            MpvBoolean(node.u.flag() != 0)

        case fmt where fmt == mpv_format_MPV_FORMAT_INT64 =>
            MpvInt64(node.u.int64())

        case fmt where fmt == mpv_format_MPV_FORMAT_DOUBLE =>
            MpvFloat64(node.u.double_())

        case fmt where fmt == mpv_format_MPV_FORMAT_NODE_ARRAY =>
            let arr = ArrayList<MpvNodeUnion>()
            let list = node.u.list().read()

            if (list.num > 0) {
                var i = 0
                while (i < Int64(list.num)) {
                    arr.add(mpvNodeToMpvNodeUnion((list.values + i).read()))
                    i++
                }
            }
            MpvArray(arr.toArray())

        case fmt where fmt == mpv_format_MPV_FORMAT_NODE_MAP =>
            let obj = HashMap<String, MpvNodeUnion>()
            let list = node.u.list().read()

            if (list.num > 0) {
                var i = 0
                while (i < Int64(list.num)) {
                    obj[(list.keys + i).read().toString()] = mpvNodeToMpvNodeUnion((list.values + i).read())
                    i++
                }
            }
            MpvMap(obj)

        case fmt where fmt == mpv_format_MPV_FORMAT_BYTE_ARRAY =>
            let ba = node.u.ba().read()
            let ptr = CPointer<UInt8>(ba.data)
            MpvArrayBuffer(Array<UInt8>(Int64(ba.size), { i => (ptr + i).read() }))

        case _ =>
            MpvNull
    }
}
