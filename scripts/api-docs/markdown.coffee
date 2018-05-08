'use strict'

escapeHtml = require 'escape-html'

exports.Heading = class Heading
    constructor: (@line = 0, @text = '', @syntax = '') ->
    getLevel: ->
        prefix = /^([#]+)/.exec @text
        if prefix?
            return prefix[1].length
        else if /^=/m.test(@text)
            return 1
        else if /^-/m.test(@text)
            return 2
        return -1
    getMarkdownLevel: ->
        /^([#]+)/.exec(@text)?[1] or ''
    getHeadingText: ->
        escapeHtml /^(?:[#]*)(.*)/.exec(@text)?[1]?.trim?() or ''
    setHeadingText: (val) ->
        @text = /^([#]*)/.exec(@text)?[1] + val

exports.Paragraph = class Paragraph
    constructor: (@line = 0, @text = '') ->

exports.ProgramCode = class ProgramCode
    constructor: (@line = 0, @text = '') ->

exports.parse = (str) ->
    file = []
    lines = str.split '\n'
    lines.push ''
    lastType = null
    pushedType = null

    for line, i in lines
        # break
        if line.trim() is ''
            if lastType
                pushedType = lastType
                file.push lastType
                lastType = null

        # heading
        else if /^#+/.test(line) or /^[\-=]+$/.test(lines[i + 1].trim())
            lastType ?= new Heading i

        # program code
        else if /^\s{4}|^\t/.test(line)
            lastType ?= new ProgramCode i

        # paragraph
        else
            lastType ?= new Paragraph i

        # join the same types
        if pushedType and lastType
            if pushedType.__proto__ is lastType.__proto__ and not (lastType instanceof Heading)
                file.pop()
                pushedType.text += "#{lastType.text}\n"
                lastType = pushedType
            pushedType = null

        # insert line into type
        if lastType
            lastType.text += "#{line}\n"

    file

exports.stringify = (file) ->
    md = ''

    for type in file
        md += "#{type.text}\n"

    md

exports.headingToUrl = (text) ->
    text = text.replace /^#*/, ''
    text = text.trim()
    text = text.toLowerCase()
    text = text.replace /[^a-z0-9 ]/g, ''
    text = text.replace /\ /g, '-'
    "##{text}"
