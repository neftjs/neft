'use strict'

Renderer = require 'renderer'
parser = require './parser'
utils = require 'utils'

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

BINDING = ///([a-zA-Z_$][a-zA-Z0-9_$]*)\.([a-zA-Z0-9_$]+)///
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

getObject = (obj) ->
	while obj
		if obj.type is 'object'
			return obj
		obj = obj.parent
	return

getObjectParent = (obj) ->
	obj = getObject obj
	unless parent = obj.parent
		throw "Binding to the static 'parent' can't be used if an item doesn't have a parent. Use 'this.parent' if this reference must be dynamic"
	parent.id

getObjectNextSibling = (obj) ->
	obj = getObject obj
	index = obj.parent?.body.indexOf(obj)
	unless sibling = obj.parent.body[index+1]
		throw "Binding to the static 'nextSibling' can't be used if an item doesn't have a next sibling. Use 'this.nextSibling' if this reference must be dynamic"
	sibling.id

getObjectPreviousSibling = (obj) ->
	obj = getObject obj
	index = obj.parent?.body.indexOf(obj)
	unless sibling = obj.parent.body[index-1]
		throw "Binding to the static 'previousSibling' can't be used if an item doesn't have a previous sibling. Use 'this.previousSibling' if this reference must be dynamic"
	sibling.id

anchorAttributeToString = (obj) ->
	assert obj.type is ATTRIBUTE, "anchorAttributeToString: type must be an attribute"

	if typeof obj.value is 'object'
		return "{}"

	dotIndex = obj.value.lastIndexOf '.'
	if dotIndex is -1
		anchor = [obj.value]
	else
		anchor = [obj.value.slice(0, dotIndex), obj.value.slice(dotIndex+1)]

	anchor[0] = switch anchor[0]
		when 'this.parent'
			"'parent'"
		when 'this.nextSibling'
			"'nextSibling'"
		when 'this.previousSibling'
			"'previousSibling'"
		when 'parent'
			getObjectParent obj
		when 'nextSibling'
			getObjectNextSibling obj
		when 'previousSibling'
			getObjectPreviousSibling obj
		else
			anchor[0]
	if anchor.length > 1
		anchor[1] = "'#{anchor[1]}'"
	"[#{anchor}]"

