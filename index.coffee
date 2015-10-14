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

# options
i = 1
BINDING_THIS_TO_TARGET_OPTS = 1

ids = idsKeys = itemsKeys = extensions = queries = null

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

# BINDING = ///([a-zA-Z_$][a-zA-Z0-9_$]*)\.([a-zA-Z0-9_$]+)///
isBinding = (obj) ->
	assert obj.type is ATTRIBUTE, "isBinding: type must be an attribute"

	try
		eval "(function(console,module,require){return (#{obj.value});}).call(null,null,{},function(){})"
		return false

	# unless BINDING.test(obj.value)
	# 	console.log obj.value
	# 	return false

	true

getByType = (arr, type) ->
	r = []
	for elem in arr
		if elem.type is type
			r.push elem
	r

getByTypeRec = (arr, type, r=[]) ->
	for elem in arr
		if elem.type is type
			r.push elem
		if elem.body
			getByTypeRec elem.body, type, r
	r

getByTypeDeep = (elem, type, callback) ->
	if elem.type is type
		callback elem

	for child in elem.body
		if child.type is type
			callback child
		switch child.type
			when 'object'
				getByTypeDeep child, type, callback
			when 'attribute'
				if child.value?.type is 'object'
					getByTypeDeep child.value, type, callback

	return

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
	AmbientSound: true
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
	else if anchor[0] is 'null'
		return 'null'

	useBinding = false
	anchor[0] = switch anchor[0]
		when 'this.parent', 'parent'
			"'parent'"
		when 'this.children', 'children'
			"'children'"
		when 'this.nextSibling', 'nextSibling'
			"'nextSibling'"
		when 'this.previousSibling', 'previousSibling'
			"'previousSibling'"
		else
			useBinding = true
			"#{anchor[0]}"
	if anchor.length > 1
		anchor[1] = "'#{anchor[1]}'"
	r = "[#{anchor}]"

	if useBinding
		"[function(#{idsKeys}){return #{r}}, []]"
	else
		r

bindingAttributeToString = (obj) ->
	binding = ['']
	val = obj.value
	opts = obj._parserOptions or 0

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
		if id is 'parent' or id is 'nextSibling' or id is 'previousSibling' or id is 'target'
			elem.unshift "this"
		else if opts & BINDING_THIS_TO_TARGET_OPTS and id is 'this'
			elem.splice 1, 0, 'target'
		else if (id is 'this' or id is 'app' or id is 'view' or ids.hasOwnProperty(id) or id of Renderer) and (i is 0 or binding[i-1][binding[i-1].length - 1] isnt '.')
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
	# args = []
	for elem, i in binding
		if typeof elem is 'string'
			# elem = elem.replace ///\$///g, '$$$'
			# elem = elem.replace ///'///g, '\\\''
			# text += "'#{elem}'"
			hash += elem
		else if elem.length > 1
			if binding[i-1]? and text
				text += ", "

			text += repeatString('[', elem.length-1)
			text += "'#{elem[0]}'"
			if elem[0] is "this"
				hash += "this"
			else
				hash += "#{elem[0]}"
				# args.push elem[0]
			elem.shift()
			for id, i in elem
				text += ", '#{id}']"
				hash += ".#{id}"
		else
			# text += "#{elem[0]}"
			if elem[0] is "this"
				hash += "this"
			else
				hash += "#{elem[0]}"
				# args.push elem[0]

	hash = hash.trim()
	text = text.trim()

	# func = new Function hash
	args = idsKeys+''
	func = "function(#{args}){return #{hash}}"

	"[#{func}, [#{text}]]"

# stringObjectHead = (obj) ->
# 	assert obj.type is OBJECT, "stringObject: type must be an object"

# 	if getByType(obj.body, ID).length > 0
# 		if MODIFIERS_NAMES[obj.name]
# 			extensions[obj.id] = true
# 		else
# 			ids[obj.id] = true

# 	rendererCtor = Renderer[obj.name.split('.')[0]]
# 	isLocal = rendererCtor?
# 	decl = if isLocal then "new #{obj.name}" else "#{obj.name}"
# 	if MODIFIERS_NAMES[obj.name]
# 		r = "#{decl}('#{obj.id}', _i)\n"
# 	else
# 		r = "#{decl}('#{obj.id}', _i)\n"

