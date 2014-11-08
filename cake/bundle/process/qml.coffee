###
Emulate as client
###
utils = require 'utils'
utils.isNode = false
utils.isClient = true
utils.isQML = true

###
Provide necessary standard browser globals
###
SIGNAL =
	connect: ->
	disconnect: ->

global.Font = {}
global.Qt =
	createQmlObject: ->
		font: {}
		onClicked: SIGNAL
		onPressed: SIGNAL
		onReleased: SIGNAL
		onReleased: SIGNAL
		onEntered: SIGNAL
		onExited: SIGNAL
		onPositionChanged: SIGNAL
		onWheel: SIGNAL
		createObject: -> global.Qt.createQmlObject()
	binding: ->
	rgba: ->
	hsla: ->
global.stylesBody =
	children: []
global.stylesWindow =
	items: []
	width: 900
	height: 600
	widthChanged: SIGNAL
	heightChanged: SIGNAL
global.qmlUtils =
	createBinding: ->
global.stylesHatchery = {}
global.requestAnimationFrame = ->