'use strict';

process.env.NEFT_PLATFORM = 'node';
process.env.NEFT_NODE = '1';
process.env.NEFT_SERVER = '1';

const semver = require('semver');

// warning for legacy node version
const currentVersion = process.version;
const expectedVersion = require('../package.json').engines.node;
if (!semver.satisfies(currentVersion, expectedVersion)) {
    console.error("Node version '#{currentVersion}' " +
        "is lower than expected '#{expectedVersion}'");
}

const moduleCache = require('lib/module-cache');
moduleCache.registerFilenameResolver();
moduleCache.registerCoffeeScript();
moduleCache.registerYaml();
moduleCache.registerTxt(['.txt', '.pegjs']);
const log = require('src/log')
const utils = require('src/utils')

utils.overrideProperty(moduleCache, 'compileFile', (_super) => (file, filename) => {
    log.show(`Compile file '${filename}'`)
    return _super.call(this, file, filename)
})

require('./init.coffee');

module.exports = Neft
