'use strict'

{utils, Document, styles} = Neft
{createView} = require '../document/utils.server'

masterStyles = {}

Document.onStyle (style) ->
    masterStyles[style.filename] = require style.path
    return

exports.render = (opts) ->
    masterStyles = {}
    doc = createView opts.html
    {path} = doc

    Style = styles
        styles: opts.styles or masterStyles
        queries: opts.queries or {}
        windowStyle: opts.windowStyle or {objects: {}}

    for key, subfile of Document._files
        if key.indexOf(path) is 0
            Style.extendDocumentByStyles subfile

    clone = doc.render()
    clone.destroy()

    doc.render()
