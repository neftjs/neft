'use strict';

if (Neft.utils.isNode) {
    require('lib/module-cache').registerCoffeeScript();
}

Neft.utils.merge(global, require('lib/testing'));
global.assert = Neft.assert;

module.exports = function (runApp) {
    global.app = runApp();
    if (app != null) {
        global.environment = global.app.config.environment;
    }
    require('build/tests');
};
