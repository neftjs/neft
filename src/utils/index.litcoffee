# Utils

Access it with:
```javascript
const { utils } = Neft;
```

    'use strict'

    {toString} = Object::
    funcToString = Function::toString
    {isArray} = Array
    {shift, pop} = Array::
    createObject = Object.create
    {getPrototypeOf, getOwnPropertyNames} = Object
    objKeys = Object.keys
    hasOwnProp = Object.hasOwnProperty
    getObjOwnPropDesc = Object.getOwnPropertyDescriptor
    defObjProp = Object.defineProperty
    {random} = Math

    ###
    Link subfiles
    ###
    require('./namespace') exports
    require('./stringifying') exports
    require('./async') exports

## ReadOnly *Boolean* utils.isNode

`true` if the application is running in the node.js environment.

## ReadOnly *Boolean* utils.isServer

`utils.isNode` link.

## ReadOnly *Boolean* utils.isClient

`utils.isNode` inverse.

## ReadOnly *Boolean* utils.isBrowser

## ReadOnly *Boolean* utils.isQt

## ReadOnly *Boolean* utils.isAndroid

## ReadOnly *Boolean* utils.isIOS

    exports.isNode = exports.isServer = exports.isClient =
    exports.isBrowser = exports.isQt = exports.isAndroid =
    exports.isIOS = false

    switch true

        when Qt?.include?
            exports.isClient = exports.isQt = true

        when android?
            exports.isClient = exports.isAndroid = true

        when ios?
            exports.isClient = exports.isIOS = true

        when window?.document?
            exports.isClient = exports.isBrowser = true

        when process? and Object.prototype.toString.call(process) is '[object process]'
            exports.isNode = exports.isServer = true

## *Function* utils.NOP

No operation (an empty function).

    exports.NOP = ->

## *Boolean* utils.is(*Any* value1, *Any* value2)

Returns `true` if the given values are exactly the same.

It's the *Object.is()* function polyfill (introduced in ECMAScript 6).

In opposite to the `===` operator, this function treats two *NaN*s as equal, and
`-0` and `+0` as not equal.

```javascript
console.log(utils.is('a', 'a'));
// true

console.log(utils.is(NaN, NaN));
// true, but ...
console.log(NaN === NaN);
// false

console.log(utils.is(-0, 0));
// false, but ...
console.log(-0 === 0);
// true
```

    exports.is = Object.is or (val1, val2) ->
        if val1 is 0 and val2 is 0
            return 1 / val1 is 1 / val2
        else if val1 isnt val1
            return val2 isnt val2
        else
            return val1 is val2

## *Boolean* utils.isFloat(*Any* value)

Returns `true` if the given value is a finite number.

```javascript
console.log(utils.isFloat(10));
// true

console.log(utils.isFloat(0.99));
// true

console.log(utils.isFloat(NaN));
// false

console.log(utils.isFloat(Infinity));
// false

console.log(utils.isFloat('10'));
// false
```

    exports.isFloat = (val) ->
        typeof val is 'number' and isFinite(val)

## *Boolean* utils.isInteger(*Any* value)

Returns `true` if the given value is an integer.

```javascript
console.log(utils.isInteger(10));
// true

console.log(utils.isInteger(-2));
// true

console.log(utils.isInteger(1.22));
// false

console.log(utils.isInteger('2'));
// false
```

    exports.isInteger = (val) ->
        typeof val is 'number' and
        isFinite(val) and
        val > -9007199254740992 and
        val < 9007199254740992 and
        Math.floor(val) is val

## *Boolean* utils.isPrimitive(*Any* value)

Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.

```javascript
console.log(utils.isPrimitive(null));
// true

console.log(utils.isPrimitive('abc'));
// true

console.log(utils.isPrimitive([]));
// false
```

    isPrimitive = exports.isPrimitive = (val) ->
        val is null or
        typeof val is 'string' or
        typeof val is 'number' or
        typeof val is 'boolean' or
        typeof val is 'undefined'

## *Boolean* utils.isObject(*Any* value)

Returns `true` if the given value is an object (object, array, but not a `null`).

