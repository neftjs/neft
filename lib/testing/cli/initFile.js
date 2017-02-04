'use strict';

if (Neft.utils.isNode) {
    require('lib/module-cache').registerCoffeeScript();
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

    global.app = initFunc ? initFunc(runApp) : runApp();

    if (app != null) {
        global.environment = global.app.config.environment;
    }

    require('build/tests');
    return global.app;
};
