# Route

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'
    log = require 'src/log'
    Schema = require 'src/schema'
    Networking = require 'src/networking'
    Document = require 'src/document'
    Renderer = require 'src/renderer'
    Dict = require 'src/dict'
    Struct = require 'src/struct'

    log = log.scope 'app', 'route'

    IS_NODE = process.env.NEFT_NODE
    IS_CLIENT = not IS_NODE

    module.exports = (app) -> class Route

        if IS_NODE
            usedTemplates = []
        else
            templates = Object.create null

        @lastClientRoute = null
        @onLastClientRouteChange = signal.create()

## *Document* Route.getTemplateComponent(*String* componentName)

        @getTemplateComponent = do ->
            if IS_NODE
                (name) ->
                    scope = routes: new Dict
                    tmpl = app.components[name].render null, scope
                    usedTemplates.push tmpl
                    tmpl
            else
                (name) ->
                    scope = routes: new Dict
                    templates[name] ?= app.components[name].render null, scope

## Route::constructor(*Object* options)

Access it with:
```javascript
module.exports = function(app) {
    var Route = app.Route;
};
```

Acceptable syntaxes:
```javascript
*Route* app.Route(*String* method, *String* uri, *Object* options)
*Route* app.Route(*String* methodWithUri, *Function* getData)
*Route* app.Route(*String* methodWithUri, *Object* options)
*Route* app.Route(*String* uri, *Function* getData)
*Route* app.Route(*String* uri, *Object* options)
*Route* app.Route(*String* method, *String* uri)
*Route* app.Route(*String* uri)
*Route* app.Route(*String* methodWithUri)
```

        constructor: (method, uri, opts) ->
            if utils.isObject(method)
                # opts
                opts = method
            else if utils.isObject(uri)
                opts = uri
            else unless utils.isObject(opts)
                opts = {}

            if typeof method is 'string' and typeof uri isnt 'string'
                opts.uri = method
            else if typeof method is 'string' and typeof uri is 'string'
                opts.method ?= method
                opts.uri ?= uri
            if typeof uri is 'function'
                opts.getData ?= uri

            assert.isObject opts
            opts = utils.clone opts

            if typeof opts.uri is 'string'
                # support methodWithUri e.g. 'get /home'
                spaceIndex = opts.uri.indexOf ' '
                if spaceIndex isnt -1
                    opts.method ?= opts.uri.slice 0, spaceIndex
                    opts.uri = opts.uri.slice spaceIndex + 1
                opts.uri = new Networking.Uri opts.uri
            assert.instanceOf opts.uri, Networking.Uri

            opts.method ?= 'get'
            assert.isString opts.method
            opts.method = opts.method.toLowerCase()
            assert.ok utils.has(Networking.Request.METHODS, opts.method)
            , "Networking doesn't provide a `#{opts.method}` method"

            if opts.schema?
                if utils.isPlainObject(opts.schema)
                    opts.schema = new Schema opts.schema
                assert.instanceOf opts.schema, Schema

            if opts.redirect?
                if typeof opts.redirect is 'string'
                    opts.redirect = new Networking.Uri opts.redirect
                else
                    assert.isFunction opts.redirect

            if utils.isObject(opts.toHTML)
                opts.toHTML = createToHTMLFromObject opts.toHTML

            for key, val of opts
                @[key] = val
            @__id__ = utils.uid()
            @app = app
            @name ||= getRouteName(@)

            app.networking.createHandler
                method: @method
                uri: @uri
                schema: @schema
                callback: utils.bindFunctionContext(handleRequest, @)

        getRouteName = (route) ->
            assert.instanceOf route, Route

            uri = route.uri._uri
            uri = uri.replace Networking.Uri.NAMES_RE, ''
            uri = uri.replace /\*/g, ''
            while uri.indexOf('//') isnt -1
                uri = uri.replace /\/\//g, '/'
            uri = uri.replace /^\//, ''
            uri = uri.replace /\/$/, ''
            uri

        routesCache = Object.create null
        pendingRoutes = Object.create null

        factoryRoute = do ->
            createInstance = (route) ->
                r = Object.create route
                r.__hash__ = utils.uid()
                r.factory?()
                r

            (route) ->
                assert.instanceOf route, Route

                id = route.__id__
                routesCache[id] ?= []
                r = routesCache[id].pop() or createInstance(route)
                r = Object.create r
                r.request = r.response = null
                r.route = r
                r._dataPrepared = false
                r._destroyComponentOnEnd = false
                r

        destroyRoute = (route) ->
            assert.instanceOf route, Route

            route.response.onSend.disconnect onResponseSent, route
            delete pendingRoutes[route.__hash__]
            route.destroy?()
            if route._dataPrepared
                switch route.request.type
                    when 'text'
                        route.destroyText?()
                    when 'json'
                        route.destroyJSON?()
                    when 'html'
                        route.destroyHTML?()

            if route._destroyComponentOnEnd
                route.response.data.destroy()

            routesCache[route.__id__].push Object.getPrototypeOf(route)

            if Route.lastClientRoute is route
                Route.lastClientRoute = null
                Route.onLastClientRouteChange.emit route

            return

        objectDataToStruct = (data) ->
            if utils.isObject(data)
                new Struct data
            else
                data

        resolveSyncGetDataFunc = (route) ->
            assert.instanceOf route, Route

            route.data = objectDataToStruct route.getData()

        resolveAsyncGetDataFuncCallback = (route, err, data) ->
            assert.instanceOf route, Route

            if err?
                if route.response.status is 200
                    route.response.status = 500
                if route._dataPrepared and route.error is err
                    return false
                route.error = err
            else
                if route._dataPrepared and route.data is data
                    return false
                route.data = objectDataToStruct data
            true

        prepareRouteData = (route) ->
            assert.instanceOf route, Route
            {response} = route

            if route.error
                log.error "Error in route '#{route.uri}':\n#{route.error}"

            respData = response.data
            switch route.request.type
                when 'text'
                    data = route.toText()
                when 'json'
                    data = route.toJSON()
                when 'html'
                    data = route.toHTML()
                    if respData instanceof Document and route._destroyComponentOnEnd
                        respData.destroy()
                        response.data = null
                    if not (data instanceof Document) and response.data is respData
                        data = renderComponentFromConfig.call route, data
            route._dataPrepared = true
            if data?
                response.data = data
            else if response.data is respData
                response.data = ''

        onResponseSent = ->
            if IS_NODE or @request.type isnt 'html'
                destroyRoute @

                if IS_NODE and utils.has(usedTemplates, @response.data)
                    @response.data.destroy()
                    utils.remove usedTemplates, @response.data
            return

        finishRequest = (route) ->
            assert.instanceOf route, Route
            if IS_CLIENT and route.response.data instanceof Document
                app.windowItem.node = route.response.data.node
            if route.response.pending
                route.response.send()
            return

        callNextIfNeeded = (route, next) ->
            unless pendingRoutes[route.__hash__]
                if route.response.pending
                    next()
                return true
            false

        handleRequest = (req, res, next) ->
            assert.instanceOf req, Networking.Request
            assert.instanceOf res, Networking.Response
            assert.isFunction next

            route = factoryRoute @
            hash = route.__hash__
            assert.notOk pendingRoutes[hash]

            if IS_CLIENT and req.type is 'html'
                if Route.lastClientRoute
                    destroyRoute Route.lastClientRoute
                {lastClientRoute} = Route
                Route.lastClientRoute = route
                Route.onLastClientRouteChange.emit lastClientRoute

            route.request = req
            route.response = res
            pendingRoutes[hash] = true

            res.onSend onResponseSent, route

            # init
            route.init?()

            unless pendingRoutes[hash]
                return next()

            # redirect
            {redirect} = route
            if typeof redirect is 'function'
                redirect = route.redirect()
                unless pendingRoutes[hash]
                    return next()
            if typeof redirect is 'string'
                redirect = new Networking.Uri redirect
            if redirect instanceof Networking.Uri
                res.redirect redirect.toString(req.params)
                return

            # getData
            {getData} = route
            fakeAsync = false
            if typeof getData is 'function'
                if getData.length is 1
                    route.getData (err, data) ->
                        fakeAsync = true
                        if callNextIfNeeded(route, next)
                            return
                        unless resolveAsyncGetDataFuncCallback(route, err, data)
                            return
                        prepareRouteData route
                        if callNextIfNeeded(route, next)
                            return
                        finishRequest route
                else
                    resolveSyncGetDataFunc route
                    if callNextIfNeeded(route, next)
                        return
                    prepareRouteData route
                    if callNextIfNeeded(route, next)
                        return
                    finishRequest route
            else
                prepareRouteData route
                if callNextIfNeeded(route, next)
                    return
                finishRequest route

            if not fakeAsync and callNextIfNeeded(route, next)
                return

