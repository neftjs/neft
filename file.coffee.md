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
	CallList = require './callList.coffee'

*class* File
------------

	module.exports = class File

		files = {}
		clones = []

### Static

#### *File* fromHTML(*string*, *string*)

		@fromHTML = (path, html) ->

			assert html and typeof html is 'string'

			# get node
			node = File.Element.fromHTML html

			# clear
			File.clear.run node

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

			# save instance
			files[path] = @

			# set properties
			@pathbase = path.substring 0, path.lastIndexOf('/')+1

			# parse file
			File.parse.run @

			# clone tmp
			@_tmp = utils.cloneDeep @_tmp

### Properties

		isClone: false
		isParsing: false
		isParsed: false

		_tmp:
			usedUnits: []
			changes: []

		node: null
		sourceNode: null
		path: ''
		pathbase: ''
		parent: null
		links: null
		units: null
		elems: null

### Methods

#### clone()

		clone: ->

			assert not @isClone
			assert not @isParsing
			assert not @isParsed

			for file, i in clones
				if file.path is @path
					clones.splice i, 1
					return file

			copy = utils.clone @
			copy.isClone = true
			copy.node = @node.cloneDeep()
			copy._tmp = utils.cloneDeep File::_tmp

			copy

#### render()

		render: (opts, callback) ->

			File.render.parse.run @, opts, callback

#### revert() ->

		revert: ->

			File.render.revert.run @

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

		@clear = new CallList File
		@clear.add 'clear', require('./file/clear.coffee')

		@parse = new CallList File
		@parse.add('links', require('./file/parse/links.coffee'))
		      .add('attrs', require('./file/parse/attrs.coffee'))
		      .add('units', require('./file/parse/units.coffee'))
		      .add('source', require('./file/parse/source.coffee'))
		      .add('elems', require('./file/parse/elems.coffee'));

		@render =
			parse: new CallList File
			revert: new CallList File

		@render.parse.add('onend', require('./file/render/parse/onend.coffee'))
		             .add('source', require('./file/render/parse/source.coffee'))
		             .add('elems', require('./file/render/parse/elems.coffee'))
		             .add('init', require('./file/render/parse/init.coffee'));
		@render.revert.add('onend', require('./file/render/revert/onend.coffee'))
		              .add('elems', require('./file/render/revert/elems.coffee'))
		              .add('init', require('./file/render/revert/init.coffee'));
