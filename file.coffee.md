View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

	ELEMENT_IMPL = if window? then 'dom' else 'htmlparser'

	utils = require 'utils/index.coffee.md'
	assert = require 'assert'
	Events = require 'Events/index.coffee.md'

*class* File
------------

	module.exports = class File extends Events

### Static

#### Events

		@LOAD_END = 'loadend'
		@READY = 'ready'
		@ERROR = 'error'

#### *File* factory(*string*)

All `File` instances are cached, so if you want to render some file it's not
necessary to parse it each time you want to use it.

		@factory = do ->

			cache = {}

			(path) ->

				assert typeof path is 'string'
				assert path

				cache[path] or cache[path] = new File path

#### Modules

		@Element = require('./Element/index.coffee.md') ELEMENT_IMPL
		@LoadFile = require('./file/load.coffee.md') File
		@ParseFile = require('./file/parse.coffee.md') File
		@RenderFile = require('./file/render.coffee.md') File
		@Unit = require('./unit.coffee.md') File
		@Elem = require('./elem.coffee.md') File

### Constructor(*path*, *parse: true*)

		constructor: (@path, opts={}) ->

			assert typeof path is 'string'
			assert path

			super

			# set default options
			opts.parse ?= true

			# set properties
			@pathbase = path.substring 0, path.lastIndexOf('/')
			@load = new File.LoadFile @

			# call init
			@init()

			# on ready
			@once File.READY, ->
				@isReady = true
				@off File.ERROR

			# load files
			@isLoading = true
			@load.all (err) =>

				@isLoading = false

				if err then return @trigger File.ERROR, err

				# create parse and render classes
				@trigger File.LOAD_END
				@parse = new File.ParseFile @
				@render = new File.RenderFile @

				unless opts.parse
					return @trigger File.READY

				# parse file if needed
				@isParsing = true
				@parse.all (err) =>

					@isParsing = false
					if err then return @trigger File.ERROR, err
					@trigger File.READY

### Properties

		isReady: false
		isLoading: false
		isParsing: false
		dom: null
		path: ''
		pathbase: ''
		parent: null
		links: null
		units: null
		elems: null

		load: null
		parse: null
		render: null

### Methods

#### init()

		init: ->

#### *Object* toJSON()

		toJSON: ->

			path: @path
			pathbase: @pathbase
			links: @links
			units: @units
			elems: @elems