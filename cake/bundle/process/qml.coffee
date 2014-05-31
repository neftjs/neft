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
global.Font = {}
global.Qt =
	createQmlObject: -> {}
global.styles = {}