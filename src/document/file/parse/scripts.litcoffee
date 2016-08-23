# script

    'use strict'

    fs = require 'fs-extra'
    os = require 'os'
    utils = require 'src/utils'
    pathUtils = require 'path'
    {getFilePath} = require './links'

    OUT_DIR = 'build/scripts/'
    DEFAULT_FILE_EXT = '.js'

    isCoffee = (path) -> /\.(?:coffee|litcoffee|coffee\.md)$/.test(path)

    module.exports = (File) -> (file) ->
        if file instanceof File.Iterator
            return

        scripts = []

        for tag, i in file.node.queryAll('script')
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
                # file
                filename = getFilePath File, file, src
                script = fs.readFileSync filename, 'utf-8'
            else
                # tag
                script = tag.stringifyChildren()
                {filename} = tag.attrs
                if isCoffee(filename)
                    script = "`module.exports = function(){`\n\n#{script}\n\n`};`"
                else
                    script = "module.exports = function(){\n\n#{script}\n\n};"

            name = "#{file.path}##{i}"
            extname = (filename and pathUtils.extname(filename)) or DEFAULT_FILE_EXT
            path = pathUtils.join OUT_DIR, name + extname
            fs.outputFileSync path, script
            File.Scripts.scripts[name] = require path
            scripts.push name

        file.scripts = new File.Scripts file, scripts

        return

# Glossary

- [script](#neftscript)