```javascript
console.log(utils.isObject({}));
// true

console.log(utils.isObject([]));
// true

console.log(utils.isObject(null));
// false

console.log(utils.isObject(''));
// false

console.log(utils.isObject(function(){}));
// false
```

    isObject = exports.isObject = (param) ->
        param isnt null and typeof param is 'object'

## *Boolean* utils.isPlainObject(*Any* value)

Returns `true` if the given value is an object with no prototype,
or with a prototype equal the `Object.prototype`.

```javascript
console.log(utils.isPlainObject({}))
// true

console.log(utils.isPlainObject(Object.create(null));
// true

console.log(utils.isPlainObject([]))
// false

console.log(utils.isPlainObject(function(){}))
// false

function User(){}
console.log(utils.isPlainObject(new User))
// false

console.log(utils.isPlainObject(Object.create({propertyInProto: 1})))
// false
```

    exports.isPlainObject = (param) ->
        unless isObject(param)
            return false

        proto = getPrototypeOf param

        # comes from Object.create
        unless proto
            return true

        # one-proto object
        if (proto is Object::) and not getPrototypeOf(proto)
            return true

        false

## *Boolean* utils.isArguments(*Any* value)

Returns `true` if the given value is an arguments object.

```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();

console.log(utils.isArguments({}))
// false
```

    exports.isArguments = (param) ->
        toString.call(param) is '[object Arguments]'

## *NotPrimitive* utils.merge(*NotPrimitive* source, *NotPrimitive* object)

Overrides the given source object properties by the given object own properties.

The source object is returned.

```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

    merge = exports.merge = (source, obj) ->
        null
        `//<development>`
        if isPrimitive(source)
            throw new Error 'utils.merge source cannot be primitive'
        if isPrimitive(obj)
            throw new Error 'utils.merge object cannot be primitive'
        if source is obj
            throw new Error 'utils.merge source and object are the same'
        if arguments.length > 2
            throw new Error 'utils.merge expects only two arguments; ' +
                'use utils.mergeAll instead'
        `//</development>`

        for key, value of obj when obj.hasOwnProperty(key)
            source[key] = value

        source

## *NotPrimitive* utils.mergeAll(*NotPrimitive* source, *NotPrimitive* objects...)

Like the utils.merge(), but the amount of objects to merge is unknown.

```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```

    exports.mergeAll = (source) ->
        null
        `//<development>`
        if isPrimitive(source)
            throw new Error 'utils.merge source cannot be primitive'
        `//</development>`

        for i in [1...arguments.length] by 1
            if (obj = arguments[i])?
                `//<development>`
                if isPrimitive(obj)
                    throw new Error 'utils.mergeAll object cannot be primitive'
                if source is obj
                    throw new Error 'utils.mergeAll source and object are the same'
                `//</development>`
                for key, value of obj when obj.hasOwnProperty(key)
                    source[key] = value

        source

## *NotPrimitive* utils.mergeDeep(*NotPrimitive* source, *NotPrimitive* object)

Overrides the given source object properties and all its objects
by the given object own properties.

The source object is returned.

```javascript
var user = {
  name: 'test',
  carsByName: {
    tiny: 'Ferrharhi',
    monkey: 'BMM'
  }
}

utils.mergeDeep(user, {
  name: 'Johny',
  carsByName: {
    nextCar: 'Fita'
  }
});

console.log(user);
// {name: 'Johny', carsByName: {tiny: 'Ferrharhi', monkey: 'BMM', nextCar: 'Fita'}}
```

    mergeDeep = exports.mergeDeep = (source, obj) ->
        null
        `//<development>`
        if isPrimitive(source)
            throw new Error 'utils.mergeDeep source cannot be primitive'
        if isPrimitive(obj)
            throw new Error 'utils.mergeDeep object cannot be primitive'
        if source is obj
            throw new Error 'utils.mergeDeep source and object are the same'
        `//</development>`

        for key, value of obj when hasOwnProp.call obj, key
            sourceValue = source[key]

            if value and typeof value is 'object' and not isArray(value) and sourceValue and typeof sourceValue is 'object' and not isArray(sourceValue)
                mergeDeep sourceValue, value
                continue

            source[key] = value

        source

