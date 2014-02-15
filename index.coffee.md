Routing
=======

It's a module to manage requests and responses from the outside (`HTTP` or client request).

	'use strict'

	[utils] = ['utils'].map require

	switch true
		when utils.isNode
			exports = module.exports = require './index.node.coffee'

	exports.PROTOCOL = 'http'
	exports.HOST = 'localhost'