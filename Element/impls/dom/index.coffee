'use strict'

unless document? then return

DOC = document

module.exports =
	Element: require('./element.coffee') DOC
	Attrs: require('./attrs.coffee') DOC
