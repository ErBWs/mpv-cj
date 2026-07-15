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
            return value.get(key) ?? MpvNull
        }
        MpvNull
    }

    public operator func [](index: Int64): MpvNodeUnion {
        if (let MpvArray(value) <- this && index >= 0 && index < value.size) {
            return value[index]
        }
        MpvNull
    }

    public func asString(): ?String {
        if (let MpvString(value) <- this) {
            return value
        }
        None
    }

    public func asBool(): ?Bool {
        if (let MpvBoolean(value) <- this) {
            return value
        }
        None
    }

    public func asInt64(): ?Int64 {
        if (let MpvInt64(value) <- this) {
            return value
        }
        None
    }

    public func asFloat64(): ?Float64 {
        if (let MpvFloat64(value) <- this) {
            return value
        }
        None
    }

    public func asArray(): ?Array<MpvNodeUnion> {
        if (let MpvArray(value) <- this) {
            return value
        }
        None
    }

    public func asMap(): ?HashMap<String, MpvNodeUnion> {
        if (let MpvMap(value) <- this) {
            return value
        }
        None
    }

    public func asByteArray(): ?Array<UInt8> {
        if (let MpvArrayBuffer(value) <- this) {
            return value
        }
        None
    }
}

public unsafe func mpvNodeToMpvNodeUnion(node: mpv_node): MpvNodeUnion {
    match (node.format) {
        case fmt where fmt == MPV_FORMAT_STRING =>
            MpvString(node.u.string().toString())

        case fmt where fmt == MPV_FORMAT_FLAG =>
            MpvBoolean(node.u.flag() != 0)

        case fmt where fmt == MPV_FORMAT_INT64 =>
            MpvInt64(node.u.int64())

        case fmt where fmt == MPV_FORMAT_DOUBLE =>
            MpvFloat64(node.u.double_())

        case fmt where fmt == MPV_FORMAT_NODE_ARRAY =>
            let arr = ArrayList<MpvNodeUnion>()
            let list = node.u.list().read()

            if (list.num > 0) {
                for (i in 0..Int64(list.num)) {
                    arr.add(mpvNodeToMpvNodeUnion((list.values + i).read()))
                }
            }
            MpvArray(arr.toArray())

        case fmt where fmt == MPV_FORMAT_NODE_MAP =>
            let obj = HashMap<String, MpvNodeUnion>()
            let list = node.u.list().read()

            if (list.num > 0) {
                for (i in 0..Int64(list.num)) {
                    obj[(list.keys + i).read().toString()] = mpvNodeToMpvNodeUnion((list.values + i).read())
                }
            }
            MpvMap(obj)

        case fmt where fmt == MPV_FORMAT_BYTE_ARRAY =>
            let ba = node.u.ba().read()
            let ptr = CPointer<UInt8>(ba.data)
            MpvArrayBuffer(Array<UInt8>(Int64(ba.size), { i => (ptr + i).read() }))

        case _ =>
            MpvNull
    }
}

public unsafe func mpvNodeUnionToMpvNode(node: MpvNodeUnion): mpv_node {
    var value = mpv_node_u()
    var format = MPV_FORMAT_NONE

    match (node) {
        case MpvNull => ()

        case MpvString(string) =>
            value.string(val: LibC.mallocCString(string))
            format = MPV_FORMAT_STRING

        case MpvBoolean(flag) =>
            value.flag(val: if (flag) { 1 } else { 0 })
            format = MPV_FORMAT_FLAG

        case MpvInt64(int64) =>
            value.int64(val: int64)
            format = MPV_FORMAT_INT64

        case MpvFloat64(double) =>
            value.double_(val: double)
            format = MPV_FORMAT_DOUBLE

        case MpvArray(array) =>
            let values = if (array.isEmpty()) {
                CPointer<mpv_node>()
            } else {
                LibC.malloc<mpv_node>(count: array.size)
            }
            for (i in 0..array.size) {
                values.write(i, mpvNodeUnionToMpvNode(array[i]))
            }

            let list = LibC.malloc<mpv_node_list>()
            list.write(mpv_node_list(
                Int32(array.size),
                values,
                CPointer<CString>()
            ))
            value.list(val: list)
            format = MPV_FORMAT_NODE_ARRAY

        case MpvMap(map) =>
            let values = if (map.isEmpty()) {
                CPointer<mpv_node>()
            } else {
                LibC.malloc<mpv_node>(count: map.size)
            }
            let keys = if (map.isEmpty()) {
                CPointer<CString>()
            } else {
                LibC.malloc<CString>(count: map.size)
            }

            var i: Int64 = 0
            for ((key, child) in map) {
                keys.write(i, LibC.mallocCString(key))
                values.write(i, mpvNodeUnionToMpvNode(child))
                i++
            }

            let list = LibC.malloc<mpv_node_list>()
            list.write(mpv_node_list(Int32(map.size), values, keys))
            value.list(val: list)
            format = MPV_FORMAT_NODE_MAP

        case MpvArrayBuffer(array) =>
            let data = if (array.isEmpty()) {
                CPointer<UInt8>()
            } else {
                LibC.malloc<UInt8>(count: array.size)
            }
            for (i in 0..array.size) {
                data.write(i, array[i])
            }

            let byteArray = LibC.malloc<mpv_byte_array>()
            byteArray.write(mpv_byte_array(CPointer<Unit>(data), UIntNative(array.size)))
            value.ba(val: byteArray)
            format = MPV_FORMAT_BYTE_ARRAY
    }

    mpv_node(value, format)
}

public unsafe func freeMpvNode(node: mpv_node): Unit {
    match (node.format) {
        case fmt where fmt == MPV_FORMAT_STRING =>
            LibC.free(node.u.string())

        case fmt where fmt == MPV_FORMAT_NODE_ARRAY || fmt == MPV_FORMAT_NODE_MAP =>
            let listPointer = node.u.list()
            if (listPointer.isNotNull()) {
                let list = listPointer.read()
                for (i in 0..Int64(list.num)) {
                    freeMpvNode((list.values + i).read())
                    if (fmt == MPV_FORMAT_NODE_MAP) {
                        LibC.free((list.keys + i).read())
                    }
                }
                if (list.values.isNotNull()) {
                    LibC.free(list.values)
                }
                if (list.keys.isNotNull()) {
                    LibC.free(list.keys)
                }
                LibC.free(listPointer)
            }

        case fmt where fmt == MPV_FORMAT_BYTE_ARRAY =>
            let byteArrayPointer = node.u.ba()
            if (byteArrayPointer.isNotNull()) {
                let byteArray = byteArrayPointer.read()
                if (byteArray.data.isNotNull()) {
                    LibC.free(byteArray.data)
                }
                LibC.free(byteArrayPointer)
            }

        case _ => ()
    }
}
