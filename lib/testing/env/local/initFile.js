'use strict'

require('lib/module-cache').register();
require('lib/module-cache').registerTxt(['.pegjs']);
global.Neft = require('index.coffee');
Neft.utils.merge(global, require('lib/testing'));
global.assert = Neft.assert;
require('build/tests');
