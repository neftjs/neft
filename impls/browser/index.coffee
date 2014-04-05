'use strict'

[utils] = ['utils'].map require

exports.Request = require('./request.coffee')()
exports.Response = require('./response.coffee')()

exports.init = ->

	uri = location.pathname

	uid = utils.uid()

	res = @request
		uid: uid
		method: @constructor.GET
		uri: uri.slice 1
		body: null