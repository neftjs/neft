'use strict'

[cp, path] = ['child_process', 'path'].map require

module.exports = (callback) ->

	index = path.resolve __dirname, '../index.coffee'
	child = cp.fork __dirname + '/bundle/process.coffee', [index], silent: true
	child.on 'message', (msg) ->

		child.kill()

		# on error
		if msg.err
			return callback msg.err

		{modules, paths} = msg

		bundle = require('./bundle/result.coffee') modules, paths

		callback null, bundle