# style

    'use strict'

    fs = require 'fs-extra'
    os = require 'os'
    utils = require 'src/utils'
    pathUtils = require 'path'
    bundleStyle = null

    uid = 0
    realpath = fs.realpathSync './'
    tmpdir = os.tmpdir()

    module.exports = (File) -> (file) ->
        bundleStyle = Neft.nmlParser.bundle

        queries = []
        addedStyles = {}

        if file instanceof File.Iterator
            return

        styleTags = []
        stylePath = "styles:#{file.path}"
        for tag in file.node.children
            if tag.name isnt 'style'
                continue

            styleTags.push tag

            # tag body
            str = tag.stringifyChildren()
            styleFile =
                data: str
                path: "#{file.path}.js"
                filename: file.path
            bundleStyle styleFile

            if utils.isEmpty(styleFile.codes)
                continue

            File.onStyle.emit styleFile

            for query, style of styleFile.queries
                itemPath = "#{stylePath}:#{style}"
                addedStyles[itemPath] = true
                queries.push
                    query: query
                    style: itemPath

            # detect main item with no document.query
            unless file.node.props['n-style']
                mainHasDoc = false
                mainId = styleFile.codes._main.link
                for _, id of styleFile.queries
                    if id is mainId
                        mainHasDoc = true
                        break
                unless mainHasDoc
                    file.node.props.set 'n-style', stylePath

        while styleTags.length > 0
            styleTags.pop().parent = null

        unless utils.isEmpty(queries)
            File.Style.applyStyleQueriesInDocument file, queries

        return

# Glossary

- [style](#style)
