View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

	[utils, assert, log] = ['utils', 'assert', 'log'].map require

	log = log.scope 'View'

*class* File
------------

	module.exports = class File

		files = {}
		pool = {}

		@Element = require('./Element/index.coffee.md') 'htmlparser'
		@Unit = require('./unit.coffee.md') @
		@Elem = require('./elem.coffee.md') @
		@Input = require('./input.coffee') @
		@Condition = require('./condition.coffee') @
		@Iterator = require('./iterator.coffee') @

#### *File* fromHTML(*string*, *string*)

		@fromHTML = do ->

			clear = require('./file/clear.coffee') File

			(path, html) ->

				assert path and typeof path is 'string'
				assert not files[path]
				assert html and typeof html is 'string'

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

#### *File* fromJSON(*String*, *String*)

		@fromJSON = (path, json) ->

			assert path and typeof path is 'string'
			assert not files[path]
			assert json and typeof json is 'string'

			# parse json
			json = utils.tryFunc JSON.parse, null, json
			assert utils.isObject json

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

			logtime = log.time 'factory'
			log "Factory new `#{path}` view"

			# from json
			json = files[path]
			assert json

			json = utils.cloneDeep json
			json = utils.assemble json

			log.end logtime

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

				assert path and typeof path is 'string'
				assert node instanceof File.Element
				assert not files[path]

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
				files[@path] = @toJSON()

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

				assert opts and typeof opts is 'object'
				assert not @isRendered

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

				assert @isRendered

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

			pathPool = pool[@path] ?= []
			pathPool.push @

#### toJSON()

		toJSON: ->

			utils.simplify @, properties: true, protos: false, constructors: true
