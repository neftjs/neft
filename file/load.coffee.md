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

#### *dom* _clearDOM(dom)

		_clearDOM: require './load/clearDOM.coffee'

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
			getFile @self.path, (err, dom) =>

				if err then return @trigger LoadFile.ERROR, err

				# get body
				body = File.DOC.body

				# parse string into DOM
				body.innerHTML = dom

				# get special element for file
				dom = File._createFileElem body

				# save parsed dom
				@self.dom = dom

				# clear dom
				@_clearDOM dom if opts.clear
				
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

			# find link tags
			nodes = dom.querySelectorAll 'file > link[rel="require"][href]'
			unless nodes.length then return onend null

			# create async stack
			stack = new utils.async.Stack

			# load file and save it
			requireView = (href, callback) =>

				links.push file = File.factory @self.pathbase + '/' + href

				if file.isReady then return callback null

				file
					.once(File.ERROR, callback)
					.once(File.READY, callback.bind null)

			# load found files
			for node in nodes

				href = node.getAttribute 'href'

				# remove link element
				dom.removeChild node

				stack.add null, requireView, href

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
			copy.self.dom = self.dom.cloneNode true

			copy