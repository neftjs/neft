'use strict'

utils = require 'utils'

{assert} = console

TEST_FILE = """
Item {
	id: main
	x: 10
	property empty
	property name: "String, 123",
	signal pressed
	obj: {a: 2, b: 3}
	onReady: ->
		a = 2
	onCompleted: -> @state = 2

	states.first: State {
		abc: 123
		transitions: [
			Transition {
				properties: ['abc']
			}
		]
	}

	Image {
		id: img1
		name: this.name + 'a' + parent.name
		anchors: {
			left: main.right
			top: parent.top
		}
	}
}

Item2 {
	a: 1
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
ANCHOR = ///([a-zA-Z]+):\s*([a-zA-Z0-9_-]+)(?:\.([a-zA-Z]+))?///
BINDING = ///([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)///
FUNCTION = ///^(\s+)([a-zA-Z0-9_-]+):\s*->$///m
LINE_COMMENT = ///\#(.*)$///m
MULTI_LINE_COMMENT = ///\#\#\#(.|\n)*?\#\#\#///m

PROPERTY_G = new RegExp PROPERTY.source, 'g'
SIGNAL_G = new RegExp SIGNAL.source, 'g'
BINDING_G = new RegExp BINDING.source, 'g'
LINE_COMMENT_G = new RegExp LINE_COMMENT.source, 'g'
MULTI_LINE_COMMENT_G = new RegExp MULTI_LINE_COMMENT.source, 'g'

getScopeLen = (str, startIndex) ->
	assert str[startIndex] is SCOPE_OPEN

	end = startIndex
	innerStartIndex = startIndex
	while true
		end = str.indexOf SCOPE_CLOSE, end+1
		assert end isnt -1

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

	scopeBody = body.slice(scopeFrom+1, scopeTo-1).trim()

	scope = new Scope type, scopeBody
	obj.body = body.slice(0, exec.index) + scope.uid + body.slice(scopeTo)
	obj.body = obj.body.trim()
	scope

getScopeRecursive = (scope) ->
	while child = getScope(scope)
		scope.children.push child
		getScopeRecursive child
	null

clearScopeBody = (scope) ->
	{body} = scope
	body = body.replace ///^\s+///gm, ''
	# body = body.replace ///\n///g, ','
	# body = body.replace ///,,///g, ','
	# body = body.replace ///({),|,(})///g, '$1$2'
	scope.body = body

findFuncs = (scope) ->
	scope.body = scope.body.replace FUNCTION, (str, tab, name, index) ->
		lines = scope.body.slice(index+str.length).split '\n'

		lines = lines.filter (line) ->
			!!line.trim()

		for line, i in lines
			unless ///\s///.test line[tab.length]
				lines.splice i, lines.length-i
				break
			else
				lines[i] = line.trim()
		
		scope.attributes[name] = "->\n	#{lines.join('	')}"

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
			scopesCharsLen += ///[{\[]///g.exec(line)?.length or 0
			scopesCharsLen -= ///[}\]]///g.exec(line)?.length or 0
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
		if scopeRef = scopes[val]
			scopeRef.isItem = false
			scope.attributes[name] = scopeRef.id
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
		if val[0] is '['
			return false

		if val.indexOf('->') is 0
			return false

		unless utils.catchError eval, null, ["(function(){return (#{val});}).call(null)"]
			return false

		unless BINDING.test val
			return false

		true

	(scope) ->
		for name, val of scope.attributes
			if isBinding val
				binding = []
				lastIndex = 0
				val = val.replace BINDING_G, (str, ref, prop, index) ->
					if ref is 'parent'
						ref = "['this', 'parent']"
					else if ref is 'this'
						ref = "'this'"
					else if not ids.hasOwnProperty ref
						return str

					binding.push val.slice lastIndex, index
					lastIndex = index + str.length
					binding.push "[#{ref}, '#{prop}']"
					str
				binding.push val.slice lastIndex

				binding = binding.filter (elem) ->
					!!elem.trim()
				
				for elem, i in binding
					if elem[0] isnt '['
						binding[i] = "'#{utils.addSlashes elem}'"

				scope.attributes[name] = "[#{binding.join ', '}]"

# STRINGIFY #

result = ''

stringifyDeclarations = (scope) ->
	return unless scope.type

	result += "#{scope.id} = new #{scope.type}("

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
		if val.indexOf('->') is 0
			result += "#{scope.id}.#{name} #{val}\n"
		else
			result += "#{scope.id}.#{name} = #{val}\n"

stringifyTree = (scope, parent) ->
	if parent? and parent.type and scope.isItem
		result += "#{scope.id}.parent = #{parent.id}\n"

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

	result += "\n#{main.children[0].id}"

	# console.log JSON.stringify main, null, 4
	result

# console.log module.exports(TEST_FILE)