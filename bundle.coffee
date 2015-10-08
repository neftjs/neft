fs = require 'fs'
bundle = require 'bundle'
utils = require 'utils'

modulePackage = require './package.json'

createBundle = (opts, callback) ->
	bundle {
		type: opts.type
		extras: opts.extras
		release: opts.release
		removeLogs: opts.release
		# minify: true
		path: 'index.coffee.md'
	}, (err, bundle) ->
		if err
			return console.error err

		license = fs.readFileSync 'LICENSE', 'utf-8'
		template = fs.readFileSync './bundle/template.js', 'utf-8'
		mode = if opts.release then 'release' else 'develop'

		bundle = bundle.replace ///\$///g, '$$$'

		template = template.replace '{{version}}', modulePackage.version
		template = template.replace '{{license}}', license
		template = template.replace '{{bundle}}', bundle
		template = template.replace '{{target}}', opts.type
		template = template.replace '{{mode}}', mode

		extrasText = if opts.extras then "#{Object.keys(opts.extras).sort().join('-')}-" else ""
		name = "#{opts.type}-#{extrasText}#{mode}"

		fs.writeFileSync "neft-#{name}.js", template

		console.log "Ready: #{name}"
		callback()

stack = new utils.async.Stack

# stack.add createBundle, null, [type: 'node', release: true]
# stack.add createBundle, null, [type: 'node', release: false]
# stack.add createBundle, null, [type: 'browser', release: true]
stack.add createBundle, null, [type: 'browser', release: false]
# stack.add createBundle, null, [type: 'browser', extras: {game: true}, release: true]
# stack.add createBundle, null, [type: 'browser', extras: {game: true}, release: false]
# stack.add createBundle, null, [type: 'qml', release: true]
# stack.add createBundle, null, [type: 'qml', release: false]
# stack.add createBundle, null, [type: 'android', release: false]

stack.runAll ->