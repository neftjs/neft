'use strict'

utils = require 'src/utils'
data = Object.create null

exports.get = (key, callback) ->
    val = data[key]
    val = utils.cloneDeep val
    callback null, val

exports.set = (key, val, callback) ->
    data[key] = val
    callback null

exports.remove = (key, callback) ->
    data[key] = undefined
    callback null
