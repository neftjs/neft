'use strict'

os = require 'os'

module.exports = switch os.platform()
    when 'darwin'
        require './driver/osx'
    when 'linux'
        require './driver/linux'
