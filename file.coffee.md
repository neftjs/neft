File @class
===========

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'
	Emitter = require 'emitter'
	signal = require 'signal'
	Dict = require 'dict'
	List = require 'list'

	assert = assert.scope 'View'
	log = log.scope 'View'

	module.exports = class File
		files = @_files = {}
		pool = Object.create null

		getTmp = -> tmp =
			listeners: []

		@__name__ = 'File'
		@__path__ = 'File'

		@CREATE = 'create'
		@ERROR = 'error'
		@HTML_NS = 'neft'

		utils.merge @, Emitter::
		Emitter.call @

		signal.create @, 'onBeforeParse'
		signal.create @, 'onParse'

*Signal* File.render(*File* file)
---------------------------------

		signal.create @, 'onRender'

*Signal* File.revert(*File* file)
---------------------------------

		signal.create @, 'onBeforeRevert'

		@Element = require('./element/index')
		@AttrChange = require('./attrChange') @
		@Fragment = require('./fragment') @
		@Use = require('./use') @
		@Input = require('./input') @
		@Condition = require('./condition') @
		@Iterator = require('./iterator') @

*File* File.fromHTML(*String* path, *String* html)
--------------------------------------------------

		@fromHTML = do ->
			clear = require('./file/clear') File

			(path, html) ->
				assert.isString path
				assert.notLengthOf path, 0
				assert.notOk files[path]?
				assert.isString html
				assert.notLengthOf html, 0, "Can't load '#{path}' document file, because it's empty"

				# get node
				node = File.Element.fromHTML html

				# clear
				clear node

				# create file
				file = new File path, node

				file

*File* File.fromJSON(*String* path, *String|Object* json)
---------------------------------------------------------

		@fromJSON = do (ctorsCache={}) -> (path, json) ->
			assert.isString path
			assert.notLengthOf path, 0
			assert.notOk files[path]?

			# parse json
			if typeof json is 'string'
				json = utils.tryFunction JSON.parse, null, [json], json

			assert.isPlainObject json

			# put ctors
			ns = File: File, Dict: Dict, List: List
			for i, ctor of ctors = json.constructors
				ctorsCache[ctor] ?= utils.get ns, ctor
				ctors[i] = ctorsCache[ctor]

			# assemble
			json = utils.assemble json

			# save to storage
			files[path] = json

			json

*File* File.factory(*String* path)
----------------------------------

		@factory = (path) ->
			unless files.hasOwnProperty path
				# TODO: trigger here instance of `LoadError` class
				File.trigger File.ERROR, path

			assert.isString path
			assert.ok files[path]?

			# from pool
			if pool[path]?.length
				return pool[path].pop()

			# clone original
			file = files[path].clone()

			File.trigger File.CREATE, file

			file

*File* File(*String* path, *Element* element)
---------------------------------------------

		constructor: do ->
			if utils.isNode
				rules = require('./file/parse/rules') File
				fragments = require('./file/parse/fragments') File
				attrs = require('./file/parse/attrs') File
				attrChanges = require('./file/parse/attrChanges') File
				iterators = require('./file/parse/iterators') File
				source = require('./file/parse/source') File
				uses = require('./file/parse/uses') File
				storage = require('./file/parse/storage') File
				conditions = require('./file/parse/conditions') File
				ids = require('./file/parse/ids') File

			(@path, @node) ->
				assert.isString path
				assert.notLengthOf path, 0
				assert.instanceOf node, File.Element
				assert.notOk files[path]?

				# set properties
				@pathbase = path.substring 0, path.lastIndexOf('/') + 1
				@isRendered = false

				# call init
				@init()

				# clone tmp
				utils.defineProperty @, '_tmp', utils.WRITABLE, getTmp()

				# trigger signal
				File.onBeforeParse.emit @

				# parse
				rules @
				fragments @
				attrs @
				attrChanges @
				iterators @
				source @
				uses @
				storage @
				conditions @
				ids @

				# trigger signal
				File.onParse.emit @

				# save to storage
				files[@path] = @

				@

		uid: ''
		isRendered: false
		node: null
		sourceNode: null
		path: ''
		pathbase: ''
		parent: null
		attrChanges: null
		fragments: null
		uses: null
		inputs: null
		conditions: null
		iterators: null
		storage: null
		source: null
		ids: null

		init: ->

*File* File::render([*Any* data, *File* source])
------------------------------------------------

		render: (storage, source) ->
			if @clone
				@clone().render storage, source
			else
				@_render(storage, source)

		_render: do ->
			renderSource = require('./file/render/parse/source') File

			(storage, source) ->
				assert.notOk @isRendered

				if storage instanceof File.Use
					source = storage
					storage = null

				if storage?
					@storage = storage
				@source = source

				# inputs
				if @inputs
					for input, i in @inputs
						input.render()

				# conditions
				if @conditions
					for condition, i in @conditions
						condition.render()

				# uses
				if @uses
					for use in @uses
						use.render()

				# iterators
				if @iterators
					for iterator, i in @iterators
						iterator.render()

				# source
				renderSource @, source

				@isRendered = true
				File.onRender.emit @

				@

*File* File::revert()
---------------------

		revert: do ->
			listeners = require('./file/render/revert/listeners') File
			source = require('./file/render/revert/source') File
			->
				assert.ok @isRendered

				@isRendered = false
				File.onBeforeRevert.emit @

				# inputs
				if @inputs
					for input, i in @inputs
						input.revert()

				# conditions
				if @conditions
					for condition, i in @conditions
						condition.revert()

				# uses
				if @uses
					for use in @uses
						use.revert()

				# iterators
				if @iterators
					for iterator, i in @iterators
						iterator.revert()

				# source
				source @, @source

				@storage = null
				@source = null

				listeners @

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

*File* File::clone()
--------------------

		clone: ->
			# from pool
			if pool[@path]?.length
				pool[@path].pop()
			else
				@_clone()

		_clone: ->
			clone = Object.create @

			clone.clone = undefined
			clone._tmp = getTmp()
			clone.uid = utils.uid()
			clone.isRendered = false
			clone.node = @node.cloneDeep()
			clone.sourceNode &&= @node.getCopiedElement @sourceNode, clone.node
			clone.parent = null
			clone.storage = null
			clone.source = null

			# call signals
			signal.create clone, 'onReplaceByUse'

			# attrChanges
			if @attrChanges
				clone.attrChanges = []
				for attrChange, i in @attrChanges
					clone.attrChanges[i] = attrChange.clone @, clone

			# inputs
			if @inputs
				clone.inputs = []
				for input, i in @inputs
					clone.inputs[i] = input.clone @, clone

			# conditions
			if @conditions
				clone.conditions = []
				for condition, i in @conditions
					clone.conditions[i] = condition.clone @, clone

			# iterators
			if @iterators
				clone.iterators = []
				for iterator, i in @iterators
					clone.iterators[i] = iterator.clone @, clone

			# uses
			if @uses
				clone.uses = []
				for use, i in @uses
					clone.uses[i] = use.clone @, clone

			# ids
			if @ids
				clone.ids = {}
				for id, node of @ids
					clone.ids[id] = @node.getCopiedElement node, clone.node

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

		toSimplifiedObject: ->
			utils.simplify @, properties: false, protos: false, constructors: true

*Object* File::toJSON()
-----------------------

		toJSON: ->
			json = @toSimplifiedObject()

			for i, ctor of ctors = json.constructors
				ctors[i] = ctor.__path__

			json
