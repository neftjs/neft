# coffeelint: disable=no_debugger

util = require 'util'
fs = require 'fs-extra'
pathUtils = require 'path'
Mustache = require 'mustache'
coffee = require 'coffee-script'
bundle = require 'lib/bundle-builder'
moduleCache = require 'lib/module-cache'
cliUtils = require 'cli/utils'
log = require 'src/log'

moduleCache.registerCoffeeScript()
moduleCache.registerYaml()
moduleCache.registerTxt(['.txt', '.pegjs'])

fs.ensureDir './cli/bundle'

createBundle = (opts, callback) ->
    log "Create Neft bundle file for #{opts.platform} platform"
    env = cliUtils.getProcessEnvForPlatform opts.platform
    console.log "Use process.env = #{util.inspect env}"
    bundle {
        release: opts.release
        removeLogs: opts.release
        minify: opts.release
        verbose: true
        path: pathUtils.join(fs.realpathSync('.'), './index.coffee')
        basepath: fs.realpathSync('.')
        env: env
    }, (err, bundle) ->
        log.show ''

        if err
            return callback err

        tmplName = opts.template or opts.platform
        try
            tmplSrc = "./scripts/bundle/#{tmplName}.coffee.mustache"
            template = fs.readFileSync tmplSrc, 'utf-8'
            template = coffee.compile template, bare: true
        try
            tmplSrc = "./scripts/bundle/#{tmplName}.js.mustache"
            template ||= fs.readFileSync tmplSrc, 'utf-8'
        tmplSrc = './scripts/bundle/standard.js.mustache'
        template ||= fs.readFileSync tmplSrc, 'utf-8'

        mode = if opts.release then 'release' else 'develop'

        template = Mustache.render template, neftCode: bundle

        name = "#{opts.platform}-#{mode}"

        fs.writeFileSync "./cli/bundle/neft-#{name}.js", template

        callback()

TYPES = for platform, opts of cliUtils.platforms
    platform: platform
    template: switch platform
        when 'html', 'webgl' then 'browser'
        else platform

do ->
    stack = []
    buildAll = process.argv.length is 2

    registerBundle = (type, opts) ->
        bundleOpts = {}
        bundleOpts[key] = val for key, val of type
        bundleOpts[key] = val for key, val of opts
        stack.push (callback) -> createBundle(bundleOpts, callback)

    for type in TYPES
        if buildAll or process.argv.indexOf("--#{type.platform}") >= 0
            registerBundle type, {release: false}
        if buildAll or process.argv.indexOf("--#{type.platform}-release") >= 0
            registerBundle type, {release: true}

    index = -1
    callback = (err) ->
        if err?
            console.error err
            return
        index += 1
        if index < stack.length
            stack[index] callback

    callback()

    return
