App @framework
==============

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
    Resources = require 'src/resources'
    Dict = require 'src/dict'

    AppRoute = require './route'

    if utils.isNode
        bootstrapRoute = require './bootstrap/route.node'

    `//<development>`
    pkg = require 'package.json'
    `//</development>`

    BASE_FILE_NAME_RE = /(.+)\.(?:node|server|client|browser|ios|android|native)/
    DEFAULT_CONFIG =
        title: "Neft.io Application"
        protocol: "http"
        port: 3000
        host: "localhost"
        language: "en"
        type: "app"

    exports = module.exports = (opts={}, extraOpts={}) ->
        # Welcome log also for release mode
        log.ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"

        `//<development>`
        log.warn "Use this bundle only in development; type --release when it's ready"
        `//</development>`

        config = utils.merge utils.clone(DEFAULT_CONFIG), opts.config

        if extraOpts?
            utils.merge config, extraOpts

*Dict* app
----------

        app = new Dict

*Object* app.config = {}
------------------------

Config object from the *package.json* file.

Can be overriden in the *init.js* file.

### type

The `app` type (the default one) uses renderer on the client side.

The `game` type uses special renderer (if exists) focused on more performance goals.

The `text` type always return HTML document with no renderer on the client side.
It's used for the crawlers (e.g. GoogleBot) or browsers with no javascript support.

```javascript
`// package.json
`{
`   "name": "neft.io app",
`   "version": "0.1.0",
`   "config": {
`       "title": "My first application!",
`       "protocol": "http",
`       "port": 3000,
`       "host": "localhost",
`       "language": "en",
`       "type": "app"
`   }
`}
`
`// init.js
`module.exports = function(NeftApp){
`   var app = NeftApp({ title: "Overridden title" });
`   console.log(app.config);
`   // {title: "My first application!", protocol: "http", port: ....}
`};
```

        app.config = config

*Networking* app.networking
---------------------------

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

*Object* app.models = {}
------------------------

Files from the *models* folder with objects returned by their exported functions.

```javascript
`// models/user/permission.js
`module.exports = function(app){
`   return {
`       getPermission: function(id){}
`   };
`};
`
`// controllers/user.js
`module.exports = function(app){
`   return {
`       get: function(req, res, callback){
`           var data = app.models['user/permission'].getPermission(req.params.userId);
`           callback(null, data);
`       }
`   }
`};
```

        app.models = {}

*Object* app.routes = {}
------------------------

Files from the *routes* folder with objects returned by their exported functions.

        app.routes = {}

*Object* app.styles = {}
------------------------

Files from the *styles* folder as *Function*s
ready to create new [Renderer.Item][renderer/Item]s.

        app.styles = {}

*Object* app.views = {}
-----------------------

Files from the *views* folder as the [Document][document/File] instances.

        app.views = {}

*Resources* app.resources
-------------------------

        app.resources = if opts.resources then Resources.fromJSON(opts.resources) else new Resources

*Signal* app.onReady()
----------------------

Called when all modules, views, styled etc. have been loaded.

        signal.create app, 'onReady'

        # config.type
        config.type ?= 'app'
        assert.ok utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game/text, but '#{config.type}' got."

        app.Route = AppRoute app

*Dict* app.cookies
------------------

On the client side, this object refers to the last received cookies
from the networking request.

On the server side, this cookies object are added into the each networking response.

By default, client has *clientId* and *sessionId* hashes.

```javascript
`app.cookies.onChange(function(key){
`   console.log('cookie changed', key, this[key]);
`});
```

```xml
<h1>Your clientId</h1>
<em>${app.cookies.clientId}</em>
```

        # cookies
        COOKIES_KEY = '__neft_cookies'
        app.cookies = null
        onCookiesReady = (dict) ->
            app.cookies = dict
            if utils.isClient
                dict.set 'sessionId', utils.uid(16)
        db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
            if dict
                onCookiesReady dict
            else
                if utils.isClient
                    cookies = {clientId: utils.uid(16)}
                else
                    cookies = {}
                db.set COOKIES_KEY, cookies, (err) ->
                    db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
                        onCookiesReady dict
        app.networking.onRequest (req, res) ->
            if utils.isClient
                utils.merge req.cookies, app.cookies
            else
                utils.merge res.cookies, app.cookies
            req.onLoadEnd.listeners.unshift ->
                if utils.isClient
                    for key, val of res.cookies
                        unless utils.isEqual(app.cookies[key], val)
                            app.cookies.set key, val
                return
            , null
            return

        # propagate data
        Renderer.resources = app.resources
        Renderer.serverUrl = app.networking.url
        Document.Scripts.scriptFiles = opts.modules

        # set styles window item
        if opts.styles?
            for style in opts.styles
                if style.name is 'view'
                    style.file._init app: app, view: null
                    windowStyle = style.file._main.getComponent()
                    break

        windowStyleItem = windowStyle?.item or new Renderer.Item
        Renderer.window = windowStyleItem

        if opts.styles?
            stylesInitObject =
                app: app
                view: windowStyleItem

            # initialize styles
            for style in opts.styles when style.name?
                if style.name isnt 'view'
                    style.file._init stylesInitObject
                app.styles[style.name] = style.file

        # load styles
        require('styles')
            windowStyle: windowStyle
            styles: app.styles
            queries: opts.styleQueries
            resources: app.resources

        # load bootstrap
        if utils.isNode
            bootstrapRoute app

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

        setImmediate ->
            # load views
            for view in opts.views when view.name?
                app.views[view.name] = Document.fromJSON view.file

            init opts.models, app.models
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

            app.onReady.emit()

        # load document extensions
        if utils.isObject(opts.extensions)
            for ext in opts.extensions
                ext app: app

        # exports app classes
        exports.app =
            Route: app.Route

        app