# 		properties = getEachProp(getByType(obj.body, PROPERTY), 'name')
# 		for property in properties
# 			r += "_d.createProperty('#{utils.addSlashes(property)}')\n"

# 		signals = getEachProp(getByType(obj.body, SIGNAL), 'name')
# 		for signal in signals
# 			r += "_d.createSignal('#{utils.addSlashes(signal)}')\n"

# 	unless MODIFIERS_NAMES[obj.name]
# 		classBody = []
# 		obj.body = obj.body.filter (elem) ->
# 			if elem.type is ATTRIBUTE or (elem.type is FUNCTION and elem.name isnt 'onReady')
# 				classBody.push elem
# 				false
# 			else
# 				true

# 		defaultClass =
# 			type: 'object'
# 			name: 'Class'
# 			id: uid()
# 			autoId: true
# 			body: [{
# 				type: 'attribute'
# 				name: 'changes'
# 				value: classBody
# 			}]
# 			parent: obj
# 		obj.body.push defaultClass
# 		# r += stringObjectFull defaultClass
# 		# r += "#{obj.id}._defaultClasses.push(#{defaultClass.id});\n"
# 		# r += "#{defaultClass.id}.target = #{obj.id};\n"

# 	r

# stringObjectChildren = (obj) ->
# 	assert obj.type is OBJECT, "stringObject: type must be an object"

# 	r = ""

# 	for child in getByType(obj.body, OBJECT)
# 		r += stringObject child

# 		rendererCtor = Renderer[child.name.split('.')[0]]

# 		# if rendererCtor?.prototype instanceof Renderer.Extension
# 		# 	r += "_d.targets.append(_i)\n"
# 		# else
# 		# 	r += "#{child.id}.parent = #{obj.id};\n"

# 	r

# stringObject = (obj) ->
# 	r = stringObjectHead obj
# 	r += stringObjectChildren obj

# stringAttribute = (obj, parents) ->
# 	assert parents[0].type is OBJECT, "stringAttribute: first parent must be an object"

# 	object = parents[0]
# 	{value} = obj

# 	parentsRef = "_d."
# 	for parent in parents[1...]
# 		parentsRef += "#{parent.name}."
# 	parentsRef = parentsRef.slice 0, -1

# 	type = 'attr'
# 	writeAsBinding = false
# 	writeAsFunction = false
# 	if object.name is 'Class' and parents[1]?.name is 'changes'
# 		type = 'change'

# 	r = ''
# 	rPre = ''
# 	rPost = ''
# 	childParents = null

# 	if Array.isArray(value)
# 		rArr = "["

# 		for elem in value
# 			switch elem.type
# 				when OBJECT
# 					rArr += "#{elem.id}, "
# 					rPre += stringObjectFull elem
# 				when ATTRIBUTE, FUNCTION
# 					unless childParents
# 						childParents = parents.slice()
# 						childParents.push obj
# 					rPost += stringAttribute elem, childParents
# 				# when FUNCTION
# 				# 	rPost += stringAttribute elem, childParents
# 				else
# 					throw "Not implemented attribute type '#{elem.type}'"

# 		rArr = rArr.slice 0, -2
# 		if rArr.length > 0
# 			r += "#{rArr}]"
# 		else
# 			if parents.length > 1 or obj.name.indexOf('$.') is 0
# 				r += "{}"
# 			else
# 				return rPre + rPost
# 	else if obj.type is FUNCTION
# 		writeAsFunction = true
# 		func = Function obj.params or [], obj.body
# 		r += func
# 	else if isAnchor(obj)
# 		r += anchorAttributeToString(obj)
# 	else
# 		[_, extraParentsRef, propName] = ///^(?:(.+)\.)?(.+)$///.exec obj.name
# 		if extraParentsRef
# 			extraParentsRef = ".#{extraParentsRef}"
# 		else
# 			extraParentsRef = ''

# 		if isBinding(obj)
# 			binding = bindingAttributeToString(obj)
# 			if type is 'attr'
# 				r = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', #{binding})"
# 			else
# 				r = binding
# 			writeAsBinding = true
# 		else
# 			# if ///^Styles\[///.test(object.name)
# 			# 	rPre = "#{parentsRef}#{extraParentsRef}.createBinding('#{propName}', null);\n"

# 			if value.type is OBJECT
# 				r += value.id
# 				rPre += stringObjectFull value
# 			else
# 				r += value

