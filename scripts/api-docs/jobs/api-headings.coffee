'use strict'

PEG = require 'pegjs'
fs = require 'fs-extra'
pathUtils = require 'path'
marked = require 'marked'
{Heading, Paragraph} = require '../markdown'

headingPegPath = pathUtils.join __dirname, './api-headings/syntax.pegjs'
grammar = fs.readFileSync headingPegPath, 'utf-8'
parser = PEG.generate grammar

PROPERTY_TYPES =
    __proto__: null
    Signal: true

defToString = (def) ->
    html = ''
    # if def.namespace
    #     if def.parameters and not PROPERTY_TYPES[def.returns]
    #         html += '<dt>Static method of</dt>'
    #     else
    #         html += '<dt>Static property of</dt>'
    #     html += "<dd><code>#{def.namespace}</code></dd>"

    if def.extends
        html += '<dt>Extends:</dt>'
        html += "<dd><code>#{def.extends}</code></dd>"

    if def.parameters?.length > 0
        html += '<dt>Parameters:</dt>'
        html += '<dd><ul>'
        for param in def.parameters
            html += '<li>'
            html += "#{param.name} — <code>"
            html += param.types.join '</code> or <code>'
            html += '</code>'
            if param.defaults?
                html += " — <code>= #{param.defaults}</code>"
            if param.optional
                html += ' — <i>optional</i>'
            html += '</li>'
        html += '</ul></dd>'

    if def.returns
        if def.parameters and not PROPERTY_TYPES[def.returns]
            html += '<dt>Returns:</dt>'
        else
            html += '<dt>Type:</dt>'
        html += "<dd><code>#{def.returns}</code></dd>"

    if def.default
        html += '<dt>Default value:</dt>'
        html += "<dd><code>#{def.default}</code></dd>"

    if def.features
        for extra in def.features
            html += "<dt>#{extra}</dt>"
    html

exports.modifyFile = (file, path) ->
    i = -1
    while ++i < file.length
        type = file[i]

        unless type instanceof Heading
            continue

        text = type.getHeadingText()
        try
            def = parser.parse text
        catch
            continue

        if def.name is text
            continue

        # break line
        # htmlType = new Paragraph type.line, '\n* * * \n'
        # file.splice i, 0, htmlType
        # i += 1

        # heading
        type.syntax = text
        type.text = "#{type.getMarkdownLevel()} #{def.name}"

        # definition
        defString = defToString def
        if defString
            htmlType = new Paragraph type.line, "\n<dl>#{defString}</dl>\n"
            file.splice i + 1, 0, htmlType
            i += 1

    return
