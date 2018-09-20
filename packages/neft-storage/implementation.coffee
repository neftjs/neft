'use strict'

utils = require 'src/utils'

module.exports = do ->
    impl = try require './implementations/browser'
    impl or= try require './implementations/native'
    impl or= require './implementations/memory'
    impl