## *NotPrimitive* utils.fill(*NotPrimitive* source, *NotPrimitive* object)

Sets the given object properties into the given source object if the property
exists in the given source, but it's not defined as an own property.

The source object is returned.

```javascript
function User(){
}

User.prototype.name = '';

var user = new User;
utils.fill(user, {name: 'Johny', age: 40});
console.log(user);
// {name: 'Johny'}
```

    exports.fill = (source, obj) ->
        null
        `//<development>`
        if isPrimitive(source)
            throw new Error 'utils.fill source cannot be primitive'
        if isPrimitive(obj)
            throw new Error 'utils.fill object cannot be primitive'
        if source is obj
            throw new Error 'utils.fill source and object are the same'
        `//</development>`

        for key, value of obj when hasOwnProp.call(obj, key)
            if key of source and not hasOwnProp.call(source, key)
                source[key] = value

        source

## utils.remove(*NotPrimitive* object, *Any* element)

Removes an array element or an object property from the given object.

```javascript
var array = ['a', 'b', 'c'];
utils.remove(array, 'b');
console.log(array);
// ['a', 'c']

var object = {a: 1, b: 2};
utils.remove(object, 'a');
console.log(object);
// {b: 2}
```

    exports.remove = (obj, elem) ->
        null
        `//<development>`
        if isPrimitive(obj)
            throw new Error 'utils.remove object cannot be primitive'
        `//</development>`

        if isArray(obj)
            index = obj.indexOf elem
            if index isnt -1
                if index is 0
                    obj.shift()
                else if index is obj.length - 1
                    obj.pop()
                else
                    obj.splice index, 1
        else
            delete obj[elem]

        return

## utils.removeFromUnorderedArray(*Array* array, *Any* element)

Removes the given element from the given array.

Elements order may be changed.

    exports.removeFromUnorderedArray = (arr, elem) ->
        null
        `//<development>`
        unless Array.isArray(arr)
            throw new Error 'utils.removeFromUnorderedArray array must be an Array'
        `//</development>`

        index = arr.indexOf elem
        if index isnt -1
            arr[index] = arr[arr.length - 1]
            arr.pop()

        return

## *Object* utils.getPropertyDescriptor(*NotPrimitive* object, *String* property)

Returns the descriptor of the given property defined in the given object.

```javascript
function User(){
  this.age = 0;
}

utils.defineProperty(User.prototype, 'isAdult', utils.CONFIGURABLE, function(){
  return this.age >= 18;
}, null);

var user = new User;
console.log(utils.getPropertyDescriptor(user, 'isAdult'));
// {enumerable: false, configurable: true, get: ..., set: undefined}
```

    exports.getPropertyDescriptor = (obj, prop) ->
        null
        `//<development>`
        if isPrimitive(obj)
            throw new Error 'utils.getPropertyDescriptor object cannot be primitive'
        if typeof prop isnt 'string'
            throw new Error 'utils.getPropertyDescriptor property must be a string'
        `//</development>`

        while obj and not desc
            desc = getObjOwnPropDesc obj, prop

            obj = getPrototypeOf obj

        desc

## *Function* utils.lookupGetter(*NotPrimitive* object, *String* property)

Returns the given property getter function defined in the given object.

```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

    exports.lookupGetter = do ->
        # use native function if possible
        if Object::__lookupGetter__
            {lookupGetter} = Object::
            (obj, prop) ->
                getter = lookupGetter.call(obj, prop)
                getter?.trueGetter or getter

        # use polyfill
        (obj, prop) ->
            if desc = exports.getPropertyDescriptor(obj, prop)
                desc.get?.trueGetter or desc.get

## *Function* utils.lookupSetter(*NotPrimitive* object, *String* property)

Returns the given property setter function defined in the given object.

    exports.lookupSetter = do ->
        # use native function if possible
        if Object::__lookupSetter__
            return Function.call.bind Object::__lookupSetter__

        # use polyfill
        (obj, prop) ->
            desc = exports.getPropertyDescriptor obj, prop
            desc?.set

## *NotPrimitive* utils.defineProperty(*NotPrimitive* object, *String* property, *Integer* descriptors, [*Any* value, *Function* setter])

Defines the given property in the given object.

The descriptors argument is a bitmask accepting
`utils.WRITABLE`, `utils.ENUMERABLE` and `utils.CONFIGURABLE`.

The value argument becomes a getter function if the given setter is not an undefined.

```javascript
var object = {};

