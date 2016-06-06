#!/usr/bin/env node --harmony

process.env.NODE_PATH = './:'+__dirname+'/..:'+__dirname+'/../node_modules';
require('module').Module._initPaths();
require('coffee-script/register');
require('babel-register')({
    presets: ['es2015'],
    ignore: /(bundle|build)\/(neft|app)-[a-z]+-[a-z]+\.js|node_modules/
});
const fs = require('fs');
global.Neft = require('../cli/bundle/neft-node-develop.js');
global.app = require(fs.realpathSync('./build/app-node-develop.js'));
app.onReady(function() {
    Neft.unit = require('../src/unit');
    require('../src/unit/cli');
});
