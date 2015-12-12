fs = require 'fs'
bundle = require 'bundle-builder'
utils = require 'utils'
Mustache = require 'mustache'
coffee = require 'coffee-script'

modulePackage = require './package.json'

createBundle = (opts, callback) ->
	bundle {
		platform: opts.platform
		extras: opts.extras
		release: opts.release
		removeLogs: opts.release
		minify: opts.release
		path: 'index.coffee.md'
	}, (err, bundle) ->
		if err
			return console.error err

		try
			template = fs.readFileSync "./bundle/#{opts.platform}.coffee.mustache", 'utf-8'
			template = coffee.compile template, bare: true
		try
			template ||= fs.readFileSync "./bundle/#{opts.platform}.js.mustache", 'utf-8'
		template ||= fs.readFileSync "./bundle/standard.js.mustache", 'utf-8'

		mode = if opts.release then 'release' else 'develop'

		template = Mustache.render template, neftCode: bundle

		extrasText = if opts.extras then "#{Object.keys(opts.extras).sort().join('-')}-" else ""
		name = "#{opts.platform}-#{extrasText}#{mode}"

		fs.writeFileSync "neft-#{name}.js", template

		console.log "Ready: #{name}"
		callback()

stack = new utils.async.Stack

stack.add createBundle, null, [platform: 'node', release: true]
stack.add createBundle, null, [platform: 'node', release: false]
stack.add createBundle, null, [platform: 'browser', release: true]
stack.add createBundle, null, [platform: 'browser', release: false]
stack.add createBundle, null, [platform: 'browser', extras: {game: true}, release: true]
stack.add createBundle, null, [platform: 'browser', extras: {game: true}, release: false]
# stack.add createBundle, null, [platform: 'qt', release: true]
# stack.add createBundle, null, [platform: 'qt', release: false]
stack.add createBundle, null, [platform: 'android', release: false]
stack.add createBundle, null, [platform: 'android', release: true]
stack.add createBundle, null, [platform: 'ios', release: false]
stack.add createBundle, null, [platform: 'ios', release: true]

stack.runAll ->