'use strict'

os = require 'os'
fs = require 'fs-extra'
pathUtils = require 'path'
cp = require 'child_process'

{log} = Neft

module.exports = (dest, options) ->
    dest ||= './'

    if dest isnt './' and fs.existsSync(dest)
        log.error "Destination '#{dest}' already exists"
        return

    log "Copy sample project into '#{dest}'"
    src = pathUtils.resolve(__dirname, 'create/sample-project')
    fs.copySync src, dest
    fs.removeSync "#{dest}/.git"

    log "Install modules (may take a while)"

    onNpmInstall = ->
        log.ok "Project created in '#{dest}'"

    if os.platform() is 'win32'
        cp.exec "cd #{dest} & npm install", onNpmInstall
    else
        cp.exec "cd #{dest} ; npm install", onNpmInstall
