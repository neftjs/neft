fs = require 'fs'
bundle = require 'bundle'
utils = require 'utils'

modulePackage = require './package.json'

createBundle = (opts, callback) ->
	bundle type: opts.type, release: opts.release, path: 'index.coffee', (err, bundle) ->
		if err
			return console.error err

		license = fs.readFileSync 'LICENSE', 'utf-8'
		template = fs.readFileSync './bundle/template.js', 'utf-8'
		mode = if opts.release then 'release' else 'develop'

		template = template.replace '{{version}}', modulePackage.version
		template = template.replace '{{license}}', license
		template = template.replace '{{bundle}}', bundle
		template = template.replace '{{target}}', opts.type
		template = template.replace '{{mode}}', mode

		fs.writeFileSync "neft-#{opts.type}-#{mode}.js", template

		console.log "Ready: #{opts.type}-#{mode}"
		callback()

stack = new utils.async.Stack

# createBundle type: 'node', release: true
# stack.add createBundle, null, [type: 'node', release: false]
# createBundle type: 'browser', release: true
stack.add createBundle, null, [type: 'browser', release: false]
# createBundle type: 'qml', release: true
# createBundle type: 'qml', release: false

stack.runAll ->