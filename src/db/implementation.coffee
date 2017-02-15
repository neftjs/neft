'use strict'

utils = require 'src/utils'

module.exports = do ->
    if utils.isBrowser
        impl = require './implementations/browser'
    if utils.isIOS or utils.isAndroid
        impl = require './implementations/native'
    impl ||= require './implementations/memory'
    impl
