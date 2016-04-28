'use strict'

parser = require './parser'
bindingParser = require 'neft-binding/parser'

{utils, Renderer, assert} = Neft

ATTRIBUTE = 'attribute'

# options
{BINDING_THIS_TO_TARGET_OPTS} = bindingParser

ids = idsKeys = itemsKeys = extensions = queries = null

isAnchor = (obj) ->
	assert obj.type is ATTRIBUTE, "isAnchor: type must be an attribute"

	obj.name is 'anchors' or obj.name.indexOf('anchors.') is 0

isBinding = (obj) ->
	assert obj.type is ATTRIBUTE, "isBinding: type must be an attribute"

	bindingParser.isBinding obj.value

getByTypeDeep = (elem, type, callback) ->
	if elem.type is type
		callback elem

	for child in elem.body
		if child.type is type
			callback child
		if child.body?
			getByTypeDeep child, type, callback
		else if child.value?.body
			getByTypeDeep child.value, type, callback

	return

MODIFIERS_NAMES =
	__proto__: null
	Class: true
	Transition: true
	Animation: true
	PropertyAnimation: true
	NumberAnimation: true
	FontLoader: true
	ResourcesLoader: true

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

isPublicBindingId = (id) ->
	id is 'this' or id is 'app' or id is 'view' or ids.hasOwnProperty(id) or id of Renderer

bindingAttributeToString = (obj) ->
	binding = bindingParser.parse obj.value, isPublicBindingId, obj._parserOptions
	args = idsKeys+''
	func = "function(#{args}){return #{binding.hash}}"

	"[#{func}, [#{binding.connections}]]"

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
				when 'attribute'
					value = attrToValue body
					if value isnt false
						json[body.name] = "`#{value}`"
				when 'function'
					json[body.name] = "`#{stringify.function body}`"
				when 'object'
					children.push stringify.object(body)
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
			r = "Renderer.#{elem.name}.New(_c, #{json})\n"
		else
			r = "Renderer.Component.getCloneFunction(#{elem.name}, '#{elem.name}')(_c, #{json})\n"
		if visibleId
			r = "#{visibleId} = #{r}"
		r
	if: (elem) ->
		changes = []
		body = []

		for child in elem.body
			if child.type in ['attribute', 'function']
				changes.push child
			else
				body.push child

		elem.type = 'object'
		elem.name = 'Class'
		elem.body = [{
			type: 'attribute'
			name: 'when'
			value: elem.condition
			parent: elem
			_parserOptions: BINDING_THIS_TO_TARGET_OPTS
		}, {
			type: 'attribute'
			name: 'changes'
			value: changes
			parent: elem
		}, body...]

		stringify.object elem
	for: (elem) ->
		changes = []
		body = []

		for child in elem.body
			if child.type in ['attribute', 'function']
				changes.push child
			else
				body.push child

		elem.type = 'object'
		elem.name = 'Class'
		elem.body = [{
			type: 'attribute'
			name: 'document.query'
			value: elem.query
			parent: elem
		}, {
			type: 'attribute'
			name: 'changes'
			value: changes
			parent: elem
		}, body...]

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
			code += "_c.initAsEmptyDefinition()\n"
			code += "_c.item.enable()\n"
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