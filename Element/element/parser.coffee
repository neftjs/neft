utils = require 'utils'
htmlparser = require 'htmlparser2'
log = require 'log'

log = log.scope 'Document'

DEFAULT_ATTR_VALUE = utils.uid 100

attrsKeyGen = (i, elem) -> elem
attrsValueGen = (i, elem) -> i

module.exports = (Element) ->
	extensions = Element.Tag.extensions

	internalTagsObject = utils.arrayToObject Element.Tag.INTERNAL_TAGS,
		((_, key) -> key), (-> true), Object.create(null)

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

			length = lastTag.children.push element
			element._parent = lastTag
			if element._previousSibling = (lastTag.children[length - 2] or null)
				element._previousSibling._nextSibling = element
			return

		onopentag: (name, attribs) ->
			null;
			`//<development>`
			if /^neft:/.test(name) and not internalTagsObject[name]
				log.warn "Unknown internal tag name '#{name}'"
			`//</development>`

			element = new (extensions[name] or Element.Tag)
			element.name = name
			element.attrs._data = attribs

			@_addDomElement element
			@_tagStack.push element

		ontext: (data) ->
			# omit tabs and new lines
			unless data.replace(/[\t\n]/gm, '')
				return

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
			recognizeCDATA: true

		parser.onattribname = do (_super = parser.onattribname) -> (name) ->
			_super.call @, name
			@_attribvalue = DEFAULT_ATTR_VALUE

		parser.onattribdata = do (_super = parser.onattribdata) -> (val) ->
			if @_attribvalue is DEFAULT_ATTR_VALUE
				@_attribvalue = ''
			_super.call @, val

		parser.onattribend = do (_super = parser.onattribend) -> ->
			if @_attribvalue is DEFAULT_ATTR_VALUE
				@_attribvalue = 'true'
			_super.call @

		# support neft:function
		html = html.replace /<neft:function([^>]*)>/g, '$&<![CDATA['
		html = html.replace /<\/neft:function>/gi, ']]>$&'

		parser.write html
		parser.end()

		r
