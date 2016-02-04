'use strict'

os = require 'os'
fs = require 'fs-extra'
pathUtils = require 'path'
cp = require 'child_process'

{log} = Neft

PACKAGE_KEYS = ['private', 'name', 'version', 'description', 'config', 'dependencies', 'android']

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

	# restore 'package.json'
	projectPackage = JSON.parse fs.readFileSync "#{src}/package.json"
	packageJson = {}
	for key in PACKAGE_KEYS
		packageJson[key] = projectPackage[key]
	fs.writeFileSync "#{dest}/package.json", JSON.stringify(packageJson, 0, 2)

	# rename .npmignore
	fs.move "#{dest}/.npmignore", "#{dest}/.gitignore", {}

	log.ok "Project created in '#{dest}'"
