View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

	[utils, expect, log, Emitter] = ['utils', 'expect', 'log', 'emitter'].map require

	log = log.scope 'View'

*class* File
------------

	module.exports = class File

		files = @_files = {}
		pool = {}

		getTmp = ->
			usedUnits: []
			changes: []
			hidden: []
			conditions: []
			iterators: []

		@__name__ = 'File'
		@__path__ = 'File'

		@CREATE = 'create'

		utils.merge @, Emitter::
		Emitter.call @

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
				expect().some(Object.keys(files)).not().toBe path
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
			expect().some(Object.keys(files)).not().toBe path

			# parse json
			if typeof json is 'string'
				json = utils.tryFunc JSON.parse, null, [json], json

			expect(json).toBe.simpleObject()

			# put ctors
			ns = File: File
			for i, ctor of ctors = json.constructors
				ctorsCache[ctor] ?= utils.get ns, ctor
				ctors[i] = ctorsCache[ctor]

			# save to storage
			json = utils.assemble json
			files[path] = json

			json

#### *File* factory(*string*)

		@factory = (path) ->

			expect(path).toBe.truthy().string()
			expect().some(Object.keys(files)).toBe path

			# from pool
			if pool[path]?.length
				return pool[path].pop()

			# clone original
			file = files[path].clone()

			File.trigger File.CREATE, file

			file

### Constructor(*string*, *File.Element*)

		constructor: do ->

			links = require('./file/parse/links.coffee') File
			attrs = require('./file/parse/attrs.coffee') File
			units = require('./file/parse/units.coffee') File
			source = require('./file/parse/source.coffee') File
			elems = require('./file/parse/elems.coffee') File
			storage = require('./file/parse/storage.coffee') File
			conditions = require('./file/parse/conditions.coffee') File
			iterators = require('./file/parse/iterators.coffee') File

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
				utils.defProp @, '_tmp', '', getTmp()

				# parse
				links @
				attrs @
				units @
				iterators @
				source @
				elems @
				storage @
				conditions @

				# save to storage
				files[@path] = @

				@

### Properties

		isRendered: false
		node: null
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

### Methods

#### init()

		init: ->

#### render()

		render: do ->

			elems = require('./file/render/parse/elems.coffee') File
			source = require('./file/render/parse/source.coffee') File
			storage = require('./file/render/parse/storage.coffee') File
			conditions = require('./file/render/parse/conditions.coffee') File
			iterators = require('./file/render/parse/iterators.coffee') File

			optsDef = {}
			(opts=optsDef) ->

				expect(opts).toBe.simpleObject()
				expect(@isRendered).toBe.falsy()

				@isRendered = true

				storage @, opts
				iterators @, opts
				conditions @, opts
				elems @, opts
				source @, opts

				null

#### revert() ->

		revert: do ->

			elems = require('./file/render/revert/elems.coffee') File
			conditions = require('./file/render/revert/conditions.coffee') File
			iterators = require('./file/render/revert/iterators.coffee') File

			->

				expect(@isRendered).toBe.truthy()

				@isRendered = false

				elems @
				iterators @
				conditions @

				null

#### clone()

		clone: ->

			clone = Object.create @

			clone.clone = undefined
			clone._tmp = getTmp()
			clone.isRendered = false
			clone.node = @node.cloneDeep()
			clone.sourceNode &&= @sourceNode.cloneDeep()
			clone.parent = null

			# elems
			unless utils.isEmpty @elems
				clone.elems = {}
				for elemName, elems of @elems
					clone.elems[elemName] = []
					for elem, i in elems
						clone.elems[elemName][i] = elem.clone @, clone

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