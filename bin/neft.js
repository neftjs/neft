#!/usr/bin/env node --harmony

process.env.NODE_PATH = './:'+__dirname+'/..:'+__dirname+'/../node_modules';
require('module').Module._initPaths();
require('../cli/neft-cli.js');
