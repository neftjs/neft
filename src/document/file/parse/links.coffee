'use strict'

pathUtils = require 'path'

module.exports = (File) -> (file) ->
    # prepare
    links = []

    # load found files
    {children} = file.node
    i = -1
    n = children.length
    while ++i < n
        node = children[i]

        if node.name isnt 'n-import'
            continue

        href = node.props.href or node.props.src
        unless href then continue

        # hide element
        node.name = 'blank'

        namespace = node.props.as

        # get view
        path = getFilePath File, file, href
        links.push
            path: path
            namespace: namespace

    links

getFilePath = module.exports.getFilePath = (File, file, path) ->
    if pathUtils.isAbsolute(path)
        return path

    if /\.{1,2}[\/\\]/.test(path)
        dirname = pathUtils.dirname file.path
        return pathUtils.join(dirname, path)

    pathUtils.join File.FILES_PATH, path
