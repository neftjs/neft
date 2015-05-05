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

uid = ->
	'c' + Math.random().toString(16).slice(2)

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

MODIFIERS_NAMES =
	__proto__: null
	Class: true
	Transition: true
	Animation: true
	PropertyAnimation: true
	NumberAnimation: true
	Source: true
	FontLoader: true
	ResourcesLoader: true
getItem = (obj) ->
	while obj
		if obj.type is 'object' and not MODIFIERS_NAMES[obj.name]
			return obj
		obj = obj.parent
	return
getObject = (obj) ->
	while obj
		if obj.type is 'object'
			return obj
		obj = obj.parent
	return

# getItemParent = (obj) ->
# 	obj = getItem obj
# 	if not obj or not (parent = obj.parent)
# 		throw "Binding to the static 'parent' can't be used if an item doesn't have a parent. Use 'this.parent' if this reference must be dynamic"
# 	parent.id

# getItemNextSibling = (obj) ->
# 	obj = getItem obj
# 	index = obj?.parent?.body.indexOf(obj)
# 	if not obj or not (sibling = obj.parent.body[index+1])
# 		throw "Binding to the static 'nextSibling' can't be used if an item doesn't have a next sibling. Use 'this.nextSibling' if this reference must be dynamic"
# 	sibling.id

# getItemPreviousSibling = (obj) ->
# 	obj = getItem obj
# 	index = obj?.parent?.body.indexOf(obj)
# 	if not obj or not (sibling = obj.parent.body[index-1])
# 		throw "Binding to the static 'previousSibling' can't be used if an item doesn't have a previous sibling. Use 'this.previousSibling' if this reference must be dynamic"
# 	sibling.id

anchorAttributeToString = (obj) ->
	assert obj.type is ATTRIBUTE, "anchorAttributeToString: type must be an attribute"

	if typeof obj.value is 'object'
		return "{}"

	anchor = obj.value.split '.'
	if anchor[0] is 'this'
		anchor.shift()
		anchor[0] = "this.#{anchor[0]}"

	anchor[0] = switch anchor[0]
		when 'this.parent', 'parent'
			"'parent'"
		when 'this.nextSibling', 'nextSibling'
			"'nextSibling'"
		when 'this.previousSibling', 'previousSibling'
			"'previousSibling'"
		# when 'parent'
		# 	getItemParent obj
		# when 'nextSibling'
		# 	getItemNextSibling obj
		# when 'previousSibling'
		# 	getItemPreviousSibling obj
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
		if id is 'parent' or id is 'target' or id is 'nextSibling' or id is 'previousSibling'
			elem.unshift "'this'"
		else if id is 'this'
			elem[0] = "'this'"
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
			if elem[0] is "'this'"
				hash += "this"
			else
				hash += "$#{args.length}"
				args.push elem[0]
			elem.shift()
			for id, i in elem
				text += ", '#{id}']"
				hash += ".#{id}"
		else
			text += "#{elem[0]}"
			if elem[0] is "'this'"
				hash += "this"
			else
				hash += "$#{args.length}"
				args.push elem[0]

	hash = hash.trim()
	text = text.trim()

	"['#{hash}', [#{text}], [#{args}]]"

stringObjectHead = (obj) ->
	assert obj.type is OBJECT, "stringObject: type must be an object"

	if getByType(obj.body, ID).length > 0
		ids[obj.id] = true

	rendererCtor = Renderer[obj.name.split('.')[0]]
	isLocal = rendererCtor?
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

	unless MODIFIERS_NAMES[obj.name]
		classBody = []
		obj.body = obj.body.filter (elem) ->
			if elem.type is ATTRIBUTE or (elem.type is FUNCTION and elem.name isnt 'onReady')
				classBody.push elem
				false
			else
				true

		defaultClass =
			type: 'object'
			name: 'Class'
			id: uid()
			body: [{
				type: 'attribute'
				name: 'priority'
				value: '0'
			}, {
				type: 'attribute'
				name: 'changes'
				value: classBody
			}]
			parent: obj
		obj.body.push defaultClass
		# r += stringObjectFull defaultClass
		# r += "#{obj.id}._defaultClasses.push(#{defaultClass.id});\n"
		# r += "#{defaultClass.id}.target = #{obj.id};\n"

	r

stringObjectChildren = (obj) ->
	assert obj.type is OBJECT, "stringObject: type must be an object"

	r = ""

	for child in getByType(obj.body, OBJECT)
		r += stringObject child

		rendererCtor = Renderer[child.name.split('.')[0]]

		if rendererCtor?.prototype instanceof Renderer.Extension
			r += "#{child.id}.target = #{obj.id};\n"
		else
			r += "if (#{child.id} instanceof Item) #{child.id}.parent = #{obj.id};\n"

	r

