utils = require 'utils'
htmlparser = require 'htmlparser2'

attrsKeyGen = (i, elem) -> elem
attrsValueGen = (i, elem) -> i

module.exports = (Element) ->

	class Parser

		constructor: (callback) ->
			@_callback = callback
			@_done = false
			@_tagStack = []
			@node = new Element.Tag

		onreset: ->
			Parser.call @, @_callback

		onend: ->
			return if @_done
			@_done = true
			@_callback null, @node

		onerror: (err) ->
			@_done = true
			@_callback err, @node

		onclosetag: (name) ->
			elem = @_tagStack.pop()

		_addDomElement: (element) ->
			lastTag = utils.last(@_tagStack) or @node

			lastTag.children.push element
			element._parent = lastTag

		onopentag: (name, attribs) ->
			lastTag = utils.last @_tagStack

			element = new Element.Tag
			element.name = name
			if (attrsNames = Object.keys attribs).length
				element.attrsKeys = attrsNames
				element.attrsNames = utils.arrayToObject attrsNames, attrsKeyGen, attrsValueGen
				element.attrsValues = utils.objectToArray attribs

			@_addDomElement element
			@_tagStack.push element

		ontext: (data) ->
			#append = not _tagStack.length and @node.length and (lastTag = @node[@node.length-1]).type is 'text'
			#append ||= _tagStack.length and (lastTag = _tagStack[_tagStack.length - 1]) and (lastTag = lastTag.children[lastTag.children.length - 1]) and lastTag.type is 'text'

			# omit spaces and new lines
			data = data.replace ///[\t\n]///gm, ''
			return unless data

			# lastTag = utils.last(@_tagStack)?.children[0]
			append = lastTag?.hasOwnProperty '_text'

			if append
				lastTag._text += data
			else
				element = new Element.Text

				element._text = data
				@_addDomElement element

		oncomment: ->

		oncdatastart: ->

		oncommentend: ->

		oncdataend: ->

		onprocessinginstruction: (name, data) ->
			element = new Element.Text

			element._text = "<#{data}>"
			@_addDomElement element

	parse: (html) ->
		r = null

		handler = new Parser (err, node) =>
			if err then throw err

			r = node

		parser = new htmlparser.Parser handler,
			xmlMode: false
			recognizeSelfClosing: true
			lowerCaseAttributeNames: false
			lowerCaseTags: false
		parser.write html
		parser.end()
		
		r