'use strict'

fs = require 'fs'
cp = require 'child_process'
log = require 'neft-log'
packageFile = require './package.json'

syncRepoWithDependency = (name) ->
	commit = ''+cp.execSync "cd node_modules/#{name} && git log --pretty=format:\"%h\" -1"
	gitUrl = do ->
		stdout = ''+cp.execSync "cd node_modules/#{name} && git remote -v"
		/origin\s([^\s]+)/m.exec(stdout)[1]

	dependency = "#{gitUrl}##{commit}"
	if packageFile.dependencies[name] isnt dependency
		log.warn "Git URL for the '#{name}' dependency has been updated"
		packageFile.dependencies[name] = dependency

for name in ['neft-android-runtime', 'neft-ios-runtime', 'neft-sample-project', 'neft-nml-parser']
	syncRepoWithDependency name

fs.writeFileSync './package.json', JSON.stringify(packageFile, null, 2)
