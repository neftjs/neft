utils = require 'src/utils'
htmlparser = require 'htmlparser2'
log = require 'src/log'

log = log.scope 'Document'

DEFAULT_ATTR_VALUE = utils.uid 100
AMPERSAND = 'Მ'
AMPERSAND_RE = new RegExp AMPERSAND, 'g'

propsKeyGen = (i, elem) -> elem
propsValueGen = (i, elem) -> i
encodeText = (text) -> text.replace(new RegExp('&', 'g'), AMPERSAND)
decodeText = (text) -> text.replace(AMPERSAND_RE, '&')

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

            length = lastTag.children.push element
            element._parent = lastTag
            if element._previousSibling = (lastTag.children[length - 2] or null)
                element._previousSibling._nextSibling = element
            return

        onopentag: (name, attribs) ->
            element = new Element.Tag
            element.name = name
            for key, val of attribs
                attribs[key] = decodeText val
            utils.merge element.props, attribs

            @_addDomElement element
            @_tagStack.push element

        ontext: (data) ->
            # omit tabs and new lines
            unless data.replace(/[\t\n]/gm, '')
                return

            element = new Element.Text

            element._text = decodeText data
            @_addDomElement element

        oncomment: ->

        oncdatastart: ->

        oncommentend: ->

        oncdataend: ->

        onprocessinginstruction: (name, data) ->
            element = new Element.Text

            element._text = "<#{decodeText data}>"
            @_addDomElement element

    parse: (html) ->
        r = null

        handler = new Parser (err, node) ->
            if err then throw err

            r = node

        parser = new htmlparser.Parser handler,
            xmlMode: true
            recognizeSelfClosing: true
            lowerCaseAttributeNames: false
            lowerCaseTags: false
            recognizeCDATA: true
            decodeEntities: true

        parser._tokenizer._xmlMode = false # enable script and style

        # TODO: do it while parsing
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

        parser.write encodeText html
        parser.end()

        r
