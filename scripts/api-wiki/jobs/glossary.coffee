'use strict'

log = require 'src/log'
{Heading, Paragraph, headingToUrl} = require '../markdown'

GLOSSARY_HEADING = 'Glossary'
URL_PREFIX = '/Neft-io/neft/'

glossary = Object.create null
terms = []

escapeRegExp = (str) ->
    str.replace /[.*+?^${}()|[\]\\]/g, '\\$&'

parseList = (list, path, fileLinks) ->
    wikiPath = path.replace /\.md$/, ''
    wikiPath = path.replace /.*\//, ''
    lines = list.split '\n'
    for line in lines
        if match = line.match(/^\s*[\-*]\s*\[([^\]]+)\]\(([^\)]+)\)\s*$/)
            [_, phrase, hash] = match
            link = URL_PREFIX + wikiPath + match[2]

            if glossary[phrase]
                log.warn "API Glossary term duplicated '#{phrase}'"
                continue
            glossary[phrase] = true

            unless fileLinks[match[2]]
                log.warn "API Glossary term '#{phrase}' url '#{hash}' not found"
                continue

            terms.push
                re: new RegExp(escapeRegExp("*#{phrase}*"), 'gm')
                newString: "[#{phrase}](#{link})"

            terms.push
                re: new RegExp(escapeRegExp("<i>#{phrase}</i>"), 'gm')
                newString: "<a href=\"#{link}\">#{phrase}</a>"
    return

exports.modifyFile = (file, path, mdPath) ->
    fileHeadingLinks = {}

    # find glossary and parse links
    for type, i in file
        unless type instanceof Heading
            continue
        text = type.getHeadingText()
        if text is GLOSSARY_HEADING
            list = file[i + 1]
            if list instanceof Paragraph
                parseList list.text, mdPath, fileHeadingLinks
            break
        fileHeadingLinks[headingToUrl(text)] = true
    return

exports.prepareFileToSave = (file) ->
    # link to terms
    for type in file
        if type instanceof Heading or type instanceof Paragraph
            {text} = type
            for term in terms
                text = text.replace term.re, term.newString
            type.text = text
    return
