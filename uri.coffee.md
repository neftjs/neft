Routing.Uri
===========

	'use strict'

	expect = require 'expect'
	Dict = require 'dict'

	module.exports = (Routing) -> class Uri

		@SEPARATORS = ['{', '}']

		@getChunks = (uri, target=[]) ->
			[SEPARATOR_LEFT, SEPARATOR_RIGHT] = Uri.SEPARATORS

			i = 0
			len = uri.length
			while i < len

				# get from previous index into left separator
				index = uri.indexOf SEPARATOR_LEFT, i
				unless ~index then index = len
				chunk = uri.substring i, index
				expect(chunk).toBe.truthy()
				target.push chunk
				i = index

				# get chunk between separators
				index = uri.indexOf SEPARATOR_RIGHT, i
				unless ~index then break
				chunk = uri.substring i + 1, index
				expect(chunk).toBe.truthy()
				target.push chunk
				i = index + 1

			target

*Uri* Uri(*String* uri)
-----------------------

		constructor: (uri) ->
			expect(uri).toBe.string()

			@_chunks = Uri.getChunks uri
			@params = {}

*Object* Uri::params
--------------------

		params: null

*Boolean* Uri::test(*String* uri)
---------------------------------

Test whether `Routing.Uri` is valid with given *uri* string.

		test: (uri) ->
			chunks = @_chunks

			# on empty uri
			if not uri and not chunks.length
				return true

			# beginning
			if uri.indexOf(chunks[0]) isnt 0 and chunks[0] isnt '*'
				return false

			# end
			if chunks.length % 2 isnt 0
				last = chunks[chunks.length - 1]
				if uri.indexOf(last) isnt uri.length - last.length and last isnt '*'
					return false

			# separators
			i = -1
			for chunk in chunks by 2
				index = uri.indexOf chunk, i
				if not ~index and chunk isnt '*'
					return false
				i = index + chunk.length

			true

*Object* Uri::match(*String* uri)
---------------------------------

Get parameters values from the passed string.

		match: (uri) ->
			expect(@test uri).toBe.truthy()

			chunks = @_chunks

			# get indexes of separators (left, right sides)
			i = -1
			indexes = []
			for chunk in chunks by 2
				indexes.push index = uri.indexOf chunk, ++i
				indexes.push i = index + chunk.length

			indexes.shift()
			indexes.push uri.length

			# get params
			{params} = @

			for index, i in indexes by 2
				left = index
				right = indexes[++i]

				key = chunks[i]
				unless key then break

				params[key] = uri.substring left, right

				if left is right then continue

			params

*String* Uri::toString()
------------------------

Parse `Uri` into string.

`params` object can be optionally passed as an argument.
It will be used to replace uri chunks (works like standard
string `format()` but on the named parameters).

		toString: (params) ->
			# TODO: use some optimized bridge here
			if params and not (params instanceof Dict)
				params = Dict params

			[SEPARATOR_LEFT, SEPARATOR_RIGHT] = Uri.SEPARATORS

			str = ''

			for chunk, i in @_chunks
				if i % 2 isnt 0
					chunk = if params and params.get(chunk) isnt undefined
							params.get chunk
						else
							"#{SEPARATOR_LEFT}#{chunk}#{SEPARATOR_RIGHT}"

				str += chunk

			str
