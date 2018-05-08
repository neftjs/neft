# List

Access it with:
```javascript
const { List } = Neft;
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'

    module.exports = class List extends signal.Emitter
        @__name__ = 'List'
        @__path__ = 'List'

## List::constructor([*Array* data])

Creates a new list instance.

```javascript
var list = new List([1, 2]);
list instanceof List; // true
```

        constructor: (arr) ->
            unless @ instanceof List
                return new List arr

            if arr?
                assert.isObject arr, """
                    List can be called with no argument or an object, but #{arr} given
                """
            assert.operator arguments.length, '<=', 1, """
                List must be called with zero or one argument
            """

            super()
            @length = 0

            if utils.isObject(arr)
                for val, i in arr
                    @[i] = val
                    @length++

        # merge Array prototype into the List prototype
        for key in Object.getOwnPropertyNames(Array::)
            if key isnt 'constructor'
                @::[key] = Array::[key]

## *Signal* List::onChange(*Any* oldValue, *Integer* index)

Signal called on each value change.

        signal.Emitter.createSignal @, 'onChange'

## *Signal* List::onInsert(*Any* value, *Integer* index)

Signal called when a value was added.

        signal.Emitter.createSignal @, 'onInsert'

## *Signal* List::onPop(*Any* oldValue, *Integer* index)

Signal called when a value was removed.

        signal.Emitter.createSignal @, 'onPop'

## ReadOnly *Integer* List::length

Amount of values stored in the list.

```javascript
var list = new List(['a', 'b']);
list.length; // 2
```

## *Any* List::set(*Integer* index, *Any* value)

Sets the given value under the given index.

The index must exists in the list.

The value can't be an `undefined`. Use `pop()` instead.

Calls `onChange()` signal.

```javascript
var types = new List(['fantasy', 'Thriller']);

types.onChange.connect(function(oldVal, i){
  console.log("element "+oldVal+" changed to "+this[i]);
});

types.set(0, 'Fantasy');
// element fantasy changed to Fantasy

types.set(0, 'Fantasy');
// nothing changed ...
```

        set: (i, val) ->
            assert.operator i, '>=', 0, """
                List.set index cannot be lower than zero, but #{i} given
            """
            assert.operator i, '<', @length, """
                List.set index must be lower than list length, #{i} given
            """
            assert.isNot val, undefined, """
                List.set cannot be called with undefined value; \
                undefined is reserved value for not existing keys; \
                use null instead
            """

            oldVal = @[i]
            if oldVal is val
                return val

            @[i] = val

            # signal
            @onChange.emit oldVal, i

            val

## *Any* List::append(*Any* value)

Adds the given value on the end on the list.

The value can't be an `undefined`.

Calls `onInsert()` signal.

```javascript
var fridge = new List(['apple', 'milk']);

fridge.onInsert.connect(function(val, i){
  console.log(val+" appended!");
});

fridge.append('cheese');
// cheese appended!

console.log(fridge.items());
// apple, milk, cheese
```

        append: (val) ->
            assert.isNot val, undefined, """
                List.append cannot be called with undefined value; \
                undefined is reserved value for not existing keys; \
                use null instead
            """

            @push val

            # signal
            @onInsert.emit val, @length - 1

            val

## *Any* List::insert(*Integer* index, *Any* value)

Add the given value under the given index.

The index can't be greater than the list length.

The value can't be an `undefined`.

Calls `onInsert()` signal.

```javascript
var list = new List(['a', 'b']);

list.onInsert.connect(function(val, i){
  console.log("new element "+val+" inserted at index "+i);
});

list.insert(1, 'c');
// new element c inserted at index 1

console.log(list.items());
// ['a', 'c', 'b']
```

        insert: (i, val) ->
            assert.operator i, '>=', 0, """
                List.insert index cannot be lower than zero, but #{i} given
            """
            assert.operator i, '<=', @length, """
                List.insert index must be lower or equal list length, #{i} given
            """
            assert.isNot val, undefined, """
                List.insert cannot be called with undefined value; \
                undefined is reserved value for not existing keys; \
                use null instead
            """

            @splice i, 0, val

            # signal
            @onInsert.emit val, i

            val

## *List* List::extend(*Object* items)

Appends all values stored in the given items into the list.

Calls `onInsert()` signal for each value.

        extend: (items) ->
            assert.isObject items, """
                List.extend needs to be called with an object, but #{items} given
            """

            for val in items
                @append val

            @

## *Any* List::remove(*Any* value)

Removes the given value from the list.

Calls `onPop()` signal.

```javascript
var list = new List(['a', 'b']);
list[1]; // b

list.remove('b');
list[1]; // undefined

list; // ['a']
```

        remove: (val) ->
            assert.ok utils.has(@, val), """
                List.remove cannot be called on not existing key, #{val} given
            """

            i = @index val
            if i isnt -1
                @pop i

            val

## *Any* List::pop([*Integer* index])

Removes the value stored in the list under the given index.

The index must exists in the list.

Calls `onPop()` signal.

```javascript
var list = new List(['a', 'b']);
list[1]; // b

list.pop(1);
list[1]; // undefined

list; // ['a']
```

        pop: (i) ->
            if i is undefined
                i = @length - 1
            assert.operator i, '>=', 0, "List.pop index cannot be lower than zero, but #{i} given"
            assert.operator i, '<', @length, """
                List.pop index must be lower than list length, #{i} given
            """

            oldVal = @[i]
            @splice i, 1

            # signal
            @onPop.emit oldVal, i

            oldVal

## List::clear()

Removes all values stored in the list.

Calls `onPop()` signal for each value.

```javascript
var list = new List(['a', 'b']);

list.onPop.connect(function(oldVal, i){
  console.log("Element "+oldVal+" popped!");
});

console.log(list.items());
// ['a', 'b']

list.clear()
// Element b popped!
// Element a popped!

console.log(list);
// []
```

        clear: ->
            while @length > 0
                @pop()

            return

## *Integer* List::index(*Any* value)

Returns the given value index in the list.

Returns `-1` if the value doesn't exist in the list.

```javascript
var list = new List(['a', 'b']);
list.index('b'); // 1
list.index('c'); // -1
```

        index: (val) ->
            assert.isNot val, undefined, """
                List.index cannot be called with undefined value; \
                undefined is reserved value for not existing keys; \
                use null instead
            """

            @indexOf val

## *Boolean* List::has(*Any* value)

Returns `true` if the given value exists in the list.

```javascript
var list = new List(['a', 'b']);
list.has('a'); // true
list.has('ab123'); // false
```

        has: (val) ->
            @index(val) isnt -1

## *Array* List::toArray()

        toArray: ->
            arr = new Array @length
            for val, i in @
                arr[i] = val
            arr