var desc = utils.ENUMERABLE | utils.WRITABLE | utils.CONFIGURABLE;
utils.defineProperty(object, 'name', desc, 'Emmy');
console.log(object.name);
// Emmy

utils.defineProperty(object, 'const', utils.ENUMERABLE, 'constantValue');
console.log(object.const);
// constantValue

utils.defineProperty(object, 'length', utils.ENUMERABLE | utils.CONFIGURABLE, function(){
  return 2;
}, null);
console.log(object.length);
// 2
```

    defObjProp exports, 'WRITABLE', value: 1<<0
    defObjProp exports, 'ENUMERABLE', value: 1<<1
    defObjProp exports, 'CONFIGURABLE', value: 1<<2

    exports.defineProperty = do ->
        {WRITABLE, ENUMERABLE, CONFIGURABLE} = exports

        descCfg = enumerable: true, configurable: true
        valueCfg = exports.merge writable: true, value: null, descCfg
        accessorsCfg = exports.merge get: undefined, set: undefined, descCfg

        # thanks to http://stackoverflow.com/a/23522755/2021829
        isSafari = if navigator?
            ///^((?!chrome).)*safari///i.test(navigator.userAgent)
        else
            false

        (obj, prop, desc, getter, setter) ->
            null
            `//<development>`
            if isPrimitive(obj)
                throw new Error 'utils.defineProperty object cannot be primitive'
            if typeof prop isnt 'string'
                throw new Error 'utils.defineProperty property must be a string'
            if desc? and (not exports.isInteger(desc) or desc < 0)
                throw new Error 'utils.defineProperty descriptors bitmask ' +
                    'must be a positive integer'
            `//</development>`

            # configure value
            if setter is undefined
                cfg = valueCfg
                valueCfg.value = getter
                valueCfg.writable = desc & WRITABLE

            # configure accessors
            else
                # HACK: safari bug
                # https://bugs.webkit.org/show_bug.cgi?id=132872
                if isSafari and getter
                    _getter = getter
                    getter = ->
                        if @ isnt obj and @hasOwnProperty(prop)
                            @[prop]
                        else
                            _getter.call @

                cfg = accessorsCfg
                accessorsCfg.get = if typeof getter is 'function' then getter else undefined
                accessorsCfg.set = if typeof setter is 'function' then setter else undefined

            # set common config
            cfg.enumerable = desc & ENUMERABLE
            cfg.configurable = desc & CONFIGURABLE

            # set property
            defObjProp obj, prop, cfg

            obj

## *NotPrimitive* utils.overrideProperty(*NotPrimitive* object, *String* property, [*Any* value, *Function* setter])

    exports.overrideProperty = (obj, prop, getter, setter) ->
        unless desc = exports.getPropertyDescriptor(obj, prop)
            throw new Error 'utils.overrideProperty object ' +
                'must has the given property'
        unless desc.configurable
            throw new Error 'utils.overrideProperty the given property ' +
                'is not configurable'

        # get bitmask descriptors
        opts = exports.CONFIGURABLE
        if desc.writable
            opts |= exports.WRITABLE
        if desc.enumerable
            opts |= exports.ENUMERABLE

        # get values
        if getter isnt undefined and setter isnt undefined
            if desc.get?
                if typeof getter is 'function'
                    getter = getter desc.get
                else
                    getter = desc.get
            if desc.set?
                if typeof setter is 'function'
                    setter = setter desc.set
                else
                    setter = desc.set
        else if typeof getter is typeof desc.value is 'function'
            getter = getter desc.value

        exports.defineProperty obj, prop, opts, getter, setter

## *Any* utils.clone(*Any* param)

Returns clone of the given array or object.

