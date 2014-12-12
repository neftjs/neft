'use strict'

utils = require 'utils'

Renderer = require 'renderer'

{assert} = console
{isArray} = Array

TEST_FILE = """
Image {
	property type: ''
	property color: 'green'
	property sources: {}

	width: -window.width
	state: [this.type, this.type + '_' + this.color]
	source: this.sources[this.color]
	anchors.left: parent.left

	onPointerEntered: ->
		if @state = 'hover'
			alert 1
	onPointerExited: ->
		@state = ''

	Text {
		font: {
			family: "AvenirLTStd-Light"
			pixelSize: 36
		}
		text: parent.text

		onPointerClicked: ->

		state: parent.color
		states.white: State {
			color: 'white'
		}
		states.black: State {
			color: '#1A1A1A'
		}
	}
}
"""

SCOPE_OPEN = '{'
SCOPE_CLOSE = '}'
PREDEFINED_ANCHORS =
	parent: true

TYPE = ///([A-Z][a-zA-Z0-9_-]*)\s*{///
ATTRIBUTE = ///([^:]*?):(.*)///
PROPERTY = ///property\s(.*)///
SIGNAL = ///signal\s(.*)///
ANCHOR = ///([a-zA-Z]+):\s*([a-zA-Z0-9_]+)(?:\.([a-zA-Z]+))?///
BINDING = ///([a-zA-Z_][a-zA-Z0-9_]*)\.([a-zA-Z0-9_]+)///
FUNCTION = ///^(\s*)([a-zA-Z0-9_.]+):\s*(\([a-zA-Z0-9_$,\s]*\)\s*)?->$///m
FUNCTION_DECLATARION = ///^(\([a-zA-Z0-9_$,\s]*\)\s*)?->///
LINE_COMMENT = ///^\s*\#(.*)$///m
MULTI_LINE_COMMENT = ///^\s*\#\#\#(.|\n)*?\#\#\#///m
CUSTOM_ID = ///CUSTOM_UID_([a-zA-Z0-9]+)///

PROPERTY_G = new RegExp PROPERTY.source, 'g'
SIGNAL_G = new RegExp SIGNAL.source, 'g'
BINDING_G = new RegExp BINDING.source, 'g'
LINE_COMMENT_G = new RegExp LINE_COMMENT.source, 'mg'
MULTI_LINE_COMMENT_G = new RegExp MULTI_LINE_COMMENT.source, 'mg'
FUNCTION_G = new RegExp FUNCTION.source, 'mg'
CUSTOM_ID_G = new RegExp CUSTOM_ID.source, 'g'

repeatString = (str, amount) ->
	r = str
	for i in [0...amount-1] by 1
		r += str
	r

getScopeLen = (str, startIndex) ->
	assert str[startIndex] is SCOPE_OPEN

	end = startIndex
	innerStartIndex = startIndex
	while true
		end = str.indexOf SCOPE_CLOSE, end+1
		assert end isnt -1, str

		innerStartIndex = str.indexOf(SCOPE_OPEN, innerStartIndex+1)
		if innerStartIndex is -1 or innerStartIndex > end
			return end - startIndex

class Scope
	constructor: (@type, @body) ->
		@uid = "CUSTOM_UID_#{utils.uid()}"
		@id = ''
		@isItem = true
		@children = []
		@attributes = {}
		@properties = []
		@signals = []

		scopes[@uid] = @

scopes = {}
ids = {}

callRecursive = (scope, func, _parent) ->
	func scope, _parent
	for child in scope.children
		callRecursive child, func, scope
	null

# PARSE #

removeComments = (str) ->
	str = str.replace MULTI_LINE_COMMENT_G, ''
	str = str.replace LINE_COMMENT_G, ''
	str

getScope = (obj) ->
	{body} = obj
	exec = TYPE.exec(body)
	unless exec
		return null

	[decl, type] = exec
	scopeFrom = exec.index + decl.length-1
	scopeLen = getScopeLen body, scopeFrom
	scopeTo = scopeFrom + scopeLen + 1

	scopeBody = body.slice(scopeFrom+1, scopeTo-1)#.trim()

	scope = new Scope type, scopeBody
	obj.body = body.slice(0, exec.index) + scope.uid + body.slice(scopeTo)
	# obj.body = obj.body.trim()
	scope

