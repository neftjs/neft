'use strict'

utils = require '../../../../util'
assert = require '../../../../assert'
styles = require '../../styles'

module.exports = (Tag) -> class Props
    constructor: (ref) ->
        utils.defineProperty @, '_ref', 0, ref

    NOT_ENUMERABLE = utils.CONFIGURABLE | utils.WRITABLE
    utils.defineProperty @::, 'constructor', NOT_ENUMERABLE, Props

    utils.defineProperty @::, 'item', NOT_ENUMERABLE, (index, target = []) ->
        assert.isArray target

        target[0] = target[1] = undefined

        i = 0
        for key, val of @
            if @hasOwnProperty(key) and i is index
                target[0] = key
                target[1] = val
                break
            i++

        target

    utils.defineProperty @::, 'has', NOT_ENUMERABLE, (name) ->
        assert.isString name
        assert.notLengthOf name, 0

        @hasOwnProperty name

    utils.defineProperty @::, 'set', NOT_ENUMERABLE, (name, value) ->
        assert.isString name
        assert.notLengthOf name, 0

        # save change
        old = @[name]
        if old is value
            return false

        @[name] = value

        # trigger event
        @_ref.emit 'onPropsChange', name, old
        Tag.query.checkWatchersDeeply @_ref

        styles.onSetProp @_ref, name, value, old

        true
