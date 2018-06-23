'use strict';

process.env.NEFT_PLATFORM = 'node';
process.env.NEFT_NODE = '1';
process.env.NEFT_SERVER = '1';

const semver = require('semver');
const pathUtils = require('path');
const fs = require('fs');

// warning for legacy node version
const currentVersion = process.version;
const expectedVersion = require('../package.json').engines.node;
if (!semver.satisfies(currentVersion, expectedVersion)) {
    console.error('\n! IMPORTANT !')
    console.error('Your node version ' + currentVersion +
        ' is lower than expected ' + expectedVersion);
    console.error('! IMPORTANT !\n')
}

const isFirstRun = !fs.existsSync(pathUtils.join(__dirname, '../build'))
const moduleCache = require('lib/module-cache');
moduleCache.registerFilenameResolver();
moduleCache.registerCoffeeScript();
moduleCache.registerYaml();
moduleCache.registerTxt(['.txt', '.pegjs']);

if (isFirstRun) {
    const log = require('src/log')
    log.warn('Loading Neft for the first time may take a while')
    log.log('')
}

require('./init.coffee');

module.exports = Neft
