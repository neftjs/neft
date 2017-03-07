'use strict'

childProcess = require 'child_process'

crop = (opts) ->
    {rect} = opts
    cmd = 'convert '
    cmd += "#{opts.path} "
    cmd += "-crop #{rect.width}x#{rect.height}+#{rect.x}+#{rect.y} "
    cmd += opts.path
    childProcess.execSync cmd, stdio: 'pipe'

resize = (opts) ->
    width = opts.env.view?.width or opts.env.width
    height = opts.env.view?.height or opts.env.height
    if not width or not height
        return
    cmd = 'convert '
    cmd += "#{opts.path} "
    cmd += "-scale #{width}x#{height}\\! "
    cmd += opts.path
    childProcess.execSync cmd, stdio: 'pipe'

compare = (opts) ->
    args = ['-metric', 'AE', '-fuzz', '60%', opts.path, opts.expected, opts.diff]
    compareProcess = childProcess.spawnSync 'compare', args, stdio: 'pipe'

    # support older 'compare' versions with no custom exit codes
    result = compareProcess.stderr.toString().trim().match(/^\d*/)?[0]
    result is '0'

module.exports = (opts) ->
    unless opts.rect
        return false
    crop opts
    resize opts
    compare opts
