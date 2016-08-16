'use strict';

const moduleCache = require('lib/module-cache');
moduleCache.registerFilenameResolver();
moduleCache.registerCoffeeScript();
moduleCache.registerYaml();
moduleCache.registerTxt(['.txt', '.pegjs']);
require('./init.coffee');

module.exports = Neft
