'use strict'

[fs, cp, path] = ['fs', 'child_process', 'path'].map require

module.exports = (type, callback) ->

	index = path.resolve fs.realpathSync('.'), 'index.coffee'
	child = cp.fork __dirname + '/bundle/process.coffee', [index, type]#, silent: true
	child.on 'message', (msg) ->

		child.kill()

		# on error
		if msg.err
			return callback msg.err

		{modules, paths} = msg

		bundle = require('./bundle/result.coffee') modules, paths

		callback null, bundle