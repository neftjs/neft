'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'
fs = require 'fs'

[_, _, path, optsArgv...] = process.argv

realpath = fs.realpathSync './'
opts =
    require: []
    ignore: []

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
            when '--ignore'
                opts.ignore.push argv[++i]
        i++

runTestFile = (path) ->
    absPath = pathUtils.join realpath, path
    try
        require absPath
    catch err
        unitsStack.errors.push new Error "Can't load file '#{absPath}'"
        unitsStack.errors.push err

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

unitsStack = require './stack'
require './index'

if pathIsFile
    runTestFile path
else
    if pathIsDir
        globPath = pathUtils.join path, '/', '**/*'
    else
        globPath = path

    files = glob.sync globPath,
        ignore: opts.ignore
    for file in files
        runTestFile file

    return
