'use strict'

Impl = require './impl'
Scope = Impl.Scope = require './scope'

exports = module.exports = Object.create new Scope id: 'main'

exports.Scope = Scope

if window? and window+'' is '[object Window]'
	windowItem = exports.create 'Item', id: 'window'
	Impl.setWindow windowItem._uid

Object.freeze exports