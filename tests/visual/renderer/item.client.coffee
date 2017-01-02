'use strict'

visual = require '../utils.client'
itemNml =

checker = new visual.Checker
    prefix: 'renderer/item'
    styles: require './item.nml'

describe 'platform renderer properly renders', ->
    checker.registerAll()
