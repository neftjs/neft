'use strict'

coffee = require 'coffee-script'
nmlParser = require 'src/nml-parser'

exports.getItemFromNml = (nml) ->
    bundle = nmlParser.bundle(nml: nml).bundle
    func = new Function 'exports', coffee.compile(bundle)
    nmlExports = {}
    func nmlExports
    nmlExports._main(document: null).item
