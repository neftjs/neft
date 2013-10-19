'use strict'

utils = require 'utils'

DOCTYPE = '<!DOCTYPE html>'


module.exports = (view, callback) ->

	{file, changes} = view

	# put declarations in place of placedunits
	while change = changes.next()
		change[0].replaceChild change[2], change[1]

	# generate html
	html = DOCTYPE + file.innerHTML

	# back changes
	while change = changes.prev()
		change[0].replaceChild change[1], change[2]

	# exit
	callback null, html