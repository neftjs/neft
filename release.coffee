'use strict'

groundskeeper = require 'groundskeeper'

{log} = Neft

RELEASE_NAMESPACES_TO_REMOVE = [
	'assert', 'Object.freeze', 'Object.seal', 'Object.preventExtensions'
]

module.exports = (bundle, opts, callback) ->
	if opts.release
		logtime = log.time 'Release mode'
		namespaces = utils.clone RELEASE_NAMESPACES_TO_REMOVE

		if opts.removeLogs
			namespaces.push 'log'

		bundle = bundle.replace ///\/\/<(\/)?development>;///g, '//<$1development>'
		bundle = bundle.replace /, assert,;/g, ', '
		bundle = bundle.replace /\ assert, |, assert;/g, ' '
		if opts.removeLogs
			bundle = bundle.replace /, log,;/g, ', '
			bundle = bundle.replace /\ log, |, log;/g, ' '
		cleaner = groundskeeper
			console: true
			namespace: namespaces
			replace: 'true'
		cleaner.write bundle
		bundle = cleaner.toString()
		log.end logtime
	else
		bundle = bundle.replace ///<production>([^]*?)<\/production>///gm, ''

	callback null, bundle
