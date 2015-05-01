'use strict'

utils = require 'utils'

if utils.isBrowser
	browserLocalStorage = require './implementations/browser/localStorage'
memory = require './implementations/memory'

if window? and window.localStorage?
	module.exports = browserLocalStorage
else
	module.exports = memory