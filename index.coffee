'use strict'

Renderer = require 'renderer'
parser = require './parser'

{assert} = console

OBJECT = 'object'
ID = 'id'
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

	if typeof obj.value is 'object'
		return "{}"

	anchor = obj.value.split '.'
	if anchor[0] is 'parent'
		anchor[0] = "'parent'"
	if anchor.length > 1
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

	if getByType(obj.body, ID).length > 0
		ids[obj.id] = true

	isLocal = Renderer[obj.name]?
	properties = getEachProp(getByType(obj.body, PROPERTY), 'name')
	signals = getEachProp(getByType(obj.body, SIGNAL), 'name')

	args = []
	args.push "properties: #{JSON.stringify properties}" if properties.length
	args.push "signals: #{JSON.stringify signals}" if signals.length
	if args.length
		args = "{#{args.join ', '}}"

	decl = if isLocal then "new #{obj.name}" else "styles['#{obj.name}']"
	r = "var #{obj.id} = #{decl}(#{args or ''});\n"

	for child in getByType(obj.body, OBJECT)
		r += stringObject child
		r += "if (#{child.id} instanceof Item){ #{child.id}.parent = #{obj.id}; }\n"

	r

stringAttributeValueObject = (obj) ->
	assert obj.type is OBJECT

	[stringObjectFull(obj), obj.id, '']

stringAttributeValue = (obj, parent) ->
	assert obj.type is ATTRIBUTE
	assert parent.type is OBJECT

	{value} = obj
	
	if Array.isArray value
		r = ''
		childIds = []
		postfix = ''
		for elem in value
			switch elem.type
				when 'object'
					childResult = stringAttributeValueObject(elem)
					r += childResult[0]
					childIds.push childResult[1]
					postfix += childResult[2]
				when 'attribute'
					elem.name = "#{obj.name}.#{elem.name}"
					childResult = stringAttribute(elem, parent)
					r += childResult[0]
					postfix += childResult[1] + childResult[2]
				else
					throw "Not implemented attribute type"
		if childIds.length
			value = "[#{childIds}]"
		else
			value = "{}"
		[r, value, postfix]
	else if isAnchor obj
		['', anchorAttributeToString(obj), '']
	else if isBinding obj
		['', bindingAttributeToString(obj), '']
	else if value.type is 'object'
		stringAttributeValueObject value
	else
		['', value, '']

stringAttribute = (obj, parent) ->
	assert obj.type is ATTRIBUTE
	assert parent.type is OBJECT

	r = ['', '', '']
	r[1] += "#{parent.id}.#{obj.name} = "
	concatArrayElements r, stringAttributeValue(obj, parent)
	r[1] += ";\n"
	r

stringAttributes = (obj) ->
	assert obj.type is OBJECT

	r = ['', '', '']

	attributes = getByType obj.body, ATTRIBUTE
	for attribute in attributes
		concatArrayElements r, stringAttribute(attribute, obj)

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

stringObjectFull = (obj) ->
	assert obj.type is OBJECT

	code = stringObject obj
	code += stringAttributes obj
	code += stringFunctions obj
	code

module.exports = (file) ->
	elems = parser file
	ids = {}

	code = stringObjectFull elems
	code += "var mainItem = #{elems.id};\n"

	idsObject = '{'
	idsKeys = Object.keys ids
	for id in idsKeys
		idsObject += "#{id}: #{id}, "
	if idsKeys.length > 0
		idsObject = idsObject.slice 0, -2
	idsObject += "}"
	code += "var ids = #{idsObject};\n"

	code