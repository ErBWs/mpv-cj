/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.utils

import std.sync.Mutex
import std.collection.ArrayList
import ohos.concurrency.launch

private class StreamEvent<T> {
    let value: T
    let listeners: ArrayList<(T) -> Unit>

    init(value: T, listeners: ArrayList<(T) -> Unit>) {
        this.value = value
        this.listeners = listeners
    }
}

public class Stream<T> {
    private let mtx = Mutex()
    private let listeners = ArrayList<(T) -> Unit>()
    private let pendings = ArrayList<StreamEvent<T>>()
    private let equal: ?((T, T) -> Bool)
    private var lastValue = Option<T>.None
    private var nextEvent: Int64 = 0
    private var isScheduled = false
    private var _isClosed = false

    public init() {
        equal = None
    }

    public init(equal: (T, T) -> Bool) {
        this.equal = equal
    }

    public prop isClosed: Bool {
        get() {
            synchronized(mtx) {
                _isClosed
            }
        }
    }

    public func close() {
        synchronized(mtx) {
            _isClosed = true
            listeners.clear()
            pendings.clear()
            nextEvent = 0
        }
    }

    public func listen(callback: (T) -> Unit) {
        synchronized(mtx) {
            if (!_isClosed) {
                listeners.add(callback)
            }
        }
    }

    public func add(value: T) {
        var broadcast = false
        synchronized(mtx) {
            if (_isClosed || listeners.size == 0) {
                return
            }
            if (let Some(eq) <- equal) {
                if (let Some(last) <- lastValue) {
                    if (eq(last, value)) {
                        return
                    }
                }
            }
            lastValue = value

            let snapshot = ArrayList<(T) -> Unit>(listeners.size, { i => listeners[i] })
            pendings.add(StreamEvent(value, snapshot))
            if (!isScheduled) {
                isScheduled = true
                broadcast = true
            }
        }

        if (broadcast) {
            launch { dispatch() }
        }
    }

    private func dispatch() {
        while (true) {
            var event = Option<StreamEvent<T>>.None
            synchronized(mtx) {
                if (_isClosed || nextEvent >= pendings.size) {
                    pendings.clear()
                    nextEvent = 0
                    isScheduled = false
                    return
                }
                event = pendings[nextEvent]
                nextEvent++
            }

            if (let Some(current) <- event) {
                for (callback in current.listeners) {
                    callback(current.value)
                }
            }
        }
    }
}
