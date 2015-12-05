'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
bundleBuilder = require 'bundle-builder'

cliUtils = require '../../../utils'

{utils, log, Document, styles} = Neft

IN_DIR = './views'
OUT_DIR = './build/views'

module.exports = (platform, app, callback) ->
	logtime = log.time 'Parse documents'

	fs.removeSync OUT_DIR

	# install document extensions
	packageConfig = JSON.parse fs.readFileSync('./package.json')
	bundleBuilder.addModulesNamespace Neft
	realpath = fs.realpathSync '.'
	for key of packageConfig.dependencies
		if /^neft\-document\-/.test(key)
			require(pathUtils.join(realpath, '/node_modules/', key))()
	bundleBuilder.removeModulesNamespace Neft

	styles = styles({windowStyle: null, styles: {}})
	utils.clear Document._files

	Document.on Document.ERROR, onErrorListener = (name) ->
		parseFile name, "./views/#{name}.html"

	parseFile = (name, path) ->
		html = fs.readFileSync path, 'utf-8'
		htmlNode = Document.Element.fromHTML html

		for elem in app.stylesQueries
			nodes = htmlNode.queryAll elem.query
			for node in nodes
				unless node.attrs.get('neft:style')
					node.attrs.set 'neft:style', elem.style

		Document.fromHTML name, htmlNode

	saveView = (name, view, callback) ->
		json = JSON.stringify view
		fs.outputFile "#{OUT_DIR}/#{name}.json", json, 'utf-8', callback

	onFilesParsed = ->
		stack = new utils.async.Stack

		for name, view of Document._files
			stack.add saveView, null, [name, view]

		stack.runAllSimultaneously onViewsSaved

	onViewsSaved = (err) ->
		if err
			return callback err

		for name, view of Document._files
			app.views.push
				name: name
				path: "#{OUT_DIR}/#{name}.json"

		Document.off Document.ERROR, onErrorListener

		log.end logtime
		callback null
		return

	cliUtils.forEachFileDeep IN_DIR, (path, stat) ->
		name = path.slice IN_DIR.length
		name = ///^\/(.+)\.html$///.exec(name)?[1]
		if name? and not Document._files[name]
			parseFile name, path
	, (err) ->
		if err
			log.end logtime
			return callback err
		onFilesParsed()
