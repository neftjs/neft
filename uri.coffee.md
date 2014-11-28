Routing.Uri
===========

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	Dict = require 'dict'

	module.exports = (Routing) -> class Uri

		@URI_TRIM_RE = ///^\/?(.*?)\/?$///
		@NAMES_RE = ///{([a-zA-Z0-9_$]+)}///g

*Uri* Uri(*String* uri)
-----------------------

		constructor: (uri) ->
			expect(uri).toBe.string()

			@params = {}

			# uri
			uri = Uri.URI_TRIM_RE.exec(uri)[1]
			utils.defineProperty @, '_uri', null, uri

			# names
			names = []
			while (exec = Uri.NAMES_RE.exec(uri))?
				names.push exec[1]
				@params[exec[1]] = null
			utils.defineProperty @, '_names', null, names

			# re
			re = uri
			re = re.replace ///\*///g, ->
				"(.*?)"
			re = re.replace ///\/([^/]*)///g, (_, str) ->
				"(?:/#{str})?"
			re = re.replace Uri.NAMES_RE, ->
				"([^/]*?)"
			re = new RegExp "^\/?#{re}\/?$"
			utils.defineProperty @, '_re', null, re

			Object.freeze @
			Object.preventExtensions @params

*Object* Uri::params
--------------------

		params: null

*Boolean* Uri::test(*String* uri)
---------------------------------

Test whether `Routing.Uri` is valid with given *uri* string.

		test: (uri) ->
			@_re.test uri

*Object* Uri::match(*String* uri)
---------------------------------

Get parameters values from the passed string.

		match: (uri) ->
			expect(@test uri).toBe.truthy()

			exec = @_re.exec uri
			for name, i in @_names
				val = exec[i+1]
				if val is undefined
					val = null
				@params[name] = val

			@params

*String* Uri::toString()
------------------------

Parse `Uri` into string.

`params` object can be optionally passed as an argument.
It will be used to replace uri chunks (works like standard
string `format()` but on the named parameters).

		toString: (params) ->
			unless utils.isObject params
				return @_uri

			if params instanceof Dict
				params = params._data

			i = 0
			@_uri.replace Uri.NAMES_RE, =>
				params[@_names[i++]]
