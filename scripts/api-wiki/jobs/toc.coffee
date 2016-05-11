'use strict'

{Heading, Paragraph, headingToUrl} = require '../markdown'

class TOCItem
    constructor: (@text, @level) ->

repeatString = (string, count) ->
    r = ''
    r += string for i in [0...count]
    r

exports.modifyFile = (file, path) ->
    items = []

    # get headings
    for type, i in file
        unless type instanceof Heading
            continue
        text = type.getHeadingText()
        level = type.getLevel()
        items.push new TOCItem(text, level)

    # prepare HTML
    html = ''
    for item in items
        html += repeatString '  ', item.level - 1
        html += "* [#{item.text}](#{headingToUrl(item.text)})\n"

    file.toc = html
    return

exports.prepareFileToSave = (file) ->
    # place HTML
    insertWhenPossible = false
    for type, i in file
        unless type instanceof Heading
            continue
        if insertWhenPossible
            tocHeading = new Heading type.line, '## Table of contents'
            tocList = new Paragraph type.line, file.toc
            file.splice i, 0, tocHeading, tocList
            break
        if type.getLevel() is 1
            insertWhenPossible = true

    return
