fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'

global.Neft =
    utils: utils = require 'src/utils'
    log: require 'src/log'
    assert: require 'src/assert'

bundle = require 'src/bundle-builder'

fs.ensureDir './cli/bundle'

createBundle = (opts, callback) ->
    bundle {
        platform: opts.platform
        extras: opts.extras
        release: opts.release
        removeLogs: opts.release
        minify: opts.release
        verbose: true
        path: 'index.coffee'
        test: (req) ->
            /^(?:src\/|\.|package\.json)/.test(req)
    }, (err, bundle) ->
        if err
            return console.error err?.stack or err

        try
            tmplSrc = "./scripts/bundle/#{opts.platform}.coffee.mustache"
            template = fs.readFileSync tmplSrc, 'utf-8'
            template = coffee.compile template, bare: true
        try
            tmplSrc = "./scripts/bundle/#{opts.platform}.js.mustache"
            template ||= fs.readFileSync tmplSrc, 'utf-8'
        tmplSrc = "./scripts/bundle/standard.js.mustache"
        template ||= fs.readFileSync tmplSrc, 'utf-8'

        mode = if opts.release then 'release' else 'develop'

        template = Mustache.render template, neftCode: bundle

        extrasText = ''
        if opts.extras
            extrasText = "#{Object.keys(opts.extras).sort().join('-')}-"
        name = "#{opts.platform}-#{extrasText}#{mode}"

        fs.writeFileSync "./cli/bundle/neft-#{name}.js", template

        console.log "Ready: #{name}"
        callback()

TYPES = [
    {platform: 'node'},
    {platform: 'browser'},
    {platform: 'browser', extras: {game: true}},
    {platform: 'qt'},
    {platform: 'android'},
    {platform: 'ios'},
]

stack = new utils.async.Stack

for type in TYPES
    if utils.has(process.argv, "--#{type.platform}")
        opts = {release: false}
        utils.merge opts, type
        stack.add createBundle, null, [opts]
    if utils.has(process.argv, "--#{type.platform}-release")
        opts = {release: true}
        utils.merge opts, type
        stack.add createBundle, null, [opts]

stack.runAll ->
