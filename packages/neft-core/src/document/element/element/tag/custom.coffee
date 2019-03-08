'use strict'

util = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'

module.exports = (Element, Tag) -> class CustomTag extends Tag
    customTags = @customTags = {}
    JSON_CTOR_ID = @JSON_CTOR_ID = Element.JSON_CTORS.push(CustomTag) - 1

    i = Tag.JSON_ARGS_LENGTH
    JSON_FIELDS = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (arr, obj) ->
        fields = arr[JSON_FIELDS]
        unless obj
            ctor = customTags[arr[Tag.JSON_NAME]]
            obj = new ctor
        Tag._fromJSON arr, obj

        for field, val of fields
            obj[field] = val

        obj

    @registerAs = (tagName) ->
        customTags[tagName] = @
        return

    @defineProperty = ({ name, defaultValue = null }) ->
        if @ is CustomTag
            throw new Error 'Cannot define a property on CustomTag; create new class'

        internalName = "_#{name}"
        signalName = "on#{util.capitalize(name)}Change"

        @_fields ?= []
        @_fieldsByName ?= {}

        field =
            name: name
            internalName: internalName
            signalName: signalName
            defaultValue: defaultValue

        @_fields.push field
        @_fieldsByName[name] = field

        SignalsEmitter.createSignal @, signalName

        getter = -> @[internalName]

        setter = (val) ->
            oldVal = @[internalName]
            if oldVal is val
                return

            @[internalName] = val
            @emit signalName, oldVal

            return

        util.defineProperty @::, name, util.CONFIGURABLE, getter, setter

        return

    @defineStyleProperty = ({ name, styleName = name }) ->
        if @ is CustomTag
            throw new Error 'Cannot define a property on CustomTag; create new class'

        internalStyleName = "_#{styleName}"
        signalName = "on#{util.capitalize(name)}Change"
        signalStyleName = "on#{util.capitalize(styleName)}Change"

        @_styleAliases ?= []
        @_styleAliasesByName ?= []

        alias =
            name: name
            signalName: signalName
            styleName: styleName

        @_styleAliases.push alias
        @_styleAliasesByName[name] = alias

        # SignalsEmitter.createSignal @, signalName

        signalGetter = -> @_style?[signalStyleName]
        getter = -> @_style?[internalStyleName]

        util.defineProperty @::, signalName, util.CONFIGURABLE, signalGetter, null
        util.defineProperty @::, name, util.CONFIGURABLE, getter, null

        return

    constructor: ->
        super()

        fields = @constructor._fields
        fieldsByName = @constructor._fieldsByName
        styleAliases = @constructor._styleAliases

        if fields
            for field in fields
                @[field.internalName] = field.defaultValue

        Object.seal @

        if fieldsByName
            @onPropsChange.connect (name) ->
                if fieldsByName[name]
                    @[name] = @props[name]


    clone: (clone = new @constructor) ->
        super clone

        fields = @constructor._fields
        if fields
            for field in fields
                clone[field.internalName] = @[field.internalName]

        clone

    toJSON: (arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        super arr

        jsonFields = arr[JSON_FIELDS] = {}

        fields = @constructor._fields
        if fields
            for field in fields
                jsonFields[field.internalName] = @[field.internalName]

        arr