```javascript
console.log(utils.clone([1, 2]))
// [1, 2]

console.log(utils.clone({a: 1}))
// {a: 1}
```

    clone = exports.clone = (param) ->
        if isArray(param)
            return param.slice()

        if isObject(param)
            proto = getPrototypeOf param
            if proto is Object::
                result = {}
            else
                result = createObject proto

            for key in objKeys param
                result[key] = param[key]

            return result

        param

## *Any* utils.cloneDeep(*Any* param)

Returns deep clone of the given array or object.

```javascript
var obj2 = {ba: 1};
var obj = {a: 1, b: obj2};

var clonedObj = utils.cloneDeep(obj);
console.log(clonedObj);
// {a: 1, b: {ba: 1}}

console.log(clonedObj.b === obj.b)
// false
```

    cloneDeep = exports.cloneDeep = (param) ->
        result = clone param

        if isObject result
            for key in objKeys result
                result[key] = cloneDeep result[key]

        result

## *Boolean* utils.isEmpty(*String*|*NotPrimitive* object)

Returns `true` if the given array has no elements, of the given object has no own properties.

```javascript
console.log(utils.isEmpty([]));
// true

console.log(utils.isEmpty([1, 2]));
// false

console.log(utils.isEmpty({}));
// true

console.log(utils.isEmpty({a: 1}));
// false

console.log(utils.isEmpty(''));
// true
```

    exports.isEmpty = (object) ->
        if typeof object is 'string'
            return object is ''

        `//<development>`
        if isPrimitive(object)
            throw new Error 'utils.isEmpty object must be a string or ' +
                'not primitive'
        `//</development>`

        if isArray(object)
            return not object.length
        else
            for key of object
                return false
            return true

## *Any* utils.last(*NotPrimitive* array)

Returns the last element of the given array, or an array-like object.

```javascript
console.log(utils.last(['a', 'b']))
// b

console.log(utils.last([]))
// undefined
```

    exports.last = (arg) ->
        null
        `//<development>`
        if isPrimitive(arg)
            throw new Error 'utils.last array cannot be primitive'
        `//</development>`

        arg[arg.length - 1]

## *NotPrimitive* utils.clear(*NotPrimitive* object)

Removes all elements from the given array, or all own properties from the given object.

```javascript
var arr = ['a', 'b'];
utils.clear(arr);
console.log(arr);
// []

var obj = {age: 37};
utils.clear(obj);
console.log(obj);
// {}
```

    exports.clear = (obj) ->
        null
        `//<development>`
        if isPrimitive(obj)
            throw new Error 'utils.clear object cannot be primitive'
        `//</development>`

        if isArray obj
            obj.pop() for _ in [0...obj.length] by 1
        else
            delete obj[key] for key in objKeys obj

        obj

## *Object* utils.setPrototypeOf(*NotPrimitive* object, *NotPrimitive*|*Null* prototype)

Changes the given object prototype into the given prototype.

**This function on some environments returns a new object.**

```javascript
var obj = {a: 1};
var prototype = {b: 100};

var newObj = utils.setPrototypeOf(obj, prototype);

console.log(Object.getPrototypeOf(newObj) === prototype)
// true

console.log(newObj.a)
// 1

console.log(newObj.b)
// 100
```

    setPrototypeOf = exports.setPrototypeOf = do ->
        # ES6 `Object.setPrototypeOf()`
        if typeof Object.setPrototypeOf is 'function'
            return Object.setPrototypeOf

        # writable __proto__
        tmp = {}
        tmp.__proto__ = a: 1
        if tmp.a is 1
            return (obj, proto) ->
                null
                `//<development>`
                if isPrimitive(obj)
                    throw new Error 'utils.setPrototypeOf object ' +
                        'cannot be primitive'
                if proto? and isPrimitive(proto)
                    throw new Error 'utils.setPrototypeOf prototype ' +
                        'cannot be primitive'
                `//</development>`

                obj.__proto__ = proto
                obj

        # object merging
        return (obj, proto) ->
            null
            `//<development>`
            if isPrimitive(obj)
                throw new Error 'utils.setPrototypeOf object ' +
                    'cannot be primitive'
            if proto? and isPrimitive(proto)
                throw new Error 'utils.setPrototypeOf prototype ' +
                    'cannot be primitive'
            `//</development>`

            if typeof obj is 'object'
                newObj = createObject proto
                merge newObj, obj
            else
                merge obj, proto
            newObj

