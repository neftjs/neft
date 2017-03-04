'use strict'

fs = require 'fs-extra'
os = require 'os'
utils = require 'src/utils'
log = require 'src/log'
pathUtils = require 'path'

log = log.scope 'Document'
uid = 0
realpath = fs.realpathSync './'
tmpdir = os.tmpdir()

module.exports = (File) -> (file) ->
    {STYLE_ID_PROP} = File.Style
    queries = []
    addedStyles = {}

    if file instanceof File.Iterator
        return

    styleTags = []
    for tag in file.node.children
        if tag.name isnt 'style'
            continue

        styleTags.push tag

        filePath = file.path

        # support win absolute paths
        if pathUtils.isAbsolute(filePath)
            filePath = encodeURIComponent filePath

        # tag body
        body = tag.stringifyChildren()
        name = "#{filePath}##{styleTags.length - 1}"
        stylePath = "styles:#{name}"
        path = pathUtils.join File.STYLES_PATH, name + '.nml'
        fs.outputFileSync path, body
        if name is 'views/Actions/Index.xhtml#0'
            console.log 'REQUIRE', path
        styleFile = require path
        if name is 'views/Actions/Index.xhtml#0'
            console.log require.extensions['.nml'] + ''
            console.log require + ''
            console.log 'QUERIES', styleFile._queries

        unless styleFile._main
            continue

        File.onStyle.emit
            path: path
            filename: name

        for query, style of styleFile._queries
            itemPath = "#{stylePath}:#{style}"
            addedStyles[itemPath] = true
            queries.push
                query: query
                style: itemPath

        # detect main item with no query
        unless file.node.props[STYLE_ID_PROP]
            mainHasDoc = false
            mainId = styleFile._mainLink
            for _, id of styleFile._queries
                if id is mainId
                    mainHasDoc = true
                    break
            unless mainHasDoc
                file.node.props.set STYLE_ID_PROP, "#{stylePath}:#{mainId}"

    while styleTags.length > 0
        styleTags.pop().parent = null

    # detect not supported <style> tags inside another nodes
    if tag = file.node.query('style')
        log.warn "<style> inside '#{tag.parent.name}' element detected;" +
            ' <style> needs to be defined as top-level element in your file or component'

    unless utils.isEmpty(queries)
        File.Style.applyStyleQueriesInDocument file, queries

    return
