'use strict';

if (process.env.NEFT_NODE) {
    require('lib/module-cache').registerCoffeeScript();
    require('lib/module-cache').registerNml();
    require('lib/module-cache').registerTxt(['.pegjs']);
}

Neft.utils.merge(global, require('lib/testing'));
global.assert = Neft.assert;

module.exports = function (runApp) {
    let initFunc;
    try {
        initFunc = require('init.js');
    } catch (error) {
        if (!Neft.utils.has(error.message, 'Cannot find module')) {
            throw error;
        }
    }

    var localApp = initFunc ? initFunc(runApp) : runApp();

    if (localApp != null) {
        global.environment = localApp.config.environment;
    }

    // make app be accessible as a global variable before running tests
    if (typeof app !== 'undefined') {
        app = localApp;
    }

    require('build/tests');

    return localApp;
};
