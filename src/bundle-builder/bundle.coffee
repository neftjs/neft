'use strict'

fs = require 'fs-extra'
crypto = require 'crypto'
pathUtils = require 'path'
coffee = require 'coffee-script'
os = require 'os'
babel = require 'babel-core'

{log} = Neft

CACHE_DIRECTORY = os.tmpdir()

{stringify} = JSON

IS_COFFEE_RE = ///\.(coffee|litcoffee|coffee.md)$///
IS_LITERATE_COFFEE_RE = ///\.(litcoffee|coffee.md)$///
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
    try
        file = fs.readFileSync path, 'utf-8'
    catch
        return

    extname = pathUtils.extname path

    # compile coffee-script files and cache it
    # TODO: use this caching method in process.coffee as well for babel
    if IS_COFFEE_RE.test(path)
        digest = crypto.createHash('sha1').update(file, 'utf8').digest('hex')
        cache = pathUtils.join CACHE_DIRECTORY, "#{digest}.js"
        if fs.existsSync(cache)
            file = fs.readFileSync cache, 'utf-8'
        else
            isLiterate = IS_LITERATE_COFFEE_RE.test path
            file = coffee.compile file, bare: true, literate: isLiterate
            fs.writeFileSync cache, file, 'utf-8'

    if opts.useBabel and extname is '.js'
        file = babel.transform(file, presets: ['es2015']).code

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
