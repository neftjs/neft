'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'

{log} = Neft

module.exports = (dest, options) ->
	dest ||= './'

	if dest isnt './' and fs.existsSync(dest)
		log.error "Destination '#{dest}' already exists"
		return

	src = pathUtils.resolve(__dirname, '../../node_modules/sample-project')
	log "Copy '#{src}' into '#{dest}'"
	fs.copySync src, dest
	log.ok "Project created"
