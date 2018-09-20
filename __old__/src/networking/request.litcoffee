# Request

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'

    assert = assert.scope 'Networking.Request'

    module.exports = (Networking, Impl) -> class Request extends signal.Emitter

## *Array* Request.METHODS

Contains available *HTTP* methods.

Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

        @METHODS = [
            (@GET = 'get'),
            (@POST = 'post'),
            (@PUT = 'put'),
            (@DELETE = 'delete'),
            (@OPTIONS = 'options')
        ]

## *Array* Request.TYPES

Contains available expected types.

Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.

        @TYPES = [
            (@TEXT_TYPE = 'text'),
            (@JSON_TYPE = 'json'),
            (@HTML_TYPE = 'html'),
            (@BINARY_TYPE = 'binary')
        ]

## Request::constructor(*Object* options)

Class used to describe coming networking request.

You should use `createRequest()` to create a full request.

Access it with:
```javascript
var Networking = require('networking');
var Request = Networking.Request;
```

        constructor: (opts) ->
            assert.isPlainObject opts, 'ctor options argument ...'
            assert.isString opts.uid if opts.uid?
            assert.ok utils.has(Request.METHODS, opts.method) if opts.method?
            unless opts.uri instanceof Networking.Uri
                assert.isString opts.uri, 'ctor options.uri argument ...'

            super()

            if opts.type?
                assert.ok utils.has(Request.TYPES, opts.type), 'ctor options.type argument ...'
                {@type} = opts
            utils.defineProperty @, 'type', utils.ENUMERABLE, @type

            {@data, @headers, @cookies} = opts
            {@method} = opts if opts.method?
            @headers ||= {}
            @cookies ||= {}

            if typeof opts.uri is 'string'
                @uri = new Networking.Uri opts.uri
            else
                {@uri} = opts

            uid = opts.uid or utils.uid()
            utils.defineProperty @, 'uid', null, uid

            @pending = true
            @params = null

            # signal handlers
            if opts.onLoadEnd
                @onLoadEnd opts.onLoadEnd

## *Signal* Request::onLoadEnd(*Any* error, *Any* data)

        signal.Emitter.createSignal @, 'onLoadEnd'

## ReadOnly *String* Request::uid

Pseudo unique hash. It's created automatically.

        uid: ''

## ReadOnly *Boolean* Request::pending

Indicates whether the request is not destroyed.

If it's `false`, the request can't be changed.

        pending: false

## *String* Request::method

This property refers to one of the `Request.METHODS` values.

Holds a method with which the request has been called.

        method: Request.GET

## *Networking.Uri* Request::uri

Refers to the request URI path.

It can holds local and absolute paths.

```javascript
// for request sent to the server ...
"http://server.domain/auth/user"

// for got request on the server ...
"http://server.domain/auth/user"

// for local requests ...
"/user/user_id"
```

        uri: null

## *String* Request::type

Describes the expected response type.

It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.

It refers to one of the *Request.TYPES* values.

        type: @JSON_TYPE

## *Object* Request::data = `null`

Holds a data sent with a request.
It can be, for instance, a form data.

        data: null

## ReadOnly *Networking.Handler* Request::handler

Refers to the currently considered [Handler][networking/Handler].

        handler: null

## ReadOnly *Networking.Response* Request::response

        response: null

## ReadOnly *Object* Request::params = `{}`

Keeps matched parameters by the handler from the request uri.

Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.

        params: null

## ReadOnly *Object* Request::headers

Contains request headers.

For the client request, this object is empty.

        headers: null

## ReadOnly *Object* Request::cookies

        cookies: null

## *String* Request::toString()

Returns a string describing the request.

It contains a method, uri and a type.

```javascript
console.log(req.toString);
// get /users/id as json
```

        toString: ->
            "#{@method} #{@uri} as #{@type}"

        toJSON: ->
            type: @type
            data: @data
            method: @method
            headers: @headers
            cookies: @cookies
            uri: @uri

        destroy: ->
            assert @pending

            @pending = false

            res = @response
            if res.isSucceed()
                @onLoadEnd.emit null, res.data
            else
                @onLoadEnd.emit res.data or res.status or "Unknown error"
            return
