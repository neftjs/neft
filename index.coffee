'use strict'

Impl = require './impl'
Scope = Impl.Scope = require './scope'

exports = module.exports = Object.create Scope.DEFAULT_SCOPE

exports.Scope = Scope
exports.window = exports.create Scope.Item, id: 'window'

Impl.setWindow exports.window

Object.freeze exports