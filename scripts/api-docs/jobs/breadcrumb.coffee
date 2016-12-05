'use strict'

utils = require 'src/utils'
pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
{Heading, Paragraph} = require '../markdown'

WIKI_INDEX_PATH = 'SUMMARY.md.mustache'
WIKI_INDEX_OUT_PATH = 'SUMMARY.md'
WIKI_INDEX_API_REF_TAG = 'api-reference'
SRC_INDEX_FILE = 'index.litcoffee'
SEP = '/'

filesHeadings = {}
filesTree = {}

exports.modifyFile = (file, path, mdPath, uri) ->
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
        uri: uri
        summary: summary
        children: []
        parent: null
    return

treeToMd = (file, prefix = '') ->
    md = "#{prefix}* [#{file.heading}](#{file.uri})"
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

    # sort children
    for path, file of filesTree
        file.children.sort (file1, file2) ->
            if file1.heading < file2.heading
                -1
            else if file1.heading > file2.heading
                1
            else
                0

    # wiki index file
    md = ''
    mdFilesHeadings = []
    mdFilesByHeadings = {}
    for path, file of indexFiles
        mdFilesHeadings.push file.heading
        mdFilesByHeadings[file.heading] = treeToMd file

    mdFilesHeadings.sort()

    for heading in mdFilesHeadings
        md += mdFilesByHeadings[heading]

    wikiIndexPath = pathUtils.join repo, '/', WIKI_INDEX_PATH
    wikiIndexOutPath = pathUtils.join repo, '/', WIKI_INDEX_OUT_PATH
    indexWiki = fs.readFileSync wikiIndexPath, 'utf-8'
    indexWiki = Mustache.render indexWiki,
        "#{WIKI_INDEX_API_REF_TAG}": md
    fs.outputFileSync wikiIndexOutPath, indexWiki

    return

exports.prepareFileToSave = (file, path) ->
    heading = null
    for type in file
        if type instanceof Heading and type.getLevel() is 1
            heading = type
            break

    treeFile = filesTree[path]

    md = '> **API Reference**'

    parentsMd = ''
    parent = treeFile
    while parent = parent?.parent
        wikiUri = parent.uri
        parentsMd = " ▸ [#{parent.heading}](#{wikiUri})" + parentsMd
    md += parentsMd

    if heading
        md += " ▸ **#{heading.getHeadingText()}**"
    md += '\n'

    # after first h1
    file.splice 1, 0, new Paragraph 0, md

    return
