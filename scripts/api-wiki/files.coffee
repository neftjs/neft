'use strict'

fs = require 'fs-extra'
glob = require 'glob'
pathUtils = require 'path'
utils = require 'src/utils'
markdown = require './markdown'

{Heading} = markdown

realpath = fs.realpathSync '.'

JOBS = [
    require('./jobs/source-to-links'),
    require('./jobs/api-headings'),
    require('./jobs/glossary'),
    require('./jobs/breadcrumb'),
    require('./jobs/toc')
]

getMarkdownFileHeading = (md) ->
    /#*\s*(.+)/.exec(md)[1]

toWikiPath = (path, repo, md) ->
    parts = pathUtils.parse path
    dir = parts.dir
    moduleName = parts.dir.split(pathUtils.sep)[2]
    for type in md
        if type instanceof Heading
            firstHeading = type
            break
    fileHeading = getMarkdownFileHeading firstHeading?.getHeadingText()

    filename = utils.capitalize moduleName
    unless utils.has(pathUtils.basename(path), 'index')
        filename += '-' + fileHeading
    filename += '-API.md'
    wikiPath = pathUtils.join repo, filename

exports.parseAll = (path, repo, callback) ->
    parsedFiles = []

    parseFileAndSave = (path, repo, callback) ->
        exports.parseFile path, repo, (err, file) ->
            parsedFiles.push file
            callback err

    glob path, (err, files) ->
        if err
            throw new Error err

        stack = new utils.async.Stack

        for path in files
            stack.add parseFileAndSave, null, [path, repo]

        stack.runAllSimultaneously (err) ->
            # apply jobs
            for job in JOBS
                job.onFilesParse? files, repo

            callback err, parsedFiles

        return
    return

exports.parseFile = (path, repo, callback) ->
    absPath = pathUtils.join realpath, path
    fs.readFile absPath, 'utf-8', (err, contents) ->
        if err
            return callback err

        md = markdown.parse contents
        mdPath = toWikiPath path, repo, md

        # apply jobs
        for job in JOBS
            job.modifyFile? md, path, mdPath

        callback null,
            path: path
            mdPath: mdPath
            markdown: md

        return
    return

exports.saveFiles = (files, callback) ->
    stack = new utils.async.Stack

    for file in files
        stack.add exports.saveFile, null, [file]

    stack.runAllSimultaneously callback
    return

exports.saveFile = (file, callback) ->
    # apply jobs
    for job in JOBS
        job.prepareFileToSave? file.markdown, file.path

    md = markdown.stringify file.markdown
    fs.outputFile file.mdPath, md, callback
