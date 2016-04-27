'use strict'

localStorageImpl = require './browser/localStorage'

module.exports = do ->
	if window.localStorage?
		localStorageImpl