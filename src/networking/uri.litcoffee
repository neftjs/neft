# Uri

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    Dict = require 'src/dict'

    {isArray} = Array

    assert = assert.scope 'Networking.Uri'

    QUERY_SEPARATOR = '&'
    QUERY_ASSIGNMENT = '='

    parseQuery = (query) ->
        result = {}
        arr = query.split QUERY_SEPARATOR

        for param in arr
            assignmentIndex = param.indexOf QUERY_ASSIGNMENT
            if assignmentIndex isnt -1
                name = param.slice 0, assignmentIndex
                val = param.slice assignmentIndex+1
            else
                name = param
                val = ''

            resultVal = result[name]
            if resultVal is undefined
                result[name] = val
            else if isArray(resultVal)
                resultVal.push val
            else
                result[name] = [resultVal, val]

        result

# **Class** Uri

    module.exports = (Networking) -> class Uri
        @URI_TRIM_RE = ///^\/?(.*?)\/?$///
        @NAMES_RE = ///{([a-zA-Z0-9_$]+)\*?}///g

## Uri::constructor(*String* uri)

Represents an uri string with parameters.

The parameter must be wrapped by the curly brackets **{…}**.

**Rest parameters** are not greedy and are wrapped by the **{…*}** or just **…***.
Rest parameters don't have to be named (**{*}** is allowed).

```javascript
var uri = new Networking.Uri('articles/{pageStart}/{pageEnd}');
console.log(uri.match('articles/2/4'));
// { pageStart: '2', pageEnd: '4' }

var uri = new Networking.Uri('comments/{path*}/{page}');
console.log(uri.match('comments/article/world/test-article/4'));
// { path: 'article/world/test-article', page: '4' }
```

Access it with:
```javascript
var Networking = require('networking');
var Uri = Networking.Uri;
```

        constructor: (uri) ->
            assert.isString uri, 'ctor uri argument ...'

            # uri
            uri = uri.trim()
            utils.defineProperty @, '_uri', null, uri
            uri = Uri.URI_TRIM_RE.exec(uri)[1]

            if Uri.NAMES_RE.test(uri) or uri.indexOf('*') isnt -1
                Uri.NAMES_RE.lastIndex = 0

                # params
                @params = {}
                names = []
                while (exec = Uri.NAMES_RE.exec(uri))?
                    names.push exec[1]
                    @params[exec[1]] = null

                Object.preventExtensions @params

                # re
                re = uri
                re = re.replace /(\?)/g, '\\$1'
                re = re.replace ///{?([a-zA-Z0-9_$]+)?\*}?///g, "(.*?)"
                re = re.replace Uri.NAMES_RE, "([^/]+)"
                re = new RegExp "^\/?#{re}\/?$"
            else
                @params = null
                names = null
                re = uri
                re = re.replace /(\?)/g, '\\$1'
                re = new RegExp "^\/?#{re}\/?$"

            utils.defineProperty @, '_names', null, names
            utils.defineProperty @, '_re', null, re

            # hash
            hashIndex = uri.lastIndexOf '#'
            if hashIndex isnt -1
                @hash = uri.slice hashIndex+1
                uri = uri.slice 0, hashIndex
            else
                @hash = ''

            # query
            searchIndex = uri.indexOf '?'
            if searchIndex isnt -1
                queryString = uri.slice searchIndex+1
                uri = uri.slice 0, searchIndex
                @query = parseQuery queryString
            else
                @query = {}

            # protocol
            protocolIndex = uri.indexOf ':'
            if protocolIndex isnt -1 and uri.slice(0, protocolIndex).indexOf('/') is -1
                @protocol = uri.slice 0, protocolIndex
                uri = uri.slice protocolIndex+1
                while uri[0] is '/'
                    uri = uri.slice 1
            else
                @protocol = ''

            # auth
            authIndex = uri.indexOf '@'
            if authIndex isnt -1 and uri.slice(0, authIndex).indexOf('/') is -1
                @auth = uri.slice 0, authIndex
                uri = uri.slice authIndex+1
            else
                @auth = ''

            # host
            hostIndex = uri.indexOf '/'
            if hostIndex isnt -1 and uri.slice(0, hostIndex).indexOf('.') isnt -1
                @host = uri.slice 0, hostIndex
                uri = uri.slice hostIndex+1
            else
                @host = ''

            # path
            @path = "/#{uri}"

            Object.seal @

## *String* Uri::protocol

## *String* Uri::auth

## *String* Uri::host

## *String* Uri::path

## *Object* Uri::params

Holds the last *Uri::match()* result.

## *Object* Uri::query

## *String* Uri::hash

## *Boolean* Uri::test(*String* uri)

Test whether the uri is valid with the given string.

        test: (uri) ->
            @_re.test uri

## *Object* Uri::match(*String* uri)

Returns found parameters from the given string.

If the given uri is not valid with the uri, error will be raised.

        match: (uri) ->
            assert.ok @test(uri)

            if @_names?
                exec = @_re.exec uri
                for name, i in @_names
                    val = exec[i+1]
                    if val is undefined
                        val = null
                    @params[name] = decodeURI val
            else
                @params ?= {}

            @params

## *String* Uri::toString([*Object|Dict* params])

Parses the uri into a string.

The given params object is used to replace the uri parameters.

```javascript
var uri = new Networking.Uri('user/{name}');

console.log(uri.toString({name: 'Jane'}));
// /user/Jane

console.log(uri.toString());
// /user/{name}
```

        toString: (params) ->
            if params? and @_re?
                assert.isObject params, 'toString() params argument ...'
            else
                return @_uri

            i = 0
            @_uri.replace Uri.NAMES_RE, =>
                encodeURI params[@_names[i++]]

# Glossary

- [Networking.Uri](#class-uri)