# 	switch type
# 		when 'attr'
# 			ref = "#{parentsRef}.#{obj.name}"
# 			if writeAsFunction
# 				rPre + "#{ref}(" + r + ", #{parents[0].id})\n" + rPost
# 			else if writeAsBinding
# 				rPre + r + ";\n" + rPost
# 			else
# 				rPre + "#{ref} = " + r + "\n" + rPost
# 		when 'change'
# 			path = parentsRef.slice object.id.length+'changes.'.length+1
# 			path += '.' if path
# 			path += obj.name
# 			if writeAsBinding
# 				method = 'setBinding'
# 			else if writeAsFunction
# 				method = 'setFunction'
# 			else
# 				method = 'setAttribute'
# 			rPre + "_d.changes.#{method}('#{path}', #{r})\n" + rPost

# stringAttributes = (obj) ->
# 	assert obj.type is OBJECT, "stringAttributes: type must be an object"

# 	r = ''

# 	for child in getByType(obj.body, OBJECT)
# 		r += stringAttributes child

# 	for attribute in getByType(obj.body, ATTRIBUTE)
# 		r += stringAttribute attribute, [obj]

# 	r

# stringFunctions = (obj) ->
# 	assert obj.type is OBJECT, "stringFunctions: type must be an object"

# 	r = ''

# 	for child in getByType(obj.body, OBJECT)
# 		r += stringFunctions child

# 	attributes = getByType obj.body, FUNCTION
# 	for attribute in attributes
# 		r += stringAttribute attribute, [obj]

# 	r

# stringObjectFull = (obj) ->
# 	if obj.type is CODE
# 		return obj.body

# 	assert obj.type is OBJECT, "stringObjectFull: type must be an object"

# 	code = stringObject obj
# 	code += stringBody obj
# 	code

# stringBody = (obj) ->
# 	code = ''
# 	code += stringAttributes obj
# 	code += stringFunctions obj
# 	code

# stringViewObjectFull = (obj) ->
# 	if obj.type is CODE
# 		return obj.body

# 	assert obj.type is OBJECT, "stringObjectFull: type must be an object"

# 	code = stringObjectHead obj
# 	code += stringObjectChildren obj
# 	code += stringBody obj
# 	code

# stringFile = (file, isView=false) ->
# 	ids = {}
# 	extensions = {}

# 	# if isView
# 	# 	code += stringViewObjectFull file
# 	# else
# 	code += stringObjectFull file

# 	code