getScopeRecursive = (scope) ->
	while child = getScope(scope)
		scope.children.push child
		getScopeRecursive child
	null

clearScopeBody = (scope) ->
	{body} = scope
	# body = body.replace ///^\s+///gm, ''
	# body = body.replace ///\n///g, ','
	# body = body.replace ///,,///g, ','
	# body = body.replace ///({),|,(})///g, '$1$2'
	scope.body = body

findFuncs = (scope) ->
	scope.body = scope.body.replace FUNCTION_G, (str, tab, name, args, index) ->
		lines = scope.body.slice(index+str.length+1).split '\n'

		lines = lines.filter (line) ->
			!!line.trim()

		tabLen = tab.match(///\t///g)?.length or 0

		for line, i in lines
			unless ///\s///.test line[tabLen]
				lines.splice i, lines.length-i
				break
			else
				lines[i] = line.slice tabLen+1

		indentation = ''
		for i in [0...tabLen]
			indentation += '\t'

		args ?= ''
		scope.attributes[name] = "#{args}->\n#{indentation}#{lines.join('\n' + indentation)}"

		''

findAttributes = (scope) ->
	lines = scope.body.split '\n'

	scopesCharsLen = 0
	lastName = ''
	i = 0; n = lines.length
	while i < n
		line = lines[i]
		if scopesCharsLen > 0
			scope.attributes[lastName] += "\n#{line}"
			scopesCharsLen += line.match(///[{\[]///g)?.length or 0
			scopesCharsLen -= line.match(///[}\]]///g)?.length or 0
			lines.splice i, 1
			n--
			continue

		exec = ATTRIBUTE.exec line
		unless exec
			i++
			continue

		[_, name, val] = exec
		name = name.trim()
		val = val.trim()
		scope.attributes[name] = val
		lastName = name

		if ///[{\[]///.test val[val.length-1]
			scopesCharsLen++

		lines.splice i, 1
		n--

	scope.body = lines.join '\n'

findId = (scope) ->
	if scope.attributes.id?
		scope.id = scope.attributes.id
		ids[scope.id] = true
		delete scope.attributes.id
	else
		scope.id = "id#{utils.uid()}"

useIdInAttributes = (scope) ->
	for name, val of scope.attributes
		scope.attributes[name] = val.replace CUSTOM_ID_G, (id) ->
			scopeRef = scopes[id]
			scopeRef.isItem = false
			scopeRef.id
	null

findProperties = (scope) ->
	# with value
	for name, val of scope.attributes
		exec = PROPERTY.exec name
		unless exec
			continue

		[_, propName] = exec
		scope.attributes[propName] ?= val
		scope.properties.push propName
		delete scope.attributes[name]

	# only declarations
	scope.body = scope.body.replace PROPERTY_G, (_, name) ->
		scope.properties.push name
		''

findSignals = (scope) ->
	# with value
	for name, val of scope.attributes
		exec = SIGNAL.exec name
		unless exec
			continue

		[_, propName] = exec
		scope.attributes[propName] ?= val
		scope.signals.push propName
		delete scope.attributes[name]

	# only declarations
	scope.body = scope.body.replace SIGNAL_G, (_, name) ->
		scope.signals.push name
		''

parseAnchors = (scope) ->
	attrs = scope.attributes

	parseAnchor = (type, ref, refType) ->
		r = "["
		if PREDEFINED_ANCHORS[ref]
			ref = "\"#{ref}\""
		r += ref
		if refType?
			r += ", \"#{refType}\""
		r += ']'
		attrs["anchors.#{type}"] = r

	# anchors.*
	INLINE_ANCHOR_PROP = ///^anchors.(.*)$///
	for prop, val of scope.attributes
		if INLINE_ANCHOR_PROP.test prop
			[_, name] = INLINE_ANCHOR_PROP.exec prop
			[ref, refType] = val.split '.'
			parseAnchor name, ref, refType

	# anchors
	if (anchors = scope.attributes.anchors)?
		while ANCHOR.test anchors
			anchors = anchors.replace ANCHOR, (_, type, ref, refType) ->
				parseAnchor type, ref, refType
				''
		delete scope.attributes.anchors
	null

parseBindings = do ->
	isBinding = (val) ->
		if val[0] is '{'
			return false

		if FUNCTION_DECLATARION.test val
			return false

		try
			eval "(function(){return (#{val});}).call(null)"
			return false

		unless BINDING.test val
			return false

		true

	(scope) ->
		for name, val of scope.attributes
			if isBinding val
				test = (val) ->
				binding = ['']

				# split to types
				val += ' '
				lastBinding = null
				for char in val
					if char is '.' and lastBinding
						lastBinding.push ''

					else if ///[a-zA-Z_]///.test char
						if lastBinding
							lastBinding[lastBinding.length - 1] += char
						else
							lastBinding = [char]
							binding.push lastBinding

					else
						if lastBinding is null
							binding[binding.length - 1] += char
						else
							lastBinding = null
							binding.push char

				# filter by ids
				for elem, i in binding when typeof elem isnt 'string'
					[id] = elem
					if id is 'parent'
						elem.unshift "'this'"
					else if id is 'this'
						elem[0] = "'this'"
					else if id is 'window' or ids.hasOwnProperty(id)
						continue
					else
						binding[i] = elem.join '.'

				# split texts
				i = -1
				n = binding.length
				while ++i < n
					if typeof binding[i] is 'string'
						if typeof binding[i-1] is 'string'
							binding[i-1] += binding[i]

						else if binding[i].trim() isnt ''
							continue

						binding.splice i, 1
						n--

				# split
				text = ''
				for elem, i in binding
					if binding[i-1]?
						text += ", "

					if typeof elem is 'string'
						text += "'#{elem}'"
					else
						text += repeatString('[', elem.length-1)
						text += "#{elem[0]}"
						elem.shift()
						for id, i in elem
							text += ", '#{id}']"

				scope.attributes[name] = "{binding: [#{text}]}"

# STRINGIFY #

result = ''

stringifyDeclarations = (scope) ->
	return unless scope.type

	if Renderer[scope.type]?
		result += "#{scope.id} = new #{scope.type}("
	else
		result += "#{scope.id} = #{scope.type}("

	args = []
	if scope.properties.length
		args.push "properties: #{JSON.stringify scope.properties}"
	if scope.signals.length
		args.push "signals: #{JSON.stringify scope.signals}"
	if args.length > 0
		result += "{#{args.join ', '}}"

	result += ')\n'

stringifyAttributes = (scope) ->
	return unless scope.type

	for name, val of scope.attributes
		if FUNCTION_DECLATARION.test val
			result += "#{scope.id}.#{name} #{val}\n"
		else
			result += "#{scope.id}.#{name} = #{val}\n"

stringifyTree = (scope, parent) ->
	if parent? and parent.type and scope.isItem
		result += "if #{scope.id} instanceof Item then #{scope.id}.parent = #{parent.id}\n"

module.exports = (str) ->
	result = ''
	scopes = {}
	ids = {}

	str = removeComments str
	main = new Scope '', str

	getScopeRecursive main
	callRecursive main, findFuncs
	callRecursive main, clearScopeBody
	callRecursive main, findAttributes
	callRecursive main, findId
	callRecursive main, useIdInAttributes
	callRecursive main, findProperties
	callRecursive main, findSignals
	callRecursive main, parseAnchors
	callRecursive main, parseBindings

	callRecursive main, stringifyDeclarations
	result += '\n'
	callRecursive main, stringifyAttributes
	result += '\n'
	callRecursive main, stringifyTree

	# main item
	result += "\nmainItem = #{main.children[0].id}\n"

	# items
	items = '{'
	for id, scope of ids
		items += "#{id}: #{id}, "
	if items.length > 1
		items = items.slice 0, -2
	items += '}'

	result += "ids = #{items}\n"

	# console.log JSON.stringify main, null, 4
	result

# console.log module.exports(TEST_FILE)