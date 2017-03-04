# Native

    'use strict'

    utils = require 'src/utils'
    log = require 'src/log'
    assert = require 'src/assert'
    colorUtils = require 'src/renderer/utils/color'

    IS_NATIVE = not utils.isServer and not utils.isBrowser

    if IS_NATIVE
        {callNativeFunction, onNativeEvent} = require 'src/native'

    module.exports = (Renderer, Impl, itemUtils) ->

        class Native extends Renderer.Item
            @__name__ = 'Native'
            @__path__ = 'Renderer.Native'

## *Native* Native.New([*Object* options])

            @New = (opts) ->
                item = new @
                itemUtils.Object.initialize item, opts
                unless IS_NATIVE
                    item.onParentChange Impl.updateNativeSize
                @Initialize? item
                item

## Native.defineProperty(*Object* config)

Defines new property with the given name.

For each property, signal `onXYZChange` is created,
where `XYZ` is the given name.

`config` parameter must be an object with specified keys:
- `enabled` - whether it's supported on current platform,
- `name` - name of the property,
- `type` - type of predefined condifuration described below,
- `defaultValue`,
- `setter`,
- `getter`,
- `developmentSetter`
- `implementationValue` - function returning value passed to the implementation.

### Predefined types

            PROPERTY_TYPES = Object.create null

#### text

            PROPERTY_TYPES.text = ->
                defaultValue: ''
                developmentSetter: (val) ->
                    assert.isString val

#### number

            PROPERTY_TYPES.number = ->
                defaultValue: 0
                developmentSetter: (val) ->
                    assert.isFloat val

#### boolean

            PROPERTY_TYPES.boolean = ->
                defaultValue: false
                developmentSetter: (val) ->
                    assert.isBoolean val

#### color

            PROPERTY_TYPES.color = (config) ->
                defaultValue: ''
                developmentSetter: (val) ->
                    assert.isString val
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        val = Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                        if IS_NATIVE
                            if val?
                                colorUtils.toRGBAHex val, config.defaultValue
                            else
                                null
                        else
                            val

#### item

            PROPERTY_TYPES.item = (config) ->
                defaultValue: null
                developmentSetter: (val) ->
                    if val?
                        assert.instanceOf val, Renderer.Item
                implementationValue: (val) ->
                    if IS_NATIVE
                        if val?
                            val._impl.id
                        else
                            null
                    else
                        val

            @defineProperty = (config) ->
                itemName = @__name__
                properties = @_properties ||= []
                config = utils.clone config

                assert.isString itemName, '''
                    NativeItem.__name__ unique name must be specified
                '''
                assert.isObject config, '''
                    NativeItem.defineProperty config parameter must be an object
                '''
                assert.isString config.name, '''
                    NativeItem property name must be a string
                '''
                assert.isNotDefined properties[config.name], """
                    Property #{config.name} is already defined
                """
                assert.isDefined PROPERTY_TYPES[config.type], """
                    Unknown property type #{config.type}
                """ if config.type

                # type
                if typeConfigFunc = PROPERTY_TYPES[config.type]
                    typeConfig = typeConfigFunc(config)
                    for key, val of typeConfig
                        if key not of config
                            config[key] = val

                # constructor
                config.constructor = @

                # internalName
                config.internalName = itemUtils.getPropInternalName config.name

                # implementation
                config.implementation = do ->
                    if config.enabled is false
                        return utils.NOP

                    ctorName = utils.capitalize itemName
                    name = utils.capitalize config.name
                    if IS_NATIVE
                        funcName = "rendererSet#{ctorName}#{name}"
                        (val) ->
                            callNativeFunction funcName, @_impl.id, val
                    else
                        funcName = "set#{ctorName}#{name}"
                        (val) ->
                            Impl[funcName]?.call @, val

                # save
                properties.push config

                # create
                itemUtils.defineProperty config

## *Native* Native::constructor() : *Item*

            constructor: ->
                super()

                unless IS_NATIVE
                    @_autoWidth = true
                    @_autoHeight = true
                    @_width = -1
                    @_height = -1

                # save properties with default values
                if properties = @constructor._properties
                    for property in properties
                        @[property.internalName] = property.defaultValue

            unless IS_NATIVE
                _width: -1
                getter = utils.lookupGetter @::, 'width'
                itemWidthSetter = utils.lookupSetter @::, 'width'
                utils.defineProperty @::, 'width', null, getter,
                    do (_super = itemWidthSetter) -> (val) ->
                        if @_autoWidth = val is -1
                            Impl.updateNativeSize.call @
                        else
                            _super.call @, val
                        return

                _height: -1
                getter = utils.lookupGetter @::, 'height'
                itemHeightSetter = utils.lookupSetter @::, 'height'
                utils.defineProperty @::, 'height', null, getter,
                    do (_super = itemHeightSetter) -> (val) ->
                        if @_autoHeight = val is -1
                            Impl.updateNativeSize.call @
                        else
                            _super.call @, val
                        return

## Native::set(*String* propName, *Any* val)

            set: (name, val) ->
                assert.isString name, "NativeItem.set name must be a string, but #{name} given"

                ctorName = utils.capitalize @constructor.__name__
                id = @_impl.id
                name = utils.capitalize name

                if IS_NATIVE
                    funcName = "rendererSet#{ctorName}#{name}"
                    callNativeFunction funcName, id, val
                else
                    funcName = "set#{ctorName}#{name}"
                    Impl[funcName]?.call @, val
                return

## Native::call(*String* funcName, *Any* args...)

            call: (name, args...) ->
                assert.isString name, "NativeItem.call name must be a string, but #{name} given"

                ctorName = utils.capitalize @constructor.__name__
                id = @_impl.id
                name = utils.capitalize name

                if IS_NATIVE
                    funcName = "rendererCall#{ctorName}#{name}"
                    callArgs = [funcName, id, args...]
                    callNativeFunction callArgs...
                else
                    funcName = "call#{ctorName}#{name}"
                    Impl[funcName]?.apply @, args
                return

## Native::on(*String* eventName, *Function* listener)

            # nativeEventName -> item id -> [item, listeners...]
            eventListeners = Object.create null

            createNativeEventListener = (listeners, eventName) -> (id) ->
                unless itemListeners = listeners[id]
                    log.warn "Got a native event '#{eventName}' for an item which " +
                        "didn't register a listener on this event; check if you " +
                        "properly call 'on()' method with a signal listener"
                    return

                length = arguments.length
                args = new Array length - 1
                for i in [0...length - 1] by 1
                    args[i] = arguments[i + 1]

                item = itemListeners[0]
                for i in [1...itemListeners.length] by 1
                    itemListeners[i].apply item, args

                return

            on: (name, func) ->
                assert.isString name, "NativeItem.on name must be a string, but #{name} given"
                assert.isFunction func, """
                    NativeItem.on listener must be a function, but #{func} given
                """

                name = utils.capitalize name

                if IS_NATIVE
                    ctorName = utils.capitalize @constructor.__name__
                    eventName = "rendererOn#{ctorName}#{name}"

                    unless listeners = eventListeners[eventName]
                        listeners = eventListeners[eventName] = Object.create(null)
                        onNativeEvent eventName, createNativeEventListener(listeners, eventName)

                    itemListeners = listeners[@_impl.id] ?= [@]
                    itemListeners.push func
                else
                    eventName = "on#{name}"
                    @_impl[eventName]?.connect func
                return

        Native
