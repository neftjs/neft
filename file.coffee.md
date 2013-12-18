View File
=========

Goals
-----

One of the main goal is to provide an easy interface to describe a file which is
a DOM element with placed unit declarations, links to units and others provided
features. Physical file should be easy to load and parse.

	'use strict'

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

			clone = utils.clone @
			clone.isClone = true
			clone.node = @node.cloneDeep()
			clone._tmp = utils.cloneDeep File::_tmp

			# copy sourceNode
			if @sourceNode
				clone.sourceNode = @node.getCopiedElement @sourceNode, clone.node

			# copy elems
			elems = clone.elems = utils.clone @elems

			for name, unitElems of elems

				unitElems = elems[name] = utils.clone unitElems
				for elem, i in unitElems
					unitElems[i] = elem.clone clone

			clone

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

#### Functions

		@clear = new CallList
		@clear.add 'clear', require('./file/clear.coffee') File

		@parse = new CallList
		@parse.add('links', require('./file/parse/links.coffee') File)
		      .add('attrs', require('./file/parse/attrs.coffee') File)
		      .add('units', require('./file/parse/units.coffee') File)
		      .add('source', require('./file/parse/source.coffee') File)
		      .add('elems', require('./file/parse/elems.coffee') File);

		@render =
			parse: new CallList
			revert: new CallList

		@render.parse.add('onend', require('./file/render/parse/onend.coffee') File)
		             .add('source', require('./file/render/parse/source.coffee') File)
		             .add('elems', require('./file/render/parse/elems.coffee') File)
		             .add('init', require('./file/render/parse/init.coffee') File);
		@render.revert.add('onend', require('./file/render/revert/onend.coffee') File)
		              .add('elems', require('./file/render/revert/elems.coffee') File)
		              .add('init', require('./file/render/revert/init.coffee') File);