## *String* Route::method = `'get'`

## *Networking.Uri* Route::uri

## *App* Route::app

## *App.Route* Route::route

## *String* Route::name

## *Schema* Route::schema

## *Any* Route::data

## *Any* Route::error

## *Function* Route::factory()

## *Function* Route::init()

## *Function* Route::getData([*Function* callback])

        getData: -> @data

## *Function* Route::destroy()

## *Function* Route::destroyJSON()

## *Function* Route::destroyText()

## *Function* Route::destroyHTML()

## *Networking.Uri* Route::redirect

Can be also a function. May returns a *Networking.Uri*, any String or `undefined`.

## *Networking.Request* Route::request

## *Networking.Response* Route::response

## *Function* Route::next()

        next: ->
            assert.ok pendingRoutes[@__hash__]
            destroyRoute @

## *Any* Route::toJSON()

        toJSON: ->
            if @response.status < 400
                @data?.toJSON?() or @data
            else
                @error.toJSON?() or @error

## *String* Route::toText()

        toText: ->
            if @response.status < 400
                @data + ''
            else
                @error + ''

## *Document* Route::toHTML()

        routeToString = ->
            "#{@method} #{@uri}"

        getDefaultRouteComponentName = ->
            path = "components/#{@name}.xhtml"
            if app.components[path]
                return path

        renderComponentFromConfig = (opts) ->
            componentName = opts?.component or
                getDefaultRouteComponentName.call(@) or
                'components/index.xhtml'
            tmplName = opts?.template or componentName
            useName = opts?.use or 'body'

            logTime = log.timer()
            if componentName isnt tmplName
                if tmpl = app.components[tmplName]
                    tmplComponent = Route.getTemplateComponent tmplName
                    tmplComponent.use useName, null
                else
                    log.warn """
                        Template component '#{tmplName}' can't be found \
                        for route '#{routeToString.call(@)}'
                    """
            if component = app.components[componentName]
                r = component.render null, @data
            else
                log.warn "Component '#{tmplName}' can't be found for route '#{routeToString.call(@)}'"
            if tmplComponent
                if r?
                    r = tmplComponent.use(useName, r)
                else
                    r = tmplComponent
                if tmplComponent.context.routes.has(useName)
                    tmplComponent.context.routes.pop useName
                tmplComponent.context.routes.set useName, @
                @_destroyComponentOnEnd = false
            else
                @_destroyComponentOnEnd = true
            logTime.ok "Component `#{componentName}` rendered"
            r

        createToHTMLFromObject = (opts) ->
            -> renderComponentFromConfig.call @, opts

        toHTML: createToHTMLFromObject
            component: ''
            template: ''
            use: ''
