'use strict'

childProcess = require 'child_process'

exports.takeScreenshot = (opts) ->
    childProcess.spawnSync 'screencapture', ['-d', '-o', '-T0', '-x', '-a', opts.path]
