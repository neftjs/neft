'use strict'

fs = require 'fs-extra'
os = require 'os'
utils = require 'src/utils'
pathUtils = require 'path'
{getFilePath} = require './links'

DEFAULT_FILE_EXT = '.js'

isCoffee = (path) -> /\.(?:coffee|litcoffee|coffee\.md)$/.test(path)

module.exports = (File) ->
    docScripts = {}
    File.Scripts.initialize docScripts

    (file) ->
        if file instanceof File.Iterator
            return

        scripts = []

        for tag, i in file.node.queryAll('script')
            omit = false
            for prop of tag.props
                if prop not in ['src', 'href', 'filename']
                    omit = true
                    break
            if omit
                continue

            tag.parent = null

            {src} = tag.props
            src ||= tag.props.href

            if src
                # file
                filename = getFilePath File, file, src
                script = fs.readFileSync filename, 'utf-8'
            else
                # tag
                script = tag.stringifyChildren()
                {filename} = tag.props
                if isCoffee(filename)
                    script = "`module.exports = function(){`\n\n#{script}\n\n`};`"
                else
                    script = "module.exports = function(){\n\n#{script}\n\n};"

            filePath = file.path

            # support win absolute paths
            if pathUtils.isAbsolute(filePath)
                filePath = encodeURIComponent filePath

            name = "#{filePath}##{i}"
            extname = (filename and pathUtils.extname(filename)) or DEFAULT_FILE_EXT
            path = pathUtils.join File.SCRIPTS_PATH, name + extname
            fs.outputFileSync path, script
            docScripts[name] = require path
            scripts.push name

        file.scripts = new File.Scripts file, scripts

        return
