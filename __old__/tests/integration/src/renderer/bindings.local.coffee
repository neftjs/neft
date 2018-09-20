'use strict'

eventLoop = require 'src/eventLoop'
{getItemFromNml} = require './utils.local'

describe 'bindings', ->
    it 'are evaluated at the first time when properties are set', ->
        item = getItemFromNml '''
            Item {
                property hasFunc: this.hasFunc || !!this.customFunc || 2

                function customFunc() {
                }
            }
        '''

        assert.is item.hasFunc, true

    it 'are evaluated at the first time when item settled', ->
        item = getItemFromNml '''
            Item {
                id: main
                property failed
                property calls: []

                Item {
                    x: this.runBinding()

                    function runBinding() {
                        if (!main.calls) main.failed = true
                        main.calls.push({ hasParent: !!this.parent })
                    }
                }
            }
        '''

        assert.is item.failed, undefined
        assert.isEqual item.calls, [{hasParent: true}]

    it 'references are available instantly', ->
        eventLoop.lock()
        try
            item = getItemFromNml '''
                Item {
                    id: main
                    property refToChild: child

                    Item {
                        id: child
                    }
                }
            '''
            assert.is item.refToChild, item.children.firstChild
        catch err
        eventLoop.release()
        throw err if err
