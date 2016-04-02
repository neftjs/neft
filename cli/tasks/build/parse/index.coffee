'use strict'

fs = require 'fs'

{utils, log} = Neft

PLATFORM_TYPES =
	node:
		node: true
		server: true
	browser:
		browser: true
		client: true
	qt:
		qt: true
		client: true
		native: true
	android:
		android: true
		client: true
		native: true
	ios:
		ios: true
		client: true
		native: true

SPECIAL_EXTS = do ->
	r = {}
	for _, exts of PLATFORM_TYPES
		utils.merge r, exts
	r

CONFIG_LINKS_TO_REQUIRE =
	views: true
	styles: true
	models: true
	routes: true

###
Prepares index file
###
module.exports = (platform, app, callback) ->
	stringifyLink = (obj) ->
		unless utils.isObject(obj)
			return obj

		{name, path} = obj

		if linkTypeMatch = /^(.+?)\.([a-zA-Z]+)$/.exec(name)
			[_, name, linkType] = linkTypeMatch

		val = "`require('#{path}')`"
		obj.path = undefined
		if linkType and SPECIAL_EXTS[linkType]
			if PLATFORM_TYPES[platform][linkType]
				obj.name = name
			else
				return false;

		obj.file = val
		return true

	jsonReplacer = (key, val) ->
		if CONFIG_LINKS_TO_REQUIRE[key]
			i = 0
			while i < val.length
				if stringifyLink(val[i])
					i++
				else
					val.splice i, 1
		val

	# include document extensions
	packageFile = JSON.parse fs.readFileSync('./package.json', 'utf-8')
	try
		for key of packageFile.dependencies
			if /^neft\-document\-/.test(key)
				app.extensions.push "`require('#{key}')`"

	# get 'package.json' config
	app.config = packageFile.config

	# parse app into object
	config = JSON.stringify app, jsonReplacer
	config = config.replace ///"`///g, ''
	config = config.replace ///`"///g, ''

	# create file
	result = ''
	result += "var opts = #{config};\n"
	result += "var init = require('./init');\n"
	result += "opts.modules = typeof modules !== 'undefined' ? modules : {};\n"
	result += "init(Neft.bind(null, opts));\n"

	result
