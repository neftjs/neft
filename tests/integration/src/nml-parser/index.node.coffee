'use strict'

{utils} = Neft

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

describe 'nml-parser', ->
    describe 'parses functions', ->
        it 'properly', ->
            code = parseAndEval '''
                Item {
                    onEvent: function(a, b){
                        "}";
                        return 1;
                        // {
                        /* { */
                    }
                }
            '''
            assert.is code.objectsConfig[0].onEvent(), 1

        it 'with no function token', ->
            code = parseAndEval '''
                Item {
                    onEvent(a, b){
                        "}";
                        return 1;
                        // {
                        /* { */
                    }
                }
            '''
            assert.is code.objectsConfig[0].onEvent(), 1

        it 'written in ES6', ->
            code = parseAndEval '''
                Item {
                    onEvent: function(){
                        const ab = 2;
                        return {ab};
                    }
                }
            '''
            assert.isEqual code.objectsConfig[0].onEvent(), ab: 2
