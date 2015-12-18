	'use strict'

	fs = require 'fs'

	{utils, log} = Neft

Platform-specified files
------------------------

When building each platform can has its own customized files.

Specify this type before the file extension and prefix it by a dot.

Example: models/products.server.js

Recognized types:
 - node: node, server,
 - browser: browser, client,
 - qt: qt, client, native,
 - android: android, client, native,
 - ios: ios, client, native.

	PLATFORM_TYPES =
		node:
			server: true
		browser:
			client: true
		qt:
			client: true
			native: true
		android:
			client: true
			native: true
		ios:
			client: true
			native: true

Platform-specified files are supported for views, styles, models and routes.

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
			if linkType
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
		result += "init(Neft.bind(null, opts));\n"

		result
