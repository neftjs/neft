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
CODE = 'code'

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
	assert obj.type is ATTRIBUTE, "isAnchor: type must be an attribute"

	obj.name is 'anchors' or obj.name.indexOf('anchors.') is 0

BINDING = ///([a-zA-Z_][a-zA-Z0-9_]*)\.([a-zA-Z0-9_]+)///
isBinding = (obj) ->
	assert obj.type is ATTRIBUTE, "isBinding: type must be an attribute"

	try
		eval "(function(global,console,process,root,module,require){return (#{obj.value});}).call(null)"
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

getElemByName = (arr, type, name) ->
	for elem in arr
		if elem.type is type and elem.name is name
			return elem
	return

anchorAttributeToString = (obj) ->
	assert obj.type is ATTRIBUTE, "anchorAttributeToString: type must be an attribute"

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
	assert obj.type is OBJECT, "stringObject: type must be an object"

	if getByType(obj.body, ID).length > 0
		ids[obj.id] = true

	isLocal = Renderer[obj.name.split('.')[0]]?
	properties = getEachProp(getByType(obj.body, PROPERTY), 'name')
	signals = getEachProp(getByType(obj.body, SIGNAL), 'name')

	args = []
	args.push "properties: #{JSON.stringify properties}" if properties.length
	args.push "signals: #{JSON.stringify signals}" if signals.length
	if args.length
		args = "{#{args.join ', '}}"

	decl = if isLocal then "new #{obj.name}" else "#{obj.name}"
	r = "var #{obj.id} = #{decl}(#{args or ''});\n"

	for child in getByType(obj.body, OBJECT)
		r += stringObject child
		r += "if (#{child.id} instanceof Item){ #{child.id}.parent = #{obj.id}; }\n"

	# initialize states
	if getElemByName obj.body, ATTRIBUTE, 'states'
		r += "#{obj.id}.states\n"

	r

stringAttribute = (obj, parents) ->
	assert obj.type is ATTRIBUTE, "stringAttribute: type must be an attribute"
	assert parents[0].type is OBJECT, "stringAttribute: first parent must be an object"

	object = parents[0]
	{value} = obj

	ref = "#{object.id}."
	for parent in parents[1...]
		ref += "#{parent.name}."
	ref += "#{obj.name}"

	r = "#{ref} = "
	rPre = ''
	rPost = ''
	childParents = null

	if Array.isArray value
		rArr = "["

		for elem in value
			switch elem.type
				when OBJECT
					rArr += "#{elem.id}, "
					rPre += stringObjectFull elem
				when ATTRIBUTE
					unless childParents
						childParents = parents.slice()
						childParents.push obj
					rPost += stringAttribute elem, childParents
				else
					throw "Not implemented attribute type"

		rArr = rArr.slice 0, -2
		if rArr.length > 0
			r += "#{rArr}]"
		else
			if parents.length > 1 or getElemByName(parents[0].body, PROPERTY, obj.name)
				r += "{}"
			else
				return rPre + rPost
	else if isAnchor obj
		r += anchorAttributeToString(obj)
	else if isBinding obj
		r += bindingAttributeToString(obj)
	else if value.type is OBJECT
		r += value.id
		rPre += stringObjectFull value
	else
		r += value

	r += ";\n"
	rPre + r + rPost

stringAttributes = (obj) ->
	assert obj.type is OBJECT, "stringAttributes: type must be an object"

	r = ''

	for attribute in getByType(obj.body, ATTRIBUTE)
		r += stringAttribute attribute, [obj]

	for child in getByType(obj.body, OBJECT)
		r += stringAttributes child

	r

stringFunctions = (obj) ->
	assert obj.type is OBJECT, "stringFunctions: type must be an object"

	r = ''

	attributes = getByType obj.body, FUNCTION
	for attribute in attributes
		func = Function attribute.params or [], attribute.body
		r += "#{obj.id}.#{attribute.name}(#{func});\n"

	for child in getByType(obj.body, OBJECT)
		r += stringFunctions child

	r

stringObjectFull = (obj) ->
	if obj.type is CODE
		return obj.body

	assert obj.type is OBJECT, "stringObjectFull: type must be an object"

	code = stringObject obj
	code += stringAttributes obj
	code += stringFunctions obj
	code

module.exports = (file) ->
	elems = parser file
	ids = {}

	code = ''
	for elem in elems
		code += stringObjectFull elem

	idsKeys = Object.keys ids

	code += "var mainItem;\n"
	for elem in elems
		if elem.type is OBJECT
			code += "if (#{elem.id} instanceof Item) mainItem = #{elem.id};\n"

	idsObject = '{'
	for id in idsKeys
		idsObject += "#{id}: #{id}, "
	if idsKeys.length > 0
		idsObject = idsObject.slice 0, -2
	idsObject += "}"
	code += "var ids = #{idsObject};\n"

	code
