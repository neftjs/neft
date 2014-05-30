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