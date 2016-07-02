'use strict'

{Renderer} = Neft
{Device} = Renderer

exports.onTestsStart = ->
    Device.log 'Neft tests started'

exports.onTestsEnd = ->
    Device.log 'Neft tests ended'

exports.log = (msg) ->
    Device.log "Unit LOG: #{msg}\n"

exports.ok = (msg) ->
    Device.log "Unit OK: #{msg}\n"

exports.error = (msg) ->
    Device.log 'Neft tests failed'
    Device.log "Unit ERROR: #{msg}\n"
