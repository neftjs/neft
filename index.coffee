'use strict'

exports = module.exports = require 'src/app'
exports.utils = require 'src/utils'
exports.signal = require 'src/signal'
exports.Dict = require 'src/dict'
exports.List = require 'src/list'
exports.log = require 'src/log'
exports.Resources = require 'src/resources'
exports.Renderer = require 'src/renderer'
exports.Networking = require 'src/networking'
exports.Schema = require 'src/schema'
exports.Document = require 'src/document'
exports.styles = require 'src/styles'
exports.assert = require 'src/assert'
exports.db = require 'src/db'
exports.eventLoop = require 'src/eventLoop'
exports.Binding = require 'src/binding'

if exports.utils.isNative
    exports.native = require 'src/native'

if exports.utils.isNode
    exports.nmlParser = require 'src/nml-parser'
