'use strict'

{Renderer} = Neft
{Text} = Renderer

textItem = Text.New null, properties: ['running', 'success']
textItem.$.running = true
textItem.$.success = true
window.neftUnitLogItem = textItem

exports.onTestsStart = ->
    textItem.parent = Renderer.window

exports.onTestsEnd = ->
    textItem.$.running = false

exports.log = (msg) ->
    textItem.text += "LOG: #{msg}\n"

exports.ok = (msg) ->
    textItem.text += "OK: #{msg}\n"

exports.error = (msg) ->
    textItem.$.success = false
    textItem.text += "ERROR: #{msg}\n"
