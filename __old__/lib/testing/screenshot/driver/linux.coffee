'use strict'

childProcess = require 'child_process'

exports.takeScreenshot = (opts) ->
    childProcess.spawnSync 'import', ['-window', 'root', opts.path]