## *Boolean* utils.has(*Any* object, *Any* value)

Returns `true` if the given array contains the given value.

```javascript
console.log(utils.has(['a'], 'a'))
// true

console.log(utils.has(['a'], 'b'))
// false
```

Returns `true` if the given object has an own property names as the given value.

```javascript
var object = {
  city: 'New York'
}

console.log(utils.has(object, 'New York'))
// true
```

Returns `true` if the given string contains the given value.

```javascript
console.log(utils.has('abc', 'b'))
// true

console.log(utils.has('abc', 'e'))
// false
```

    has = exports.has = (obj, val) ->
        if typeof obj is 'string'
            !!~obj.indexOf(val)
        else
            `//<development>`
            if isPrimitive(obj)
                throw new Error 'utils.has object must be a string or not primitive'
            `//</development>`

            if isArray(obj)
                !!~Array::indexOf.call obj, val
            else
                for key, value of obj when hasOwnProp.call(obj, key)
                    if value is val
                        return true

                false

## *Array* utils.objectToArray(*Object* object, [*Function* valueGen, *Array* target = `[]`])

Translates the given object into an array.

Array elements are determined by the given valueGen function.
The valueGen function is called with the property name, property value and the given object.

By default, the valueGen returns the object property value.

Created elements are set into the given target array (a new array by default).

```javascript
var object = {
  type: 'dog',
  name: 'Bandit'
};

console.log(utils.objectToArray(object));
// ['dog', 'Bandit']

console.log(utils.objectToArray(object, function(key, val){
  return key + "_" + val;
}));
// ['type_dog', 'name_Bandit']
```

    exports.objectToArray = (obj, valueGen, target) ->
        keys = objKeys obj
        target ?= keys

        `//<development>`
        if not isObject(obj)
            throw new Error 'utils.objectToArray object must be an object'
        if valueGen? and typeof valueGen isnt 'function'
            throw new Error 'utils.objectToArray valueGen must be a function'
        if not isArray(target)
            throw new Error 'utils.objectToArray target must be an array'
        `//</development>`

        for key, i in keys
            value = if valueGen then valueGen(key, obj[key], obj) else obj[key]
            target[i] = value

        target

## *Object* utils.arrayToObject(*Array* array, [*Function* keyGen, *Function* valueGen, *Object* target = `{}`])

Translates the given array into an object.

Object keys are determined by the given keyGen function.
Object key values are determined by the given valueGen function.
The keyGen and valueGen functions are called with the array element index,
array element value and the array itself.

By default, the keyGen function returns the array element index.
By default, the valueGen function returns the array element value.

Created proeprties are set into the given target object (a new object by default).

```javascript
console.log(utils.arrayToObject(['a', 'b']))
// {0: 'a', 1: 'b'}

console.log(utils.arrayToObject(['a'], function(i, elem){
  return "value_" + elem;
}));
// {"value_a": "a"}

console.log(utils.arrayToObject(['a'], function(i, elem){
  return elem;
}, function(i, elem){
  return i;
}));
// {"a": 0}
```

    exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->
        null
        `//<development>`
        if not isArray(arr)
            throw new Error 'utils.arrayToObject array must be an array'
        if keyGen? and typeof keyGen isnt 'function'
            throw new Error 'utils.arrayToObject keyGen must be a function'
        if valueGen? and typeof valueGen isnt 'function'
            throw new Error 'utils.arrayToObject valueGen must be a function'
        if not isObject(target)
            throw new Error 'utils.arrayToObject target must be an object'
        `//</development>`

        for elem, i in arr
            key = if keyGen then keyGen(i, elem, arr) else i
            value = if valueGen then valueGen(i, elem, arr) else elem

            if key?
                target[key] = value

        target

## *String* utils.capitalize(*String* string)

