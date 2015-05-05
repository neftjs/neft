'use strict'

module.exports = ->
	# gets argv
	[_, _, index, opts] = process.argv
	opts = JSON.parse opts
	{type, onlyLocal, allowedRemoteModules} = opts
	allowedRemoteModules ?= []
	process.argv.splice 2, Infinity

	extras = opts.extras or {}

	EMULATORS =
		browser: ->
			###
			Provide necessary standard browser globals
			###
			global.window =
				document: {}
				isFake: true
				addEventListener: ->
				Image: ->
				HTMLCanvasElement: if extras.game then (->) else null
				console:
					log: ->
				navigator: {}
			global.location = pathname: ''
			global.navigator = userAgent: ''
			global.innerWidth = 1024
			global.innerHeight = 600
			global.scrollX = 0
			global.scrollY = 0
			global.screen = {}
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
							width:
								baseVal: 0
							height:
								baseVal: 0
						}
					]
					removeChild: ->
					getBoundingClientRect: -> {}
					addEventListener: ->
					setAttribute: ->
					innerHTML: ''
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
			global.requestAnimationFrame = ->
			global.Image = global.document.createElement

		node: ->
			global.option = ->
			global.task = ->
			global.requestAnimationFrame = ->

		qml: ->
			###
			Provide necessary standard browser globals
			###
			SIGNAL =
				connect: ->
				disconnect: ->

			global.Font = {}
			global.Qt =
				include: ->
				createQmlObject: ->
					font: {}
					onClicked: SIGNAL
					onPressed: SIGNAL
					onReleased: SIGNAL
					onEntered: SIGNAL
					onExited: SIGNAL
					onPositionChanged: SIGNAL
					onWheel: SIGNAL
					createObject: -> global.Qt.createQmlObject()
				binding: ->
				rgba: ->
				hsla: ->
				platform: {}
				locale: ->
					name: ''
			global.Screen = {}
			global.__stylesBody =
				children: []
			global.__stylesWindow =
				items: []
				width: 900
				height: 600
				widthChanged: SIGNAL
				heightChanged: SIGNAL
				screen:
					orientationChanged:
						connect: ->
			global.qmlUtils =
				createBinding: ->
			global.__stylesHatchery = {}
			global.__stylesMouseArea =
				onPressed:
					connect: ->
				onPositionChanged:
					connect: ->
				onReleased:
					connect: ->
			global.requestAnimationFrame = ->

	NODE_MODULES =
		fs: true
		path: true
		vm: true
		http: true
		https: true
		zlib: true
		util: true # TODO
		events: true # TODO
		rethinkdb: true
		'coffee-script': true
		child_process: true
		stream: true
		groundskeeper: true
		'uglify-js': true
		pegjs: true
		url: true
		mmmagic: true
		'node-static': true
		mysql: true

	fs = require 'fs'
	pathUtils = require 'path'
	require 'coffee-script/register'

	modules = []
	paths = {}

	# Get index to require and their base path
	base = pathUtils.dirname index

	EMULATORS[type]()

	require.extensions['.pegjs'] = require.extensions['.txt'] = (module, filename) ->
		module.exports = fs.readFileSync filename, 'utf8'

	try
		Neft = require "./neft-#{type}-develop.js"

	###
	Override standard `Module._load()` to capture all required modules and files
	###
	Module = module.constructor
	Module._load = do (_super = Module._load) -> (req, parent) ->
		if Neft?[req]
			return Neft[req]

		hiddenReq = req
		if req is 'assert'
			hiddenReq = arguments[0] = 'neft-assert'

		r = _super.apply @, arguments

		if NODE_MODULES[req]
			return r

		for module, _ of NODE_MODULES
			if parent.id.indexOf("node_modules/#{module}") > 0
				return r

		filename = Module._resolveFilename hiddenReq, parent

		modulePath = pathUtils.relative base, filename
		parentPath = pathUtils.relative base, parent.id
		unless parentPath then return r	

		if onlyLocal
			if ///^\.\./|^node_modules\////.test(modulePath) or not ///\.[a-zA-Z0-9]+$///.test(modulePath)
				name = ///^\.\.\/([a-z_\-A-Z]+)///.exec(modulePath)?[1]
				if allowedRemoteModules.indexOf(name) is -1
					return r

		modules.push modulePath unless ~modules.indexOf modulePath

		mpaths = paths[parentPath] ?= {}
		mpaths[req] = modulePath

		if req is 'neft-assert'
			mpaths['assert'] = modulePath

		r

	# run index file
	try
		require index
	catch err
		if err.stack
			err = err.stack
		else
			err += ''
		return process.send err: err

	# add index file into modules list
	modules.push opts.path

	process.send
		modules: modules
		paths: paths
