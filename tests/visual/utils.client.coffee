'use strict'

{utils} = Neft

exports.Checker = class Checker
    constructor: ({prefix, @styles}) ->
        @prefix = "tests/visual/#{prefix}"
    test: (name) ->
        item = @styles[name]()
        item.parent = Neft.Renderer.window
        item.layout.enabled = false
        expected = "#{@prefix}/#{name}.png"
        takeScreenshot expected, ->
            item.parent = null
    registerAll: ->
        for item of @styles
            do (item) =>
                if /^test/.test(item)
                    it item, => @test item
        return
