'use strict'

{assert} = console

utils = require 'src/utils'
signal = require 'src/signal'
eventLoop = require 'src/eventLoop'

module.exports = (Renderer) ->
    impl = abstractImpl = require './impl/base'
    impl.Renderer = Renderer
    impl.windowItem = null
    impl.serverUrl = ''
    impl.resources = null
    signal.create impl, 'onWindowItemReady'

    TYPES = ['Item', 'Image', 'Text', 'Native', 'FontLoader',
             'Device', 'Screen', 'Navigator',

             'Rectangle', 'Grid', 'Column', 'Row', 'Flow',
             'Animation', 'PropertyAnimation', 'NumberAnimation']

    ABSTRACT_TYPES =
        'Class': true
        'Transition': true

    if process.env.NEFT_CLIENT
        platformImpl = try require('./impl/pixi') impl
        platformImpl or= try require('./impl/css') impl
        platformImpl or= try require('./impl/native') impl

    # merge types
    for name in TYPES
        type = impl.Types[name] = impl.Types[name](impl)
        utils.merge impl, type

    if platformImpl
        utils.mergeDeep impl, platformImpl

    # merge types
    for name in TYPES
        if typeof impl.Types[name] is 'function'
            type = impl.Types[name] = impl.Types[name](impl)
            utils.merge impl, type

    # init createData
    for name in TYPES
        if impl.Types[name].createData
            impl.Types[name].createData = impl.Types[name].createData()

    # merge modules
    for name, extra of impl.Extras
        extra = impl.Extras[name] = extra(impl)
        utils.merge impl, extra

    impl.createObject = (object, type) ->
        unless ABSTRACT_TYPES[type]
            obj = object
            while type and not impl.Types[type]?
                obj = Object.getPrototypeOf(obj)
                type = obj.constructor.__name__

        object._impl = impl.Types[type]?.createData?() or {}
        object._impl.bindings ?= {}
        Object.seal object._impl

    impl.initializeObject = (object, type) ->
        unless ABSTRACT_TYPES[type]
            obj = object
            while type and not impl.Types[type]?
                obj = Object.getPrototypeOf(obj)
                type = obj.constructor.__name__

            impl.Types[type]?.create?.call object, object._impl

    windowItemClass = null

    impl.setWindow = do (_super = impl.setWindow) -> (item) ->
        utils.defineProperty impl, 'windowItem', utils.ENUMERABLE, item

        windowItemClass = Renderer.Class.New()
        windowItemClass.target = item
        windowItemClass.running = true

        _super.call impl, item
        impl.onWindowItemReady.emit item
        item.keys.focus = true
        return

    impl.setWindowSize = (width, height) ->
        return unless impl.windowItem
        eventLoop.lock()
        windowItemClass.changes = width: width, height: height
        eventLoop.release()

    impl.addTypeImplementation = (type, methods) ->
        impl.Types[type] = methods
        utils.merge impl, methods

    impl
