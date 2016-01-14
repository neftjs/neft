File @class
===========

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	log = require 'log'
	signal = require 'signal'
	Dict = require 'dict'
	List = require 'list'

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
					if file.readyToUse
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

		signal.create @, 'onBeforeRender'

*Signal* File.onRender(*File* file)
-----------------------------------

		signal.create @, 'onRender'

*Signal* File.onBeforeRevert(*File* file)
-----------------------------------------

		signal.create @, 'onBeforeRevert'

*Signal* File.onRevert(*File* file)
-----------------------------------

		signal.create @, 'onRevert'

		@Element = require('./element/index')
		@AttrChange = require('./attrChange') @
		@Fragment = require('./fragment') @
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

			# save to storage
			files[file.path] = file

*File* File.fromJSON(*String|Object* json)
------------------------------------------

		@fromJSON = (json) ->
			# parse json
			if typeof json is 'string'
				json = utils.tryFunction JSON.parse, null, [json], json

			assert.isArray json

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

				if arr[JSON_TARGET_NODE]
					obj.targetNode = node.getChildByAccessPath arr[JSON_TARGET_NODE]

				parseObject obj, arr[JSON_FRAGMENTS], obj.fragments
				parseArray obj, arr[JSON_ATTR_CHANGES], obj.attrChanges
				parseArray obj, arr[JSON_INPUTS], obj.inputs
				parseArray obj, arr[JSON_CONDITIONS], obj.conditions
				parseArray obj, arr[JSON_ITERATORS], obj.iterators
				parseArray obj, arr[JSON_USES], obj.uses

				for id, path of arr[JSON_IDS]
					obj.ids[id] = obj.node.getChildByAccessPath path

				parseObject obj, arr[JSON_FUNCS], obj.funcs
				parseArray obj, arr[JSON_ATTRS_TO_SET], obj.attrsToSet
				parseArray obj, arr[JSON_LOGS], obj.logs
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

				# trigger signal
				File.onBeforeParse.emit file

				# parse
				rules file
				fragments file
				attrs file
				iterators file
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

			assert.isString path
			assert.ok files[path]?

			# from pool
			if r = getFromPool(path)
				return r

			# clone original
			file = files[path].clone()

			File.onCreate.emit file

			file

*File* File(*String* path, *Element* element)
---------------------------------------------

		constructor: (@path, @node) ->
			assert.isString path
			assert.notLengthOf path, 0
			assert.instanceOf node, File.Element

			super()

			@isClone = false
			@uid = utils.uid()
			@isRendered = false
			@readyToUse = true
			@targetNode = null
			@parent = null
			@storage = null
			@source = null
			@parentUse = null

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

		_render: do ->
			renderTarget = require('./file/render/parse/target') File

			(storage, source) ->
				assert.notOk @isRendered
				assert.ok @readyToUse

				if storage instanceof File.Use
					source = storage
					storage = null

				if storage?
					@storage = storage
				@source = source

				File.onBeforeRender.emit @

				# inputs
				if @inputs
					for input, i in @inputs
						input.render()

				# uses
				if @uses
					for use in @uses
						use.render()

				# iterators
				if @iterators
					for iterator, i in @iterators
						iterator.render()

				# conditions
				if @conditions
					for condition, i in @conditions
						condition.render()

				# source
				renderTarget @, source

				# logs
				`//<development>`
				for log in @logs
					log.render()
				`//</development>`

				@isRendered = true
				File.onRender.emit @

				@

*File* File::revert()
---------------------

		revert: do ->
			target = require('./file/render/revert/target') File
			->
				assert.ok @isRendered

				@isRendered = false
				File.onBeforeRevert.emit @

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
				log.warn "`#{@path}` view doesn't have any `#{useName}` neft:use"

			@

*Signal* File::onReplaceByUse(*File.Use* use)
---------------------------------------------

		Emitter.createSignal @, 'onReplaceByUse'

*File* File::clone()
--------------------

		clone: ->
			# from pool
			if r = getFromPool(@path)
				r
			else
				@_clone()

		_clone: ->
			clone = new File @path, @node.cloneDeep()
			clone.isClone = true
			clone.fragments = @fragments

			if @targetNode
				targetNode = @node.getCopiedElement @targetNode, clone.node

			# attrChanges
			for attrChange in @attrChanges
				clone.attrChanges.push attrChange.clone @, clone

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

			# ids
			for id, node of @ids
				clone.ids[id] = @node.getCopiedElement node, clone.node

			# funcs
			for name, func of @funcs
				clone.funcs[name] = File.Func.bindFuncIntoGlobal func, clone

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

		toJSON: (key, arr) ->
			unless arr
				arr = new Array JSON_ARGS_LENGTH
				arr[0] = JSON_CTOR_ID
			arr[JSON_PATH] = @path
			arr[JSON_NODE] = @node.toJSON()

			# targetNode
			if @targetNode
				arr[JSON_TARGET_NODE] = @targetNode.getAccessPath @node

			arr[JSON_FRAGMENTS] = @fragments
			arr[JSON_ATTR_CHANGES] = @attrChanges
			arr[JSON_INPUTS] = @inputs
			arr[JSON_CONDITIONS] = @conditions
			arr[JSON_ITERATORS] = @iterators
			arr[JSON_USES] = @uses

			ids = arr[JSON_IDS] = {}
			for id, node of @ids
				ids[id] = node.getAccessPath @node

			arr[JSON_FUNCS] = @funcs
			arr[JSON_ATTRS_TO_SET] = @attrsToSet

			`//<development>`
			arr[JSON_LOGS] = @logs
			`//</development>`
			`//<production>`
			arr[JSON_LOGS] = []
			`//</production>`

			arr[JSON_STYLES] = @styles

			arr
