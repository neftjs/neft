'use strict'

fs = require 'fs'
PNG = require('pngjs').PNG
client = require '../client'

[RED, GREEN, BLUE] = client.CONTROL_COLOR
CONTROL_COLOR_TRESHOLD = 15

{abs} = Math

isControlColor = (data, idx) ->
    abs(data[idx] - RED) < CONTROL_COLOR_TRESHOLD and
    abs(data[idx + 1] - GREEN) < CONTROL_COLOR_TRESHOLD and
    abs(data[idx + 2] - BLUE) < CONTROL_COLOR_TRESHOLD

onEachPixel = (path, callback) ->
    data = fs.readFileSync path
    png = PNG.sync.read data
    for x in [0...png.width]
        for y in [0...png.height]
            idx = (png.width * y + x) << 2
            callback idx, x, y, png.data
    return

getRects = (path) ->
    rects = []
    lines = []
    onEachPixel path, (idx, x, y, data) ->
        unless isControlColor(data, idx)
            return
        rect = lines[x - 1]?[y]
        if rect
            rect.width = Math.max rect.width, x - rect.x + 1
        else
            rect = lines[x]?[y - 1]
            if rect
                rect.height = Math.max rect.height, y - rect.y + 1
            else
                rect = x: x, y: y, width: 1, height: 1
                rects.push rect
        lines[x] ?= []
        lines[x][y] = rect
    rects

getMaxRect = (rects) ->
    maxRect = null
    max = 0
    for rect in rects
        rectSize = rect.width * rect.height
        if rectSize > max
            max = rectSize
            maxRect = rect
    maxRect

module.exports = (opts) ->
    getMaxRect getRects opts.path
