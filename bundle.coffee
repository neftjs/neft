fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'

global.Neft =
	utils: utils = require 'neft-utils'
	log: require 'neft-log'
	assert: require 'neft-assert'

bundle = require 'neft-bundle-builder'

fs.ensureDir './cli/bundle'
fs.removeSync './node_modules/neft-*/node_modules/neft-*'

createBundle = (opts, callback) ->
	bundle {
		platform: opts.platform
		extras: opts.extras
		release: opts.release
		removeLogs: opts.release
		minify: opts.release
		verbose: true
		path: "index.coffee"
		test: (req) ->
			/^(?:neft\-|\.)/.test(req)
	}, (err, bundle) ->
		if err
			return console.error err?.stack or err

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

		fs.writeFileSync "./cli/bundle/neft-#{name}.js", template

		console.log "Ready: #{name}"
		callback()

TYPES = [
	{ platform: 'node' },
	{ platform: 'browser' },
	{ platform: 'browser', extras: {game: true} },
	{ platform: 'qt' },
	{ platform: 'android' },
	{ platform: 'ios' },
]

stack = new utils.async.Stack

for type in TYPES
	if utils.has(process.argv, "--#{type.platform}")
		opts = { release: false }
		utils.merge opts, type
		stack.add createBundle, null, [opts]
	if utils.has(process.argv, "--#{type.platform}-release")
		opts = { release: true }
		utils.merge opts, type
		stack.add createBundle, null, [opts]

stack.runAll ->
