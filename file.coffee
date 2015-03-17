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
	@Fragment = require('./fragment') @
	@Use = require('./use') @
	@Input = require('./input') @
	@Condition = require('./condition') @
	@Iterator = require('./iterator') @

	@fromHTML = do ->
		clear = require('./file/clear') File

		(path, html) ->
			assert.isString path
			assert.notLengthOf path, 0
			assert.notOk files[path]?
			assert.isString html
			assert.notLengthOf html, 0

			# get node
			node = File.Element.fromHTML html

			# clear
			clear node

			# create file
			file = new File path, node

			file

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
			File.parse @

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

			# trigger signal
			File.parsed @

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

	init: ->

	render: render = (source) ->
		assert.isObject source if source?
		assert.notOk @isRendered
		assert.is @clone, undefined

		@source = source

		# inputs
		if @inputs
			for input, i in @inputs
				input.render()

		# conditions
		if @conditions
			for condition, i in @conditions
				condition.render()

		# TODO: render uses and iterators in proper
		# order (by the nodes tree) - important for styles

		# uses
		if @uses
			for use in @uses
				use.render()

		# iterators
		if @iterators
			for iterator, i in @iterators
				iterator.render()

		# source
		render.source @, source

		@isRendered = true

		@

	render.source = require('./file/render/parse/source') File

	revert: do ->

		listeners = require('./file/render/revert/listeners') File
		source = require('./file/render/revert/source') File

		->
			assert.ok @isRendered

			@isRendered = false

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
		assert.notOk utils.has(pathPool, @)

		pathPool.push @

	toSimplifiedObject: ->

		utils.simplify @, properties: false, protos: false, constructors: true

	toJSON: ->

		json = @toSimplifiedObject()

		for i, ctor of ctors = json.constructors
			ctors[i] = ctor.__path__

		json