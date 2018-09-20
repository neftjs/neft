'use strict'

visual = require '../utils.client'

checker = new visual.Checker
    prefix: 'renderer/item'
    styles: require './item.nml'

describe 'platform renderer properly renders item', ->
    checker.registerAll()
