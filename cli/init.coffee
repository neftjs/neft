'use strict'

semver = require 'semver'
fs = require 'fs'
pathUtils = require 'path'
global.Neft = require './bundle/neft-node-develop'
moduleCache = require 'lib/module-cache'

moduleCache.registerBabel()
moduleCache.registerNml()

{log, utils} = Neft

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
    webgl: true
    android: true
    ios: true

DEFAULT_OPTIONS_VALUES =
    out: 'build'

args =
    help: false
    version: false
    create: ''
    build: []
    run: []
    test: false

options =
    release: false
    out: ''
    watch: false
    notify: false
    'init-file': './init.js'
    config: ''

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
            log.error "Unexpected option '#{arg}'"
            args.help = true

        options[name] = value
    else
        if ARGS_WITH_COMMANDS[arg]
            argOutput = arg
        else if argOutput
            argValue = args[argOutput]
            if Array.isArray(argValue)
                argValue.push arg
            else
                args[argOutput] += arg
        else
            if args[arg] is undefined
                log.error "Unexpected command '#{arg}'"
                args.help = true

            args[arg] = true

# options to camelCase
do ->
    ALIASES =
        'init-file': 'initFile'
    for oldName, newName of ALIASES
        options[newName] = options[oldName]
        delete options[oldName]
    return

if process.argv.length <= 2
    args.help = true

# verify
platforms = args.build
if platforms.length is 0
    platforms = args.run
if utils.has(process.argv, 'build') or utils.has(process.argv, 'run')
    if not platforms or not platforms.length
        log.error 'No platform specified'
        args.help = true
    else
        unsupportedPlatform = platforms.find (platform) -> not PLATFORMS[platform]
        if unsupportedPlatform
            log.error "Unsupported platform #{unsupportedPlatform}"
            args.help = true
    options.platforms = platforms

# commands
if args.help
    helpFilePath = pathUtils.resolve(__dirname, './README')
    helpFile = fs.readFileSync(helpFilePath, 'utf-8')
    log "\n#{helpFile}"

else if args.version
    log require('../package.json').version

else if args.create
    require('./tasks/create') args.create, options

else if platforms.length > 0
    options.isRunning = args.run.length > 0
    require('./tasks/build') options, (err) ->
        if args.run.length > 0 and not err
            for platform in platforms
                require('./tasks/run') platform, options
        else if not options.watch
            process.exit()

else if args.test
    require 'lib/testing/cli'
