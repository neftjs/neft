# Database

Access it with:
```javascript
var db = require('db');
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'

    assert = assert.scope 'Database'

    NOP = ->

    impl = require './implementation'
    watchersCount = Object.create null
    watchers = Object.create null

## db.get(*String* key, *Function* callback)
```

    exports.get = (key, callback) ->
        assert.isString key
        assert.notLengthOf key, 0
        assert.isFunction callback

        impl.get key, (err, data) ->
            if err? or not data
                return callback err, data

            callback null, data

        return

## db.set(*String* key, *Any* value, [*Function* callback])

    exports.set = (key, val, callback=NOP) ->
        assert.isString key
        assert.notLengthOf key, 0
        assert.isFunction callback

        watchers[key]?.disconnect()
        impl.set key, val, callback
        return

## db.remove(*String* key, [*Any* value, *Function* callback])

    exports.remove = (key, val, callback=NOP) ->
        if typeof val is 'function'
            callback = val
            val = null
        assert.isString key
        assert.notLengthOf key, 0
        assert.isFunction callback

        if val?
            exports.get key, (err, data) ->
                if err?
                    return callback err
                unless Array.isArray(data)
                    return callback new Error "'#{key}' is not an array"

                # remove from watcher
                if list = watchers[key]
                    if (index = list.items().indexOf(val)) isnt -1
                        list.pop index
                    else
                        for item, i in list.items()
                            if utils.isEqual(item, val)
                                list.pop i
                                break

                # remove from data
                if (index = data.indexOf(val)) isnt -1
                    data.splice index, 1
                else
                    for item, i in data
                        if utils.isEqual(item, val)
                            data.splice i, 1
                            break

                impl.set key, data, callback
        else
            watchers[key]?.disconnect()
            impl.remove key, callback
        return

## db.append(*String* key, *Any* value, [*Function* callback])

    exports.append = (key, val, callback=NOP) ->
        assert.isString key
        assert.notLengthOf key, 0
        assert.isFunction callback

        exports.get key, (err, data) ->
            if err?
                return callback err

            data ?= []
            unless Array.isArray(data)
                return callback new Error "'#{key}' is not an array"

            watchers[key]?.append val

            data.push val
            impl.set key, data, callback
        return

    createPassProperty = (object, name) ->
        utils.defineProperty object, name, null, ->
            Object.getPrototypeOf(@)[name]
        , (val) ->
            Object.getPrototypeOf(@)[name] = val
