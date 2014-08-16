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
global.window =
	addEventListener: ->
	Image: ->
global.location = pathname: ''
global.navigator = userAgent: ''
global.innerWidth = 1024
global.innerHeight = 600
global.scrollX = 0
global.scrollY = 0
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