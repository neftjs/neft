File @class
===========

	'use strict'

	utils = require 'neft-utils'
	assert = require 'neft-assert'
	log = require 'neft-log'
	signal = require 'neft-signal'
	Dict = require 'neft-dict'
	List = require 'neft-list'

	assert = assert.scope 'View'
	log = log.scope 'View'

	{Emitter} = signal

	module.exports = class File extends Emitter
		files = @_files = {}
		pool = Object.create null

		getFromPool = (path) ->
			arr = pool[path]
			if arr?.length
				i = n = arr.length
				while file = arr[--i]
					arr[i] = arr[n-1]
					arr.pop()
					return file

		@__name__ = 'File'
		@__path__ = 'File'

		@JSON_CTORS = []
		JSON_CTOR_ID = @JSON_CTOR_ID = @JSON_CTORS.push(File) - 1

		i = 1
		JSON_PATH = i++
		JSON_NODE = i++
		JSON_TARGET_NODE = i++
		JSON_ATTRS_TO_PARSE = i++
		JSON_FRAGMENTS = i++
		JSON_ATTR_CHANGES = i++
		JSON_INPUTS = i++
		JSON_CONDITIONS = i++
		JSON_ITERATORS = i++
		JSON_USES = i++
		JSON_IDS = i++
		JSON_FUNCS = i++
		JSON_ATTRS_TO_SET = i++
		JSON_LOGS = i++
		JSON_STYLES = i++
		JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

		@HTML_NS = 'neft'

		signal.create @, 'onCreate'
		signal.create @, 'onError'
		signal.create @, 'onBeforeParse'
		signal.create @, 'onParse'

*Signal* File.onBeforeRender(*File* file)
-----------------------------------------

Corresponding node handler: *neft:onBeforeRender=""*.

		signal.create @, 'onBeforeRender'

*Signal* File.onRender(*File* file)
-----------------------------------

Corresponding node handler: *neft:onRender=""*.

		signal.create @, 'onRender'

*Signal* File.onBeforeRevert(*File* file)
-----------------------------------------

Corresponding node handler: *neft:onBeforeRevert=""*.

		signal.create @, 'onBeforeRevert'

*Signal* File.onRevert(*File* file)
-----------------------------------

Corresponding node handler: *neft:onRevert=""*.

		signal.create @, 'onRevert'

		@Element = require('./element/index')
		@AttrChange = require('./attrChange') @
		@Use = require('./use') @
		@Input = require('./input') @
		@Condition = require('./condition') @
		@Iterator = require('./iterator') @
		@Log = require('./log') @
		@Func = require('./func') @
		@AttrsToSet = require('./attrsToSet') @

*File* File.fromHTML(*String* path, *String* html)
--------------------------------------------------

		@fromHTML = do ->
			unless utils.isNode
				return (path, html) ->
					throw new Error "Document.fromHTML is available only on the server"

			clear = require('./file/clear') File

			(path, html) ->
				assert.isString path
				assert.notLengthOf path, 0
				assert.notOk files[path]?
				assert.isString html

				if html is ''
					html = '<html></html>'

				# get node
				node = File.Element.fromHTML html

				# clear
				clear node

				# create file
				File.fromElement path, node

*File* File.fromElement(*String* path, *Element* element)
---------------------------------------------------------

		@fromElement = (path, node) ->
			assert.isString path
			assert.notLengthOf path, 0
			assert.instanceOf node, File.Element
			assert.notOk files[path]?

			# create
			file = new File path, node