Capitalizes the given string.

```javascript
console.log(utils.capitalize('name'))
// Name
```

    exports.capitalize = (str) ->
        null
        `//<development>`
        if typeof str isnt 'string'
            throw new Error 'utils.capitalize string must be a string'
        `//</development>`

        unless str.length
            return ''

        str[0].toUpperCase() + str.slice(1)

## *String* utils.addSlashes(*String* string)

Adds backslashes before each `'` and `"` characters found in the given string.

```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```

    exports.addSlashes = do ->
        SLASHES_RE = ///'|"///g
        NEW_SUB_STR = '\\$\&'

        (str) ->
            null
            `//<development>`
            if typeof str isnt 'string'
                throw new Error 'utils.addSlashes string must be a string'
            `//</development>`

            unless str.length
                return str

            str.replace SLASHES_RE, NEW_SUB_STR

## *String* utils.uid([*Integer* length = `8`])

Returns pseudo-unique string with the given length.

This function doesn't quarantee uniqueness of the returned data.

```javascript
console.log(utils.uid())
// "50"
```

    exports.uid = (n = 8) ->
        null
        `//<development>`
        if typeof n isnt 'number' or n <= 0 or not isFinite(n)
            throw new Error 'utils.uid length must be a positive finite number'
        `//</development>`

        str = ''

        loop
            str += random().toString(16).slice 2
            if str.length >= n then break

        if str.length isnt n
            str = str.slice 0, n
        str

## *Any* utils.tryFunction(*Function* function, [*Any* context, *Array* arguments, *Any* onFail])

Calls the given function with the given context and arguments.

If the function throws an error, the given onFail value is returned.

If the given onFail is a function, it will be called with the caught error.

```javascript
function test(size){
  if (size === 0){
    throw "Wrong size!";
  }
}

console.log(utils.tryFunction(test, null, [0]))
// undefined

console.log(utils.tryFunction(test, null, [0], 'ERROR!'))
// ERROR!

console.log(utils.tryFunction(test, null, [100], 'ERROR!'))
// undefined
```

    exports.tryFunction = (func, context, args, onFail) ->
        null
        `//<development>`
        if typeof func isnt 'function'
            throw new Error 'utils.tryFunction function must be a function'
        if args? and not isObject(args)
            throw new Error 'utils.tryFunction arguments must be an object'
        `//</development>`

        try
            func.apply context, args
        catch err
            if typeof onFail is 'function'
                onFail(err)
            else if onFail is undefined
                err
            else
                onFail

## *Any* utils.catchError(*Function* function, [*Any* context, *Array* arguments])

Calls the given function with the given context and arguments.

Returns caught error.

```javascript
function test(size){
  if (size === 0){
    throw "Wrong size!";
  }
}

console.log(utils.catchError(test, null, [0]))
// "Wrong size!"

console.log(utils.catchError(test, null, [100]))
// null
```

    exports.catchError = (func, context, args) ->
        null
        `//<development>`
        if typeof func isnt 'function'
            throw new Error 'utils.catchError function must be a function'
        if args? and not isObject(args)
            throw new Error 'utils.catchError arguments must be an object'
        `//</development>`

        try
            func.apply context, args
            return
        catch err
            err

## *Function* utils.bindFunctionContext(*Function* function, *Any* context)

Returns a new function calling the given function with the given context and
arguments in an amount lower or equal the function length.

```javascript
function func(arg1){
  console.log(this, arg1);
}

var bindFunc = utils.bindFunctionContext(func, {ctx: 1});

console.log(bindFunc('a'));
// {ctx: 1} "a"
```

    exports.bindFunctionContext = (func, ctx) ->
        null
        `//<development>`
        if typeof func isnt 'function'
            throw new Error 'utils.bindFunctionContext function must be a function'
        `//</development>`

        switch func.length
            when 0
                -> func.call ctx
            when 1
                (a1) -> func.call ctx, a1
            when 2
                (a1, a2) -> func.call ctx, a1, a2
            when 3
                (a1, a2, a3) -> func.call ctx, a1, a2, a3
            when 4
                (a1, a2, a3, a4) -> func.call ctx, a1, a2, a3, a4
            when 5
                (a1, a2, a3, a4, a5) -> func.call ctx, a1, a2, a3, a4, a5
            when 6
                (a1, a2, a3, a4, a5, a6) -> func.call ctx, a1, a2, a3, a4, a5, a6
            when 7
                (a1, a2, a3, a4, a5, a6, a7) -> func.call ctx, a1, a2, a3, a4, a5, a6, a7
            else
                -> func.apply ctx, arguments

