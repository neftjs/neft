View File Load
==============

Goals
-----

Trigger `LOAD_END` event when all needed resources are loaded and parsed into DOM.

	'use strict'

	utils = require 'utils/index.coffee.md'
	assert = require 'assert'
	Events = require 'Events/index.coffee.md'

	getFile = require './load/getFile.coffee'

*class* LoadFile
----------------

	module.exports = (File) -> class LoadFile extends Events

### Static

#### Status bitmask values

		@FILE = 1<<0
		@LINKS = 1<<1
		@ALL = @FILE | @LINKS

#### Event names

		@STATUS_CHANGED = 'statuschanged'
		@ERROR = 'error'

### Constructor(*File*)

		constructor: (@self) ->

			assert self instanceof File

			super

### Properties

#### *File* self

		self: null

#### status

Integer value used for bitmasks. Check static properties to needed values.

		status: 0

### Protected

#### *dom* _clear(dom)

		_clear: require './load/clear.coffee'

### Methods

#### file(*clear: true*)

Load and parse file into DOM structure.

File will be cleared if needed (editable in options).

		file: (opts={}) ->

			assert not (@status & LoadFile.FILE)

			onend = =>

				# change status
				@status |= LoadFile.FILE 
				@trigger LoadFile.STATUS_CHANGED, @status

			# on already exists
			if @self.dom then return onend()

			# set default options
			opts.clear ?= true

			# get file
			getFile @self.path, (err, html) =>

				if err then return @trigger LoadFile.ERROR, err

				# save parsed dom
				dom = @self.dom = File.Element.fromHTML html

				# clear dom
				@_clear dom if opts.clear
				
				onend()

#### links()

Find and attach all found links to the other files.

		links: ->

			assert @status & LoadFile.FILE
			assert not (@status & LoadFile.LINKS)

			# prepare
			dom = @self.dom
			links = @self.links = []

			# change status on end
			onend = (err) =>

				if err then return @trigger LoadFile.ERROR, err

				# change status
				@status |= LoadFile.LINKS 
				@trigger LoadFile.STATUS_CHANGED, @status 

			# create async stack
			stack = new utils.async.Stack

			# load file and save it
			requireView = (href, node, callback) =>

				# remove link element
				node.parent = undefined

				# get view
				links.push file = File.factory @self.pathbase + '/' + href

				if file.isReady then return callback null

				file
					.once(File.ERROR, callback)
					.once(File.READY, callback.bind null)

			# load found files
			for node in dom.children

				if node.name isnt 'link' or node.attrs.get('rel') isnt 'require'
					continue

				href = node.attrs.get 'href'
				unless href then continue

				stack.add null, requireView, href, node

			stack.runAllSimultaneously onend

			null

#### all()

Load file complexly.

		all: (callback) ->

			assert not @status
			assert typeof callback is 'function'

			@once LoadFile.ERROR, callback

			onnext = (name, i, arr, callback) ->

				@once LoadFile.STATUS_CHANGED, callback
				@[name]()

			utils.async.forEach ['file', 'links'], onnext, callback.bind(null), @

#### *LoadFile* clone(*File*)

		clone: (self) ->

			copy = utils.clone @
			copy.self = self
			copy.self.dom = self.dom.cloneDeep()

			copy