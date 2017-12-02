'use strict'

{getItemFromNml} = require './utils.local'

describe 'Class', ->
    describe 'changes', ->
        it 'can be modified by binding', ->
            item = getItemFromNml '''
                Item {
                    property props
                    property propsIsRunning: true

                    Class {
                        running: target.propsIsRunning
                        changes: target.props
                    }
                }
            '''

            item.props = width: 100
            assert.is item.width, 100

            item.props = height: 50
            assert.is item.width, 0
            assert.is item.height, 50

            item.propsIsRunning = false
            assert.is item.height, 0

    describe 'target', ->
        it 'can be changed in runtime', ->
            item = getItemFromNml '''
                Item {
                    property itemClass: itemClass

                    Item {}
                    Item {}

                    Class {
                        id: itemClass
                        running: true
                        changes: {
                            x: 100
                        }
                    }
                }
            '''

            {firstChild, lastChild} = item.children

            item.itemClass.target = firstChild
            assert.is item.x, 0
            assert.is firstChild.x, 100
            assert.is lastChild.x, 0

            item.itemClass.target = lastChild
            assert.is item.x, 0
            assert.is firstChild.x, 0
            assert.is lastChild.x, 100
