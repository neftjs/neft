'use strict'

{utils, unit, assert} = Neft
{describe, it, beforeEach, afterEach} = unit

parse = require 'src/nml-parser'

FILENAME = 'testsFile.js'

parseAndEval = (text) ->
    result = parse text, FILENAME
    code = result.codes[Object.keys(result.codes)[0]]
    comp =
        objectsConfig: []
    Renderer =
        Component: (config) ->
            comp.config = config
            comp
        Item:
            New: (comp, config) ->
                comp.objectsConfig.push config
    func = new Function 'Renderer', code
    func Renderer
    comp

describe.onNode 'src/nml-parser', ->
    it 'recognizes signals listeners as functions', ->
        code = parseAndEval 'Item {\nonEvent: function(){ return 1; }\n}\n'
        assert.is code.objectsConfig[0].onEvent(), 1

    it 'recognizes signals listeners as functions written in ES6', ->
        nml = 'Item {\nonEvent: function(){ const ab = 2; return {ab}; }\n}\n'
        code = parseAndEval nml
        assert.isEqual code.objectsConfig[0].onEvent(), ab: 2
