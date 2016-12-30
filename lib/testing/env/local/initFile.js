'use strict'

global.Neft = require('cli/bundle/neft-node-develop');
require('lib/module-cache').register();
require('lib/module-cache').registerTxt(['.pegjs']);
Neft.utils.merge(global, require('lib/testing'));
global.assert = Neft.assert;
require('build/tests');
