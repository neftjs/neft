'use strict';

const fs = require('fs-extra');
const pathUtils = require('path');
const crypto = require('crypto');
const babel = require('babel-core');
const CoffeeScript = require('coffee-script');
const yaml = require('js-yaml');
const { promisify } = require('util')

const HASH = 'sha256';
const HASH_LENGTH = 64;
const TMP_DIR = pathUtils.join(__dirname, '../../build/tmp/');
const BABEL_OPTIONS = {
    presets: ['es2015', 'es2016', 'es2017'],
    filename: '',
    babelrc: false,
    ast: false
};
const COFFEE_SCRIPT_EXTS = ['.coffee', '.litcoffee'];
const YAML_EXTS = ['.yaml', '.yml'];
const REALPATH = fs.realpathSync('.');
const MTIME_DELAY = 1000;

const filesCache = Object.create(null);

const fsReadFile = promisify(fs.readFile);

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

function createHash(string) {
    return crypto.createHash(HASH).update(string).digest('hex');
}

async function readCacheFile(path) {
    const file = await fsReadFile(path, 'utf-8');
    return {
        hash: file.slice(0, HASH_LENGTH),
        code: file.slice(HASH_LENGTH)
    }
}

function readCacheFileSync(path) {
    const file = fs.readFileSync(path, 'utf-8');
    return {
        hash: file.slice(0, HASH_LENGTH),
        code: file.slice(HASH_LENGTH)
    }
}

async function writeCacheFile(path, hash, code) {
    const file = hash + code;
    await promisify(fs.writeFile)(path, file, 'utf-8');
}

function writeCacheFileSync(path, hash, code) {
    const file = hash + code;
    fs.writeFileSync(path, file, 'utf-8');
}

exports.BABEL_OPTIONS = BABEL_OPTIONS;

exports.compileFile = function (file, filename) {
    const extname = pathUtils.extname(filename);
    switch (extname) {
    case '.coffee':
        return CoffeeScript.compile(file);
    case '.litcoffee':
        return CoffeeScript.compile(file, {literate: true});
    case '.js':
        BABEL_OPTIONS.filename = filename;
        return babel.transform(file, BABEL_OPTIONS).code;
    case '.yaml':
    case '.yml': {
        const object = yaml.safeLoad(file, { filename: filename, json: true });
        return JSON.stringify(object);
    }
    case '.nml': {
        const bundle = require('src/nml-parser').bundle({ nml: file, path: filename }).bundle;
        return CoffeeScript.compile(bundle);
    }
    default:
        return file;
    }
};

exports.fileHash = async function (filename) {
    const code = await exports.getFile(filename);
    return createHash(code)
};

exports.getFile = async function (filename) {
    var path = absolutePath(filename);

    // get file from memory cache
    var fileCache = filesCache[path];
    const fileStat = await promisify(fs.stat)(path);
    if (!fileStat.isFile()) {
        throw new TypeError(`Path ${path} is not a file`);
    }
    if (fileCache) {
        if (fileStat.mtime < fileCache.mtime) {
            return fileCache.code;
        }
    }

    // get file from cache
    let code;
    let hash;
    const pathHash = createHash(path);
    const cacheFilename = pathUtils.join(TMP_DIR, pathHash);
    let cacheStat;
    try {
        cacheStat = await promisify(fs.stat)(cacheFilename);
        if (cacheStat.mtime - MTIME_DELAY >= fileStat.mtime) {
            const cache = await readCacheFile(cacheFilename);
            code = cache.code;
            hash = cache.hash;
        }
    }
    catch (error) {}

    // get file
    if (code === undefined) {
        const file = await promisify(fs.readFile)(path, 'utf-8');

        // use cache when both files are the same
        if (cacheStat) {
            const cache = await readCacheFile(cacheFilename);
            if (cache.hash === createHash(file)) {
                code = cache.code;
            }
        }

        if (code === undefined) {
            code = exports.compileFile(file, filename);
            await writeCacheFile(cacheFilename, createHash(file), code);
        }
    }

    // update memory cache
    if (!fileCache) {
        fileCache = filesCache[path] = {mtime: 0, code: ''};
    }

    // some of systems has 1 second precision for file modification time;
    // to prevent using cache for new files, we use current time back by 1 second;
    // if you're getting file multiple times just after change; it won't be optimized
    fileCache.mtime = Date.now() - MTIME_DELAY;

    fileCache.code = code;

    return code;
};

exports.getFileSync = function (filename) {
    var path = absolutePath(filename);

    // get file from memory cache
    var fileCache = filesCache[path];
    const fileStat = fs.statSync(path);
    if (!fileStat.isFile()) {
        throw new TypeError(`Path ${path} is not a file`);
    }
    if (fileCache) {
        if (fileStat.mtime < fileCache.mtime) {
            return fileCache.code;
        }
    }

    // get file from cache
    let code;
    let hash;
    const pathHash = createHash(path);
    const cacheFilename = pathUtils.join(TMP_DIR, pathHash);
    let cacheStat;
    try {
        cacheStat = fs.statSync(cacheFilename);
        if (cacheStat.mtime - MTIME_DELAY >= fileStat.mtime) {
            const cache = readCacheFileSync(cacheFilename);
            code = cache.code;
            hash = cache.hash;
        }
    }
    catch (error) {}

    // get file
    if (code === undefined) {
        const file = fs.readFileSync(path, 'utf-8');

        // use cache when both files are the same
        if (cacheStat) {
            const cache = readCacheFileSync(cacheFilename);
            if (cache.hash === createHash(file)) {
                code = cache.code;
            }
        }

        if (code === undefined) {
            code = exports.compileFile(file, filename);
            writeCacheFileSync(cacheFilename, createHash(file), code);
        }
    }

    // update memory cache
    if (!fileCache) {
        fileCache = filesCache[path] = {mtime: 0, code: ''};
    }

    // some of systems has 1 second precision for file modification time;
    // to prevent using cache for new files, we use current time back by 1 second;
    // if you're getting file multiple times just after change; it won't be optimized
    fileCache.mtime = Date.now() - MTIME_DELAY;

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

    exports.registerFilenameResolver = () => {};
};

exports.registerCoffeeScript = function () {
    function compile (module, filename) {
        const file = exports.getFileSync(filename);
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
        const file = exports.getFileSync(filename);
        return module._compile(file, filename);
    };

    exports.registerBabel = () => {};
};

exports.registerYaml = function () {
    function compile (module, filename) {
        const file = exports.getFileSync(filename);
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
            module.exports = exports.getFileSync(filename);
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
        const file = exports.getFileSync(filename);
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
