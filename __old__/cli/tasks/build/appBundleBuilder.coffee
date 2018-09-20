'use strict'

fs = require 'fs'
pathUtils = require 'path'
Module = require 'module'
bundleBuilder = require 'lib/bundle-builder'
utils = require 'src/utils'
signal = require 'src/signal'
cliUtils = require 'cli/utils'

module.exports = (opts, callback) ->
    builderOpts = utils.clone opts
    utils.merge builderOpts,
        env: cliUtils.getProcessEnvForPlatform(opts.platform)

    bundleBuilder builderOpts, callback
