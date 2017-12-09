# App

    'use strict'

    utils = require 'src/utils'
    log = require 'src/log'
    signal = require 'src/signal'
    db = require 'src/db'
    assert = require 'src/assert'
    Schema = require 'src/schema'
    Networking = require 'src/networking'
    Document = require 'src/document'
    Renderer = require 'src/renderer'
    Styles = require 'src/styles'
    Resources = require 'src/resources'
    Dict = require 'src/dict'

    AppRoute = require './route'

    bootstrapRoute = try require './bootstrap/route.node'

    `//<development>`
    pkg = require 'package.json'
    `//</development>`

    BASE_FILE_NAME_RE = /(.+)\.(?:node|server|client|browser|ios|android|native)/
    DEFAULT_CONFIG =
        title: 'Neft.io Application'
        protocol: 'http'
        port: 3000
        host: 'localhost'
        language: 'en'
        type: 'app'

    exports = module.exports = (opts = {}, extraOpts = {}) ->
        null
        `//<development>`
        log.ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"
        log.warn "Use this bundle only in development; type --release when it's ready"
        `//</development>`

        config = utils.clone DEFAULT_CONFIG
        config = utils.mergeAll config, opts.config, extraOpts

        app = new Dict

## *Object* app.config = `{}`

Config object from the *package.json* file.

Can be overriden in the *init.js* file.

### type

The `app` type (the default one) uses renderer on the client side.

The `game` type uses special renderer (if exists) focused on more performance goals.

The `text` type always return HTML document with no renderer on the client side.
It's used for the crawlers (e.g. GoogleBot) or browsers with no javascript support.

```javascript
// package.json
{
    "name": "neft.io app",
    "version": "0.1.0",
    "config": {
        "title": "My first application!",
        "protocol": "http",
        "port": 3000,
        "host": "localhost",
        "language": "en",
        "type": "app"
    }
}
// init.js
module.exports = function(NeftApp) {
    var app = NeftApp({ title: "Overridden title" });
    console.log(app.config);
    // {title: "My first application!", protocol: "http", port: ....}
};
```

        app.config = config

## *Networking* app.networking

Standard Networking instance used to communicate
with the server and to create local requests.

All routes created by the *App.Route* uses this networking.

HTTP protocol is used by default with the data specified in the *package.json*.

        app.networking = new Networking
            type: Networking.HTTP
            protocol: config.protocol
            port: parseInt(config.port, 10)
            host: config.host
            url: config.url
            language: config.language

## *Object* app.routes = `{}`

Files from the *routes* folder with objects returned by their exported functions.

        app.routes = {}

## *Object* app.styles = `{}`

Files from the *styles* folder as *Function*s
ready to create new *Item*s.

        app.styles = {}

## *Object* app.components = `{}`

Files from the *components* folder as the *Document* instances.

        app.components = {}

## *Resources* app.resources

        app.resources = do ->
            if opts.resources
                Resources.fromJSON(opts.resources)
            else
                new Resources

## *Signal* app.onReady()

Called when all modules, components, styled etc. have been loaded.

        signal.create app, 'onReady'

        # config.type
        config.type ?= 'app'
        assert.ok utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game/text, but '#{config.type}' got."

        app.Route = AppRoute app

## *Dict* app.cookies

On the client side, this object refers to the last received cookies
from the networking request.

On the server side, this cookies object are added into the each networking response.

By default, client has *clientId* and *sessionId* hashes.

```javascript
app.cookies.onChange(function(key){
    console.log('cookie changed', key, this[key]);
});
```

```xml
<h1>Your clientId</h1>
<em>${context.app.cookies.clientId}</em>
```

        # cookies
        COOKIES_KEY = '__neft_cookies'
        IS_CLIENT = not process.env.NEFT_SERVER
        app.cookies = Dict()
        onCookiesReady = (dict) ->
            app.cookies = dict
            if IS_CLIENT
                dict.set 'sessionId', utils.uid(16)
        db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
            if dict
                onCookiesReady dict
            else
                if IS_CLIENT
                    cookies = {clientId: utils.uid(16)}
                else
                    cookies = {}
                db.set COOKIES_KEY, cookies, (err) ->
                    db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
                        if dict
                            onCookiesReady dict
        app.networking.onRequest (req, res) ->
            if IS_CLIENT
                utils.merge req.cookies, app.cookies
            else
                utils.merge res.cookies, app.cookies
            req.onLoadEnd.listeners.unshift ->
                if IS_CLIENT
                    for key, val of res.cookies
                        unless utils.isEqual(app.cookies[key], val)
                            app.cookies.set key, val
                return
            , null
            return

        # propagate data
        Renderer.setResources app.resources
        Renderer.setServerUrl app.networking.url
        Renderer.onLinkUri (uri) ->
            app.networking.createLocalRequest
                method: Networking.Request.GET
                type: Networking.Request.HTML_TYPE
                uri: uri
        app.documentScripts = utils.arrayToObject opts.scripts,
            (index, elem) -> elem.name,
            (index, elem) -> elem.file
        Document.Scripts.initialize app.documentScripts

        # set styles window item
        if opts.styles?
            for style in opts.styles
                if style.name is '__windowItem__'
                    style.file._init windowItem: null
                    windowStyle = style.file._main document: null
                    break

        app.windowItem = windowStyleItem = windowStyle?.item
        assert.ok windowStyleItem, '__windowItem__ style must be defined'
        Renderer.setWindowItem windowStyleItem

        if opts.styles?
            stylesInitObject =
                windowItem: windowStyleItem

            # initialize styles
            for style in opts.styles when style.name?
                if style.name isnt '__windowItem__'
                    style.file._init stylesInitObject
                app.styles[style.name] = style.file

        # load styles
        Styles
            windowStyle: windowStyle
            styles: app.styles
            queries: opts.styleQueries
            resources: app.resources

        # load bootstrap
        bootstrapRoute? app

        # loading files helper
        init = (files, target) ->
            for file in files when file.name?
                if typeof file.file isnt 'function'
                    continue

                fileObj = file.file app
                target[file.name] = fileObj

                if baseNameMatch = BASE_FILE_NAME_RE.exec(file.name)
                    [_, baseName] = baseNameMatch
                    if target[baseName]?
                        if utils.isPlainObject(target[baseName]) and utils.isPlainObject(fileObj)
                            fileObj = utils.merge Object.create(target[baseName]), fileObj
                    target[baseName] = fileObj

            return

        # load app extensions
        if utils.isObject(opts.extensions)
            for ext in opts.extensions
                ext app

        # exports app classes
        exports.app =
            Route: app.Route

        # load components
        for component in opts.components when component.name?
            app.components[component.name] = Document.fromJSON component.file

        # load files
        init opts.routes, app.routes

        for path, obj of app.routes
            r = {}
            if utils.isObject(obj) and not (obj instanceof app.Route)
                for method, opts of obj
                    if utils.isObject(opts)
                        route = new app.Route method, opts
                        r[route.name] = route
                    else
                        r[method] = opts
            app.routes[path] = r

        # provide default index route
        unless app.routes.index
            app.routes.index = new app.Route 'get /', {}

        # emit ready signal
        app.onReady.emit()

        app
