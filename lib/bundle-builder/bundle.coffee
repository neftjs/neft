# coffeelint: disable=no_debugger

fs = require 'fs-extra'
pathUtils = require 'path'
os = require 'os'
moduleCache = require 'lib/module-cache'

{stringify} = JSON

REALPATH = fs.realpathSync '.'

replaceStr = (str, oldStr, newStr) ->
    i = str.indexOf oldStr
    unless ~i then return str

    r = str.slice 0, i
    r += newStr
    r += str.slice i + oldStr.length

    r

relativePath = (path) ->
    pathUtils.relative REALPATH, path

FILE_SCOPE = """(function(){
    {{before}}
    var __modules = {{init}};

    var __require = (function(){
        var exports = {{declarations}};
        var initialized = new Array(__modules.length);

        function requireFunc(paths, name){
            var path = paths[name] || name;
            var module = __modules[path];
            if (module) {
                if (!initialized[path]) {
                    initialized[path] = true;
                    exports[path] = {};
                    exports[path] = module(exports[path]);
                }
                return exports[path];
            }
            if (typeof require === 'function') {
                return require(name);
            }
            throw new Error("Cannot find module '"+name+"'");
        };

        requireFunc.initModule = function (path, moduleExports) {
            if (!__modules[path]) {
                __modules[path] = function() { return moduleExports }
            }
            initialized[path] = true;
            exports[path] = moduleExports;
        }

        requireFunc.reloadModule = function (path) {
            if (!__modules[path]) {
                throw new Error('Cannot reload unknown module ' + path)
            }
            initialized[path] = false;
        }

        return requireFunc
    })();

    var __createRequire = function (paths){
        var requireFunc = __require.bind(null, paths);
        if (typeof require === 'function') {
            for (var key in require) {
                requireFunc[key] = require[key];
            }
        }
        return requireFunc;
    };

    var __result = __require({index: {{index}}}, 'index');

    if(typeof module !== 'undefined'){
        return module.exports = __result;
    } else {
        return __result;
    }
})();"""

MODULE_SCOPE = '''function(exports){
    var module = {exports: exports};
    var require = __createRequire({{paths}});
    var exports = module.exports;

    (function(){
        {{file}}
    }());

    return module.exports;
}'''

getDeclarations = (modules) ->
    r = []

    for name in modules
        r.push {}

    r

getModulesInit = (modules, paths, indexes, opts) ->
    inits = if opts.release then [] else {}

    for name in modules
        index = if opts.release then indexes[name]
        modulePaths = paths[name]

        pathRefs = {}
        for req, modulePath of modulePaths
            pathRefs[req] = if opts.release then indexes[modulePath] else relativePath modulePath

        unless pathUtils.extname(name)
            continue

        func = moduleCache.getFileSync(name)
        safeName = name.replace /\\/g, '\\\\'

        switch pathUtils.extname(name)
            when '.txt', '.pegjs'
                func = "module.exports = #{JSON.stringify func};"
            when '.json', '.yaml', '.yml', '.txt', '.pegjs'
                func = "module.exports = #{func};"

        module = MODULE_SCOPE
        module = replaceStr module, '{{name}}', safeName
        module = replaceStr module, '{{paths}}', stringify pathRefs
        module = replaceStr module, '{{file}}', func

        if opts.release
            inits[index] = module
        else
            inits[relativePath name] = module

    if opts.release
        "[#{inits}]"
    else if opts.onlyIndex
        result = ""
        for name, func of inits
            result += "module.exports = (#{func})(module.exports);\n"
        result
    else
        result = ""
        for name, func of inits
            result += JSON.stringify(name)
            result += ": #{func},\n"
        "{#{result.slice(0, -2)}}"

getModulesByPaths = (paths) ->
    modules = Object.keys paths

getIndexes = (modules) ->
    indexes = Object.create null
    for module, i in modules
        indexes[module] = i
    indexes

module.exports = (paths, opts, callback) ->
    modules = do ->
        if opts.onlyIndex
            [opts.path]
        else
            getModulesByPaths paths
    if opts.verbose
        for module in modules.sort()
            console.log "Append file '#{module}'"
    indexes = if opts.release then getIndexes(modules)
    declarations = getDeclarations modules
    init = getModulesInit modules, paths, indexes, opts

    if opts.onlyIndex
        callback null, init
        return

    # before
    before = ''
    if opts.env
        before += "var process = typeof global !== 'undefined' && global.process || {env: {}};\n"
        for key, val of opts.env
            before += "process.env['#{key}'] = #{JSON.stringify(val)};\n"
    if opts.globals
        for key, val of opts.globals
            val = JSON.stringify val
            before += "var #{key} = #{val};\n"

    mainIndex = if opts.release then indexes[opts.path] else JSON.stringify(relativePath(opts.path))

    r = FILE_SCOPE
    r = replaceStr r, '{{before}}', before
    r = replaceStr r, '{{index}}', mainIndex
    r = replaceStr r, '{{declarations}}', stringify declarations
    r = replaceStr r, '{{init}}', init

    callback null, r
