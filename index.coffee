'use strict'

Impl = require './impl'
Scope = Impl.Scope = require './scope'

exports = module.exports = Object.create Scope.DEFAULT_SCOPE

exports.Scope = Scope

windowItem = exports.create Scope.Item, id: 'window'
Impl.setWindow windowItem._uid

Object.freeze exports