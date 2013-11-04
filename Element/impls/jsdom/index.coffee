'use strict'

jsdom = require 'jsdom'

DOC = jsdom.jsdom null, null,
	FetchExternalResources: false
	ProcessExternalResources: false

module.exports =
	Element: require('./element.coffee') DOC
	Attrs: require('./attrs.coffee') DOC
