'use strict'

# ! IMPORTANT !
# DO NOT INCLUDE THIS FILE INTO PRODUCTION BUILDS

{log, utils, Document} = Neft
try {onNativeEvent} = Neft.native

log = log.scope 'HotReloader'

NATIVE_EVENT = '__neftHotReload'

reloadDocumentDeeply = (doc, reloadCompPath) ->
    # uses
    for use in doc.uses
        unless use.isRendered
            continue
        if doc.components[use.name] is reloadCompPath
            use.revert()
            delete Document._pool[reloadCompPath]
            use.render()
        else if use.usedComponent
            reloadDocumentDeeply use.usedComponent, reloadCompPath

    # iterators
    for iterator in doc.iterators
        unless iterator.isRendered
            continue
        if iterator.name is reloadCompPath
            iterator.revert()
            delete Document._pool[reloadCompPath]
            iterator.render()
        else
            for child in iterator.usedComponents
                reloadDocumentDeeply child, reloadCompPath
    return

reloadRouteDocument = (app, route, reloadCompPath) ->
    onLoadEnd = ->
        app.Route.onLastClientRouteChange.disconnect onLoadEnd
        delete Document._pool[reloadCompPath]

    app.Route.onLastClientRouteChange.connect onLoadEnd
    app.networking.createLocalRequest route.request.toJSON()

    return

module.exports = (app) ->

    reloadVisibleComponent = (name) ->
        delete Document._pool[name]
        lastRespData = app.Route.lastClientRoute?.response.data
        if lastRespData instanceof Document
            if lastRespData.path is name
                reloadRouteDocument app, app.Route.lastClientRoute, name
            else
                reloadDocumentDeeply lastRespData, name
        return

    reloadDocStyleDeeply = (doc, style, stylesToReload) ->
        unless style.node instanceof Document.Element.Tag
            return
        styleId = style.node.props[Document.Style.STYLE_ID_PROP]
        styleIdParts = styleId.split ':'
        if styleIdParts[0] is 'styles' and stylesToReload[styleIdParts[1]]
            reloadVisibleComponent doc.path
            return
        for substyle in style.children
            reloadDocStyleDeeply doc, substyle, stylesToReload
        return

    reloadComponent = (name, fileStr) ->
        log.debug "Reload component #{name}"
        func = new Function 'module', fileStr
        funcModules = exports: {}
        name = "components/#{name}"
        delete Document._files[name]
        func funcModules
        app.components[name] = Document.fromJSON funcModules.exports
        reloadVisibleComponent name

    reloadStyle = (name, fileStr) ->
        log.debug "Reload style #{name}"

        # evaluate new file
        styleModule = do (module, exports = {}) ->
            module = exports: exports
            eval fileStr
            module

        # initialize and save new style
        styleModule.exports._init windowItem: app.windowItem
        app.styles[name] = styleModule.exports

        # get styles to reload
        stylesToReload = "#{name}": true
        fullName = "styles/#{name}"
        for styleName, style of app.styles
            if style._imports[fullName]
                stylesToReload[styleName] = true

        # reload current style in modules
        __require.initModule styleModule.exports._path, styleModule.exports

        # reload modules
        for styleName of stylesToReload
            if styleName is name
                continue
            path = app.styles[styleName]._path
            __require.reloadModule path
            app.styles[styleName] = require path
            app.styles[styleName]._init windowItem: app.windowItem

        # reload documents
        for path, file of Document._files
            for style in file.styles
                reloadDocStyleDeeply file, style, stylesToReload

        return

    reloadScript = (name, fileStr) ->
        log.debug "Reload script #{name}"
        scriptModule = do (module, exports = {}) ->
            module = exports: exports
            eval fileStr
            module
        app.documentScripts[name] = scriptModule.exports

        for path, file of Document._files
            if utils.has(file.scripts.names, name)
                reloadVisibleComponent path

        return

    app?.reload = reload = (hotReloads) ->
        for hotReload in hotReloads
            switch hotReload.destination
                when 'components'
                    reloadComponent(hotReload.name, hotReload.file)
                when 'styles'
                    reloadStyle(hotReload.name, hotReload.file)
                when 'scripts'
                    reloadScript(hotReload.name, hotReload.file)
                else
                    throw new Error "Unsupported hot reload destination #{hotReload.destination}"

    if process.env.NEFT_NATIVE
        onNativeEvent NATIVE_EVENT, (data) ->
            reload JSON.parse(data).hotReloads