stringify =
	function: (elem) ->
		args = idsKeys+''
		if args and elem.params+''
			args += ","
		args += elem.params+''
		"function(#{args}){#{elem.body}}"
	object: (elem) ->
		json = {}
		children = []
		postfix = ''

		attrToValue = (body) ->
			{value} = body

			if body.name is 'document.query' and not MODIFIERS_NAMES[body.parent.name]
				if isBinding(body)
					throw new Error 'document.query must be a string'
				if value
					query = ''
					tmp = body

					# get value
					while tmp = tmp.parent
						for child in tmp.body
							if child.name is 'document.query'
								query = child.value.replace(/'/g, '') + ' ' + query
								break
					query = query.trim()

					# get ids
					id = ''
					if body.parent.parent
						id = ':' + body.parent.id

					# save query
					queries[query] = id
			else if Array.isArray(value)
				r = {}
				for child in value
					r[child.name] = "`#{attrToValue(child)}`"
				r = JSON.stringify r
				postfix += ", \"#{body.name}\": #{r}"
				return false
			else if value?.type is 'object'
				valueCode = stringify.object value
				# postfix += ", \"#{body.name}\": ((#{valueCode}), new Renderer.Component.Link('#{value.id}'))"
				# return false
				value = "((#{valueCode}), new Renderer.Component.Link('#{value.id}'))"
			else if body.type is 'function'
				value = stringify.function body
			else if isAnchor(body)
				value = anchorAttributeToString(body)
			else if isBinding(body)
				value = bindingAttributeToString(body)
			value

		unless elem.id
			json.id = elem.id = "i#{utils.uid()}"

		for body in elem.body
			switch body.type
				when 'id'
					json.id = body.value
				when 'object'
					children.push stringify.object(body)
				when 'attribute'
					value = attrToValue body
					if value isnt false
						json[body.name] = "`#{value}`"
				when 'function'
					json[body.name] = "`#{stringify.function body}`"
				when 'property'
					json.properties ?= []
					json.properties.push body.name
				when 'signal'
					json.signals ?= []
					json.signals.push body.name
				else
					if stringify[body.type]?
						children.push stringify[body.type](body)
					else
						throw "Unexpected object body type '#{body.type}'"

		if not elem.parent and elem.name is 'Class' and not json.target
			json.target = "`view`"

		# unless MODIFIERS_NAMES[elem.name]
		itemsKeys.push json.id
		visibleId = json.id

		if utils.has(idsKeys, json.id)
			visibleId = json.id

		json = JSON.stringify json, null, 4

		if children.length
			postfix += ", children: ["
			for child, i in children
				if i > 0
					postfix += ", "
				postfix += child
			postfix += "]"

		if postfix
			if json.length is 2
				postfix = postfix.slice(2)
			json = json.slice 0, -1
			json += postfix
			json += "}"

		json = json.replace /"`(.*?)`"/g, (_, val) ->
			JSON.parse "\"#{val}\""

		rendererCtor = Renderer[elem.name.split('.')[0]]
		if rendererCtor?
			r = "new Renderer.#{elem.name}(_c, #{json})\n"
		else
			r = "Renderer.Component.getCloneFunction(#{elem.name}, '#{elem.name}')(_c, #{json})\n"
		if visibleId
			r = "#{visibleId} = #{r}"
		r
	if: (elem) ->
		cond = elem.condition

		elem.type = 'object'
		elem.name = 'Class'
		elem.body = [{
			type: 'attribute'
			name: 'when'
			value: cond
			_parserOptions: BINDING_THIS_TO_TARGET_OPTS
		}, {
			type: 'attribute'
			name: 'changes'
			value: elem.body
		}]

		stringify.object elem

getIds = (elem, ids={}) ->
	elems = getByTypeDeep elem, 'id', (attr) ->
		ids[attr.value] = attr.parent
	ids

module.exports = (file, filename) ->
	elems = parser file
	codes = {}
	autoInitCodes = []
	bootstrap = ''
	firstId = null
	allQueries = {}

	for elem, i in elems
		queries = {}
		id = elem.id
		ids = getIds elem
		idsKeys = Object.keys(ids).filter (id) -> !!id
		itemsKeys = []
		code = "var _c = new Renderer.Component({fileName: '#{filename}'})\n"
		if elem.type is 'code'
			bootstrap += elem.body
			continue
		if typeof stringify[elem.type] isnt 'function'
			console.error "Unexpected block type '#{elem.type}'"
			continue
		elemCode = stringify[elem.type] elem

		objectsIds = idsKeys.slice()
		for id in itemsKeys
			unless utils.has(objectsIds, id)
				objectsIds.push id
		if objectsIds.length
			code += "var #{objectsIds}\n"

		objects = utils.arrayToObject objectsIds,
			(i, elem) -> elem,
			(i, elem) -> "`#{elem}`"

		code += '_c.item = '
		code += elemCode
		code += "_c.itemId = '#{elem.id}'\n"
		code += "_c.idsOrder = #{JSON.stringify(idsKeys)}\n"
		code += "_c.objectsOrder = #{JSON.stringify(idsKeys).replace(/\"/g, '')}\n"
		code += "_c.objects = #{JSON.stringify(objects).replace(/\"`|`\"/g, '')}\n"

		if elem.name is 'Class'
			code += "_c.item.enable();\n"
			autoInitCodes.push code
		else
			code += 'return _c.createItem\n'
			uid = 'n' + utils.uid()
			id ||= uid
			if codes[id]?
				id = uid
			codes[id] = code
			firstId ?= id

		# queries
		for query, val of queries
			val = id + val

			if allQueries[query]?
				throw new Error "document.query '#{query}' is duplicated"
			allQueries[query] = val

	if not codes._main and firstId
		codes._main = link: firstId

	bootstrap: bootstrap
	codes: codes
	autoInitCodes: autoInitCodes
	queries: allQueries

# codes = module.exports("""
# Image {
# 	id: main
# 	Class {
# 		changes: {
# 			ab: 2
# 			onReady: function(){
# 				console.log(123);
# 			}
# 		}
# 	}
# }
# """).codes
# console.log codes
# console.log codes[Object.keys(codes)[0]]
