'use strict'

{Renderer} = Neft
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

describe 'renderer Flow', ->
    flow = items = item1 = item2 = item3 = null

    beforeEach ->
        flow = Flow.New()

        items = []
        for i in [0...3]
            item = items[i] = Item.New()
            item.parent = flow
        [item1, item2, item3] = items

    it '1', ->
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50

        expectSize flow, 150, 50
        expectPosition item1, 0, 0
        expectPosition item2, 50, 0
        expectPosition item3, 100, 0

    it '2', ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50

        expectSize flow, 100, 100
        expectPosition item1, 0, 0
        expectPosition item2, 50, 0
        expectPosition item3, 0, 50

    it '3', ->
        flow.height = 20
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 50
        setSize item3, 50, 50

        expectSize flow, 150, 20
        expectPosition item1, 0, 0
        expectPosition item2, 50, 0
        expectPosition item3, 100, 0

    it '4', ->
        flow.width = 120
        flow.collapseMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20

        expectSize flow, 120, 120
        expectPosition item1, 0, 0
        expectPosition item2, 70, 0
        expectPosition item3, 0, 70

    it '5', ->
        flow.width = 140
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20

        expectSize flow, 140, 150
        expectPosition item1, 20, 10
        expectPosition item2, 90, 0
        expectPosition item3, 20, 80

    it '6', ->
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20

        expectSize flow, 230, 90
        expectPosition item1, 20, 10
        expectPosition item2, 90, 0
        expectPosition item3, 160, 20

    it '7', ->
        flow.width = 120
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20

        expectSize flow, 120, 130
        expectPosition item1, 0, 0
        expectPosition item2, 70, 0
        expectPosition item3, 0, 80

    it '8', ->
        flow.width = 160
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        item1.margin = '10 20'
        setSize item2, 50, 50
        setSize item3, 50, 50
        item3.margin = 20

        expectSize flow, 160, 160
        expectPosition item1, 20, 10
        expectPosition item2, 90, 0
        expectPosition item3, 20, 90

    it '9', ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        setSize item3, 50, 50

        expectSize flow, 100, 150
        expectPosition item1, 0, 0
        expectPosition item2, 0, 50
        expectSize item2, 100, 50
        expectPosition item3, 0, 100

    it '10', ->
        flow.width = 100
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        item2.margin = 10
        setSize item3, 50, 50

        expectSize flow, 100, 170
        expectPosition item1, 0, 0
        expectPosition item2, 0, 60
        expectSize item2, 100, 50
        expectPosition item3, 0, 120

    it '11', ->
        flow.width = 100
        flow.collapseMargins = true
        flow.includeBorderMargins = true
        setSize item1, 50, 50
        setSize item2, 0, 50
        item2.layout.fillWidth = true
        item2.margin = 10
        setSize item3, 50, 50

        expectSize flow, 100, 170
        expectPosition item1, 0, 0
        expectPosition item2, 10, 60
        expectSize item2, 80, 50
        expectPosition item3, 0, 120

    it '12', ->
        flow.width = 110
        flow.height = 200
        flow.collapseMargins = true
        setSize item1, 50, 50
        setSize item2, 50, 0
        item2.layout.fillHeight = true
        item2.margin = 10
        setSize item3, 50, 50

        expectSize flow, 110, 200
        expectPosition item1, 0, 0
        expectPosition item2, 60, 0
        expectSize item2, 50, 140
        expectPosition item3, 0, 150
