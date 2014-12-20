fs = require 'fs'
bundle = require 'bundle'

bundle
	type: 'node'
	path: 'index.coffee'
	onlyLocal: true
	, (err, bundle) ->
		if err
			console.error err
			return

		grammar = fs.readFileSync 'grammar.pegjs', 'utf-8'
		grammar = grammar.replace ///\\///g, "\\\\"
		grammar = grammar.replace ///'///g, "\\'"
		grammar = grammar.replace ///\n///g, "\\n' + '"
		bundle = bundle.replace '{{grammar}}', grammar
		fs.writeFileSync 'out.js', bundle