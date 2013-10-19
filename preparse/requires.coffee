'use strict'

utils = require 'utils'

LINK = 'LINK'

###
Parse `body` and find all special `link` tags. Load pointed files.

From loaded files get `declarations` and append them into `declarations`
with `path` prefix.
###
module.exports = (pathbase, doc, file, declarations, callback) ->

	View = require '../index.coffee'

	nodes = file.querySelectorAll 'link[rel="require"][href]'
	unless nodes.length then return callback null

	stack = new utils.async.Stack

	requireView = (href, callback) ->

		View.parse pathbase + href, (err, result) ->

			if err then return callback err

			# save found declarations and exit
			utils.merge declarations, result.declarations

			callback null

	for node in nodes

		href = node.getAttribute 'href'

		# remove link element
		file.removeChild node

		stack.add null, requireView, href

	stack.runAllSimultaneously callback