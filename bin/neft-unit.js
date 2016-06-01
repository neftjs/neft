#!/usr/bin/env node

"use strict";
require('coffee-script/register');
const fs = require('fs');
global.Neft = require('../cli/bundle/neft-node-develop.js');
global.app = require(fs.realpathSync('./build/app-node-develop.js'));
app.onReady(function() {
    Neft.unit = require('../src/unit');
    require('../src/unit/cli');
});
