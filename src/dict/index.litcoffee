# Dict

Access it with:
```javascript
const { Dict } = Neft
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'

    module.exports = class Dict extends signal.Emitter
        @__name__ = 'Dict'
        @__path__ = 'Dict'

        KEYS = 1<<0
        VALUES = 1<<1
        ITEMS = 1<<2
        ALL = (ITEMS<<1) - 1

## *Dict* Dict.fromJSON(*String*|*Object* json)

Returns a new *Dict* based on the given *json*.

Example:

```javascript
const dict = Dict.fromJSON('{"param": "value"}');
dict.param; // value
```

        @fromJSON = (json) ->
            json = utils.tryFunction JSON.parse, JSON, [json], json
            assert.isPlainObject json

            new Dict json

        NOT_ENUMERABLE = utils.CONFIGURABLE | utils.WRITABLE
        utils.defineProperty @::, 'constructor', NOT_ENUMERABLE, Dict

## Dict::constructor([*Object* data])

Creates a new dict instance.

The given *data* parameter determines default keys with their values.

Example:

```javascript
var data = new Dict({
  name: 'xyz'
});
data.name; // xyz
```

        constructor: (obj) ->
            # support no `new` syntax
            unless @ instanceof Dict
                return new Dict obj

            if obj?
                assert.isObject obj

            super()

            utils.defineProperty @, '_signals', utils.WRITABLE, @_signals
            utils.defineProperty @, '_keys', utils.WRITABLE, null
            utils.defineProperty @, '_values', utils.WRITABLE, null
            utils.defineProperty @, '_items', utils.WRITABLE, null
            utils.defineProperty @, '_dirty', utils.WRITABLE, ALL

            if utils.isObject(obj)
                utils.merge @, obj

## ReadOnly *Integer* Dict::length

Returns an amount of keys stored in this *Dict*.

This property cannot be changed manually.

Example:

```javascript
var dict = Dict({ prop: 1 });
dict.length; // 1
```

        desc = NOT_ENUMERABLE
        utils.defineProperty @::, 'length', desc, ->
            @keys().length
        , null

## *Signal* Dict::onChange(*String* key, *Any* oldValue)

Signal called on each key value change.

Example:

```javascript
var user = new Dict({
  country: 'Germany'
});

user.onChange.connect(function(key, oldVal){
  console.log(key + " property changed from " + oldVal + " to " + this[key]);
});

user.set('country', 'US');
// country property changed from Germany to US
```

        signal.Emitter.createSignal @, 'onChange'

## *Any* Dict::set(*String* key, *Any* value)

Sets the given value under the given key in this *Dict*.

The given value can't be an undefined. Use `pop()` instead.

Calls `onChange()` signal.

Example:

```javascript
var links = new Dict({
  facebook: 'https://facebook.com/neft.io',
  twitter: 'https://twitter.com/neft_io'
});

links.onChange.connect(function(key, oldVal){
  console.log(key + " changed from " + oldVal + " to " + this[key]);
});

links.set('googlePlus', 'https://plus.google.com/+NeftIo-for-apps/');
// googlePlus changed from undefined to https://...
```

        utils.defineProperty @::, 'set', NOT_ENUMERABLE, (key, val) ->
            assert.isString key
            assert.notLengthOf key, 0
            assert.isNot val, undefined

            oldVal = @[key]

            # break if value didn't change
            if oldVal is val
                return val

            # update value
            @[key] = val

            # dirty
            @_dirty |= ALL

            # signal
            @onChange.emit key, oldVal

            val

## *Boolean* Dict::has(*String* key)

Returns `true` if the given key exists in this *Dict*.

        utils.defineProperty @::, 'has', NOT_ENUMERABLE, (key) ->
            assert.isString key
            assert.notLengthOf key, 0

            @[key] isnt undefined

## *Dict* Dict::extend(*Object*|*Dict* object)

Sets all keys with their values from the given object into this *Dict*.

Calls `onChange()` signal for each given key.

        utils.defineProperty @::, 'extend', NOT_ENUMERABLE, (obj) ->
            assert.isObject obj

            for key, val of obj
                if obj.hasOwnProperty(key)
                    @set key, val

            @

## *Any* Dict::pop(*String* key)

Removes the given key from this *Dict*.

The given key must exists.

Calls `onChange()` signal.

Example:

```javascript
var data = new Dict;

data.set('name', 'John');

data.onChange.connect(function(key, oldVal){
  if (this[key] === undefined){
    console.log(key + " property has been removed");
  }
});

data.pop('name');
// name property has been removed
```

        utils.defineProperty @::, 'pop', NOT_ENUMERABLE, (key) ->
            assert.isString key
            assert.notLengthOf key, 0
            assert.isNot @[key], undefined

            oldVal = @[key]
            delete @[key]

            # dirty
            @_dirty |= ALL

            # signal
            @onChange.emit key, oldVal

            oldVal

## Dict::clear()

Removes all stored keys from this *Dict*.

Calls `onChange()` signal for each stored key.

        utils.defineProperty @::, 'clear', NOT_ENUMERABLE, ->
            for key, val of this
                @pop key

            return

## ReadOnly *Array* Dict::keys()

Returns an array of keys stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.keys(); // ['x', 'y']
```

        utils.defineProperty @::, 'keys', NOT_ENUMERABLE, ->
            if @_dirty & KEYS
                @_dirty ^= KEYS
                arr = @_keys ?= []

                i = 0
                for key, val of @
                    arr[i] = key
                    i++

                arr.length = i

            @_keys

## *Array* Dict::values()

Returns an array of values stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.values(); // [10, 30]
```

        utils.defineProperty @::, 'values', NOT_ENUMERABLE, ->
            if @_dirty & VALUES
                @_dirty ^= VALUES
                arr = @_values ?= []

                i = 0
                for key, val of @
                    arr[i] = val
                    i++

                arr.length = i

            @_values

## *Array* Dict::items()

Returns an array of key-value pairs stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.items(); // [['x', 10], ['y', 30]]
```

        utils.defineProperty @::, 'items', NOT_ENUMERABLE, ->
            if @_dirty & ITEMS
                arr = @_values ?= []

                i = 0
                for key, val of @
                    arr[i] ?= ['', null]
                    arr[i][0] = key
                    arr[i][1] = val
                    i++

                arr.length = i

            @_values