bindingAttributeToString = (obj) ->
	binding = ['']
	val = obj.value

	# split to types
	val += ' '
	lastBinding = null
	isString = false
	for char, i in val
		if char is '.' and lastBinding
			lastBinding.push ''
			continue

		if lastBinding and (isString or ///[a-zA-Z_0-9$]///.test(char))
			lastBinding[lastBinding.length - 1] += char
		else if ///[a-zA-Z_$]///.test(char)
			lastBinding = [char]
			binding.push lastBinding
		else
			if lastBinding is null
				binding[binding.length - 1] += char
			else
				lastBinding = null
				binding.push char

		if /'|"/.test(char) and val[i-1] isnt '\\'
			isString = not isString

	# filter by ids
	for elem, i in binding when typeof elem isnt 'string'
		[id] = elem
		if id is 'parent' or id is 'target'
			elem[0] = getObjectParent obj
		else if id is 'nextSibling'
			elem[0] = getObjectNextSibling obj
		else if id is 'previousSibling'
			elem[0] = getObjectPreviousSibling obj
		else if id is 'this'
			elem[0] = getObject(obj).id
		else if (id is 'app' or id is 'view' or ids.hasOwnProperty(id) or id of Renderer) and (i is 0 or binding[i-1][binding[i-1].length - 1] isnt '.')
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
	hash = ''
	args = []
	for elem, i in binding
		if binding[i-1]?
			text += ", "

		if typeof elem is 'string'
			elem = elem.replace ///\$///g, '$$$'
			elem = elem.replace ///'///g, '\\\''
			text += "'#{elem}'"
			hash += elem
		else if elem.length > 1
			text += repeatString('[', elem.length-1)
			text += "#{elem[0]}"
			hash += "$#{args.length}"
			args.push elem[0]
			elem.shift()
			for id, i in elem
				text += ", '#{id}']"
				hash += ".#{id}"
		else
			text += "#{elem[0]}"
			hash += "$#{args.length}"
			args.push elem[0]

	hash = hash.trim()
	text = text.trim()

	"['#{hash}', [#{text}], [#{args}]]"

stringObjectHead = (obj) ->
	assert obj.type is OBJECT, "stringObject: type must be an object"

	if getByType(obj.body, ID).length > 0
		ids[obj.id] = true

	rendererClass = Renderer[obj.name.split('.')[0]]
	isLocal = rendererClass?
	decl = if isLocal then "new #{obj.name}" else "#{obj.name}"
	r = "var #{obj.id} = ids.#{obj.id} = #{decl}();\n"
	r += "#{obj.id}._id = '#{obj.id}';\n"
	r += "#{obj.id}._isReady = false;\n"

	properties = getEachProp(getByType(obj.body, PROPERTY), 'name')
	for property in properties
		r += "#{obj.id}.createProperty('#{utils.addSlashes(property)}')\n"

	signals = getEachProp(getByType(obj.body, SIGNAL), 'name')
	for signal in signals
		r += "#{obj.id}.createSignal('#{utils.addSlashes(signal)}')\n"

	r

stringObjectChildren = (obj) ->
	assert obj.type is OBJECT, "stringObject: type must be an object"

	r = ""

	for child in getByType(obj.body, OBJECT)
		r += stringObject child

		rendererClass = Renderer[child.name.split('.')[0]]

		if rendererClass?.prototype instanceof Renderer.Extension
			r += "#{child.id}.target = #{obj.id};\n"
		else
			r += "if (#{child.id} instanceof Item) #{child.id}.parent = #{obj.id};\n"

	r

stringObject = (obj) ->
	r = stringObjectHead obj
	r += stringObjectChildren obj

stringAttribute = (obj, parents) ->
	assert obj.type is ATTRIBUTE, "stringAttribute: type must be an attribute"
	assert parents[0].type is OBJECT, "stringAttribute: first parent must be an object"

	object = parents[0]
	{value} = obj

	parentsRef = "#{object.id}."
	for parent in parents[1...]
		parentsRef += "#{parent.name}."
	parentsRef = parentsRef.slice 0, -1
	ref = "#{parentsRef}.#{obj.name}"

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
			if parents.length > 1 or obj.name.indexOf('$.') is 0
				r += "{}"
			else
				return rPre + rPost
	else if isAnchor obj
		r += anchorAttributeToString(obj)
	else
		[_, extraParentsRef, propName] = ///^(?:(.+)\.)?(.+)$///.exec obj.name
		if extraParentsRef
			extraParentsRef = ".#{extraParentsRef}"
		else
			extraParentsRef = ''

		if isBinding obj
			binding = bindingAttributeToString(obj)
			r = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', #{binding})"
		else
			if ///^Styles\[///.test object.name
				rPre = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', null);\n"

			if value.type is OBJECT
				r += value.id
				rPre += stringObjectFull value
			else
				r += value

	r += ";\n"
	rPre + r + rPost

stringAttributes = (obj) ->
	assert obj.type is OBJECT, "stringAttributes: type must be an object"

	r = ''

	for child in getByType(obj.body, OBJECT)
		r += stringAttributes child

	for attribute in getByType(obj.body, ATTRIBUTE)
		r += stringAttribute attribute, [obj]

	r

stringFunctions = (obj) ->
	assert obj.type is OBJECT, "stringFunctions: type must be an object"

	r = ''

	attributes = getByType obj.body, FUNCTION
	for attribute in attributes
		func = Function attribute.params or [], attribute.body
		r += "#{obj.id}.#{attribute.name}(#{func}, #{obj.id});\n"

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

stringViewObjectFull = (obj) ->
	if obj.type is CODE
		return obj.body

	assert obj.type is OBJECT, "stringObjectFull: type must be an object"

	code = stringObjectHead obj
	code += "setImmediate(function(){\n"
	code += stringObjectChildren obj
	code += stringAttributes obj
	code += stringFunctions obj
	code += "});\n"
	code

module.exports = (file, filename) ->
	elems = parser file
	ids = {}

	code = 'var ids = {};\n'
	for elem in elems
		if filename is 'view'
			code += stringViewObjectFull elem
		else
			code += stringObjectFull elem

	idsKeys = Object.keys ids

	if filename is 'view'
		code += "setImmediate(function(){\n"
	code += "for (var _id in ids){\n"
	code += "	ids[_id]._isReady = true; ids[_id].ready(); ids[_id].onReady.disconnectAll();\n"
	code += "}\n"
	if filename is 'view'
		code += "});\n"

	code += "var mainItem;\n"
	for elem in elems
		if elem.type is OBJECT
			code += "if (#{elem.id} instanceof Item) mainItem = #{elem.id};\n"

	code
