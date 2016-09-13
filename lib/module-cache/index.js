'use strict';

const os = require('os');
const fs = require('fs-extra');
const pathUtils = require('path');
const crypto = require('crypto');
const babel = require('babel-core');
const CoffeeScript = require('coffee-script');
const yaml = require('js-yaml');

const HASH = 'sha';
const TMP_DIR = pathUtils.join(os.tmpdir(), '/neft-files-cache/');
const BABEL_OPTIONS = {presets: [require('babel-preset-es2015')]};
const COFFEE_SCRIPT_EXTS = ['.coffee', '.litcoffee'];
const YAML_EXTS = ['.yaml', '.yml'];

const filesCache = Object.create(null);

fs.ensureDirSync(TMP_DIR);

process.on('exit', function () {
    const files = fs.readdirSync(TMP_DIR);
    const maxDate = Date.now() - 1000 * 60 * 60;
    for (var i = 0; i < files.length; i++) {
        const filename = pathUtils.join(TMP_DIR, files[i]);
        const stat = fs.statSync(filename);
        if (stat.atime < maxDate) {
            fs.unlinkSync(filename);
        }
    }
});

exports.compileFile = function (file, filename) {
    const extname = pathUtils.extname(filename);
    switch (extname) {
    case '.coffee':
        return CoffeeScript.compile(file);
    case '.litcoffee':
        return CoffeeScript.compile(file, {literate: true});
    case '.js':
        return babel.transform(file, BABEL_OPTIONS).code;
    case '.yaml':
    case '.yml':
        return yaml.safeLoad(file, 'utf8')
    default:
        return file;
    }
};

exports.getFile = function (filename, opts) {
    const shouldCompile = !opts || opts.compile === undefined || !!opts.compile;

    // get file from memory cache
    var fileCache = filesCache[filename];
    if (fileCache) {
        const stat = fs.statSync(filename);
        if (stat.mtime <= fileCache.mtime) {
            return fileCache.code;
        }
    }

    // get file data
    const file = fs.readFileSync(filename, 'utf-8');
    const hash = crypto.createHash(HASH).update(file).digest('hex');
    const cacheFilename = pathUtils.join(TMP_DIR, hash);

    // get/save into cache
    try {
        var code = fs.readFileSync(cacheFilename, 'utf-8');
    }
    catch (err) {
        if (!shouldCompile) return file;
        var code = file;
        var code = exports.compileFile(file, filename);
        fs.writeFileSync(cacheFilename, code, 'utf-8');
    }

    // update memory cache
    if (!fileCache) {
        fileCache = filesCache[filename] = {mtime: 0, code: ''};
    }
    fileCache.mtime = Date.now();
    fileCache.code = code;

    return code;
};

exports.registerFilenameResolver = function () {
    const Module = module.constructor;
    const filenamesCache = Object.create(null);
    const resolveFilename = Module._resolveFilename
    Module._resolveFilename = function (request, parent, isMain) {
        const cache = filenamesCache[request];
        if (cache) {
            return cache;
        } else {
            const filename = resolveFilename(request, parent, isMain);
            if (request[0] !== '.') {
                filenamesCache[request] = filename;
            }
            return filename;
        }
    };
};

exports.registerCoffeeScript = function () {
    function compile (module, filename) {
        const file = exports.getFile(filename);
        return module._compile(file, filename);
    }

    for (var i = 0; i < COFFEE_SCRIPT_EXTS.length; i++) {
        require.extensions[COFFEE_SCRIPT_EXTS[i]] = compile;
    }
};

exports.registerBabel = function () {
    const _super = require.extensions['.js'];
    require.extensions['.js'] = function (module, filename) {
        if (filename.indexOf('node_modules') >= 0) {
            return _super(module, filename);
        }
        const file = exports.getFile(filename);
        return module._compile(file, filename);
    };
};

exports.registerYaml = function () {
    function compile (module, filename) {
        return exports.getFile(filename);
    }

    for (var i = 0; i < YAML_EXTS.length; i++) {
        require.extensions[YAML_EXTS[i]] = compile;
    }
};

exports.registerTxt = function (extnames) {
    if (!Array.isArray(extnames)) {
        extnames = ['.txt'];
    }

    function compile (module, filename) {
        module.exports = exports.getFile(filename);
    }

    for (var i = 0; i < extnames.length; i++) {
        require.extensions[extnames[i]] = compile;
    }
};

exports.register = function () {
    exports.registerFilenameResolver();
    exports.registerCoffeeScript();
    exports.registerBabel();
    exports.registerYaml();
    exports.registerTxt();
};
