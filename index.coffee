'use strict'

Renderer = require 'renderer'

parser = require './parser'

{assert} = console

OBJECT = 'object'
PROPERTY = 'property'
ATTRIBUTE = 'attribute'
SIGNAL = 'signal'
FUNCTION = 'function'

ids = null

repeatString = (str, amount) ->
	r = str
	for i in [0...amount-1] by 1
		r += str
	r

concatArrayElements = (arrA, arrB) ->
	assert arrA.length is arrB.length

	for elem, i in arrA
		arrA[i] += arrB[i]

	arrA

isAnchor = (obj) ->
	assert obj.type is ATTRIBUTE

	obj.name is 'anchors' or obj.name.indexOf('anchors.') is 0

BINDING = ///([a-zA-Z_][a-zA-Z0-9_]*)\.([a-zA-Z0-9_]+)///
isBinding = (obj) ->
	assert obj.type is ATTRIBUTE

	try
		eval "(function(){return (#{obj.value});}).call(null)"
		return false

	unless BINDING.test obj.value
		return false

	true

getByType = (arr, type) ->
	r = []
	for elem in arr
		if elem.type is type
			r.push elem
	r

getEachProp = (arr, prop) ->
	r = []
	for elem in arr
		r.push elem[prop]
	r

anchorAttributeToString = (obj) ->
	assert obj.type is ATTRIBUTE

	anchor = obj.value.split '.'
	if anchor[0] is 'parent'
		anchor[0] = "'#{anchor[0]}'"
	anchor[1] = "'#{anchor[1]}'"
	"[#{anchor}]"

bindingAttributeToString = (obj) ->
	binding = ['']
	val = obj.value

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

	"{binding: [#{text}]}"

stringObject = (obj) ->
	assert obj.type is OBJECT

	isLocal = Renderer[obj.name]?
	properties = getEachProp(getByType(obj.body, PROPERTY), 'name')
	signals = getEachProp(getByType(obj.body, SIGNAL), 'name')

	args = []
	args.push "properties: #{JSON.stringify properties}" if properties.length
	args.push "signals: #{JSON.stringify signals}" if signals.length
	if args.length
		args = "{#{args.join ', '}}"

	r = "#{obj.id} = #{isLocal and 'new ' or ''}#{obj.name}(#{args or ''});\n"

	for child in getByType(obj.body, OBJECT)
		r += stringObject child
		r += "if (#{child.id} instanceof Item){ #{child.id}.parent = #{obj.id}; }\n"

	r

stringAttributeValueObject = (obj) ->
	assert obj.type is OBJECT

	[stringObject(obj), obj.id]

stringAttributeValue = (obj) ->
	assert obj.type is ATTRIBUTE

	{value} = obj

	if isAnchor obj
		['', anchorAttributeToString obj]
	else if isBinding obj
		['', bindingAttributeToString obj]
	else if Array.isArray value
		r = ''
		childIds = []
		for elem in value
			childResult = stringAttributeValueObject(elem)
			r += childResult[0]
			childIds.push childResult[1]
		[r, "[#{childIds}]"]
	else if value.type is 'object'
		stringAttributeValueObject value
	else
		['', value]

stringAttributes = (obj) ->
	assert obj.type is OBJECT

	r = ['', '']

	attributes = getByType obj.body, ATTRIBUTE
	for attribute in attributes
		r[1] += "#{obj.id}.#{attribute.name} = "
		concatArrayElements r, stringAttributeValue(attribute)
		r[1] += ";\n"

	for child in getByType(obj.body, OBJECT)
		r[1] += stringAttributes child

	r.join('')

stringFunctions = (obj) ->
	assert obj.type is OBJECT

	r = ''

	attributes = getByType obj.body, FUNCTION
	for attribute in attributes
		func = Function attribute.params or [], attribute.body
		r += "#{obj.id}.#{attribute.name}(#{func});\n"

	for child in getByType(obj.body, OBJECT)
		r += stringFunctions child

	r

module.exports = (file) ->
	elems = parser file
	ids = {}

	console.log JSON.stringify elems, null, 2

	console.log ''
	console.log ''

	code = stringObject elems
	code += stringAttributes elems
	code += stringFunctions elems
	code += "mainItem = #{elems.id}\n"

	code