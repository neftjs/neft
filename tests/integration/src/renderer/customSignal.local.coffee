'use strict'

{getItemFromNml} = require './utils.local'

describe 'Item custom signal', ->
    it 'is accessible', ->
        item = getItemFromNml '''
            Item {
                signal onCustom
            }
        '''
        signalArgs = []
        item.onCustom.connect (args...) -> signalArgs.push args
        item.onCustom.emit 5, 4
        assert.isEqual signalArgs, [[5, 4]]

    it 'can be connected in NML', ->
        item = getItemFromNml '''
            Item {
                property result: 0
                signal calcResult
                calcResult(a, b) {
                    this.result = a + b
                }
            }
        '''
        item.calcResult.emit 1, 4
        assert.is item.result, 5

    it 'can be used in bindings between items', ->
        item = getItemFromNml '''
            Item {
                id: main
                signal show

                Item {
                    if (main.show) {
                        width: 100
                    }
                }
            }
        '''
        assert.is item.children.firstChild.width, 0
        item.show.emit()
        assert.is item.children.firstChild.width, 100

    it 'cannot override other signals', ->
        try
            getItemFromNml '''
                Item {
                    signal onXChange
                }
            '''
        catch
            return
        throw new Error "Should throw an exception"
