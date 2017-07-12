'use strict'

{utils, Document, Renderer, styles} = Neft
{render} = require './utils.server'

describe 'Renderer.Class', ->
    it '\'when\' signal handler properly enables class', ->
        doc = render
            html: '''
                <style>
                Rectangle {
                    Class {
                        when: target.pointer.pressed
                        changes: {
                            color: 'red'
                        }
                    }
                }
                </style>
            '''

        {style} = doc.node

        assert.is style.color, 'transparent'

        style.pointer.pressed = true
        assert.is style.color, 'red'

        style.pointer.pressed = false
        assert.is style.color, 'transparent'
