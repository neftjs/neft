Uri
===

	'use strict'

	[assert] = ['assert'].map require

*class* Uri
-----------

	module.exports = (Routing, impl) -> class Uri

### Static

#### SEPARATORS

Left and right characters used as separators for parameters.

		@SEPARATORS = ['{', '}']

#### *String[]* getChunks(*String*, *[Array]*)

Get separators and parameters names as one-deep array.

		@getChunks = (uri, target=[]) ->

			[SEPARATOR_LEFT, SEPARATOR_RIGHT] = Uri.SEPARATORS

			i = 0
			len = uri.length
			while i < len

				# get from previous index into left separator
				index = uri.indexOf SEPARATOR_LEFT, i
				unless ~index then index = len
				chunk = uri.substring i, index
				assert chunk
				target.push chunk
				i = index

				# get chunk between separators
				index = uri.indexOf SEPARATOR_RIGHT, i
				unless ~index then break
				chunk = uri.substring i + 1, index
				assert chunk
				target.push chunk
				i = index + 1

			target

### Constructor(*String*)

		constructor: (uri) ->

			assert uri and typeof uri is 'string'

			@_chunks = Uri.getChunks uri
			@params = {}

### Protected

#### *String[]* _chunks

		_chunks: null

### Properties

#### params

		params: null

### Methods

#### test(*String*)

Test whether *uri* is valid with *uri*.

		test: (uri) ->

			chunks = @_chunks

			# beginning
			if uri.indexOf(chunks[0]) isnt 0
				return false

			# end
			if chunks.length % 2 isnt 0
				last = chunks[chunks.length - 1]
				unless uri.indexOf(last) is uri.length - last.length
					return false

			# separators
			i = -1
			for chunk in chunks by 2
				index = uri.indexOf chunk, i
				unless ~index then return false
				i = index + chunk.length

			true

#### match(*String*)

Get parameters values from the passed string.

		match: (uri) ->

			assert @test uri

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

#### toString()

		toString: ->

			[SEPARATOR_LEFT, SEPARATOR_RIGHT] = Uri.SEPARATORS

			str = ''
			for chunk, i in @_chunks
				if i % 2 isnt 0
					chunk = "#{SEPARATOR_LEFT}#{chunk}#{SEPARATOR_RIGHT}"
				str += chunk

			str