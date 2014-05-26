'use strict'

[path] = ['path'].map require

modules = []
paths = {}

# Get index to require and their base path
index = process.argv[2]
base = path.dirname index

###
Override standard `Module._load()` to capture all required modules and files
###
Module = module.constructor
Module._load = do (_super = Module._load) -> (req, parent) ->

	r = _super.apply @, arguments

	filename = Module._resolveFilename req, parent

	modulePath = path.relative base, filename
	parentPath = path.relative base, parent.id
	unless parentPath then return r	

	modules.push modulePath unless ~modules.indexOf modulePath

	mpaths = paths[parentPath] ?= {}
	mpaths[req] = modulePath

	r

###
Emulate as client
###
utils = require 'utils'
utils.isNode = false
utils.isClient = true
utils.isBrowser = true

###
Provide necessary standard browser globals
###
global.window = {}
global.location = pathname: ''
global.navigator = userAgent: ''
global.document =
	body:
		appendChild: ->
	createElement: ->
		classList:
			add: ->
		appendChild: ->
		style: {}
		children: [
			{
				childNodes: []
			}
		]
		removeChild: ->
		getBoundingClientRect: -> {}
	createElementNS: ->
		width: baseVal: value: null
		height: baseVal: value: null
		style: {}
		classList:
			add: ->
		transform:
			baseVal:
				appendItem: ->
		setAttribute: ->
		appendChild: ->
		setAttributeNS: ->
		createSVGTransform: ->
			setTranslate: ->
			setScale: ->
		childNodes: [
			{
				transform:
					baseVal:
						appendItem: ->
				childNodes: []
				setAttribute: ->
			}
		]
		children: []
	getElementById: ->
	addEventListener: ->
	querySelector: ->
global.history =
	pushState: ->

# run index file
try
	require index
catch err
	return process.send err: err.stack

# add index file into modules list
modules.push 'index.coffee'

process.send
	modules: modules
	paths: paths