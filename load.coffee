'use strict'

fs = require 'fs'
jsdom = require 'jsdom'

doc = jsdom.jsdom null, null,
	FetchExternalResources: false
	ProcessExternalResources: false

window = doc.defaultView
body = doc.body

###
Load specified `basepath` file from the filesystem and
parse it using `jsdom` to get DOM structure.
Found `window.document.body` is saved as `target.body`.
###
module.exports = (basepath, target, callback) ->

	# get fs file
	fs.readFile basepath, 'utf-8', (err, file) ->

		if err then return callback err

		body.innerHTML = file

		file = doc.createElement 'fragment' # BUG: use DocumentFragment
		while child = body.firstChild then file.appendChild child

		target.doc = doc
		target.file = file
		callback null