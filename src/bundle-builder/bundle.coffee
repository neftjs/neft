'use strict'

fs = require 'fs-extra'
crypto = require 'crypto'
pathUtils = require 'path'
os = require 'os'
moduleCache = require 'lib/moduleCache'

{log} = Neft
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
    unless extname = pathUtils.extname path
        return

    file = moduleCache.getFile path

    if STRING_FILES[extname]
        file = "module.exports = #{JSON.stringify(file)}"

    file

fileScope = """(function(){
    // list of modules with empty objects
    var modules = {{declarations}};

    // used as `require`
    function getModule(paths, name){
        var path = paths[name];
        return (path in modules ? modules[path] :
               (typeof Neft !== "undefined" && Neft[name]) ||
               (typeof require === 'function' && require(name)) ||
               (function(){throw new Error("Cannot find module '"+name+"'");}()));
    };

    // fill modules by their bodies
    {{init}}

    var result = modules["{{path}}"];

    if(typeof module !== 'undefined'){
        return module.exports = result;
    } else {
        return result;
    }
})();"""

moduleScope = """(function(){
    var module = {exports: modules["{{name}}"]};
    var require = getModule.bind(null, {{paths}});
    var exports = module.exports;

    {{file}}

    return module.exports;
})();"""

getDeclarations = (modules) ->
    r = {}

    for name in modules
        r[name] = {}

    r

getModulesInit = (data, opts) ->
    r = ''

    for name in data.modules
        modulePaths = data.paths[name] or {}

        path = name
        unless func = getFile(path, opts)
            continue

        name = name.replace /\\/g, '\\\\'

        switch pathUtils.extname name
            when '.json'
                func = "module.exports = #{func};"

        module = moduleScope
        module = replaceStr module, '{{name}}', name
        module = replaceStr module, '{{paths}}', stringify modulePaths
        module = replaceStr module, '{{file}}', func

        r += "modules['#{name}'] = #{module}"

    r

module.exports = (processData, opts, callback) ->
    logtime = log.time 'Build bundle'
    declarations = getDeclarations processData.modules
    init = getModulesInit processData, opts

    r = fileScope
    r = replaceStr r, '{{path}}', opts.path
    r = replaceStr r, '{{declarations}}', stringify declarations
    r = replaceStr r, '{{init}}', init
    log.end logtime

    callback null, r
