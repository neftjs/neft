    `// when=NEFT_NODE`

# Standard routes

    'use strict'

    utils = require 'src/utils'
    log = require 'src/log'
    fs = require 'fs'
    pathUtils = require 'path'

    Dict = require 'src/dict'
    Document = require 'src/document'
    Networking = require 'src/networking'

    log = log.scope 'App', 'Bootstrap'

    VIEW_HTML = '''
    <!doctype html>
    <html>
    <head>
        <meta charset="utf-8" />
        <title>${context.title}</title>
        <script type="text/javascript" src="${context.neftFilePath}"></script>
        <script type="text/javascript" src="${context.appFilePath}"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    </head>
    <body>
        <noscript>
            <meta http-equiv="refresh" content="0; url=${context.appTextModeUrl}"></meta>
        </noscript>
    </body>
    </html>
    '''

    module.exports = (app) ->
        APP_JS_URI = '/app.js'
        NEFT_JS_URI = '/neft.js'
        JS_NEFT_HTML_FILE_PATH = './build/neft-html-release.js'
        JS_NEFT_WEBGL_FILE_PATH = './build/neft-webgl-release.js'
        JS_HTML_BUNDLE_FILE_PATH = './build/app-html-release.js'
        JS_WEBGL_BUNDLE_FILE_PATH = './build/app-webgl-release.js'
        VIEW_NAME = '_app_bootstrap'
        TEXT_MODE_URI_PREFIX = '/neft-type=text'
        TYPE_COOKIE_NAME = 'neft-type'

        `//<development>`
        JS_NEFT_HTML_FILE_PATH = './build/neft-html-develop.js'
        JS_NEFT_WEBGL_FILE_PATH = './build/neft-webgl-develop.js'
        JS_HTML_BUNDLE_FILE_PATH = './build/app-html-develop.js'
        JS_WEBGL_BUNDLE_FILE_PATH = './build/app-webgl-develop.js'
        `//</development>`

        view = Document.fromHTML VIEW_NAME, VIEW_HTML
        Document.parse view

        reservedUris = ['app.js', 'favicon.ico', 'static']
        reservedUrisRe = do ->
            re = ''
            re += "#{utils.addSlashes(uri)}|" for uri in reservedUris
            re = re.slice 0, -1
            new RegExp "^(?:#{re})"

        getType = (req) ->
            {cookie} = req.headers
            if cookie and cookie.indexOf(TYPE_COOKIE_NAME) isnt -1
                ///neft\-type=([a-z]+)///.exec(cookie)[1]
            else
                app.config.type

## app.js

Returns the application javascript file.

        `//<production>`
        appFile = appWebglFile = ''
        loadAppFiles = ->
            try appFile = fs.readFileSync JS_HTML_BUNDLE_FILE_PATH, 'utf-8'
            try appWebglFile = fs.readFileSync JS_WEBGL_BUNDLE_FILE_PATH, 'utf-8'
        `//</production>`
        new app.Route
            uri: APP_JS_URI
            getData: (callback) ->
                isGameType = getType(@request) is 'game'

                `//<development>`
                if isGameType
                    fs.readFile JS_WEBGL_BUNDLE_FILE_PATH, 'utf-8', callback
                else
                    fs.readFile JS_HTML_BUNDLE_FILE_PATH, 'utf-8', callback
                `//</development>`
                `//<production>`
                if not appWebglFile or not appFile
                    loadAppFiles()
                if isGameType
                    callback null, appWebglFile
                else
                    callback null, appFile
                `//</production>`

## neft.js

Returns the neft javascript file.

        `//<production>`
        try neftFile = fs.readFileSync JS_NEFT_HTML_FILE_PATH, 'utf-8'
        try neftGameFile = fs.readFileSync JS_NEFT_WEBGL_FILE_PATH, 'utf-8'
        `//</production>`
        new app.Route
            uri: NEFT_JS_URI
            getData: (callback) ->
                isGameType = getType(@request) is 'game'

                `//<development>`
                if isGameType
                    fs.readFile JS_NEFT_WEBGL_FILE_PATH, 'utf-8', callback
                else
                    fs.readFile JS_NEFT_HTML_FILE_PATH, 'utf-8', callback
                `//</development>`
                `//<production>`
                if isGameType
                    callback null, neftGameFile
                else
                    callback null, neftFile
                `//</production>`

## favicon.ico

Returns 'static/favicon.ico' file.

        new app.Route
            uri: 'favicon.ico'
            redirect: 'static/favicon.ico'

## static/{path*}

Returns any file from the static/ folder.

## neft-type={type}/*

URI used by the browser which doesn't support javascript - in such case always
full HTML document is returned (like for the searching robots).

You can use this route in a browser to check whether your HTML document is proper.
Clean your cookies when you finish.

```html
<a href="/neft-type=app/">Use CSS renderer</a>
<a href="/neft-type=game/">Use WebGL renderer</a>
<a href="/neft-type=text/">Use text type (robots)</a>
```

        new app.Route
            uri: 'neft-type={type}{rest*}'
            getData: (callback) ->
                req = @request
                res = @response
                res.setHeader 'Set-Cookie', "#{TYPE_COOKIE_NAME}=#{req.params.type}; path=/;"
                res.redirect "#{app.networking.url}#{req.params.rest}"

## Default route

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or the HTML scaffolding which will run **neft.io** on the client side.

        new app.Route
            uri: '*'
            getData: (callback) ->
                req = @request

                # text mode
                if getType(req) is 'text' or req.headers['x-expected-type']
                    return @next()

                userAgent = req.headers['user-agent'] or ''

                if req.type isnt Networking.Request.HTML_TYPE or # omit types other than html
                   reservedUrisRe.test(req.uri) or # omit reserved URIs
                   utils.has(userAgent, 'bot') or # omit Googlebot, msnbot etc.
                   utils.has(userAgent, 'Baiduspider') or # omit baidu bot
                   utils.has(userAgent, 'facebook') or # omit facebook bot
                   utils.has(userAgent, 'Links') # omit links text browser
                    return @next()

                callback null

            destroyHTML: ->
                @response.data.destroy()

            toHTML: ->
                view.render null,
                    title: app.config.title
                    appTextModeUrl: TEXT_MODE_URI_PREFIX + @request.uri
                    neftFilePath: NEFT_JS_URI
                    appFilePath: APP_JS_URI
