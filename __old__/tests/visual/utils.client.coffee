'use strict'

{utils} = Neft

exports.Checker = class Checker
    constructor: ({prefix, @styles}) ->
        @prefix = "tests/visual/#{prefix}"
    test: (name) ->
        item = @styles[name](document: null).item
        item.layout.enabled = false
        item.parent = app.windowItem
        expected = "#{@prefix}/#{name}.png"
        takeScreenshot expected, ->
            item.parent = null
    registerAll: ->
        for item of @styles
            do (item) =>
                if item[0] isnt '_' and item isnt 'New'
                    it item, => @test item
        return
