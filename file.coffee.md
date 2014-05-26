View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

	[utils, expect, log, Emitter] = ['utils', 'expect', 'log', 'emitter'].map require

	{assert} = console

	log = log.scope 'View'

*class* File
------------

	module.exports = class File

		files = @_files = {}
		pool = {}

		@__name__ = 'File'
		@__path__ = 'File'

		@CREATE = 'create'

		utils.merge @, Emitter::
		utils.merge @, new Emitter

		@Element = require('./Element/index.coffee.md')
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
				expect().some(files).not().toBe path
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

		@fromJSON = (path, json) ->
			expect(path).toBe.truthy().string()
			expect().some(files).not().toBe path

			# parse json
			if typeof json is 'string'
				json = utils.tryFunc JSON.parse, null, [json], json

			expect(json).toBe.simpleObject()

			# put ctors
			ns = File: File
			for i, ctor of ctors = json.constructors
				ctors[i] = utils.get ns, ctor

			# save to storage
			files[path] = json

			# factory
			File.factory path

#### *File* factory(*string*)

		@factory = (path) ->

			assert path and typeof path is 'string'

			# from pool
			if pool[path]?.length
				return pool[path].pop()

			# from json
			json = files[path]
			assert json

			json = utils.cloneDeep json
			json = utils.assemble json

			File.trigger File.CREATE, json

			json

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
				@_tmp = utils.cloneDeep @_tmp

				# parse
				links @
				attrs @
				units @
				source @
				elems @
				storage @
				iterators @
				conditions @

				# save to storage
				files[@path] = @toSimplifiedObject()

				@

### Properties

		_tmp:
			usedUnits: []
			changes: []
			hidden: []
			conditions: []
			iterators: []

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

			File.factory @path

#### destroy()

		destroy: ->

			if @isRendered
				@revert()

			pathPool = pool[@path] ?= []
			pathPool.push @

#### toSimplifiedObject()

		toSimplifiedObject: ->

			utils.simplify @, properties: true, protos: false, constructors: true

#### toJSON()

		toJSON: ->

			json = @toSimplifiedObject()

			for i, ctor of ctors = json.constructors
				ctors[i] = ctor.__path__

			json