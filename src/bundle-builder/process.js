const moduleCache = require('lib/moduleCache');
moduleCache.registerFilenameResolver();
moduleCache.registerCoffeeScript();
require('./process.coffee');
