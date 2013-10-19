'use strict'

preparseRequires = require './preparse/requires.coffee'
preparseDeclarations = require './preparse/declarations.coffee'
preparsePlacedunits = require './preparse/placedunits.coffee'
preparseContents = require './preparse/contents.coffee'
preparseChanges = require './preparse/changes.coffee'

###
Using DOM `body` element find all requires, declarations
and placedunits. Last two things will be saved into `target`.

Found requires files will be automatically loaded.
###
module.exports = (target, callback) ->

	# get declarations
	try
		declarations = target.declarations = preparseDeclarations target.pathbase, target.file
	catch err
		return callback err

	# get declarations from requires
	preparseRequires target.pathbase, target.doc, target.file, declarations, (err) ->

		if err then return callback err

		target.placedunits = preparsePlacedunits target.file, declarations
		#target.contents = preparseContents declarations, target.placedunits
		target.changes = preparseChanges target

		callback null