stringObject = (obj) ->
	r = stringObjectHead obj
	r += stringObjectChildren obj

stringAttribute = (obj, parents) ->
	assert parents[0].type is OBJECT, "stringAttribute: first parent must be an object"

	object = parents[0]
	{value} = obj

	parentsRef = "#{object.id}."
	for parent in parents[1...]
		parentsRef += "#{parent.name}."
	parentsRef = parentsRef.slice 0, -1

	type = 'attr'
	writeAsBinding = false
	writeAsFunction = false
	if object.name is 'Class' and parents[1]?.name is 'changes'
		type = 'change'

	r = ''
	rPre = ''
	rPost = ''
	childParents = null

	if Array.isArray(value)
		rArr = "["

		for elem in value
			switch elem.type
				when OBJECT
					rArr += "#{elem.id}, "
					rPre += stringObjectFull elem
				when ATTRIBUTE, FUNCTION
					unless childParents
						childParents = parents.slice()
						childParents.push obj
					rPost += stringAttribute elem, childParents
				# when FUNCTION
				# 	rPost += stringAttribute elem, childParents
				else
					throw "Not implemented attribute type '#{elem.type}'"

		rArr = rArr.slice 0, -2
		if rArr.length > 0
			r += "#{rArr}]"
		else
			if parents.length > 1 or obj.name.indexOf('$.') is 0
				r += "{}"
			else
				return rPre + rPost
	else if obj.type is FUNCTION
		writeAsFunction = true
		func = Function obj.params or [], obj.body
		r += func
	else if isAnchor(obj)
		r += anchorAttributeToString(obj)
	else
		[_, extraParentsRef, propName] = ///^(?:(.+)\.)?(.+)$///.exec obj.name
		if extraParentsRef
			extraParentsRef = ".#{extraParentsRef}"
		else
			extraParentsRef = ''

		if isBinding(obj)
			binding = bindingAttributeToString(obj)
			if type is 'attr'
				r = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', #{binding})"
			else
				r = binding
			writeAsBinding = true
		else
			# if ///^Styles\[///.test(object.name)
			# 	rPre = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', null);\n"

			if value.type is OBJECT
				r += value.id
				rPre += stringObjectFull value
			else
				r += value

	switch type
		when 'attr'
			ref = "#{parentsRef}.#{obj.name}"
			if writeAsFunction
				rPre + "#{ref}(" + r + ", #{parents[0].id});\n" + rPost
			else if writeAsBinding
				rPre + r + ";\n" + rPost
			else
				rPre + "#{ref} = " + r + ";\n" + rPost
		when 'change'
			path = parentsRef.slice object.id.length+'changes.'.length+1
			path += '.' if path
			path += obj.name
			if writeAsBinding
				method = 'setBinding'
			else if writeAsFunction
				method = 'setFunction'
			else
				method = 'setAttribute'
			rPre + "#{object.id}.changes.#{method}('#{path}', #{r});\n" + rPost

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

	for child in getByType(obj.body, OBJECT)
		r += stringFunctions child

	attributes = getByType obj.body, FUNCTION
	for attribute in attributes
		r += stringAttribute attribute, [obj]

	r

stringObjectFull = (obj) ->
	if obj.type is CODE
		return obj.body

	assert obj.type is OBJECT, "stringObjectFull: type must be an object"

	code = stringObject obj
	code += stringBody obj
	code

stringBody = (obj) ->
	code = ''
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
	code += stringBody obj
	code += "});\n"
	code

stringFile = (file, isView=false) ->
	ids = {}

	code = 'var ids = {};\n'
	if isView
		code += stringViewObjectFull file
	else
		code += stringObjectFull file

	idsKeys = Object.keys ids

	if isView
		code += "setImmediate(function(){\n"
	code += "for (var _id in ids){\n"
	code += "	ids[_id]._isReady = true; ids[_id].ready(); ids[_id].onReady.disconnectAll();\n"
	code += "}\n"
	if isView
		code += "});\n"
	code

module.exports = (file, filename) ->
	elems = parser file
	ids = {}
	codes = {}
	waitsCode = ''

	objectIndex = 0
	for elem, i in elems
		if elem.type isnt 'object'
			waitsCode += stringObjectFull elem
			continue

		isView = objectIndex is 0 and filename is 'view'
		r = waitsCode
		waitsCode = ''
		r += stringFile elem, isView
		if objectIndex > 0 and elem.autoId
			codes._neftMain += r
		else
			r += "var mainItem = #{elem.id};\n"
			if objectIndex is 0
				codes._neftMain = r
			else
				codes[elem.id] = r
		objectIndex++

	if waitsCode
		codes._neftMain = waitsCode + codes._neftMain

	codes

# console.log module.exports("""
# Item {
# 	width: parent.width === this
# }
# """)._neftMain#, 'view'
