# Properties extraction

    'use strict'

    module.exports = (utils) ->

## *Any* utils.get(*Object* object, *String* path, [*OptionsArray* target])

Extracts property, deep property or an array of possible properties from the given object.

```javascript
var obj = {prop: 1};
console.log(utils.get(obj, 'prop'));
// 1

var obj = {prop: {deep: 1}};
console.log(utils.get(obj, 'prop.deep'));
// 1

var obj = {prop: [{deep: 1}, {deep: 2}]};
console.log(utils.get(obj, 'prop[].deep'));
// [1, 2]
// 'utils.get.OptionsArray' instance ...

var obj = {prop: [{deep: 1}, {deep: 2}]};
console.log(utils.get(obj, 'prop[]'));
// [{deep: 1}, {deep: 2}]
// 'utils.get.OptionsArray' instance ...

var obj = {prop: [{deep: {}}, {deep: {result: 1}}]};
console.log(utils.get(obj, 'prop[].deep.result'));
// [1]
// 'utils.get.OptionsArray' instance ...
```

        get = utils.get = (obj, path = '', target) ->
            switch typeof path
                when 'object'
                    path = exports.clone path
                when 'string'
                    # split path by dot's
                    path = path.split '.'
                else
                    throw new TypeError

            # check chunks
            for key, i in path
                # empty props are not supported
                if not key.length and i
                    throw new ReferenceError 'utils.get(): empty properties ' +
                        'are not supported'

                # support array elements by `[]` chars
                if isStringArray key

                    # get array key name
                    key = key.substring 0, key.indexOf('[]')

                    # cut path removing checked elements
                    path = path.splice i

                    # update current path elem without array brackets
                    path[0] = path[0].substring key.length + 2

                    # if current path is empty, remove it
                    unless path[0].length then path.shift()

                    # create target array if no exists
                    target ?= new OptionsArray()

                    # move to the key value if needed
                    if key.length
                        obj = obj[key]

                    # return `undefined` if no value exists
                    if typeof obj is 'undefined'
                        return undefined

                    # call this func recursive on all array elements
                    # found results will be saved in the `target` array
                    for elem in obj
                        get elem, path.join('.'), target

                    # return `undefined` if nothing has been found
                    unless target.length
                        return undefined

                    # return found elements
                    return target

                # move to the next object value
                if key.length then obj = obj[key]

                # break if no way exists
                if typeof obj isnt 'object' and typeof obj isnt 'function'
                    # if it is no end of path, return undefined
                    if i isnt path.length - 1
                        obj = undefined

                    break

            # save obj into target array
            if target and typeof obj isnt 'undefined' then target.push obj

            obj

## **Class** utils.get.OptionsArray()

Special version of an Array, returned if the result of the utils.get()
function is a list of the possible values.

        get.OptionsArray = class OptionsArray extends Array

            constructor: ->
                super()

## *Boolean* utils.isStringArray(*String* value)

Checks whether the given string references into an array according
to the notation in the utils.get() function.

        isStringArray = utils.isStringArray = (arg) ->
            null
            `//<development>`
            if typeof arg isnt 'string'
                throw new Error 'utils.isStringArray value must be a string'
            `//</development>`

            ///\[\]$///.test arg
