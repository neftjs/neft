'use strict'

{Document, utils} = Neft

Document.SCRIPTS_PATH = 'build/scripts'
Document.STYLES_PATH = 'build/styles'

exports.uid = do (i = 0) -> -> "index_#{i++}.html"

exports.createView = (html, viewUid = exports.uid()) ->
    # omit fromJSON cache by detecting differences
    files = utils.clone Document._files
    view = Document.fromHTML viewUid, html
    Document.parse view
    for path, file of Document._files
        if files[path]
            continue
        delete Document._files[path]
        json = JSON.stringify file
        Document.fromJSON json
    Document._files[view.path]

exports.renderParse = (view, opts) ->
    view.render opts?.props, opts?.storage, opts?.source
    view.revert()
    view.render opts?.props, opts?.storage, opts?.source
