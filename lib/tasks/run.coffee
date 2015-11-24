'use strict'

fs = require 'fs'
open = require 'open'
cp = require 'child_process'

module.exports = (platform, options) ->
	mode = if options.release then 'release' else 'develop'

	switch platform
		when 'node'
			cp.fork "./build/app-node-#{mode}.js"
		when 'browser'
			packageFile = JSON.parse fs.readFileSync './package.json'
			{config} = packageFile
			url = config.url
			url ?= "#{config.protocol}://#{config.host}:#{config.port}"
			open url
		when 'android'
			break
		when 'qt'
			break
