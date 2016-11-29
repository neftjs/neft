'use strict'

{Paragraph} = require '../markdown'

exports.prepareFileToSave = (file) ->
    # after first h1
    file.splice 1, 0, new Paragraph 0, '<!-- toc -->'
    return
