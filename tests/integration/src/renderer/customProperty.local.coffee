'use strict'

{getItemFromNml} = require './utils.local'

describe 'Item custom property', ->
    it 'is accessible', ->
        item = getItemFromNml '''
            Item {
                property custom: 5
            }
        '''
        assert.is item.custom, 5

    it 'is writable', ->
        item = getItemFromNml '''
            Item {
                property custom: 5
            }
        '''
        item.custom = 10
        assert.is item.custom, 10

    it 'emits change signal', ->
        item = getItemFromNml '''
            Item {
                property custom: 5
            }
        '''
        signalArgs = []
        item.onCustomChange.connect (args...) -> signalArgs.push args
        item.custom = 10
        assert.isEqual signalArgs, [[5, undefined]]

    it 'can be used in bindings', ->
        item = getItemFromNml '''
            Item {
                property custom: 5
                width: this.custom + 1
            }
        '''
        assert.is item.width, 6
        item.custom = 10
        assert.is item.width, 11

    it 'can be used in bindings between items', ->
        item = getItemFromNml '''
            Item {
                id: main
                property custom: 5

                Item {
                    id: child
                    width: main.custom + 1
                }
            }
        '''
        item.custom = 10
        assert.is item.children.firstChild.width, 11

    it 'can be a function', ->
        item = getItemFromNml '''
            Item {
                function createChild(a, b) {
                    return a + b
                }
            }
        '''
        assert.is item.createChild(4, 7), 11

    it 'can be an array literal', ->
        item = getItemFromNml '''
            Item {
                property custom: [];
            }
        '''
        assert.isEqual item.custom, []

    it 'can be an array literal with elements', ->
        item = getItemFromNml '''
            Item {
                property custom: [1, 4, 6];
            }
        '''
        assert.isEqual item.custom, [1, 4, 6]

    it 'can be an object literal', ->
        item = getItemFromNml '''
            Item {
                property custom: {};
            }
        '''
        assert.isEqual item.custom, {}

    it 'can be an object literal with elements', ->
        item = getItemFromNml '''
            Item {
                property custom: {a: 1, b: 2};
            }
        '''
        assert.isEqual item.custom, {a: 1, b: 2}

    it 'cannot override other properties', ->
        try
            getItemFromNml '''
                Item {
                    property x: 5
                }
            '''
        catch
            return
        throw new Error "Should throw an exception"