## *Object* utils.errorToObject(*Error* error)

Returns a plain object with the given error name, message and other custom properties.

Standard error `name` and `message` properties are not enumerable.

```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

    exports.errorToObject = (error) ->
        null
        `//<development>`
        unless error instanceof Error
            throw new Error 'utils.errorToObject error must be an Error instance'
        `//</development>`

        result =
            name: error.name
            message: error.message

        # support custom properties
        exports.merge result, error

        result

## *Object* utils.getOwnProperties(*Object* object)

Returns an array or an object with own properties associated in the given object.

    exports.getOwnProperties = (obj) ->
        null
        `//<development>`
        if not isObject(obj)
            throw new Error 'utils.getOwnProperties object must be an object'
        `//</development>`

        result = if isArray obj then [] else {}
        merge result, obj
        result

## *Boolean* utils.isEqual(*Object* object1, *Object* object2, [*Function* compareFunction, *Integer* maxDeep = `Infinity`])

Returns `true` if the given objects have equal values.

The given compareFunction is used to compare two values (which at least one them is primitive).
By default the compareFunction uses triple comparison (`===`).

```javascript
utils.isEqual([1, 0], [1, 0])
// true

utils.isEqual({a: 1}, {a: 1})
// true

utils.isEqual({a: {aa: 1}}, {a: {aa: 1}})
// true

utils.isEqual([0, 1], [1, 0])
// false

utils.isEqual({a: {aa: 1}}, {a: {aa: 1, ab: 2}})
// false
```

    isEqual = exports.isEqual = do ->
        defaultComparison = (a, b) -> a is b

        forArrays = (a, b, compareFunc, maxDeep) ->
            # prototypes are the same
            if getPrototypeOf(a) isnt getPrototypeOf(b)
                return false

            # length is the same
            if a.length isnt b.length
                return false

            # values are the same
            if maxDeep <= 0
                return true

            for aValue, index in a
                bValue = b[index]

                if bValue and typeof bValue is 'object'
                    unless isEqual(aValue, bValue, compareFunc, maxDeep - 1)
                        return false
                    continue

                unless compareFunc(aValue, bValue)
                    return false

            true

        forObjects = (a, b, compareFunc, maxDeep) ->
            # prototypes are the same
            if getPrototypeOf(a) isnt getPrototypeOf(b)
                return false

            # whether keys are the same
            for key, value of a when a.hasOwnProperty(key)
                unless b.hasOwnProperty(key)
                    return false

            for key, value of b when b.hasOwnProperty(key)
                unless a.hasOwnProperty(key)
                    return false

            # whether values are equal
            if maxDeep <= 0
                return true

            for key, value of a when a.hasOwnProperty(key)
                if value and typeof value is 'object'
                    unless isEqual(value, b[key], compareFunc, maxDeep - 1)
                        return false
                    continue

                unless compareFunc(value, b[key])
                    return false

            true

        (a, b, compareFunc = defaultComparison, maxDeep = Infinity) ->
            if typeof compareFunc is 'number'
                maxDeep = compareFunc
                compareFunc = defaultComparison

            `//<development>`
            if typeof compareFunc isnt 'function'
                throw new Error 'utils.isEqual compareFunction must be a function'
            if typeof maxDeep isnt 'number'
                throw new Error 'utils.isEqual maxDeep must be a number'
            `//</development>`

            if maxDeep < 0
                return compareFunc a, b

            if isArray(a) and isArray(b)
                forArrays a, b, compareFunc, maxDeep
            else if isObject(a) and isObject(b)
                forObjects a, b, compareFunc, maxDeep
            else
                return compareFunc a, b
