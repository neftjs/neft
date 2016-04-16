'use strict'

semver = require 'semver'
fs = require 'fs'
pathUtils = require 'path'
global.Neft = require './bundle/neft-node-develop'

{log} = Neft

# warning for legacy node version
do ->
	currentVersion = process.version
	expectedVersion = require('../package.json').engines.node
	unless semver.satisfies(currentVersion, expectedVersion)
		log.error "Node version '#{currentVersion}' " +
			"is lower than expected '#{expectedVersion}'"

# parse arguments
ARGS_WITH_COMMANDS =
	create: true
	build: true
	run: true

PLATFORMS =
	node: true
	browser: true
	android: true
	qt: true
	ios: true

DEFAULT_OPTIONS_VALUES =
	out: 'build'

args =
	help: false
	version: false
	create: ''
	build: ''
	run: ''

options =
	release: false
	out: ''
	watch: false
	notify: false

argOutput = ''
for arg, i in process.argv when i > 1
	if arg.slice(0, 2) is '--'
		if arg.indexOf('=') >= 0
			[name, value] = arg.split('=')
			name = name.slice(2)
		else
			name = arg.slice(2)
			value = DEFAULT_OPTIONS_VALUES[name] or true

		if options[name] is undefined
			log.error "Unexpected option '"+arg+"'"
			args.help = true

		options[name] = value
	else
		if argOutput
			args[argOutput] = arg
			argOutput = ''
		else
			if args[arg] is undefined
				log.error "Unexpected command '"+arg+"'"
				args.help = true

			args[arg] = true

		if ARGS_WITH_COMMANDS[arg]
			argOutput = arg

if process.argv.length <= 2
	args.help = true

# verify
if args.build is true or args.run is true
	log.error "No platform specified"
	args.help = true
else if (args.build and not PLATFORMS[args.build]) or args.run and not PLATFORMS[args.run]
	log.error "Unsupported platform"
	args.help = true

# commands
if args.help
	log '\n'+fs.readFileSync(pathUtils.resolve(__dirname, './README'), 'utf-8')

else if args.version
	log require('../package.json').version

else if args.create
	require('./tasks/create') args.create, options

else if (platform = args.build or args.run)
	require('./tasks/build') platform, options, (err) ->
		if err
			return log.error err?.stack or err

		if args.run
			require('./tasks/run') platform, options
