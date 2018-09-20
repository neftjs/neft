'use strict'

coffee = require 'coffee-script'
nmlParser = require 'src/nml-parser'
eventLoop = require 'src/eventLoop'

exports.getItemFromNml = (nml) ->
    bundle = nmlParser.bundle(nml: nml).bundle
    func = new Function 'exports', coffee.compile(bundle)
    nmlExports = {}
    func nmlExports

    eventLoop.lock()
    try result = nmlExports._main(document: null).item
    catch err
    eventLoop.release()
    throw err if err
    result
