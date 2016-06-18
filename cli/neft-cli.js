'use strict';

const moduleCache = require('lib/moduleCache');
moduleCache.registerFilenameResolver();
moduleCache.registerCoffeeScript();
require('./init.coffee');

module.exports = Neft
