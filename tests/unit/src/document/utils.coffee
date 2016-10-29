'use strict'

{Document, utils} = Neft

VIEWS_CACHE_FILE = 'tmp/views.json'

loaded = false

exports.uid = do (i = 0) -> -> "index_#{i++}.html"

exports.createView = do ->
    getViewPath = (viewUid) ->
        "tmp/views/#{viewUid}.json"

    if utils.isNode
        (html, viewUid = exports.uid()) ->
            loaded = true
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
    else
        cache = require VIEWS_CACHE_FILE
        if utils.isClient and modules?
            Document.Scripts.scriptFiles = modules
        for _, json of cache
            Document.fromJSON json
        (html, viewUid = exports.uid()) ->
            unless loaded
                loaded = true
            view = Document._files[viewUid]
            view

exports.renderParse = (view, opts) ->
    view.render opts?.props, opts?.storage, opts?.source
    view.revert()
    view.render opts?.props, opts?.storage, opts?.source

if utils.isNode
    process.on 'exit', ->
        unless loaded
            return
        fs = require 'fs-extra'
        try
            fs.outputFileSync VIEWS_CACHE_FILE, JSON.stringify(Document._files)
        catch err
            console.error err