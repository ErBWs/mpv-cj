/**
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

package ohos_app_cangjie_mpvcj.utils

import std.sync.Mutex
import std.collection.ArrayList
import ohos.concurrency.launch

public class Stream<T> {
    private let mtx = Mutex()
    private let listeners = ArrayList<(T) -> Unit>()
    private let equal: ?((T, T) -> Bool)
    private var lastValue = Option<T>.None
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
        var snapshot = ArrayList<(T) -> Unit>()
        synchronized(mtx) {
            if (_isClosed) {
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
            snapshot = ArrayList<(T) -> Unit>(listeners.size, { i => listeners[i] })
        }
        for (callback in snapshot) {
            launch { callback(value) }
        }
    }
}
