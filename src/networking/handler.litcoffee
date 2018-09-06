# Handler

Represents a callback function called on the request.

Each handler must determine an uri, which is compared with the got request URI.

You should use `createHandler()` to create a functional handler.

Access it with:
```javascript
var Networking = require('networking');
var Handler = Networking.Handler;
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    log = require 'src/log'

    {parse, stringify} = JSON

    assert = assert.scope 'Networking.Handler'
    log = log.scope 'Networking', 'Handler'

    module.exports = (Networking) -> class Handler

## Handler::constructor(*Object* options)

        constructor: (opts) ->
            assert.isPlainObject opts, 'ctor options argument ...'
            assert.ok utils.has(Networking.Request.METHODS, opts.method), 'ctor options.method argument ...'
            assert.instanceOf opts.uri, Networking.Uri, 'ctor options.uri argument ...'
            assert.isFunction opts.callback, 'ctor options.callback argument ...'

            {@method, @uri, @callback} = opts

## *String* Handler::method

Describes which type of the request, this handler can handle.

        method: ''

## *Networking.Uri* Handler::uri

This property is compared with the request uri.

        uri: null

## *Function* Handler::callback

Function used to handle the request.

It's called with three parameters: *Networking.Request*, *Networking.Response* and
a *next* function.

If the *next* function is called, the next handler is checked.

        callback: null

## Handler::exec(*Networking.Request* request, *Networking.Response* response, *Function* next)

Executes the handler, that is:
 - compares the uri with the request,
 - calls the handler callback.

It's internally called by the `createRequest()`.

        exec: (req, res, next) ->
            assert.instanceOf req, Networking.Request, '::exec request argument ...'
            assert.instanceOf res, Networking.Response, '::exec response argument ...'
            assert.isFunction next, '::exec next argument ...'

            # compare methods
            if @method isnt req.method
                return next()

            # test uri
            unless @uri.test(req.uri.path)
                return next()

            params = req.params = @uri.match req.uri.path

            # on callback fail
            callbackNext = (err) =>
                req.handler = null
                if err? and err isnt true
                    errMsg = err
                    if errMsg.stack?
                        errMsg = err.stack
                    else if utils.isObject(errMsg)
                        errMsg = utils.tryFunction JSON.stringify, null, [errMsg], errMsg
                if errMsg
                    log.error "Error in '#{@uri}': #{errMsg}"
                    if err instanceof RangeError or
                       err instanceof TypeError or
                       err instanceof SyntaxError or
                       err instanceof ReferenceError
                        errMsg = "Internal Error; message has been removed"
                    next errMsg
                else
                    next()

            req.handler = @
            @callback req, res, callbackNext

            null

## *String* Handler::toString()

Returns a string describing the handler.

```javascript
"get /users/{name}"
```

        toString: ->
            "#{@method} #{@uri}"
