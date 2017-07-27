'use strict'

eventLoop = require './index'
utils = require 'src/utils'
Dict = require 'src/dict'

module.exports = class EventLoopDict extends Dict
    PROTO_DESC = utils.CONFIGURABLE | utils.WRITABLE
    utils.defineProperty @::, 'constructor', PROTO_DESC, EventLoopDict

    utils.overrideProperty @::, 'set', (_super) -> (key, val) ->
        eventLoop.lock()
        result = _super.call @, key, val
        eventLoop.release()
        result

    utils.overrideProperty @::, 'extend', (_super) -> (obj) ->
        eventLoop.lock()
        result = _super.call @, obj
        eventLoop.release()
        result

    utils.overrideProperty @::, 'pop', (_super) -> (key) ->
        eventLoop.lock()
        result = _super.call @, key
        eventLoop.release()
        result

    utils.overrideProperty @::, 'clear', (_super) -> ->
        eventLoop.lock()
        result = _super.call @
        eventLoop.release()
        result
