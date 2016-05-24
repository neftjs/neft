'use strict'

utils = require 'src/utils'
pathUtils = require 'path'
fs = require 'fs-extra'
{Heading, Paragraph} = require '../markdown'

WIKI_INDEX_FILE_NAME = 'API-Reference.md'
SRC_INDEX_FILE = 'index.litcoffee'
SEP = '/'

filesHeadings = {}
filesTree = {}

exports.modifyFile = (file, path, mdPath) ->
    summary = ''

    for type, i in file
        if type instanceof Heading
            filesHeadings[path] = type.getHeadingText()
        if type instanceof Paragraph and type.text[0] is '>'
            summary = />\s*(.+)/.exec(type.text)[1]
            break
        if i > 0
            break

    filesTree[path] = Object.seal
        heading: filesHeadings[path]
        path: path
        mdPath: mdPath
        summary: summary
        children: []
        parent: null
    return

getFileWikiPageName = (file) ->
    pathUtils.parse(file.mdPath).name

treeToMd = (file, prefix = '') ->
    md = "#{prefix}* [[#{file.heading}|#{getFileWikiPageName(file)}]]"
    if file.summary
        md += " — #{file.summary}"
    md += '\n'

    prefix += '  '
    for child in file.children
        md += treeToMd child, prefix

    md

exports.onFilesParse = (parsedFiles, repo) ->
    indexFiles = {}

    # files to dirs
    for path, file of filesTree
        pathCfg = pathUtils.parse path
        if pathCfg.base is SRC_INDEX_FILE
            indexFiles[path] = file
            filesTree[pathCfg.dir] = file
        else
            fileDir = pathUtils.join pathCfg.dir, '/', pathCfg.name
            filesTree[fileDir] = file

    # children
    fileToParents = {}
    for path, file of filesTree
        pathDirname = pathUtils.dirname path
        pathParts = pathDirname.split SEP
        while pathParts.length
            parentFile = filesTree[pathParts.join(SEP)]
            if parentFile and parentFile isnt file
                fileToParents[file.path] = parentFile
                break
            pathParts.pop()
    for path, parentFile of fileToParents
        childFile = filesTree[path]
        childFile.parent = parentFile
        parentFile.children.push childFile

    # wiki index file
    md = '> [Wiki](Home)'
    md += ' ▸ **API Reference**\n\n'

    mdFilesHeadings = []
    mdFilesByHeadings = {}
    for path, file of indexFiles
        mdFilesHeadings.push file.heading
        mdFilesByHeadings[file.heading] = treeToMd file

    mdFilesHeadings.sort()

    for heading in mdFilesHeadings
        md += mdFilesByHeadings[heading]

    wikiIndexPath = pathUtils.join repo, '/', WIKI_INDEX_FILE_NAME
    fs.outputFileSync wikiIndexPath, md

    return

exports.prepareFileToSave = (file, path) ->
    heading = null
    for type in file
        if type instanceof Heading and type.getLevel() is 1
            heading = type
            break

    treeFile = filesTree[path]

    md = '> [Wiki](Home)'
    md += ' ▸ [[API Reference|API-Reference]]'

    parentsMd = ''
    parent = treeFile
    while parent = parent?.parent
        wikiName = getFileWikiPageName parent
        parentsMd = " ▸ [[#{parent.heading}|#{wikiName}]]" + parentsMd
    md += parentsMd

    if heading
        md += " ▸ **#{heading.getHeadingText()}**"
    md += '\n'

    file.unshift new Paragraph 0, md

    if treeFile.children.length > 0
        for type, i in file
            if type instanceof Heading and i > 1 or i is file.length - 1
                childrenMd = '## Nested APIs\n\n'
                for child in treeFile.children
                    childrenMd += treeToMd child
                childrenType = new Paragraph type.line, childrenMd

                file.splice i, 0, childrenType
                break

    return
