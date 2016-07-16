#!/usr/bin/env node --harmony

const PATHS = ['./build', './', __dirname+'/..', __dirname+'/../node_modules'];
const isWin = process.platform === 'win32';
process.env.NODE_PATH = PATHS.join(isWin ? ';' : ':');
require('module')._initPaths();
require('coffee-script/register');
require('babel-register')({
    presets: ['es2015'],
    ignore: /(bundle|build)\/(neft|app)-[a-z]+-[a-z]+\.js|node_modules/
});
const fs = require('fs');
global.Neft = require('../cli/bundle/neft-node-develop.js');
global.app = require(fs.realpathSync('./build/app-node-develop.js'));
app.onReady(function() {
    Neft.unit = require('../lib/unit');
    require('../lib/unit/cli');
});
