neft:script @xml
================

    'use strict'

    fs = require 'fs-extra'
    os = require 'os'
    utils = require 'src/utils'
    pathUtils = require 'path'
    { getFilePath } = require './fragments/links'

    uid = 0
    realpath = fs.realpathSync './'
    tmpdir = os.tmpdir()

    module.exports = (File) -> (file) ->
        scripts = []

        for tag in file.node.queryAll('neft:script')
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
                if Neft?
                    path = pathUtils.join 'build/scripts/', filename
                else
                    path = pathUtils.join tmpdir, '/', filename
                fs.outputFileSync path, str
                scripts.push path

        if scripts.length > 0
            file.scripts = new File.Scripts file, scripts

        return
