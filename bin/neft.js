#!/usr/bin/env node --harmony

const PATHS = ['./build', './', __dirname+'/..', __dirname+'/../node_modules'];
const isWin = process.platform === 'win32';
process.env.NODE_PATH = PATHS.join(isWin ? ';' : ':');
require('module')._initPaths();
require('../cli/neft-cli.js');
