# Typed Array

    'use strict'

    polyfill = (n) ->
        arr = new Array n
        for i in [0...n] by 1
            arr[i] = 0
        arr

# **Class** Int8([*Integer* length = `0`])

    exports.Int8 = do ->
        if typeof Int8Array isnt 'undefined'
            Int8Array
        else
            polyfill

# **Class** Uint8([*Integer* length = `0`])

    exports.Uint8 = do ->
        if typeof Uint8Array isnt 'undefined'
            Uint8Array
        else
            polyfill

# **Class** Int16([*Integer* length = `0`])

    exports.Int16 = do ->
        if typeof Int16Array isnt 'undefined'
            Int16Array
        else
            polyfill

# **Class** Uint16([*Integer* length = `0`])

    exports.Uint16 = do ->
        if typeof Uint16Array isnt 'undefined'
            Uint16Array
        else
            polyfill

# **Class** Int32([*Integer* length = `0`])

    exports.Int32 = do ->
        if typeof Int32Array isnt 'undefined'
            Int32Array
        else
            polyfill

# **Class** Uint32([*Integer* length = `0`])

    exports.Uint32 = do ->
        if typeof Uint32Array isnt 'undefined'
            Uint32Array
        else
            polyfill

# **Class** Float32([*Integer* length = `0`])

    exports.Float32 = do ->
        if typeof Float32Array isnt 'undefined'
            Float32Array
        else
            polyfill

# **Class** Float64([*Integer* length = `0`])

    exports.Float64 = do ->
        if typeof Float64Array isnt 'undefined'
            Float64Array
        else
            polyfill
