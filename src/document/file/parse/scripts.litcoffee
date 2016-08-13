# script

    'use strict'

    fs = require 'fs-extra'
    os = require 'os'
    utils = require 'src/utils'
    pathUtils = require 'path'
    { getFilePath } = require './links'

    uid = 0
    realpath = fs.realpathSync './'
    tmpdir = os.tmpdir()

    isCoffee = (path) -> /\.(?:coffee|litcoffee|coffee\.md)$/.test(path)

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
                scripts.push src
            else
                # tag body
                str = tag.stringifyChildren()
                filename = tag.attrs.filename or "tmp#{uid++}.js"
                if isCoffee(filename)
                    str = "`module.exports = function(){`\n\n#{str}\n\n`};`"
                else
                    str = "module.exports = function(){\n\n#{str}\n\n};"
                if Neft?
                    path = pathUtils.join 'build/scripts/', filename
                else
                    path = pathUtils.join tmpdir, '/', filename
                fs.outputFileSync path, str
                scripts.push path

        file.scripts = new File.Scripts file, scripts

        return

# Glossary

- [script](#neftscript)
