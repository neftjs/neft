astParser = require './astParser'
codeStringifier = require './codeStringifier'
bundler = require './bundler'
queriesFinder = require './queriesFinder'
importsFinder = require './importsFinder'
transformNamespaceSetters = require './transformNamespaceSetters'
transformClassNesting = require './transformClassNesting'

exports.getAST = (nml, parser) ->
    astParser.parse nml, parser

exports.getObjectCode = ({ast, path}) ->
    codeStringifier.stringify ast, path

exports.getQueries = (objects) ->
    queriesFinder.getQueries objects

exports.getImports = (ast) ->
    importsFinder.getImports ast

exports.transformNamespaceSetters = (ast) ->
    transformNamespaceSetters.transform ast

exports.transformClassNesting = (ast) ->
    transformClassNesting.transform ast

exports.bundle = (nml, parser) ->
    ast = exports.getAST nml, parser
    objects = []
    for object in ast.objects
        exports.transformNamespaceSetters object
        exports.transformClassNesting object
        objects.push
            id: object.id
            code: exports.getObjectCode ast: object, path: parser.resourcePath
    queries = exports.getQueries ast.objects
    imports = exports.getImports ast
    bundle = bundler.bundle
        path: parser.resourcePath
        imports: imports
        constants: ast.constants
        objects: ast.objects
        objectCodes: objects
        queries: queries

    bundle: bundle
    queries: queries
