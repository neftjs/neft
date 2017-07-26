'use strict'

Dict = require 'src/dict'
utils = require 'src/utils'

module.exports = class ImmutableInputDict extends Dict
    constructor: (file, type) ->
        # support no `new` syntax
        unless @ instanceof ImmutableInputDict
            return new ImmutableInputDict file, type

        super()

        `//</development>`
        utils.defineProperty @, '_file', null, file
        utils.defineProperty @, '_type', null, type
        `//</development>`

    PROTO_DESC = utils.CONFIGURABLE | utils.WRITABLE
    utils.defineProperty @::, 'constructor', PROTO_DESC, ImmutableInputDict
    utils.defineProperty @::, '_set', PROTO_DESC, @::set
    utils.defineProperty @::, '_pop', PROTO_DESC, @::pop

    `//<development>`
    utils.overrideProperty @::, 'set', (_super) -> (key, val) ->
        throw new Error """
            Cannot modify #{@_type} in component #{@_file.path} by setting \
            #{key}=#{val}
        """

    utils.overrideProperty @::, 'pop', (_super) -> (key) ->
        throw new Error """
            Cannot modify #{@_type} in component #{@_file.path} by popping key #{key}
        """
    `//</development>`
