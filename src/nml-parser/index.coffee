`// when=NEFT_SERVER`

'use strict'

astParser = require './astParser'
codeStringifier = require './codeStringifier'
bundler = require './bundler'
queriesFinder = require './queriesFinder'
importsFinder = require './importsFinder'

exports.getAST = (nml) ->
    astParser.parse nml

exports.getObjectCode = ({ast, path}) ->
    codeStringifier.stringify ast, path

exports.getQueries = (objects) ->
    queriesFinder.getQueries objects

exports.getImports = (ast) ->
    importsFinder.getImports ast

exports.bundle = ({nml, path}) ->
    ast = exports.getAST nml
    objects = []
    for object in ast.objects
        objects.push
            id: object.id
            code: exports.getObjectCode ast: object, path: path
    queries = exports.getQueries ast.objects
    imports = exports.getImports ast
    bundle = bundler.bundle
        imports: imports
        constants: ast.constants
        objects: ast.objects
        objectCodes: objects
        queries: queries

    bundle: bundle
    queries: queries
