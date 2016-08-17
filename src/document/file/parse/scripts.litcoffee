# script

    'use strict'

    fs = require 'fs-extra'
    os = require 'os'
    utils = require 'src/utils'
    pathUtils = require 'path'
    {getFilePath} = require './links'

    uid = 0
    realpath = fs.realpathSync './'
    tmpdir = os.tmpdir()

    isCoffee = (path) -> /\.(?:coffee|litcoffee|coffee\.md)$/.test(path)
    getScriptPath = (filename) ->
        extname = (filename and pathUtils.extname(filename)) or '.js'
        "build/scripts/#{uid++}.js"

    module.exports = (File) -> (file) ->
        if file instanceof File.Iterator
            return

        scripts = []

        for tag in file.node.queryAll('script')
            omit = false
            for attr of tag.attrs
                if attr not in ['src', 'href', 'filename']
                    omit = true
                    break
            if omit
                continue

            tag.parent = null

            {src} = tag.attrs
            src ||= tag.attrs.href

            if src
                src = getFilePath File, file, src
                path = getScriptPath src
                fs.copySync src, path
                scripts.push path
            else
                # tag body
                str = tag.stringifyChildren()
                path = getScriptPath tag.attrs.filename
                if isCoffee(path)
                    str = "`module.exports = function(){`\n\n#{str}\n\n`};`"
                else
                    str = "module.exports = function(){\n\n#{str}\n\n};"
                fs.outputFileSync path, str
                scripts.push path

        file.scripts = new File.Scripts file, scripts

        return

# Glossary

- [script](#neftscript)
