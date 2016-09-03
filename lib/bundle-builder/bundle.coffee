'use strict'

fs = require 'fs-extra'
crypto = require 'crypto'
pathUtils = require 'path'
os = require 'os'
moduleCache = require 'lib/module-cache'

{stringify} = JSON

STRING_FILES =
    '.pegjs': true
    '.txt': true

replaceStr = (str, oldStr, newStr) ->
    i = str.indexOf oldStr
    unless ~i then return str

    r = str.slice 0, i
    r += newStr
    r += str.slice i + oldStr.length

    r

getFile = (path, opts) ->
    unless extname = pathUtils.extname(path)
        return

    file = moduleCache.getFile path, compile: false

    if STRING_FILES[extname]
        file = "module.exports = #{JSON.stringify(file)}"

    file

fileScope = """(function(){
    var __modules = {{init}};

    var __require = (function(){
        var exports = {{declarations}};
        var initialized = new Array(__modules.length);

        return function (paths, name){
            var path = paths[name];
            if (path < exports.length) {
                if (!initialized[path]) {
                    initialized[path] = true;
                    exports[path] = {};
                    exports[path] = __modules[path](exports[path]);
                }
                return exports[path];
            }
            if (typeof require === 'function') {
                return require(name);
            }
            throw new Error("Cannot find module '"+name+"'");
        };
    })();

    var result = __require({index: {{index}}}, 'index');

    if(typeof module !== 'undefined'){
        return module.exports = result;
    } else {
        return result;
    }
})();"""

moduleScope = '''function(exports){
    var module = {exports: exports};
    var require = __require.bind(null, {{paths}});
    var exports = module.exports;

    {{file}}

    return module.exports;
}'''

getDeclarations = (modules) ->
    r = []

    for name in modules
        r.push {}

    r

getModulesInit = (modules, paths, indexes, opts) ->
    inits = []

    for name in modules
        index = indexes[name]
        modulePaths = paths[name]

        pathRefs = {}
        for req of modulePaths
            pathRefs[req] = indexes[modulePaths[req]]

        unless func = getFile(name, opts)
            continue

        name = name.replace /\\/g, '\\\\'

        switch pathUtils.extname name
            when '.json'
                func = "module.exports = #{func};"

        module = moduleScope
        module = replaceStr module, '{{name}}', name
        module = replaceStr module, '{{paths}}', stringify pathRefs
        module = replaceStr module, '{{file}}', func

        inits[index] = module

    "[#{inits}]"

getModulesByPaths = (paths) ->
    modules = []
    modulesByPaths = Object.create null
    for parentPath of paths
        parentPaths = paths[parentPath]
        for req of parentPaths
            path = parentPaths[req]
            if modulesByPaths[path]
                continue
            modulesByPaths[path] = true
            modules.push path
    modules

getIndexes = (modules) ->
    indexes = Object.create null
    for module, i in modules
        indexes[module] = i
    indexes

module.exports = (processData, opts, callback) ->
    {paths} = processData
    modules = getModulesByPaths paths
    indexes = getIndexes modules
    declarations = getDeclarations modules
    init = getModulesInit modules, paths, indexes, opts

    r = fileScope
    r = replaceStr r, '{{index}}', indexes[opts.path]
    r = replaceStr r, '{{declarations}}', stringify declarations
    r = replaceStr r, '{{init}}', init

    callback null, r
