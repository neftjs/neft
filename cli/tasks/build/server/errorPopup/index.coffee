'use strict'

Popup = require './style.nml'

###
This file is run in the application code.
Each exception catch by Neft shows up as a popup on the screen.
Not included in the release mode.
###
module.exports = (app) ->
    popup = Popup.New()

    Neft.tryCatch.onError (error) ->
        popup.text = "ERROR: " + String(error?.message or error or "UNKNOWN")
        popup.parent = app.windowItem
