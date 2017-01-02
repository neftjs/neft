'use strict'

os = require 'os'

module.exports = switch os.platform()
    when 'darwin'
        require './driver/ios'
    when 'linux'
        require './driver/linux'
