'use strict'

[assert, utils, coffee] = ['assert', 'utils', 'coffee-script'].map require

module.exports = (File) -> class Input

	RE = @RE = new RegExp '([^#]*)#{([^}]*)}([^#]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^[a-z][a-z0-9]*)|(?:\[)([a-z][a-z0-9]*)(?:\])///gi

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @

	constructor: (@node, text) ->

		assert node instanceof File.Element
		assert text and typeof text is 'string'

		# build toString
		func = ''
		get = @get
		RE.lastIndex = 0
		while (match = RE.exec text) isnt null

			# parse prop
			prop = match[2].replace VAR_RE, (_, elem1, elem2, index) ->
				str = "get(storages, '#{escape(elem1 or elem2)}')"
				if index then str = "[#{str}]"
				str

			# add into func string
			if match[1] then func += "'#{utils.addSlashes match[1]}' + "
			func += "#{prop} + "
			if match[3] then func += "'#{utils.addSlashes match[3]}' + "

		func = 'return ' + func.slice 0, -3
		func = coffee.compile func, bare: true
		eval "func = function(storages){ #{func} }"
		this.toString = -> try func.apply null, arguments

	node: null

	get: (storages, prop) ->

		for storage in storages when storage

			# from attr
			if storage instanceof File.Element.modules.Attrs
				if r = storage.get prop
					return r

			# from object
			if r = storage[prop]
				return r

	parse: ->

	toString: null
