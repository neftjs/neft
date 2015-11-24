'use strict'

pathUtils = require 'path'
fs = require 'fs'

{log, assert} = Neft

exports.verifyNeftProject = (path) ->
	result = false

	src = pathUtils.resolve path, './package.json'
	if fs.existsSync(src)
		json = JSON.parse fs.readFileSync src, 'utf-8'
		if json.devDependencies?.neft
			result = true

	unless result
		log.error "No project found"
		log.info "Valid project must specify 'neft' module in the 'devDependencies' " +
			"of his package.json file"

	result

exports.forEachFileDeep = (dir, onFile, onEnd) ->
	assert.isString dir
	assert.isFunction onFile
	assert.isFunction onEnd

	ready = length = 0
	onReady = ->
		if ++ready is length
			onEnd null

	proceedFile = (path) ->
		fs.stat path, (err, stat) ->
			if err
				return onEnd err

			if stat.isFile()
				onFile path, stat
				onReady()
			else
				exports.forEachFile path, onFile, onReady

	fs.readdir dir, (err, files) ->
		if err or files.length is 0
			return onEnd err

		for file in files
			if file[0] isnt '.'
				length++
				filePath = "#{dir}/#{file}"
				proceedFile filePath
			
		return
	return