*File* File.fromJSON(*String|Object* json)
------------------------------------------

		@fromJSON = (json) ->
			# parse json
			if typeof json is 'string'
				json = utils.tryFunction JSON.parse, null, [json], json

			assert.isArray json

			if file = files[json[JSON_PATH]]
				return file

			file = File.JSON_CTORS[json[0]]._fromJSON json
			assert.notOk files[file.path]?

			# save to storage
			files[file.path] = file

			file

		@_fromJSON = do ->
			parseObject = (file, obj, target) ->
				for key, val of obj
					target[key] = File.JSON_CTORS[val[0]]._fromJSON file, val
				return

			parseArray = (file, arr, target) ->
				for val in arr
					target.push File.JSON_CTORS[val[0]]._fromJSON file, val
				return

			(arr, obj) ->
				unless obj
					node = File.Element.fromJSON arr[JSON_NODE]
					obj = new File arr[JSON_PATH], node

				# targetNode
				if arr[JSON_TARGET_NODE]
					obj.targetNode = node.getChildByAccessPath arr[JSON_TARGET_NODE]

				# attrsToParse
				{attrsToParse} = obj
				jsonAttrsToParse = arr[JSON_ATTRS_TO_PARSE]
				for attrNode, i in jsonAttrsToParse by 2
					attrsToParse.push node.getChildByAccessPath(attrNode)
					attrsToParse.push jsonAttrsToParse[i+1]

				utils.merge obj.fragments, arr[JSON_FRAGMENTS]
				parseArray obj, arr[JSON_ATTR_CHANGES], obj.attrChanges
				parseArray obj, arr[JSON_INPUTS], obj.inputs
				parseArray obj, arr[JSON_CONDITIONS], obj.conditions
				parseArray obj, arr[JSON_ITERATORS], obj.iterators
				parseArray obj, arr[JSON_USES], obj.uses

				for id, path of arr[JSON_IDS]
					obj.ids[id] = obj.node.getChildByAccessPath path

				utils.merge obj.funcs, arr[JSON_FUNCS]
				parseArray obj, arr[JSON_ATTRS_TO_SET], obj.attrsToSet

				`//<development>`
				parseArray obj, arr[JSON_LOGS], obj.logs
				`//</development>`

				parseArray obj, arr[JSON_STYLES], obj.styles

				obj

File.parse(*File* file)
-----------------------

		@parse = do ->
			unless utils.isNode
				return (file) ->
					throw new Error "Document.parse() is available only on the server"

			rules = require('./file/parse/rules') File
			fragments = require('./file/parse/fragments') File
			attrs = require('./file/parse/attrs') File
			attrChanges = require('./file/parse/attrChanges') File
			iterators = require('./file/parse/iterators') File
			target = require('./file/parse/target') File
			uses = require('./file/parse/uses') File
			storage = require('./file/parse/storage') File
			conditions = require('./file/parse/conditions') File
			ids = require('./file/parse/ids') File
			logs = require('./file/parse/logs') File
			funcs = require('./file/parse/funcs') File
			attrSetting = require('./file/parse/attrSetting') File

			(file) ->
				assert.instanceOf file, File
				assert.notOk files[file.path]?

				files[file.path] = file

				# trigger signal
				File.onBeforeParse.emit file

				# parse
				rules file
				fragments file
				iterators file
				attrs file
				attrChanges file
				target file
				uses file
				storage file
				conditions file
				ids file
				funcs file
				attrSetting file
				`//<development>`
				logs file
				`//</development>`

				# trigger signal
				File.onParse.emit file

*File* File.factory(*String* path)
----------------------------------

		@factory = (path) ->
			unless files.hasOwnProperty path
				# TODO: trigger here instance of `LoadError` class
				File.onError.emit path

			assert.isString path, "path is not a string"
			assert.ok files[path]?, "the given file path doesn't exist"

			# from pool
			if r = getFromPool(path)
				return r

			# clone original
			file = files[path].clone()

			File.onCreate.emit file

			file

*File* File(*String* path, *Element* element)
---------------------------------------------

		@emitNodeSignal = emitNodeSignal = (file, attrName, attr1, attr2) ->
			if nodeSignal = file.node.attrs[attrName]
				nodeSignal?.call? file, attr1, attr2
			return

		constructor: (@path, @node) ->
			assert.isString @path
			assert.notLengthOf @path, 0
			assert.instanceOf @node, File.Element

			super()

			@isClone = false
			@uid = utils.uid()
			@isRendered = false
			@targetNode = null
			@parent = null
			@storage = null
			@source = null
			@parentUse = null

			@attrsToParse = []
			@fragments = {}
			@attrChanges = []
			@inputs = []
			@conditions = []
			@iterators = []
			@uses = []
			@ids = {}
			@funcs = {}
			@attrsToSet = []
			@logs = []
			@styles = []
			@inputIds = new Dict
			@inputFuncs = new Dict
			@inputAttrs = new Dict
			@inputArgs = [@inputIds, @inputFuncs, @inputAttrs]

			@node.onAttrsChange onNodeAttrsChange, @
			@inputAttrs.extend @node.attrs

			`//<development>`
			if @constructor is File
				Object.preventExtensions @
			`//</development>`

