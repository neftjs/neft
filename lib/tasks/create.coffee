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
	src = pathUtils.resolve(__dirname, '../../node_modules/sample-project')
	fs.copySync src, dest
	fs.removeSync "#{dest}/.git"

	log "Install modules (may take a while)"

	if os.platform() is 'win32'
		cp.execSync "cd #{dest} & npm install"
	else
		cp.execSync "cd #{dest} ; npm install"

	log.ok "Project created in '#{dest}'"
