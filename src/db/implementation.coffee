'use strict'

utils = require 'src/utils'

module.exports = do ->
    if utils.isBrowser
        impl = require './implementations/browser'
    if utils.isIOS or utils.isAndroid or utils.isMacOS
        impl = require './implementations/native'
    impl ||= require './implementations/memory'
    impl
