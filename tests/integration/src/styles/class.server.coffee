'use strict'

{utils, Document, Renderer, styles} = Neft
{render} = require './utils.server'

describe 'Renderer.Class', ->
    it '\'running\' property enables class', ->
        doc = render
            html: '''
                <style>
                Rectangle {
                    Class {
                        running: target.pointer.pressed
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
