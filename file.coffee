'use strict'

utils = require 'utils'
expect = require 'expect'
log = require 'log'
Emitter = require 'emitter'
signal = require 'signal'
Dict = require 'dict'
List = require 'list'

log = log.scope 'View'

module.exports = class File

	files = @_files = {}
	pool = {}

	getTmp = -> tmp =
		listeners: []

	@__name__ = 'File'
	@__path__ = 'File'

	@CREATE = 'create'
	@ERROR = 'error'
	@HTML_NS = 'neft'

	utils.merge @, Emitter::
	Emitter.call @

	signal.create @, 'parse'
	signal.create @, 'parsed'

	@Element = require('./element/index')
	@AttrChange = require('./attrChange') @
	@Unit = require('./unit') @
	@Use = require('./use') @
	@Input = require('./input') @
	@Condition = require('./condition') @
	@Iterator = require('./iterator') @

	@fromHTML = do ->

		clear = require('./file/clear') File

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

	@fromJSON = do (ctorsCache={}) -> (path, json) ->

		expect(path).toBe.truthy().string()
		expect().some().keys(files).not().toBe path

		# parse json
		if typeof json is 'string'
			json = utils.tryFunction JSON.parse, null, [json], json

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

	constructor: do ->

		if utils.isNode
			links = require('./file/parse/links') File
			attrs = require('./file/parse/attrs') File
			attrChanges = require('./file/parse/attrChanges') File
			units = require('./file/parse/units') File
			iterators = require('./file/parse/iterators') File
			source = require('./file/parse/source') File
			uses = require('./file/parse/uses') File
			storage = require('./file/parse/storage') File
			conditions = require('./file/parse/conditions') File
			nodes = require('./file/parse/nodes') File

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
			utils.defineProperty @, '_tmp', utils.WRITABLE, getTmp()

			# trigger signal
			File.parse @

			# parse
			links @
			attrs @
			attrChanges @
			units @
			iterators @
			source @
			uses @
			storage @
			conditions @
			nodes @

			# trigger signal
			File.parsed @

			# save to storage
			files[@path] = @

			@

	uid: ''
	isRendered: false
	node: null
	nodes: null
	sourceNode: null
	path: ''
	pathbase: ''
	parent: null
	links: null
	attrChanges: null
	units: null
	uses: null
	inputs: null
	conditions: null
	iterators: null
	storage: null
	source: null

	init: ->

	render: render = (source) ->

		expect().defined(source).toBe.object()
		expect(@isRendered).toBe.falsy()
		expect(@clone).toBe undefined

		@isRendered = true
		@source = source

		# inputs
		if @inputs
			for input, i in @inputs
				input.render()

		# conditions
		if @conditions
			for condition, i in @conditions
				condition.render()

		# iterators
		if @iterators
			for iterator, i in @iterators
				iterator.render()

		# uses
		if @uses
			for use in @uses
				use.render()

		# source
		render.source @, source

		@

	render.source = require('./file/render/parse/source') File

	revert: do ->

		listeners = require('./file/render/revert/listeners') File

		->

			expect(@isRendered).toBe.truthy()
			@isRendered = false

			# inputs
			if @inputs
				for input, i in @inputs
					input.revert()

			# conditions
			if @conditions
				for condition, i in @conditions
					condition.revert()

			# iterators
			if @iterators
				for iterator, i in @iterators
					iterator.revert()

			# uses
			if @uses
				for use in @uses
					use.revert()

			@storage = null
			@source = null

			listeners @

			@

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

			# call signals
			signal.create clone, 'replacedByUse'

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

			clone

	destroy: ->

		if @isRendered
			@revert()

		pathPool = pool[@path] ?= []
		expect().some(pathPool).not().toBe @

		pathPool.push @

	toSimplifiedObject: ->

		utils.simplify @, properties: false, protos: false, constructors: true

	toJSON: ->

		json = @toSimplifiedObject()

		for i, ctor of ctors = json.constructors
			ctors[i] = ctor.__path__

		json