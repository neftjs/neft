'use strict'

{unit, assert, Renderer} = Neft
{describe, it, beforeEach} = unit
{Flow, Item} = Renderer

setSize = (item, width, height) ->
    item.width = width
    item.height = height
    item

expectPosition = (item, x, y) ->
    assert.is item.x, x
    assert.is item.y, y
    item

expectSize = (item, width, height) ->
    assert.is item.width, width
    assert.is item.height, height
    item

describe 'src/renderer Flow', ->
    flow = items = item1 = item2 = item3 = onReady = null

    beforeEach ->
        onReadyCallback = null
        onReadyCalled = false
        onReady = ->
            if onReadyCalled or not listen
                return
            onReadyCalled = true
            setTimeout onReadyCallback

        comp = new Renderer.Component
        flow = Flow.New comp
        flow.onWidthChange onReady
        flow.onHeightChange onReady
        flow.onMarginChange onReady

        items = []
        for i in [0...3]
            item = items[i] = Item.New comp
            item.parent = flow
            item.onXChange onReady
            item.onYChange onReady
            item.onWidthChange onReady
            item.onHeightChange onReady
        [item1, item2, item3] = items

        listen = false
        onReady = (callback) ->
            listen = true
            onReadyCallback = callback

    it '1', (done) ->
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 150, 50
            expectPosition item1, 0, 0
            expectPosition item2, 50, 0
            expectPosition item3, 100, 0
            done()

    it '2', (done) ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 100, 100
            expectPosition item1, 0, 0
            expectPosition item2, 50, 0
            expectPosition item3, 0, 50
            done()

    it '3', (done) ->
        flow.height = 20
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 150, 20
            expectPosition item1, 0, 0
            expectPosition item2, 50, 0
            expectPosition item3, 100, 0
            done()

    it '4', (done) ->
        flow.width = 120
        flow.collapseMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20
        onReady ->
            expectSize flow, 120, 120
            expectPosition item1, 0, 0
            expectPosition item2, 70, 0
            expectPosition item3, 0, 70
            done()

    it '5', (done) ->
        flow.width = 140
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20
        onReady ->
            expectSize flow, 140, 150
            expectPosition item1, 20, 10
            expectPosition item2, 90, 0
            expectPosition item3, 20, 80
            done()

    it '6', (done) ->
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20
        onReady ->
            expectSize flow, 230, 90
            expectPosition item1, 20, 10
            expectPosition item2, 90, 0
            expectPosition item3, 160, 20
            done()

    it '7', (done) ->
        flow.width = 120
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20
        onReady ->
            expectSize flow, 120, 130
            expectPosition item1, 0, 0
            expectPosition item2, 70, 0
            expectPosition item3, 0, 80
            done()

    it '8', (done) ->
        flow.width = 160
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20
        onReady ->
            expectSize flow, 160, 160
            expectPosition item1, 20, 10
            expectPosition item2, 90, 0
            expectPosition item3, 20, 90
            done()

    it '9', (done) ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 100, 150
            expectPosition item1, 0, 0
            expectPosition item2, 0, 50
            expectSize item2, 100, 50
            expectPosition item3, 0, 100
            done()

    it '10', (done) ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        item2.margin = 10
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 100, 170
            expectPosition item1, 0, 0
            expectPosition item2, 0, 60
            expectSize item2, 100, 50
            expectPosition item3, 0, 120
            done()

    it '11', (done) ->
        flow.width = 100
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        item2.margin = 10
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 100, 170
            expectPosition item1, 0, 0
            expectPosition item2, 10, 60
            expectSize item2, 80, 50
            expectPosition item3, 0, 120
            done()

    it '12', (done) ->
        flow.width = 110
        flow.height = 200
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 0
        item2.layout.fillHeight = true
        item2.margin = 10
        setSize item3, 50, 50
        onReady ->
            expectSize flow, 110, 200
            expectPosition item1, 0, 0
            expectPosition item2, 60, 0
            expectSize item2, 50, 140
            expectPosition item3, 0, 150
            done()
