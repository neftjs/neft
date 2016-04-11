'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'
createBundle = require './styles/bundle'

{utils, log, Document} = Neft

cliUtils = require '../../../utils'

IN_DIR = './styles'
OUT_DIR = './build/styles'
QUERIES = './build/styles/queries.json'

getQueryPriority = (val) ->
	Document.Element.Tag.query.getSelectorCommandsLength val

queriesSortFunc = (a, b) ->
	a.dirPriority - b.dirPriority or getQueryPriority(b.query) - getQueryPriority(a.query)

module.exports = (platform, app, callback) ->
	fs.ensureDir OUT_DIR

	filesToLoad = 0
	files = []
	filesByFilename = {}

	inputDirPriorities = {}
	inputDirs = [path: IN_DIR, prefix: '']

	packageConfig = JSON.parse fs.readFileSync('./package.json', 'utf-8')
	for key of packageConfig.dependencies
		stylesPath = "node_modules/#{key}/styles"
		if /^neft\-/.test(key) and fs.existsSync(stylesPath)
			inputDirs.push path: stylesPath, prefix: "#{key}/"

	if utils.isObject(packageConfig.styles)
		for key, val of packageConfig.styles
			inputDirs.push path: val, prefix: "#{key}/"

	for dir, i in inputDirs then do (dir) ->
		if dir.prefix
			inputDirPriorities[dir.prefix] = i
		filesToLoad++
		cliUtils.forEachFileDeep dir.path, (path, stat) ->
			unless pathUtils.extname(path) in ['.js', '.nml']
				return

			filesToLoad++

			filename = dir.prefix + path.slice(dir.path.length+1)
			filename = filename.slice 0, filename.lastIndexOf('.')
			destPath = "#{OUT_DIR}/#{filename}.js"

			fs.stat destPath, (destErr, destStat) ->
				if destErr or (new Date(stat.mtime)).valueOf() > (new Date(destStat.mtime)).valueOf()
					fs.readFile path, 'utf-8', (err, data) ->
						if err
							return callback err

						files.push file =
							dir: dir
							filename: filename
							path: path
							destPath: destPath
							data: data
						filesByFilename[filename] = file

						if files.length is filesToLoad
							onFilesReady()
				else
					files.push file =
						filename: filename
						path: path
						destPath: destPath
					filesByFilename[filename] = file

					if files.length is filesToLoad
						onFilesReady()
		, ->
			filesToLoad--
			if files.length is filesToLoad
				onFilesReady()

	writeFile = (path, data, callback) ->
		data = coffee.compile data
		fs.outputFile path, data, callback

	onFilesReady = ->
		newQueries = {}
		stack = new utils.async.Stack

		for file in files
			if file.data?
				compileLogtime = log.time "Compile '#{file.path}'"
				try
					createBundle file
				catch err
					console.error "\u001b[1mError in `#{file.path}`\u001b[22m\n\n#{err.message or err}"
					log.end compileLogtime
					continue
				log.end compileLogtime
				newQueries[file.filename] = file.queries
				stack.add writeFile, null, [file.destPath, file.data]

			app.styles.push
				name: ///^\./build/styles/(.+)\.[a-z]+$///.exec(file.destPath)[1]
				path: file.destPath

		# queries
		writeLogtime = log.time 'Save styles'
		stack.runAllSimultaneously ->
			log.end writeLogtime

			currentQueries = null
			mergeQueries = ->
				utils.merge currentQueries, newQueries

				for filename, fileQueries of currentQueries
					unless cliUtils.isPlatformFilePath(platform, "#{filename}.js")
						continue

					dirPriority = do ->
						for dir, dirPriority of inputDirPriorities
							if filename.indexOf(dir) is 0
								return dirPriority
						return 0

					for query, val of fileQueries
						val = "styles:#{filename}:#{val}"

						splitQuery = query.split ','
						for query in splitQuery
							app.styleQueries.push
								query: query
								style: val
								dirPriority: dirPriority

				# sort queries
				app.styleQueries.sort queriesSortFunc

				queriesJson = JSON.stringify currentQueries, null, 4
				fs.writeFile QUERIES, queriesJson, callback

			fs.exists QUERIES, (exists) ->
				if exists
					fs.readFile QUERIES, (err, json) ->
						if err?
							return callback err
						currentQueries = JSON.parse json

						# remove abandoned files queries
						for filename of currentQueries
							unless filesByFilename[filename]
								delete currentQueries[filename]

						mergeQueries()
				else
					currentQueries = {}
					mergeQueries()
				return
			return
