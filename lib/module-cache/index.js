'use strict';

const fs = require('fs-extra');
const pathUtils = require('path');
const crypto = require('crypto');
const babel = require('babel-core');
const CoffeeScript = require('coffee-script');
const yaml = require('js-yaml');

const HASH = 'sha';
const TMP_DIR = pathUtils.join(fs.realpathSync('./'), './build/tmp/');
const BABEL_OPTIONS = {
    presets: ['es2015'],
    filename: '',
    babelrc: false,
    ast: false
};
const COFFEE_SCRIPT_EXTS = ['.coffee', '.litcoffee'];
const YAML_EXTS = ['.yaml', '.yml'];
const REALPATH = fs.realpathSync('.');

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

function absolutePath(path) {
    if (pathUtils.isAbsolute(path)) {
        return path;
    }
    return pathUtils.join(REALPATH, path);
}

exports.compileFile = function (file, filename) {
    var path = absolutePath(filename);
    const extname = pathUtils.extname(path);
    switch (extname) {
    case '.coffee':
        return CoffeeScript.compile(file);
    case '.litcoffee':
        return CoffeeScript.compile(file, {literate: true});
    case '.js':
        BABEL_OPTIONS.filename = path;
        return babel.transform(file, BABEL_OPTIONS).code;
    case '.yaml':
    case '.yml': {
        const object = yaml.safeLoad(file, { filename: path, json: true });
        return JSON.stringify(object);
    }
    case '.nml': {
        const bundle = require('src/nml-parser').bundle({ nml: file, path: path }).bundle;
        return CoffeeScript.compile(bundle);
    }
    default:
        return file;
    }
};

exports.fileHash = function (filename) {
    var path = absolutePath(filename);
    exports.getFile(path);
    return filesCache[path].hash;
};

exports.getFile = function (filename) {
    var path = absolutePath(filename);

    // get file from memory cache
    var fileCache = filesCache[path];
    const stat = fs.statSync(path);
    if (fileCache) {
        if (stat.mtime < fileCache.mtime) {
            return fileCache.code;
        }
    }

    // get file data
    const file = fs.readFileSync(path, 'utf-8');
    const hash = crypto.createHash(HASH).update(file).digest('hex');
    const cacheFilename = pathUtils.join(TMP_DIR, hash);

    // get/save into cache
    try {
        var code = fs.readFileSync(cacheFilename, 'utf-8');
    }
    catch (err) {
        var code = file;
        var code = exports.compileFile(file, path);
        fs.writeFileSync(cacheFilename, code, 'utf-8');
    }

    // update memory cache
    if (!fileCache) {
        fileCache = filesCache[path] = {mtime: 0, code: '', hash: ''};
    }

    // some of systems has 1 second precision for file modification time;
    // to prevent using cache for new files, we use current time back by 1 second;
    // if you're getting file multiple times just after change; it won't be optimized
    fileCache.mtime = Date.now() - 1000;

    fileCache.code = code;
    fileCache.hash = hash;

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

    exports.registerFilenameResolver = () => {};
};

exports.registerCoffeeScript = function () {
    function compile (module, filename) {
        const file = exports.getFile(filename);
        return module._compile(file, filename);
    }

    for (var i = 0; i < COFFEE_SCRIPT_EXTS.length; i++) {
        require.extensions[COFFEE_SCRIPT_EXTS[i]] = compile;
    }

    exports.registerCoffeeScript = () => {};
};

exports.registerBabel = function () {
    const _super = require.extensions['.js'];
    require.extensions['.js'] = function (module, filename) {
        if (filename.indexOf('node_modules') >= 0
            && (
                filename.indexOf('node_modules/neft') < 0
                || filename.indexOf('node_modules/neft/node_modules') >= 0
            )) {
            return _super(module, filename);
        }
        const file = exports.getFile(filename);
        return module._compile(file, filename);
    };

    exports.registerBabel = () => {};
};

exports.registerYaml = function () {
    function compile (module, filename) {
        const file = exports.getFile(filename);
        module.exports = JSON.parse(file);
    }

    for (var i = 0; i < YAML_EXTS.length; i++) {
        require.extensions[YAML_EXTS[i]] = compile;
    }

    exports.registerYaml = () => {};
};

exports.registerTxt = (function () {
    const registeredExtensions = Object.create(null);

    return function (extnames) {
        if (!Array.isArray(extnames)) {
            extnames = ['.txt'];
        }

        function compile (module, filename) {
            module.exports = exports.getFile(filename);
        }

        for (var i = 0; i < extnames.length; i++) {
            const extname = extnames[i];
            if (registeredExtensions[extname]) {
                continue;
            }
            registeredExtensions[extname] = true;
            require.extensions[extname] = compile;
        }
    };
}());

exports.registerNml = function () {
    require.extensions['.nml'] = function (module, filename) {
        const file = exports.getFile(filename);
        return module._compile(file, filename);
    };

    exports.registerNml = () => {};
};

exports.register = function () {
    exports.registerFilenameResolver();
    exports.registerCoffeeScript();
    exports.registerBabel();
    exports.registerYaml();
    exports.registerTxt();
    exports.registerNml();
};