*File* File::render([*Any* data, *File* source])
------------------------------------------------

		render: (storage, source) ->
			unless @isClone
				@clone().render storage, source
			else
				@_render(storage, source)

		onNodeAttrsChange = (name) ->
			if @source and @source.file.inputAttrs isnt @source.node.attrs[name] isnt undefined
				return
			@inputAttrs.set name, @node.attrs[name]
			return

		onSourceFileAttrsChange = (name) ->
			if @source.node.attrs[name] is undefined
				@inputAttrs.set name, @source.file.inputAttrs[name]
			return

		onSourceNodeAttrsChange = (name) ->
			@inputAttrs.set name, @source.node.attrs[name]
			return

		_render: do ->
			renderTarget = require('./file/render/parse/target') File

			(storage, source) ->
				assert.notOk @isRendered

				if storage?
					@storage = storage
				@source = source

				if source?
					# attrs
					{inputAttrs} = @
					viewAttrs = @node.attrs
					sourceFileAttrs = source.file.inputAttrs
					sourceAttrs = source.node.attrs
					sourceFileAttrs.onChange onSourceFileAttrsChange, @
					source.node.onAttrsChange onSourceNodeAttrsChange, @
					for prop, val of inputAttrs
						if viewAttrs[prop] is sourceAttrs[prop] is sourceFileAttrs[prop] is undefined
							inputAttrs.pop prop
					for ptop, val of viewAttrs
						if sourceAttrs[prop] is sourceFileAttrs[prop] is undefined
							if val isnt undefined
								inputAttrs.set prop, val
					for prop, val of sourceFileAttrs
						if sourceAttrs[prop] is undefined
							inputAttrs.set prop, val
					for prop, val of sourceAttrs
						if val isnt undefined
							inputAttrs.set prop, val

					# ids
					{inputIds} = @
					viewIds = @ids
					sourceIds = source.file.inputIds
					for prop, val of inputIds
						if viewIds[prop] is undefined and sourceIds[prop] is undefined
							inputIds.pop prop
					for prop, val of sourceIds
						if viewIds[prop] is undefined
							inputIds.set prop, val
					for prop, val of viewIds
						inputIds.set prop, val

					# funcs
					{inputFuncs} = @
					viewFuncs = @funcs
					sourceFuncs = source.file.inputFuncs
					for prop, val of inputFuncs
						if viewFuncs[prop] is undefined and sourceFuncs[prop] is undefined
							inputFuncs.pop prop
					for prop, val of sourceFuncs
						if viewFuncs[prop] is undefined
							inputFuncs.set prop, val
					for prop, val of viewFuncs
						inputFuncs.set prop, val

				File.onBeforeRender.emit @
				emitNodeSignal @, 'neft:onBeforeRender'

				# inputs
				for input, i in @inputs
					input.render()

				# conditions
				for condition, i in @conditions
					condition.render()

				# uses
				for use in @uses
					unless use.isRendered
						use.render()

				# iterators
				for iterator, i in @iterators
					iterator.render()

				# source
				renderTarget @, source

				# logs
				`//<development>`
				for log in @logs
					log.render()
				`//</development>`

				@isRendered = true
				File.onRender.emit @
				emitNodeSignal @, 'neft:onRender'

				@

*File* File::revert()
---------------------

		revert: do ->
			target = require('./file/render/revert/target') File
			->
				assert.ok @isRendered

				@isRendered = false
				File.onBeforeRevert.emit @
				emitNodeSignal @, 'neft:onBeforeRevert'

				# attrs
				if @source
					@source.file.inputAttrs.onChange.disconnect onSourceFileAttrsChange, @
					@source.node.onAttrsChange.disconnect onSourceNodeAttrsChange, @

				# parent use
				@parentUse?.detachUsedFragment()

				# inputs
				if @inputs
					for input, i in @inputs
						input.revert()

				# uses
				if @uses
					for use in @uses
						use.revert()

				# iterators
				if @iterators
					for iterator, i in @iterators
						iterator.revert()

				# target
				target @, @source

				@storage = null
				@source = null

				File.onRevert.emit @
				emitNodeSignal @, 'neft:onRevert'

				@

