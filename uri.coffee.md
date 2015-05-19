Uri
===

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	Dict = require 'dict'

	assert = assert.scope 'Networking.Uri'

	module.exports = (Networking) -> class Uri

		@URI_TRIM_RE = ///^\/?(.*?)\/?$///
		@NAMES_RE = ///{([a-zA-Z0-9_$]+)\*?}///g

*Uri* Uri(*String* uri)
-----------------------

This class represents a uri string with parameters.

The parameter must be wrapped by the curly brackets **{…}**.

**Rest parameters** are not greedy and are wrapped by **{…*}** or just **…***.
Rest parameters don't have to be named (**{*}** is allowed).

```
var uri = new Networking.Uri('articles/{pageStart}/{pageEnd}');
console.log(uri.match('articles/2'));
// { pageStart: '2', pageEnd: null }
console.log(uri.match('articles/2/4'));
// { pageStart: '2', pageEnd: '4' }

var uri = new Networking.Uri('comments/{path*}/{page}');
console.log(uri.match('comments/article/world/test-article/4'));
// { path: 'article/world/test-article', page: '4' }
```

Access it with:
```
var Networking = require('networking');
var Uri = Networking.Uri;
```

		constructor: (uri) ->
			assert.isString uri, 'ctor uri argument ...'

			@params = {}

			# uri
			uri = Uri.URI_TRIM_RE.exec(uri)[1]
			utils.defineProperty @, '_uri', null, "/#{uri}"

			# names
			names = []
			while (exec = Uri.NAMES_RE.exec(uri))?
				names.push exec[1]
				@params[exec[1]] = null
			utils.defineProperty @, '_names', null, names

			# re
			re = uri
			re = re.replace /(\?)/g, '\\$1'
			re = re.replace ///{?([a-zA-Z0-9_$]+)?\*}?///g, ->
				"(.*?)"
			# re = re.replace ///\/([^/]*)///g, (_, str) ->
			# 	"(?:/#{str})?"
			re = re.replace Uri.NAMES_RE, ->
				"([^/]*?)"
			re = new RegExp "^\/?#{re}\/?$"
			utils.defineProperty @, '_re', null, re

			Object.freeze @
			Object.preventExtensions @params

*Object* Uri::params = {}
-------------------------

This property holds last *Uri::match()* result.

		params: null

*Boolean* Uri::test(*String* uri)
---------------------------------

Use this method to test whether a uri is valid with the given string.

		test: (uri) ->
			@_re.test uri

*Object* Uri::match(*String* uri)
---------------------------------

This method returns parameters from the given string.

If the given uri is not valid with a uri, error will be raised.
In such case, you should use the *Uri::test()* method before.

		match: (uri) ->
			assert.ok @test(uri)

			exec = @_re.exec uri
			for name, i in @_names
				val = exec[i+1]
				if val is undefined
					val = null
				@params[name] = decodeURI val

			@params

*String* Uri::toString([*Object|Dict* params])
----------------------------------------------

This method parses a uri into a string.

The given *params* object is used to replace the uri parameters.

```
var uri = new Networking.Uri('user/{name}');

console.log(uri.toString({name: 'Jane'}));
// /user/Jane

console.log(uri.toString());
// /user/{name}
```

		toString: (params) ->
			if params?
				assert.isObject params, 'toString() params argument ...'
			else
				return @_uri

			if params instanceof Dict
				params = params._data

			i = 0
			@_uri.replace Uri.NAMES_RE, =>
				encodeURI params[@_names[i++]]
