'use strict'

{utils, log} = Neft

REQUEST_DELAY = 50
UID = utils.uid()
exports.CONTROL_COLOR = [240, 20, 130]

updateViewConfig = ->
    {environment} = global
    unless environment
        return
    if not view = environment.view
        return
    utils.merge Neft.Renderer.window, view
    str = do ->
        str = ''
        for key, val of view
            str += "#{key}=#{val} "
        str.trim()
    log "View properties updated to #{str}"

getControlRect = do ->
    rect = null
    ->
        if rect?
            return rect
        updateViewConfig()
        rect = Neft.Renderer.Rectangle.New()
        rect.width = Neft.Renderer.window.width
        rect.height = Neft.Renderer.window.height
        rect.layout.enabled = false
        rect.color = "rgb(#{exports.CONTROL_COLOR})"
        rect.z = 9999
        log.info """
            Create screenshot initialize rect \
            width=#{rect.width} \
            height=#{rect.height} \
            color=#{rect.color}
        """
        rect

exports.initialize = (callback) ->
    getControlRect().parent = Neft.Renderer.window
    url = "#{app.config.testingServerUrl}/initializeScreenshots"
    setTimeout ->
        opts =
            clientUid: UID
            env: environment
        app.networking.post url, opts, (err) ->
            getControlRect().parent = null
            if err
                callback new Error """
                    Cannot initialize screenshots;
                    Make sure application is visible on the screen and \
                    can be captured by screenshot
                """
            else
                callback()
    , REQUEST_DELAY
    return

exports.take = (opts, callback) ->
    opts.clientUid = UID
    opts.env = environment
    url = "#{app.config.testingServerUrl}/takeScreenshot"
    setTimeout ->
        app.networking.post url, opts, callback
    , REQUEST_DELAY
    return
