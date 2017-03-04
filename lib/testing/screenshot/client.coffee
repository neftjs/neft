'use strict'

{utils} = Neft

UID = utils.uid()
exports.CONTROL_COLOR = [240, 20, 130]

getControlRect = do ->
    rect = null
    ->
        if rect?
            return rect
        rect = Neft.Renderer.Rectangle.New()
        rect.width = Neft.Renderer.window.width
        rect.height = Neft.Renderer.window.height
        rect.layout.enabled = false
        rect.color = "rgb(#{exports.CONTROL_COLOR})"
        rect.z = 9999
        rect

exports.initialize = (callback) ->
    getControlRect().parent = Neft.Renderer.window
    url = "#{app.config.testingServerUrl}/initializeScreenshots"
    requestAnimationFrame ->
        app.networking.post url, clientUid: UID, (err) ->
            getControlRect().parent = null
            if err
                callback new Error """
                    Cannot initialize screenshots;
                    Make sure application is visible on the screen and \
                    can be captured by screenshot
                """
            else
                callback()
    return

exports.take = (opts, callback) ->
    opts.clientUid = UID
    opts.env = environment
    url = "#{app.config.testingServerUrl}/takeScreenshot"
    requestAnimationFrame ->
        app.networking.post url, opts, callback
    return
