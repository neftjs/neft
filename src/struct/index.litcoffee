# Struct

Access it with:
```javascript
const { Struct } = Neft;
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'

    {createSignalOnObject, emitSignal} = signal.Emitter

    privatePropOpts = utils.CONFIGURABLE | utils.WRITABLE
    propOpts = utils.CONFIGURABLE | utils.ENUMERABLE

    createProperty = (struct, key, value) ->
        privateKey = "_#{key}"
        signalName = "on#{utils.capitalize(key)}Change"
        utils.defineProperty struct, privateKey, privatePropOpts, value
        createSignalOnObject struct, signalName
        getter = -> @[privateKey]
        setter = (value) ->
            oldVal = @[privateKey]
            return if value is oldVal
            @[privateKey] = value
            emitSignal @, signalName, oldVal
            value
        utils.defineProperty struct, key, propOpts, getter, setter
        return

    module.exports = class Struct extends signal.Emitter
        @__name__ = 'Struct'
        @__path__ = 'Struct'

## Struct::constructor(*Object* object)

Creates a new struct instance with the given properties.

Once created struct keys cannot be added or removed.

Each key is created with his onChange signal.

```javascript
var struct = new Struct({ name: 'Max' });
struct.name; // 'Max'
struct.onNameChange.connect((oldValue) => {
    console.log(`Name changed from ${oldValue} to ${struct.name}`)
})
struct.name = 'Bob'
// prints 'Name changed from Max to Bob'
```

        constructor: (obj) ->
            assert.instanceOf @, Struct, "Constructor Struct requires 'new'"
            assert.isPlainObject obj, 'Struct requires object to be given'

            super()

            for key, val of obj
                createProperty @, key, val

            Object.seal @
