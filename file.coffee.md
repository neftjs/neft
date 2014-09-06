View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

	[utils,   expect,   log,   Emitter,   signal,   Dict,   List] =
	['utils', 'expect', 'log', 'emitter', 'signal', 'dict', 'list'].map require

	log = log.scope 'View'

*class* File
------------

	module.exports = class File

		files = @_files = {}
		pool = {}

		getTmp = -> tmp =
			listeners: []

		@__name__ = 'File'
		@__path__ = 'File'

		@CREATE = 'create'
		@ERROR = 'error'

		utils.merge @, Emitter::
		Emitter.call @

		signal.create @, 'onParse'
		signal.create @, 'onParsed'

		@Element = require('./Element/index')
		@Unit = require('./unit.coffee.md') @
		@Elem = require('./elem.coffee.md') @
		@Input = require('./input.coffee') @
		@Condition = require('./condition.coffee') @
		@Iterator = require('./iterator.coffee') @

#### *File* fromHTML(*string*, *string*)

		@fromHTML = do ->

			clear = require('./file/clear.coffee') File

			(path, html) ->

				expect(path).toBe.truthy().string()
				expect().some().keys(files).not().toBe path
				expect(html).toBe.truthy().string()

				logtime = log.time 'from html'
				log "Parse `#{path}` from HTML"

				# get node
				node = File.Element.fromHTML html

				# clear
				clear node

				# create file
				file = new File path, node

				log.end logtime

				file

#### *File* fromJSON(*String*, *String|Object*)

		@fromJSON = do (ctorsCache={}) -> (path, json) ->

			expect(path).toBe.truthy().string()
			expect().some().keys(files).not().toBe path

			# parse json
			if typeof json is 'string'
				json = utils.tryFunc JSON.parse, null, [json], json

			expect(json).toBe.simpleObject()

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

#### *File* factory(*string*)

		@factory = (path) ->

			unless files.hasOwnProperty path
				# TODO: trigger here instance of `LoadError` class
				File.trigger File.ERROR, path

			expect(path).toBe.truthy().string()
			expect().some().keys(files).toBe path

			# from pool
			if pool[path]?.length
				return pool[path].pop()

			# clone original
			file = files[path].clone()

			File.trigger File.CREATE, file

			file

### Constructor(*string*, *File.Element*)

		constructor: do ->

			if utils.isNode
				links = require('./file/parse/links.coffee') File
				attrs = require('./file/parse/attrs.coffee') File
				units = require('./file/parse/units.coffee') File
				iterators = require('./file/parse/iterators.coffee') File
				source = require('./file/parse/source.coffee') File
				elems = require('./file/parse/elems.coffee') File
				storage = require('./file/parse/storage.coffee') File
				conditions = require('./file/parse/conditions.coffee') File
				nodes = require('./file/parse/nodes.coffee') File

			(@path, @node) ->

				expect(path).toBe.truthy().string()
				expect(node).toBe.any File.Element
				expect().some(files).not().toBe path

				# set properties
				@pathbase = path.substring 0, path.lastIndexOf('/') + 1
				@isRendered = false

				# call init
				@init()

				# clone tmp
				utils.defProp @, '_tmp', 'w', getTmp()

				# trigger signal
				File.onParse @

				# parse
				links @
				attrs @
				units @
				iterators @
				source @
				elems @
				storage @
				conditions @
				nodes @

				# trigger signal
				File.onParsed @

				# save to storage
				files[@path] = @

				@

### Properties

		uid: ''
		isRendered: false
		node: null
		nodes: null
		sourceNode: null
		path: ''
		pathbase: ''
		parent: null
		links: null
		units: null
		elems: null
		inputs: null
		conditions: null
		iterators: null
		storage: null
		source: null

		signal.defineGetter @::, 'onRender'
		signal.defineGetter @::, 'onRevert'
		signal.defineGetter @::, 'onReplacedByElem'

### Methods

#### init()

		init: ->

#### render()

		render: render = (source) ->

			expect().defined(source).toBe.object()
			expect(@isRendered).toBe.falsy()
			expect(@clone).toBe undefined

			@isRendered = true
			@source = source

			@onRender()

			# source
			render.source @, source

			File.Element.OBSERVE = true

			@

		render.source = require('./file/render/parse/source.coffee') File

#### revert() ->

		revert: do ->

			listeners = require('./file/render/revert/listeners.coffee') File

			->

				expect(@isRendered).toBe.truthy()
				@isRendered = false
				File.Element.OBSERVE = false

				@onRevert()

				@storage = null
				@source = null

				listeners @

				@

#### clone()

		clone: do ->

			->

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

				# inputs
				if @inputs.length
					clone.inputs = []
					for input, i in @inputs
						clone.inputs[i] = input.clone @, clone

				# conditions
				if @conditions.length
					clone.conditions = []
					for condition, i in @conditions
						clone.conditions[i] = condition.clone @, clone

				# iterators
				if @iterators.length
					clone.iterators = []
					for iterator, i in @iterators
						clone.iterators[i] = iterator.clone @, clone

				# elems
				unless utils.isEmpty @elems
					clone.elems = {}
					for elemName, elems of @elems
						clone.elems[elemName] = []
						for elem, i in elems
							clone.elems[elemName][i] = elem.clone @, clone

				clone

#### destroy()

		destroy: ->

			if @isRendered
				@revert()

			pathPool = pool[@path] ?= []
			pathPool.push @

#### toSimplifiedObject()

		toSimplifiedObject: ->

			utils.simplify @, properties: false, protos: false, constructors: true

#### toJSON()

		toJSON: ->

			json = @toSimplifiedObject()

			for i, ctor of ctors = json.constructors
				ctors[i] = ctor.__path__

			json