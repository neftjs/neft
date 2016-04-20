'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'
fs = require 'fs'

[_, _, path, optsArgv...] = process.argv

realpath = fs.realpathSync ''
opts =
	require: []

# parse opts
do ->
	argv = optsArgv.splice ' '
	i = 0
	n = argv.length
	while i < n
		arg = argv[i]
		switch arg
			when '--require'
				opts.require.push argv[++i]
			else
				throw new Error "Unexpected option '#{arg}'"
		i++

runTestFile = (path) ->
	try
		require pathUtils.join realpath, path
	catch err
		console.error err

pathIsFile = pathIsDir = false

if fs.existsSync(path)
	pathStat = fs.statSync path
	pathIsFile = pathStat.isFile()
	pathIsDir = pathStat.isDirectory()

# requires
for requirePath in opts.require
	requireAbsPath = pathUtils.join realpath, requirePath
	if fs.existsSync(requireAbsPath)
		require requireAbsPath
	else
		require requirePath

if pathIsFile
	runTestFile path
else
	if pathIsDir
		globPath = pathUtils.join path, '/', '**/*'
	else
		globPath = path

	glob globPath, (err, files) ->
		if err
			throw err

		for file in files
			runTestFile file

		return
