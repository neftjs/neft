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

*class* File
------------

	module.exports = class File

		firstInit = false
		files = {}
		clones = []

### Static

#### *File* fromHTML(*string*, *string*)

		@fromHTML = (path, html) ->

			assert html and typeof html is 'string'

			# get node
			node = File.Element.fromHTML html

			# clear
			File.clear node

			new File path, node

#### *File* factory(*string*)

		@factory = (path) ->

			assert files[path]

			files[path].clone()

### Constructor(*string*, *File.Element*)

		constructor: (@path, @node) ->

			assert path and typeof path is 'string'
			assert node instanceof File.Element
			assert not files[path]

			# on first init
			unless firstInit
				File.parse = require('./file/parse/elems.coffee') File, File.parse
				File.render.parse = require('./file/render/parse/init.coffee') File, File.render.parse
				File.render.clear = require('./file/render/clear/init.coffee') File, File.render.clear
				firstInit = true

			# save instance
			files[path] = @

			# set properties
			@pathbase = path.substring 0, path.lastIndexOf('/')+1

			# call init
			@init()

			# parse file
			File.parse @

			# set render functions
			@render = utils.cloneDeep @render
			@render.parse = File.render.parse.bind null, @
			@render.clear = File.render.clear.bind null, @

### Properties

		isClone: false

		render:
			isParsing: false
			isParsed: false
			parse: null
			clear: null

		node: null
		path: ''
		pathbase: ''
		parent: null
		links: null
		units: null
		elems: null

### Methods

#### init()

		init: ->

#### clone()

		clone: ->

			assert not @isClone
			assert not @render.isParsing
			assert not @render.isParsed

			for file in clones
				if file.path is @path
					return file

			copy = utils.clone @
			copy.isClone = true
			copy.node = @node.cloneDeep()

			copy.render = utils.cloneDeep File::render
			copy.render.parse = File.render.parse.bind null, copy
			copy.render.clear = File.render.clear.bind null, copy

			copy

#### destroy()

		destroy: ->

			assert @isClone
			assert not ~clones.indexOf @

			clones.push @

### Static

#### Modules

		@Element = require('./Element/index.coffee.md') ELEMENT_IMPL
		@Unit = require('./unit.coffee.md') File
		@Elem = require('./elem.coffee.md') File

#### Functions

		@clear = require('./file/clear.coffee') File
		@parse = 
			require('./file/parse/units.coffee') File,
			require('./file/parse/attrs.coffee') File,
			require('./file/parse/links.coffee') File, ->
		@render =
			parse:
				require('./file/render/parse/elems.coffee') File,
				require('./file/render/parse/onend.coffee') File
			clear:
				require('./file/render/clear/elems.coffee') File,
				require('./file/render/clear/onend.coffee') File