*File* File::use(*String* useName, [*File* document])
-----------------------------------------------------

		use: (useName, view) ->
			if @uses
				for use in @uses
					if use.name is useName
						elem = use
						break

			if elem
				elem.render view
			else
				log.warn "'#{@path}' view doesn't have '#{useName}' neft:use"

			@

*Signal* File::onReplaceByUse(*File.Use* use)
---------------------------------------------

Corresponding node handler: *neft:onReplaceByUse=""*.

		Emitter.createSignal @, 'onReplaceByUse'

*File* File::clone()
--------------------

		clone: ->
			# from pool
			if r = getFromPool(@path)
				r
			else
				if @isClone and (original = files[@path])
					original._clone()
				else
					@_clone()

		parseAttr = do ->
			cache = Object.create null
			(val) ->
				func = cache[val] ?= new Function 'Dict', 'List', "return #{val}"
				func Dict, List

		_clone: ->
			clone = new File @path, @node.cloneDeep()
			clone.isClone = true
			clone.fragments = @fragments

			if @targetNode
				clone.targetNode = @node.getCopiedElement @targetNode, clone.node

			# attrsToParse
			{attrsToParse} = @
			for attrNode, i in attrsToParse by 2
				attrNode = @node.getCopiedElement attrNode, clone.node
				attrName = attrsToParse[i+1]
				attrNode.attrs.set attrName, parseAttr(attrNode.attrs[attrName])

			# attrChanges
			for attrChange in @attrChanges
				clone.attrChanges.push attrChange.clone @, clone

			# ids
			for id, node of @ids
				clone.ids[id] = @node.getCopiedElement node, clone.node
			clone.inputIds.extend clone.ids

			# funcs
			for name, func of @funcs
				clone.funcs[name] = File.Func.bindFuncIntoGlobal func, clone
			clone.inputFuncs.extend clone.funcs

			# inputs
			for input in @inputs
				clone.inputs.push input.clone @, clone

			# conditions
			for condition in @conditions
				clone.conditions.push condition.clone @, clone

			# iterators
			for iterator in @iterators
				clone.iterators.push iterator.clone @, clone

			# uses
			for use in @uses
				clone.uses.push use.clone @, clone

			# attrs to set
			for attrsToSet in @attrsToSet
				clone.attrsToSet.push attrsToSet.clone @, clone

			# logs
			for log in @logs
				clone.logs.push log.clone @, clone

			clone

File::destroy()
---------------

		destroy: ->
			if @isRendered
				@revert()

			pathPool = pool[@path] ?= []
			assert.notOk utils.has(pathPool, @)

			pathPool.push @
			return

*Object* File::toJSON()
-----------------------

		toJSON: do ->
			callToJSON = (elem) ->
				elem.toJSON()

			(key, arr) ->
				if @isClone and original = File._files[@path]
					return original.toJSON key, arr

				unless arr
					arr = new Array JSON_ARGS_LENGTH
					arr[0] = JSON_CTOR_ID
				arr[JSON_PATH] = @path
				arr[JSON_NODE] = @node.toJSON()

				# targetNode
				if @targetNode
					arr[JSON_TARGET_NODE] = @targetNode.getAccessPath @node

				# attrsToParse
				attrsToParse = arr[JSON_ATTRS_TO_PARSE] = new Array @attrsToParse.length
				for attrNode, i in @attrsToParse by 2
					attrsToParse[i] = attrNode.getAccessPath @node
					attrsToParse[i+1] = @attrsToParse[i+1]

				arr[JSON_FRAGMENTS] = @fragments
				arr[JSON_ATTR_CHANGES] = @attrChanges.map callToJSON
				arr[JSON_INPUTS] = @inputs.map callToJSON
				arr[JSON_CONDITIONS] = @conditions.map callToJSON
				arr[JSON_ITERATORS] = @iterators.map callToJSON
				arr[JSON_USES] = @uses.map callToJSON

				ids = arr[JSON_IDS] = {}
				for id, node of @ids
					ids[id] = node.getAccessPath @node

				arr[JSON_FUNCS] = @funcs
				arr[JSON_ATTRS_TO_SET] = @attrsToSet

				`//<development>`
				arr[JSON_LOGS] = @logs.map callToJSON
				`//</development>`
				`//<production>`
				arr[JSON_LOGS] = []
				`//</production>`

				arr[JSON_STYLES] = @styles.map callToJSON

				arr
