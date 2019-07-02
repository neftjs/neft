// modules are defined as an array
// [ module function, map of requires ]
//
// map of requires is short require name -> numeric require
//
// anything defined in a previous bundle is accessed via the
// orig method which is the require for previous bundles
parcelRequire = (function (modules, cache, entry, globalName) {
  // Save the require from previous bundle to this closure if any
  var previousRequire = typeof parcelRequire === 'function' && parcelRequire;
  var nodeRequire = typeof require === 'function' && require;

  function newRequire(name, jumped) {
    if (!cache[name]) {
      if (!modules[name]) {
        // if we cannot find the module within our internal map or
        // cache jump to the current global require ie. the last bundle
        // that was added to the page.
        var currentRequire = typeof parcelRequire === 'function' && parcelRequire;
        if (!jumped && currentRequire) {
          return currentRequire(name, true);
        }

        // If there are other bundles on this page the require from the
        // previous one is saved to 'previousRequire'. Repeat this as
        // many times as there are bundles until the module is found or
        // we exhaust the require chain.
        if (previousRequire) {
          return previousRequire(name, true);
        }

        // Try the node require function if it exists.
        if (nodeRequire && typeof name === 'string') {
          return nodeRequire(name);
        }

        var err = new Error('Cannot find module \'' + name + '\'');
        err.code = 'MODULE_NOT_FOUND';
        throw err;
      }

      localRequire.resolve = resolve;
      localRequire.cache = {};

      var module = cache[name] = new newRequire.Module(name);

      modules[name][0].call(module.exports, localRequire, module, module.exports, this);
    }

    return cache[name].exports;

    function localRequire(x){
      return newRequire(localRequire.resolve(x));
    }

    function resolve(x){
      return modules[name][1][x] || x;
    }
  }

  function Module(moduleName) {
    this.id = moduleName;
    this.bundle = newRequire;
    this.exports = {};
  }

  newRequire.isParcelRequire = true;
  newRequire.Module = Module;
  newRequire.modules = modules;
  newRequire.cache = cache;
  newRequire.parent = previousRequire;
  newRequire.register = function (id, exports) {
    modules[id] = [function (require, module) {
      module.exports = exports;
    }, {}];
  };

  var error;
  for (var i = 0; i < entry.length; i++) {
    try {
      newRequire(entry[i]);
    } catch (e) {
      // Save first error but execute all entries
      if (!error) {
        error = e;
      }
    }
  }

  if (entry.length) {
    // Expose entry point to Node, AMD or browser globals
    // Based on https://github.com/ForbesLindesay/umd/blob/master/template.js
    var mainExports = newRequire(entry[entry.length - 1]);

    // CommonJS
    if (typeof exports === "object" && typeof module !== "undefined") {
      module.exports = mainExports;

    // RequireJS
    } else if (typeof define === "function" && define.amd) {
     define(function () {
       return mainExports;
     });

    // <script>
    } else if (globalName) {
      this[globalName] = mainExports;
    }
  }

  // Override the current require with this new one
  parcelRequire = newRequire;

  if (error) {
    // throw error from earlier, _after updating parcelRequire_
    throw error;
  }

  return newRequire;
})({"8ITs":[function(require,module,exports) {

},{}],"vZcY":[function(require,module,exports) {
(function () {
  'use strict';

  var canUseBrowser, loadCustomMarker, noMarker;

  noMarker = function noMarker(msg) {
    return msg;
  };

  exports.bold = noMarker;
  exports.italic = noMarker;
  exports.strikethrough = noMarker;
  exports.underline = noMarker;
  exports.code = noMarker;
  exports.red = noMarker;
  exports.green = noMarker;
  exports.yellow = noMarker;
  exports.blue = noMarker;
  exports.white = noMarker;
  exports.cyan = noMarker;
  exports.gray = noMarker;
  exports.hex = noMarker;
  canUseBrowser = typeof navigator !== "undefined" && navigator !== null;
  canUseBrowser && (canUseBrowser = /chrome|safari|firefox/i.test(navigator.userAgent));
  canUseBrowser && (canUseBrowser = !/edge/i.test(navigator.userAgent));

  loadCustomMarker = function loadCustomMarker(marker) {
    var func, key;

    for (key in marker) {
      func = marker[key];

      if (!exports[key]) {
        throw new Error("Unrecognized marker function '" + key + "'");
      }

      exports[key] = func;
    }
  };

  if (undefined) {
    if (canUseBrowser) {
      loadCustomMarker(require('./browser'));
    }
  }

  if (undefined) {
    loadCustomMarker(require('./node'));
  }
}).call(this);
},{}],"XNjX":[function(require,module,exports) {
(function () {
  'use strict';

  var RULES, delimeterRegexp, marker;
  marker = require('./marker');

  delimeterRegexp = function delimeterRegexp(start, end, prefix, suffix) {
    if (end == null) {
      end = start;
    }

    if (prefix == null) {
      prefix = '';
    }

    if (suffix == null) {
      suffix = '';
    }

    return new RegExp("(" + prefix + ")" + start + "(.+?)" + end + "(" + suffix + ")", 'g');
  };

  RULES = [{
    regexp: delimeterRegexp('__', '__', ' |^', ' |$'),
    replacer: marker.bold
  }, {
    regexp: delimeterRegexp('\\*\\*'),
    replacer: marker.bold
  }, {
    regexp: delimeterRegexp('_', '_', ' |^', ' |$'),
    replacer: marker.italic
  }, {
    regexp: delimeterRegexp('\\*'),
    replacer: marker.italic
  }, {
    regexp: delimeterRegexp('~~'),
    replacer: marker.strikethrough
  }, {
    regexp: delimeterRegexp('<u>', '<\\/u>'),
    replacer: marker.underline
  }, {
    regexp: delimeterRegexp('`'),
    replacer: marker.code
  }];

  exports.parse = function (msg, context) {
    var i, len, rule;
    msg = String(msg);

    for (i = 0, len = RULES.length; i < len; i++) {
      rule = RULES[i];
      msg = msg.replace(rule.regexp, function (_, prefix, str, suffix) {
        return prefix + rule.replacer(str, context) + suffix;
      });
    }

    return msg;
  };

  exports.clear = function (msg) {
    var i, len, rule;

    for (i = 0, len = RULES.length; i < len; i++) {
      rule = RULES[i];
      msg = msg.replace(rule.regexp, '$1$2$3');
    }

    return msg;
  };
}).call(this);
},{"./marker":"vZcY"}],"1krr":[function(require,module,exports) {
(function () {
  var loadCustomPrinter;
  exports.allowsNoLine = false;

  exports.createContext = function () {
    return null;
  };

  exports.stdout = function (msg) {
    return console.log(msg);
  };

  loadCustomPrinter = function loadCustomPrinter(printer) {
    var func, key;

    for (key in printer) {
      func = printer[key];

      if (!(key in exports)) {
        throw new Error("Unrecognized printer function '" + key + "'");
      }

      exports[key] = func;
    }
  };

  if (undefined) {
    loadCustomPrinter(require('./browser'));
  }

  if (undefined) {
    loadCustomPrinter(require('./node'));
  }
}).call(this);
},{}],"R1c3":[function(require,module,exports) {
(function () {
  'use strict';

  var DEFAULT_DELAY;
  DEFAULT_DELAY = 100;

  exports.createLogger = function (logger, opts) {
    var delay, printTasks, printlnTasks, repeatLogger, timer, updateTasks, updating;
    repeatLogger = Object.create(logger);
    delay = (opts != null ? opts.delay : void 0) || DEFAULT_DELAY;
    printTasks = [];
    printlnTasks = [];
    timer = void 0;
    updating = false;

    updateTasks = function updateTasks() {
      var i, j, len, len1, task;
      updating = true;

      for (i = 0, len = printTasks.length; i < len; i++) {
        task = printTasks[i];
        logger.print(task);
      }

      for (j = 0, len1 = printlnTasks.length; j < len1; j++) {
        task = printlnTasks[j];
        logger.println(task);
      }

      updating = false;
    };

    repeatLogger.print = function (msgBuilder) {
      printTasks.push(msgBuilder);
      logger.print(msgBuilder);
      return this;
    };

    repeatLogger.println = function (msgBuilder) {
      printlnTasks.push(msgBuilder);
      logger.println(msgBuilder);
      return this;
    };

    repeatLogger.stop = function () {
      logger.stop();
      clearInterval(timer);
      timer = void 0;
    };

    timer = setInterval(updateTasks, delay);
    return repeatLogger;
  };
}).call(this);
},{}],"XAYT":[function(require,module,exports) {
(function () {
  'use strict';

  var marker;
  marker = require('./marker');

  exports.createLogger = function (logger) {
    var getMsgWithTime, time, timerLogger;
    timerLogger = Object.create(logger);
    time = Date.now();

    getMsgWithTime = function getMsgWithTime(msgBuilder) {
      return function (ctx) {
        var change, unit;
        change = Date.now() - time;
        unit = 'ms';

        if (change > 1000) {
          change = (change / 1000).toFixed(1);
          unit = 's';

          if (change > 60) {
            change = (change / 60).toFixed(2);
            unit = 'm';
          }
        }

        return msgBuilder(ctx) + ' ' + marker.cyan("+" + change + unit, ctx);
      };
    };

    timerLogger.print = function (msgBuilder) {
      logger.print(getMsgWithTime(msgBuilder));
      return this;
    };

    timerLogger.println = function (msgBuilder) {
      logger.println(getMsgWithTime(msgBuilder));
      return this;
    };

    return timerLogger;
  };
}).call(this);
},{"./marker":"vZcY"}],"xG2I":[function(require,module,exports) {
(function () {
  'use strict';

  var marker;
  marker = require('./marker');

  exports.createLogger = function (logger, prefix) {
    var getMsgWithPrefix, prefixLogger, time;
    prefixLogger = Object.create(logger);
    time = Date.now();

    getMsgWithPrefix = function getMsgWithPrefix(msgBuilder) {
      return function (ctx) {
        return marker.gray("[" + prefix + "]  ", ctx) + msgBuilder(ctx);
      };
    };

    prefixLogger.print = function (msgBuilder) {
      logger.print(getMsgWithPrefix(msgBuilder));
      return this;
    };

    prefixLogger.println = function (msgBuilder) {
      logger.println(getMsgWithPrefix(msgBuilder));
      return this;
    };

    return prefixLogger;
  };
}).call(this);
},{"./marker":"vZcY"}],"r7L2":[function(require,module,exports) {

// shim for using process in browser
var process = module.exports = {}; // cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
  throw new Error('setTimeout has not been defined');
}

function defaultClearTimeout() {
  throw new Error('clearTimeout has not been defined');
}

(function () {
  try {
    if (typeof setTimeout === 'function') {
      cachedSetTimeout = setTimeout;
    } else {
      cachedSetTimeout = defaultSetTimout;
    }
  } catch (e) {
    cachedSetTimeout = defaultSetTimout;
  }

  try {
    if (typeof clearTimeout === 'function') {
      cachedClearTimeout = clearTimeout;
    } else {
      cachedClearTimeout = defaultClearTimeout;
    }
  } catch (e) {
    cachedClearTimeout = defaultClearTimeout;
  }
})();

function runTimeout(fun) {
  if (cachedSetTimeout === setTimeout) {
    //normal enviroments in sane situations
    return setTimeout(fun, 0);
  } // if setTimeout wasn't available but was latter defined


  if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
    cachedSetTimeout = setTimeout;
    return setTimeout(fun, 0);
  }

  try {
    // when when somebody has screwed with setTimeout but no I.E. maddness
    return cachedSetTimeout(fun, 0);
  } catch (e) {
    try {
      // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
      return cachedSetTimeout.call(null, fun, 0);
    } catch (e) {
      // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
      return cachedSetTimeout.call(this, fun, 0);
    }
  }
}

function runClearTimeout(marker) {
  if (cachedClearTimeout === clearTimeout) {
    //normal enviroments in sane situations
    return clearTimeout(marker);
  } // if clearTimeout wasn't available but was latter defined


  if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
    cachedClearTimeout = clearTimeout;
    return clearTimeout(marker);
  }

  try {
    // when when somebody has screwed with setTimeout but no I.E. maddness
    return cachedClearTimeout(marker);
  } catch (e) {
    try {
      // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
      return cachedClearTimeout.call(null, marker);
    } catch (e) {
      // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
      // Some versions of I.E. have different rules for clearTimeout vs setTimeout
      return cachedClearTimeout.call(this, marker);
    }
  }
}

var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
  if (!draining || !currentQueue) {
    return;
  }

  draining = false;

  if (currentQueue.length) {
    queue = currentQueue.concat(queue);
  } else {
    queueIndex = -1;
  }

  if (queue.length) {
    drainQueue();
  }
}

function drainQueue() {
  if (draining) {
    return;
  }

  var timeout = runTimeout(cleanUpNextTick);
  draining = true;
  var len = queue.length;

  while (len) {
    currentQueue = queue;
    queue = [];

    while (++queueIndex < len) {
      if (currentQueue) {
        currentQueue[queueIndex].run();
      }
    }

    queueIndex = -1;
    len = queue.length;
  }

  currentQueue = null;
  draining = false;
  runClearTimeout(timeout);
}

process.nextTick = function (fun) {
  var args = new Array(arguments.length - 1);

  if (arguments.length > 1) {
    for (var i = 1; i < arguments.length; i++) {
      args[i - 1] = arguments[i];
    }
  }

  queue.push(new Item(fun, args));

  if (queue.length === 1 && !draining) {
    runTimeout(drainQueue);
  }
}; // v8 likes predictible objects


function Item(fun, array) {
  this.fun = fun;
  this.array = array;
}

Item.prototype.run = function () {
  this.fun.apply(null, this.array);
};

process.title = 'browser';
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues

process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) {
  return [];
};

process.binding = function (name) {
  throw new Error('process.binding is not supported');
};

process.cwd = function () {
  return '/';
};

process.chdir = function (dir) {
  throw new Error('process.chdir is not supported');
};

process.umask = function () {
  return 0;
};
},{}],"fe8o":[function(require,module,exports) {
var process = require("process");
(function () {
  'use strict';

  var DEFAULT_SCOPE, LOADING_FRAMES, LOADING_MSG, Logger, getStringColor, getStringHash, lineLogger, marker, parser, prefixLogger, printer, repeatLogger, timerLogger;
  parser = require('./parser');
  marker = require('./marker');
  printer = require('./printer');

  if (undefined) {
    lineLogger = require('./line-logger');
  }

  repeatLogger = require('./repeat-logger');
  timerLogger = require('./timer-logger');
  prefixLogger = require('./prefix-logger');
  DEFAULT_SCOPE = 'debug';
  LOADING_MSG = 'Loading...';
  LOADING_FRAMES = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'];

  getStringHash = function getStringHash(str) {
    var hash, i;
    hash = 5381;
    i = str.length;

    while (i) {
      hash = hash * 33 ^ str.charCodeAt(--i);
    }

    return hash >>> 0;
  };

  getStringColor = function getStringColor(str) {
    var hash, hex, validHex;
    hash = getStringHash(str);
    hex = hash.toString(16);
    validHex = ("000000" + hex).slice(-6);
    return "#" + validHex;
  };

  Logger = function () {
    function Logger(scopeName) {
      this.scopeName = scopeName != null ? scopeName : DEFAULT_SCOPE;
      this.scopeColor = getStringColor(this.scopeName);
      this._loadingFrame = 0;
    }

    Logger.prototype.stop = function () {};

    Logger.prototype.print = function (msgBuilder) {
      var ctx;
      ctx = printer.createContext();
      printer.stdout(msgBuilder(ctx), ctx);
      return this;
    };

    Logger.prototype.println = function (msgBuilder) {
      var ctx, msg;
      ctx = printer.createContext();
      msg = msgBuilder(ctx);

      if (printer.allowsNoLine) {
        msg += '\n';
      }

      printer.stdout(msg, ctx);
      return this;
    };

    Logger.prototype.line = function () {
      if (undefined) {
        return this;
      } else {
        return (lineLogger != null ? lineLogger.createLogger(this) : void 0) || this;
      }
    };

    Logger.prototype.repeat = function (opts) {
      if (undefined) {
        return this;
      } else {
        return repeatLogger.createLogger(this, opts);
      }
    };

    Logger.prototype.timer = function () {
      return timerLogger.createLogger(this);
    };

    Logger.prototype.prefix = function (prefix) {
      return prefixLogger.createLogger(this, prefix);
    };

    Logger.prototype.scope = function (name) {
      var childScope;
      childScope = this.scopeName === DEFAULT_SCOPE ? '' : this.scopeName + ":";
      childScope += name;
      return new Logger(childScope);
    };

    Logger.prototype.log = function (msg) {
      return this.println(function (ctx) {
        return parser.parse(msg, ctx);
      });
    };

    Logger.prototype.debug = function (msg) {
      return this.println(function (_this) {
        return function (ctx) {
          return marker.hex(_this.scopeName, _this.scopeColor, ctx) + '  ' + parser.parse(msg, ctx);
        };
      }(this));
    };

    Logger.prototype.info = function (msg) {
      return this.println(function (ctx) {
        return marker.blue(marker.bold('INFO', ctx), ctx) + '  ' + parser.parse(msg, ctx);
      });
    };

    Logger.prototype.ok = function (msg) {
      return this.println(function (ctx) {
        return marker.green(marker.bold('OK', ctx), ctx) + '  ' + parser.parse(msg, ctx);
      });
    };

    Logger.prototype.warn = function (msg) {
      return this.println(function (ctx) {
        return marker.yellow(marker.bold('WARN', ctx), ctx) + '  ' + parser.parse(msg, ctx);
      });
    };

    Logger.prototype.warning = function (msg) {
      return this.warn(msg);
    };

    Logger.prototype.error = function (msg, error) {
      this.println(function (ctx) {
        return marker.red(marker.bold('ERROR', ctx), ctx) + '  ' + parser.parse(msg, ctx);
      });

      if (error != null) {
        return this.println(function (ctx) {
          if (undefined) {
            return String(error.stack);
          } else {
            return error.toString();
          }
        });
      }
    };

    Logger.prototype.progress = function (title, value, max) {
      var label, left, right, width;

      if (typeof title === 'number') {
        max = value;
        value = title;
        title = '';
      }

      width = process.stdout.columns / 3 - parser.clear(title).length;

      if (max === void 0) {
        value = Math.floor(value * 100);
        max = 100;
        label = value + "%";
      } else {
        label = value + "/" + max;
      }

      left = '█'.repeat(Math.min(width, Math.floor(value / max * width)));
      right = '░'.repeat(Math.max(0, width - left.length));
      return this.println(function (ctx) {
        var titleMsg;
        titleMsg = title ? parser.parse(title, ctx) + "  " : '';
        return "" + titleMsg + left + marker.gray(right, ctx) + " " + label;
      });
    };

    Logger.prototype.loading = function (msg, frames) {
      if (msg == null) {
        msg = LOADING_MSG;
      }

      if (frames == null) {
        frames = LOADING_FRAMES;
      }

      return this.println(function (_this) {
        return function (ctx) {
          var frame;
          frame = frames[_this._loadingFrame++ % frames.length];
          return marker.cyan(frame, ctx) + ' ' + parser.parse(msg, ctx);
        };
      }(this));
    };

    return Logger;
  }();

  module.exports = new Logger();
}).call(this);
},{"./parser":"XNjX","./marker":"vZcY","./printer":"1krr","./repeat-logger":"R1c3","./timer-logger":"XAYT","./prefix-logger":"xG2I","process":"r7L2"}],"XbcT":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var log = require('../log');

var disconnectFromListeners = function disconnectFromListeners(listeners, listener, ctx) {
  if (!listeners) return;
  var index = 0;

  while (index < listeners.length) {
    index = listeners.indexOf(listener, index);
    if (index === -1) return;

    if (listeners[index + 1] === ctx) {
      listeners[index] = null;
      listeners[index + 1] = null;
      return;
    }

    index += 2;
  }
};

var clearListenersGaps = function clearListenersGaps(listeners) {
  var i = 0;
  var n = listeners.length;
  var shift = 0;

  while (i < n) {
    var func = listeners[i];

    if (func === null) {
      shift += 2;
    } else if (shift > 0) {
      listeners[i - shift] = func;
      listeners[i - shift + 1] = listeners[i + 1];
      listeners[i] = null;
      listeners[i + 1] = null;
    }

    i += 2;
  }
};

var callListeners = function callListeners(object, listeners, arg1, arg2) {
  if (!listeners) return;
  var i = 0;
  var n = listeners.length;
  var containsGaps = false;

  while (i < n) {
    var func = listeners[i];

    if (func === null) {
      containsGaps = true;
    } else {
      var ctx = listeners[i + 1];

      try {
        func.call(ctx || object, arg1, arg2);
      } catch (error) {
        log.error('Uncaught error thrown in signal listener', error);
      }
    }

    i += 2;
  }

  if (containsGaps) {
    clearListenersGaps(listeners);
  }
};

var Signal =
/*#__PURE__*/
function () {
  function Signal() {
    _classCallCheck(this, Signal);

    this.listeners = null;
    Object.seal(this);
  }

  _createClass(Signal, [{
    key: "connect",
    value: function connect(listener) {
      var ctx = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
      var listeners = this.listeners;
      if (!listeners) return;
      var n = listeners.length;
      var i = n - 2;

      while (i >= 0) {
        if (listeners[i] !== null) {
          break;
        }

        i -= 2;
      }

      if (i + 2 === n) {
        listeners.push(listener, ctx);
      } else {
        listeners[i + 2] = listener;
        listeners[i + 3] = ctx;
      }
    }
  }, {
    key: "connectOnce",
    value: function connectOnce(listener) {
      var ctx = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
      var listeners = this.listeners;
      if (!listeners) return;

      var wrapper = function wrapper(arg1, arg2) {
        disconnectFromListeners(listeners, wrapper, ctx);
        listener.call(this, arg1, arg2);
      };

      this.connect(wrapper, ctx);
    }
  }, {
    key: "disconnect",
    value: function disconnect(listener) {
      var ctx = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
      disconnectFromListeners(this.listeners, listener, ctx);
    }
  }, {
    key: "disconnectAll",
    value: function disconnectAll() {
      var listeners = this.listeners;
      if (!listeners) return;

      for (var i = 0, n = listeners.length; i < n; i += 1) {
        listeners[i] = null;
      }
    }
  }, {
    key: "isEmpty",
    value: function isEmpty() {
      var listeners = this.listeners;
      if (!listeners) return true;

      for (var i = 0, n = listeners.length; i < n; i += 2) {
        if (listeners[i] !== null) return false;
      }

      return true;
    }
  }]);

  return Signal;
}();

exports.Signal = Signal;
exports.callListeners = callListeners;
},{"../log":"fe8o"}],"Beob":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var _require = require('./signal'),
    Signal = _require.Signal,
    callListeners = _require.callListeners;

var InternalSignalDispatcher =
/*#__PURE__*/
function (_Signal) {
  _inherits(InternalSignalDispatcher, _Signal);

  function InternalSignalDispatcher(listeners) {
    var _this;

    _classCallCheck(this, InternalSignalDispatcher);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(InternalSignalDispatcher).call(this));
    _this.listeners = listeners;
    Object.freeze(_assertThisInitialized(_this));
    return _this;
  }

  _createClass(InternalSignalDispatcher, [{
    key: "emit",
    value: function emit(arg1, arg2) {
      callListeners(null, this.listeners, arg1, arg2);
    }
  }]);

  return InternalSignalDispatcher;
}(Signal);

var SignalDispatcher =
/*#__PURE__*/
function (_InternalSignalDispat) {
  _inherits(SignalDispatcher, _InternalSignalDispat);

  function SignalDispatcher() {
    _classCallCheck(this, SignalDispatcher);

    return _possibleConstructorReturn(this, _getPrototypeOf(SignalDispatcher).call(this, []));
  }

  return SignalDispatcher;
}(InternalSignalDispatcher);

exports.SignalDispatcher = SignalDispatcher;
exports.InternalSignalDispatcher = InternalSignalDispatcher;
},{"./signal":"XbcT"}],"WmdM":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  module.exports = function (utils) {
    var OptionsArray, get, isStringArray;

    get = utils.get = function (obj, path, target) {
      var elem, i, j, k, key, len, len1;

      if (path == null) {
        path = '';
      }

      switch (_typeof(path)) {
        case 'object':
          path = exports.clone(path);
          break;

        case 'string':
          path = path.split('.');
          break;

        default:
          throw new TypeError();
      }

      for (i = j = 0, len = path.length; j < len; i = ++j) {
        key = path[i];

        if (!key.length && i) {
          throw new ReferenceError('utils.get(): empty properties ' + 'are not supported');
        }

        if (isStringArray(key)) {
          key = key.substring(0, key.indexOf('[]'));
          path = path.splice(i);
          path[0] = path[0].substring(key.length + 2);

          if (!path[0].length) {
            path.shift();
          }

          if (target == null) {
            target = new OptionsArray();
          }

          if (key.length) {
            obj = obj[key];
          }

          if (typeof obj === 'undefined') {
            return void 0;
          }

          for (k = 0, len1 = obj.length; k < len1; k++) {
            elem = obj[k];
            get(elem, path.join('.'), target);
          }

          if (!target.length) {
            return void 0;
          }

          return target;
        }

        if (key.length) {
          obj = obj[key];
        }

        if (_typeof(obj) !== 'object' && typeof obj !== 'function') {
          if (i !== path.length - 1) {
            obj = void 0;
          }

          break;
        }
      }

      if (target && typeof obj !== 'undefined') {
        target.push(obj);
      }

      return obj;
    };

    get.OptionsArray = OptionsArray = function (superClass) {
      extend(OptionsArray, superClass);

      function OptionsArray() {
        OptionsArray.__super__.constructor.call(this);
      }

      return OptionsArray;
    }(Array);

    return isStringArray = utils.isStringArray = function (arg) {
      null; //<development>;

      if (typeof arg !== 'string') {
        throw new Error('utils.isStringArray value must be a string');
      } //</development>;


      return /\[\]$/.test(arg);
    };
  };
}).call(this);
},{}],"UEAv":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var hasOwnProp, isArray;
  isArray = Array.isArray;
  hasOwnProp = Object.hasOwnProperty;

  module.exports = function (utils) {
    utils.simplify = function () {
      var nativeCtors, nativeProtos;
      nativeProtos = [Array.prototype, Object.prototype];
      nativeCtors = [Array, Object];
      return function (obj, opts) {
        var ctors, _cyclic, i, ids, j, len1, objs, optsCtors, optsInsts, optsProps, optsProtos, parse, protos, references, value;

        if (opts == null) {
          opts = {};
        }

        null; //<development>;

        if (!utils.isObject(obj)) {
          throw new Error('utils.simplify object must be an object');
        }

        if (!utils.isPlainObject(opts)) {
          throw new Error('utils.simplify options must be a plain object');
        } //</development>;


        optsProps = opts.properties != null ? opts.properties : opts.properties = false;
        optsProtos = opts.protos != null ? opts.protos : opts.protos = false;
        optsCtors = opts.constructors != null ? opts.constructors : opts.constructors = false;
        optsInsts = opts.instances = !optsProtos && optsCtors;
        objs = [];
        ids = [];
        references = {};

        if (optsCtors) {
          ctors = {};
        }

        if (optsProtos) {
          protos = {};
        }

        _cyclic = function cyclic(obj) {
          var i, key, len, objIds, proto, value;
          len = objs.push(obj);
          ids.push(objIds = []);

          for (key in obj) {
            value = obj[key];

            if (!hasOwnProp.call(obj, key)) {
              continue;
            }

            if (!(value && _typeof(value) === 'object')) {
              continue;
            }

            if (optsProps && exports.lookupGetter(obj, key)) {
              objIds.push(null);
              continue;
            }

            if (!~(i = objs.indexOf(value))) {
              i = _cyclic(value);
            }

            objIds.push(i);
          }

          if (optsProtos && (proto = getPrototypeOf(obj))) {
            if (~nativeProtos.indexOf(proto)) {
              i = null;
            } else if (!~(i = objs.indexOf(proto))) {
              i = _cyclic(proto);
            }

            objIds.push(i);
          }

          return len - 1;
        };

        parse = function parse(obj, index) {
          var ctor, desc, isReference, key, objId, objIds, objReferences, obji, protoObjId, r, value;
          r = isArray(obj) ? [] : {};
          objIds = ids[index];
          obji = 0;
          objReferences = null;

          for (key in obj) {
            value = obj[key];

            if (!hasOwnProp.call(obj, key)) {
              continue;
            }

            r[key] = value;
            isReference = false;

            if (value && _typeof(value) === 'object') {
              if (objReferences == null) {
                objReferences = [];
              }

              objId = value = objIds[obji++];

              if (value !== null) {
                isReference = true;
                objReferences.push(key);
              }
            }

            if (optsProps) {
              desc = getObjOwnPropDesc(obj, key);

              if (isReference) {
                desc.value = value;
              }

              value = desc;
            }

            r[key] = value;
          }

          if (optsProtos && getPrototypeOf(obj)) {
            protoObjId = objIds[obji++];

            if (protoObjId !== null) {
              protos[index] = protoObjId;
            }
          }

          if (optsCtors && (ctor = obj.constructor)) {
            if (optsInsts || hasOwnProp.call(obj, 'constructor')) {
              if (!~nativeCtors.indexOf(ctor)) {
                ctors[index] = ctor;
              }
            }
          }

          if (objReferences) {
            references[index] = objReferences;
          }

          return r;
        };

        _cyclic(obj);

        for (i = j = 0, len1 = objs.length; j < len1; i = ++j) {
          value = objs[i];
          objs[i] = parse(value, i);
        }

        return {
          opts: opts,
          objects: objs,
          references: references,
          protos: protos,
          constructors: ctors
        };
      };
    }();

    return utils.assemble = function () {
      var ctorPropConfig;
      ctorPropConfig = {
        value: null
      };
      return function (obj) {
        null; //<development>;

        var constructors, func, j, k, key, l, len1, len2, len3, len4, m, objI, object, objects, opts, optsCtors, optsInsts, optsProps, optsProtos, protos, ref, refI, refId, references, refs, refsIds, value;

        if (!utils.isPlainObject(obj)) {
          throw new Error('utils.assemble object must be a plain object');
        } //</development>;


        opts = obj.opts, objects = obj.objects, references = obj.references, protos = obj.protos, constructors = obj.constructors;
        optsProps = opts.properties;
        optsProtos = opts.protos;
        optsCtors = opts.constructors;
        optsInsts = opts.instances;
        refsIds = [];

        if (optsProps) {
          for (objI in references) {
            refs = references[objI];
            obj = objects[objI];

            for (j = 0, len1 = refs.length; j < len1; j++) {
              ref = refs[j];
              refsIds.push(obj[ref].value);
              obj[ref].value = objects[obj[ref].value];
            }
          }
        } else {
          for (objI in references) {
            refs = references[objI];
            obj = objects[objI];

            for (k = 0, len2 = refs.length; k < len2; k++) {
              ref = refs[k];
              refsIds.push(obj[ref]);
              obj[ref] = objects[obj[ref]];
            }
          }
        }

        if (optsProps) {
          for (l = 0, len3 = objects.length; l < len3; l++) {
            obj = objects[l];

            for (key in obj) {
              value = obj[key];

              if (hasOwnProp.call(obj, key)) {
                defObjProp(obj, key, value);
              }
            }
          }
        }

        for (objI in protos) {
          refI = protos[objI];
          objects[objI] = utils.setPrototypeOf(objects[objI], objects[refI]);
        }

        if (optsInsts) {
          for (objI in constructors) {
            func = constructors[objI];
            object = objects[objI] = utils.setPrototypeOf(objects[objI], func.prototype);

            if (typeof func.fromAssembled === "function") {
              func.fromAssembled(object);
            }
          }
        } else if (optsCtors) {
          for (objI in constructors) {
            func = constructors[objI];
            ctorPropConfig.value = func;
            defObjProp(objects[objI], 'constructor', ctorPropConfig);
          }
        }

        refId = 0;

        for (objI in references) {
          refs = references[objI];
          obj = objects[objI];

          for (m = 0, len4 = refs.length; m < len4; m++) {
            ref = refs[m];
            obj[ref] = objects[refsIds[refId++]];
          }
        }

        return objects[0];
      };
    }();
  };
}).call(this);
},{}],"u0uD":[function(require,module,exports) {
(function () {
  'use strict';

  var NOP,
      Stack,
      assert,
      exports,
      forEach,
      isArray,
      shift,
      utils,
      slice = [].slice;
  utils = null;
  assert = console.assert.bind(console);
  exports = module.exports;
  shift = Array.prototype.shift;
  isArray = Array.isArray;

  NOP = function NOP() {};

  forEach = function () {
    var forArray, forObject;

    forArray = function forArray(arr, callback, onEnd, thisArg) {
      var i, n, _next;

      i = 0;
      n = arr.length;

      _next = function next() {
        if (i === n) {
          return onEnd.call(thisArg);
        }

        i++;
        return callback.call(thisArg, arr[i - 1], i - 1, arr, _next);
      };

      return _next();
    };

    forObject = function forObject(obj, callback, onEnd, thisArg) {
      var i, keys, n, _next2;

      keys = Object.keys(obj);
      i = 0;
      n = keys.length;

      _next2 = function next() {
        var key;

        if (i === n) {
          return onEnd.call(thisArg);
        }

        key = keys[i];
        callback.call(thisArg, key, obj[key], obj, _next2);
        return i++;
      };

      return _next2();
    };

    return function (list, callback, onEnd, thisArg) {
      var method;
      assert(!utils.isPrimitive(list));
      assert(typeof callback === 'function');

      if (onEnd != null) {
        assert(typeof onEnd === 'function');
      }

      method = isArray(list) ? forArray : forObject;
      method(list, callback, onEnd, thisArg);
      return null;
    };
  }();

  Stack = function () {
    function Stack() {
      this._arr = [];
      this.length = 0;
      this.pending = false;
      Object.preventExtensions(this);
    }

    Stack.prototype.add = function (func, context, args) {
      if (args != null) {
        assert(utils.isObject(args));
      }

      this._arr.push(func, context, args);

      this.length++;
      return this;
    };

    Stack.prototype.callNext = function (args, callback) {
      var arg, callbackWrapper, called, context, func, funcArgs, funcLength, i, j, len, syncError;

      if (typeof args === 'function' && callback == null) {
        callback = args;
        args = null;
      }

      assert(typeof callback === 'function');

      if (!this._arr.length) {
        return callback();
      }

      this.length--;
      func = this._arr.shift();
      context = this._arr.shift();
      funcArgs = this._arr.shift();

      if (typeof func === 'string') {
        func = utils.get(context, func);
      }

      if (typeof func !== 'function') {
        throw new TypeError('ASync Stack::callNext(): ' + 'function to call is not a function');
      }

      funcLength = func.length || Math.max((args != null ? args.length : void 0) || 0, (funcArgs != null ? funcArgs.length : void 0) || 0) + 1;
      syncError = null;
      called = false;

      callbackWrapper = function callbackWrapper() {
        assert(!called || !syncError, "Callback can't be called if function throws an error;\n" + ("Function: `" + func + "`\nSynchronous error: `" + ((syncError != null ? syncError.stack : void 0) || syncError) + "`"));
        assert(!called, "Callback can't be called twice;\nFunction: `" + func + "`");
        called = true;
        return callback.apply(this, arguments);
      };

      funcArgs = Object.create(funcArgs || null);
      funcArgs[funcLength - 1] = callbackWrapper;

      if (funcArgs.length === void 0 || funcArgs.length < funcLength) {
        funcArgs.length = funcLength;
      }

      if (args) {
        for (i = j = 0, len = args.length; j < len; i = ++j) {
          arg = args[i];

          if (i !== funcLength - 1 && funcArgs[i] === void 0) {
            funcArgs[i] = arg;
          }
        }
      }

      syncError = utils.catchError(func, context, funcArgs);

      if (syncError) {
        callbackWrapper(syncError);
      }

      return null;
    };

    Stack.prototype.runAll = function (callback, ctx) {
      var callNext, onNextCalled;

      if (callback == null) {
        callback = NOP;
      }

      if (ctx == null) {
        ctx = null;
      }

      assert(this.pending === false);

      if (typeof callback !== 'function') {
        throw new TypeError('ASync runAll(): ' + 'passed callback is not a function');
      }

      if (!this._arr.length) {
        return callback.call(ctx, null);
      }

      onNextCalled = function (_this) {
        return function () {
          var args, err;
          err = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];

          if (err != null) {
            _this.pending = false;
            return callback.call(ctx, err);
          }

          if (_this._arr.length) {
            return callNext(args);
          }

          _this.pending = false;
          return callback.apply(ctx, arguments);
        };
      }(this);

      callNext = function (_this) {
        return function (args) {
          return _this.callNext(args, onNextCalled);
        };
      }(this);

      this.pending = true;
      callNext();
      return null;
    };

    Stack.prototype.runAllSimultaneously = function (callback, ctx) {
      var done, length, n, onDone;

      if (callback == null) {
        callback = NOP;
      }

      if (ctx == null) {
        ctx = null;
      }

      assert(this.pending === false);
      assert(typeof callback === 'function');
      length = n = this._arr.length / 3;
      done = 0;

      if (!length) {
        return callback.call(ctx);
      }

      onDone = function (_this) {
        return function (err) {
          ++done;

          if (done > length) {
            return;
          }

          if (err) {
            done = length;
            _this.pending = false;
            return callback.call(ctx, err);
          }

          if (done === length) {
            _this.pending = false;
            return callback.call(ctx);
          }
        };
      }(this);

      this.pending = true;

      while (n--) {
        this.callNext(onDone);
      }

      return null;
    };

    return Stack;
  }();
  /*
  Exports
   */


  module.exports = function () {
    utils = arguments[0];
    return utils.async = {
      forEach: forEach,
      Stack: Stack
    };
  };
}).call(this);
},{}],"xr+4":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var clone, cloneDeep, createObject, defObjProp, funcToString, getObjOwnPropDesc, getOwnPropertyNames, getPrototypeOf, has, hasOwnProp, isArray, isEqual, isObject, isPrimitive, log, merge, mergeDeep, objKeys, pop, random, ref, setPrototypeOf, shift, toString;
  toString = Object.prototype.toString;
  funcToString = Function.prototype.toString;
  isArray = Array.isArray;
  ref = Array.prototype, shift = ref.shift, pop = ref.pop;
  createObject = Object.create;
  getPrototypeOf = Object.getPrototypeOf, getOwnPropertyNames = Object.getOwnPropertyNames;
  objKeys = Object.keys;
  hasOwnProp = Object.hasOwnProperty;
  getObjOwnPropDesc = Object.getOwnPropertyDescriptor;
  defObjProp = Object.defineProperty;
  random = Math.random;
  log = require('../log');
  /*
  Link subfiles
   */

  require('./namespace')(exports);

  require('./stringifying')(exports);

  require('./async')(exports);

  ['isNode', 'isServer', 'isClient', 'isBrowser', 'isWebGL', 'isAndroid', 'isIOS', 'isMacOS'].forEach(function (prop) {
    return Object.defineProperty(exports, prop, {
      get: function get() {
        throw new Error("utils." + prop + " is replaced by process.env.NEFT_PLATFORM");
      }
    });
  });
  Object.defineProperty(exports, 'isNative', {
    get: function get() {
      throw new Error("utils.isNative is replaced by process.env.NEFT_NATIVE");
    }
  });

  exports.NOP = function () {};

  exports.is = Object.is || function (val1, val2) {
    if (val1 === 0 && val2 === 0) {
      return 1 / val1 === 1 / val2;
    } else if (val1 !== val1) {
      return val2 !== val2;
    } else {
      return val1 === val2;
    }
  };

  exports.isFloat = function (val) {
    return typeof val === 'number' && isFinite(val);
  };

  exports.isInteger = function (val) {
    return typeof val === 'number' && isFinite(val) && val > -9007199254740992 && val < 9007199254740992 && Math.floor(val) === val;
  };

  isPrimitive = exports.isPrimitive = function (val) {
    return val === null || typeof val === 'string' || typeof val === 'number' || typeof val === 'boolean' || typeof val === 'undefined';
  };

  isObject = exports.isObject = function (param) {
    return param !== null && _typeof(param) === 'object';
  };

  exports.isPlainObject = function (param) {
    var proto;

    if (!isObject(param)) {
      return false;
    }

    proto = getPrototypeOf(param);

    if (!proto) {
      return true;
    }

    if (proto === Object.prototype && !getPrototypeOf(proto)) {
      return true;
    }

    return false;
  };

  exports.isArguments = function (param) {
    return toString.call(param) === '[object Arguments]';
  };

  merge = exports.merge = function (source, obj) {
    null; //<development>;

    var key, value;

    if (isPrimitive(source)) {
      throw new Error('utils.merge source cannot be primitive');
    }

    if (isPrimitive(obj)) {
      throw new Error('utils.merge object cannot be primitive');
    }

    if (source === obj) {
      throw new Error('utils.merge source and object are the same');
    }

    if (arguments.length > 2) {
      throw new Error('utils.merge expects only two arguments; ' + 'use utils.mergeAll instead');
    } //</development>;


    for (key in obj) {
      value = obj[key];

      if (hasOwnProp.call(obj, key)) {
        source[key] = value;
      }
    }

    return source;
  };

  exports.mergeAll = function (source) {
    null; //<development>;

    var i, j, obj, ref1;

    if (isPrimitive(source)) {
      throw new Error('utils.mergeAll source cannot be primitive');
    } //</development>;


    for (i = j = 1, ref1 = arguments.length; j < ref1; i = j += 1) {
      if ((obj = arguments[i]) != null) {
        //<development>;
        if (isPrimitive(obj)) {
          throw new Error('utils.mergeAll object cannot be primitive');
        }

        if (source === obj) {
          throw new Error('utils.mergeAll source and object are the same');
        } //</development>;


        merge(source, obj);
      }
    }

    return source;
  };

  mergeDeep = exports.mergeDeep = function (source, obj) {
    null; //<development>;

    var key, sourceValue, value;

    if (isPrimitive(source)) {
      throw new Error('utils.mergeDeep source cannot be primitive');
    }

    if (isPrimitive(obj)) {
      throw new Error('utils.mergeDeep object cannot be primitive');
    }

    if (source === obj) {
      throw new Error('utils.mergeDeep source and object are the same');
    } //</development>;


    if (isArray(source) && isArray(obj)) {
      Array.prototype.push.apply(source, obj);
    } else {
      for (key in obj) {
        value = obj[key];

        if (!hasOwnProp.call(obj, key)) {
          continue;
        }

        sourceValue = source[key];

        if (isObject(value) && isObject(sourceValue)) {
          mergeDeep(sourceValue, value);
          continue;
        }

        source[key] = value;
      }
    }

    return source;
  };

  exports.mergeDeepAll = function (source) {
    null; //<development>;

    var i, j, obj, ref1;

    if (isPrimitive(source)) {
      throw new Error('utils.mergeDeepAll source cannot be primitive');
    } //</development>;


    for (i = j = 1, ref1 = arguments.length; j < ref1; i = j += 1) {
      if ((obj = arguments[i]) != null) {
        //<development>;
        if (isPrimitive(obj)) {
          throw new Error('utils.mergeDeepAll object cannot be primitive');
        }

        if (source === obj) {
          throw new Error('utils.mergeDeepAll source and object are the same');
        } //</development>;


        mergeDeep(source, obj);
      }
    }

    return source;
  };

  exports.fill = function (source, obj) {
    null; //<development>;

    var key, value;

    if (isPrimitive(source)) {
      throw new Error('utils.fill source cannot be primitive');
    }

    if (isPrimitive(obj)) {
      throw new Error('utils.fill object cannot be primitive');
    }

    if (source === obj) {
      throw new Error('utils.fill source and object are the same');
    } //</development>;


    for (key in obj) {
      value = obj[key];

      if (hasOwnProp.call(obj, key)) {
        if (key in source && !hasOwnProp.call(source, key)) {
          source[key] = value;
        }
      }
    }

    return source;
  };

  exports.remove = function (obj, elem) {
    null; //<development>;

    var index;

    if (isPrimitive(obj)) {
      throw new Error('utils.remove object cannot be primitive');
    } //</development>;


    if (isArray(obj)) {
      index = obj.indexOf(elem);

      if (index !== -1) {
        if (index === 0) {
          obj.shift();
        } else if (index === obj.length - 1) {
          obj.pop();
        } else {
          obj.splice(index, 1);
        }
      }
    } else {
      delete obj[elem];
    }
  };

  exports.removeFromUnorderedArray = function (arr, elem) {
    null; //<development>;

    var index;

    if (!Array.isArray(arr)) {
      throw new Error('utils.removeFromUnorderedArray array must be an Array');
    } //</development>;


    index = arr.indexOf(elem);

    if (index !== -1) {
      arr[index] = arr[arr.length - 1];
      arr.pop();
    }
  };

  exports.getPropertyDescriptor = function (obj, prop) {
    null; //<development>;

    var desc;

    if (isPrimitive(obj)) {
      throw new Error('utils.getPropertyDescriptor object cannot be primitive');
    }

    if (typeof prop !== 'string') {
      throw new Error('utils.getPropertyDescriptor property must be a string');
    } //</development>;


    while (obj && !desc) {
      desc = getObjOwnPropDesc(obj, prop);
      obj = getPrototypeOf(obj);
    }

    return desc;
  };

  exports.lookupGetter = function () {
    var lookupGetter;

    if (Object.prototype.__lookupGetter__) {
      lookupGetter = Object.prototype.lookupGetter;

      (function (obj, prop) {
        var getter;
        getter = lookupGetter.call(obj, prop);
        return (getter != null ? getter.trueGetter : void 0) || getter;
      });
    }

    return function (obj, prop) {
      var desc, ref1;

      if (desc = exports.getPropertyDescriptor(obj, prop)) {
        return ((ref1 = desc.get) != null ? ref1.trueGetter : void 0) || desc.get;
      }
    };
  }();

  exports.lookupSetter = function () {
    if (Object.prototype.__lookupSetter__) {
      return Function.call.bind(Object.prototype.__lookupSetter__);
    }

    return function (obj, prop) {
      var desc;
      desc = exports.getPropertyDescriptor(obj, prop);
      return desc != null ? desc.set : void 0;
    };
  }();

  defObjProp(exports, 'WRITABLE', {
    value: 1 << 0
  });
  defObjProp(exports, 'ENUMERABLE', {
    value: 1 << 1
  });
  defObjProp(exports, 'CONFIGURABLE', {
    value: 1 << 2
  });

  exports.defineProperty = function () {
    var CONFIGURABLE, ENUMERABLE, WRITABLE, accessorsCfg, descCfg, isSafari, valueCfg;
    WRITABLE = exports.WRITABLE, ENUMERABLE = exports.ENUMERABLE, CONFIGURABLE = exports.CONFIGURABLE;
    descCfg = {
      enumerable: true,
      configurable: true
    };
    valueCfg = exports.merge({
      writable: true,
      value: null
    }, descCfg);
    accessorsCfg = exports.merge({
      get: void 0,
      set: void 0
    }, descCfg);
    isSafari = typeof navigator !== "undefined" && navigator !== null ? /^((?!chrome).)*safari/i.test(navigator.userAgent) : false;
    return function (obj, prop, desc, getter, setter) {
      null; //<development>;

      var _getter, cfg;

      if (isPrimitive(obj)) {
        throw new Error('utils.defineProperty object cannot be primitive');
      }

      if (typeof prop !== 'string') {
        throw new Error('utils.defineProperty property must be a string');
      }

      if (desc != null && (!exports.isInteger(desc) || desc < 0)) {
        throw new Error('utils.defineProperty descriptors bitmask ' + 'must be a positive integer');
      } //</development>;


      if (setter === void 0) {
        cfg = valueCfg;
        valueCfg.value = getter;
        valueCfg.writable = desc & WRITABLE;
      } else {
        if (isSafari && getter) {
          _getter = getter;

          getter = function getter() {
            if (this !== obj && this.hasOwnProperty(prop)) {
              return this[prop];
            } else {
              return _getter.call(this);
            }
          };
        }

        cfg = accessorsCfg;
        accessorsCfg.get = typeof getter === 'function' ? getter : void 0;
        accessorsCfg.set = typeof setter === 'function' ? setter : void 0;
      }

      cfg.enumerable = desc & ENUMERABLE;
      cfg.configurable = desc & CONFIGURABLE;
      defObjProp(obj, prop, cfg);
      return obj;
    };
  }();

  exports.overrideProperty = function (obj, prop, getter, setter) {
    var desc, opts, ref1;

    if (!(desc = exports.getPropertyDescriptor(obj, prop))) {
      throw new Error('utils.overrideProperty object ' + 'must has the given property');
    }

    if (!desc.configurable) {
      throw new Error('utils.overrideProperty the given property ' + 'is not configurable');
    }

    opts = exports.CONFIGURABLE;

    if (desc.writable) {
      opts |= exports.WRITABLE;
    }

    if (desc.enumerable) {
      opts |= exports.ENUMERABLE;
    }

    if (getter !== void 0 && setter !== void 0) {
      if (desc.get != null) {
        if (typeof getter === 'function') {
          getter = getter(desc.get);
        } else {
          getter = desc.get;
        }
      }

      if (desc.set != null) {
        if (typeof setter === 'function') {
          setter = setter(desc.set);
        } else {
          setter = desc.set;
        }
      }
    } else if (_typeof(getter) === (ref1 = _typeof(desc.value)) && ref1 === 'function') {
      getter = getter(desc.value);
    }

    return exports.defineProperty(obj, prop, opts, getter, setter);
  };

  clone = exports.clone = function (param) {
    var j, key, len, proto, ref1, result;

    if (isArray(param)) {
      return param.slice();
    }

    if (isObject(param)) {
      proto = getPrototypeOf(param);

      if (proto === Object.prototype) {
        result = {};
      } else {
        result = createObject(proto);
      }

      ref1 = objKeys(param);

      for (j = 0, len = ref1.length; j < len; j++) {
        key = ref1[j];
        result[key] = param[key];
      }

      return result;
    }

    return param;
  };

  cloneDeep = exports.cloneDeep = function (param) {
    var j, key, len, ref1, result;
    result = clone(param);

    if (isObject(result)) {
      ref1 = objKeys(result);

      for (j = 0, len = ref1.length; j < len; j++) {
        key = ref1[j];
        result[key] = cloneDeep(result[key]);
      }
    }

    return result;
  };

  exports.isEmpty = function (object) {
    var key;

    if (typeof object === 'string') {
      return object === '';
    } //<development>;


    if (isPrimitive(object)) {
      throw new Error('utils.isEmpty object must be a string or ' + 'not primitive');
    } //</development>;


    if (isArray(object)) {
      return !object.length;
    } else {
      for (key in object) {
        return false;
      }

      return true;
    }
  };

  exports.last = function (arg) {
    null; //<development>;

    if (isPrimitive(arg)) {
      throw new Error('utils.last array cannot be primitive');
    } //</development>;


    return arg[arg.length - 1];
  };

  exports.clear = function (obj) {
    null; //<development>;

    var _, j, k, key, len, ref1, ref2;

    if (isPrimitive(obj)) {
      throw new Error('utils.clear object cannot be primitive');
    } //</development>;


    if (isArray(obj)) {
      for (_ = j = 0, ref1 = obj.length; j < ref1; _ = j += 1) {
        obj.pop();
      }
    } else {
      ref2 = objKeys(obj);

      for (k = 0, len = ref2.length; k < len; k++) {
        key = ref2[k];
        delete obj[key];
      }
    }

    return obj;
  };

  setPrototypeOf = exports.setPrototypeOf = function () {
    var tmp;

    if (typeof Object.setPrototypeOf === 'function') {
      return Object.setPrototypeOf;
    }

    tmp = {};
    tmp.__proto__ = {
      a: 1
    };

    if (tmp.a === 1) {
      return function (obj, proto) {
        null; //<development>;

        if (isPrimitive(obj)) {
          throw new Error('utils.setPrototypeOf object ' + 'cannot be primitive');
        }

        if (proto != null && isPrimitive(proto)) {
          throw new Error('utils.setPrototypeOf prototype ' + 'cannot be primitive');
        } //</development>;


        obj.__proto__ = proto;
        return obj;
      };
    }

    return function (obj, proto) {
      null; //<development>;

      var newObj;

      if (isPrimitive(obj)) {
        throw new Error('utils.setPrototypeOf object ' + 'cannot be primitive');
      }

      if (proto != null && isPrimitive(proto)) {
        throw new Error('utils.setPrototypeOf prototype ' + 'cannot be primitive');
      } //</development>;


      if (_typeof(obj) === 'object') {
        newObj = createObject(proto);
        merge(newObj, obj);
      } else {
        merge(obj, proto);
      }

      return newObj;
    };
  }();

  has = exports.has = function (obj, val) {
    var key, value;

    if (typeof obj === 'string') {
      return !!~obj.indexOf(val);
    } else {
      //<development>;
      if (isPrimitive(obj)) {
        throw new Error('utils.has object must be a string or not primitive');
      } //</development>;


      if (isArray(obj)) {
        return !!~Array.prototype.indexOf.call(obj, val);
      } else {
        for (key in obj) {
          value = obj[key];

          if (hasOwnProp.call(obj, key)) {
            if (value === val) {
              return true;
            }
          }
        }

        return false;
      }
    }
  };

  exports.objectToArray = function (obj, valueGen, target) {
    var i, j, key, keys, len, value;
    keys = objKeys(obj);

    if (target == null) {
      target = keys;
    } //<development>;


    if (!isObject(obj)) {
      throw new Error('utils.objectToArray object must be an object');
    }

    if (valueGen != null && typeof valueGen !== 'function') {
      throw new Error('utils.objectToArray valueGen must be a function');
    }

    if (!isArray(target)) {
      throw new Error('utils.objectToArray target must be an array');
    } //</development>;


    for (i = j = 0, len = keys.length; j < len; i = ++j) {
      key = keys[i];
      value = valueGen ? valueGen(key, obj[key], obj) : obj[key];
      target[i] = value;
    }

    return target;
  };

  exports.arrayToObject = function (arr, keyGen, valueGen, target) {
    var elem, i, j, key, len, value;

    if (target == null) {
      target = {};
    }

    null; //<development>;

    if (!isArray(arr)) {
      throw new Error('utils.arrayToObject array must be an array');
    }

    if (keyGen != null && typeof keyGen !== 'function') {
      throw new Error('utils.arrayToObject keyGen must be a function');
    }

    if (valueGen != null && typeof valueGen !== 'function') {
      throw new Error('utils.arrayToObject valueGen must be a function');
    }

    if (!isObject(target)) {
      throw new Error('utils.arrayToObject target must be an object');
    } //</development>;


    for (i = j = 0, len = arr.length; j < len; i = ++j) {
      elem = arr[i];
      key = keyGen ? keyGen(i, elem, arr) : i;
      value = valueGen ? valueGen(i, elem, arr) : elem;

      if (key != null) {
        target[key] = value;
      }
    }

    return target;
  };

  exports.capitalize = function (str) {
    null; //<development>;

    if (typeof str !== 'string') {
      throw new Error('utils.capitalize string must be a string');
    } //</development>;


    if (!str.length) {
      return '';
    }

    return str[0].toUpperCase() + str.slice(1);
  };

  exports.addSlashes = function () {
    var NEW_SUB_STR, SLASHES_RE;
    SLASHES_RE = /'|"/g;
    NEW_SUB_STR = '\\$\&';
    return function (str) {
      null; //<development>;

      if (typeof str !== 'string') {
        throw new Error('utils.addSlashes string must be a string');
      } //</development>;


      if (!str.length) {
        return str;
      }

      return str.replace(SLASHES_RE, NEW_SUB_STR);
    };
  }();

  exports.uid = function (n) {
    var str;

    if (n == null) {
      n = 8;
    }

    null; //<development>;

    if (typeof n !== 'number' || n <= 0 || !isFinite(n)) {
      throw new Error('utils.uid length must be a positive finite number');
    } //</development>;


    str = '';

    while (true) {
      str += random().toString(16).slice(2);

      if (str.length >= n) {
        break;
      }
    }

    if (str.length !== n) {
      str = str.slice(0, n);
    }

    return str;
  };

  exports.tryFunction = function (func, context, args, onFail) {
    null; //<development>;

    var err;

    if (typeof func !== 'function') {
      throw new Error('utils.tryFunction function must be a function');
    }

    if (args != null && !isObject(args)) {
      throw new Error('utils.tryFunction arguments must be an object');
    } //</development>;


    try {
      return func.apply(context, args);
    } catch (error1) {
      err = error1;

      if (typeof onFail === 'function') {
        return onFail(err);
      } else if (onFail === void 0) {
        return err;
      } else {
        return onFail;
      }
    }
  };

  exports.catchError = function (func, context, args) {
    null; //<development>;

    var err;

    if (typeof func !== 'function') {
      throw new Error('utils.catchError function must be a function');
    }

    if (args != null && !isObject(args)) {
      throw new Error('utils.catchError arguments must be an object');
    } //</development>;


    try {
      func.apply(context, args);
    } catch (error1) {
      err = error1;
      return err;
    }
  };

  exports.bindFunctionContext = function (func, ctx) {
    null; //<development>;

    if (typeof func !== 'function') {
      throw new Error('utils.bindFunctionContext function must be a function');
    } //</development>;


    switch (func.length) {
      case 0:
        return function () {
          return func.call(ctx);
        };

      case 1:
        return function (a1) {
          return func.call(ctx, a1);
        };

      case 2:
        return function (a1, a2) {
          return func.call(ctx, a1, a2);
        };

      case 3:
        return function (a1, a2, a3) {
          return func.call(ctx, a1, a2, a3);
        };

      case 4:
        return function (a1, a2, a3, a4) {
          return func.call(ctx, a1, a2, a3, a4);
        };

      case 5:
        return function (a1, a2, a3, a4, a5) {
          return func.call(ctx, a1, a2, a3, a4, a5);
        };

      case 6:
        return function (a1, a2, a3, a4, a5, a6) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6);
        };

      case 7:
        return function (a1, a2, a3, a4, a5, a6, a7) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6, a7);
        };

      default:
        return function () {
          return func.apply(ctx, arguments);
        };
    }
  };

  exports.errorToObject = function (error) {
    null; //<development>;

    var result;

    if (!isObject(error)) {
      throw new Error('utils.errorToObject error must be an object');
    } //</development>;


    result = {
      name: error.name,
      message: error.message
    };
    exports.merge(result, error);
    return result;
  };

  exports.getOwnProperties = function (obj) {
    null; //<development>;

    var result;

    if (!isObject(obj)) {
      throw new Error('utils.getOwnProperties object must be an object');
    } //</development>;


    result = isArray(obj) ? [] : {};
    merge(result, obj);
    return result;
  };

  exports.deprecate = function (func, msg) {
    var deprecated, warned;
    warned = false;

    deprecated = function deprecated() {
      if (!warned) {
        log.warn(msg);
        warned = true;
      }

      return func.apply(this, arguments);
    };

    return deprecated;
  };

  isEqual = exports.isEqual = function () {
    var defaultComparison, forArrays, forObjects;

    defaultComparison = function defaultComparison(a, b) {
      return a === b;
    };

    forArrays = function forArrays(a, b, compareFunc, maxDeep) {
      var aValue, bValue, index, j, len;

      if (getPrototypeOf(a) !== getPrototypeOf(b)) {
        return false;
      }

      if (a.length !== b.length) {
        return false;
      }

      if (maxDeep <= 0) {
        return true;
      }

      for (index = j = 0, len = a.length; j < len; index = ++j) {
        aValue = a[index];
        bValue = b[index];

        if (bValue && _typeof(bValue) === 'object') {
          if (!isEqual(aValue, bValue, compareFunc, maxDeep - 1)) {
            return false;
          }

          continue;
        }

        if (!compareFunc(aValue, bValue)) {
          return false;
        }
      }

      return true;
    };

    forObjects = function forObjects(a, b, compareFunc, maxDeep) {
      var key, value;

      if (getPrototypeOf(a) !== getPrototypeOf(b)) {
        return false;
      }

      for (key in a) {
        value = a[key];

        if (a.hasOwnProperty(key)) {
          if (!b.hasOwnProperty(key)) {
            return false;
          }
        }
      }

      for (key in b) {
        value = b[key];

        if (b.hasOwnProperty(key)) {
          if (!a.hasOwnProperty(key)) {
            return false;
          }
        }
      }

      if (maxDeep <= 0) {
        return true;
      }

      for (key in a) {
        value = a[key];

        if (!a.hasOwnProperty(key)) {
          continue;
        }

        if (value && _typeof(value) === 'object') {
          if (!isEqual(value, b[key], compareFunc, maxDeep - 1)) {
            return false;
          }

          continue;
        }

        if (!compareFunc(value, b[key])) {
          return false;
        }
      }

      return true;
    };

    return function (a, b, compareFunc, maxDeep) {
      if (compareFunc == null) {
        compareFunc = defaultComparison;
      }

      if (maxDeep == null) {
        maxDeep = 2e308;
      }

      if (typeof compareFunc === 'number') {
        maxDeep = compareFunc;
        compareFunc = defaultComparison;
      } //<development>;


      if (typeof compareFunc !== 'function') {
        throw new Error('utils.isEqual compareFunction must be a function');
      }

      if (typeof maxDeep !== 'number') {
        throw new Error('utils.isEqual maxDeep must be a number');
      } //</development>;


      if (maxDeep < 0) {
        return compareFunc(a, b);
      }

      if (isArray(a) && isArray(b)) {
        return forArrays(a, b, compareFunc, maxDeep);
      } else if (isObject(a) && isObject(b)) {
        return forObjects(a, b, compareFunc, maxDeep);
      } else {
        return compareFunc(a, b);
      }
    };
  }();

  exports.snakeToCamel = function () {
    var regex, replacer;
    regex = /(_\w)/g;

    replacer = function replacer(matches) {
      return matches[1].toUpperCase();
    };

    return function (value) {
      //<development>;
      if (typeof value !== 'string') {
        throw new Error('utils.snakeToCamel value must be a string');
      } //</development>;


      return value.replace(regex, replacer);
    };
  }();

  exports.kebabToCamel = function () {
    var regex, replacer;
    regex = /(\-\w)/g;

    replacer = function replacer(matches) {
      return matches[1].toUpperCase();
    };

    return function (value) {
      //<development>;
      if (typeof value !== 'string') {
        throw new Error('utils.kebabToCamel value must be a string');
      } //</development>;


      return value.replace(regex, replacer);
    };
  }();

  exports.camelToKebab = function () {
    var regex;
    regex = /([a-z])([A-Z])/g;
    return function (value) {
      //<development>;
      if (typeof value !== 'string') {
        throw new Error('utils.camelToKebab value must be a string');
      } //</development>;


      return value.replace(regex, '$1-$2').toLowerCase();
    };
  }();

  Object.freeze(exports);
}).call(this);
},{"../log":"fe8o","./namespace":"WmdM","./stringifying":"UEAv","./async":"u0uD"}],"juRu":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var util = require('../util');

var _require = require('./signal'),
    Signal = _require.Signal,
    callListeners = _require.callListeners;

var _require2 = require('./dispatcher'),
    InternalSignalDispatcher = _require2.InternalSignalDispatcher;

function SignalsEmitter() {
  util.defineProperty(this, '_signals', null, {});
}

util.defineProperty(SignalsEmitter.prototype, 'emit', null, function (name, arg1, arg2) {
  var listeners = this._signals[name];
  if (!listeners) return;
  callListeners(this, listeners, arg1, arg2);
});

var EmitterSharedSignal =
/*#__PURE__*/
function (_Signal) {
  _inherits(EmitterSharedSignal, _Signal);

  function EmitterSharedSignal() {
    _classCallCheck(this, EmitterSharedSignal);

    return _possibleConstructorReturn(this, _getPrototypeOf(EmitterSharedSignal).apply(this, arguments));
  }

  _createClass(EmitterSharedSignal, [{
    key: "asSignalDispatcher",
    value: function asSignalDispatcher() {
      return new InternalSignalDispatcher(this.listeners);
    }
  }]);

  return EmitterSharedSignal;
}(Signal);

var sharedSignal = new EmitterSharedSignal();

SignalsEmitter.createSignal = function (target, name, onInitialized) {
  var object = typeof target === 'function' ? target.prototype : target;

  var getter = function getter() {
    var signals = this._signals;
    if (!signals) return null;
    var listeners = signals[name];

    if (!listeners) {
      listeners = [null, null, null, null];
      signals[name] = listeners;

      if (typeof onInitialized === 'function') {
        onInitialized(this, name);
      }
    }

    sharedSignal.listeners = listeners;
    return sharedSignal;
  };

  util.defineProperty(object, name, null, getter, null);
};

exports.SignalsEmitter = SignalsEmitter;
},{"../util":"xr+4","./signal":"XbcT","./dispatcher":"Beob"}],"WtLN":[function(require,module,exports) {
var _require = require('./dispatcher'),
    SignalDispatcher = _require.SignalDispatcher;

var _require2 = require('./emitter'),
    SignalsEmitter = _require2.SignalsEmitter;

exports.SignalDispatcher = SignalDispatcher;
exports.SignalsEmitter = SignalsEmitter;
},{"./dispatcher":"Beob","./emitter":"juRu"}],"lQvG":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var AssertionError,
      assert,
      createFailFunction,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../util');

  assert = module.exports = function (expr, msg) {
    if (!expr) {
      return assert.fail(expr, true, msg, '==', assert);
    }
  };

  assert.AssertionError = AssertionError = function (superClass) {
    var valueToString;
    extend(AssertionError, superClass);

    valueToString = function valueToString(value) {
      var result;

      if (utils.isObject(value)) {
        result = function () {
          try {
            return JSON.stringify(value);
          } catch (error1) {}
        }();
      }

      return result || String(value);
    };

    AssertionError.generateMessage = function (error, msg) {
      return msg || valueToString(error.actual) + " " + error.operator + " " + valueToString(error.expected);
    };

    function AssertionError(opts) {
      AssertionError.__super__.constructor.call(this);

      this.name = 'AssertionError';
      this.actual = opts.actual;
      this.expected = opts.expected;
      this.operator = opts.operator;
      this.scope = opts.scope;
      this.message = AssertionError.generateMessage(this, opts.message);

      if (typeof Error.captureStackTrace === "function") {
        Error.captureStackTrace(this, opts.stackStartFunction);
      }
    }

    return AssertionError;
  }(Error);

  createFailFunction = function createFailFunction(assert) {
    var _func;

    return _func = function func(actual, expected, msg, operator, stackStartFunction) {
      throw new assert.AssertionError({
        actual: actual,
        expected: expected,
        message: msg,
        operator: operator,
        scope: assert._scope,
        stackStartFunction: stackStartFunction || _func
      });
    };
  };

  assert.scope = function (msg) {
    var func;
    msg = "" + this._scope + msg;

    func = function func(expr, msg) {
      return assert(expr, msg);
    };

    utils.merge(func, assert);
    func.fail = createFailFunction(func);
    func._scope = msg;
    return func;
  };

  assert.fail = createFailFunction(assert);
  assert._scope = '';
  assert.ok = assert;

  assert.notOk = function (expr, msg) {
    if (expr) {
      return this.fail(expr, true, msg, '!=', assert.notOk);
    }
  };

  assert.is = function (actual, expected, msg) {
    if (!utils.is(actual, expected)) {
      return this.fail(actual, expected, msg, '===', assert.is);
    }
  };

  assert.isNot = function (actual, expected, msg) {
    if (utils.is(actual, expected)) {
      return this.fail(actual, expected, msg, '!==', assert.isNot);
    }
  };

  assert.isDefined = function (val, msg) {
    if (val == null) {
      return this.fail(val, null, msg, '!=', assert.isDefined);
    }
  };

  assert.isNotDefined = function (val, msg) {
    if (val != null) {
      return this.fail(val, null, msg, '==', assert.isNotDefined);
    }
  };

  assert.isPrimitive = function (val, msg) {
    if (!utils.isPrimitive(val)) {
      return this.fail(val, 'primitive', msg, 'is', assert.isPrimitive);
    }
  };

  assert.isNotPrimitive = function (val, msg) {
    if (utils.isPrimitive(val)) {
      return this.fail(val, 'primitive', msg, 'isn\'t', assert.isNotPrimitive);
    }
  };

  assert.isString = function (val, msg) {
    if (typeof val !== 'string') {
      return this.fail(val, 'string', msg, 'is', assert.isString);
    }
  };

  assert.isNotString = function (val, msg) {
    if (typeof val === 'string') {
      return this.fail(val, 'string', msg, 'isn\'t', assert.isNotString);
    }
  };

  assert.isFloat = function (val, msg) {
    if (!utils.isFloat(val)) {
      return this.fail(val, 'float', msg, 'is', assert.isFloat);
    }
  };

  assert.isNotFloat = function (val, msg) {
    if (utils.isFloat(val)) {
      return this.fail(val, 'float', msg, 'isn\'t', assert.isNotFloat);
    }
  };

  assert.isInteger = function (val, msg) {
    if (!utils.isInteger(val)) {
      return this.fail(val, 'integer', msg, 'is', assert.isInteger);
    }
  };

  assert.isNotInteger = function (val, msg) {
    if (utils.isInteger(val)) {
      return this.fail(val, 'integer', msg, 'isn\'t', assert.isNotInteger);
    }
  };

  assert.isBoolean = function (val, msg) {
    if (typeof val !== 'boolean') {
      return this.fail(val, 'boolean', msg, 'is', assert.isBoolean);
    }
  };

  assert.isNotBoolean = function (val, msg) {
    if (typeof val === 'boolean') {
      return this.fail(val, 'boolean', msg, 'isn\'t', assert.isNotBoolean);
    }
  };

  assert.isFunction = function (val, msg) {
    if (typeof val !== 'function') {
      return this.fail(val, 'function', msg, 'is', assert.isFunction);
    }
  };

  assert.isNotFunction = function (val, msg) {
    if (typeof val === 'function') {
      return this.fail(val, 'function', msg, 'isn\'t', assert.isNotFunction);
    }
  };

  assert.isObject = function (val, msg) {
    if (val === null || _typeof(val) !== 'object') {
      return this.fail(val, 'object', msg, 'is', assert.isObject);
    }
  };

  assert.isNotObject = function (val, msg) {
    if (val !== null && _typeof(val) === 'object') {
      return this.fail(val, 'object', msg, 'isn\'t', assert.isNotObject);
    }
  };

  assert.isPlainObject = function (val, msg) {
    if (!utils.isPlainObject(val)) {
      return this.fail(val, 'plain object', msg, 'is', assert.isPlainObject);
    }
  };

  assert.isNotPlainObject = function (val, msg) {
    if (utils.isPlainObject(val)) {
      return this.fail(val, 'plain object', msg, 'isn\'t', assert.isNotPlainObject);
    }
  };

  assert.isArray = function (val, msg) {
    if (!Array.isArray(val)) {
      return this.fail(val, 'array', msg, 'is', assert.isArray);
    }
  };

  assert.isNotArray = function (val, msg) {
    if (Array.isArray(val)) {
      return this.fail(val, 'array', msg, 'isn\'t', assert.isNotArray);
    }
  };

  assert.isEqual = function (val1, val2, msg, opts) {
    if (_typeof(msg) === 'object') {
      opts = msg;
      msg = void 0;
    }

    if (!utils.isEqual(val1, val2, opts != null ? opts.maxDeep : void 0)) {
      return this.fail(val1, val2, msg, 'equal', assert.isEqual);
    }
  };

  assert.isNotEqual = function (val1, val2, msg, opts) {
    if (_typeof(msg) === 'object') {
      opts = msg;
      msg = void 0;
    }

    if (utils.isEqual(val1, val2, opts != null ? opts.maxDeep : void 0)) {
      return this.fail(val1, val2, msg, 'isn\'t equal', assert.isNotEqual);
    }
  };

  assert.instanceOf = function (val, ctor, msg) {
    var ctorName;

    if (!(val instanceof ctor)) {
      ctorName = ctor.__path__ || ctor.__name__ || ctor.name || ctor;
      return this.fail(val, ctorName, msg, 'instanceof', assert.instanceOf);
    }
  };

  assert.notInstanceOf = function (val, ctor, msg) {
    var ctorName;

    if (val instanceof ctor) {
      ctorName = ctor.__path__ || ctor.__name__ || ctor.name || ctor;
      return this.fail(val, ctorName, msg, 'instanceof', assert.notInstanceOf);
    }
  };

  assert.lengthOf = function (val, length, msg) {
    if ((val != null ? val.length : void 0) !== length) {
      return this.fail(val, length, msg, '.length ===', assert.lengthOf);
    }
  };

  assert.notLengthOf = function (val, length, msg) {
    if ((val != null ? val.length : void 0) === length) {
      return this.fail(val, length, msg, '.length !==', assert.notLengthOf);
    }
  };

  assert.operator = function (val1, operator, val2, msg) {
    var pass;

    pass = function () {
      switch (operator) {
        case '>':
          return val1 > val2;

        case '>=':
          return val1 >= val2;

        case '<':
          return val1 < val2;

        case '<=':
          return val1 <= val2;

        default:
          throw new TypeError("Unexpected operator `" + operator + "`");
      }
    }();

    if (!pass) {
      return this.fail(val1, val2, msg, operator, assert.operator);
    }
  };

  assert.match = function (val, regexp, msg) {
    if (!regexp.test(val)) {
      return this.fail(val, regexp, msg, 'match', assert.match);
    }
  };

  assert.notMatch = function (val, regexp, msg) {
    if (regexp.test(val)) {
      return this.fail(val, regexp, msg, 'not match', assert.match);
    }
  };
}).call(this);
},{"../util":"xr+4"}],"jt0G":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, immediate, log, pending;
  assert = require('../assert');
  log = require('../log');
  immediate = [];
  pending = 0;

  exports.lock = function () {
    return pending += 1;
  };

  exports.release = function () {
    var error;
    pending -= 1;
    assert.ok(pending >= 0);

    if (pending === 0 && immediate.length > 0) {
      exports.lock();

      while (immediate.length > 0) {
        try {
          immediate.shift()();
        } catch (error1) {
          error = error1;
          log.error('Uncaught error when executing event-loop', error);
        }
      }

      exports.release();
    }
  };

  exports.callInLock = function (func, ctx, args) {
    var result;
    exports.lock();

    try {
      result = func.apply(ctx, args);
    } finally {
      exports.release();
    }

    return result;
  };

  exports.bindInLock = function (func) {
    return function () {
      var result;
      exports.lock();

      try {
        result = func.apply(this, arguments);
      } finally {
        exports.release();
      }

      return result;
    };
  };

  exports.setImmediate = function (callback) {
    var error;
    assert.isFunction(callback, "eventLoop.setImmediate callback must be a function, but " + callback + " given");

    if (pending === 0) {
      exports.lock();

      try {
        callback();
      } catch (error1) {
        error = error1;
        log.error('Uncaught error during setImmediate in the event-loop', error);
      }

      exports.release();
    } else {
      immediate.push(callback);
    }
  };
}).call(this);
},{"../assert":"lQvG","../log":"fe8o"}],"JghC":[function(require,module,exports) {
(function () {
  'use strict';

  var cos, eventLoop, isPointInBox, sin, utils;
  utils = require('../../../../../util');
  eventLoop = require('../../../../../event-loop');
  sin = Math.sin, cos = Math.cos;

  isPointInBox = function isPointInBox(ex, ey, x, y, w, h) {
    return ex >= x && ey >= y && ex < x + w && ey < y + h;
  };

  module.exports = function (impl) {
    var CLICK, ENTER, EVENTS, EXIT, MOVE, PRESS, PROPAGATE_UP, RELEASE, STOP_ASIDE_PROPAGATION, STOP_PROPAGATION, WHEEL, captureItems, hoverItems, i, itemsToMove, itemsToRelease, pressedItems;
    PROPAGATE_UP = 1 << 0;
    STOP_ASIDE_PROPAGATION = 1 << 1;
    STOP_PROPAGATION = 1 << 2;

    captureItems = function () {
      var _checkItem;

      _checkItem = function checkItem(item, ex, ey, onItem, parentX, parentY, parentScale) {
        var child, data, fullScale, h, itemX, itemY, pointer, rcos, result, rey, rotation, rsin, scale, t1, t2, w, x, y;
        result = 0;
        x = y = w = h = scale = rotation = t1 = t2 = rey = rsin = rcos = 0.0;

        if (!item._visible) {
          return result;
        }

        data = item._impl;
        pointer = item._pointer;

        if (pointer && !pointer._enabled) {
          return result;
        }

        x = parentX + item._x * parentScale;
        y = parentY + item._y * parentScale;
        w = item._width * parentScale;
        h = item._height * parentScale;
        scale = item._scale;
        rotation = item._rotation;
        fullScale = scale * parentScale;

        if (scale !== 1) {
          t1 = w * scale;
          t2 = h * scale;
          x += (w - t1) / 2;
          y += (h - t2) / 2;
          w = t1;
          h = t2;
        }

        if (rotation !== 0) {
          rsin = sin(-rotation);
          rcos = cos(-rotation);
          t1 = x + w / 2;
          t2 = y + h / 2;
          rey = rcos * (ex - t1) - rsin * (ey - t2) + t1;
          ey = rsin * (ex - t1) + rcos * (ey - t2) + t2;
          ex = rey;
        }

        if (item._clip && !isPointInBox(ex, ey, x, y, w, h)) {
          return result;
        }

        if (!(result & STOP_ASIDE_PROPAGATION)) {
          if (item._children) {
            child = item._children.topChild;

            while (child) {
              result = _checkItem(child, ex, ey, onItem, x, y, fullScale);

              if (result & STOP_PROPAGATION) {
                return result;
              }

              if (result & STOP_ASIDE_PROPAGATION) {
                break;
              }

              child = child.belowSibling;
            }
          }
        }

        if (result & PROPAGATE_UP || isPointInBox(ex, ey, x, y, w, h)) {
          itemX = (ex - x) / fullScale;
          itemY = (ey - y) / fullScale;
          result = onItem(item, itemX, itemY);
        }

        return result;
      };

      return function (item, ex, ey, onItem) {
        if (item) {
          return _checkItem(item, ex, ey, onItem, 0, 0, 1);
        }

        return 0;
      };
    }();

    itemsToRelease = [];
    itemsToMove = [];
    pressedItems = [];
    hoverItems = [];
    impl.Renderer.onReady.connect(function () {
      var Device, event, getEventStatus;
      Device = impl.Renderer.Device;
      event = impl.Renderer.Item.Pointer.event;

      getEventStatus = function getEventStatus() {
        if (event._checkSiblings) {
          return PROPAGATE_UP;
        } else {
          return PROPAGATE_UP | STOP_ASIDE_PROPAGATION;
        }
      };

      Device.onPointerPress.connect(function () {
        var onItem;

        onItem = function onItem(item, itemX, itemY) {
          var capturePointer;
          capturePointer = item._impl.capturePointer;

          if (capturePointer & CLICK) {
            pressedItems.push(item);
          }

          if (capturePointer & PRESS) {
            event._ensureRelease = true;
            event._ensureMove = true;
            event._itemX = itemX;
            event._itemY = itemY;
            item.pointer.emit('onPress', event);

            if (event._ensureRelease) {
              itemsToRelease.push(item);
            }

            if (event._ensureMove) {
              itemsToMove.push(item);
            }

            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
          }

          return getEventStatus();
        };

        return eventLoop.bindInLock(function (e) {
          event._stopPropagation = false;
          event._checkSiblings = false;
          event._preventClick = false;
          captureItems(impl.windowItem, e._x, e._y, onItem);
        });
      }());
      Device.onPointerRelease.connect(function () {
        var onItem;

        onItem = function onItem(item, itemX, itemY) {
          var capturePointer, data, index;
          data = item._impl;
          capturePointer = data.capturePointer;

          if (capturePointer & (RELEASE | PRESS | CLICK)) {
            event._itemX = itemX;
            event._itemY = itemY;
          }

          if (capturePointer & RELEASE) {
            item._pointer.emit('onRelease', event);
          }

          if (capturePointer & PRESS) {
            index = itemsToRelease.indexOf(item);

            if (index >= 0) {
              itemsToRelease[index] = null;
            }
          }

          if (capturePointer & CLICK && !event._preventClick) {
            if (utils.has(pressedItems, item)) {
              item.pointer.emit('onClick', event);
            }
          }

          if (capturePointer & (RELEASE | CLICK)) {
            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
          }

          return getEventStatus();
        };

        return eventLoop.bindInLock(function (e) {
          var data, item, j;
          event._stopPropagation = false;
          event._checkSiblings = false;
          captureItems(impl.windowItem, e._x, e._y, onItem);
          event._itemX = -1;
          event._itemY = -1;

          if (impl.Renderer.Screen.touch) {
            while (item = hoverItems.pop()) {
              data = item._impl;
              data.pointerHover = false;
              data.pointerMoveFlag = 0;
              item.pointer.emit('onExit', event);
            }
          }

          if (!event._stopPropagation) {
            for (j = itemsToRelease.length - 1; j >= 0; j += -1) {
              item = itemsToRelease[j];

              if (item) {
                item.pointer.emit('onRelease', event);

                if (event._stopPropagation) {
                  break;
                }
              }
            }
          }

          utils.clear(itemsToRelease);
          utils.clear(itemsToMove);
          utils.clear(pressedItems);
        });
      }());
      Device.onPointerMove.connect(function () {
        var flag, onItem;
        flag = 0;

        onItem = function onItem(item, itemX, itemY) {
          var capturePointer, data;
          data = item._impl;
          capturePointer = data.capturePointer;

          if (capturePointer & (ENTER | EXIT | MOVE)) {
            data.pointerMoveFlag = flag;
            event._itemX = itemX;
            event._itemY = itemY;
          }

          if (capturePointer & (ENTER | EXIT) && !data.pointerHover) {
            data.pointerHover = true;
            hoverItems.push(item);
            item.pointer.emit('onEnter', event);
          }

          if (capturePointer & MOVE) {
            item._pointer.emit('onMove', event);
          }

          if (capturePointer & (ENTER | EXIT | MOVE)) {
            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
          }

          return getEventStatus();
        };

        return eventLoop.bindInLock(function (e) {
          var data, i, item, j, k, l, len, len1;
          event._stopPropagation = false;
          event._checkSiblings = false;
          flag = flag % 2 + 1;
          captureItems(impl.windowItem, e._x, e._y, onItem);
          event._itemX = -1;
          event._itemY = -1;

          for (j = 0, len = itemsToMove.length; j < len; j++) {
            item = itemsToMove[j];

            if (event._stopPropagation) {
              break;
            }

            data = item._impl;

            if (data.pointerMoveFlag !== flag) {
              item.pointer.emit('onMove', event);
            }
          }

          for (i = k = hoverItems.length - 1; k >= 0; i = k += -1) {
            item = hoverItems[i];
            data = item._impl;

            if (data.pointerHover && data.pointerMoveFlag !== flag) {
              data.pointerHover = false;
              data.pointerMoveFlag = 0;
              hoverItems.splice(i, 1);
              item.pointer.emit('onExit', event);
            }
          }

          for (l = 0, len1 = itemsToMove.length; l < len1; l++) {
            item = itemsToMove[l];
            data = item._impl;

            if (data.pointerMoveFlag !== flag) {
              data.pointerMoveFlag = flag;
            }
          }
        });
      }());
      return Device.onPointerWheel.connect(function () {
        var onItem;

        onItem = function onItem(item, itemX, itemY) {
          var pointer;
          event._stopPropagation = true;

          if (item._impl.capturePointer & WHEEL) {
            if ((pointer = item._pointer) && !pointer.onWheel.isEmpty()) {
              event._itemX = itemX;
              event._itemY = itemY;
              pointer.emit('onWheel', event);

              if (event._stopPropagation) {
                return STOP_PROPAGATION;
              }
            }
          }

          return getEventStatus();
        };

        return eventLoop.bindInLock(function (e) {
          event._checkSiblings = false;
          captureItems(impl.windowItem, e._x, e._y, onItem);
        });
      }());
    });
    i = 0;
    return {
      EVENTS: EVENTS = {
        onPress: PRESS = 1 << i++,
        onRelease: RELEASE = 1 << i++,
        onMove: MOVE = 1 << i++,
        onWheel: WHEEL = 1 << i++,
        onClick: CLICK = 1 << i++,
        onEnter: ENTER = 1 << i++,
        onExit: EXIT = 1 << i++
      },
      DATA: {
        pointerHover: false,
        pointerMoveFlag: 0,
        capturePointer: 0
      },
      attachItemSignal: function attachItemSignal(signal) {
        var data, eventId, item;
        item = this._ref;
        data = item._impl;

        if (!(eventId = EVENTS[signal])) {
          return;
        }

        data.capturePointer |= eventId;
      },
      setItemPointerEnabled: function setItemPointerEnabled(val) {},
      setItemPointerDraggable: function setItemPointerDraggable(val) {},
      setItemPointerDragActive: function setItemPointerDragActive(val) {}
    };
  };
}).call(this);
},{"../../../../../util":"xr+4","../../../../../event-loop":"jt0G"}],"wKwT":[function(require,module,exports) {
(function () {
  'use strict';

  var polyfill;

  polyfill = function polyfill(n) {
    var arr, i, j, ref;
    arr = new Array(n);

    for (i = j = 0, ref = n; j < ref; i = j += 1) {
      arr[i] = 0;
    }

    return arr;
  };

  exports.Int8 = function () {
    if (typeof Int8Array !== 'undefined') {
      return Int8Array;
    } else {
      return polyfill;
    }
  }();

  exports.Uint8 = function () {
    if (typeof Uint8Array !== 'undefined') {
      return Uint8Array;
    } else {
      return polyfill;
    }
  }();

  exports.Int16 = function () {
    if (typeof Int16Array !== 'undefined') {
      return Int16Array;
    } else {
      return polyfill;
    }
  }();

  exports.Uint16 = function () {
    if (typeof Uint16Array !== 'undefined') {
      return Uint16Array;
    } else {
      return polyfill;
    }
  }();

  exports.Int32 = function () {
    if (typeof Int32Array !== 'undefined') {
      return Int32Array;
    } else {
      return polyfill;
    }
  }();

  exports.Uint32 = function () {
    if (typeof Uint32Array !== 'undefined') {
      return Uint32Array;
    } else {
      return polyfill;
    }
  }();

  exports.Float32 = function () {
    if (typeof Float32Array !== 'undefined') {
      return Float32Array;
    } else {
      return polyfill;
    }
  }();

  exports.Float64 = function () {
    if (typeof Float64Array !== 'undefined') {
      return Float64Array;
    } else {
      return polyfill;
    }
  }();
}).call(this);
},{}],"9UEq":[function(require,module,exports) {
(function () {
  'use strict';

  var MAX_LOOPS, TypedArray, clean, cleanPending, cleanQueue, elementsBottomMargin, elementsRow, elementsX, elementsY, eventLoop, getArray, getCleanArray, log, max, min, pending, queue, queueIndex, queues, rowsFills, rowsHeight, rowsWidth, unusedFills, update, updateItem, updateItems, updateSize, utils;
  utils = require('../../../../../../util');
  log = require('../../../../../../log');
  eventLoop = require('../../../../../../event-loop');
  TypedArray = require('../../../../../../typed-array');
  log = log.scope('Renderer', 'Flow');
  MAX_LOOPS = 150;

  min = function min(a, b) {
    if (a < b) {
      return a;
    } else {
      return b;
    }
  };

  max = function max(a, b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  };

  getArray = function getArray(arr, len) {
    if (arr.length < len) {
      return new arr.constructor(len * 1.4 | 0);
    } else {
      return arr;
    }
  };

  getCleanArray = function getCleanArray(arr, len) {
    var i, j, newArr, ref;
    newArr = getArray(arr, len);

    if (newArr === arr) {
      for (i = j = 0, ref = len; j < ref; i = j += 1) {
        arr[i] = 0;
      }

      return arr;
    } else {
      return newArr;
    }
  };

  queueIndex = 0;
  queues = [[], []];
  queue = queues[queueIndex];
  pending = false;
  rowsWidth = new TypedArray.Float64(64);
  rowsHeight = new TypedArray.Float64(64);
  elementsX = new TypedArray.Float64(64);
  elementsY = new TypedArray.Float64(64);
  elementsRow = new TypedArray.Float64(64);
  elementsBottomMargin = new TypedArray.Float64(64);
  rowsFills = new TypedArray.Uint8(64);
  unusedFills = new TypedArray.Uint8(64);

  updateItem = function updateItem(item) {
    var alignH, alignV, anchors, autoHeight, autoWidth, bottom, bottomMargin, bottomPadding, cell, child, children, columnSpacing, currentRow, currentRowBottomMargin, currentRowY, currentYShift, data, firstChild, flowHeight, flowWidth, freeHeightSpace, height, i, j, lastColumnRightMargin, lastRowBottomMargin, leftMargin, leftPadding, length, margin, maxFlowWidth, maxLen, multiplierX, multiplierY, nextChild, padding, perCell, plusY, ref, right, rightMargin, rightPadding, row, rowSpacing, rowsFillsSum, topMargin, topPadding, update, visibleChildrenIndex, width, x, y, yShift;
    children = item._children;
    firstChild = children.firstChild;
    data = item._impl;
    autoWidth = data.autoWidth, autoHeight = data.autoHeight;
    autoWidth && (autoWidth = !item._fillWidth);
    autoHeight && (autoHeight = !item._fillHeight);

    if (data.loops === MAX_LOOPS) {
      log.error("Potential Flow loop detected. Recalculating on this item (" + item.toString() + ") has been disabled.");
      data.loops++;
      return;
    } else if (data.loops > MAX_LOOPS) {
      return;
    }

    if (padding = item._padding) {
      topPadding = padding._top;
      rightPadding = padding._right;
      bottomPadding = padding._bottom;
      leftPadding = padding._left;
    } else {
      topPadding = rightPadding = bottomPadding = leftPadding = 0;
    }

    maxFlowWidth = autoWidth ? 2e308 : item._width - leftPadding - rightPadding;
    columnSpacing = item.spacing.column;
    rowSpacing = item.spacing.row;

    if (item._alignment) {
      alignH = item._alignment._horizontal;
      alignV = item._alignment._vertical;
    } else {
      alignH = 'left';
      alignV = 'top';
    }

    maxLen = children.length;
    rowsFills = getCleanArray(rowsFills, maxLen);

    if (elementsX.length < maxLen) {
      maxLen *= 1.5;
      rowsWidth = getArray(rowsWidth, maxLen);
      rowsHeight = getArray(rowsHeight, maxLen);
      elementsX = getArray(elementsX, maxLen);
      elementsY = getArray(elementsY, maxLen);
      elementsRow = getArray(elementsRow, maxLen);
      elementsBottomMargin = getArray(elementsBottomMargin, maxLen);
    }

    flowWidth = flowHeight = 0;
    currentRow = currentRowY = 0;
    lastColumnRightMargin = lastRowBottomMargin = currentRowBottomMargin = 0;
    x = y = right = bottom = 0;
    rowsFillsSum = visibleChildrenIndex = 0;
    nextChild = firstChild;
    i = -1;

    while (child = nextChild) {
      i += 1;
      nextChild = child.nextSibling;
      margin = child._margin;
      anchors = child._anchors;
      width = child._width;
      height = child._height;

      if (!child._visible || anchors && anchors._runningCount) {
        continue;
      }

      if (margin) {
        topMargin = margin._top;
        rightMargin = margin._right;
        bottomMargin = margin._bottom;
        leftMargin = margin._left;
      } else {
        topMargin = rightMargin = bottomMargin = leftMargin = 0;
      }

      if (child._fillWidth && !autoWidth) {
        width = maxFlowWidth - leftMargin - rightMargin;
        child.width = width;
      }

      x += leftMargin + lastColumnRightMargin + (x > 0 ? columnSpacing : 0);
      right = x + width + rightMargin;

      if (right > maxFlowWidth && visibleChildrenIndex > 0) {
        x = leftMargin;
        right = x + width + rightMargin;
        currentRowY += rowsHeight[currentRow];
        currentRow++;
        lastRowBottomMargin = currentRowBottomMargin;
        currentRowBottomMargin = 0;
      }

      if (child._fillHeight && !autoHeight) {
        rowsFills[currentRow] = max(rowsFills[currentRow], rowsFills[currentRow] + 1);
        rowsFillsSum++;
        height = 0;
        elementsBottomMargin[i] = bottomMargin;
      }

      bottom = y + height;
      y = currentRowY;
      y += lastRowBottomMargin + topMargin + (y > 0 ? rowSpacing : 0);
      lastColumnRightMargin = rightMargin;
      currentRowBottomMargin = max(currentRowBottomMargin, bottomMargin);
      elementsX[i] = x;
      elementsY[i] = y;
      elementsRow[i] = currentRow;
      flowWidth = max(flowWidth, right);
      flowHeight = max(flowHeight, y + height);
      rowsWidth[currentRow] = right;
      rowsHeight[currentRow] = flowHeight - currentRowY;
      x += width;
      y += height;
      visibleChildrenIndex++;
    }

    flowHeight = max(flowHeight, flowHeight + currentRowBottomMargin);
    freeHeightSpace = item._height - topPadding - bottomPadding - flowHeight;

    if (freeHeightSpace > 0 && rowsFillsSum > 0) {
      length = currentRow + 1;
      unusedFills = getCleanArray(unusedFills, length);
      perCell = (flowHeight + freeHeightSpace) / length;
      update = true;

      while (update) {
        update = false;

        for (i = j = 0, ref = currentRow; j <= ref; i = j += 1) {
          if (unusedFills[i] === 0 && (rowsFills[i] === 0 || rowsHeight[i] > perCell)) {
            length--;
            perCell -= (rowsHeight[i] - perCell) / length;
            unusedFills[i] = 1;
            update = true;
          }
        }
      }

      yShift = currentYShift = 0;
      nextChild = firstChild;
      row = -1;
      i = -1;

      while (child = nextChild) {
        i += 1;
        nextChild = child.nextSibling;
        anchors = child._anchors;

        if (!child._visible || anchors && anchors._runningCount) {
          continue;
        }

        if (elementsRow[i] === row + 1 && unusedFills[row] === 0) {
          yShift += currentYShift;
          currentYShift = 0;
        }

        row = elementsRow[i];
        elementsY[i] += yShift;

        if (unusedFills[row] === 0) {
          if (child._fillHeight) {
            child.height = perCell;

            if (!currentYShift) {
              currentYShift = perCell - rowsHeight[row];
              rowsHeight[row] = perCell;
            }
          }
        }
      }

      freeHeightSpace = 0;
    }

    switch (alignH) {
      case 'left':
        multiplierX = 0;
        break;

      case 'center':
        multiplierX = 0.5;
        break;

      case 'right':
        multiplierX = 1;
    }

    switch (alignV) {
      case 'top':
        multiplierY = 0;
        break;

      case 'center':
        multiplierY = 0.5;
        break;

      case 'bottom':
        multiplierY = 1;
    }

    if (autoHeight || alignV === 'top') {
      plusY = 0;
    } else {
      plusY = freeHeightSpace * multiplierY;
    }

    if (!autoWidth) {
      flowWidth = item._width - leftPadding - rightPadding;
    }

    if (!autoHeight) {
      flowHeight = item._height - topPadding - bottomPadding;
    }

    nextChild = firstChild;
    i = -1;

    while (child = nextChild) {
      i += 1;
      nextChild = child.nextSibling;

      if (!child._visible) {
        continue;
      }

      cell = elementsRow[i];
      anchors = child._anchors;

      if (anchors && anchors._runningCount) {
        continue;
      }

      child.x = elementsX[i] + (flowWidth - rowsWidth[cell]) * multiplierX + leftPadding;
      child.y = elementsY[i] + plusY + (rowsHeight[cell] - child._height) * multiplierY + topPadding;
    }

    if (autoWidth) {
      item.width = flowWidth + leftPadding + rightPadding;
    }

    if (autoHeight) {
      item.height = flowHeight + topPadding + bottomPadding;
    }
  };

  updateItems = function updateItems() {
    var currentQueue, item;
    pending = false;
    currentQueue = queue;
    queue = queues[++queueIndex % queues.length];

    while (currentQueue.length) {
      item = currentQueue.pop();
      item._impl.pending = false;
      item._impl.updatePending = true;
      updateItem(item);
      item._impl.updatePending = false;
    }
  };

  cleanPending = false;
  cleanQueue = [];

  clean = function clean() {
    var data;
    cleanPending = false;

    while (data = cleanQueue.pop()) {
      if (data.loops < MAX_LOOPS) {
        data.loops = 0;
      }
    }
  };

  update = function update() {
    var data;
    data = this._impl;

    if (data.pending || !this._visible) {
      return;
    }

    if (!data.loops++) {
      cleanQueue.push(data);

      if (!cleanPending) {
        setTimeout(clean);
        cleanPending = true;
      }
    }

    data.pending = true;
    queue.push(this);

    if (!pending) {
      pending = true;
      eventLoop.setImmediate(updateItems);
    }
  };

  updateSize = function updateSize() {
    if (!this._impl.updatePending) {
      update.call(this);
    }
  };

  module.exports = function (impl) {
    var disableChild, enableChild, onChildrenChange, onHeightChange, onWidthChange;

    onWidthChange = function onWidthChange(oldVal) {
      this._impl.autoWidth = impl.Renderer.sizeUtils.isAutoWidth(this);
      return updateSize.call(this);
    };

    onHeightChange = function onHeightChange(oldVal) {
      this._impl.autoHeight = impl.Renderer.sizeUtils.isAutoHeight(this);
      return updateSize.call(this);
    };

    enableChild = function enableChild(child) {
      child.onVisibleChange.connect(update, this);
      child.onWidthChange.connect(updateSize, this);
      child.onHeightChange.connect(updateSize, this);
      child.onFillWidthChange.connect(update, this);
      child.onFillHeightChange.connect(update, this);
      child.onMarginChange.connect(update, this);
      return child.onAnchorsChange.connect(update, this);
    };

    disableChild = function disableChild(child) {
      child.onVisibleChange.disconnect(update, this);
      child.onWidthChange.disconnect(updateSize, this);
      child.onHeightChange.disconnect(updateSize, this);
      child.onFillWidthChange.disconnect(update, this);
      child.onFillHeightChange.disconnect(update, this);
      child.onMarginChange.disconnect(update, this);
      return child.onAnchorsChange.disconnect(update, this);
    };

    onChildrenChange = function onChildrenChange(added, removed) {
      if (added) {
        enableChild.call(this, added);
      }

      if (removed) {
        disableChild.call(this, removed);
      }

      return update.call(this);
    };

    return {
      turnOff: function turnOff(item, oldItem) {
        var child;
        this.onAlignmentChange.disconnect(updateSize);
        this.onPaddingChange.disconnect(update);
        this.onVisibleChange.disconnect(update);
        this.onChildrenChange.disconnect(onChildrenChange);
        this.onWidthChange.disconnect(onWidthChange);
        this.onHeightChange.disconnect(onHeightChange);

        if (this._impl.autoWidth) {
          this.width = 0;
        }

        if (this._impl.autoHeight) {
          this.height = 0;
        }

        child = this.children.firstChild;

        while (child) {
          disableChild.call(this, child);
          child = child.nextSibling;
        }
      },
      turnOn: function turnOn() {
        var child;
        this.onAlignmentChange.connect(updateSize);
        this.onPaddingChange.connect(update);
        this.onVisibleChange.connect(update);
        this.onChildrenChange.connect(onChildrenChange);
        this.onWidthChange.connect(onWidthChange);
        this.onHeightChange.connect(onHeightChange);
        child = this.children.firstChild;

        while (child) {
          enableChild.call(this, child);
          child = child.nextSibling;
        }

        update.call(this);
      },
      update: update
    };
  };
}).call(this);
},{"../../../../../../util":"xr+4","../../../../../../log":"fe8o","../../../../../../event-loop":"jt0G","../../../../../../typed-array":"wKwT"}],"uxrr":[function(require,module,exports) {
(function () {
  'use strict';

  var ALIGNMENT_TO_POINT, ALL, COLUMN, MAX_LOOPS, ROW, TypedArray, columnsFills, columnsSizes, eventLoop, getArray, getCleanArray, log, pending, queue, queueIndex, queues, rowsFills, rowsSizes, unusedFills, update, updateItem, updateItems, updateSize, utils, visibleChildren;
  MAX_LOOPS = 100;
  utils = require('../../../../../../util');
  log = require('../../../../../../log');
  eventLoop = require('../../../../../../event-loop');
  TypedArray = require('../../../../../../typed-array');
  log = log.scope('Renderer');
  COLUMN = 1 << 0;
  ROW = 1 << 1;
  ALL = (1 << 2) - 1;
  queueIndex = 0;
  queues = [[], []];
  queue = queues[queueIndex];
  pending = false;
  visibleChildren = new TypedArray.Uint8(64);
  columnsSizes = new TypedArray.Float64(64);
  columnsFills = new TypedArray.Uint8(64);
  rowsSizes = new TypedArray.Float64(64);
  rowsFills = new TypedArray.Uint8(64);
  unusedFills = new TypedArray.Uint8(64);

  getArray = function getArray(arr, len) {
    if (arr.length < len) {
      return new arr.constructor(len * 1.4 | 0);
    } else {
      return arr;
    }
  };

  getCleanArray = function getCleanArray(arr, len) {
    var i, j, newArr, ref;
    newArr = getArray(arr, len);

    if (newArr === arr) {
      for (i = j = 0, ref = len; j < ref; i = j += 1) {
        arr[i] = 0;
      }

      return arr;
    } else {
      return newArr;
    }
  };

  ALIGNMENT_TO_POINT = {
    left: 0,
    center: 0.5,
    right: 1,
    top: 0,
    bottom: 1
  };

  updateItem = function updateItem(item) {
    var alignH, alignV, alignment, autoHeight, autoWidth, bottomMargin, bottomPadding, cellX, cellY, child, childIndex, children, column, columnSpacing, columnsFillsSum, columnsLen, data, firstChild, freeHeightSpace, freeWidthSpace, gridHeight, gridType, gridWidth, height, i, j, k, l, lastColumn, lastRow, leftMargin, leftPadding, length, m, margin, maxColumnsLen, maxRowsLen, n, nextChild, o, padding, perCell, plusX, plusY, ref, ref1, ref2, ref3, ref4, ref5, rightMargin, rightPadding, row, rowSpacing, rowsFillsSum, rowsLen, topMargin, topPadding, update, width;
    children = item.children;
    firstChild = children.firstChild;
    data = item._impl;
    gridType = data.gridType;
    autoWidth = data.autoWidth, autoHeight = data.autoHeight;
    columnSpacing = rowSpacing = 0;
    autoWidth && (autoWidth = !item._fillWidth);
    autoHeight && (autoHeight = !item._fillHeight);
    columnSpacing = item.spacing.column;
    rowSpacing = item.spacing.row;

    if (gridType === ALL) {
      columnsLen = item.columns;
      rowsLen = item.rows;
    } else if (gridType === COLUMN) {
      columnsLen = 1;
      rowsLen = 2e308;
    } else if (gridType === ROW) {
      columnsLen = 2e308;
      rowsLen = 1;
    }

    if (alignment = item._alignment) {
      alignH = ALIGNMENT_TO_POINT[alignment._horizontal];
      alignV = ALIGNMENT_TO_POINT[alignment._vertical];
    } else {
      alignH = 0;
      alignV = 0;
    }

    if (padding = item._padding) {
      topPadding = padding._top;
      rightPadding = padding._right;
      bottomPadding = padding._bottom;
      leftPadding = padding._left;
    } else {
      topPadding = rightPadding = bottomPadding = leftPadding = 0;
    }

    maxColumnsLen = columnsLen === 2e308 ? children.length : columnsLen;
    columnsSizes = getCleanArray(columnsSizes, maxColumnsLen);
    columnsFills = getCleanArray(columnsFills, maxColumnsLen);
    maxRowsLen = rowsLen === 2e308 ? Math.ceil(children.length / columnsLen) : rowsLen;
    rowsSizes = getCleanArray(rowsSizes, maxRowsLen);
    rowsFills = getCleanArray(rowsFills, maxRowsLen);
    visibleChildren = getArray(visibleChildren, children.length);
    i = lastColumn = 0;
    lastRow = -1;
    nextChild = firstChild;
    childIndex = -1;

    while (child = nextChild) {
      childIndex += 1;
      nextChild = child.nextSibling;

      if (!child._visible || child._anchors && child._anchors._runningCount) {
        visibleChildren[childIndex] = 0;
        continue;
      }

      visibleChildren[childIndex] = 1;
      column = i % columnsLen;
      row = Math.floor(i / columnsLen) % rowsLen;

      if (column > lastColumn) {
        lastColumn = column;
      }

      if (row > lastRow) {
        lastRow = row;
      }

      i++;
    }

    i = columnsFillsSum = rowsFillsSum = 0;
    nextChild = firstChild;
    childIndex = -1;

    while (child = nextChild) {
      childIndex += 1;
      nextChild = child.nextSibling;

      if (!visibleChildren[childIndex]) {
        continue;
      }

      width = child._width;
      height = child._height;
      margin = child._margin;
      column = i % columnsLen;
      row = Math.floor(i / columnsLen) % rowsLen;

      if (child._fillWidth) {
        width = 0;
        columnsFillsSum++;
        columnsFills[column] = 1;
      }

      if (child._fillHeight) {
        height = 0;
        rowsFillsSum++;
        rowsFills[row] = 1;
      }

      if (margin) {
        width += margin._left;
        width += margin._right;
        height += margin._top;
        height += margin._bottom;
      }

      if (width > columnsSizes[column]) {
        columnsSizes[column] = width;
      }

      if (height > rowsSizes[row]) {
        rowsSizes[row] = height;
      }

      i++;
    }

    gridWidth = 0;

    if (autoWidth || columnsFillsSum > 0 || alignH !== 0) {
      for (i = j = 0, ref = lastColumn; j <= ref; i = j += 1) {
        gridWidth += columnsSizes[i];
      }
    }

    gridHeight = 0;

    if (autoHeight || rowsFillsSum > 0 || alignV !== 0) {
      for (i = k = 0, ref1 = lastRow; k <= ref1; i = k += 1) {
        gridHeight += rowsSizes[i];
      }
    }

    if (!autoWidth) {
      freeWidthSpace = item._width - columnSpacing * lastColumn - leftPadding - rightPadding - gridWidth;

      if (freeWidthSpace > 0 && columnsFillsSum > 0) {
        unusedFills = getCleanArray(unusedFills, lastColumn + 1);
        length = lastColumn + 1;
        perCell = (gridWidth + freeWidthSpace) / length;
        update = true;

        while (update) {
          update = false;

          for (i = l = 0, ref2 = lastColumn; l <= ref2; i = l += 1) {
            if (unusedFills[i] === 0 && (columnsFills[i] === 0 || columnsSizes[i] > perCell)) {
              length--;
              perCell -= (columnsSizes[i] - perCell) / length;
              unusedFills[i] = 1;
              update = true;
            }
          }
        }

        for (i = m = 0, ref3 = lastColumn; m <= ref3; i = m += 1) {
          if (unusedFills[i] === 0) {
            columnsSizes[i] = perCell;
          }
        }

        freeWidthSpace = 0;
      }
    }

    if (!autoHeight) {
      freeHeightSpace = item._height - rowSpacing * lastRow - topPadding - bottomPadding - gridHeight;

      if (freeHeightSpace > 0 && rowsFillsSum > 0) {
        unusedFills = getCleanArray(unusedFills, lastRow + 1);
        length = lastRow + 1;
        perCell = (gridHeight + freeHeightSpace) / length;
        update = true;

        while (update) {
          update = false;

          for (i = n = 0, ref4 = lastRow; n <= ref4; i = n += 1) {
            if (unusedFills[i] === 0 && (rowsFills[i] === 0 || rowsSizes[i] > perCell)) {
              length--;
              perCell -= (rowsSizes[i] - perCell) / length;
              unusedFills[i] = 1;
              update = true;
            }
          }
        }

        for (i = o = 0, ref5 = lastRow; o <= ref5; i = o += 1) {
          if (unusedFills[i] === 0) {
            rowsSizes[i] = perCell;
          }
        }

        freeHeightSpace = 0;
      }
    }

    if (autoWidth || alignH === 0) {
      plusX = 0;
    } else {
      plusX = freeWidthSpace * alignH;
    }

    if (autoHeight || alignV === 0) {
      plusY = 0;
    } else {
      plusY = freeHeightSpace * alignV;
    }

    i = cellX = cellY = 0;
    nextChild = firstChild;
    childIndex = -1;

    while (child = nextChild) {
      childIndex += 1;
      nextChild = child.nextSibling;

      if (!visibleChildren[childIndex]) {
        continue;
      }

      margin = child._margin;
      column = i % columnsLen;
      row = Math.floor(i / columnsLen) % rowsLen;

      if (column === 0) {
        cellX = 0;

        if (row === 0) {
          cellY = 0;
        } else {
          cellY += rowsSizes[row - 1] + rowSpacing;
        }
      } else {
        cellX += columnsSizes[column - 1] + columnSpacing;
      }

      leftMargin = rightMargin = 0;

      if (margin) {
        leftMargin = margin._left;
        rightMargin = margin._right;
      }

      topMargin = bottomMargin = 0;

      if (margin) {
        topMargin = margin._top;
        bottomMargin = margin._bottom;
      }

      if (child._fillWidth) {
        width = columnsSizes[column] - leftMargin - rightMargin;
        child.width = width;
      }

      if (child._fillHeight) {
        height = rowsSizes[row] - topMargin - bottomMargin;
        child.height = height;
      }

      child.x = cellX + plusX + leftMargin + leftPadding + columnsSizes[column] * alignH - (child._width + leftMargin + rightMargin) * alignH;
      child.y = cellY + plusY + topMargin + topPadding + rowsSizes[row] * alignV - (child._height + topMargin + bottomMargin) * alignV;
      i++;
    }

    if (autoWidth) {
      item.width = gridWidth + columnSpacing * lastColumn + leftPadding + rightPadding;
    }

    if (autoHeight) {
      item.height = gridHeight + rowSpacing * lastRow + topPadding + bottomPadding;
    }
  };

  updateItems = function updateItems() {
    var currentQueue, item;
    pending = false;
    currentQueue = queue;
    queue = queues[++queueIndex % queues.length];

    while (currentQueue.length) {
      item = currentQueue.pop();
      item._impl.pending = false;
      item._impl.updatePending = true;
      updateItem(item);
      item._impl.updatePending = false;
    }
  };

  update = function update() {
    var data;
    data = this._impl;

    if (data.pending || !this._visible) {
      return;
    }

    data.pending = true;

    if (data.updatePending) {
      if (data.gridUpdateLoops > MAX_LOOPS) {
        return;
      }

      if (++data.gridUpdateLoops === MAX_LOOPS) {
        log.error("Potential Grid/Column/Row loop detected. Recalculating on this item (" + this.toString() + ") has been disabled.");
        return;
      }
    } else {
      data.gridUpdateLoops = 0;
    }

    queue.push(this);

    if (!pending) {
      pending = true;
      eventLoop.setImmediate(updateItems);
    }
  };

  updateSize = function updateSize() {
    if (!this._impl.updatePending) {
      update.call(this);
    }
  };

  module.exports = function (impl) {
    var disableChild, enableChild, onChildrenChange, onHeightChange, onWidthChange;

    onWidthChange = function onWidthChange(oldVal) {
      this._impl.autoWidth = impl.Renderer.sizeUtils.isAutoWidth(this);
      return updateSize.call(this);
    };

    onHeightChange = function onHeightChange(oldVal) {
      this._impl.autoHeight = impl.Renderer.sizeUtils.isAutoHeight(this);
      return updateSize.call(this);
    };

    enableChild = function enableChild(child) {
      child.onVisibleChange.connect(update, this);
      child.onWidthChange.connect(updateSize, this);
      child.onHeightChange.connect(updateSize, this);
      child.onFillWidthChange.connect(update, this);
      child.onFillHeightChange.connect(update, this);
      child.onMarginChange.connect(update, this);
      return child.onAnchorsChange.connect(update, this);
    };

    disableChild = function disableChild(child) {
      child.onVisibleChange.disconnect(update, this);
      child.onWidthChange.disconnect(updateSize, this);
      child.onHeightChange.disconnect(updateSize, this);
      child.onFillWidthChange.disconnect(update, this);
      child.onFillHeightChange.disconnect(update, this);
      child.onMarginChange.disconnect(update, this);
      return child.onAnchorsChange.disconnect(update, this);
    };

    onChildrenChange = function onChildrenChange(added, removed) {
      if (added) {
        enableChild.call(this, added);
      }

      if (removed) {
        disableChild.call(this, removed);
      }

      return update.call(this);
    };

    return {
      COLUMN: COLUMN,
      ROW: ROW,
      ALL: ALL,
      update: update,
      turnOff: function turnOff() {
        var child;
        this.onAlignmentChange.disconnect(updateSize);
        this.onPaddingChange.disconnect(updateSize);
        this.onVisibleChange.disconnect(update);
        this.onChildrenChange.disconnect(onChildrenChange);
        this.onWidthChange.disconnect(onWidthChange);
        this.onHeightChange.disconnect(onHeightChange);
        child = this.children.firstChild;

        while (child) {
          disableChild.call(this, child);
          child = child.nextSibling;
        }
      },
      turnOn: function turnOn(gridType) {
        var child;
        this._impl.gridType = gridType;
        this.onAlignmentChange.connect(updateSize);
        this.onPaddingChange.connect(updateSize);
        this.onVisibleChange.connect(update);
        this.onChildrenChange.connect(onChildrenChange);
        this.onWidthChange.connect(onWidthChange);
        this.onHeightChange.connect(onHeightChange);
        child = this.children.firstChild;

        while (child) {
          enableChild.call(this, child);
          child = child.nextSibling;
        }

        update.call(this);
      }
    };
  };
}).call(this);
},{"../../../../../../util":"xr+4","../../../../../../log":"fe8o","../../../../../../event-loop":"jt0G","../../../../../../typed-array":"wKwT"}],"YSW+":[function(require,module,exports) {
(function () {
  'use strict';

  var utils;
  utils = require('../../../../util');

  module.exports = function (impl) {
    var DATA, NOP, flowLayout, gridLayout, pointer;
    pointer = impl.pointer = require('./item/pointer')(impl);
    flowLayout = require('./item/layout/flow')(impl);
    gridLayout = require('./item/layout/grid')(impl);

    NOP = function NOP() {};

    DATA = utils.merge({
      bindings: null,
      anchors: null,
      capturePointer: 0,
      childrenCapturesPointer: 0,
      layout: null,
      loops: 0,
      pending: false,
      updatePending: false,
      gridType: 0,
      gridUpdateLoops: 0,
      autoWidth: true,
      autoHeight: true
    }, pointer.DATA);
    impl.ITEM_DATA = DATA;
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function create(data) {},
      setItemParent: function setItemParent(val) {},
      insertItemBefore: function insertItemBefore(val) {
        var child, children, i, item, len, parent, tmp;
        impl.setItemParent.call(this, null);
        this._parent = null;
        parent = val.parent;
        children = parent.children;
        tmp = [];
        child = val;

        while (child) {
          if (child !== this) {
            impl.setItemParent.call(child, null);
            child._parent = null;
            tmp.push(child);
          }

          child = child.aboveSibling;
        }

        impl.setItemParent.call(this, parent);
        this._parent = parent;

        for (i = 0, len = tmp.length; i < len; i++) {
          item = tmp[i];
          impl.setItemParent.call(item, parent);
          item._parent = parent;
        }
      },
      setItemVisible: function setItemVisible(val) {},
      setItemClip: function setItemClip(val) {},
      setItemWidth: function setItemWidth(val) {},
      setItemHeight: function setItemHeight(val) {},
      setItemX: function setItemX(val) {},
      setItemY: function setItemY(val) {},
      setItemScale: function setItemScale(val) {},
      setItemRotation: function setItemRotation(val) {},
      setItemOpacity: function setItemOpacity(val) {},
      setItemLayout: function setItemLayout(val) {
        var ref;

        if ((ref = this._impl.layout) != null) {
          ref.turnOff.call(this);
        }

        if (val === 'flow') {
          this._impl.layout = flowLayout;
          flowLayout.turnOn.call(this);
        } else if (val === 'column') {
          this._impl.layout = gridLayout;
          gridLayout.turnOn.call(this, gridLayout.COLUMN);
        } else if (val === 'row') {
          this._impl.layout = gridLayout;
          gridLayout.turnOn.call(this, gridLayout.ROW);
        } else if (val === 'grid') {
          this._impl.layout = gridLayout;
          gridLayout.turnOn.call(this, gridLayout.COLUMN | gridLayout.ROW);
        }
      },
      setItemColumnSpacing: function setItemColumnSpacing(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      setItemRowSpacing: function setItemRowSpacing(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      setItemColumns: function setItemColumns(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      setItemRows: function setItemRows(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      setItemAlignmentHorizontal: function setItemAlignmentHorizontal(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      setItemAlignmentVertical: function setItemAlignmentVertical(val) {
        var ref;
        return (ref = this._impl.layout) != null ? ref.update.call(this) : void 0;
      },
      attachItemSignal: function attachItemSignal(name, signal) {
        if (name === 'pointer') {
          return pointer.attachItemSignal.call(this, signal);
        }
      },
      setItemPointerEnabled: function setItemPointerEnabled(val) {
        return pointer.setItemPointerEnabled.call(this, val);
      },
      setItemPointerDraggable: function setItemPointerDraggable(val) {
        return pointer.setItemPointerDraggable.call(this, val);
      },
      setItemPointerDragActive: function setItemPointerDragActive(val) {
        return pointer.setItemPointerDragActive.call(this, val);
      },
      setItemKeysFocus: function setItemKeysFocus(val) {}
    };
  };
}).call(this);
},{"../../../../util":"xr+4","./item/pointer":"JghC","./item/layout/flow":"9UEq","./item/layout/grid":"uxrr"}],"+A0V":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA;
    DATA = {
      source: ''
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function create(data) {
        return impl.Types.Item.create.call(this, data);
      },
      setImageSource: function setImageSource(val) {
        return this._impl.source = val;
      }
    };
  };
}).call(this);
},{}],"yk96":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA, items;
    items = impl.items;
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function create(data) {
        return impl.Types.Item.create.call(this, data);
      },
      setText: function setText(val) {},
      setTextWrap: function setTextWrap(val) {},
      updateTextContentSize: function updateTextContentSize() {},
      setTextColor: function setTextColor(val) {},
      setTextLinkColor: function setTextLinkColor(val) {},
      setTextLineHeight: function setTextLineHeight(val) {},
      setTextFontFamily: function setTextFontFamily(val) {},
      setTextFontPixelSize: function setTextFontPixelSize(val) {},
      setTextFontWordSpacing: function setTextFontWordSpacing(val) {},
      setTextFontLetterSpacing: function setTextFontLetterSpacing(val) {},
      setTextAlignmentHorizontal: function setTextAlignmentHorizontal(val) {},
      setTextAlignmentVertical: function setTextAlignmentVertical(val) {}
    };
  };
}).call(this);
},{}],"yDry":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA, items;
    items = impl.items;
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function create(data) {
        return impl.Types.Item.create.call(this, data);
      },
      updateNativeSize: function updateNativeSize() {}
    };
  };
}).call(this);
},{}],"xuz/":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    return {
      loadFont: function loadFont(name, source, sources, callback) {}
    };
  };
}).call(this);
},{}],"mBbZ":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    return {
      initDeviceNamespace: function initDeviceNamespace() {},
      logDevice: function logDevice(msg) {
        return console.log(msg);
      },
      showDeviceKeyboard: function showDeviceKeyboard() {},
      hideDeviceKeyboard: function hideDeviceKeyboard() {}
    };
  };
}).call(this);
},{}],"ma+O":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    return {
      initScreenNamespace: function initScreenNamespace() {},
      setScreenStatusBarColor: function setScreenStatusBarColor(val) {}
    };
  };
}).call(this);
},{}],"0Y+d":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    return {
      initNavigatorNamespace: function initNavigatorNamespace() {}
    };
  };
}).call(this);
},{}],"Ceg+":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA, NOP, getRectangleSource, items, round, updateImage, updateImageIfNeeded;
    items = impl.items;
    round = Math.round;

    NOP = function NOP() {};

    getRectangleSource = function getRectangleSource(item) {
      var borderColor, color, data, height, pixelRatio, radius, strokeWidth, width;
      data = item._impl;
      pixelRatio = impl.pixelRatio;

      if (item.width <= 0 || item.height <= 0) {
        data.isRectVisible = false;
        return null;
      } else {
        data.isRectVisible = true;
      }

      width = round(item.width * pixelRatio);
      height = round(item.height * pixelRatio);
      radius = round(item.radius * pixelRatio);
      strokeWidth = round(Math.min(item.border.width * 2 * pixelRatio, width, height));
      color = data.color;
      borderColor = data.borderColor;
      return "data:image/svg+xml;utf8," + ("<svg width='" + width + "' height='" + height + "' xmlns='http://www.w3.org/2000/svg'>") + "<clipPath id='clip'>" + "<rect " + ("rx='" + radius + "' ") + ("width='" + width + "' height='" + height + "' />") + "</clipPath>" + "<rect " + "clip-path='url(#clip)' " + ("fill='" + color + "' ") + ("stroke='" + borderColor + "' ") + ("stroke-width='" + strokeWidth + "' ") + ("rx='" + radius + "' ") + ("width='" + width + "' height='" + height + "' />") + "</svg>";
    };

    updateImage = function updateImage() {
      impl.setImageSource.call(this, getRectangleSource(this), NOP);
    };

    updateImageIfNeeded = function updateImageIfNeeded() {
      if (!this._impl.isRectVisible || this.radius > 0 || this.border.width > 0) {
        updateImage.call(this);
      }
    };

    DATA = {
      color: 'transparent',
      borderColor: 'transparent',
      isRectVisible: false
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Image', DATA),
      create: function create(data) {
        impl.Types.Image.create.call(this, data);
        this.onWidthChange.connect(updateImageIfNeeded);
        return this.onHeightChange.connect(updateImageIfNeeded);
      },
      setRectangleColor: function setRectangleColor(val) {
        this._impl.color = val;
        return updateImage.call(this);
      },
      setRectangleRadius: updateImage,
      setRectangleBorderColor: function setRectangleBorderColor(val) {
        this._impl.borderColor = val;
        return updateImage.call(this);
      },
      setRectangleBorderWidth: updateImage
    };
  };
}).call(this);
},{}],"u1pG":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA;
    DATA = {
      bindings: null,
      reversed: false
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function create(data) {},
      setAnimationLoop: function setAnimationLoop(val) {},
      setAnimationReversed: function setAnimationReversed(val) {
        this._impl.reversed = val;
      },
      startAnimation: function startAnimation() {},
      stopAnimation: function stopAnimation() {},
      resumeAnimation: function resumeAnimation() {},
      pauseAnimation: function pauseAnimation() {}
    };
  };
}).call(this);
},{}],"7GKH":[function(require,module,exports) {
(function () {
  'use strict';

  module.exports = function (impl) {
    var DATA, EASINGS, Types, items;
    Types = impl.Types, items = impl.items;
    EASINGS = {
      Linear: function Linear(t, b, c, d) {
        return c * (t / d) + b;
      },
      InQuad: function InQuad(t, b, c, d) {
        return c * (t /= d) * t + b;
      },
      OutQuad: function OutQuad(t, b, c, d) {
        return -c * (t /= d) * (t - 2) + b;
      },
      InOutQuad: function InOutQuad(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t + b;
        } else {
          return -c / 2 * (--t * (t - 2) - 1) + b;
        }
      },
      InCubic: function InCubic(t, b, c, d) {
        return c * (t /= d) * t * t + b;
      },
      OutCubic: function OutCubic(t, b, c, d) {
        return c * ((t = t / d - 1) * t * t + 1) + b;
      },
      InOutCubic: function InOutCubic(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t + b;
        } else {
          return c / 2 * ((t -= 2) * t * t + 2) + b;
        }
      },
      InQuart: function InQuart(t, b, c, d) {
        return c * (t /= d) * t * t * t + b;
      },
      OutQuart: function OutQuart(t, b, c, d) {
        return -c * ((t = t / d - 1) * t * t * t - 1) + b;
      },
      InOutQuart: function InOutQuart(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t * t + b;
        } else {
          return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
        }
      },
      InQuint: function InQuint(t, b, c, d) {
        return c * (t /= d) * t * t * t * t + b;
      },
      OutQuint: function OutQuint(t, b, c, d) {
        return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
      },
      InOutQuint: function InOutQuint(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t * t * t + b;
        } else {
          return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
        }
      },
      InSine: function InSine(t, b, c, d) {
        return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
      },
      OutSine: function OutSine(t, b, c, d) {
        return c * Math.sin(t / d * (Math.PI / 2)) + b;
      },
      InOutSine: function InOutSine(t, b, c, d) {
        return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
      },
      InExpo: function InExpo(t, b, c, d) {
        if (t === 0) {
          return b;
        } else {
          return c * Math.pow(2, 10 * (t / d - 1)) + b;
        }
      },
      OutExpo: function OutExpo(t, b, c, d) {
        if (t === d) {
          return b + c;
        } else {
          return c * (-Math.pow(2, -10 * t / d) + 1) + b;
        }
      },
      InOutExpo: function InOutExpo(t, b, c, d) {
        if (t === 0) {
          return b;
        } else if (t === d) {
          return b + c;
        } else if ((t /= d / 2) < 1) {
          return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
        } else {
          return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;
        }
      },
      InCirc: function InCirc(t, b, c, d) {
        return -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b;
      },
      OutCirc: function OutCirc(t, b, c, d) {
        return c * Math.sqrt(1 - (t = t / d - 1) * t) + b;
      },
      InOutCirc: function InOutCirc(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
        } else {
          return c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b;
        }
      },
      InElastic: function InElastic(t, b, c, d) {
        var a, p, s;
        s = 1.70158;
        p = 0;
        a = c;

        if (t === 0) {
          return b;
        } else if ((t /= d) === 1) {
          return b + c;
        } else {
          p || (p = d * .3);

          if (a < Math.abs(c)) {
            a = c;
            s = p / 4;
          } else {
            s = p / (2 * Math.PI) * Math.asin(c / a);
          }

          return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
        }
      },
      OutElastic: function OutElastic(t, b, c, d) {
        var a, p, s;
        s = 1.70158;
        p = 0;
        a = c;

        if (t === 0) {
          return b;
        } else if ((t /= d) === 1) {
          return b + c;
        } else {
          p || (p = d * .3);

          if (a < Math.abs(c)) {
            a = c;
            s = p / 4;
          } else {
            s = p / (2 * Math.PI) * Math.asin(c / a);
          }

          return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b;
        }
      },
      InOutElastic: function InOutElastic(t, b, c, d) {
        var a, p, s;
        s = 1.70158;
        p = 0;
        a = c;

        if (t === 0) {
          return b;
        } else if ((t /= d / 2) === 2) {
          return b + c;
        } else {
          p || (p = d * (.3 * 1.5));

          if (a < Math.abs(c)) {
            a = c;
            s = p / 4;
          } else {
            s = p / (2 * Math.PI) * Math.asin(c / a);
          }

          if (t < 1) {
            return -.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
          } else {
            return a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * .5 + c + b;
          }
        }
      },
      InBack: function InBack(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }

        return c * (t /= d) * t * ((s + 1) * t - s) + b;
      },
      OutBack: function OutBack(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }

        return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
      },
      InOutBack: function InOutBack(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }

        if ((t /= d / 2) < 1) {
          return c / 2 * (t * t * (((s *= 1.525) + 1) * t - s)) + b;
        } else {
          return c / 2 * ((t -= 2) * t * (((s *= 1.525) + 1) * t + s) + 2) + b;
        }
      },
      InBounce: function InBounce(t, b, c, d) {
        return c - EASINGS.OutBounce(d - t, 0, c, d) + b;
      },
      OutBounce: function OutBounce(t, b, c, d) {
        if ((t /= d) < 1 / 2.75) {
          return c * (7.5625 * t * t) + b;
        } else if (t < 2 / 2.75) {
          return c * (7.5625 * (t -= 1.5 / 2.75) * t + .75) + b;
        } else if (t < 2.5 / 2.75) {
          return c * (7.5625 * (t -= 2.25 / 2.75) * t + .9375) + b;
        } else {
          return c * (7.5625 * (t -= 2.625 / 2.75) * t + .984375) + b;
        }
      },
      InOutBounce: function InOutBounce(t, b, c, d) {
        if (t < d / 2) {
          return EASINGS.InBounce(t * 2, 0, c, d) * .5 + b;
        } else {
          return EASINGS.OutBounce(t * 2 - d, 0, c, d) * .5 + c * .5 + b;
        }
      },
      Steps: function Steps(t, b, c, d) {
        return c * Math.floor(t / d * this.steps) / (this.steps - 1) + b;
      }
    };
    DATA = {
      progress: 0,
      propertySetter: null,
      isIntegerProperty: false,
      easing: null,
      steps: 1,
      startDelay: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Animation', DATA),
      create: function create(data) {
        data.easing = EASINGS.Linear;
        return impl.Types.Animation.create.call(this, data);
      },
      setPropertyAnimationTarget: function setPropertyAnimationTarget(val) {},
      setPropertyAnimationProperty: function setPropertyAnimationProperty(val) {
        this._impl.propertySetter = impl.utils.SETTER_METHODS_NAMES[val];
        this._impl.isIntegerProperty = !!impl.utils.INTEGER_PROPERTIES[val];
      },
      setPropertyAnimationDuration: function setPropertyAnimationDuration(val) {},
      setPropertyAnimationStartDelay: function setPropertyAnimationStartDelay(val) {
        this._impl.startTime += val - this._impl.startDelay;
        return this._impl.startDelay = val;
      },
      setPropertyAnimationLoopDelay: function setPropertyAnimationLoopDelay(val) {},
      setPropertyAnimationFrom: function setPropertyAnimationFrom(val) {
        return this._impl.from = val;
      },
      setPropertyAnimationTo: function setPropertyAnimationTo(val) {
        return this._impl.to = val;
      },
      setPropertyAnimationUpdateProperty: function setPropertyAnimationUpdateProperty(val) {},
      setPropertyAnimationEasingType: function setPropertyAnimationEasingType(val) {
        return this._impl.easing = EASINGS[val] || EASINGS.Linear;
      },
      setPropertyAnimationEasingSteps: function setPropertyAnimationEasingSteps(val) {
        return this._impl.steps = val;
      },
      getPropertyAnimationProgress: function getPropertyAnimationProgress() {
        return this._impl.progress;
      }
    };
  };
}).call(this);
},{}],"ABfx":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, eventLoop, utils;
  utils = require('../../../../../util');
  assert = require('../../../../../assert');
  eventLoop = require('../../../../../event-loop');

  module.exports = function (impl) {
    var DATA, Renderer, Types, addAnimationIntoPending, now, nowTime, pending, round, updateAnimation, _vsync;

    Types = impl.Types, Renderer = impl.Renderer;
    now = Date.now;
    round = Math.round;
    pending = [];
    nowTime = now();

    _vsync = function vsync() {
      var anim, i, n;
      nowTime = now();
      eventLoop.lock();
      i = 0;
      n = pending.length;

      while (i < n) {
        anim = pending[i];

        if (anim._running && !anim._paused) {
          updateAnimation(anim, Renderer.PropertyAnimation.ON_PENDING);
          i++;
        } else {
          pending.splice(i, 1);
          anim._impl.pending = false;
          n--;
        }
      }

      if (pending.length > 0) {
        requestAnimationFrame(_vsync);
      }

      eventLoop.release();
    };

    updateAnimation = function updateAnimation(anim, stateFlags) {
      var data, fromVal, progress, property, running, target, toVal, val;
      data = anim._impl;
      progress = (nowTime - data.startTime) / anim._duration;

      if (progress < 0) {
        progress = 0;
      } else if (progress > 1) {
        progress = 1;
      }

      data.progress = progress;
      running = progress !== 1 || anim._running && anim._loop;
      fromVal = data.reversed ? data.to : data.from;
      toVal = data.reversed ? data.from : data.to;

      if (progress === 1) {
        val = toVal;
      } else {
        val = data.easing(anim._duration * progress, fromVal, toVal - fromVal, anim._duration);
      }

      target = anim._target;
      property = anim._property;

      if (!running) {
        stateFlags |= Renderer.PropertyAnimation.ON_STOP;
      }

      if (val === val && target && property) {
        if ((anim._updateProperty & stateFlags) > 0 || !data.propertySetter) {
          anim._updatePending = true;
          target[property] = val;
          anim._updatePending = false;
        } else {
          impl[data.propertySetter].call(target, val);
        }
      }

      if (progress === 1) {
        if (running) {
          data.startTime += anim._loopDelay + anim._duration;
        } else {
          data.startTime = 0;
          anim.running = false;
        }
      }
    };

    addAnimationIntoPending = function addAnimationIntoPending(anim) {
      var data;
      data = anim._impl;

      if (!data.pending) {
        if (pending.length === 0) {
          requestAnimationFrame(_vsync);
        }

        pending.push(anim);
        data.pending = true;
      }
    };

    DATA = {
      type: 'number',
      pending: false,
      startTime: 0,
      pauseTime: 0,
      from: 0,
      to: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('PropertyAnimation', DATA),
      create: function create(data) {
        return impl.Types.PropertyAnimation.create.call(this, data);
      },
      startAnimation: function (_super) {
        return function () {
          var data;

          _super.call(this);

          if (this._impl.type === 'number') {
            data = this._impl;
            data.from = this._from;
            data.to = this._to;
            addAnimationIntoPending(this);
            data.startTime = now();
            updateAnimation(this, Renderer.PropertyAnimation.ON_START);
            data.startTime += this._startDelay;
          }
        };
      }(impl.startAnimation),
      stopAnimation: function (_super) {
        return function () {
          var data;

          _super.call(this);

          data = this._impl;

          if (data.type === 'number' && data.startTime !== 0) {
            updateAnimation(this, Renderer.PropertyAnimation.ON_STOP);
            data.startTime = 0;
          }
        };
      }(impl.stopAnimation),
      resumeAnimation: function (_super) {
        return function () {
          var data;

          _super.call(this);

          if (this._impl.type === 'number') {
            data = this._impl;
            addAnimationIntoPending(this);
            data.startTime += Date.now() - data.pauseTime;
            data.pauseTime = 0;
          }
        };
      }(impl.resumeAnimation),
      pauseAnimation: function (_super) {
        return function () {
          var data;

          _super.call(this);

          data = this._impl;

          if (data.type === 'number') {
            data.pauseTime = Date.now();
          }
        };
      }(impl.pauseAnimation)
    };
  };
}).call(this);
},{"../../../../../util":"xr+4","../../../../../assert":"lQvG","../../../../../event-loop":"jt0G"}],"JLX2":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _get(target, property, receiver) { if (typeof Reflect !== "undefined" && Reflect.get) { _get = Reflect.get; } else { _get = function _get(target, property, receiver) { var base = _superPropBase(target, property); if (!base) return; var desc = Object.getOwnPropertyDescriptor(base, property); if (desc.get) { return desc.get.call(receiver); } return desc.value; }; } return _get(target, property, receiver || target); }

function _superPropBase(object, property) { while (!Object.prototype.hasOwnProperty.call(object, property)) { object = _getPrototypeOf(object); if (object === null) break; } return object; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _wrapNativeSuper(Class) { var _cache = typeof Map === "function" ? new Map() : undefined; _wrapNativeSuper = function _wrapNativeSuper(Class) { if (Class === null || !_isNativeFunction(Class)) return Class; if (typeof Class !== "function") { throw new TypeError("Super expression must either be null or a function"); } if (typeof _cache !== "undefined") { if (_cache.has(Class)) return _cache.get(Class); _cache.set(Class, Wrapper); } function Wrapper() { return _construct(Class, arguments, _getPrototypeOf(this).constructor); } Wrapper.prototype = Object.create(Class.prototype, { constructor: { value: Wrapper, enumerable: false, writable: true, configurable: true } }); return _setPrototypeOf(Wrapper, Class); }; return _wrapNativeSuper(Class); }

function isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Date.prototype.toString.call(Reflect.construct(Date, [], function () {})); return true; } catch (e) { return false; } }

function _construct(Parent, args, Class) { if (isNativeReflectConstruct()) { _construct = Reflect.construct; } else { _construct = function _construct(Parent, args, Class) { var a = [null]; a.push.apply(a, args); var Constructor = Function.bind.apply(Parent, a); var instance = new Constructor(); if (Class) _setPrototypeOf(instance, Class.prototype); return instance; }; } return _construct.apply(null, arguments); }

function _isNativeFunction(fn) { return Function.toString.call(fn).indexOf("[native code]") !== -1; }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var _require = require('../signal'),
    SignalDispatcher = _require.SignalDispatcher;

var ObservableArray =
/*#__PURE__*/
function (_Array) {
  _inherits(ObservableArray, _Array);

  function ObservableArray() {
    var _getPrototypeOf2;

    var _this;

    _classCallCheck(this, ObservableArray);

    for (var _len = arguments.length, elements = new Array(_len), _key = 0; _key < _len; _key++) {
      elements[_key] = arguments[_key];
    }

    _this = _possibleConstructorReturn(this, (_getPrototypeOf2 = _getPrototypeOf(ObservableArray)).call.apply(_getPrototypeOf2, [this].concat(elements)));
    _this.onPush = new SignalDispatcher();
    _this.onPop = new SignalDispatcher();
    return _this;
  }

  _createClass(ObservableArray, [{
    key: "push",
    value: function push() {
      var _get2,
          _this2 = this;

      for (var _len2 = arguments.length, elements = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
        elements[_key2] = arguments[_key2];
      }

      var result = (_get2 = _get(_getPrototypeOf(ObservableArray.prototype), "push", this)).call.apply(_get2, [this].concat(elements));

      elements.forEach(function (element, index) {
        _this2.onPush.emit(element, _this2.length - elements.length + index);
      });
      return result;
    }
  }, {
    key: "pop",
    value: function pop() {
      if (this.length === 0) return _get(_getPrototypeOf(ObservableArray.prototype), "pop", this).call(this);

      var result = _get(_getPrototypeOf(ObservableArray.prototype), "pop", this).call(this);

      this.onPop.emit(result, this.length);
      return result;
    }
  }, {
    key: "shift",
    value: function shift() {
      if (this.length === 0) return _get(_getPrototypeOf(ObservableArray.prototype), "shift", this).call(this);

      var result = _get(_getPrototypeOf(ObservableArray.prototype), "shift", this).call(this);

      this.onPop.emit(result, 0);
      return result;
    }
  }, {
    key: "unshift",
    value: function unshift() {
      var _get3,
          _this3 = this;

      for (var _len3 = arguments.length, elements = new Array(_len3), _key3 = 0; _key3 < _len3; _key3++) {
        elements[_key3] = arguments[_key3];
      }

      var result = (_get3 = _get(_getPrototypeOf(ObservableArray.prototype), "unshift", this)).call.apply(_get3, [this].concat(elements));

      elements.forEach(function (element, index) {
        _this3.onPush.emit(element, index);
      });
      return result;
    }
  }, {
    key: "splice",
    value: function splice(start, deleteCount) {
      var _get4,
          _this4 = this;

      var popped = this.slice(start, start + deleteCount);

      for (var _len4 = arguments.length, elements = new Array(_len4 > 2 ? _len4 - 2 : 0), _key4 = 2; _key4 < _len4; _key4++) {
        elements[_key4 - 2] = arguments[_key4];
      }

      var result = (_get4 = _get(_getPrototypeOf(ObservableArray.prototype), "splice", this)).call.apply(_get4, [this, start, deleteCount].concat(elements));

      popped.forEach(function (element, index) {
        _this4.onPop.emit(element, start + index);
      });
      elements.forEach(function (element, index) {
        _this4.onPush.emit(element, start + index);
      });
      return result;
    }
  }, {
    key: "reverse",
    value: function reverse() {
      var _this5 = this;

      this.forEach(function (element, index) {
        _this5.onPop.emit(element, index);
      });

      var result = _get(_getPrototypeOf(ObservableArray.prototype), "reverse", this).call(this);

      this.forEach(function (element, index) {
        _this5.onPush.emit(element, index);
      });
      return result;
    }
  }, {
    key: "sort",
    value: function sort(compareFunction) {
      var _this6 = this;

      this.forEach(function (element, index) {
        _this6.onPop.emit(element, index);
      });

      var result = _get(_getPrototypeOf(ObservableArray.prototype), "sort", this).call(this, compareFunction);

      this.forEach(function (element, index) {
        _this6.onPush.emit(element, index);
      });
      return result;
    }
  }]);

  return ObservableArray;
}(_wrapNativeSuper(Array));

module.exports = ObservableArray;
},{"../signal":"WtLN"}],"fqjs":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var Binding, Connection, MAX_LOOPS, ObservableArray, assert, getPropHandlerName, isArray, log, util;
  util = require('../util');
  log = require('../log');
  assert = require('../assert');
  ObservableArray = require('../observable-array');
  log = log.scope('Binding');
  isArray = Array.isArray;
  MAX_LOOPS = 50;

  getPropHandlerName = function () {
    var cache, toHandlerName;
    cache = Object.create(null);

    toHandlerName = function toHandlerName(prop) {
      if (prop[0] === '$') {
        prop = "$" + util.capitalize(prop.slice(1));
      } else {
        prop = util.capitalize(prop);
      }

      return "on" + prop + "Change";
    };

    return function (prop) {
      return cache[prop] || (cache[prop] = toHandlerName(prop));
    };
  }();

  Connection = function () {
    var pool;
    pool = [];

    Connection.factory = function (binding, item, prop, parent) {
      var elem;

      if (parent == null) {
        parent = null;
      }

      if (pool.length > 0 && (elem = pool.pop())) {
        Connection.call(elem, binding, item, prop, parent);
        return elem;
      } else {
        return new Connection(binding, item, prop, parent);
      }
    };

    function Connection(binding1, item, prop1, parent1) {
      this.binding = binding1;
      this.prop = prop1;
      this.parent = parent1;
      this.handlerName = getPropHandlerName(this.prop);
      this.isConnected = false;

      if (isArray(item)) {
        this.itemId = '';
        this.child = Connection.factory(this.binding, item[0], item[1], this);
        this.item = this.child.getValue();
      } else {
        this.itemId = item;
        this.child = null;
        this.item = this.binding.getItemById(item);
      }

      this.connect();
      Object.seal(this);
    }

    Connection.prototype.getSignalChangeListener = function () {
      var noParent, withParent;

      withParent = function withParent(prop, val) {
        if (val === void 0 || typeof prop !== 'string' || this.parent.prop === prop) {
          this.parent.updateItem();
        }
      };

      noParent = function noParent() {
        this.binding.update();
      };

      return function () {
        if (this.parent) {
          return withParent;
        } else {
          return noParent;
        }
      };
    }();

    Connection.prototype.update = function () {
      return this.getSignalChangeListener().call(this);
    };

    Connection.prototype.connect = function () {
      var handler, item;
      item = this.item;

      if (item) {
        if (item instanceof ObservableArray) {
          this.isConnected = true;
          handler = this.getSignalChangeListener();
          item.onPush.connect(handler, this);
          item.onPop.connect(handler, this);
        } else if (handler = item[this.handlerName]) {
          this.isConnected = true;
          handler.connect(this.getSignalChangeListener(), this);
        }
      }
    };

    Connection.prototype.disconnect = function () {
      var handler, item;
      item = this.item;

      if (item && this.isConnected) {
        handler = this.getSignalChangeListener();

        if (item instanceof ObservableArray) {
          item.onPush.disconnect(handler, this);
          item.onPop.disconnect(handler, this);
        } else {
          item[this.handlerName].disconnect(handler, this);
        }
      }

      this.isConnected = false;
    };

    Connection.prototype.updateItem = function () {
      var oldVal, val;
      oldVal = this.item;

      if (this.child) {
        val = this.child.getValue();
      } else {
        val = this.binding.getItemById(this.itemId);
      }

      if (oldVal && !this.isConnected) {
        this.connect();
        oldVal = null;
      }

      if (oldVal !== val) {
        this.disconnect();
        this.item = val;
        this.connect();

        if (!this.parent) {
          this.binding.update();
        }
      }

      if (this.parent) {
        this.parent.updateItem();
      }
    };

    Connection.prototype.getValue = function () {
      if (this.item) {
        return this.item[this.prop];
      } else {
        return null;
      }
    };

    Connection.prototype.destroy = function () {
      var ref;
      this.disconnect();

      if ((ref = this.child) != null) {
        ref.destroy();
      }

      pool.push(this);
    };

    return Connection;
  }();

  module.exports = Binding = function () {
    Binding.New = function (binding, ctx, target) {
      var connections, elem, i, len, ref;

      if (target == null) {
        target = new Binding(binding, ctx);
      }

      Object.seal(target);
      connections = target.connections;
      ref = binding[1];

      for (i = 0, len = ref.length; i < len; i++) {
        elem = ref[i];

        if (isArray(elem)) {
          connections.push(Connection.factory(target, elem[0], elem[1]));
        }
      }

      return target;
    };

    function Binding(binding, ctx1) {
      this.ctx = ctx1;
      assert.lengthOf(binding, 2);
      assert.isFunction(binding[0]);
      assert.isArray(binding[1]);
      this.func = binding[0];
      this.args = null;
      this.connections || (this.connections = []); //<development>;

      this.updatePending = false;
      this.updateLoop = 0; //</development>;
    }

    Binding.prototype.getItemById = function (item) {
      throw new Error("Not implemented");
    };

    Binding.prototype.getValue = function () {
      throw new Error("Not implemented");
    };

    Binding.prototype.getDefaultValue = function () {
      switch (_typeof(this.getValue())) {
        case 'string':
          return '';

        case 'number':
          return 0;

        case 'boolean':
          return false;

        default:
          return null;
      }
    };

    Binding.prototype.setValue = function (val) {
      throw new Error("Not implemented");
    };

    Binding.prototype.onError = function (err) {};

    Binding.prototype.update = function () {
      null; //<development>;

      var result;

      if (this.updatePending) {
        if (this.updateLoop > MAX_LOOPS) {
          return;
        }

        if (++this.updateLoop === MAX_LOOPS) {
          log.error(this.getLoopDetectedErrorMessage());
          return;
        }
      } else {
        this.updateLoop = 0;
      } //</development>;


      result = util.tryFunction(this.func, this.ctx, this.args);

      if (result instanceof Error) {
        this.onError(result);
        result = this.getDefaultValue();
      } //<development>;


      this.updatePending = true; //</development>;

      this.setValue(result); //<development>;

      this.updatePending = false; //</development>;
    };

    Binding.prototype.getLoopDetectedErrorMessage = function () {
      return "Potential loop detected";
    };

    Binding.prototype.destroy = function () {
      var connection;

      while (connection = this.connections.pop()) {
        connection.destroy();
      }

      this.args = null;
    };

    return Binding;
  }();
}).call(this);
},{"../util":"xr+4","../log":"fe8o","../assert":"lQvG","../observable-array":"JLX2"}],"g1G0":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

(function () {
  'use strict';

  var Binding,
      eventLoop,
      log,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  log = require('../../../../log');
  eventLoop = require('../../../../event-loop');
  Binding = require('../../../../binding');

  module.exports = function (impl) {
    var RendererBinding;

    RendererBinding = function (superClass) {
      var pool;
      extend(RendererBinding, superClass);
      pool = [];

      RendererBinding.factory = function (obj, prop, binding, ctx) {
        var elem;

        if (elem = pool.pop()) {
          RendererBinding.call(elem, obj, prop, binding, ctx);
        }

        return RendererBinding.New(obj, prop, binding, ctx, elem);
      };

      RendererBinding.New = function (obj, prop, binding, ctx, target) {
        if (target == null) {
          target = new RendererBinding(obj, prop, binding, ctx);
        }

        eventLoop.setImmediate(function () {
          Binding.New(binding, ctx, target);
          return target.update();
        });
        return target;
      };

      function RendererBinding(obj1, prop1, binding, ctx) {
        this.obj = obj1;
        this.prop = prop1;

        RendererBinding.__super__.constructor.call(this, binding, ctx);
      }

      RendererBinding.prototype.getItemById = function (item) {
        if (_typeof(item) === 'object') {
          return item;
        } else if (item === 'this') {
          return this.ctx;
        } else if (item === 'windowItem') {
          return impl.windowItem;
        } else {
          return impl.Renderer[item] || null;
        }
      };

      RendererBinding.prototype.update = function () {
        eventLoop.lock();

        RendererBinding.__super__.update.call(this);

        eventLoop.release();
      };

      RendererBinding.prototype.getValue = function () {
        return this.obj[this.prop];
      };

      RendererBinding.prototype.setValue = function (val) {
        if (val == null || val !== val) {
          val = this.getDefaultValue();
        }

        this.obj[this.prop] = val;
      };

      RendererBinding.prototype.getLoopDetectedErrorMessage = function () {
        return "Potential loop detected. Property binding `" + this.prop + "` on `" + this.ctx + "` has been disabled.";
      }; //<development>;


      RendererBinding.prototype.onError = function (err) {
        var shouldPrint;

        if (this.obj.running !== void 0) {
          shouldPrint = this.obj.running !== false;
        } else if (this.obj.parent !== void 0) {
          shouldPrint = this.obj.parent !== null;
        } else {
          shouldPrint = true;
        }

        if (shouldPrint) {
          log.error("Failed property `" + this.prop + "` binding in style `" + this.ctx + "`: `" + err + "`");
        }
      }; //</development>;


      RendererBinding.prototype.destroy = function () {
        this.obj._impl.bindings[this.prop] = null;

        RendererBinding.__super__.destroy.call(this);

        pool.push(this);
      };

      return RendererBinding;
    }(Binding);

    return {
      setItemBinding: function setItemBinding(prop, binding, ctx) {
        var data, ref;
        data = this._impl;

        if (data.bindings == null) {
          data.bindings = {};
        }

        if ((ref = data.bindings[prop]) != null) {
          ref.destroy();
        }

        if (binding != null) {
          data.bindings[prop] = RendererBinding.factory(this, prop, binding, ctx);
        }
      }
    };
  };
}).call(this);
},{"../../../../log":"fe8o","../../../../event-loop":"jt0G","../../../../binding":"fqjs"}],"VWzf":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, eventLoop, isArray, log, utils;
  assert = require('../../../../assert');
  log = require('../../../../log');
  utils = require('../../../../util');
  eventLoop = require('../../../../event-loop');
  log = log.scope('Renderer', 'Anchors');
  isArray = Array.isArray;

  module.exports = function (impl) {
    var Anchor, GET_ZERO, MAX_LOOPS, MultiAnchor, createAnchor, exports, getBaseAnchors, getBaseAnchorsPerAnchorType, getItemProp, getMarginValue, getSourceValue, getSourceWatchProps, getTargetValue, getTargetWatchProps, isMultiAnchor, onChildInsert, onChildPop, onChildrenChange, onNextSiblingChange, onParentChange, onPreviousSiblingChange, pending, queue, queueIndex, queues, update, updateItems;

    GET_ZERO = function GET_ZERO() {
      return 0;
    };

    MAX_LOOPS = 10;
    queueIndex = 0;
    queues = [[], []];
    queue = queues[queueIndex];
    pending = false;

    updateItems = function updateItems() {
      var anchor, currentQueue;
      pending = false;
      currentQueue = queue;
      queue = queues[++queueIndex % queues.length];

      while (currentQueue.length) {
        anchor = currentQueue.pop();
        anchor.pending = false;
        anchor.update();
      }
    };

    update = function update() {
      if (this.pending) {
        return;
      }

      this.pending = true;
      queue.push(this);

      if (!pending) {
        pending = true;
        eventLoop.setImmediate(updateItems);
      }
    };

    getItemProp = {
      left: 'x',
      top: 'y',
      right: 'x',
      bottom: 'y',
      horizontalCenter: 'x',
      verticalCenter: 'y',
      fillWidthSize: 'width',
      fillHeightSize: 'height'
    };
    getSourceWatchProps = {
      left: ['onMarginChange'],
      top: ['onMarginChange'],
      right: ['onMarginChange', 'onWidthChange'],
      bottom: ['onMarginChange', 'onHeightChange'],
      horizontalCenter: ['onMarginChange', 'onWidthChange'],
      verticalCenter: ['onMarginChange', 'onHeightChange'],
      fillWidthSize: ['onMarginChange'],
      fillHeightSize: ['onMarginChange']
    };
    getTargetWatchProps = {
      left: {
        parent: [],
        children: [],
        sibling: ['onXChange']
      },
      top: {
        parent: [],
        children: [],
        sibling: ['onYChange']
      },
      right: {
        parent: ['onWidthChange'],
        sibling: ['onXChange', 'onWidthChange']
      },
      bottom: {
        parent: ['onHeightChange'],
        sibling: ['onYChange', 'onHeightChange']
      },
      horizontalCenter: {
        parent: ['onWidthChange'],
        sibling: ['onXChange', 'onWidthChange']
      },
      verticalCenter: {
        parent: ['onHeightChange'],
        sibling: ['onYChange', 'onHeightChange']
      },
      fillWidthSize: {
        parent: ['onWidthChange'],
        children: [],
        sibling: ['onWidthChange']
      },
      fillHeightSize: {
        parent: ['onHeightChange'],
        children: [],
        sibling: ['onHeightChange']
      }
    };
    getSourceValue = {
      left: function left(item) {
        return 0;
      },
      top: function top(item) {
        return 0;
      },
      right: function right(item) {
        return -item._width;
      },
      bottom: function bottom(item) {
        return -item._height;
      },
      horizontalCenter: function horizontalCenter(item) {
        return -item._width / 2;
      },
      verticalCenter: function verticalCenter(item) {
        return -item._height / 2;
      },
      fillWidthSize: function fillWidthSize(item) {
        return 0;
      },
      fillHeightSize: function fillHeightSize(item) {
        return 0;
      }
    };
    getTargetValue = {
      left: {
        parent: function parent(target) {
          return 0;
        },
        children: function children(target) {
          return 0;
        },
        sibling: function sibling(target) {
          return target._x;
        }
      },
      top: {
        parent: function parent(target) {
          return 0;
        },
        children: function children(target) {
          return 0;
        },
        sibling: function sibling(target) {
          return target._y;
        }
      },
      right: {
        parent: function parent(target) {
          return target._width;
        },
        sibling: function sibling(target) {
          return target._x + target._width;
        }
      },
      bottom: {
        parent: function parent(target) {
          return target._height;
        },
        sibling: function sibling(target) {
          return target._y + target._height;
        }
      },
      horizontalCenter: {
        parent: function parent(target) {
          return target._width / 2;
        },
        sibling: function sibling(target) {
          return target._x + target._width / 2;
        }
      },
      verticalCenter: {
        parent: function parent(target) {
          return target._height / 2;
        },
        sibling: function sibling(target) {
          return target._y + target._height / 2;
        }
      },
      fillWidthSize: {
        parent: function parent(target) {
          return target._width;
        },
        children: function children(target) {
          var child, size, tmp;
          tmp = 0;
          size = 0;
          child = target.firstChild;

          while (child) {
            if (child._visible) {
              tmp = child._x + child._width;

              if (tmp > size) {
                size = tmp;
              }
            }

            child = child.nextSibling;
          }

          return size;
        },
        sibling: function sibling(target) {
          return target._width;
        }
      },
      fillHeightSize: {
        parent: function parent(target) {
          return target._height;
        },
        children: function children(target) {
          var child, size, tmp;
          tmp = 0;
          size = 0;
          child = target.firstChild;

          while (child) {
            if (child._visible) {
              tmp = child._y + child._height;

              if (tmp > size) {
                size = tmp;
              }
            }

            child = child.nextSibling;
          }

          return size;
        },
        sibling: function sibling(target) {
          return target._height;
        }
      }
    };
    getMarginValue = {
      left: function left(margin) {
        return margin._left;
      },
      top: function top(margin) {
        return margin._top;
      },
      right: function right(margin) {
        return -margin._right;
      },
      bottom: function bottom(margin) {
        return -margin._bottom;
      },
      horizontalCenter: function horizontalCenter(margin) {
        return margin._left - margin._right;
      },
      verticalCenter: function verticalCenter(margin) {
        return margin._top - margin._bottom;
      },
      fillWidthSize: function fillWidthSize(margin) {
        return -margin._left - margin._right;
      },
      fillHeightSize: function fillHeightSize(margin) {
        return -margin._top - margin._bottom;
      }
    };

    onParentChange = function onParentChange(oldVal) {
      var handler, i, j, len, len1, ref, ref1, val;

      if (oldVal) {
        ref = getTargetWatchProps[this.line].parent;

        for (i = 0, len = ref.length; i < len; i++) {
          handler = ref[i];
          oldVal[handler].disconnect(update, this);
        }
      }

      if (val = this.targetItem = this.item._parent) {
        ref1 = getTargetWatchProps[this.line].parent;

        for (j = 0, len1 = ref1.length; j < len1; j++) {
          handler = ref1[j];
          val[handler].connect(update, this);
        }
      }

      update.call(this);
    };

    onNextSiblingChange = function onNextSiblingChange(oldVal) {
      var handler, i, j, len, len1, ref, ref1, val;

      if (oldVal) {
        ref = getTargetWatchProps[this.line].sibling;

        for (i = 0, len = ref.length; i < len; i++) {
          handler = ref[i];
          oldVal[handler].disconnect(update, this);
        }
      }

      if (val = this.targetItem = this.item._nextSibling) {
        ref1 = getTargetWatchProps[this.line].sibling;

        for (j = 0, len1 = ref1.length; j < len1; j++) {
          handler = ref1[j];
          val[handler].connect(update, this);
        }
      }

      update.call(this);
    };

    onPreviousSiblingChange = function onPreviousSiblingChange(oldVal) {
      var handler, i, j, len, len1, ref, ref1, val;

      if (oldVal) {
        ref = getTargetWatchProps[this.line].sibling;

        for (i = 0, len = ref.length; i < len; i++) {
          handler = ref[i];
          oldVal[handler].disconnect(update, this);
        }
      }

      if (val = this.targetItem = this.item._previousSibling) {
        ref1 = getTargetWatchProps[this.line].sibling;

        for (j = 0, len1 = ref1.length; j < len1; j++) {
          handler = ref1[j];
          val[handler].connect(update, this);
        }
      }

      update.call(this);
    };

    onChildInsert = function onChildInsert(child) {
      child.onVisibleChange.connect(update, this);

      if (this.source === 'fillWidthSize') {
        child.onXChange.connect(update, this);
        child.onWidthChange.connect(update, this);
      }

      if (this.source === 'fillHeightSize') {
        child.onYChange.connect(update, this);
        child.onHeightChange.connect(update, this);
      }

      update.call(this);
    };

    onChildPop = function onChildPop(child) {
      child.onVisibleChange.disconnect(update, this);

      if (this.source === 'fillWidthSize') {
        child.onXChange.disconnect(update, this);
        child.onWidthChange.disconnect(update, this);
      }

      if (this.source === 'fillHeightSize') {
        child.onYChange.disconnect(update, this);
        child.onHeightChange.disconnect(update, this);
      }

      update.call(this);
    };

    onChildrenChange = function onChildrenChange(added, removed) {
      if (added) {
        onChildInsert.call(this, added);
      }

      if (removed) {
        return onChildPop.call(this, removed);
      }
    };

    Anchor = function () {
      var pool;
      pool = [];

      Anchor.factory = function (item, source, def) {
        var elem;

        if (pool.length > 0 && (elem = pool.pop())) {
          Anchor.call(elem, item, source, def);
          return elem;
        } else {
          return new Anchor(item, source, def);
        }
      };

      function Anchor(item1, source1, def) {
        var child, handler, i, item, j, len, len1, line, ref, ref1, source, target;
        this.item = item1;
        this.source = source1;
        item = this.item;
        source = this.source;
        target = def[0], line = def[1];

        if (line == null) {
          line = source;
        }

        this.target = target;
        this.line = line;
        this.pending = false;
        this.updateLoops = 0;

        if (target === 'parent' || item._parent === target) {
          this.type = 'parent';
        } else if (target === 'children') {
          this.type = 'children';
        } else {
          this.type = 'sibling';
        }

        ref = getSourceWatchProps[source];

        for (i = 0, len = ref.length; i < len; i++) {
          handler = ref[i];
          item[handler].connect(update, this);
        }

        this.prop = getItemProp[source];
        this.getSourceValue = getSourceValue[source];
        this.getTargetValue = getTargetValue[line][this.type];
        this.targetItem = null;
        Object.seal(this);

        if (typeof this.getTargetValue !== 'function') {
          this.getTargetValue = GET_ZERO;
          log.error("Unknown anchor `" + this + "` given");
        }

        switch (target) {
          case 'parent':
            this.targetItem = item._parent;
            item.onParentChange.connect(onParentChange, this);
            onParentChange.call(this, null);
            break;

          case 'children':
            this.targetItem = item.children;
            item.onChildrenChange.connect(onChildrenChange, this);
            child = this.targetItem.firstChild;

            while (child) {
              onChildInsert.call(this, child);
              child = child.nextSibling;
            }

            break;

          case 'nextSibling':
            this.targetItem = item._nextSibling;
            item.onNextSiblingChange.connect(onNextSiblingChange, this);
            onNextSiblingChange.call(this, null);
            break;

          case 'previousSibling':
            this.targetItem = item._previousSibling;
            item.onPreviousSiblingChange.connect(onPreviousSiblingChange, this);
            onPreviousSiblingChange.call(this, null);
            break;

          default:
            if (!utils.isObject(target) || !(handler in target)) {
              log.error("Unknown anchor `" + this + "` given");
              return;
            }

            if (this.targetItem = target) {
              ref1 = getTargetWatchProps[line][this.type];

              for (j = 0, len1 = ref1.length; j < len1; j++) {
                handler = ref1[j];
                this.targetItem[handler].connect(update, this);
              }
            }

            update.call(this);
        }
      }

      Anchor.prototype.update = function () {
        var fails, margin, r, targetItem;

        if (!this.item || this.updateLoops >= MAX_LOOPS) {
          return;
        }

        switch (this.target) {
          case 'parent':
            targetItem = this.item._parent;
            break;

          case 'children':
            targetItem = this.item.children;
            break;

          case 'nextSibling':
            targetItem = this.item._nextSibling;
            break;

          case 'previousSibling':
            targetItem = this.item._previousSibling;
            break;

          default:
            targetItem = this.targetItem;
        }

        if (!targetItem || targetItem !== this.targetItem) {
          return;
        }

        if (targetItem) {
          //<development>;
          fails = this.item._parent;
          fails && (fails = targetItem !== this.item._children);
          fails && (fails = this.item._parent !== targetItem);
          fails && (fails = this.item._parent !== targetItem._parent);

          if (fails) {
            log.error("Invalid anchor point; you can anchor only to a parent or a sibling; item '" + this.item.toString() + ".anchors." + this.source + ": " + this.target + "'");
          } //</development>;


          r = this.getSourceValue(this.item) + this.getTargetValue(targetItem);
        } else {
          r = 0;
        }

        if (margin = this.item._margin) {
          r += getMarginValue[this.source](margin);
        }

        this.updateLoops++;
        this.item[this.prop] = r;

        if (this.updateLoops === MAX_LOOPS) {
          log.error("Potential anchors loop detected; recalculating on this anchor (" + this + ") has been disabled");
          this.updateLoops++;
        } else if (this.updateLoops < MAX_LOOPS) {
          this.updateLoops--;
        }
      };

      Anchor.prototype.destroy = function () {
        var child, handler, i, j, len, len1, ref, ref1;

        switch (this.target) {
          case 'parent':
            this.item.onParentChange.disconnect(onParentChange, this);
            break;

          case 'children':
            this.item.onChildrenChange.disconnect(onChildrenChange, this);
            child = this.item.children.firstChild;

            while (child) {
              onChildPop.call(this, child, -1);
              child = child.nextSibling;
            }

            break;

          case 'nextSibling':
            this.item.onNextSiblingChange.disconnect(onNextSiblingChange, this);
            break;

          case 'previousSibling':
            this.item.onPreviousSiblingChange.disconnect(onPreviousSiblingChange, this);
        }

        ref = getSourceWatchProps[this.source];

        for (i = 0, len = ref.length; i < len; i++) {
          handler = ref[i];
          this.item[handler].disconnect(update, this);
        }

        if (this.targetItem) {
          ref1 = getTargetWatchProps[this.line][this.type];

          for (j = 0, len1 = ref1.length; j < len1; j++) {
            handler = ref1[j];
            this.targetItem[handler].disconnect(update, this);
          }
        }

        this.item = this.targetItem = null;
        pool.push(this);
      };

      Anchor.prototype.toString = function () {
        return this.item.toString() + ".anchors." + this.source + ": " + this.target + "." + this.line;
      };

      return Anchor;
    }();

    getBaseAnchors = {
      centerIn: ['horizontalCenter', 'verticalCenter'],
      fillWidth: ['fillWidthSize', 'left'],
      fillHeight: ['fillHeightSize', 'top'],
      fill: ['fillWidthSize', 'fillHeightSize', 'left', 'top']
    };
    getBaseAnchorsPerAnchorType = {
      __proto__: null
    };

    isMultiAnchor = function isMultiAnchor(source) {
      return !!getBaseAnchors[source];
    };

    MultiAnchor = function () {
      var pool;
      pool = [];

      MultiAnchor.factory = function (item, source, def) {
        var elem;

        if (elem = pool.pop()) {
          MultiAnchor.call(elem, item, source, def);
          return elem;
        } else {
          return new MultiAnchor(item, source, def);
        }
      };

      function MultiAnchor(item, source, def) {
        var anchor, baseAnchors, i, len, line, ref;
        assert.lengthOf(def, 1);
        this.anchors = [];
        def = [def[0], ''];
        this.pending = false;
        baseAnchors = (ref = getBaseAnchorsPerAnchorType[def[0]]) != null ? ref[source] : void 0;

        if (baseAnchors == null) {
          baseAnchors = getBaseAnchors[source];
        }

        for (i = 0, len = baseAnchors.length; i < len; i++) {
          line = baseAnchors[i];
          def[1] = line;
          anchor = Anchor.factory(item, line, def);
          this.anchors.push(anchor);
        }

        return;
      }

      MultiAnchor.prototype.update = function () {
        var anchor, i, len, ref;
        ref = this.anchors;

        for (i = 0, len = ref.length; i < len; i++) {
          anchor = ref[i];
          anchor.update();
        }
      };

      MultiAnchor.prototype.destroy = function () {
        var anchor, i, len, ref;
        ref = this.anchors;

        for (i = 0, len = ref.length; i < len; i++) {
          anchor = ref[i];
          anchor.destroy();
        }

        pool.push(this);
      };

      return MultiAnchor;
    }();

    createAnchor = function createAnchor(item, source, def) {
      if (isMultiAnchor(source)) {
        return MultiAnchor.factory(item, source, def);
      } else {
        return Anchor.factory(item, source, def);
      }
    };

    return exports = {
      setItemAnchor: function setItemAnchor(type, val) {
        var anchors, base;

        if (val !== null) {
          assert.isArray(val);
        }

        anchors = (base = this._impl).anchors != null ? base.anchors : base.anchors = {};

        if (!val && !anchors[type]) {
          return;
        }

        if (anchors[type]) {
          anchors[type].destroy();
          anchors[type] = null;
        }

        if (val) {
          anchors[type] = createAnchor(this, type, val);
        }
      }
    };
  };
}).call(this);
},{"../../../../assert":"lQvG","../../../../log":"fe8o","../../../../util":"xr+4","../../../../event-loop":"jt0G"}],"m+TT":[function(require,module,exports) {
(function () {
  var utils;
  utils = require('../../../util');

  module.exports = function (impl) {
    return {
      INTEGER_PROPERTIES: {
        __proto__: null,
        x: true,
        y: true,
        width: true,
        height: true
      },
      SETTER_METHODS_NAMES: {
        __proto__: null,
        'x': 'setItemX',
        'y': 'setItemY',
        'width': 'setItemWidth',
        'height': 'setItemHeight',
        'opacity': 'setItemOpacity',
        'rotation': 'setItemRotation',
        'scale': 'setItemScale',
        'offsetX': 'setImageOffsetX',
        'offsetY': 'setImageOffsetY',
        'sourceWidth': 'setImageSourceWidth',
        'sourceHeight': 'setImageSourceHeight'
      },
      createDataCloner: function createDataCloner(extend, base) {
        return function () {
          var func, json, obj;
          obj = extend;

          if (base != null) {
            extend = impl.Types[extend].DATA;
            obj = utils.clone(extend);
            utils.merge(obj, base);
            utils.merge(base, obj);
          }

          json = JSON.stringify(obj);
          func = Function("return " + json);
          return func;
        };
      },
      radToDeg: function () {
        var RAD;
        RAD = 180 / Math.PI;
        return function (val) {
          return val * RAD;
        };
      }(),
      degToRad: function () {
        var DEG;
        DEG = Math.PI / 180;
        return function (val) {
          return val * DEG;
        };
      }()
    };
  };
}).call(this);
},{"../../../util":"xr+4"}],"84Gw":[function(require,module,exports) {
(function () {
  'use strict';

  var utils;
  utils = require('../../../util');
  exports.Types = {
    Item: require('./level0/item'),
    Image: require('./level0/image'),
    Text: require('./level0/text'),
    Native: require('./level0/native'),
    FontLoader: require('./level0/loader/font'),
    Device: require('./level0/device'),
    Screen: require('./level0/screen'),
    Navigator: require('./level0/navigator'),
    Rectangle: require('./level1/rectangle'),
    Animation: require('./level1/animation'),
    PropertyAnimation: require('./level1/animation/property'),
    NumberAnimation: require('./level1/animation/number')
  };
  exports.Extras = {
    Binding: require('./level1/binding'),
    Anchors: require('./level1/anchors')
  };
  exports.items = {};
  exports.utils = require('./utils')(exports);
  exports.pixelRatio = 1;

  exports.setWindow = function (item) {};
}).call(this);
},{"../../../util":"xr+4","./level0/item":"YSW+","./level0/image":"+A0V","./level0/text":"yk96","./level0/native":"yDry","./level0/loader/font":"xuz/","./level0/device":"mBbZ","./level0/screen":"ma+O","./level0/navigator":"0Y+d","./level1/rectangle":"Ceg+","./level1/animation":"u1pG","./level1/animation/property":"7GKH","./level1/animation/number":"ABfx","./level1/binding":"g1G0","./level1/anchors":"VWzf","./utils":"m+TT"}],"2vQI":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalDispatcher, assert, eventLoop, utils;
  assert = console.assert;
  utils = require('../util');
  SignalDispatcher = require('../signal').SignalDispatcher;
  eventLoop = require('../event-loop');

  module.exports = function (Renderer) {
    var ABSTRACT_TYPES, TYPES, abstractImpl, extra, i, impl, j, k, len, len1, len2, name, platformImpl, ref, type, windowItemClass;
    impl = abstractImpl = require('./impl/base');
    impl.Renderer = Renderer;
    impl.windowItem = null;
    impl.serverUrl = '';
    impl.resources = null;
    impl.onWindowItemReady = new SignalDispatcher();
    TYPES = ['Item', 'Image', 'Text', 'Native', 'FontLoader', 'Device', 'Screen', 'Navigator', 'Rectangle', 'Animation', 'PropertyAnimation', 'NumberAnimation'];
    ABSTRACT_TYPES = {
      'Class': true,
      'Transition': true
    };

    if (undefined) {
      if (undefined) {
        platformImpl = require('./impl/pixi')(impl);
      }

      if (undefined) {
        platformImpl = require('./impl/css')(impl);
      }

      if (undefined) {
        platformImpl = require('./impl/native')(impl);
      }
    }

    for (i = 0, len = TYPES.length; i < len; i++) {
      name = TYPES[i];
      type = impl.Types[name] = impl.Types[name](impl);
      utils.merge(impl, type);
    }

    if (platformImpl) {
      utils.mergeDeep(impl, platformImpl);
    }

    for (j = 0, len1 = TYPES.length; j < len1; j++) {
      name = TYPES[j];

      if (typeof impl.Types[name] === 'function') {
        type = impl.Types[name] = impl.Types[name](impl);
        utils.merge(impl, type);
      }
    }

    for (k = 0, len2 = TYPES.length; k < len2; k++) {
      name = TYPES[k];

      if (impl.Types[name].createData) {
        impl.Types[name].createData = impl.Types[name].createData();
      }
    }

    ref = impl.Extras;

    for (name in ref) {
      extra = ref[name];
      extra = impl.Extras[name] = extra(impl);
      utils.merge(impl, extra);
    }

    impl.createObject = function (object, type) {
      var base, obj, ref1;

      if (!ABSTRACT_TYPES[type]) {
        obj = object;

        while (type && impl.Types[type] == null) {
          obj = Object.getPrototypeOf(obj);

          if (!obj) {
            break;
          }

          type = obj.constructor.name;
        }
      }

      object._impl = ((ref1 = impl.Types[type]) != null ? typeof ref1.createData === "function" ? ref1.createData() : void 0 : void 0) || {};

      if ((base = object._impl).bindings == null) {
        base.bindings = {};
      }

      return Object.seal(object._impl);
    };

    impl.initializeObject = function (object, type) {
      var obj, ref1, ref2;

      if (!ABSTRACT_TYPES[type]) {
        obj = object;

        while (type && impl.Types[type] == null) {
          obj = Object.getPrototypeOf(obj);
          type = obj.constructor.name;
        }

        return (ref1 = impl.Types[type]) != null ? (ref2 = ref1.create) != null ? ref2.call(object, object._impl) : void 0 : void 0;
      }
    };

    windowItemClass = null;

    impl.setWindow = function (_super) {
      return function (item) {
        utils.defineProperty(impl, 'windowItem', utils.ENUMERABLE, item);
        windowItemClass = Renderer.Class.New();
        windowItemClass.target = item;
        windowItemClass.running = true;

        _super.call(impl, item);

        impl.onWindowItemReady.emit(item);
        item.keys.focus = true;
      };
    }(impl.setWindow);

    impl.setWindowSize = function (width, height) {
      if (!impl.windowItem) {
        return;
      }

      eventLoop.lock();
      windowItemClass.changes = {
        width: width,
        height: height
      };
      return eventLoop.release();
    };

    impl.addTypeImplementation = function (type, methods) {
      impl.Types[type] = methods;
      return utils.merge(impl, methods);
    };

    return impl;
  };
}).call(this);
},{"../util":"xr+4","../signal":"WtLN","../event-loop":"jt0G","./impl/base":"84Gw"}],"jRFR":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      isArray,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../assert');
  utils = require('../../util');
  SignalsEmitter = require('../../signal').SignalsEmitter;
  log = require('../../log');
  log = log.scope('Renderer');
  isArray = Array.isArray;

  module.exports = function (Renderer, Impl) {
    var CustomObject, DeepObject, FixedObject, MutableDeepObject, NOP, UtilsObject, exports, getObjAsString, getObjFile, getPropHandlerName, getPropInternalName;

    NOP = function NOP() {};

    getObjAsString = function getObjAsString(item) {
      var attrs, ctorName;
      ctorName = item.constructor.name;
      attrs = [];

      if (item.id) {
        attrs.push("id=" + item.id);
      }

      if (item._path) {
        attrs.push("file=" + item._path);
      }

      return ctorName + "(" + attrs.join(', ') + ")";
    };

    getObjFile = function getObjFile(item) {
      var path, tmp;
      path = '';
      tmp = item;

      while (tmp) {
        if (path = tmp.constructor.__file__) {
          break;
        } else {
          tmp = tmp._parent;
        }
      }

      return path || '';
    };

    UtilsObject = function (superClass) {
      var createClass, initObject, setOpts;
      extend(UtilsObject, superClass);

      initObject = function initObject(opts) {
        var obj, path, prop, val;

        for (prop in opts) {
          val = opts[prop];
          path = exports.splitAttribute(prop);
          prop = path[path.length - 1];
          obj = exports.getObjectByPath(this, path);

          if (typeof val === 'function' && typeof obj[prop] === 'function') {
            obj[prop](exports.bindSignalListener(this, val));
          } else if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            continue;
          } else if (prop in obj) {
            obj[prop] = val;
          } else {
            log.error("Object '" + obj + "' has no property '" + prop + "'");
          }
        }

        for (prop in opts) {
          val = opts[prop];
          path = exports.splitAttribute(prop);
          prop = path[path.length - 1];
          obj = exports.getObjectByPath(this, path);

          if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            obj.createBinding(prop, val);
          }
        }
      };

      setOpts = function setOpts(opts) {
        var child, classElem, j, len1, ref1, ref2;

        if (typeof opts.id === 'string') {
          this.id = opts.id;
        }

        if (Array.isArray(opts.children)) {
          ref1 = opts.children;

          for (j = 0, len1 = ref1.length; j < len1; j++) {
            child = ref1[j];

            if (child instanceof Renderer.Item) {
              child.parent = this;
            } else if (this instanceof Renderer.Extension) {
              this._children = opts.children;
            } else if (child instanceof Renderer.Extension && !((ref2 = child._bindings) != null ? ref2.target : void 0)) {
              child.target = this;
            }
          }
        }

        classElem = createClass(opts);
        classElem.target = this;
        classElem.running = true;
      };

      createClass = function createClass(opts) {
        var classElem;
        classElem = Renderer.Class.New();
        classElem._priority = -1;
        classElem.changes = opts;
        return classElem;
      };

      UtilsObject.createProperty = function (object, name) {
        assert.isString(name, "Property must be a string, but '" + name + "' given");
        assert.notLengthOf(name, 0, "Property cannot be an empty string");
        assert.notOk(name in object, object + " already has a property '" + name + "'");
        exports.defineProperty({
          object: object,
          name: name
        });
      };

      UtilsObject.createSignal = function (object, name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        assert.notOk(name in object, object + " already has a signal '" + name + "'");
        SignalsEmitter.createSignal(object, name);
      };

      UtilsObject.setOpts = function (object, opts) {
        if (opts.id != null) {
          object.id = opts.id;
        }

        if (object instanceof Renderer.Class || object instanceof FixedObject) {
          initObject.call(object, opts);
        } else {
          setOpts.call(object, opts);
        }

        return object;
      };

      UtilsObject.initialize = function (object, opts) {
        Impl.initializeObject(object, object.constructor.name);

        if (opts) {
          UtilsObject.setOpts(object, opts);
        }
      };

      function UtilsObject() {
        SignalsEmitter.call(this);
        this.id = ''; //<development>;

        this._path = ''; //</development>;

        this._impl = null;
        this._bindings = null;

        if (!(this instanceof Renderer.Class)) {
          this._classList = [];
          this._classQueue = [];
          this._extensions = [];
        }

        Impl.createObject(this, this.constructor.name);
      }

      UtilsObject.prototype.createBinding = function (prop, val, ctx) {
        var bindings;

        if (ctx == null) {
          ctx = this;
        }

        assert.isString(prop);

        if (val != null) {
          assert.isArray(val);
        } //<development>;


        if (!(prop in this)) {
          log.warn("Binding on the '" + prop + "' property can't be created, because this object (" + this.toString() + ") doesn't have such property");
          return;
        } //</development>;


        if (!val && (!this._bindings || !this._bindings.hasOwnProperty(prop))) {
          return;
        }

        bindings = this._bindings != null ? this._bindings : this._bindings = {};

        if (bindings[prop] !== val) {
          bindings[prop] = val;
          Impl.setItemBinding.call(this, prop, val, ctx);
        }
      };

      UtilsObject.prototype.toString = function () {
        return getObjAsString(this);
      };

      return UtilsObject;
    }(SignalsEmitter);

    FixedObject = function (superClass) {
      extend(FixedObject, superClass);

      function FixedObject(opts) {
        FixedObject.__super__.constructor.call(this, opts);
      }

      return FixedObject;
    }(UtilsObject);

    MutableDeepObject = function (superClass) {
      extend(MutableDeepObject, superClass);

      function MutableDeepObject(ref) {
        assert.instanceOf(ref, UtilsObject);

        MutableDeepObject.__super__.constructor.call(this);

        this._ref = ref;
        this._impl = {
          bindings: null
        };
        this._bindings = null;
        this._extensions = [];
      }

      MutableDeepObject.prototype.createBinding = UtilsObject.prototype.createBinding;

      MutableDeepObject.prototype.toString = function () {
        return getObjAsString(this._ref);
      };

      return MutableDeepObject;
    }(SignalsEmitter);

    DeepObject = function (superClass) {
      extend(DeepObject, superClass);

      function DeepObject(ref) {
        DeepObject.__super__.constructor.call(this, ref);
      }

      return DeepObject;
    }(MutableDeepObject);

    CustomObject = function (superClass) {
      extend(CustomObject, superClass);

      function CustomObject(ref) {
        CustomObject.__super__.constructor.call(this, ref);
      }

      return CustomObject;
    }(MutableDeepObject);

    Impl.DeepObject = DeepObject;
    return exports = {
      Object: UtilsObject,
      FixedObject: FixedObject,
      DeepObject: DeepObject,
      MutableDeepObject: MutableDeepObject,
      CustomObject: CustomObject,
      getPropHandlerName: getPropHandlerName = function () {
        var cache;
        cache = Object.create(null);
        return function (prop) {
          return cache[prop] || (cache[prop] = "on" + utils.capitalize(prop) + "Change");
        };
      }(),
      getPropInternalName: getPropInternalName = function () {
        var cache;
        cache = Object.create(null);
        return function (prop) {
          return cache[prop] || (cache[prop] = "_" + prop);
        };
      }(),
      getInnerPropName: function () {
        var cache;
        cache = Object.create(null);
        cache[''] = '';
        return function (val) {
          return cache[val] != null ? cache[val] : cache[val] = '_' + val;
        };
      }(),
      splitAttribute: function () {
        var cache;
        cache = Object.create(null);
        return function (attr) {
          return cache[attr] != null ? cache[attr] : cache[attr] = attr.split('.');
        };
      }(),
      getObjectByPath: function getObjectByPath(item, path) {
        var i, len;
        len = path.length - 1;
        i = 0;

        while (i < len) {
          if (!(item = item[path[i]])) {
            return null;
          }

          i++;
        }

        return item;
      },
      bindSignalListener: function bindSignalListener(object, func) {
        return function (arg1, arg2) {
          return func.call(object, arg1, arg2);
        };
      },
      defineProperty: function defineProperty(opts) {
        var basicGetter, basicSetter, customGetter, customSetter, developmentSetter, func, getter, implementation, implementationValue, internalName, name, namespace, namespaceSignalName, propGetter, propSetter, prototype, setter, signalName, uniquePropName, valueConstructor;
        assert.isPlainObject(opts);
        name = opts.name, namespace = opts.namespace, valueConstructor = opts.valueConstructor, implementation = opts.implementation, implementationValue = opts.implementationValue; //<development>;

        developmentSetter = opts.developmentSetter; //</development>;

        prototype = opts.object || opts.constructor.prototype;
        customGetter = opts.getter;
        customSetter = opts.setter;
        signalName = getPropHandlerName(name);

        if (opts.hasOwnProperty('constructor')) {
          SignalsEmitter.createSignal(opts.constructor, signalName, opts.signalInitializer);
        } else {
          SignalsEmitter.createSignal(prototype, signalName, opts.signalInitializer);
        }

        internalName = getPropInternalName(name);
        propGetter = basicGetter = Function("return this." + internalName);

        if (valueConstructor) {
          propGetter = function propGetter() {
            return this[internalName] != null ? this[internalName] : this[internalName] = new valueConstructor(this);
          };
        }

        if (valueConstructor) {
          if (developmentSetter) {
            //<development>;
            propSetter = basicSetter = developmentSetter; //</development>;
          } else {
            propSetter = basicSetter = NOP;
          }
        } else if (namespace != null) {
          namespaceSignalName = "on" + utils.capitalize(namespace) + "Change";
          uniquePropName = namespace + utils.capitalize(name);

          func = function () {
            var funcStr;
            funcStr = "return function(val){\n"; //<development>;

            if (developmentSetter != null) {
              funcStr += "debug.call(this, val);\n";
            } //</development>;


            funcStr += "var oldVal = this." + internalName + ";\n";
            funcStr += "if (oldVal === val) return;\n";

            if (implementation != null) {
              if (implementationValue != null) {
                funcStr += "impl.call(this._ref, implValue.call(this._ref, val));\n";
              } else {
                funcStr += "impl.call(this._ref, val);\n";
              }
            }

            funcStr += "this." + internalName + " = val;\n";
            funcStr += "this.emit('" + signalName + "', oldVal);\n";
            funcStr += "this._ref.emit('" + namespaceSignalName + "', '" + name + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'implValue', 'debug', funcStr);
          }();

          propSetter = basicSetter = func(implementation, implementationValue, developmentSetter);
        } else {
          func = function () {
            var funcStr;
            funcStr = "return function(val){\n"; //<development>;

            if (developmentSetter != null) {
              funcStr += "debug.call(this, val);\n";
            } //</development>;


            funcStr += "var oldVal = this." + internalName + ";\n";
            funcStr += "if (oldVal === val) return;\n";

            if (implementation != null) {
              if (implementationValue != null) {
                funcStr += "impl.call(this, implValue.call(this, val));\n";
              } else {
                funcStr += "impl.call(this, val);\n";
              }
            }

            funcStr += "this." + internalName + " = val;\n";
            funcStr += "this.emit('" + signalName + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'implValue', 'debug', funcStr);
          }();

          propSetter = basicSetter = func(implementation, implementationValue, developmentSetter);
        }

        getter = customGetter != null ? customGetter(propGetter) : propGetter;
        setter = customSetter != null ? customSetter(propSetter) : propSetter;
        prototype[internalName] = opts.defaultValue;
        utils.defineProperty(prototype, name, null, getter, setter);
        return prototype;
      },
      setPropertyValue: function setPropertyValue(item, prop, val) {
        var internalName, oldVal, signalName;
        assert.instanceOf(item, Renderer.Item);
        assert.isString(prop);
        internalName = getPropInternalName(prop);
        signalName = getPropHandlerName(prop);
        oldVal = item[internalName];

        if (val !== oldVal) {
          item[internalName] = val;
          item.emit(signalName, oldVal);
        }
      }
    };
  };
}).call(this);
},{"../../assert":"lQvG","../../util":"xr+4","../../signal":"WtLN","../../log":"fe8o"}],"aX08":[function(require,module,exports) {
(function () {
  'use strict';

  var HEIGHT_PROPS, WIDTH_PROPS, assert;
  assert = require('../../assert');
  WIDTH_PROPS = ['width', 'anchors.fill', 'anchors.fillWidth', 'fillWidth'];
  HEIGHT_PROPS = ['height', 'anchors.fill', 'anchors.fillHeight', 'fillHeight'];

  module.exports = function (Renderer) {
    var hasOneOfProps;

    hasOneOfProps = function hasOneOfProps(item, props) {
      var attributes, bindings, ext, i, j, len, len1, prop, ref;
      assert.instanceOf(item, Renderer.Item);
      ref = item._extensions;

      for (i = 0, len = ref.length; i < len; i++) {
        ext = ref[i];

        if (!(ext instanceof Renderer.Class)) {
          continue;
        }

        attributes = ext.changes._attributes;
        bindings = ext.changes._bindings;

        for (j = 0, len1 = props.length; j < len1; j++) {
          prop = props[j];

          if (attributes[prop] != null || bindings[prop] != null) {
            return true;
          }
        }
      }

      return false;
    };

    return {
      isAutoWidth: function isAutoWidth(item) {
        return !hasOneOfProps(item, WIDTH_PROPS);
      },
      isAutoHeight: function isAutoHeight(item) {
        return !hasOneOfProps(item, HEIGHT_PROPS);
      }
    };
  };
}).call(this);
},{"../../assert":"lQvG"}],"jPDc":[function(require,module,exports) {
(function () {
  'use strict';

  var assert;
  assert = require('../../assert');
  /*
  Parse 3-digit hex, 6-digit hex, rgb, rgba, hsl, hsla, or named color into RGBA hex.
   */

  exports.toRGBAHex = function () {
    var DIGIT_3_RE, DIGIT_6_RE, HSLA_RE, HSL_RE, NAMED_COLORS, RGBA_RE, RGB_RE, alphaToHex, hslToRgb, numberToHex;
    NAMED_COLORS = {
      '': 0x00000000,
      transparent: 0x00000000,
      black: 0x000000ff,
      silver: 0xc0c0c0ff,
      gray: 0x808080ff,
      white: 0xffffffff,
      maroon: 0x800000ff,
      red: 0xff0000ff,
      purple: 0x800080ff,
      fuchsia: 0xff00ffff,
      green: 0x008000ff,
      lime: 0x00ff00ff,
      olive: 0x808000ff,
      yellow: 0xffff00ff,
      navy: 0x000080ff,
      blue: 0x0000ffff,
      teal: 0x008080ff,
      aqua: 0x00ffffff,
      orange: 0xffa500ff,
      aliceblue: 0xf0f8ffff,
      antiquewhite: 0xfaebd7ff,
      aquamarine: 0x7fffd4ff,
      azure: 0xf0ffffff,
      beige: 0xf5f5dcff,
      bisque: 0xffe4c4ff,
      blanchedalmond: 0xffe4c4ff,
      blueviolet: 0x8a2be2ff,
      brown: 0xa52a2aff,
      burlywood: 0xdeb887ff,
      cadetblue: 0x5f9ea0ff,
      chartreuse: 0x7fff00ff,
      chocolate: 0xd2691eff,
      coral: 0xff7f50ff,
      cornflowerblue: 0x6495edff,
      cornsilk: 0xfff8dcff,
      crimson: 0xdc143cff,
      darkblue: 0x00008bff,
      darkcyan: 0x008b8bff,
      darkgoldenrod: 0xb8860bff,
      darkgray: 0xa9a9a9ff,
      darkgreen: 0x006400ff,
      darkgrey: 0xa9a9a9ff,
      darkkhaki: 0xbdb76bff,
      darkmagenta: 0x8b008bff,
      darkolivegreen: 0x556b2fff,
      darkorange: 0xff8c00ff,
      darkorchid: 0x9932ccff,
      darkred: 0x8b0000ff,
      darksalmon: 0xe9967aff,
      darkseagreen: 0x8fbc8fff,
      darkslateblue: 0x483d8bff,
      darkslategray: 0x2f4f4fff,
      darkslategrey: 0x2f4f4fff,
      darkturquoise: 0x00ced1ff,
      darkviolet: 0x9400d3ff,
      deeppink: 0xff1493ff,
      deepskyblue: 0x00bfffff,
      dimgray: 0x696969ff,
      dimgrey: 0x696969ff,
      dodgerblue: 0x1e90ffff,
      firebrick: 0xb22222ff,
      floralwhite: 0xfffaf0ff,
      forestgreen: 0x228b22ff,
      gainsboro: 0xdcdcdcff,
      ghostwhite: 0xf8f8ffff,
      gold: 0xffd700ff,
      goldenrod: 0xdaa520ff,
      greenyellow: 0xadff2fff,
      grey: 0x808080ff,
      honeydew: 0xf0fff0ff,
      hotpink: 0xff69b4ff,
      indianred: 0xcd5c5cff,
      indigo: 0x4b0082ff,
      ivory: 0xfffff0ff,
      khaki: 0xf0e68cff,
      lavender: 0xe6e6faff,
      lavenderblush: 0xfff0f5ff,
      lawngreen: 0x7cfc00ff,
      lemonchiffon: 0xfffacdff,
      lightblue: 0xadd8e6ff,
      lightcoral: 0xf08080ff,
      lightcyan: 0xe0ffffff,
      lightgoldenrodyellow: 0xfafad2ff,
      lightgray: 0xd3d3d3ff,
      lightgreen: 0x90ee90ff,
      lightgrey: 0xd3d3d3ff,
      lightpink: 0xffb6c1ff,
      lightsalmon: 0xffa07aff,
      lightseagreen: 0x20b2aaff,
      lightskyblue: 0x87cefaff,
      lightslategray: 0x778899ff,
      lightslategrey: 0x778899ff,
      lightsteelblue: 0xb0c4deff,
      lightyellow: 0xffffe0ff,
      limegreen: 0x32cd32ff,
      linen: 0xfaf0e6ff,
      mediumaquamarine: 0x66cdaaff,
      mediumblue: 0x0000cdff,
      mediumorchid: 0xba55d3ff,
      mediumpurple: 0x9370dbff,
      mediumseagreen: 0x3cb371ff,
      mediumslateblue: 0x7b68eeff,
      mediumspringgreen: 0x00fa9aff,
      mediumturquoise: 0x48d1ccff,
      mediumvioletred: 0xc71585ff,
      midnightblue: 0x191970ff,
      mintcream: 0xf5fffaff,
      mistyrose: 0xffe4e1ff,
      moccasin: 0xffe4b5ff,
      navajowhite: 0xffdeadff,
      oldlace: 0xfdf5e6ff,
      olivedrab: 0x6b8e23ff,
      orangered: 0xff4500ff,
      orchid: 0xda70d6ff,
      palegoldenrod: 0xeee8aaff,
      palegreen: 0x98fb98ff,
      paleturquoise: 0xafeeeeff,
      palevioletred: 0xdb7093ff,
      papayawhip: 0xffefd5ff,
      peachpuff: 0xffdab9ff,
      peru: 0xcd853fff,
      pink: 0xffc0cbff,
      plum: 0xdda0ddff,
      powderblue: 0xb0e0e6ff,
      rosybrown: 0xbc8f8fff,
      royalblue: 0x4169e1ff,
      saddlebrown: 0x8b4513ff,
      salmon: 0xfa8072ff,
      sandybrown: 0xf4a460ff,
      seagreen: 0x2e8b57ff,
      seashell: 0xfff5eeff,
      sienna: 0xa0522dff,
      skyblue: 0x87ceebff,
      slateblue: 0x6a5acdff,
      slategray: 0x708090ff,
      slategrey: 0x708090ff,
      snow: 0xfffafaff,
      springgreen: 0x00ff7fff,
      steelblue: 0x4682b4ff,
      tan: 0xd2b48cff,
      thistle: 0xd8bfd8ff,
      tomato: 0xff6347ff,
      turquoise: 0x40e0d0ff,
      violet: 0xee82eeff,
      wheat: 0xf5deb3ff,
      whitesmoke: 0xf5f5f5ff,
      yellowgreen: 0x9acd32ff,
      rebeccapurple: 0x663399ff
    };
    DIGIT_3_RE = /^#[0-9a-fA-F]{3}$/;
    DIGIT_6_RE = /^#[0-9a-fA-F]{6}$/;
    RGB_RE = /^rgb\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\)$/;
    RGBA_RE = /^rgba\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\)$/;
    HSL_RE = /^hsl\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*%\s*\)$/;
    HSLA_RE = /^hsla\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*\)$/;

    numberToHex = function numberToHex(val) {
      var hex;
      val = parseFloat(val);

      if (val < 0) {
        val = 0;
      } else if (val > 255) {
        val = 255;
      }

      hex = Math.round(val);
      return hex;
    };

    alphaToHex = function alphaToHex(val) {
      return numberToHex(Math.round(parseFloat(val) * 255));
    };

    hslToRgb = function () {
      var hueToRgb;

      hueToRgb = function hueToRgb(p, q, t) {
        if (t < 0) {
          t += 1;
        }

        if (t > 1) {
          t -= 1;
        }

        if (t * 6 < 1) {
          return p + (q - p) * t * 6;
        }

        if (t * 2 < 1) {
          return q;
        }

        if (t * 3 < 2) {
          return p + (q - p) * (2 / 3 - t) * 6;
        }

        return p;
      };

      return function (hStr, sStr, lStr) {
        var blue, green, h, l, p, q, red, s;
        p = q = h = s = l = 0.0;
        h = parseFloat(hStr) % 360 / 360;
        s = parseFloat(sStr) / 100;
        l = parseFloat(lStr) / 100;

        if (s === 0) {
          red = green = blue = l;
        } else {
          if (l <= 0.5) {
            q = l * (s + 1);
          } else {
            q = l + s - l * s;
          }

          p = l * 2 - q;
          red = hueToRgb(p, q, h + 1 / 3);
          green = hueToRgb(p, q, h);
          blue = hueToRgb(p, q, h - 1 / 3);
        }

        return Math.round(red * 255) << 16 | Math.round(green * 255) << 8 | Math.round(blue * 255);
      };
    }();

    return function (color, defaultColor) {
      var a, b, g, match, r, result;

      if (defaultColor == null) {
        defaultColor = 'transparent';
      }

      assert.isString(color);
      r = g = b = a = 0;

      if ((result = NAMED_COLORS[color]) !== void 0) {
        return result;
      }

      if (DIGIT_3_RE.test(color)) {
        r = parseInt(color[1], 16);
        g = parseInt(color[2], 16);
        b = parseInt(color[3], 16);
        r = r << 4 | r;
        g = g << 4 | g;
        b = b << 4 | b;
        a = 0xFF;
      } else if (DIGIT_6_RE.test(color)) {
        r = parseInt(color.substr(1, 2), 16);
        g = parseInt(color.substr(3, 2), 16);
        b = parseInt(color.substr(5, 2), 16);
        a = 0xFF;
      } else if (match = RGB_RE.exec(color)) {
        r = numberToHex(match[1]);
        g = numberToHex(match[2]);
        b = numberToHex(match[3]);
        a = 0xFF;
      } else if (match = RGBA_RE.exec(color)) {
        r = numberToHex(match[1]);
        g = numberToHex(match[2]);
        b = numberToHex(match[3]);
        a = alphaToHex(match[4]);
      } else if (match = HSL_RE.exec(color)) {
        b = hslToRgb(match[1], match[2], match[3]);
        a = 0xFF;
      } else if (match = HSLA_RE.exec(color)) {
        b = hslToRgb(match[1], match[2], match[3]);
        a = alphaToHex(match[4]);
      } else {
        return exports.toRGBAHex(defaultColor);
      }

      return (r << 24 | g << 16 | b << 8 | a) >>> 0;
    };
  }();
}).call(this);
},{"../../assert":"lQvG"}],"5krt":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  log = require('../../../../log');
  utils = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;
  assert = require('../../../../assert');

  module.exports = function (Renderer, Impl, itemUtils) {
    var StatusBar;
    return StatusBar = function (superClass) {
      extend(StatusBar, superClass);

      function StatusBar() {
        StatusBar.__super__.constructor.call(this);

        this._height = 0;
        this._color = 'Dark';
        Object.preventExtensions(this);
      }

      itemUtils.defineProperty({
        constructor: StatusBar,
        name: 'height'
      });
      itemUtils.defineProperty({
        constructor: StatusBar,
        name: 'color',
        implementation: Impl.setScreenStatusBarColor,
        implementationValue: function implementationValue(val) {
          val = utils.capitalize(val.toLowerCase());

          if (val !== 'Light' && val !== 'Dark') {
            log.warn("Unknown Screen.StatusBar.color `" + val + "` given");
            val = 'Dark';
          }

          return val;
        },
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val);
        }
      });
      return StatusBar;
    }(SignalsEmitter);
  };
}).call(this);
},{"../../../../log":"fe8o","../../../../util":"xr+4","../../../../signal":"WtLN","../../../../assert":"lQvG"}],"NLAG":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  SignalsEmitter = require('../../../../signal').SignalsEmitter;

  module.exports = function (Renderer, Impl, itemUtils) {
    var NavigationBar;
    return NavigationBar = function (superClass) {
      extend(NavigationBar, superClass);

      function NavigationBar() {
        NavigationBar.__super__.constructor.call(this);

        this._height = 0;
        Object.preventExtensions(this);
      }

      itemUtils.defineProperty({
        constructor: NavigationBar,
        name: 'height'
      });
      return NavigationBar;
    }(SignalsEmitter);
  };
}).call(this);
},{"../../../../signal":"WtLN"}],"bLcb":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  assert = require('../../../assert');

  module.exports = function (Renderer, Impl, itemUtils) {
    var NavigationBar, Screen, StatusBar, screen;
    StatusBar = require('./screen/statusBar')(Renderer, Impl, itemUtils);
    NavigationBar = require('./screen/navigationBar')(Renderer, Impl, itemUtils);

    Screen = function (superClass) {
      extend(Screen, superClass);

      function Screen() {
        Screen.__super__.constructor.call(this);

        this._impl = {
          bindings: null
        };
        this._touch = false;
        this._width = 1024;
        this._height = 800;
        this._orientation = 'Portrait';
        this._statusBar = new StatusBar();
        this._navigationBar = new NavigationBar();
        Object.preventExtensions(this);
      }

      utils.defineProperty(Screen.prototype, 'touch', null, function () {
        return this._touch;
      }, null);
      utils.defineProperty(Screen.prototype, 'width', null, function () {
        return this._width;
      }, null);
      utils.defineProperty(Screen.prototype, 'height', null, function () {
        return this._height;
      }, null);
      itemUtils.defineProperty({
        constructor: Screen,
        name: 'orientation',
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val);
        }
      });
      utils.defineProperty(Screen.prototype, 'statusBar', null, function () {
        return this._statusBar;
      }, null);
      utils.defineProperty(Screen.prototype, 'navigationBar', null, function () {
        return this._navigationBar;
      }, null);
      return Screen;
    }(SignalsEmitter);

    screen = new Screen();
    Impl.initScreenNamespace.call(screen, function () {
      Impl.setWindowSize(screen.width, screen.height);
    });
    return screen;
  };
}).call(this);
},{"../../../util":"xr+4","../../../signal":"WtLN","../../../assert":"lQvG","./screen/statusBar":"5krt","./screen/navigationBar":"NLAG"}],"OiVh":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty,
      slice = [].slice;

  utils = require('../../../util');
  SignalsEmitter = require('../../../signal').SignalsEmitter;

  module.exports = function (Renderer, Impl, itemUtils) {
    var Device, DeviceKeyboardEvent, DevicePointerEvent, device;

    Device = function (superClass) {
      extend(Device, superClass);

      function Device() {
        Device.__super__.constructor.call(this);

        this._platform = 'Unix';
        this._desktop = true;
        this._phone = false;
        this._pixelRatio = 1;
        this._pointer = new DevicePointerEvent();
        this._keyboard = new DeviceKeyboardEvent();
        Object.preventExtensions(this);
      }

      utils.defineProperty(Device.prototype, 'platform', null, function () {
        return this._platform;
      }, null);
      utils.defineProperty(Device.prototype, 'desktop', null, function () {
        return this._desktop;
      }, null);
      utils.defineProperty(Device.prototype, 'tablet', null, function () {
        return !this.desktop && !this.phone;
      }, null);
      utils.defineProperty(Device.prototype, 'phone', null, function () {
        return this._phone;
      }, null);
      utils.defineProperty(Device.prototype, 'mobile', null, function () {
        return this.tablet || this.phone;
      }, null);
      utils.defineProperty(Device.prototype, 'pixelRatio', null, function () {
        return this._pixelRatio;
      }, null);

      Device.prototype.log = function () {
        var msgs;
        msgs = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        return Impl.logDevice(msgs.join(' '));
      };

      utils.defineProperty(Device.prototype, 'pointer', null, function () {
        return this._pointer;
      }, null);
      SignalsEmitter.createSignal(Device, 'onPointerPress');
      SignalsEmitter.createSignal(Device, 'onPointerRelease');
      SignalsEmitter.createSignal(Device, 'onPointerMove');
      SignalsEmitter.createSignal(Device, 'onPointerWheel');
      utils.defineProperty(Device.prototype, 'keyboard', null, function () {
        return this._keyboard;
      }, null);
      SignalsEmitter.createSignal(Device, 'onKeyPress');
      SignalsEmitter.createSignal(Device, 'onKeyHold');
      SignalsEmitter.createSignal(Device, 'onKeyRelease');
      SignalsEmitter.createSignal(Device, 'onKeyInput');
      return Device;
    }(SignalsEmitter);

    DevicePointerEvent = function (superClass) {
      extend(DevicePointerEvent, superClass);

      function DevicePointerEvent() {
        DevicePointerEvent.__super__.constructor.call(this);

        this._x = 0;
        this._y = 0;
        this._movementX = 0;
        this._movementY = 0;
        this._deltaX = 0;
        this._deltaY = 0;
        Object.preventExtensions(this);
      }

      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'x',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'y',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'movementX',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'movementY',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'deltaX',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DevicePointerEvent,
        name: 'deltaY',
        defaultValue: 0
      });
      return DevicePointerEvent;
    }(SignalsEmitter);

    DeviceKeyboardEvent = function (superClass) {
      extend(DeviceKeyboardEvent, superClass);

      function DeviceKeyboardEvent() {
        DeviceKeyboardEvent.__super__.constructor.call(this);

        this._visible = false;
        this._height = 0;
        this._key = '';
        this._text = '';
        Object.preventExtensions(this);
      }

      itemUtils.defineProperty({
        constructor: DeviceKeyboardEvent,
        name: 'visible',
        defaultValue: false
      });
      itemUtils.defineProperty({
        constructor: DeviceKeyboardEvent,
        name: 'height',
        defaultValue: 0
      });
      itemUtils.defineProperty({
        constructor: DeviceKeyboardEvent,
        name: 'key',
        defaultValue: ''
      });
      itemUtils.defineProperty({
        constructor: DeviceKeyboardEvent,
        name: 'text',
        defaultValue: ''
      });

      DeviceKeyboardEvent.prototype.show = function () {
        return Impl.showDeviceKeyboard.call(device);
      };

      DeviceKeyboardEvent.prototype.hide = function () {
        return Impl.hideDeviceKeyboard.call(device);
      };

      return DeviceKeyboardEvent;
    }(SignalsEmitter);

    device = new Device();

    (function () {
      var updateMovement, x, y;
      x = y = 0;

      updateMovement = function updateMovement(event) {
        event.movementX = event.x - x;
        event.movementY = event.y - y;
        x = event.x;
        y = event.y;
      };

      device.onPointerPress.connect(updateMovement);
      device.onPointerRelease.connect(updateMovement);
      return device.onPointerMove.connect(updateMovement);
    })();

    Impl.initDeviceNamespace.call(device);
    return device;
  };
}).call(this);
},{"../../../util":"xr+4","../../../signal":"WtLN"}],"iSrG":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  assert = require('../../../assert');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Navigator, navigator, ref;

    Navigator = function (superClass) {
      extend(Navigator, superClass);

      function Navigator() {
        Navigator.__super__.constructor.call(this);

        this._impl = {
          bindings: null
        };
        this._language = 'en';
        this._browser = true;
        this._online = true;
        Object.preventExtensions(this);
      }

      utils.defineProperty(Navigator.prototype, 'language', null, function () {
        return this._language;
      }, null);
      utils.defineProperty(Navigator.prototype, 'browser', null, function () {
        return this._browser;
      }, null);
      utils.defineProperty(Navigator.prototype, 'native', null, function () {
        return !this._browser;
      }, null);
      itemUtils.defineProperty({
        constructor: Navigator,
        name: 'online',
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        }
      });
      return Navigator;
    }(SignalsEmitter);

    navigator = new Navigator();

    if ((ref = Impl.initNavigatorNamespace) != null) {
      ref.call(navigator);
    }

    return navigator;
  };
}).call(this);
},{"../../../util":"xr+4","../../../signal":"WtLN","../../../assert":"lQvG"}],"rImO":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      signal,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../util');
  signal = require('../../signal');
  assert = require('../../assert');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Extension;
    return Extension = function (superClass) {
      extend(Extension, superClass);
      Extension.__name__ = 'Extension';

      function Extension() {
        Extension.__super__.constructor.call(this);

        this._target = null;
        this._running = false;
      }

      itemUtils.defineProperty({
        constructor: Extension,
        name: 'target',
        defaultValue: null
      });
      itemUtils.defineProperty({
        constructor: Extension,
        name: 'running',
        defaultValue: false,
        setter: function setter(_super) {
          return function (val) {
            var oldVal;
            assert.isBoolean(val);
            oldVal = this._running;

            _super.call(this, val);

            if (oldVal && !val) {
              this._disable();
            }

            if (!oldVal && val) {
              this._enable();
            }
          };
        }
      });

      Extension.prototype._enable = function () {};

      Extension.prototype._disable = function () {};

      return Extension;
    }(itemUtils.Object);
  };
}).call(this);
},{"../../util":"xr+4","../../signal":"WtLN","../../assert":"lQvG"}],"6aTz":[function(require,module,exports) {
(function () {
  'use strict';

  var ATTRS_PRIORITY,
      ATTR_CLASS_SEARCH,
      ATTR_SEARCH,
      ATTR_VALUES,
      ATTR_VALUE_SEARCH,
      CONTAINS,
      DEEP,
      DEFAULT_PRIORITY,
      ELEMENTS_PRIORITY,
      ENDS_WITH,
      MAX_QUERIES_CACHE_LENGTH,
      OPTS_ADD_ANCHOR,
      OPTS_QUERY_BY_PARENTS,
      OPTS_REVERSED,
      QUERIES_CACHE_OVERFLOW_REDUCTION,
      STARTS_WITH,
      SignalsEmitter,
      TRIM_ATTR_VALUE,
      TYPE,
      Tag,
      Text,
      Watcher,
      _anyChild,
      _anyDescendant,
      _anyParent,
      assert,
      byInstance,
      byName,
      byProp,
      byPropContainsValue,
      byPropEndsWithValue,
      byPropStartsWithValue,
      byPropValue,
      byTag,
      _directParent,
      eventLoop,
      getQueries,
      i,
      queriesCache,
      queriesCacheLengths,
      test,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;
  eventLoop = require('../../../../event-loop');
  assert = require('../../../../assert');
  Tag = Text = null;
  DEFAULT_PRIORITY = 0;
  ELEMENTS_PRIORITY = 1;
  ATTRS_PRIORITY = 100;

  test = function test(node, funcs, index, targetFunc, targetCtx, single) {
    var data1, data2, func;

    while (index < funcs.length) {
      func = funcs[index];

      if (func.isIterator) {
        return func(node, funcs, index + 3, targetFunc, targetCtx, single);
      } else {
        data1 = funcs[index + 1];
        data2 = funcs[index + 2];

        if (!func(node, data1, data2)) {
          return false;
        }
      }

      index += 3;
    }

    targetFunc.call(targetCtx, node);
    return true;
  };

  _anyDescendant = function anyDescendant(node, funcs, index, targetFunc, targetCtx, single) {
    var child, j, len, ref;
    ref = node.children;

    for (j = 0, len = ref.length; j < len; j++) {
      child = ref[j];

      if (!(child instanceof Tag) || child.name !== 'blank') {
        if (test(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
      }

      if (child instanceof Tag) {
        if (_anyDescendant(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
      }
    }

    return false;
  };

  _anyDescendant.isIterator = true;
  _anyDescendant.priority = DEFAULT_PRIORITY;

  _anyDescendant.toString = function () {
    return 'anyDescendant';
  };

  _directParent = function directParent(node, funcs, index, targetFunc, targetCtx, single) {
    var parent;

    if (parent = node._parent) {
      if (test(parent, funcs, index, targetFunc, targetCtx, single)) {
        return true;
      }

      if (parent.name === 'blank') {
        return _directParent(parent, funcs, index, targetFunc, targetCtx, single);
      }
    }

    return false;
  };

  _directParent.isIterator = true;
  _directParent.priority = DEFAULT_PRIORITY;

  _directParent.toString = function () {
    return 'directParent';
  };

  _anyChild = function anyChild(node, funcs, index, targetFunc, targetCtx, single) {
    var child, j, len, ref;
    ref = node.children;

    for (j = 0, len = ref.length; j < len; j++) {
      child = ref[j];

      if (child instanceof Tag && child.name === 'blank') {
        if (_anyChild(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
      } else {
        if (test(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
      }
    }

    return false;
  };

  _anyChild.isIterator = true;
  _anyChild.priority = DEFAULT_PRIORITY;

  _anyChild.toString = function () {
    return 'anyChild';
  };

  _anyParent = function anyParent(node, funcs, index, targetFunc, targetCtx, single) {
    var parent;

    if (parent = node._parent) {
      if (test(parent, funcs, index, targetFunc, targetCtx, single)) {
        return true;
      } else {
        return _anyParent(parent, funcs, index, targetFunc, targetCtx, single);
      }
    }

    return false;
  };

  _anyParent.isIterator = true;
  _anyParent.priority = DEFAULT_PRIORITY;

  _anyParent.toString = function () {
    return 'anyParent';
  };

  byName = function byName(node, data1) {
    if (node instanceof Tag) {
      return node.name === data1;
    } else if (data1 === '#text' && node instanceof Text) {
      return true;
    }
  };

  byName.isIterator = false;
  byName.priority = ELEMENTS_PRIORITY;

  byName.toString = function () {
    return 'byName';
  };

  byInstance = function byInstance(node, data1) {
    return node instanceof data1;
  };

  byInstance.isIterator = false;
  byInstance.priority = DEFAULT_PRIORITY;

  byInstance.toString = function () {
    return 'byInstance';
  };

  byTag = function byTag(node, data1) {
    return node === data1;
  };

  byTag.isIterator = false;
  byTag.priority = DEFAULT_PRIORITY;

  byTag.toString = function () {
    return 'byTag';
  };

  byProp = function byProp(node, data1) {
    if (node instanceof Tag) {
      return node.props[data1] !== void 0;
    } else {
      return false;
    }
  };

  byProp.isIterator = false;
  byProp.priority = ATTRS_PRIORITY;

  byProp.toString = function () {
    return 'byProp';
  };

  byPropValue = function byPropValue(node, data1, data2) {
    if (node instanceof Tag) {
      return node.props[data1] == data2;
    } else {
      return false;
    }
  };

  byPropValue.isIterator = false;
  byPropValue.priority = ATTRS_PRIORITY;

  byPropValue.toString = function () {
    return 'byPropValue';
  };

  byPropStartsWithValue = function byPropStartsWithValue(node, data1, data2) {
    var prop;

    if (node instanceof Tag) {
      prop = node.props[data1];

      if (typeof prop === 'string') {
        return prop.indexOf(data2) === 0;
      }
    }

    return false;
  };

  byPropStartsWithValue.isIterator = false;
  byPropStartsWithValue.priority = ATTRS_PRIORITY;

  byPropStartsWithValue.toString = function () {
    return 'byPropStartsWithValue';
  };

  byPropEndsWithValue = function byPropEndsWithValue(node, data1, data2) {
    var prop;

    if (node instanceof Tag) {
      prop = node.props[data1];

      if (typeof prop === 'string') {
        return prop.indexOf(data2, prop.length - data2.length) > -1;
      }
    }

    return false;
  };

  byPropEndsWithValue.isIterator = false;
  byPropEndsWithValue.priority = ATTRS_PRIORITY;

  byPropEndsWithValue.toString = function () {
    return 'byPropEndsWithValue';
  };

  byPropContainsValue = function byPropContainsValue(node, data1, data2) {
    var prop;

    if (node instanceof Tag) {
      prop = node.props[data1];

      if (typeof prop === 'string') {
        return prop.indexOf(data2) > -1;
      }
    }

    return false;
  };

  byPropContainsValue.isIterator = false;
  byPropContainsValue.priority = ATTRS_PRIORITY;

  byPropContainsValue.toString = function () {
    return 'byPropContainsValue';
  };

  TYPE = /^#?[a-zA-Z0-9|\-:_]+/;
  DEEP = /^([ ]*)>([ ]*)|^([ ]+)/;
  ATTR_SEARCH = /^\[([^\]]+?)\]/;
  ATTR_VALUE_SEARCH = /^\[([^=]+?)=([^\]]+?)\]/;
  ATTR_CLASS_SEARCH = /^\.([a-zA-Z0-9|\-_]+)/;
  STARTS_WITH = /\^$/;
  ENDS_WITH = /\$$/;
  CONTAINS = /\*$/;
  TRIM_ATTR_VALUE = /(?:'|")?([^'"]*)/;
  ATTR_VALUES = {
    __proto__: null,
    'true': true,
    'false': false,
    'null': null,
    'undefined': void 0
  };
  i = 0;
  OPTS_QUERY_BY_PARENTS = 1 << i++;
  OPTS_REVERSED = 1 << i++;
  OPTS_ADD_ANCHOR = 1 << i++;
  MAX_QUERIES_CACHE_LENGTH = 2000;
  QUERIES_CACHE_OVERFLOW_REDUCTION = 100;
  queriesCache = [];
  queriesCacheLengths = [];

  getQueries = function getQueries(selector, opts) {
    var _, arrFunc, cache, closeTagFunc, deep, distantTagFunc, exec, firstFunc, func, funcs, j, key, len, name, queries, r, ref, removed, reversed, reversedArrFunc, sel, val;

    if (opts == null) {
      opts = 0;
    }

    reversed = !!(opts & OPTS_REVERSED);

    if (r = (ref = queriesCache[opts]) != null ? ref[selector] : void 0) {
      return r;
    }

    distantTagFunc = reversed ? _anyParent : _anyDescendant;
    closeTagFunc = reversed ? _directParent : _anyChild;
    arrFunc = reversed ? 'unshift' : 'push';
    reversedArrFunc = reversed ? 'push' : 'unshift';
    funcs = [];
    queries = [funcs];
    sel = selector.trim();

    while (sel.length) {
      if (sel[0] === '*') {
        sel = sel.slice(1);
        funcs[arrFunc](byInstance, Tag, null);
      } else if (sel[0] === '&') {
        sel = sel.slice(1);

        if (!(opts & OPTS_QUERY_BY_PARENTS)) {
          funcs[arrFunc](byTag, null, null);
        }
      } else if (exec = TYPE.exec(sel)) {
        sel = sel.slice(exec[0].length);
        name = exec[0];
        funcs[arrFunc](byName, name, null);
      } else if (exec = ATTR_VALUE_SEARCH.exec(sel)) {
        sel = sel.slice(exec[0].length);
        _ = exec[0], name = exec[1], val = exec[2];

        if (val in ATTR_VALUES) {
          val = ATTR_VALUES[val];
        } else {
          val = TRIM_ATTR_VALUE.exec(val)[1];
        }

        if (STARTS_WITH.test(name)) {
          func = byPropStartsWithValue;
        } else if (ENDS_WITH.test(name)) {
          func = byPropEndsWithValue;
        } else if (CONTAINS.test(name)) {
          func = byPropContainsValue;
        } else {
          func = byPropValue;
        }

        if (func !== byPropValue) {
          name = name.slice(0, -1);
        }

        funcs[arrFunc](func, name, val);
      } else if (exec = ATTR_SEARCH.exec(sel)) {
        sel = sel.slice(exec[0].length);
        funcs[arrFunc](byProp, exec[1], null);
      } else if (exec = ATTR_CLASS_SEARCH.exec(sel)) {
        sel = sel.slice(exec[0].length);
        funcs[arrFunc](byPropContainsValue, 'class', exec[1]);
      } else if (exec = DEEP.exec(sel)) {
        sel = sel.slice(exec[0].length);
        deep = exec[0].trim();

        if (deep === '') {
          funcs[arrFunc](distantTagFunc, null, null);
        } else if (deep === '>') {
          funcs[arrFunc](closeTagFunc, null, null);
        }
      } else if (sel[0] === ',') {
        funcs = [];
        queries.push(funcs);
        sel = sel.slice(1);
        sel = sel.trim();
      } else {
        throw new Error("queryAll: unexpected selector '" + sel + "' in '" + selector + "'");
      }
    }

    for (j = 0, len = queries.length; j < len; j++) {
      funcs = queries[j];
      firstFunc = reversed && !(opts & OPTS_QUERY_BY_PARENTS) ? funcs[funcs.length - 3] : funcs[0];

      if (firstFunc === byTag) {
        continue;
      }

      if (opts & OPTS_QUERY_BY_PARENTS && !(firstFunc != null ? firstFunc.isIterator : void 0)) {
        funcs[arrFunc](distantTagFunc, null, null);
      } else if (reversed && !(firstFunc != null ? firstFunc.isIterator : void 0)) {
        funcs[reversedArrFunc](distantTagFunc, null, null);
      } else if (!reversed && !(firstFunc != null ? firstFunc.isIterator : void 0)) {
        funcs[reversedArrFunc](distantTagFunc, null, null);
      }

      if (opts & OPTS_ADD_ANCHOR) {
        funcs[reversedArrFunc](byTag, null, null);
      }
    }

    if (!(cache = queriesCache[opts])) {
      cache = queriesCache[opts] = {};
      queriesCacheLengths[opts] = 0;
    }

    cache[selector] = queries;

    if ((queriesCacheLengths[opts] += 1) > MAX_QUERIES_CACHE_LENGTH) {
      removed = 0;

      for (key in cache) {
        delete cache[key];
        removed += 1;

        if (removed >= QUERIES_CACHE_OVERFLOW_REDUCTION) {
          break;
        }
      }

      queriesCacheLengths[opts] -= removed;
    }

    return queries;
  };

  Watcher = function (superClass) {
    var NOP, lastUid, pool;
    extend(Watcher, superClass);

    NOP = function NOP() {};

    lastUid = 0;
    pool = [];

    Watcher.create = function (node, queries) {
      var nodeWatchers, watcher;

      if (pool.length) {
        watcher = pool.pop();
        watcher.node = node;
        watcher.queries = queries;
        watcher._forceUpdate = true;
      } else {
        watcher = new Watcher(node, queries);
      }

      nodeWatchers = node._watchers != null ? node._watchers : node._watchers = [];
      nodeWatchers.push(watcher);
      return watcher;
    };

    function Watcher(node, queries) {
      Watcher.__super__.constructor.call(this);

      this._forceUpdate = true;
      this.node = node;
      this.queries = queries;
      this.uid = lastUid++ + '';
      this.nodes = [];
      this.nodesToAdd = [];
      this.nodesToRemove = [];
      this.nodesWillChange = false;
      Object.seal(this);
    }

    SignalsEmitter.createSignal(Watcher, 'onAdd');
    SignalsEmitter.createSignal(Watcher, 'onRemove');

    Watcher.prototype.test = function (tag) {
      var funcs, j, len, ref;
      ref = this.queries;

      for (j = 0, len = ref.length; j < len; j++) {
        funcs = ref[j];
        funcs[funcs.length - 2] = this.node;

        if (test(tag, funcs, 0, NOP, null, true)) {
          return true;
        }
      }

      return false;
    };

    Watcher.prototype.disconnect = function () {
      var node, nodes, nodesToAdd, nodesToRemove, ref, uid;
      assert.ok(this.node);
      ref = this, uid = ref.uid, node = ref.node, nodes = ref.nodes, nodesToAdd = ref.nodesToAdd, nodesToRemove = ref.nodesToRemove;
      utils.remove(node._watchers, this);

      while (node = nodesToAdd.pop()) {
        delete node._inWatchers[uid];
      }

      while (node = nodesToRemove.pop()) {
        this.emit('onRemove', node);
      }

      while (node = nodes.pop()) {
        delete node._inWatchers[uid];
        this.emit('onRemove', node);
      }

      this.onAdd.disconnectAll();
      this.onRemove.disconnectAll();
      this.node = this.queries = null;
      pool.push(this);
    };

    return Watcher;
  }(SignalsEmitter);

  module.exports = function (Element, _Tag) {
    var checkWatchersDeeply, query, queryAll;
    Tag = _Tag;
    Text = Element.Text;
    return {
      getSelectorCommandsLength: module.exports.getSelectorCommandsLength,
      queryAll: queryAll = function queryAll(selector, target, targetCtx, opts) {
        var func, funcs, j, len, queries;

        if (target == null) {
          target = [];
        }

        if (targetCtx == null) {
          targetCtx = target;
        }

        if (opts == null) {
          opts = 0;
        }

        assert.isString(selector);
        assert.notLengthOf(selector, 0);

        if (typeof target !== 'function') {
          assert.isArray(target);
        }

        queries = getQueries(selector, opts);
        func = Array.isArray(target) ? target.push : target;

        for (j = 0, len = queries.length; j < len; j++) {
          funcs = queries[j];
          funcs[0](this, funcs, 3, func, targetCtx, false);
        }

        if (Array.isArray(target)) {
          return target;
        }
      },
      queryAllParents: function queryAllParents(selector, target, targetCtx) {
        var func, _onNode, opts;

        if (target == null) {
          target = [];
        }

        if (targetCtx == null) {
          targetCtx = target;
        }

        if (typeof target !== 'function') {
          assert.isArray(target);
        }

        func = Array.isArray(target) ? target.push : target;
        opts = OPTS_REVERSED | OPTS_QUERY_BY_PARENTS;

        _onNode = function onNode(node) {
          func.call(targetCtx, node);
          queryAll.call(node, selector, _onNode, null, opts);
        };

        queryAll.call(this, selector, _onNode, null, opts);

        if (Array.isArray(target)) {
          return target;
        }
      },
      query: query = function () {
        var result, resultFunc;
        result = null;

        resultFunc = function resultFunc(arg) {
          return result = arg;
        };

        return function (selector, opts) {
          var funcs, j, len, queries;

          if (opts == null) {
            opts = 0;
          }

          assert.isString(selector);
          assert.notLengthOf(selector, 0);
          queries = getQueries(selector, opts);

          for (j = 0, len = queries.length; j < len; j++) {
            funcs = queries[j];

            if (funcs[0](this, funcs, 3, resultFunc, null, true)) {
              return result;
            }
          }

          return null;
        };
      }(),
      queryParents: function queryParents(selector) {
        return query.call(this, selector, OPTS_REVERSED | OPTS_QUERY_BY_PARENTS);
      },
      watch: function watch(selector) {
        var queries, watcher;
        assert.isString(selector);
        assert.notLengthOf(selector, 0);
        queries = getQueries(selector, OPTS_REVERSED | OPTS_ADD_ANCHOR);
        watcher = Watcher.create(this, queries);
        checkWatchersDeeply(this);
        return watcher;
      },
      checkWatchersDeeply: checkWatchersDeeply = function () {
        var CHECK_WATCHERS_CHILDREN, CHECK_WATCHERS_IS_MASTER_NODE, CHECK_WATCHERS_THIS, _checkNodeRec, invalidateWatcher, isChildOf, masterNodes, pending, updateWatchers, updateWatchersQueue, watchersToUpdate;

        pending = false;
        masterNodes = [];
        watchersToUpdate = [];
        updateWatchersQueue = [];
        i = 0;
        CHECK_WATCHERS_THIS = 1 << i++;
        CHECK_WATCHERS_CHILDREN = 1 << i++;
        CHECK_WATCHERS_IS_MASTER_NODE = 1 << i++;

        invalidateWatcher = function invalidateWatcher(watcher) {
          if (!watcher.nodesWillChange) {
            watchersToUpdate.push(watcher);
            watcher.nodesWillChange = true;
          }
        };

        isChildOf = function isChildOf(child, parent) {
          var tmp;
          tmp = child;

          while (tmp = tmp._parent) {
            if (tmp === parent) {
              return true;
            }
          }

          return false;
        };

        _checkNodeRec = function checkNodeRec(node, watchersQueue, flags, hasForcedWatcher) {
          var checkWatchers, childNode, inWatchers, j, k, l, len, len1, len2, m, n, nodes, ref, ref1, watcher, watcherNode, watcherUid, watchers;
          checkWatchers = node._checkWatchers;
          flags |= checkWatchers;

          if (watchers = node._watchers) {
            for (j = 0, len = watchers.length; j < len; j++) {
              watcher = watchers[j];
              watchersQueue.push(watcher);

              if (!hasForcedWatcher && watcher._forceUpdate) {
                hasForcedWatcher = true;
              }

              watcherNode = watcher.node;
              nodes = watcher.nodes;
              i = n = nodes.length;

              while (i-- > 0) {
                childNode = nodes[i];

                if (childNode !== watcherNode && !isChildOf(childNode, watcherNode)) {
                  delete childNode._inWatchers[watcher.uid];
                  nodes[i] = nodes[n - 1];
                  nodes.pop();
                  watcher.nodesToRemove.push(childNode);
                  invalidateWatcher(watcher);
                  n--;
                }
              }
            }
          }

          if (hasForcedWatcher || flags & CHECK_WATCHERS_THIS) {
            inWatchers = node._inWatchers;

            for (k = 0, len1 = watchersQueue.length; k < len1; k++) {
              watcher = watchersQueue[k];

              if (hasForcedWatcher && !watcher._forceUpdate && !(flags & CHECK_WATCHERS_THIS)) {
                continue;
              }

              watcherUid = watcher.uid;

              if ((!inWatchers || !inWatchers[watcherUid]) && watcher.test(node)) {
                if (!inWatchers) {
                  inWatchers = node._inWatchers = {};
                }

                inWatchers[watcherUid] = true;
                watcher.nodesToAdd.push(node);
                invalidateWatcher(watcher);
              } else if (inWatchers && inWatchers[watcherUid] && !watcher.test(node)) {
                delete inWatchers[watcherUid];
                utils.removeFromUnorderedArray(watcher.nodes, node);
                watcher.nodesToRemove.push(node);
                invalidateWatcher(watcher);
              }
            }
          }

          if (flags & CHECK_WATCHERS_CHILDREN && node instanceof Tag) {
            ref = node.children;

            for (l = 0, len2 = ref.length; l < len2; l++) {
              childNode = ref[l];

              if (hasForcedWatcher || flags & CHECK_WATCHERS_THIS || childNode._checkWatchers > 0) {
                _checkNodeRec(childNode, watchersQueue, flags, hasForcedWatcher);
              }
            }
          }

          if (watchers) {
            for (i = m = 0, ref1 = watchers.length; m < ref1; i = m += 1) {
              watcher = watchersQueue.pop();
            }
          }

          node._checkWatchers = 0;
        };

        updateWatchers = function updateWatchers() {
          var masterNode, node, nodesToAdd, nodesToRemove, watcher;
          pending = false;

          while (masterNode = masterNodes.pop()) {
            if (!masterNode._parent) {
              _checkNodeRec(masterNode, updateWatchersQueue, 0, false);
            }
          }

          while (watcher = watchersToUpdate.pop()) {
            nodesToAdd = watcher.nodesToAdd, nodesToRemove = watcher.nodesToRemove;

            while (node = nodesToRemove.pop()) {
              watcher.emit('onRemove', node);
            }

            while (node = nodesToAdd.pop()) {
              watcher.nodes.push(node);
              watcher.emit('onAdd', node);
            }

            watcher.nodesWillChange = false;
          }
        };

        return function (node, parent) {
          var tmp;

          if (parent == null) {
            parent = node._parent;
          }

          node._checkWatchers |= CHECK_WATCHERS_THIS;

          if (node instanceof Tag) {
            node._checkWatchers |= CHECK_WATCHERS_CHILDREN;
          }

          tmp = node;

          while (parent) {
            tmp = parent;

            if (tmp._checkWatchers & CHECK_WATCHERS_CHILDREN) {
              break;
            }

            tmp._checkWatchers |= CHECK_WATCHERS_CHILDREN;
            parent = tmp._parent;
          }

          if (!parent) {
            if (!(tmp._checkWatchers & CHECK_WATCHERS_IS_MASTER_NODE)) {
              masterNodes.push(tmp);
              tmp._checkWatchers |= CHECK_WATCHERS_IS_MASTER_NODE;
            }
          }

          if (!pending) {
            pending = true;
            eventLoop.setImmediate(updateWatchers);
          }
        };
      }()
    };
  };

  module.exports.getSelectorCommandsLength = function (selector, beginQuery, endQuery) {
    var j, len, queries, query, sum;

    if (beginQuery == null) {
      beginQuery = 0;
    }

    if (endQuery == null) {
      endQuery = 2e308;
    }

    sum = 0;
    queries = getQueries(selector, 0);

    for (i = j = 0, len = queries.length; j < len; i = ++j) {
      query = queries[i];

      if (i < beginQuery) {
        continue;
      }

      if (i >= endQuery) {
        break;
      }

      sum += query.length;
    }

    return sum;
  };

  module.exports.getSelectorPriority = function (selector, beginQuery, endQuery) {
    var func, j, k, len, len1, queries, query, sum;

    if (beginQuery == null) {
      beginQuery = 0;
    }

    if (endQuery == null) {
      endQuery = 2e308;
    }

    sum = 0;
    queries = getQueries(selector, 0);

    for (i = j = 0, len = queries.length; j < len; i = ++j) {
      query = queries[i];

      if (i < beginQuery) {
        continue;
      }

      if (i >= endQuery) {
        break;
      }

      for (k = 0, len1 = query.length; k < len1; k += 3) {
        func = query[k];
        sum += func.priority;
      }
    }

    return sum;
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../signal":"WtLN","../../../../event-loop":"jt0G","../../../../assert":"lQvG"}],"+F8w":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      TagQuery,
      assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../assert');
  utils = require('../../../util');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  log = require('../../../log');
  TagQuery = require('../../../document/element/element/tag/query');
  log = log.scope('Rendering', 'Class');

  module.exports = function (Renderer, Impl, itemUtils) {
    var ATTRS_ALIAS, ATTRS_CONFLICTS, ChangesObject, Class, ClassChildDocument, ClassDocument, ElementTarget, classListSortFunc, cloneClassChild, cloneClassWithNoDocument, disableClass, enableClass, getContainedAlias, getContainedAttribute, getContainedAttributeOrAlias, getObjectByPath, getPropertyDefaultValue, ifClassListWillChange, loadObjects, _runQueue, saveAndDisableClass, saveAndEnableClass, setAttribute, splitAttribute, unloadObjects, updateChildPriorities, updateClassList, _updatePriorities, updateTargetClass;

    ChangesObject = function () {
      function ChangesObject() {
        this._attributes = Object.create(null);
        this._bindings = Object.create(null);
      }

      ChangesObject.prototype.setAttribute = function (prop, val) {
        this._attributes[prop] = val;
      };

      ChangesObject.prototype.setBinding = function (prop, val) {
        this._attributes[prop] = val;
        this._bindings[prop] = true;
      };

      return ChangesObject;
    }();

    Class = function (superClass) {
      var CHANGES_OMIT_ATTRIBUTES, ChildrenObject, lastUid;
      extend(Class, superClass);
      Class.__name__ = 'Class';

      Class.New = function (opts) {
        var item;
        item = new Class();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      lastUid = 0;

      function Class() {
        Class.__super__.constructor.call(this);

        this._classUid = String(lastUid++);
        this._priority = 0;
        this._inheritsPriority = 0;
        this._nestingPriority = 0;
        this._changes = null;
        this._document = null;
        this._children = null;
        this._nesting = null;
      }

      itemUtils.defineProperty({
        constructor: Class,
        name: 'target',
        developmentSetter: function developmentSetter(val) {
          if (val != null) {
            return assert.instanceOf(val, itemUtils.Object);
          }
        },
        setter: function setter(_super) {
          return function (val) {
            var isRunning, oldVal, ref1, ref2, ref3;
            oldVal = this._target;

            if (oldVal === val) {
              return;
            }

            isRunning = this._running;

            if (isRunning) {
              this.running = false;
            }

            if (oldVal) {
              utils.remove(oldVal._extensions, this);

              if (this._running && !((ref1 = this._document) != null ? ref1._query : void 0)) {
                unloadObjects(this, oldVal);
              }
            }

            _super.call(this, val);

            if (val) {
              val._extensions.push(this);

              if (this._priority !== -1 && !((ref2 = this._bindings) != null ? ref2.running : void 0) && !((ref3 = this._document) != null ? ref3._query : void 0)) {
                this.running = true;
              }
            }

            if (isRunning) {
              this.running = true;
            }
          };
        }
      });
      CHANGES_OMIT_ATTRIBUTES = {
        __proto__: null,
        id: true,
        properties: true,
        signals: true,
        children: true
      };
      utils.defineProperty(Class.prototype, 'changes', null, function () {
        return this._changes || (this._changes = new ChangesObject());
      }, function (obj) {
        var changes, isRunning, prop, val;

        if (obj == null) {
          obj = {};
        }

        assert.isObject(obj);
        isRunning = this._running && !!this._target;

        if (isRunning) {
          updateTargetClass(disableClass, this._target, this);
        }

        this._changes = new ChangesObject();
        changes = this._changes;

        for (prop in obj) {
          val = obj[prop];

          if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            changes.setBinding(prop, val);
          } else if (!CHANGES_OMIT_ATTRIBUTES[prop]) {
            changes.setAttribute(prop, val);
          }
        }

        if (isRunning) {
          updateTargetClass(enableClass, this._target, this);
        }
      });
      itemUtils.defineProperty({
        constructor: Class,
        name: 'priority',
        defaultValue: 0,
        developmentSetter: function developmentSetter(val) {
          return assert.isInteger(val);
        },
        setter: function setter(_super) {
          return function (val) {
            _super.call(this, val);

            _updatePriorities(this);
          };
        }
      });

      Class.prototype._enable = function () {
        var classElem, docQuery, j, len, ref1, ref2, ref3;
        assert.ok(this._running);
        docQuery = (ref1 = this._document) != null ? ref1._query : void 0;

        if (!this._target || docQuery) {
          if (docQuery) {
            ref2 = this._document._classesInUse;

            for (j = 0, len = ref2.length; j < len; j++) {
              classElem = ref2[j];
              classElem.running = true;
            }
          }

          return;
        }

        updateTargetClass(saveAndEnableClass, this._target, this);

        if (!((ref3 = this._document) != null ? ref3._query : void 0)) {
          loadObjects(this, this._target);
        }
      };

      Class.prototype._disable = function () {
        var classElem, j, len, ref1, ref2;
        assert.notOk(this._running);

        if (!this._target) {
          if (this._document && this._document._query) {
            ref1 = this._document._classesInUse;

            for (j = 0, len = ref1.length; j < len; j++) {
              classElem = ref1[j];
              classElem.running = false;
            }
          }

          return;
        }

        if (!((ref2 = this._document) != null ? ref2._query : void 0)) {
          unloadObjects(this, this._target);
        }

        updateTargetClass(saveAndDisableClass, this._target, this);
      };

      utils.defineProperty(Class.prototype, 'children', null, function () {
        return this._children || (this._children = new ChildrenObject(this));
      }, function (val) {
        var child, children, j, len, length;
        children = this.children;
        length = children.length;

        while (length--) {
          children.pop(length);
        }

        if (val) {
          assert.isArray(val);

          for (j = 0, len = val.length; j < len; j++) {
            child = val[j];
            children.append(child);
          }
        }
      });
      utils.defineProperty(Class.prototype, 'nesting', null, null, function (val) {
        assert.notOk(this._running);
        this._nesting = val;
      });

      ChildrenObject = function () {
        function ChildrenObject(ref) {
          this._ref = ref;
          this.length = 0;
        }

        ChildrenObject.prototype.append = function (val) {
          assert.instanceOf(val, itemUtils.Object);
          assert.isNot(val, this._ref);

          if (val instanceof Class) {
            updateChildPriorities(this._ref, val);
          }

          this[this.length++] = val;
          return val;
        };

        ChildrenObject.prototype.pop = function (i) {
          var oldVal;

          if (i == null) {
            i = this.length - 1;
          }

          assert.operator(i, '>=', 0);
          assert.operator(i, '<', this.length);
          oldVal = this[i];
          delete this[i];
          --this.length;
          return oldVal;
        };

        return ChildrenObject;
      }();

      Class.prototype.clone = function () {
        var arr, clone, cloneDoc, doc, name, ref1;
        clone = cloneClassWithNoDocument.call(this);

        if (doc = this._document) {
          cloneDoc = clone.document;
          cloneDoc.query = doc.query;
          ref1 = doc._signals;

          for (name in ref1) {
            arr = ref1[name];
            cloneDoc._signals[name] = utils.clone(arr);
          }
        }

        return clone;
      };

      return Class;
    }(Renderer.Extension);

    loadObjects = function loadObjects(classElem, item) {
      var child, children, j, len;

      if (children = classElem._children) {
        for (j = 0, len = children.length; j < len; j++) {
          child = children[j];

          if (child instanceof Renderer.Item) {
            if (child.parent == null) {
              child.parent = item;
            }
          } else {
            if (child instanceof Class) {
              updateChildPriorities(classElem, child);
            }

            if (child.target == null) {
              child.target = item;
            }
          }
        }
      }
    };

    unloadObjects = function unloadObjects(classElem, item) {
      var child, children, j, len;

      if (children = classElem._children) {
        for (j = 0, len = children.length; j < len; j++) {
          child = children[j];

          if (child instanceof Renderer.Item) {
            if (child.parent === item) {
              child.parent = null;
            }
          } else {
            if (child.target === item) {
              child.target = null;
            }
          }
        }
      }
    };

    updateChildPriorities = function updateChildPriorities(parent, child) {
      var ref1;
      child._inheritsPriority = parent._inheritsPriority + parent._priority;
      child._nestingPriority = parent._nestingPriority + 1 + (((ref1 = child._document) != null ? ref1._priority : void 0) || 0);

      _updatePriorities(child);
    };

    _updatePriorities = function updatePriorities(classElem) {
      var _inheritsPriority, _nestingPriority, child, children, document, j, k, l, len, len1, len2, ref1, ref2, target;

      if (classElem._running && ifClassListWillChange(classElem)) {
        target = classElem._target;
        updateTargetClass(disableClass, target, classElem);
        updateClassList(target);
        updateTargetClass(enableClass, target, classElem);
      }

      if (children = classElem._children) {
        for (j = 0, len = children.length; j < len; j++) {
          child = children[j];

          if (child instanceof Class) {
            updateChildPriorities(classElem, child);
          }
        }
      }

      if (document = classElem._document) {
        _inheritsPriority = classElem._inheritsPriority, _nestingPriority = classElem._nestingPriority;
        ref1 = document._classesInUse;

        for (k = 0, len1 = ref1.length; k < len1; k++) {
          child = ref1[k];
          child._inheritsPriority = _inheritsPriority;
          child._nestingPriority = _nestingPriority;

          _updatePriorities(child);
        }

        ref2 = document._classesPool;

        for (l = 0, len2 = ref2.length; l < len2; l++) {
          child = ref2[l];
          child._inheritsPriority = _inheritsPriority;
          child._nestingPriority = _nestingPriority;
        }
      }
    };

    ifClassListWillChange = function ifClassListWillChange(classElem) {
      var classList, index, target;

      if (!(target = classElem._target)) {
        return false;
      }

      classList = target._classList;
      index = classList.indexOf(classElem);

      if (index > 0 && classListSortFunc(classElem, classList[index - 1]) < 0) {
        return true;
      }

      if (index < classList.length - 1 && classListSortFunc(classElem, classList[index + 1]) > 0) {
        return true;
      }

      return false;
    };

    classListSortFunc = function classListSortFunc(a, b) {
      return b._priority + b._inheritsPriority - (a._priority + a._inheritsPriority) || b._nestingPriority - a._nestingPriority;
    };

    updateClassList = function updateClassList(item) {
      return item._classList.sort(classListSortFunc);
    };

    cloneClassChild = function cloneClassChild(classElem, child) {
      return child.clone();
    };

    cloneClassWithNoDocument = function cloneClassWithNoDocument() {
      var child, childClone, children, clone, i, j, k, len, len1, prop, ref1, ref2, val;
      clone = Class.New();
      clone.id = this.id;
      clone._classUid = this._classUid;
      clone._priority = this._priority;
      clone._inheritsPriority = this._inheritsPriority;
      clone._nestingPriority = this._nestingPriority;
      clone._changes = this._changes;
      clone._nesting = this._nesting;

      if (this._bindings) {
        ref1 = this._bindings;

        for (prop in ref1) {
          val = ref1[prop];
          clone.createBinding(prop, val);
        }
      }

      if (children = this._children) {
        for (i = j = 0, len = children.length; j < len; i = ++j) {
          child = children[i];
          childClone = cloneClassChild(clone, child);
          clone.children.append(childClone);
        }
      }

      if (typeof this._nesting === 'function') {
        ref2 = this._nesting();

        for (k = 0, len1 = ref2.length; k < len1; k++) {
          child = ref2[k];
          clone.children.append(child);
        }
      }

      return clone;
    };

    splitAttribute = itemUtils.splitAttribute, getObjectByPath = itemUtils.getObjectByPath;

    setAttribute = function setAttribute(item, attr, val) {
      var object, path;
      path = splitAttribute(attr);

      if (object = getObjectByPath(item, path)) {
        object[path[path.length - 1]] = val;
      }
    };

    saveAndEnableClass = function saveAndEnableClass(item, classElem) {
      assert.notOk(utils.has(item._classList, classElem));

      item._classList.unshift(classElem);

      if (ifClassListWillChange(classElem)) {
        updateClassList(item);
      }

      return enableClass(item, classElem);
    };

    saveAndDisableClass = function saveAndDisableClass(item, classElem) {
      assert.ok(utils.has(item._classList, classElem));
      disableClass(item, classElem);
      return utils.remove(item._classList, classElem);
    };

    ATTRS_CONFLICTS = [['x', 'anchors.left', 'anchors.right', 'anchors.horizontalCenter', 'anchors.centerIn'], ['y', 'anchors.top', 'anchors.bottom', 'anchors.verticalCenter', 'anchors.centerIn'], ['width', 'anchors.fill', 'anchors.fillWidth', 'fillWidth'], ['height', 'anchors.fill', 'anchors.fillHeight', 'fillHeight']];
    ATTRS_ALIAS = Object.create(null);

    (function () {
      var alias, aliases, arr, j, k, l, len, len1, len2, prop;

      for (j = 0, len = ATTRS_CONFLICTS.length; j < len; j++) {
        aliases = ATTRS_CONFLICTS[j];

        for (k = 0, len1 = aliases.length; k < len1; k++) {
          prop = aliases[k];
          arr = ATTRS_ALIAS[prop] != null ? ATTRS_ALIAS[prop] : ATTRS_ALIAS[prop] = [];

          for (l = 0, len2 = aliases.length; l < len2; l++) {
            alias = aliases[l];

            if (alias !== prop) {
              arr.push(alias);
            }
          }
        }
      }
    })();

    getContainedAttribute = function getContainedAttribute(classElem, attr) {
      var attrs, changes;

      if (changes = classElem._changes) {
        attrs = changes._attributes;

        if (attrs[attr] !== void 0) {
          return attr;
        }
      }

      return '';
    };

    getContainedAlias = function getContainedAlias(classElem, attr) {
      var alias, aliases, attrs, changes, j, len;

      if (changes = classElem._changes) {
        attrs = changes._attributes;

        if (aliases = ATTRS_ALIAS[attr]) {
          for (j = 0, len = aliases.length; j < len; j++) {
            alias = aliases[j];

            if (attrs[alias] !== void 0) {
              return alias;
            }
          }
        }
      }

      return '';
    };

    getContainedAttributeOrAlias = function getContainedAttributeOrAlias(classElem, attr) {
      var alias, aliases, attrs, changes, j, len;

      if (changes = classElem._changes) {
        attrs = changes._attributes;

        if (attrs[attr] !== void 0) {
          return attr;
        } else if (aliases = ATTRS_ALIAS[attr]) {
          for (j = 0, len = aliases.length; j < len; j++) {
            alias = aliases[j];

            if (attrs[alias] !== void 0) {
              return alias;
            }
          }
        }
      }

      return '';
    };

    getPropertyDefaultValue = function getPropertyDefaultValue(obj, prop) {
      var innerProp, proto;
      proto = Object.getPrototypeOf(obj);
      innerProp = itemUtils.getInnerPropName(prop);

      if (innerProp in proto) {
        return proto[innerProp];
      } else {
        return proto[prop];
      }
    };

    enableClass = function enableClass(item, classElem) {
      var alias, attr, attributes, bindings, changes, classList, classListIndex, classListLength, defaultIsBinding, defaultValue, i, j, k, lastPath, object, path, ref1, ref2, ref3, ref4, ref5, val, writeAttr;
      assert.instanceOf(item, itemUtils.Object);
      assert.instanceOf(classElem, Class);
      classList = item._classList;
      classListIndex = classList.indexOf(classElem);
      classListLength = classList.length;

      if (classListIndex === -1) {
        return;
      }

      if (!(changes = classElem._changes)) {
        return;
      }

      attributes = changes._attributes;
      bindings = changes._bindings;

      for (attr in attributes) {
        val = attributes[attr];
        path = null;
        writeAttr = true;
        alias = '';

        for (i = j = ref1 = classListIndex - 1; j >= 0; i = j += -1) {
          if (getContainedAttributeOrAlias(classList[i], attr)) {
            writeAttr = false;
            break;
          }
        }

        if (writeAttr) {
          for (i = k = ref2 = classListIndex + 1, ref3 = classListLength; k < ref3; i = k += 1) {
            if (alias = getContainedAlias(classList[i], attr)) {
              path = splitAttribute(alias);
              object = getObjectByPath(item, path);
              lastPath = path[path.length - 1];

              if (!object) {
                continue;
              }

              defaultValue = getPropertyDefaultValue(object, lastPath);
              defaultIsBinding = !!classList[i].changes._bindings[alias];

              if (defaultIsBinding) {
                object.createBinding(lastPath, null, item);
              }

              object[lastPath] = defaultValue;
              break;
            }
          }

          if (attr !== alias || !path) {
            path = splitAttribute(attr);
            lastPath = path[path.length - 1];
            object = getObjectByPath(item, path);
          }

          if (!object || !(lastPath in object)) {
            //<development>;
            log.error("Attribute '" + attr + "' doesn't exist in '" + item + "'"); //</development>;

            continue;
          }

          if (bindings[attr]) {
            object.createBinding(lastPath, val, item);
          } else if (typeof val === 'function' && ((ref4 = object[lastPath]) != null ? ref4.connect : void 0)) {
            object[lastPath].connect(val, item);
          } else {
            if ((ref5 = object._bindings) != null ? ref5[lastPath] : void 0) {
              object.createBinding(lastPath, null, item);
            }

            object[lastPath] = val;
          }
        }
      }
    };

    disableClass = function disableClass(item, classElem) {
      var alias, attr, attributes, bindings, changes, classList, classListIndex, classListLength, defaultIsBinding, defaultValue, getAttributeMethod, i, j, k, lastPath, object, path, ref1, ref2, ref3, ref4, restoreDefault, val;
      assert.instanceOf(item, itemUtils.Object);
      assert.instanceOf(classElem, Class);
      classList = item._classList;
      classListIndex = classList.indexOf(classElem);
      classListLength = classList.length;

      if (classListIndex === -1) {
        return;
      }

      if (!(changes = classElem._changes)) {
        return;
      }

      attributes = changes._attributes;
      bindings = changes._bindings;

      for (attr in attributes) {
        val = attributes[attr];
        restoreDefault = true;

        for (i = j = ref1 = classListIndex - 1; j >= 0; i = j += -1) {
          if (getContainedAttributeOrAlias(classList[i], attr)) {
            restoreDefault = false;
            break;
          }
        }

        if (restoreDefault) {
          getAttributeMethod = getContainedAttribute;

          while (getAttributeMethod) {
            path = null;
            alias = '';
            defaultValue = void 0;
            defaultIsBinding = false;

            for (i = k = ref2 = classListIndex + 1, ref3 = classListLength; k < ref3; i = k += 1) {
              if (alias = getAttributeMethod(classList[i], attr)) {
                defaultValue = classList[i].changes._attributes[alias];
                defaultIsBinding = !!classList[i].changes._bindings[alias];
                break;
              }
            }

            if (getAttributeMethod === getContainedAttribute) {
              alias || (alias = attr);
              getAttributeMethod = getContainedAlias;
            } else {
              getAttributeMethod = null;
            }

            if (!alias) {
              continue;
            }

            if (!!bindings[attr]) {
              path = splitAttribute(attr);
              object = getObjectByPath(item, path);
              lastPath = path[path.length - 1];

              if (!object) {
                continue;
              }

              object.createBinding(lastPath, null, item);
            }

            if (attr !== alias || !path) {
              path = splitAttribute(alias);
              object = getObjectByPath(item, path);
              lastPath = path[path.length - 1];

              if (!object) {
                continue;
              }
            }

            if (defaultIsBinding) {
              object.createBinding(lastPath, defaultValue, item);
            } else if (typeof val === 'function' && ((ref4 = object[lastPath]) != null ? ref4.connect : void 0)) {
              object[lastPath].disconnect(val, item);
            } else {
              if (defaultValue === void 0) {
                defaultValue = getPropertyDefaultValue(object, lastPath);
              }

              object[lastPath] = defaultValue;
            }
          }
        }
      }
    };

    _runQueue = function runQueue(target) {
      var classElem, classQueue, func;
      classQueue = target._classQueue;
      func = classQueue[0], target = classQueue[1], classElem = classQueue[2];
      func(target, classElem);
      classQueue.shift();
      classQueue.shift();
      classQueue.shift();

      if (classQueue.length > 0) {
        _runQueue(target);
      }
    };

    updateTargetClass = function updateTargetClass(func, target, classElem) {
      var classQueue;
      classQueue = target._classQueue;
      classQueue.push(func, target, classElem);

      if (classQueue.length === 3) {
        _runQueue(target);
      }
    };

    ElementTarget = function (superClass) {
      extend(ElementTarget, superClass);

      function ElementTarget(element) {
        ElementTarget.__super__.constructor.call(this);

        this._element = element;
        Object.seal(this);
      }

      itemUtils.defineProperty({
        constructor: ElementTarget,
        name: 'element',
        defaultValue: null
      });
      return ElementTarget;
    }(itemUtils.Object);

    Class.ElementTarget = ElementTarget;

    ClassChildDocument = function () {
      function ClassChildDocument(parent) {
        this._ref = parent._ref;
        this._parent = parent;
        this._multiplicity = 0;
        Object.preventExtensions(this);
      }

      return ClassChildDocument;
    }();

    ClassDocument = function (superClass) {
      var connectNodeStyle, disconnectNodeStyle, getChildClass, onNodeAdd, onNodeRemove, onNodeStyleChange, onTargetChange;
      extend(ClassDocument, superClass);
      ClassDocument.__name__ = 'ClassDocument';
      itemUtils.defineProperty({
        constructor: Class,
        name: 'document',
        valueConstructor: ClassDocument
      });

      onTargetChange = function onTargetChange(oldVal) {
        var val;

        if (oldVal) {
          oldVal.onElementChange.disconnect(this.reloadQuery, this);
        }

        if (val = this._ref._target) {
          val.onElementChange.connect(this.reloadQuery, this);
        }

        if (oldVal !== val) {
          this.reloadQuery();
        }
      };

      function ClassDocument(ref) {
        this._query = '';
        this._classesInUse = [];
        this._classesPool = [];
        this._nodeWatcher = null;
        this._priority = 0;

        ClassDocument.__super__.constructor.call(this, ref);

        ref.onTargetChange.connect(onTargetChange, this);
        onTargetChange.call(this, ref._target);
      }

      SignalsEmitter.createSignal(ClassDocument, 'onNodeAdd');
      SignalsEmitter.createSignal(ClassDocument, 'onNodeRemove');
      itemUtils.defineProperty({
        constructor: ClassDocument,
        name: 'query',
        defaultValue: '',
        namespace: 'document',
        parentConstructor: ClassDocument,
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val);
        },
        setter: function setter(_super) {
          return function (val) {
            var cmdLen, oldPriority;
            assert.notOk(this._parent);

            if (this._query === val) {
              return;
            }

            if (!this._query) {
              unloadObjects(this, this._target);
            }

            _super.call(this, val);

            this.reloadQuery();

            if (this._ref._priority < 1) {
              cmdLen = TagQuery.getSelectorPriority(val, 0, 1);
              oldPriority = this._priority;
              this._priority = cmdLen;
              this._ref._nestingPriority += cmdLen - oldPriority;

              _updatePriorities(this._ref);
            }

            if (!val) {
              loadObjects(this, this._target);
            }
          };
        }
      });

      getChildClass = function getChildClass(style, parentClass) {
        var classElem, j, len, ref1, ref2;
        ref1 = style._extensions;

        for (j = 0, len = ref1.length; j < len; j++) {
          classElem = ref1[j];

          if (classElem instanceof Class) {
            if (((ref2 = classElem._document) != null ? ref2._parent : void 0) === parentClass) {
              return classElem;
            }
          }
        }
      };

      connectNodeStyle = function connectNodeStyle(style) {
        var classElem, j, len, ref1, ref2, uid;
        uid = this._ref._classUid;
        ref1 = style._extensions;

        for (j = 0, len = ref1.length; j < len; j++) {
          classElem = ref1[j];

          if (classElem instanceof Class) {
            if (classElem !== this._ref && classElem._classUid === uid && classElem._document instanceof ClassChildDocument) {
              classElem._document._multiplicity++;
              return;
            }
          }
        }

        if (!(classElem = this._classesPool.pop())) {
          classElem = cloneClassWithNoDocument.call(this._ref);
          classElem._document = new ClassChildDocument(this);
        }

        this._classesInUse.push(classElem);

        classElem.target = style;

        if (!((ref2 = classElem._bindings) != null ? ref2.running : void 0)) {
          classElem.running = true;
        }
      };

      disconnectNodeStyle = function disconnectNodeStyle(style) {
        var classElem;

        if (!(classElem = getChildClass(style, this))) {
          return;
        }

        if (classElem._document._multiplicity > 0) {
          classElem._document._multiplicity--;
          return;
        }

        classElem.target = null;
        utils.remove(this._classesInUse, classElem);

        this._classesPool.push(classElem);
      };

      onNodeStyleChange = function onNodeStyleChange(oldVal, val) {
        if (oldVal) {
          disconnectNodeStyle.call(this, oldVal);
        }

        if (val) {
          connectNodeStyle.call(this, val);
        }
      };

      onNodeAdd = function onNodeAdd(node) {
        var style;
        node.onStyleChange.connect(onNodeStyleChange, this);

        if (style = node._style) {
          connectNodeStyle.call(this, style);
        }

        this.emit('onNodeAdd', node);
      };

      onNodeRemove = function onNodeRemove(node) {
        var style;
        node.onStyleChange.disconnect(onNodeStyleChange, this);

        if (style = node._style) {
          disconnectNodeStyle.call(this, style);
        }

        this.emit('onNodeRemove', node);
      };

      ClassDocument.prototype.reloadQuery = function () {
        var classElem, node, query, ref1, target, watcher;

        if ((ref1 = this._nodeWatcher) != null) {
          ref1.disconnect();
        }

        this._nodeWatcher = null;

        while (classElem = this._classesInUse.pop()) {
          classElem.target = null;

          this._classesPool.push(classElem);
        }

        if ((query = this._query) && (target = this._ref.target) && (node = target.element) && node.watch) {
          watcher = this._nodeWatcher = node.watch(query);
          watcher.onAdd.connect(onNodeAdd, this);
          watcher.onRemove.connect(onNodeRemove, this);
        }
      };

      return ClassDocument;
    }(itemUtils.DeepObject);

    return Class;
  };
}).call(this);
},{"../../../assert":"lQvG","../../../util":"xr+4","../../../signal":"WtLN","../../../log":"fe8o","../../../document/element/element/tag/query":"6aTz"}],"Utkc":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  assert = require('../../../assert');
  SignalsEmitter = require('../../../signal').SignalsEmitter;

  module.exports = function (Renderer, Impl, itemUtils) {
    var Animation;
    return Animation = function (superClass) {
      extend(Animation, superClass);
      Animation.__name__ = 'Animation';

      function Animation() {
        Animation.__super__.constructor.call(this);

        this._loop = false;
        this._paused = false;
        this._reversed = false;
      }

      SignalsEmitter.createSignal(Animation, 'onStart');
      SignalsEmitter.createSignal(Animation, 'onStop');
      itemUtils.defineProperty({
        constructor: Animation,
        name: 'paused',
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        },
        setter: function setter(_super) {
          return function (val) {
            var oldVal;
            oldVal = this._paused;

            if (oldVal === val) {
              return;
            }

            _super.call(this, val);

            if (val) {
              Impl.pauseAnimation.call(this);
            } else {
              Impl.resumeAnimation.call(this);
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Animation,
        name: 'reversed',
        implementation: Impl.setAnimationReversed,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        }
      });
      itemUtils.defineProperty({
        constructor: Animation,
        name: 'loop',
        implementation: Impl.setAnimationLoop,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        }
      });

      Animation.prototype.start = function () {
        this.running = true;
        return this;
      };

      Animation.prototype.stop = function () {
        this.running = false;
        return this;
      };

      Animation.prototype.pause = function () {
        if (this.running) {
          this.paused = true;
        }

        return this;
      };

      Animation.prototype.resume = function () {
        this.paused = false;
        return this;
      };

      Animation.prototype._enable = function () {
        Impl.startAnimation.call(this);
        this.emit('onStart');

        if (this._paused) {
          return Impl.pauseAnimation.call(this);
        }
      };

      Animation.prototype._disable = function () {
        if (this._paused) {
          this.paused = false;
        }

        Impl.stopAnimation.call(this);
        return this.emit('onStop');
      };

      return Animation;
    }(Renderer.Extension);
  };
}).call(this);
},{"../../../util":"xr+4","../../../assert":"lQvG","../../../signal":"WtLN"}],"C8pE":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../../../../assert');
  log = require('../../../../../../log');
  log = log.scope('Renderer', 'PropertyAnimation', 'Easing');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Easing;
    return Easing = function (superClass) {
      var EASINGS, EASING_ALIASES, easing, i, len;
      extend(Easing, superClass);

      function Easing(ref) {
        this._type = 'Linear';
        this._steps = 1;

        Easing.__super__.constructor.call(this, ref);
      }

      EASINGS = ['Linear', 'InQuad', 'OutQuad', 'InOutQuad', 'InCubic', 'OutCubic', 'InOutCubic', 'InQuart', 'OutQuart', 'InOutQuart', 'InQuint', 'OutQuint', 'InOutQuint', 'InSine', 'OutSine', 'InOutSine', 'InExpo', 'OutExpo', 'InOutExpo', 'InCirc', 'OutCirc', 'InOutCirc', 'InElastic', 'OutElastic', 'InOutElastic', 'InBack', 'OutBack', 'InOutBack', 'InBounce', 'OutBounce', 'InOutBounce', 'Steps'];
      EASING_ALIASES = Object.create(null);

      for (i = 0, len = EASINGS.length; i < len; i++) {
        easing = EASINGS[i];
        EASING_ALIASES[easing] = easing;
        EASING_ALIASES[easing.toLowerCase()] = easing;
      }

      itemUtils.defineProperty({
        constructor: Easing,
        name: 'type',
        defaultValue: 'Linear',
        namespace: 'easing',
        implementation: Impl.setPropertyAnimationEasingType,
        developmentSetter: function developmentSetter(val) {
          if (val) {
            return assert.isString(val);
          }
        },
        setter: function setter(_super) {
          return function (val) {
            var type;

            if (!val) {
              val = 'Linear';
            }

            type = EASING_ALIASES[val];
            type || (type = EASING_ALIASES[val.toLowerCase()]);

            if (!type) {
              log.warn("Easing type '" + val + "' not recognized");
              type = 'Linear';
            }

            _super.call(this, type);
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Easing,
        name: 'steps',
        defaultValue: 1,
        namespace: 'easing',
        implementation: Impl.setPropertyAnimationEasingSteps,
        developmentSetter: function developmentSetter(val) {
          if (val) {
            assert.isInteger(val);
            return assert.operator(val, '>', 0);
          }
        }
      });
      return Easing;
    }(itemUtils.DeepObject);
  };
}).call(this);
},{"../../../../../../assert":"lQvG","../../../../../../log":"fe8o"}],"2FpY":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../../util');
  assert = require('../../../../../assert');
  log = require('../../../../../log');
  log = log.scope('Renderer', 'PropertyAnimation');

  module.exports = function (Renderer, Impl, itemUtils) {
    var PropertyAnimation;
    return PropertyAnimation = function (superClass) {
      var Easing, getter, setter;
      extend(PropertyAnimation, superClass);
      PropertyAnimation.__name__ = 'PropertyAnimation';

      (function (i) {
        PropertyAnimation.NEVER = 0;
        PropertyAnimation.ON_START = 1 << i++;
        PropertyAnimation.ON_STOP = 1 << i++;
        PropertyAnimation.ON_PENDING = 1 << i++;
        PropertyAnimation.ALWAYS = (1 << i) - 1;
        return PropertyAnimation.ON_END = PropertyAnimation.ON_STOP;
      })(0);

      function PropertyAnimation() {
        PropertyAnimation.__super__.constructor.call(this);

        this._property = '';
        this._autoFrom = true;
        this._duration = 250;
        this._startDelay = 0;
        this._loopDelay = 0;
        this._updateProperty = PropertyAnimation.ON_START | PropertyAnimation.ON_STOP;
        this._easing = null;
        this._updatePending = false;
      }

      getter = utils.lookupGetter(PropertyAnimation.prototype, 'running');
      setter = utils.lookupSetter(PropertyAnimation.prototype, 'running');
      utils.defineProperty(PropertyAnimation.prototype, 'running', null, getter, function (_super) {
        return function (val) {
          if (val && this._autoFrom && this._target) {
            this.from = this._target[this._property];
            this._autoFrom = true;
          }

          _super.call(this, val);
        };
      }(setter));
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'target',
        defaultValue: null,
        implementation: Impl.setPropertyAnimationTarget,
        setter: function setter(_super) {
          return function (val) {
            var oldVal;
            oldVal = this._target;

            if (oldVal) {
              if (this._running) {
                this._disable();
              }

              utils.remove(oldVal._extensions, this);
            }

            if (val) {
              val._extensions.push(this);
            }

            _super.call(this, val);

            if (val && this._running) {
              this._enable();
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'property',
        defaultValue: '',
        implementation: Impl.setPropertyAnimationProperty,
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val);
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'duration',
        defaultValue: 250,
        implementation: Impl.setPropertyAnimationDuration,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        },
        setter: function setter(_super) {
          return function (val) {
            if (val < 0) {
              _super.call(this, 0);
            } else {
              _super.call(this, val);
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'startDelay',
        defaultValue: 0,
        implementation: Impl.setPropertyAnimationStartDelay,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'loopDelay',
        defaultValue: 0,
        implementation: Impl.setPropertyAnimationLoopDelay,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'delay',
        defaultValue: 0,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        },
        getter: function getter(_super) {
          return function (val) {
            if (this._startDelay === this._loopDelay) {
              return this._startDelay;
            } else {
              throw new Error("startDelay and loopDelay are different");
            }
          };
        },
        setter: function setter(_super) {
          return function (val) {
            this.startDelay = val;
            this.loopDelay = val;

            _super.call(this, val);
          };
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'updateProperty',
        defaultValue: PropertyAnimation.ON_START | PropertyAnimation.ON_STOP,
        implementation: Impl.setPropertyAnimationUpdateProperty,
        developmentSetter: function developmentSetter(val) {
          var msg;
          msg = "PropertyAnimation::updateProperty needs to be a bitmask of PropertyAnimation.ON_START, PropertyAnimation.ON_STOP, PropertyAnimation.ON_PENDING or PropertyAnimation.NEVER, PropertyAnimation.ALWAYS";
          assert.isInteger(val, msg);
          assert.operator(val, '>=', PropertyAnimation.NEVER, msg);
          return assert.operator(val, '<=', PropertyAnimation.ALWAYS, msg);
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'from',
        implementation: Impl.setPropertyAnimationFrom,
        setter: function setter(_super) {
          return function (val) {
            this._autoFrom = false;

            _super.call(this, val);
          };
        }
      });
      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'to',
        implementation: Impl.setPropertyAnimationTo
      });
      utils.defineProperty(PropertyAnimation.prototype, 'progress', null, function () {
        return Impl.getPropertyAnimationProgress.call(this);
      }, null);
      utils.defineProperty(PropertyAnimation.prototype, 'updatePending', null, function () {
        return this._updatePending;
      }, null);
      Easing = require('./property/easing')(Renderer, Impl, itemUtils);
      utils.defineProperty(PropertyAnimation.prototype, 'easing', null, function () {
        return this._easing || (this._easing = new Easing(this));
      }, function (val) {
        if (typeof val === 'string') {
          return this.easing.type = val;
        } else if (utils.isObject(val)) {
          return utils.merge(this.easing, val);
        } else if (!val) {
          return this.easing.type = 'Linear';
        }
      });
      return PropertyAnimation;
    }(Renderer.Animation);
  };
}).call(this);
},{"../../../../../util":"xr+4","../../../../../assert":"lQvG","../../../../../log":"fe8o","./property/easing":"C8pE"}],"xqCq":[function(require,module,exports) {
(function () {
  'use strict';

  var utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../../../../util');

  module.exports = function (Renderer, Impl, itemUtils) {
    var NumberAnimation;
    return NumberAnimation = function (superClass) {
      extend(NumberAnimation, superClass);
      NumberAnimation.__name__ = 'NumberAnimation';

      NumberAnimation.New = function (opts) {
        var item;
        item = new NumberAnimation();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function NumberAnimation() {
        NumberAnimation.__super__.constructor.call(this);

        this._from = 0;
        this._to = 0;
      }

      return NumberAnimation;
    }(Renderer.PropertyAnimation);
  };
}).call(this);
},{"../../../../../../../util":"xr+4"}],"6ZTd":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../../util');
  assert = require('../../../../../assert');
  log = require('../../../../../log');
  log = log.scope('Renderer', 'SequentialAnimation');

  module.exports = function (Renderer, Impl, itemUtils) {
    var SequentialAnimation;
    return SequentialAnimation = function (superClass) {
      var onStart, onStop, _runNext, shouldStop;

      extend(SequentialAnimation, superClass);
      SequentialAnimation.__name__ = 'SequentialAnimation';

      SequentialAnimation.New = function (opts) {
        var item;
        item = new SequentialAnimation();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function SequentialAnimation() {
        SequentialAnimation.__super__.constructor.call(this);

        this._children = [];
        this._runningChildIndex = -1;
        this.onStart.connect(onStart);
        this.onStop.connect(onStop);
      }

      itemUtils.defineProperty({
        constructor: SequentialAnimation,
        name: 'target',
        setter: function setter(_super) {
          return function (val) {
            var child, i, len, ref;
            ref = this._children;

            for (i = 0, len = ref.length; i < len; i++) {
              child = ref[i];
              child.target = val;
            }

            _super.call(this, val);
          };
        }
      });

      shouldStop = function shouldStop() {
        return this._runningChildIndex >= this._children.length || this._runningChildIndex < 0;
      };

      _runNext = function runNext() {
        var child;

        if (!this._running) {
          return;
        }

        if (this._runningChildIndex >= 0) {
          this._children[this._runningChildIndex].onStop.disconnect(_runNext, this);
        }

        this._runningChildIndex += this._reversed ? -1 : 1;

        if (this._loop && shouldStop.call(this)) {
          this._runningChildIndex = this._reversed ? this._children.length - 1 : 0;
        }

        if (shouldStop.call(this)) {
          this.running = false;
        } else {
          child = this._children[this._runningChildIndex];
          child.onStop.connect(_runNext, this);
          child.running = true;
          child.paused = this._paused;
        }
      };

      onStart = function onStart() {
        if (!this._children.length) {
          this.running = false;
          return;
        }

        _runNext.call(this);
      };

      onStop = function onStop() {
        var ref;

        if ((ref = this._children[this._runningChildIndex]) != null) {
          ref.running = false;
        }

        this._runningChildIndex = -1;
      };

      itemUtils.defineProperty({
        constructor: SequentialAnimation,
        name: 'paused',
        setter: function setter(_super) {
          return function (val) {
            var ref;

            _super.call(this, val);

            if ((ref = this._children[this._runningChildIndex]) != null) {
              ref.paused = val;
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: SequentialAnimation,
        name: 'reversed',
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        },
        setter: function setter(_super) {
          return function (val) {
            _super.call(this, val);
          };
        }
      });
      return SequentialAnimation;
    }(Renderer.Animation);
  };
}).call(this);
},{"../../../../../util":"xr+4","../../../../../assert":"lQvG","../../../../../log":"fe8o"}],"Jgr6":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../../util');
  assert = require('../../../../../assert');
  log = require('../../../../../log');
  log = log.scope('Renderer', 'ParallelAnimation');

  module.exports = function (Renderer, Impl, itemUtils) {
    var ParallelAnimation;
    return ParallelAnimation = function (superClass) {
      var onChildStop, onChildrenStop, onStart, onStop;
      extend(ParallelAnimation, superClass);
      ParallelAnimation.__name__ = 'ParallelAnimation';

      ParallelAnimation.New = function (opts) {
        var item;
        item = new ParallelAnimation();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function ParallelAnimation() {
        ParallelAnimation.__super__.constructor.call(this);

        this._children = [];
        this._runningChildren = 0;
        this.onStart.connect(onStart);
        this.onStop.connect(onStop);
      }

      itemUtils.defineProperty({
        constructor: ParallelAnimation,
        name: 'target',
        setter: function setter(_super) {
          return function (val) {
            var child, i, len, ref;
            ref = this._children;

            for (i = 0, len = ref.length; i < len; i++) {
              child = ref[i];
              child.target = val;
            }

            _super.call(this, val);
          };
        }
      });

      onChildrenStop = function onChildrenStop() {
        if (this.loop) {
          onStop.call(this);
          onStart.call(this);
        } else {
          this.running = false;
        }
      };

      onChildStop = function onChildStop() {
        this._runningChildren -= 1;

        if (this._runningChildren === 0) {
          onChildrenStop.call(this);
        }
      };

      onStart = function onStart() {
        var child, i, len, ref;

        if (!this._children.length) {
          this.running = false;
          return;
        }

        this._runningChildren = this._children.length;
        ref = this._children;

        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];
          child.onStop.connect(onChildStop, this);
          child.running = true;
        }
      };

      onStop = function onStop() {
        var child, i, len, ref;
        ref = this._children;

        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];
          child.onStop.disconnect(onChildStop, this);
          child.running = false;
        }
      };

      itemUtils.defineProperty({
        constructor: ParallelAnimation,
        name: 'paused',
        setter: function setter(_super) {
          return function (val) {
            var child, i, len, ref;

            _super.call(this, val);

            ref = this._children;

            for (i = 0, len = ref.length; i < len; i++) {
              child = ref[i];
              child.paused = val;
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: ParallelAnimation,
        name: 'reversed',
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        },
        setter: function setter(_super) {
          return function (val) {
            var child, i, len, ref;

            _super.call(this, val);

            ref = this._children;

            for (i = 0, len = ref.length; i < len; i++) {
              child = ref[i];
              child.reversed = val;
            }
          };
        }
      });
      return ParallelAnimation;
    }(Renderer.Animation);
  };
}).call(this);
},{"../../../../../util":"xr+4","../../../../../assert":"lQvG","../../../../../log":"fe8o"}],"Ro6R":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      signal,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  assert = require('../../../assert');
  signal = require('../../../signal');
  log = require('../../../log');
  log = log.scope('Renderer', 'Transition');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Transition;
    return Transition = function (superClass) {
      var listener, onTargetReady;
      extend(Transition, superClass);
      Transition.__name__ = 'Transition';

      Transition.New = function (opts) {
        var item;
        item = new Transition();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function Transition() {
        Transition.__super__.constructor.call(this);

        this._running = true;
        this._ready = false;
        this._animation = null;
        this._property = '';
        this._animationClass = Renderer.Class.New({
          priority: -2,
          changes: {
            updateProperty: Renderer.PropertyAnimation.NEVER
          }
        });
      }

      listener = function listener(oldVal) {
        var animation, shouldRun, to;
        animation = this.animation;
        to = this._target[this.property];
        shouldRun = animation && this.running && this._ready && !animation.updatePending;
        shouldRun && (shouldRun = utils.isFloat(oldVal) && utils.isFloat(to));

        if (!shouldRun) {
          return;
        }

        animation.stop();
        animation.from = oldVal;
        animation.to = to;
        animation.start();
      };

      onTargetReady = function onTargetReady() {
        return this._ready = true;
      };

      itemUtils.defineProperty({
        constructor: Transition,
        name: 'target',
        defaultValue: null,
        setter: function setter(_super) {
          return function (val) {
            var animation, handlerName, item, oldVal, property, ref, ref1;
            oldVal = this.target;

            if (oldVal === val) {
              return;
            }

            ref = this, animation = ref.animation, property = ref.property;

            if (animation) {
              animation.stop();
              animation.target = val;
            }

            _super.call(this, val);

            if (oldVal) {
              utils.remove(oldVal._extensions, this);
            }

            this._ready = false;

            if (val instanceof itemUtils.Object) {
              item = val;
            } else if (val instanceof itemUtils.MutableDeepObject) {
              item = val._ref;
            } else {
              setImmediate(onTargetReady.bind(this));
            }

            if (item) {
              item._extensions.push(this);

              this._ready = true;
            }

            if (property) {
              handlerName = itemUtils.getPropHandlerName(property);

              if (oldVal) {
                if ((ref1 = oldVal[handlerName]) != null) {
                  ref1.disconnect(listener, this);
                }
              }

              if (val) {
                if (handlerName in val) {
                  val[handlerName].connect(listener, this);
                } else {
                  log.error("'" + property + "' property signal not found");
                }
              }
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Transition,
        name: 'animation',
        defaultValue: null,
        developmentSetter: function developmentSetter(val) {
          if (val != null) {
            return assert.instanceOf(val, Renderer.PropertyAnimation);
          }
        },
        setter: function setter(_super) {
          return function (val) {
            var oldVal;
            oldVal = this.animation;

            if (oldVal === val) {
              return;
            }

            _super.call(this, val);

            if (oldVal) {
              this._animationClass.disable();

              oldVal.target = null;
              oldVal.stop();
            }

            if (val) {
              this._animationClass.target = val;
              this._animationClass.running = true;
              val.target = this.target;
              val.property = this.property;
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Transition,
        name: 'property',
        defaultValue: '',
        setter: function setter(_super) {
          return function (val) {
            var animation, chain, chains, handlerName, i, j, len, n, oldVal, ref, target;
            oldVal = this.property;

            if (oldVal === val) {
              return;
            }

            ref = this, animation = ref.animation, target = ref.target;

            if (target && val.indexOf('.') !== -1) {
              chains = val.split('.');
              n = chains.length;

              for (i = j = 0, len = chains.length; j < len; i = ++j) {
                chain = chains[i];

                if (!(i < n - 1)) {
                  continue;
                }

                target = target[chain];

                if (!target) {
                  log.error("No object found for the '" + val + "' property");
                  break;
                }
              }

              val = chains[n - 1];
              this.target = target;
            }

            if (animation) {
              animation.stop();
              animation.property = val;
            }

            _super.call(this, val);

            if (target) {
              if (oldVal) {
                handlerName = itemUtils.getPropHandlerName(oldVal);
                target[handlerName].disconnect(listener, this);
              }

              if (val) {
                handlerName = itemUtils.getPropHandlerName(val);
                target[handlerName].connect(listener, this);
              }
            }
          };
        }
      });
      return Transition;
    }(Renderer.Extension);
  };
}).call(this);
},{"../../../util":"xr+4","../../../assert":"lQvG","../../../signal":"WtLN","../../../log":"fe8o"}],"dDWa":[function(require,module,exports) {
(function () {
  'use strict';
  /*
  A C E
  B D F
  0 0 1
   */

  var Matrix;

  module.exports = Matrix = function () {
    function Matrix() {
      this.a = this.d = 1;
      this.b = this.c = this.e = this.f = 0;
    }

    Matrix.prototype.transform = function (a2, b2, c2, d2, e2, f2) {
      var a1, b1, c1, d1, e1, f1;
      a1 = this.a;
      b1 = this.b;
      c1 = this.c;
      d1 = this.d;
      e1 = this.e;
      f1 = this.f;
      this.a = a1 * a2 + c1 * b2;
      this.b = b1 * a2 + d1 * b2;
      this.c = a1 * c2 + c1 * d2;
      this.d = b1 * c2 + d1 * d2;
      this.e = a1 * e2 + c1 * f2 + e1;
      this.f = b1 * e2 + d1 * f2 + f1;
      return this;
    };

    Matrix.prototype.rotate = function (angle) {
      var cos, sin;
      cos = Math.cos(angle);
      sin = Math.sin(angle);
      return this.transform(cos, sin, -sin, cos, 0, 0);
    };

    Matrix.prototype.scale = function (f) {
      return this.transform(f, 0, 0, f, 0, 0);
    };

    Matrix.prototype.translate = function (tx, ty) {
      return this.transform(1, 0, 0, 1, tx, ty);
    };

    Matrix.prototype.multiply = function (m) {
      return this.transform(m.a, m.b, m.c, m.d, m.e, m.f);
    };

    Matrix.prototype.getRotation = function () {
      var r;
      r = Math.sqrt(this.a * this.a + this.b * this.b);

      if (this.b > 0) {
        return Math.acos(this.a / r);
      } else {
        return -Math.acos(this.a / r);
      }
    };

    Matrix.prototype.getScale = function () {
      return Math.sqrt(this.a * this.a + this.b * this.b);
    };

    Matrix.prototype.getTranslate = function () {
      return {
        x: this.e,
        y: this.f
      };
    };

    return Matrix;
  }();
}).call(this);
},{}],"ibDz":[function(require,module,exports) {
(function () {
  exports.onSetParent = function () {
    var findItemParent, _setItemParent;

    findItemParent = function findItemParent(node) {
      var docStyle, item, tmp;
      tmp = node;

      while (tmp) {
        if ((docStyle = tmp._documentStyle) && (item = docStyle.item)) {
          return item;
        }

        tmp = tmp.parent;
      }

      return null;
    };

    _setItemParent = function setItemParent(node, newParent) {
      var child, docStyle, i, len, ref;

      if (docStyle = node._documentStyle) {
        docStyle.setItemParent(newParent);
      } else if (node.children) {
        ref = node.children;

        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];

          _setItemParent(child, newParent);
        }
      }
    };

    return function (element, val) {
      var newParent;
      newParent = findItemParent(val);

      _setItemParent(element, newParent);
    };
  }();

  exports.onSetIndex = function () {
    var _updateItemIndex;

    _updateItemIndex = function updateItemIndex(node) {
      var child, docStyle, i, len, ref;

      if (docStyle = node._documentStyle) {
        docStyle.findItemIndex();
      } else if (node.children) {
        ref = node.children;

        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];

          _updateItemIndex(child);
        }
      }
    };

    return function (element) {
      _updateItemIndex(element);
    };
  }();

  exports.onSetVisible = function () {
    var _setVisibleForNode, updateTextNode;

    _setVisibleForNode = function setVisibleForNode(node, val) {
      var child, docStyle, i, len, ref;

      if (docStyle = node._documentStyle) {
        docStyle.setVisibility(val);
      } else if (node.children) {
        ref = node.children;

        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];

          if (child.visible) {
            _setVisibleForNode(child, val);
          }
        }
      }
    };

    updateTextNode = function updateTextNode(node) {
      var docStyle;

      while (node) {
        if (docStyle = node._documentStyle) {
          if (docStyle.hasText) {
            docStyle.updateText();
          }

          break;
        }

        node = node.parent;
      }
    };

    return function (element, val) {
      _setVisibleForNode(element, val);

      updateTextNode(element);
    };
  }();

  exports.onSetText = function () {
    var updateTextNode;

    updateTextNode = function updateTextNode(node) {
      var docStyle;

      while (node) {
        docStyle = node._documentStyle;

        if (docStyle != null ? docStyle.hasText : void 0) {
          docStyle.updateText();
          break;
        }

        node = node.parent;
      }
    };

    return function (element) {
      updateTextNode(element);
    };
  }();

  exports.onSetProp = function (element, name, val, oldVal) {
    var docStyle;
    docStyle = element._documentStyle;

    if (!docStyle) {
      return;
    }

    docStyle.setProp(name, val, oldVal);
  };
}).call(this);
},{}],"2WS1":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      styles,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  assert = require('../../../assert');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  styles = require('../styles');
  assert = assert.scope('View.Element.Text');

  module.exports = function (Element) {
    var Text;
    return Text = function (superClass) {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_TEXT, i, opts;
      extend(Text, superClass);
      Text.__name__ = 'Text';
      Text.__path__ = 'File.Element.Text';
      JSON_CTOR_ID = Text.JSON_CTOR_ID = Element.JSON_CTORS.push(Text) - 1;
      i = Element.JSON_ARGS_LENGTH;
      JSON_TEXT = i++;
      JSON_ARGS_LENGTH = Text.JSON_ARGS_LENGTH = i;

      Text._fromJSON = function (arr, obj) {
        if (obj == null) {
          obj = new Text();
        }

        Element._fromJSON(arr, obj);

        obj._text = arr[JSON_TEXT];
        return obj;
      };

      function Text() {
        Text.__super__.constructor.call(this);

        this._text = ''; //<development>;

        if (this.constructor === Text) {
          Object.seal(this);
        } //</development>;

      }

      Text.prototype.clone = function (clone) {
        if (clone == null) {
          clone = new Text();
        }

        Text.__super__.clone.call(this, clone);

        clone._text = this._text;
        return clone;
      };

      opts = utils.CONFIGURABLE;
      utils.defineProperty(Text.prototype, 'text', opts, function () {
        return this._text;
      }, function (value) {
        var old;
        assert.isString(value);
        old = this._text;

        if (old === value) {
          return false;
        }

        this._text = value;
        this.emit('onTextChange', old);
        Element.Tag.query.checkWatchersDeeply(this);
        styles.onSetText(this);
        return true;
      });
      SignalsEmitter.createSignal(Text, 'onTextChange');

      Text.prototype.toJSON = function (arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }

        Text.__super__.toJSON.call(this, arr);

        arr[JSON_TEXT] = this.text;
        return arr;
      };

      return Text;
    }(Element);
  };
}).call(this);
},{"../../../util":"xr+4","../../../assert":"lQvG","../../../signal":"WtLN","../styles":"ibDz"}],"I1Xt":[function(require,module,exports) {
(function () {
  'use strict';

  var SINGLE_TAG, getInnerHTML, getOuterHTML, isPublicProp, isPublicTag;
  SINGLE_TAG = {
    __proto__: null,
    area: true,
    base: true,
    basefont: true,
    br: true,
    col: true,
    command: true,
    embed: true,
    frame: true,
    hr: true,
    img: true,
    input: true,
    isindex: true,
    keygen: true,
    link: true,
    meta: true,
    param: true,
    source: true,
    track: true,
    wbr: true
  };

  isPublicTag = function isPublicTag(name) {
    return name !== '' && name !== 'blank' && !/^(?:[A-Z]|n-)/.test(name);
  };

  isPublicProp = function isPublicProp(name) {
    return !/^(?:n-|style:)/.test(name);
  };

  getInnerHTML = function getInnerHTML(elem) {
    var child, i, len, r, ref;

    if (elem.children) {
      r = '';
      ref = elem.children;

      for (i = 0, len = ref.length; i < len; i++) {
        child = ref[i];
        r += getOuterHTML(child);
      }

      return r;
    } else {
      return '';
    }
  };

  getOuterHTML = function getOuterHTML(elem) {
    var innerHTML, name, propName, propValue, props, ret;

    if (elem._visible === false) {
      return '';
    }

    if (elem._text !== void 0) {
      return elem._text;
    }

    name = elem.name;

    if (!name || !isPublicTag(name)) {
      return getInnerHTML(elem);
    }

    ret = '<' + name;
    props = elem.props;

    for (propName in props) {
      propValue = props[propName];

      if (!props.hasOwnProperty(propName)) {
        continue;
      }

      if (propValue == null || typeof propValue === 'function' || !isPublicProp(propName)) {
        continue;
      }

      ret += ' ' + propName + '="' + propValue + '"';
    }

    innerHTML = getInnerHTML(elem);

    if (!innerHTML && SINGLE_TAG[name]) {
      return ret + ' />';
    } else {
      return ret + '>' + innerHTML + '</' + name + '>';
    }
  };

  module.exports = {
    getInnerHTML: getInnerHTML,
    getOuterHTML: getOuterHTML
  };
}).call(this);
},{}],"hspS":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, styles, utils;
  utils = require('../../../../util');
  assert = require('../../../../assert');
  styles = require('../../styles');

  module.exports = function (Tag) {
    var Props;
    return Props = function () {
      var NOT_ENUMERABLE;

      function Props(ref) {
        utils.defineProperty(this, '_ref', 0, ref);
      }

      NOT_ENUMERABLE = utils.CONFIGURABLE | utils.WRITABLE;
      utils.defineProperty(Props.prototype, 'constructor', NOT_ENUMERABLE, Props);
      utils.defineProperty(Props.prototype, 'item', NOT_ENUMERABLE, function (index, target) {
        var i, key, ref1, val;

        if (target == null) {
          target = [];
        }

        assert.isArray(target);
        target[0] = target[1] = void 0;
        i = 0;
        ref1 = this;

        for (key in ref1) {
          val = ref1[key];

          if (this.hasOwnProperty(key) && i === index) {
            target[0] = key;
            target[1] = val;
            break;
          }

          i++;
        }

        return target;
      });
      utils.defineProperty(Props.prototype, 'has', NOT_ENUMERABLE, function (name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        return this.hasOwnProperty(name);
      });
      utils.defineProperty(Props.prototype, 'set', NOT_ENUMERABLE, function (name, value) {
        var old;
        assert.isString(name);
        assert.notLengthOf(name, 0);
        old = this[name];

        if (old === value) {
          return false;
        }

        this[name] = value;

        this._ref.emit('onPropsChange', name, old);

        Tag.query.checkWatchersDeeply(this._ref);
        styles.onSetProp(this._ref, name, value, old);
        return true;
      });
      return Props;
    }();
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../assert":"lQvG","../../styles":"ibDz"}],"a9No":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      util,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  util = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;

  module.exports = function (Element, Tag) {
    var CustomTag;
    return CustomTag = function (superClass) {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_FIELDS, customTags, i;
      extend(CustomTag, superClass);
      customTags = CustomTag.customTags = {};
      JSON_CTOR_ID = CustomTag.JSON_CTOR_ID = Element.JSON_CTORS.push(CustomTag) - 1;
      i = Tag.JSON_ARGS_LENGTH;
      JSON_FIELDS = i++;
      JSON_ARGS_LENGTH = CustomTag.JSON_ARGS_LENGTH = i;

      CustomTag._fromJSON = function (arr, obj) {
        var ctor, field, fields, val;
        fields = arr[JSON_FIELDS];

        if (!obj) {
          ctor = customTags[arr[Tag.JSON_NAME]];
          obj = new ctor();
        }

        Tag._fromJSON(arr, obj);

        for (field in fields) {
          val = fields[field];
          obj[field] = val;
        }

        return obj;
      };

      CustomTag.registerAs = function (tagName) {
        customTags[tagName] = this;
      };

      CustomTag.defineProperty = function (arg) {
        var defaultValue, field, getter, internalName, name, ref, setter, signalName;
        name = arg.name, defaultValue = (ref = arg.defaultValue) != null ? ref : null;

        if (this === CustomTag) {
          throw new Error('Cannot define a property on CustomTag; create new class');
        }

        internalName = "_" + name;
        signalName = "on" + util.capitalize(name) + "Change";

        if (this._fields == null) {
          this._fields = [];
        }

        if (this._fieldsByName == null) {
          this._fieldsByName = {};
        }

        field = {
          name: name,
          internalName: internalName,
          signalName: signalName,
          defaultValue: defaultValue
        };

        this._fields.push(field);

        this._fieldsByName[name] = field;
        SignalsEmitter.createSignal(this, signalName);

        getter = function getter() {
          return this[internalName];
        };

        setter = function setter(val) {
          var oldVal;
          oldVal = this[internalName];

          if (oldVal === val) {
            return;
          }

          this[internalName] = val;
          this.emit(signalName, oldVal);
        };

        util.defineProperty(this.prototype, name, util.CONFIGURABLE, getter, setter);
      };

      CustomTag.defineStyleProperty = function (arg) {
        var getter, internalStyleName, name, ref, setter, signalGetter, signalName, signalStyleName, styleName;
        name = arg.name, styleName = (ref = arg.styleName) != null ? ref : name;

        if (this === CustomTag) {
          throw new Error('Cannot define a property on CustomTag; create your own class');
        }

        internalStyleName = "_" + styleName;
        signalName = "on" + util.capitalize(name) + "Change";
        signalStyleName = "on" + util.capitalize(styleName) + "Change";

        if (this._styleAliases == null) {
          this._styleAliases = [];
        }

        if (this._styleAliasesByName == null) {
          this._styleAliasesByName = {};
        }

        this._styleAliases.push({
          name: name,
          signalName: signalName,
          styleName: styleName
        });

        this._styleAliasesByName[signalName] = {
          styleName: signalStyleName
        };
        this._styleAliasesByName[name] = {
          styleName: styleName
        };

        signalGetter = function signalGetter() {
          var ref1;
          return (ref1 = this._style) != null ? ref1[signalStyleName] : void 0;
        };

        getter = function getter() {
          var ref1;
          return (ref1 = this._style) != null ? ref1[internalStyleName] : void 0;
        };

        setter = function setter(val) {
          var ref1;
          return (ref1 = this._style) != null ? ref1[styleName] = val : void 0;
        };

        util.defineProperty(this.prototype, signalName, util.CONFIGURABLE, signalGetter, null);
        util.defineProperty(this.prototype, name, util.CONFIGURABLE, getter, setter);
      };

      function CustomTag() {
        var field, fields, fieldsByName, j, len;

        CustomTag.__super__.constructor.call(this);

        fields = this.constructor._fields;
        fieldsByName = this.constructor._fieldsByName;

        if (fields) {
          for (j = 0, len = fields.length; j < len; j++) {
            field = fields[j];
            this[field.internalName] = field.defaultValue;
          }
        }

        Object.seal(this);

        if (fieldsByName) {
          this.onPropsChange.connect(function (name) {
            if (fieldsByName[name]) {
              return this[name] = this.props[name];
            }
          });
        }
      }

      CustomTag.prototype.clone = function (clone) {
        var field, fields, j, len;

        if (clone == null) {
          clone = new this.constructor();
        }

        CustomTag.__super__.clone.call(this, clone);

        fields = this.constructor._fields;

        if (fields) {
          for (j = 0, len = fields.length; j < len; j++) {
            field = fields[j];
            clone[field.internalName] = this[field.internalName];
          }
        }

        return clone;
      };

      CustomTag.prototype.toJSON = function (arr) {
        var field, fields, j, jsonFields, len;

        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }

        CustomTag.__super__.toJSON.call(this, arr);

        jsonFields = arr[JSON_FIELDS] = {};
        fields = this.constructor._fields;

        if (fields) {
          for (j = 0, len = fields.length; j < len; j++) {
            field = fields[j];
            jsonFields[field.internalName] = this[field.internalName];
          }
        }

        return arr;
      };

      return CustomTag;
    }(Tag);
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../signal":"WtLN"}],"RxB4":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      TypedArray,
      assert,
      stringify,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../util');
  assert = require('../../../assert');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  TypedArray = require('../../../typed-array');
  stringify = require('./tag/stringify');
  assert = assert.scope('View.Element.Tag');

  module.exports = function (Element) {
    var Tag;
    return Tag = function (superClass) {
      var JSON_ARGS_LENGTH, JSON_CHILDREN, JSON_CTOR_ID, JSON_NAME, JSON_PROPS, Props, i, query;
      extend(Tag, superClass);
      Tag.Props = Props = require('./tag/props')(Tag);
      Tag.__name__ = 'Tag';
      Tag.__path__ = 'File.Element.Tag';
      JSON_CTOR_ID = Tag.JSON_CTOR_ID = Element.JSON_CTORS.push(Tag) - 1;
      i = Element.JSON_ARGS_LENGTH;
      JSON_NAME = Tag.JSON_NAME = i++;
      JSON_CHILDREN = i++;
      JSON_PROPS = i++;
      JSON_ARGS_LENGTH = Tag.JSON_ARGS_LENGTH = i;
      Tag.CustomTag = require('./tag/custom')(Element, Tag);

      Tag._fromJSON = function (arr, obj) {
        var child, childObj, j, len, name, prevChild, ref;
        name = arr[JSON_NAME];

        if (!obj) {
          obj = new Tag();
        }

        Element._fromJSON(arr, obj);

        obj.name = name;
        utils.merge(obj.props, arr[JSON_PROPS]);
        prevChild = null;
        ref = arr[JSON_CHILDREN];

        for (j = 0, len = ref.length; j < len; j++) {
          child = ref[j];
          childObj = Element.fromJSON(child);
          obj.children.push(childObj);
          childObj._parent = obj;

          if (childObj._previousSibling = prevChild) {
            prevChild._nextSibling = childObj;
          }

          prevChild = childObj;
        }

        return obj;
      };

      function Tag() {
        Tag.__super__.constructor.call(this);

        this.name = 'blank';
        this.children = [];
        this.props = new Props(this); //<development>;

        if (this.constructor === Tag) {
          Object.seal(this);
        } //</development>;

      }

      SignalsEmitter.createSignal(Tag, 'onChildrenChange');
      SignalsEmitter.createSignal(Tag, 'onPropsChange');

      Tag.prototype.clone = function (clone) {
        if (clone == null) {
          clone = new this.constructor();
        }

        Tag.__super__.clone.call(this, clone);

        clone.name = this.name;
        utils.merge(clone.props, this.props);
        return clone;
      };

      Tag.prototype.cloneDeep = function () {
        var child, clone, clonedChild, j, len, prevClonedChild, ref;
        clone = this.clone();
        prevClonedChild = null;
        ref = this.children;

        for (j = 0, len = ref.length; j < len; j++) {
          child = ref[j];

          if (child instanceof Tag) {
            clonedChild = child.cloneDeep();
          } else {
            clonedChild = child.clone();
          }

          clone.children.push(clonedChild);
          clonedChild._parent = clone;

          if (clonedChild._previousSibling = prevClonedChild) {
            prevClonedChild._nextSibling = clonedChild;
          }

          prevClonedChild = clonedChild;
        }

        return clone;
      };

      Tag.prototype.getCopiedElement = function () {
        var arr;
        arr = new TypedArray.Uint16(256);
        return function (lookForElement, copiedParent) {
          var elem, index, parent;
          assert.instanceOf(this, Tag);
          assert.instanceOf(lookForElement, Element);
          assert.instanceOf(copiedParent, Element);

          if (lookForElement === this) {
            return copiedParent;
          }

          i = 0;
          elem = lookForElement;

          while (parent = elem._parent) {
            arr[i++] = parent.children.indexOf(elem);
            elem = parent;

            if (elem === this) {
              break;
            }
          }

          elem = copiedParent;

          while (i-- > 0) {
            index = arr[i];
            elem = elem.children[index];
          }

          return elem;
        };
      }();

      Tag.prototype.getChildByAccessPath = function (arr) {
        var elem, j;
        assert.isArray(arr);
        elem = this;

        for (j = arr.length - 1; j >= 0; j += -1) {
          i = arr[j];

          if (!(elem = elem.children[i])) {
            return null;
          }
        }

        return elem;
      };

      Tag.query = query = require('./tag/query')(Element, Tag);
      Tag.prototype.queryAll = query.queryAll;
      Tag.prototype.query = query.query;
      Tag.prototype.watch = query.watch;

      Tag.prototype.stringify = function () {
        return stringify.getOuterHTML(this);
      };

      Tag.prototype.stringifyChildren = function () {
        return stringify.getInnerHTML(this);
      };

      Tag.prototype.replace = function (oldElement, newElement) {
        var index;
        assert.instanceOf(oldElement, Element);
        assert.instanceOf(newElement, Element);
        assert.is(oldElement.parent, this);
        index = this.children.indexOf(oldElement);
        oldElement.parent = void 0;
        newElement.parent = this;
        newElement.index = index;
        return null;
      };

      Tag.prototype.toJSON = function (arr) {
        var child, children, j, len, ref;

        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }

        Tag.__super__.toJSON.call(this, arr);

        arr[JSON_NAME] = this.name;
        children = arr[JSON_CHILDREN] = [];
        arr[JSON_PROPS] = this.props;
        ref = this.children;

        for (j = 0, len = ref.length; j < len; j++) {
          child = ref[j];
          children.push(child.toJSON());
        }

        return arr;
      };

      return Tag;
    }(Element);
  };
}).call(this);
},{"../../../util":"xr+4","../../../assert":"lQvG","../../../signal":"WtLN","../../../typed-array":"wKwT","./tag/stringify":"I1Xt","./tag/props":"hspS","./tag/custom":"a9No","./tag/query":"6aTz"}],"7MrE":[function(require,module,exports) {
(function () {
  'use strict';

  var Element,
      SignalsEmitter,
      assert,
      isArray,
      styles,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../util');
  assert = require('../../assert');
  SignalsEmitter = require('../../signal').SignalsEmitter;
  styles = require('./styles');
  isArray = Array.isArray;
  assert = assert.scope('View.Element');

  Element = function (superClass) {
    var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_VISIBLE, Tag, i, opts;
    extend(Element, superClass);
    Element.__name__ = 'Element';
    Element.__path__ = 'File.Element';
    Element.JSON_CTORS = [];
    JSON_CTOR_ID = Element.JSON_CTOR_ID = Element.JSON_CTORS.push(Element) - 1;
    i = 1;
    JSON_VISIBLE = i++;
    JSON_ARGS_LENGTH = Element.JSON_ARGS_LENGTH = i;

    Element.fromJSON = function (json) {
      if (typeof json === 'string') {
        json = JSON.parse(json);
      }

      assert.isArray(json);
      return Element.JSON_CTORS[json[0]]._fromJSON(json);
    };

    Element._fromJSON = function (arr, obj) {
      if (obj == null) {
        obj = new Element();
      }

      obj._visible = arr[JSON_VISIBLE] === 1;
      return obj;
    };

    Element.Text = require('./element/text')(Element);
    Element.Tag = Tag = require('./element/tag')(Element);

    function Element() {
      Element.__super__.constructor.call(this);

      this._parent = null;
      this._nextSibling = null;
      this._previousSibling = null;
      this._style = null;
      this._documentStyle = null;
      this._visible = true;
      this._watchers = null;
      this._inWatchers = null;
      this._checkWatchers = 0; //<development>;

      if (this.constructor === Element) {
        Object.seal(this);
      } //</development>;

    }

    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'index', opts, function () {
      var ref;
      return ((ref = this.parent) != null ? ref.children.indexOf(this) : void 0) || 0;
    }, function (val) {
      var children, index, parent, ref, ref1, ref2, ref3;
      assert.instanceOf(this.parent, Element);
      assert.isInteger(val);
      assert.operator(val, '>=', 0);
      parent = this._parent;

      if (!parent) {
        return false;
      }

      index = this.index;
      children = parent.children;

      if (val > children.length) {
        val = children.length;
      }

      if (index === val || index === val - 1) {
        return false;
      }

      if ((ref = this._previousSibling) != null) {
        ref._nextSibling = this._nextSibling;
      }

      if ((ref1 = this._nextSibling) != null) {
        ref1._previousSibling = this._previousSibling;
      }

      children.splice(index, 1);

      if (val > index) {
        val--;
      }

      children.splice(val, 0, this);
      this._previousSibling = children[val - 1] || null;
      this._nextSibling = children[val + 1] || null;

      if ((ref2 = this._previousSibling) != null) {
        ref2._nextSibling = this;
      }

      if ((ref3 = this._nextSibling) != null) {
        ref3._previousSibling = this;
      }

      assert.is(this.index, val);
      assert.is(children[val], this);
      assert.is(this._previousSibling, children[val - 1] || null);
      assert.is(this._nextSibling, children[val + 1] || null);
      styles.onSetIndex(this);
      return true;
    });
    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'nextSibling', opts, function () {
      return this._nextSibling;
    }, null);
    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'previousSibling', opts, function () {
      return this._previousSibling;
    }, null);
    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'parent', opts, function () {
      return this._parent;
    }, function (val) {
      var index, newChildren, old, oldChildren, parent, ref, ref1;
      assert.instanceOf(this, Element);

      if (val != null) {
        assert.instanceOf(val, Element);
      }

      assert.isNot(this, val);
      old = this._parent;

      if (old === val) {
        return false;
      }

      if (this._parent) {
        oldChildren = this._parent.children;
        assert.ok(utils.has(oldChildren, this));

        if (!this._nextSibling) {
          assert.ok(oldChildren[oldChildren.length - 1] === this);
          oldChildren.pop();
        } else if (!this._previousSibling) {
          assert.ok(oldChildren[0] === this);
          oldChildren.shift();
        } else {
          index = oldChildren.indexOf(this);
          oldChildren.splice(index, 1);
        }

        this._parent.emit('onChildrenChange', null, this);

        if ((ref = this._previousSibling) != null) {
          ref._nextSibling = this._nextSibling;
        }

        if ((ref1 = this._nextSibling) != null) {
          ref1._previousSibling = this._previousSibling;
        }

        this._previousSibling = null;
        this._nextSibling = null;
      }

      this._parent = parent = val;

      if (parent) {
        assert.notOk(utils.has(this._parent.children, this));
        newChildren = this._parent.children;
        index = newChildren.push(this) - 1;
        parent.emit('onChildrenChange', this);

        if (index === 0) {
          this._previousSibling = null;
        } else {
          this._previousSibling = newChildren[index - 1];
          this._previousSibling._nextSibling = this;
        }
      }

      assert.is(this._parent, val);
      assert.is(this._nextSibling, null);
      assert.is(this._previousSibling, (val != null ? val.children[val.children.length - 2] : void 0) || null);

      if (this._previousSibling) {
        assert.is(this._previousSibling._nextSibling, this);
      }

      this.emit('onParentChange', old);
      Tag.query.checkWatchersDeeply(this, old);
      Tag.query.checkWatchersDeeply(this);
      styles.onSetParent(this, val);
      return true;
    });
    SignalsEmitter.createSignal(Element, 'onParentChange');
    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'style', opts, function () {
      return this._style;
    }, function (val) {
      var old;
      old = this._style;

      if (old === val) {
        return false;
      }

      this._style = val;
      this.emit('onStyleChange', old, val);
      return true;
    });
    SignalsEmitter.createSignal(Element, 'onStyleChange');
    opts = utils.CONFIGURABLE;
    utils.defineProperty(Element.prototype, 'visible', opts, function () {
      return this._visible;
    }, function (val) {
      var old;
      assert.isBoolean(val);
      old = this._visible;

      if (old === val) {
        return false;
      }

      this._visible = val;
      this.emit('onVisibleChange', old);
      styles.onSetVisible(this, val);
      return true;
    });
    SignalsEmitter.createSignal(Element, 'onVisibleChange');
    Element.prototype.queryAllParents = Tag.query.queryAllParents;
    Element.prototype.queryParents = Tag.query.queryParents;

    Element.prototype.getAccessPath = function (toParent) {
      var arr, elem, parent;

      if (toParent != null) {
        assert.instanceOf(toParent, Tag);
      }

      arr = [];
      i = 0;
      elem = this;
      parent = this;

      while (parent = elem._parent) {
        arr.push(parent.children.indexOf(elem));
        elem = parent;

        if (parent === toParent) {
          break;
        }
      }

      return arr;
    };

    Element.prototype.clone = function (clone) {
      if (clone == null) {
        clone = new Element();
      }

      clone._visible = this._visible;
      return clone;
    };

    Element.prototype.toJSON = function (arr) {
      if (!arr) {
        arr = new Array(JSON_ARGS_LENGTH);
        arr[0] = JSON_CTOR_ID;
      }

      arr[JSON_VISIBLE] = this.visible ? 1 : 0;
      return arr;
    };

    return Element;
  }(SignalsEmitter);

  module.exports = Element;
}).call(this);
},{"../../util":"xr+4","../../assert":"lQvG","../../signal":"WtLN","./styles":"ibDz","./element/text":"2WS1","./element/tag":"RxB4"}],"BiIz":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../../assert');
  utils = require('../../../../util');

  module.exports = function (Renderer, Impl, itemUtils) {
    return function (ctor) {
      var Spacing;
      return Spacing = function (superClass) {
        extend(Spacing, superClass);
        Spacing.__name__ = 'Spacing';
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'spacing',
          defaultValue: 0,
          valueConstructor: Spacing,
          setter: function setter(_super) {
            return function (val) {
              var spacing;
              spacing = this.spacing;

              if (utils.isObject(val)) {
                if (val.column != null) {
                  spacing.column = val.column;
                }

                if (val.row != null) {
                  spacing.row = val.row;
                }
              } else {
                spacing.column = spacing.row = val;
              }

              _super.call(this, val);
            };
          }
        });

        function Spacing(ref) {
          Spacing.__super__.constructor.call(this, ref);

          this._column = 0;
          this._row = 0;
          Object.preventExtensions(this);
        }

        itemUtils.defineProperty({
          constructor: Spacing,
          name: 'column',
          defaultValue: 0,
          namespace: 'spacing',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "ColumnSpacing"],
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val);
          }
        });
        itemUtils.defineProperty({
          constructor: Spacing,
          name: 'row',
          defaultValue: 0,
          namespace: 'spacing',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "RowSpacing"],
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val);
          }
        });

        Spacing.prototype.valueOf = function () {
          if (this.column === this.row) {
            return this.column;
          } else {
            throw new Error("column and row spacing are different");
          }
        };

        Spacing.prototype.toJSON = function () {
          return {
            column: this.column,
            row: this.row
          };
        };

        return Spacing;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../assert":"lQvG","../../../../util":"xr+4"}],"8B6V":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../../assert');
  utils = require('../../../../util');

  module.exports = function (Renderer, Impl, itemUtils) {
    return function (ctor) {
      var Alignment;
      return Alignment = function (superClass) {
        extend(Alignment, superClass);
        Alignment.__name__ = 'Alignment';
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'alignment',
          defaultValue: null,
          valueConstructor: Alignment,
          setter: function setter() {
            return null;
          }
        });

        function Alignment(ref) {
          Alignment.__super__.constructor.call(this, ref);

          this._horizontal = 'left';
          this._vertical = 'top';
          Object.preventExtensions(this);
        }

        itemUtils.defineProperty({
          constructor: Alignment,
          name: 'horizontal',
          defaultValue: 'left',
          namespace: 'alignment',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "AlignmentHorizontal"],
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val);
          },
          setter: function setter(_super) {
            return function (val) {
              if (val == null) {
                val = 'left';
              }

              return _super.call(this, val);
            };
          }
        });
        itemUtils.defineProperty({
          constructor: Alignment,
          name: 'vertical',
          defaultValue: 'top',
          namespace: 'alignment',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "AlignmentVertical"],
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val);
          },
          setter: function setter(_super) {
            return function (val) {
              if (val == null) {
                val = 'top';
              }

              return _super.call(this, val);
            };
          }
        });

        Alignment.prototype.toJSON = function () {
          return {
            horizontal: this.horizontal,
            vertical: this.vertical
          };
        };

        return Alignment;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../assert":"lQvG","../../../../util":"xr+4"}],"XIpW":[function(require,module,exports) {
(function () {
  'use strict';

  var FREE_H_LINE_REQ,
      FREE_V_LINE_REQ,
      H_LINE,
      H_LINES,
      H_LINE_REQ,
      LINE_REQ,
      ONLY_TARGET_ALLOW,
      V_LINE,
      V_LINES,
      V_LINE_REQ,
      assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../util');
  log = require('../../../../log');
  assert = require('../../../../assert');
  log = log.scope('Renderer');
  H_LINE = 1 << 0;
  V_LINE = 1 << 1;
  LINE_REQ = 1 << 0;
  ONLY_TARGET_ALLOW = 1 << 1;
  H_LINE_REQ = 1 << 2;
  V_LINE_REQ = 1 << 3;
  FREE_H_LINE_REQ = 1 << 4;
  FREE_V_LINE_REQ = 1 << 5;
  H_LINES = {
    top: true,
    bottom: true,
    verticalCenter: true
  };
  V_LINES = {
    left: true,
    right: true,
    horizontalCenter: true
  };

  module.exports = function (Renderer, Impl, itemUtils, Item) {
    return function (ctor) {
      var Anchors;
      return Anchors = function (superClass) {
        var createAnchorProp, implMethod, stringValuesCache;
        extend(Anchors, superClass);
        Anchors.__name__ = 'Anchors';
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'anchors',
          valueConstructor: Anchors,
          developmentSetter: function developmentSetter(val) {
            return assert.isObject(val);
          },
          setter: function setter(_super) {
            return function (val) {
              var anchors;
              anchors = this.anchors;

              if (val.left != null) {
                anchors.left = val.left;
              }

              if (val.right != null) {
                anchors.right = val.right;
              }

              if (val.horizontalCenter != null) {
                anchors.horizontalCenter = val.horizontalCenter;
              }

              if (val.top != null) {
                anchors.top = val.top;
              }

              if (val.bottom != null) {
                anchors.bottom = val.bottom;
              }

              if (val.verticalCenter != null) {
                anchors.verticalCenter = val.verticalCenter;
              }

              if (val.centerIn != null) {
                anchors.centerIn = val.centerIn;
              }

              if (val.fill != null) {
                anchors.fill = val.fill;
              }

              if (val.fillWidth != null) {
                anchors.fillWidth = val.fillWidth;
              }

              if (val.fillHeight != null) {
                anchors.fillHeight = val.fillHeight;
              }

              _super.call(this, val);
            };
          }
        });

        function Anchors(ref) {
          Anchors.__super__.constructor.call(this, ref);

          this._runningCount = 0;
          this._top = null;
          this._bottom = null;
          this._verticalCenter = null;
          this._left = null;
          this._right = null;
          this._horizontalCenter = null;
          this._centerIn = null;
          this._fill = null;
          this._fillWidth = null;
          this._fillHeight = null;
          Object.preventExtensions(this);
        }

        implMethod = Impl["set" + ctor.name + "Anchor"];
        stringValuesCache = Object.create(null);

        createAnchorProp = function createAnchorProp(type, opts, _getter) {
          var internalProp, setter;

          if (opts == null) {
            opts = 0;
          }

          internalProp = "_" + type;

          setter = function setter(_super) {
            return function (val) {
              var allowedLines, arr, line, oldVal, target;

              if (val == null) {
                val = null;
              }

              oldVal = this[internalProp];

              if (typeof val === 'string') {
                if (!(arr = stringValuesCache[val])) {
                  arr = stringValuesCache[val] = val.split('.');
                }

                val = arr;
              }

              if (val != null) {
                //<development>;
                allowedLines = H_LINES[type] ? H_LINES : V_LINES;

                if (!(Array.isArray(val) && val.length > 0 && val.length < 3)) {
                  log.error("`anchors." + type + "` expects an array; `'" + val + "'` given");
                }

                target = val[0], line = val[1];

                if (opts & ONLY_TARGET_ALLOW) {
                  if (line !== void 0) {
                    log.error("`anchors." + type + "` expects only a target to be defined; " + ("`'" + val + "'` given;\npointing to the line is not required ") + "(e.g `anchors.centerIn = parent`)");
                  }
                }

                if (opts & LINE_REQ) {
                  if (!(H_LINES[line] || V_LINES[line])) {
                    log.error("`anchors." + type + "` expects an anchor line to be defined; " + ("`'" + val + "'` given;\nuse one of the `" + Object.keys(allowedLines) + "`"));
                  }
                }

                if (opts & H_LINE_REQ) {
                  if (!H_LINES[line]) {
                    log.error("`anchors." + type + "` can't be anchored to the vertical edge; " + ("`'" + val + "'` given;\nuse one of the `" + Object.keys(H_LINES) + "`"));
                  }
                }

                if (opts & V_LINE_REQ) {
                  if (!V_LINES[line]) {
                    log.error("`anchors." + type + "` can't be anchored to the horizontal edge; " + ("`'" + val + "'` given;\nuse one of the `" + Object.keys(V_LINES) + "`"));
                  }
                } //</development>;


                if (val[0] === 'this') {
                  val[0] = this;
                }
              }

              if (!!oldVal !== !!val) {
                this._runningCount += val ? 1 : -1;
              }

              return _super.call(this, val);
            };
          };

          return itemUtils.defineProperty({
            constructor: Anchors,
            name: type,
            defaultValue: null,
            implementation: function implementation(val) {
              return implMethod.call(this, type, val);
            },
            namespace: 'anchors',
            parentConstructor: ctor,
            setter: setter,
            getter: function getter() {
              return _getter;
            }
          });
        };

        createAnchorProp('left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function () {
          var ref1;

          if (this._ref) {
            return this._ref.x - (((ref1 = this._ref._margin) != null ? ref1._left : void 0) || 0);
          }
        });
        createAnchorProp('right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function () {
          var ref1;

          if (this._ref) {
            return this._ref._x + this._ref._width + (((ref1 = this._ref._margin) != null ? ref1._right : void 0) || 0);
          }
        });
        createAnchorProp('horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function () {
          if (this._ref) {
            return this._ref._x + this._ref._width / 2;
          }
        });
        createAnchorProp('top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function () {
          var ref1;

          if (this._ref) {
            return this._ref._y - (((ref1 = this._ref._margin) != null ? ref1._top : void 0) || 0);
          }
        });
        createAnchorProp('bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function () {
          var ref1;

          if (this._ref) {
            return this._ref._y + this._ref._height + (((ref1 = this._ref._margin) != null ? ref1._bottom : void 0) || 0);
          }
        });
        createAnchorProp('verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function () {
          if (this._ref) {
            return this._ref._y + this._ref._height / 2;
          }
        });
        createAnchorProp('centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ, function () {
          if (this._ref) {
            return [this.horizontalCenter, this.verticalCenter];
          }
        });
        createAnchorProp('fill', ONLY_TARGET_ALLOW, function () {
          if (this._ref) {
            return [this._ref._x, this._ref._y, this._ref._width, this._ref._height];
          }
        });
        createAnchorProp('fillWidth', ONLY_TARGET_ALLOW, function () {
          if (this._ref) {
            return [this._ref._x, this._ref._width];
          }
        });
        createAnchorProp('fillHeight', ONLY_TARGET_ALLOW, function () {
          if (this._ref) {
            return [this._ref._y, this._ref._height];
          }
        });
        return Anchors;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../log":"fe8o","../../../../assert":"lQvG"}],"jwc1":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;
  assert = require('../../../../assert');

  module.exports = function (Renderer, Impl, itemUtils, Item) {
    return function (ctor, opts) {
      var Margin;
      return Margin = function (superClass) {
        var createMarginProp, propertyName;
        extend(Margin, superClass);
        Margin.__name__ = 'Margin';
        propertyName = (opts != null ? opts.propertyName : void 0) || 'margin';
        itemUtils.defineProperty({
          constructor: ctor,
          name: propertyName,
          defaultValue: 0,
          valueConstructor: Margin,
          setter: function setter() {
            return null;
          }
        });

        function Margin(ref) {
          Margin.__super__.constructor.call(this, ref);

          this._left = 0;
          this._top = 0;
          this._right = 0;
          this._bottom = 0;
          Object.preventExtensions(this);
        }

        createMarginProp = function createMarginProp(type) {
          var setter;

          setter = function setter(_super) {
            return function (val) {
              return _super.call(this, Number(val) || 0);
            };
          };

          return itemUtils.defineProperty({
            constructor: Margin,
            name: type,
            defaultValue: 0,
            namespace: propertyName,
            parentConstructor: ctor,
            setter: setter
          });
        };

        createMarginProp('left');
        createMarginProp('top');
        createMarginProp('right');
        createMarginProp('bottom');

        Margin.prototype.valueOf = function () {
          if (this.left === this.top && this.top === this.right && this.right === this.bottom) {
            return this.left;
          } else {
            throw new Error("margin values are different");
          }
        };

        Margin.prototype.toJSON = function () {
          return {
            left: this.left,
            top: this.top,
            right: this.right,
            bottom: this.bottom
          };
        };

        return Margin;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../signal":"WtLN","../../../../assert":"lQvG"}],"jn9n":[function(require,module,exports) {
(function () {
  'use strict';

  var NOP,
      SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;
  assert = require('../../../../assert');

  NOP = function NOP() {};

  module.exports = function (Renderer, Impl, itemUtils, Item) {
    return function (ctor) {
      var Pointer;
      return Pointer = function (superClass) {
        var MOVE_SIGNALS, PRESS_SIGNALS, PointerEvent, i, initializeHover, initializePressed, len, onLazySignalInitialized, ref1, signalName;
        extend(Pointer, superClass);
        Pointer.__name__ = 'Pointer';
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'pointer',
          valueConstructor: Pointer
        });

        function Pointer(ref) {
          Pointer.__super__.constructor.call(this, ref);

          this._enabled = true;
          this._draggable = false;
          this._dragActive = false;
          this._pressed = false;
          this._hover = false;
          this._pressedInitialized = false;
          this._hoverInitialized = false;
          Object.preventExtensions(this);
        }

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'enabled',
          defaultValue: true,
          namespace: 'pointer',
          parentConstructor: ctor,
          implementation: Impl.setItemPointerEnabled,
          developmentSetter: function developmentSetter(val) {
            return assert.isBoolean(val);
          }
        });
        PRESS_SIGNALS = {
          onClick: true,
          onPress: true,
          onRelease: true
        };
        MOVE_SIGNALS = {
          onEnter: true,
          onExit: true,
          onMove: true
        };

        onLazySignalInitialized = function onLazySignalInitialized(pointer, name) {
          if (PRESS_SIGNALS[name] || MOVE_SIGNALS[name]) {
            initializePressed(pointer);

            if (MOVE_SIGNALS[name]) {
              initializeHover(pointer);
            }
          }

          Impl.attachItemSignal.call(pointer, 'pointer', name);
        };

        Pointer.SIGNALS = Object.keys(PRESS_SIGNALS).concat(Object.keys(MOVE_SIGNALS)).concat(['onWheel']);
        ref1 = Pointer.SIGNALS;

        for (i = 0, len = ref1.length; i < len; i++) {
          signalName = ref1[i];
          SignalsEmitter.createSignal(Pointer, signalName, onLazySignalInitialized);
        }

        initializePressed = function () {
          var onPress, onRelease;

          onPress = function onPress(event) {
            event.stopPropagation = false;
            return this.pressed = true;
          };

          onRelease = function onRelease() {
            return this.pressed = false;
          };

          return function (pointer) {
            if (!pointer._pressedInitialized) {
              pointer._pressedInitialized = true;
              pointer.onPress.connect(onPress);
              pointer.onRelease.connect(onRelease);
            }
          };
        }();

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'pressed',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          signalInitializer: initializePressed,
          getter: function getter(_super) {
            return function () {
              initializePressed(this);
              return _super.call(this);
            };
          }
        });

        initializeHover = function () {
          var onEnter, onExit;

          onEnter = function onEnter() {
            return this.hover = true;
          };

          onExit = function onExit() {
            return this.hover = false;
          };

          return function (pointer) {
            if (!pointer._hoverInitialized) {
              pointer._hoverInitialized = true;
              pointer.onEnter.connect(onEnter);
              pointer.onExit.connect(onExit);
            }
          };
        }();

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'hover',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          signalInitializer: initializeHover,
          getter: function getter(_super) {
            return function () {
              initializeHover(this);
              return _super.call(this);
            };
          }
        });

        Pointer.Event = PointerEvent = function () {
          function PointerEvent() {
            this._itemX = 0;
            this._itemY = 0;
            this._stopPropagation = true;
            this._checkSiblings = false;
            this._ensureRelease = true;
            this._ensureMove = true;
            this._preventClick = false;
            Object.preventExtensions(this);
          }

          PointerEvent.prototype = Object.create(Renderer.Device.pointer);
          PointerEvent.prototype.constructor = PointerEvent;
          utils.defineProperty(PointerEvent.prototype, 'itemX', null, function () {
            return this._itemX;
          }, null);
          utils.defineProperty(PointerEvent.prototype, 'itemY', null, function () {
            return this._itemY;
          }, null);
          utils.defineProperty(PointerEvent.prototype, 'stopPropagation', null, function () {
            return this._stopPropagation;
          }, function (val) {
            assert.isBoolean(val);
            return this._stopPropagation = val;
          });
          utils.defineProperty(PointerEvent.prototype, 'checkSiblings', null, function () {
            return this._checkSiblings;
          }, function (val) {
            assert.isBoolean(val);
            return this._checkSiblings = val;
          });
          utils.defineProperty(PointerEvent.prototype, 'ensureRelease', null, function () {
            return this._ensureRelease;
          }, function (val) {
            assert.isBoolean(val);
            return this._ensureRelease = val;
          });
          utils.defineProperty(PointerEvent.prototype, 'ensureMove', null, function () {
            return this._ensureMove;
          }, function (val) {
            assert.isBoolean(val);
            return this._ensureMove = val;
          });
          utils.defineProperty(PointerEvent.prototype, 'preventClick', null, function () {
            return this._preventClick;
          }, function (val) {
            assert.isBoolean(val);
            return this._preventClick = val;
          });
          return PointerEvent;
        }();

        Pointer.event = new PointerEvent();
        return Pointer;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../signal":"WtLN","../../../../assert":"lQvG"}],"8/0Z":[function(require,module,exports) {
(function () {
  'use strict';

  var SignalsEmitter,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../../../../util');
  SignalsEmitter = require('../../../../signal').SignalsEmitter;
  assert = require('../../../../assert');

  module.exports = function (Renderer, Impl, itemUtils, Item) {
    return function (ctor) {
      var Keys;
      return Keys = function (superClass) {
        var Device, KeysEvent, focusedKeys, i, keysEvent, len, ref1, signalName;
        extend(Keys, superClass);
        Keys.__name__ = 'Keys';
        Device = Renderer.Device;
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'keys',
          valueConstructor: Keys
        });
        Keys.focusedItem = null;

        Keys.Event = KeysEvent = function () {
          function KeysEvent() {
            Object.preventExtensions(this);
          }

          KeysEvent.prototype = Object.create(Device.keyboard);
          KeysEvent.prototype.constructor = KeysEvent;
          return KeysEvent;
        }();

        function Keys(ref) {
          Keys.__super__.constructor.call(this, ref);

          this._focus = false;
          Object.preventExtensions(this);
        }

        Keys.SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput'];
        ref1 = Keys.SIGNALS;

        for (i = 0, len = ref1.length; i < len; i++) {
          signalName = ref1[i];
          SignalsEmitter.createSignal(Keys, signalName);
        }

        focusedKeys = null;
        itemUtils.defineProperty({
          constructor: Keys,
          name: 'focus',
          defaultValue: false,
          implementation: Impl.setItemKeysFocus,
          namespace: 'keys',
          parentConstructor: ctor,
          developmentSetter: function developmentSetter(val) {
            return assert.isBoolean(val);
          },
          setter: function setter(_super) {
            return function (val) {
              if (this._focus !== val) {
                if (val && focusedKeys !== this) {
                  if (focusedKeys != null) {
                    focusedKeys.focus = false;
                  }

                  focusedKeys = this;
                  Keys.focusedItem = this._ref;
                }

                _super.call(this, val);

                if (!val && focusedKeys === this) {
                  focusedKeys = null;
                  Keys.focusedItem = null;
                }
              }
            };
          }
        });
        Device.onKeyPress.connect(function (event) {
          return focusedKeys != null ? focusedKeys.emit('onPress', keysEvent) : void 0;
        });
        Device.onKeyHold.connect(function (event) {
          return focusedKeys != null ? focusedKeys.emit('onHold', keysEvent) : void 0;
        });
        Device.onKeyRelease.connect(function (event) {
          return focusedKeys != null ? focusedKeys.emit('onRelease', keysEvent) : void 0;
        });
        Device.onKeyInput.connect(function (event) {
          return focusedKeys != null ? focusedKeys.emit('onInput', keysEvent) : void 0;
        });
        Keys.event = keysEvent = new KeysEvent();
        return Keys;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../util":"xr+4","../../../../signal":"WtLN","../../../../assert":"lQvG"}],"6G0o":[function(require,module,exports) {
(function () {
  'use strict';

  var Matrix,
      SignalsEmitter,
      assert,
      isArray,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../assert');
  utils = require('../../../util');
  SignalsEmitter = require('../../../signal').SignalsEmitter;
  Matrix = require('../../utils/Matrix');
  isArray = Array.isArray;
  assert = assert.scope('Renderer.Item');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Item;
    return Item = function (superClass) {
      var ChildrenObject, DocElement, insertItemInImpl, isNextSibling, isPreviousSibling, setFakeParent, updateZSiblingsForAppendedItem, updateZSiblingsForInsertedItem;
      extend(Item, superClass);
      Item.__name__ = 'Item';
      Item.__path__ = 'Renderer.Item';
      DocElement = require('../../../document/element');

      Item.New = function (opts) {
        var item;
        item = new Item();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function Item() {
        assert.instanceOf(this, Item);

        Item.__super__.constructor.call(this);

        this._parent = null;
        this._children = null;
        this._previousSibling = null;
        this._nextSibling = null;
        this._belowSibling = null;
        this._aboveSibling = null;
        this._width = 0;
        this._height = 0;
        this._x = 0;
        this._y = 0;
        this._z = 0;
        this._visible = true;
        this._clip = false;
        this._scale = 1;
        this._rotation = 0;
        this._opacity = 1;
        this._anchors = null;
        this._layout = null;
        this._fillWidth = false;
        this._fillHeight = false;
        this._keys = null;
        this._pointer = null;
        this._margin = null;
        this._padding = null;
        this._columns = 2;
        this._rows = 2e308;
        this._spacing = null;
        this._alignment = null;
        this._classes = null;
        this._query = '';
        this._element = null;
      }

      utils.defineProperty(Item.prototype, 'query', null, function () {
        return this._query;
      }, function (val) {
        if (this._query === '') {
          this._query = val;
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'element',
        defaultValue: null,
        developmentSetter: function developmentSetter(val) {
          if (val != null) {
            return assert.instanceOf(val, DocElement);
          }
        }
      });
      SignalsEmitter.createSignal(Item, 'onAnimationFrame', function () {
        var _frame, items, now;

        now = Date.now();
        items = [];

        _frame = function frame() {
          var i, item, len, ms, oldNow;
          oldNow = now;
          now = Date.now();
          ms = now - oldNow;

          for (i = 0, len = items.length; i < len; i++) {
            item = items[i];
            item.emit('onAnimationFrame', ms);
          }

          return requestAnimationFrame(_frame);
        };

        if (typeof requestAnimationFrame === "function") {
          requestAnimationFrame(_frame);
        }

        return function (item) {
          return items.push(item);
        };
      }());
      utils.defineProperty(Item.prototype, 'children', null, function () {
        return this._children || (this._children = new ChildrenObject(this));
      }, function (val) {
        var i, item, len;
        assert.isArray(val, "Item.children needs to be an array, but " + val + " given");
        this.clear();

        for (i = 0, len = val.length; i < len; i++) {
          item = val[i];
          val.parent = this;
        }
      });
      SignalsEmitter.createSignal(Item, 'onChildrenChange');

      ChildrenObject = function (superClass1) {
        extend(ChildrenObject, superClass1);

        function ChildrenObject(ref) {
          this._firstChild = null;
          this._lastChild = null;
          this._bottomChild = null;
          this._topChild = null;
          this._length = 0;

          ChildrenObject.__super__.constructor.call(this, ref);
        }

        utils.defineProperty(ChildrenObject.prototype, 'firstChild', null, function () {
          return this._firstChild;
        }, null);
        utils.defineProperty(ChildrenObject.prototype, 'lastChild', null, function () {
          return this._lastChild;
        }, null);
        utils.defineProperty(ChildrenObject.prototype, 'bottomChild', null, function () {
          return this._bottomChild;
        }, null);
        utils.defineProperty(ChildrenObject.prototype, 'topChild', null, function () {
          return this._topChild;
        }, null);
        utils.defineProperty(ChildrenObject.prototype, 'length', null, function () {
          return this._length;
        }, null);

        ChildrenObject.prototype.get = function (val) {
          var sibling;
          assert.operator(val, '>=', 0, "Item.children.get index cannot be lower than zero, " + val + " given");
          assert.operator(val, '<', this.length, "Item.children.get index must be lower than children.length, " + val + " given");

          if (val < this.length / 2) {
            sibling = this.firstChild;

            while (val > 0) {
              sibling = sibling.nextSibling;
              val--;
            }
          } else {
            sibling = this.lastChild;

            while (val > 0) {
              sibling = sibling.previousSibling;
              val--;
            }
          }

          return sibling;
        };

        ChildrenObject.prototype.index = function (val) {
          if (this.has(val)) {
            return val.index;
          } else {
            return -1;
          }
        };

        ChildrenObject.prototype.has = function (val) {
          return this._ref === val._parent;
        };

        ChildrenObject.prototype.clear = function () {
          var last;

          while (last = this.last) {
            last.parent = null;
          }
        };

        return ChildrenObject;
      }(itemUtils.MutableDeepObject);

      setFakeParent = function setFakeParent(child, parent, index) {
        if (index == null) {
          index = -1;
        }

        child.parent = null;

        if (index >= 0 && parent.children._length < index) {
          Impl.insertItemBefore.call(child, parent.children[index]);
        } else {
          Impl.setItemParent.call(child, parent);
        }

        child._parent = parent;
        child.emit('onParentChange', null);
      };

      updateZSiblingsForAppendedItem = function updateZSiblingsForAppendedItem(item, z, newChildren) {
        var child, nextChild;
        child = newChildren._topChild;

        while (child) {
          if (child._z <= z) {
            if (item._aboveSibling = child._aboveSibling) {
              item._aboveSibling._belowSibling = item;
            }

            item._belowSibling = child;
            child._aboveSibling = item;
            return;
          }

          if (!(nextChild = child._belowSibling)) {
            item._aboveSibling = child;
            child._belowSibling = item;
            item._belowSibling = null;
            return;
          }

          child = nextChild;
        }
      };

      insertItemInImpl = function insertItemInImpl(item) {
        var aboveSibling;

        if (aboveSibling = item._aboveSibling) {
          Impl.insertItemBefore.call(item, aboveSibling);
        } else {
          Impl.setItemParent.call(item, item._parent);
        }
      };

      itemUtils.defineProperty({
        constructor: Item,
        name: 'parent',
        defaultValue: null,
        setter: function setter(_super) {
          return function (val) {
            var old, oldAboveSibling, oldBelowSibling, oldChildren, oldNextSibling, oldPreviousSibling, pointer, previousSibling, valChildren;

            if (val == null) {
              val = null;
            }

            old = this._parent;
            oldChildren = old != null ? old.children : void 0;
            valChildren = val != null ? val.children : void 0;

            if (old === val) {
              return;
            }

            assert.isNot(this, val, "Item.parent cannot be set with context item, " + val + " given");

            if (pointer = this._pointer) {
              pointer.hover = pointer.pressed = false;
            }

            if (val !== null) {
              assert.instanceOf(val, Item, "Item.parent needs to be an Item or null, but " + val + " given");
            }

            oldPreviousSibling = this._previousSibling;
            oldNextSibling = this._nextSibling;

            if (oldPreviousSibling !== null) {
              oldPreviousSibling._nextSibling = oldNextSibling;
            }

            if (oldNextSibling !== null) {
              oldNextSibling._previousSibling = oldPreviousSibling;
            }

            if (val !== null) {
              if (previousSibling = this._previousSibling = valChildren.lastChild) {
                previousSibling._nextSibling = this;
              }
            } else {
              this._previousSibling = null;
            }

            if (oldNextSibling !== null) {
              this._nextSibling = null;
            }

            if (oldChildren) {
              oldChildren._length -= 1;

              if (oldChildren.firstChild === this) {
                oldChildren._firstChild = oldNextSibling;
              }

              if (oldChildren.lastChild === this) {
                oldChildren._lastChild = oldPreviousSibling;
              }
            }

            if (valChildren) {
              if (++valChildren._length === 1) {
                valChildren._firstChild = this;
              }

              valChildren._lastChild = this;
            }

            oldBelowSibling = this._belowSibling;
            oldAboveSibling = this._aboveSibling;

            if (oldBelowSibling !== null) {
              oldBelowSibling._aboveSibling = oldAboveSibling;
            }

            if (oldAboveSibling !== null) {
              oldAboveSibling._belowSibling = oldBelowSibling;
            }

            this._belowSibling = this._aboveSibling = null;

            if (valChildren) {
              updateZSiblingsForAppendedItem(this, this._z, valChildren);
            }

            if (oldChildren) {
              if (!oldAboveSibling) {
                oldChildren._topChild = oldBelowSibling;
              }

              if (!oldBelowSibling) {
                oldChildren._bottomChild = oldAboveSibling;
              }
            }

            if (valChildren) {
              if (!this._aboveSibling) {
                valChildren._topChild = this;
              }

              if (!this._belowSibling) {
                valChildren._bottomChild = this;
              }
            }

            this._parent = val;
            insertItemInImpl(this); //<development>;

            assert.is(this.nextSibling, null);

            if (val) {
              assert.is(val.children.lastChild, this);
              assert.isDefined(val.children.firstChild);
              assert.isDefined(val.children.lastChild);
              assert.isDefined(val.children.topChild);
              assert.isDefined(val.children.bottomChild);
            }

            if (old && old.children.length === 0) {
              assert.isNotDefined(old.children.firstChild);
              assert.isNotDefined(old.children.lastChild);
              assert.isNotDefined(old.children.topChild);
              assert.isNotDefined(old.children.bottomChild);
            } //</development>;


            if (old !== null) {
              old.emit('onChildrenChange', null, this);
            }

            if (val !== null) {
              val.emit('onChildrenChange', this, null);
            }

            this.emit('onParentChange', old);

            if (oldPreviousSibling !== null) {
              oldPreviousSibling.emit('onNextSiblingChange', this);
            }

            if (oldNextSibling !== null) {
              oldNextSibling.emit('onPreviousSiblingChange', this);
            }

            if (val !== null || oldPreviousSibling !== null) {
              if (previousSibling) {
                previousSibling.emit('onNextSiblingChange', null);
              }

              this.emit('onPreviousSiblingChange', oldPreviousSibling);
            }

            if (oldNextSibling !== null) {
              this.emit('onNextSiblingChange', oldNextSibling);
            }
          };
        }
      });
      utils.defineProperty(Item.prototype, 'previousSibling', null, function () {
        return this._previousSibling;
      }, function (val) {
        var nextSibling;

        if (val == null) {
          val = null;
        }

        assert.isNot(this, val, "Item.previousSibling cannot be set with context Item, " + val + " given");

        if (val === this._previousSibling) {
          return;
        }

        if (val) {
          assert.instanceOf(val, Item, "Item.previousSibling must be an Item or null, but " + val + " given");
          nextSibling = val._nextSibling;

          if (!nextSibling && val._parent !== this._parent) {
            this.parent = val._parent;
          } else {
            this.nextSibling = nextSibling;
          }
        } else {
          assert.isDefined(this._parent, "Cannot null Item.previousSibling when Item has no parent");
          this.nextSibling = this._parent.children.firstChild;
        }

        assert.is(this._previousSibling, val);
      });
      SignalsEmitter.createSignal(Item, 'onPreviousSiblingChange');

      isNextSibling = function isNextSibling(item, sibling) {
        var nextItem;

        while (item) {
          nextItem = item._nextSibling;

          if (nextItem === sibling) {
            return true;
          }

          item = nextItem;
        }

        return false;
      };

      isPreviousSibling = function isPreviousSibling(item, sibling) {
        var prevItem;

        while (item) {
          prevItem = item._previousSibling;

          if (prevItem === sibling) {
            return true;
          }

          item = prevItem;
        }

        return false;
      };

      updateZSiblingsForInsertedItem = function updateZSiblingsForInsertedItem(item, nextSibling, z, newChildren) {
        var child, nextChild;

        if (nextSibling._z === z) {
          if (item._belowSibling = nextSibling._belowSibling) {
            item._belowSibling._aboveSibling = item;
          }

          item._aboveSibling = nextSibling;
          nextSibling._belowSibling = item;
        } else {
          nextChild = newChildren._bottomChild;

          while (child = nextChild) {
            nextChild = child._aboveSibling;

            if (child._z > z || child._z === z && isNextSibling(item, child)) {
              item._aboveSibling = child;

              if (item._belowSibling = child._belowSibling) {
                item._belowSibling._aboveSibling = item;
              }

              child._belowSibling = item;
              break;
            }

            if (!nextChild) {
              item._aboveSibling = null;
              item._belowSibling = child;
              child._aboveSibling = item;
            }
          }
        }
      };

      utils.defineProperty(Item.prototype, 'nextSibling', null, function () {
        return this._nextSibling;
      }, function (val) {
        var newChildren, newParent, nextSibling, nextSiblingOldPreviousSibling, oldAboveSibling, oldBelowSibling, oldChildren, oldNextSibling, oldParent, oldPreviousSibling, previousSibling, previousSiblingOldNextSibling;

        if (val == null) {
          val = null;
        }

        assert.isNot(this, val, "Item.nextSibling cannot be set with context Item, " + val + " given");

        if (val) {
          assert.instanceOf(val, Item, "Item.nextSibling needs to be an Item or null, but " + val + " given");
          assert.isDefined(val._parent, "Item.nextSibling value needs to have a parent, given " + val + " has no parent");
        } else {
          assert.isDefined(this._parent, "Cannot null Item.nextSibling when Item has no parent");
        }

        if (val === this._nextSibling) {
          return;
        }

        oldParent = this._parent;
        oldChildren = oldParent != null ? oldParent._children : void 0;
        oldPreviousSibling = this._previousSibling;
        oldNextSibling = this._nextSibling;

        if (val) {
          newParent = val._parent;
          newChildren = newParent._children;
        } else {
          newParent = oldParent;
          newChildren = oldChildren;
        }

        this._parent = newParent;

        if (oldPreviousSibling != null) {
          oldPreviousSibling._nextSibling = oldNextSibling;
        }

        if (oldNextSibling != null) {
          oldNextSibling._previousSibling = oldPreviousSibling;
        }

        previousSibling = previousSiblingOldNextSibling = null;
        nextSibling = nextSiblingOldPreviousSibling = null;

        if (val) {
          if (previousSibling = val._previousSibling) {
            previousSiblingOldNextSibling = previousSibling._nextSibling;
            previousSibling._nextSibling = this;
          }

          nextSibling = val;
          nextSiblingOldPreviousSibling = nextSibling._previousSibling;
          nextSibling._previousSibling = this;
        } else {
          if (previousSibling = newChildren.lastChild) {
            previousSibling._nextSibling = this;
          }
        }

        this._previousSibling = previousSibling;
        this._nextSibling = nextSibling;

        if (oldChildren) {
          oldChildren._length -= 1;

          if (!oldPreviousSibling) {
            oldChildren._firstChild = oldNextSibling;
          }

          if (!oldNextSibling) {
            oldChildren._lastChild = oldPreviousSibling;
          }
        }

        newChildren._length += 1;

        if (newChildren.firstChild === val) {
          newChildren._firstChild = this;
        }

        if (!val) {
          newChildren._lastChild = this;
        }

        oldBelowSibling = this._belowSibling;
        oldAboveSibling = this._aboveSibling;

        if (oldBelowSibling !== null) {
          oldBelowSibling._aboveSibling = oldAboveSibling;
        }

        if (oldAboveSibling !== null) {
          oldAboveSibling._belowSibling = oldBelowSibling;
        }

        this._belowSibling = this._aboveSibling = null;

        if (nextSibling) {
          updateZSiblingsForInsertedItem(this, nextSibling, this._z, newChildren);
        } else {
          updateZSiblingsForAppendedItem(this, this._z, newChildren);
        }

        if (oldChildren) {
          if (!oldAboveSibling) {
            oldChildren._topChild = oldBelowSibling;
          }

          if (!oldBelowSibling) {
            oldChildren._bottomChild = oldAboveSibling;
          }
        }

        if (!this._aboveSibling) {
          newChildren._topChild = this;
        }

        if (!this._belowSibling) {
          newChildren._bottomChild = this;
        }

        insertItemInImpl(this); //<development>;

        assert.is(this._nextSibling, val);
        assert.is(this._parent, newParent);

        if (val) {
          assert.is(this._parent, val._parent);
        }

        if (this._previousSibling) {
          assert.is(this._previousSibling._nextSibling, this);
        }

        if (this._nextSibling) {
          assert.is(this._nextSibling._previousSibling, this);
        }

        if (oldPreviousSibling) {
          assert.is(oldPreviousSibling._nextSibling, oldNextSibling);
        }

        if (oldNextSibling) {
          assert.is(oldNextSibling._previousSibling, oldPreviousSibling);
        } //</development>;


        if (oldParent !== newParent) {
          if (oldParent) {
            oldParent.emit('onChildrenChange', null, this);
          }

          newParent.emit('onChildrenChange', this, null);
          this.emit('onParentChange', oldParent);
        } else {
          newParent.emit('onChildrenChange', null, null);
        }

        if (oldPreviousSibling) {
          oldPreviousSibling.emit('onNextSiblingChange', this);
        }

        if (oldNextSibling) {
          oldNextSibling.emit('onPreviousSiblingChange', this);
        }

        this.emit('onPreviousSiblingChange', oldPreviousSibling);

        if (previousSibling) {
          previousSibling.emit('onNextSiblingChange', previousSiblingOldNextSibling);
        }

        this.emit('onNextSiblingChange', oldNextSibling);

        if (nextSibling) {
          nextSibling.emit('onPreviousSiblingChange', nextSiblingOldPreviousSibling);
        }
      });
      SignalsEmitter.createSignal(Item, 'onNextSiblingChange');
      utils.defineProperty(Item.prototype, 'belowSibling', null, function () {
        return this._belowSibling;
      }, null);
      utils.defineProperty(Item.prototype, 'aboveSibling', null, function () {
        return this._aboveSibling;
      }, null);
      utils.defineProperty(Item.prototype, 'index', null, function () {
        var index, sibling;
        index = 0;
        sibling = this;

        while (sibling = sibling.previousSibling) {
          index++;
        }

        return index;
      }, function (val) {
        var children, valItem;
        assert.isInteger(val, "Item.index needs to be a integer, but " + val + " given");
        assert.isDefined(this._parent, "When setting Item.index, item needs to have a parent, " + this + " has no parent");
        assert.operator(val, '>=', 0, "Item.index needs to greater than zero, " + val + " given");
        assert.operator(val, '<=', this._parent._children.length, "Item.index needs to be lower than parent.children.length, " + val + " given");
        children = this.parent.children;

        if (val >= children.length) {
          this.nextSibling = null;
        } else if ((valItem = children.get(val)) !== this) {
          this.nextSibling = valItem;
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'visible',
        defaultValue: true,
        implementation: Impl.setItemVisible,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val, "Item.visible needs to be a boolean, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'clip',
        defaultValue: false,
        implementation: Impl.setItemClip,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val, "Item.clip needs to be a boolean, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'width',
        defaultValue: 0,
        implementation: Impl.setItemWidth,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.width needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'height',
        defaultValue: 0,
        implementation: Impl.setItemHeight,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.height needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'x',
        defaultValue: 0,
        implementation: Impl.setItemX,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.x needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'y',
        defaultValue: 0,
        implementation: Impl.setItemY,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.y needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'z',
        defaultValue: 0,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.z needs to be a float, but " + val + " given");
        },
        setter: function setter(_super) {
          return function (val) {
            var aboveSibling, child, children, nextChild, oldAboveSibling, oldBelowSibling, oldVal, parent, prevChild, ref1, ref2;
            oldVal = this._z;

            if (oldVal === val) {
              return;
            }

            _super.call(this, val);

            if (!(parent = this._parent)) {
              return;
            }

            children = parent._children;
            oldAboveSibling = this._aboveSibling;
            oldBelowSibling = this._belowSibling;

            if (val > oldVal) {
              nextChild = this._aboveSibling;

              while (child = nextChild) {
                nextChild = child._aboveSibling;

                if (child._z > val || child._z === val && isNextSibling(this, child)) {
                  if (oldAboveSibling === child) {
                    break;
                  }

                  this._aboveSibling = child;

                  if (this._belowSibling = child._belowSibling) {
                    this._belowSibling._aboveSibling = this;
                  }

                  child._belowSibling = this;
                  break;
                }

                if (!nextChild) {
                  this._aboveSibling = null;
                  this._belowSibling = child;
                  child._aboveSibling = this;
                }
              }
            }

            if (val < oldVal) {
              prevChild = this._belowSibling;

              while (child = prevChild) {
                prevChild = child._belowSibling;

                if (child._z < val || child._z === val && isPreviousSibling(this, child)) {
                  if (oldBelowSibling === child) {
                    break;
                  }

                  this._belowSibling = child;
                  aboveSibling = child._aboveSibling;

                  if (this._aboveSibling = child._aboveSibling) {
                    this._aboveSibling._belowSibling = this;
                  }

                  child._aboveSibling = this;
                  break;
                }

                if (!prevChild) {
                  this._belowSibling = null;
                  this._aboveSibling = child;
                  child._belowSibling = this;
                }
              }
            }

            if (oldBelowSibling && oldBelowSibling !== this._belowSibling) {
              oldBelowSibling._aboveSibling = oldAboveSibling;
            }

            if (oldAboveSibling && oldAboveSibling !== this._aboveSibling) {
              oldAboveSibling._belowSibling = oldBelowSibling;
            }

            if (this._belowSibling) {
              if (children._bottomChild === this) {
                children._bottomChild = oldAboveSibling;
              }
            } else {
              children._bottomChild = this;
            }

            if (this._aboveSibling) {
              if (children._topChild === this) {
                children._topChild = oldBelowSibling;
              }
            } else {
              children._topChild = this;
            }

            if (oldAboveSibling !== this._aboveSibling) {
              insertItemInImpl(this);
            } //<development>;


            assert.isNot(this._belowSibling, this);
            assert.isNot((ref1 = this._belowSibling) != null ? ref1._belowSibling : void 0, this);
            assert.isNot(this._aboveSibling, this);
            assert.isNot((ref2 = this._aboveSibling) != null ? ref2._aboveSibling : void 0, this);

            if (this._belowSibling) {
              assert.is(this._belowSibling._aboveSibling, this);
            }

            if (this._aboveSibling) {
              assert.is(this._aboveSibling._belowSibling, this);
            } //</development>;

          };
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'scale',
        defaultValue: 1,
        implementation: Impl.setItemScale,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.scale needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'rotation',
        defaultValue: 0,
        implementation: Impl.setItemRotation,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.rotation needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'opacity',
        defaultValue: 1,
        implementation: Impl.setItemOpacity,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Item.opacity needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'layout',
        defaultValue: null,
        implementation: Impl.setItemLayout,
        developmentSetter: function developmentSetter(val) {
          if (val !== null) {
            return assert.isString(val);
          }
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'fillWidth',
        defaultValue: false,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'fillHeight',
        defaultValue: false,
        developmentSetter: function developmentSetter(val) {
          return assert.isBoolean(val);
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'columns',
        defaultValue: 2,
        implementation: Impl.setItemColumns,
        developmentSetter: function developmentSetter(val) {
          return assert.operator(val, '>=', 0);
        },
        setter: function setter(_super) {
          return function (val) {
            if (val <= 0) {
              val = 1;
            }

            return _super.call(this, val);
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Item,
        name: 'rows',
        defaultValue: 2e308,
        implementation: Impl.setItemRows,
        developmentSetter: function developmentSetter(val) {
          return assert.operator(val, '>=', 0);
        },
        setter: function setter(_super) {
          return function (val) {
            if (val <= 0) {
              val = 1;
            }

            return _super.call(this, val);
          };
        }
      });

      Item.prototype.scaleInPoint = function (scale, pointX, pointY) {
        var height, heightChange, oldScale, width, widthChange, xOriginToChange, yOriginToChange;
        oldScale = this.scale;
        this.scale = scale;
        width = this.width;
        widthChange = (width * scale - width * oldScale) / 2;
        xOriginToChange = -2 * (pointX / width) + 1;
        this.x += xOriginToChange * widthChange;
        height = this.height;
        heightChange = (height * scale - height * oldScale) / 2;
        yOriginToChange = -2 * (pointY / height) + 1;
        this.y += yOriginToChange * heightChange;
      };

      Item.prototype.getGlobalComputes = function () {
        var chain, i, item, m, m2, m2Translate, mRotation, mScale, mTranslate, opacity, originX, originY, ref1, visible;
        m = new Matrix();
        ref1 = this, visible = ref1.visible, opacity = ref1.opacity;
        chain = [];
        item = this;

        while (item) {
          chain.push(item);
          visible && (visible = item.visible);
          opacity *= item.opacity;
          item = item.parent;
        }

        for (i = chain.length - 1; i >= 0; i += -1) {
          item = chain[i];
          originX = item.width / 2;
          originY = item.height / 2;
          m.translate(item.x + originX, item.y + originY);
          m.scale(item.scale);
          m.rotate(item.rotation);
          m.translate(-originX, -originY);
        }

        mScale = m.getScale();
        mRotation = m.getRotation();
        m2 = new Matrix();
        m2.translate(-this.width / 2, -this.height / 2);
        m2.rotate(mRotation);
        m2.translate(this.width * mScale / 2, this.height * mScale / 2);
        mTranslate = m.getTranslate();
        m2Translate = m2.getTranslate();
        return {
          x: mTranslate.x + m2Translate.x,
          y: mTranslate.y + m2Translate.y,
          scale: mScale,
          rotation: mRotation
        };
      };

      Item.createSpacing = require('./item/spacing')(Renderer, Impl, itemUtils, Item);
      Item.createAlignment = require('./item/alignment')(Renderer, Impl, itemUtils, Item);
      Item.createAnchors = require('./item/anchors')(Renderer, Impl, itemUtils, Item);
      Item.createMargin = require('./item/margin')(Renderer, Impl, itemUtils, Item);
      Item.createPointer = require('./item/pointer')(Renderer, Impl, itemUtils, Item);
      Item.createKeys = require('./item/keys')(Renderer, Impl, itemUtils, Item);
      Item.createAnchors(Item);
      Item.Pointer = Item.createPointer(Item);
      Item.createMargin(Item);
      Item.createMargin(Item, {
        propertyName: 'padding'
      });
      Item.createAlignment(Item);
      Item.createSpacing(Item);
      Item.Keys = Item.createKeys(Item);
      Item;
      return Item;
    }(itemUtils.Object);
  };
}).call(this);
},{"../../../assert":"lQvG","../../../util":"xr+4","../../../signal":"WtLN","../../utils/Matrix":"dDWa","../../../document/element":"7MrE","./item/spacing":"BiIz","./item/alignment":"8B6V","./item/anchors":"XIpW","./item/margin":"jwc1","./item/pointer":"jn9n","./item/keys":"8/0Z"}],"eiV3":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, log, utils;
  log = require('../log');
  utils = require('../util');
  assert = require('../assert');
  log = log.scope('Resources', 'Resource');

  module.exports = function (Resources) {
    var Resource;
    return Resource = function () {
      Resource.__name__ = 'Resource';
      Resource.__path__ = 'Resources.Resource';
      Resource.FILE_NAME = /^(.*?)(?:@([0-9p]+)x)?(?:\.([a-zA-Z0-9]+))?(?:\#([a-zA-Z0-9]+))?$/;

      Resource.fromJSON = function (json) {
        var prop, res, val;

        if (typeof json === 'string') {
          json = JSON.parse(json);
        }

        assert.isObject(json);
        res = new Resources[json.__name__]();

        for (prop in json) {
          val = json[prop];

          if (prop === '__name__') {
            continue;
          }

          res[prop] = val;
        }

        return res;
      };

      Resource.parseFileName = function (path) {
        var match;
        assert.isString(path);

        if (path && (match = Resource.FILE_NAME.exec(path))) {
          return {
            file: match[1] || void 0,
            resolution: match[2] != null ? parseFloat(match[2].replace('p', '.')) : void 0,
            format: match[3],
            property: match[4]
          };
        }
      };

      function Resource() {
        assert.instanceOf(this, Resource);
        this.file = '';
        this.name = '';
        this.color = '';
        this.width = 0;
        this.height = 0;
        this.formats = null;
        this.resolutions = null;
        this.paths = null;
        Object.seal(this);
      }

      Resource.prototype.resolve = function (uri, req) {
        var bestResolution, diff, file, format, formats, i, j, len, len1, name, property, r, ref, ref1, resolution, thisDiff, val;

        if (uri == null) {
          uri = '';
        }

        if (req === void 0 && utils.isPlainObject(uri)) {
          req = uri;
          uri = '';
        }

        if (uri !== '') {
          name = Resource.parseFileName(uri);
          file = name.file, resolution = name.resolution, property = name.property;

          if (name.format) {
            formats = [name.format];
          }
        }

        assert.isString(uri);

        if (req != null) {
          assert.isPlainObject(req);
        }

        if (file == null) {
          file = (req != null ? req.file : void 0) || this.file;
        }

        if (resolution == null) {
          resolution = (req != null ? req.resolution : void 0) || 1;
        }

        if (formats == null) {
          formats = (req != null ? req.formats : void 0) || this.formats;
        }

        if (property == null) {
          property = (req != null ? req.property : void 0) || 'file';
        }

        if (file !== this.file) {
          return;
        }

        if (property !== 'file') {
          return this[property];
        }

        if ((req != null ? req.width : void 0) != null || (req != null ? req.height : void 0) != null) {
          if (req.width != null && req.width > req.height) {
            resolution *= req.width / this.width;
          } else if (req.height != null && req.width < req.height) {
            resolution *= req.height / this.height;
          }
        }

        diff = 2e308;
        bestResolution = 0;
        ref = this.resolutions;

        for (i = 0, len = ref.length; i < len; i++) {
          val = ref[i];
          thisDiff = Math.abs(resolution - val);

          if (thisDiff < diff || thisDiff === diff && val > bestResolution) {
            diff = thisDiff;
            bestResolution = val;
          }
        }

        for (j = 0, len1 = formats.length; j < len1; j++) {
          format = formats[j];

          if (r = (ref1 = this.paths[format]) != null ? ref1[bestResolution] : void 0) {
            return r;
          }
        }
      };

      Resource.prototype.toJSON = function () {
        return utils.merge({
          __name__: this.constructor.__name__
        }, this);
      };

      return Resource;
    }();
  };
}).call(this);
},{"../log":"fe8o","../util":"xr+4","../assert":"lQvG"}],"fuji":[function(require,module,exports) {
(function () {
  'use strict';

  var Resources, assert, log, utils;
  utils = require('../util');
  log = require('../log');
  assert = require('../assert');
  log = log.scope('Resources');

  module.exports = Resources = function () {
    var URI_SEPARATOR;
    Resources.__name__ = 'Resources';
    Resources.Resources = Resources;
    Resources.Resource = require('./resource')(Resources);
    URI_SEPARATOR = '/';
    Resources.URI = /^(?:rsc|resource|resources)?:\/?\/?(.*?)((?:@(?:[0-9p]+)x)?(?:\.(?:[a-zA-Z0-9]+))?(?:\#(?:[a-zA-Z0-9]+))?)$/;

    Resources.fromJSON = function (json, resources) {
      var prop, val;

      if (resources == null) {
        resources = new Resources();
      }

      if (typeof json === 'string') {
        json = JSON.parse(json);
      }

      assert.isObject(json);

      for (prop in json) {
        val = json[prop];

        if (prop === '__name__') {
          continue;
        }

        val = Resources[val.__name__].fromJSON(val);
        assert.notOk(prop in resources, "Can't set '" + prop + "' property in this resources object, because it's already defined");
        resources[prop] = val;
      }

      return resources;
    };

    Resources.testUri = function (uri) {
      assert.isString(uri);
      return Resources.URI.test(uri);
    };

    function Resources() {}

    Resources.prototype.getResource = function (uri) {
      var chunk, match, r, rest;

      if (typeof uri === 'string') {
        if (match = Resources.URI.exec(uri)) {
          uri = match[1];
        }
      }

      chunk = uri;

      while (chunk) {
        if (r = this[chunk]) {
          rest = uri.slice(chunk.length + 1);

          if (rest !== '' && r instanceof Resources) {
            return r.getResource(rest);
          } else if (uri === chunk) {
            return r;
          }

          return;
        }

        chunk = chunk.substring(0, chunk.lastIndexOf(URI_SEPARATOR));
      }
    };

    Resources.prototype.resolve = function (uri, req) {
      var ref, rsc, rscUri;

      if (!Resources.testUri(uri)) {
        return;
      }

      rsc = this.getResource(uri);
      rscUri = (ref = Resources.URI.exec(uri)) != null ? ref[2] : void 0;
      return rsc != null ? rsc.resolve(rscUri, req) : void 0;
    };

    Resources.prototype.toJSON = function () {
      return utils.merge({
        __name__: this.constructor.__name__
      }, this);
    };

    return Resources;
  }();
}).call(this);
},{"../util":"xr+4","../log":"fe8o","../assert":"lQvG","./resource":"eiV3"}],"59g0":[function(require,module,exports) {
(function () {
  'use strict';

  var Resources,
      SignalDispatcher,
      SignalsEmitter,
      assert,
      log,
      ref,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../assert');
  ref = require('../../../signal'), SignalDispatcher = ref.SignalDispatcher, SignalsEmitter = ref.SignalsEmitter;
  log = require('../../../log');
  utils = require('../../../util');
  Resources = require('../../../resources');
  log = log.scope('Renderer', 'Image');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Image;
    return Image = function (superClass) {
      var getter, itemHeightSetter, itemWidthSetter, pixelRatio, updateSize;
      extend(Image, superClass);
      Image.__name__ = 'Image';
      Image.__path__ = 'Renderer.Image';

      Image.New = function (opts) {
        var item;
        item = new Image();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function Image() {
        Image.__super__.constructor.call(this);

        this._source = '';
        this._loaded = false;
        this._resolution = 1;
        this._sourceWidth = 0;
        this._sourceHeight = 0;
        this._autoWidth = true;
        this._autoHeight = true;
        this._width = -1;
        this._height = -1;
      }

      Image.onPixelRatioChange = new SignalDispatcher();
      pixelRatio = 1;
      utils.defineProperty(Image, 'pixelRatio', utils.CONFIGURABLE, function () {
        return pixelRatio;
      }, function (val) {
        var oldVal;
        assert.isFloat(val, "Image.pixelRatio needs to be a float, but " + val + " given");

        if (val === pixelRatio) {
          return;
        }

        oldVal = pixelRatio;
        pixelRatio = val;
        return this.onPixelRatioChange.emit(oldVal);
      });

      updateSize = function updateSize() {
        if (this._autoHeight === this._autoWidth) {
          return;
        }

        if (this._autoHeight) {
          itemHeightSetter.call(this, this._width / this.sourceWidth * this.sourceHeight || 0);
        }

        if (this._autoWidth) {
          itemWidthSetter.call(this, this._height / this.sourceHeight * this.sourceWidth || 0);
        }
      };

      Image.prototype._width = -1;
      getter = utils.lookupGetter(Image.prototype, 'width');
      itemWidthSetter = utils.lookupSetter(Image.prototype, 'width');
      utils.defineProperty(Image.prototype, 'width', null, getter, function (_super) {
        return function (val) {
          this._autoWidth = val === -1;

          _super.call(this, val);

          updateSize.call(this);
        };
      }(itemWidthSetter));
      Image.prototype._height = -1;
      getter = utils.lookupGetter(Image.prototype, 'height');
      itemHeightSetter = utils.lookupSetter(Image.prototype, 'height');
      utils.defineProperty(Image.prototype, 'height', null, getter, function (_super) {
        return function (val) {
          this._autoHeight = val === -1;

          _super.call(this, val);

          updateSize.call(this);
        };
      }(itemHeightSetter));
      itemUtils.defineProperty({
        constructor: Image,
        name: 'source',
        defaultValue: '',
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val, "Image.source needs to be a string, but " + val + " given");
        },
        setter: function () {
          var RESOURCE_REQUEST, defaultResult, loadCallback, setSize;
          RESOURCE_REQUEST = {
            resolution: 1
          };
          defaultResult = {
            source: '',
            width: 0,
            height: 0
          };

          setSize = function setSize(size) {
            assert.isFloat(size.width);
            assert.isFloat(size.height);
            itemUtils.setPropertyValue(this, 'sourceWidth', size.width);
            itemUtils.setPropertyValue(this, 'sourceHeight', size.height);

            if (this._autoWidth) {
              itemWidthSetter.call(this, size.width);
            }

            if (this._autoHeight) {
              itemHeightSetter.call(this, size.height);
            }

            updateSize.call(this);
          };

          loadCallback = function loadCallback(err, opts) {
            if (err == null) {
              err = null;
            }

            if (err) {
              log.warn("Can't load '" + this.source + "' image at " + this.toString());
            } else {
              assert.isString(opts.source);

              if (this.sourceWidth === 0 || this.sourceHeight === 0) {
                setSize.call(this, opts);
              } else {
                itemUtils.setPropertyValue(this, 'resolution', opts.width / this.sourceWidth);
              }
            }

            this._loaded = true;
            this.emit('onLoadedChange', false);

            if (err) {
              this.emit('onError', err);
            } else {
              this.emit('onLoad');
            }
          };

          return function (_super) {
            return function (val) {
              var ref1, res, resolution;

              _super.call(this, val);

              if (this._loaded) {
                this._loaded = false;
                this.emit('onLoadedChange', true);
              }

              itemUtils.setPropertyValue(this, 'sourceWidth', 0);
              itemUtils.setPropertyValue(this, 'sourceHeight', 0);
              itemUtils.setPropertyValue(this, 'resolution', 1);

              if (Resources.testUri(val)) {
                if (res = (ref1 = Impl.resources) != null ? ref1.getResource(val) : void 0) {
                  resolution = Renderer.Device.pixelRatio * Image.pixelRatio;
                  RESOURCE_REQUEST.resolution = resolution;
                  val = res.resolve(RESOURCE_REQUEST);
                  setSize.call(this, res);
                } else {
                  log.warn("Unknown resource given `" + val + "`");
                  val = '';
                }
              }

              if (val) {
                Impl.setImageSource.call(this, val, loadCallback);
              } else {
                Impl.setImageSource.call(this, null, null);
                defaultResult.source = val;
                loadCallback.call(this, null, defaultResult);
              }
            };
          };
        }()
      });
      itemUtils.defineProperty({
        constructor: Image,
        name: 'resolution',
        defaultValue: 1,
        setter: function setter(_super) {
          return function () {};
        }
      });
      itemUtils.defineProperty({
        constructor: Image,
        name: 'sourceWidth',
        defaultValue: 0,
        setter: function setter(_super) {
          return function () {};
        }
      });
      itemUtils.defineProperty({
        constructor: Image,
        name: 'sourceHeight',
        defaultValue: 0,
        setter: function setter(_super) {
          return function () {};
        }
      });
      utils.defineProperty(Image.prototype, 'loaded', null, function () {
        return this._loaded;
      }, null);
      SignalsEmitter.createSignal(Image, 'onLoadedChange');
      SignalsEmitter.createSignal(Image, 'onLoad');
      SignalsEmitter.createSignal(Image, 'onError');
      return Image;
    }(Renderer.Item);
  };
}).call(this);
},{"../../../assert":"lQvG","../../../signal":"WtLN","../../../log":"fe8o","../../../util":"xr+4","../../../resources":"fuji"}],"DPRb":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../../assert');
  utils = require('../../../../util');
  log = require('../../../../log');
  log = log.scope('Renderer', 'Font');

  module.exports = function (Renderer, Impl, itemUtils) {
    return function (ctor) {
      var Font;
      return Font = function (superClass) {
        var checkingFamily, reloadFontFamily, setFontFamilyImpl;
        extend(Font, superClass);
        Font.__name__ = 'Font';
        itemUtils.defineProperty({
          constructor: ctor,
          name: 'font',
          defaultValue: null,
          valueConstructor: Font,
          developmentSetter: function developmentSetter(val) {
            if (val != null) {
              return assert.isObject(val);
            }
          },
          setter: function setter(_super) {
            return function (val) {
              var font;

              _super.call(this, val);

              if (utils.isObject(val)) {
                font = this.font;

                if (val.family != null) {
                  font.family = val.family;
                }

                if (val.pixelSize != null) {
                  font.pixelSize = val.pixelSize;
                }

                if (val.weight != null) {
                  font.weight = val.weight;
                }

                if (val.wordSpacing != null) {
                  font.wordSpacing = val.wordSpacing;
                }

                if (val.letterSpacing != null) {
                  font.letterSpacing = val.letterSpacing;
                }

                if (val.italic != null) {
                  font.italic = val.italic;
                }
              }
            };
          }
        });

        function Font(ref) {
          Font.__super__.constructor.call(this, ref);

          this._family = 'sans-serif';
          this._pixelSize = 14;
          this._weight = 0.4;
          this._wordSpacing = 0;
          this._letterSpacing = 0;
          this._italic = false;
          Object.preventExtensions(this);
        }

        setFontFamilyImpl = Impl["set" + ctor.name + "FontFamily"];

        reloadFontFamily = function reloadFontFamily(font) {
          var name;
          name = Renderer.FontLoader.getInternalFontName(font._family, font._weight, font._italic);
          name || (name = 'sans-serif');
          return setFontFamilyImpl.call(font._ref, name);
        }; //<development>;


        checkingFamily = {}; //</development>;

        itemUtils.defineProperty({
          constructor: Font,
          name: 'family',
          defaultValue: 'sans-serif',
          namespace: 'font',
          parentConstructor: ctor,
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val, "Font.family needs to be a string, but " + val + " given");
          },
          setter: function setter(_super) {
            return function (val) {
              _super.call(this, val);

              return reloadFontFamily(this);
            };
          }
        });
        itemUtils.defineProperty({
          constructor: Font,
          name: 'pixelSize',
          defaultValue: 14,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "FontPixelSize"],
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val, "Font.pixelSize needs to be a float, but " + val + " given");
          }
        });
        itemUtils.defineProperty({
          constructor: Font,
          name: 'weight',
          defaultValue: 0.4,
          namespace: 'font',
          parentConstructor: ctor,
          developmentSetter: function developmentSetter(val) {
            assert.isFloat(val, "Font.weight needs to be a float, but " + val + " given");
            assert.operator(val, '>=', 0, "Font.weight needs to be in range 0-1, " + val + " given");
            return assert.operator(val, '<=', 1, "Font.weight needs to be in range 0-1, " + val + " given");
          },
          setter: function setter(_super) {
            return function (val) {
              _super.call(this, val);

              return reloadFontFamily(this);
            };
          }
        });
        itemUtils.defineProperty({
          constructor: Font,
          name: 'wordSpacing',
          defaultValue: 0,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "FontWordSpacing"],
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val, "Font.wordSpacing needs to be a float, but " + val + " given");
          }
        });
        itemUtils.defineProperty({
          constructor: Font,
          name: 'letterSpacing',
          defaultValue: 0,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.name + "FontLetterSpacing"],
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val, "Font.letterSpacing needs to be a float, but " + val + " given");
          }
        });
        itemUtils.defineProperty({
          constructor: Font,
          name: 'italic',
          defaultValue: false,
          namespace: 'font',
          parentConstructor: ctor,
          developmentSetter: function developmentSetter(val) {
            return assert.isBoolean(val, "Font.italic needs to be a boolean, but " + val + " given");
          },
          setter: function setter(_super) {
            return function (val) {
              _super.call(this, val);

              return reloadFontFamily(this);
            };
          }
        });

        Font.prototype.toJSON = function () {
          return {
            family: this.family,
            pixelSize: this.pixelSize,
            weight: this.weight,
            wordSpacing: this.wordSpacing,
            letterSpacing: this.letterSpacing,
            italic: this.italic
          };
        };

        return Font;
      }(itemUtils.DeepObject);
    };
  };
}).call(this);
},{"../../../../assert":"lQvG","../../../../util":"xr+4","../../../../log":"fe8o"}],"ppxw":[function(require,module,exports) {
(function () {
  'use strict';

  var assert,
      log,
      signal,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../assert');
  utils = require('../../../util');
  signal = require('../../../signal');
  log = require('../../../log');
  log = log.scope('Renderer', 'Text');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Text;

    Text = function (superClass) {
      var getter, itemHeightSetter, itemWidthSetter;
      extend(Text, superClass);
      Text.__name__ = 'Text';
      Text.__path__ = 'Renderer.Text';
      Text.SUPPORTED_HTML_TAGS = {
        b: true,
        strong: true,
        em: true,
        br: true,
        font: true,
        i: true,
        s: true,
        u: true,
        a: true
      };

      Text.New = function (opts) {
        var item, name;
        item = new Text();
        itemUtils.Object.initialize(item, opts);

        if (name = Renderer.FontLoader.getInternalFontName('sans-serif', 0.4, false)) {
          Impl.setTextFontFamily.call(item, name);
        }

        return item;
      };

      function Text() {
        Text.__super__.constructor.call(this);

        this._text = '';
        this._color = 'black';
        this._linkColor = 'blue';
        this._lineHeight = 1;
        this._contentWidth = 0;
        this._contentHeight = 0;
        this._font = null;
        this._alignment = null;
        this._autoWidth = true;
        this._autoHeight = true;
        this._width = -1;
        this._height = -1;
      }

      Text.prototype._width = -1;
      getter = utils.lookupGetter(Text.prototype, 'width');
      itemWidthSetter = utils.lookupSetter(Text.prototype, 'width');
      utils.defineProperty(Text.prototype, 'width', null, getter, function (_super) {
        return function (val) {
          var oldAutoWidth;
          oldAutoWidth = this._autoWidth;

          if (this._autoWidth = val === -1) {
            _super.call(this, this._contentWidth);
          } else {
            _super.call(this, val);
          }

          if (this._autoWidth || this._autoHeight) {
            Impl.updateTextContentSize.call(this);
          }

          if (oldAutoWidth !== this._autoWidth) {
            Impl.setTextWrap.call(this, !this._autoWidth);
          }
        };
      }(itemWidthSetter));
      Text.prototype._height = -1;
      getter = utils.lookupGetter(Text.prototype, 'height');
      itemHeightSetter = utils.lookupSetter(Text.prototype, 'height');
      utils.defineProperty(Text.prototype, 'height', null, getter, function (_super) {
        return function (val) {
          if (this._autoHeight = val === -1) {
            _super.call(this, this._contentHeight);

            Impl.updateTextContentSize.call(this);
          } else {
            _super.call(this, val);
          }
        };
      }(itemHeightSetter));
      itemUtils.defineProperty({
        constructor: Text,
        name: 'text',
        defaultValue: '',
        implementation: Impl.setText,
        setter: function setter(_super) {
          return function (val) {
            return _super.call(this, val + '');
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Text,
        name: 'color',
        defaultValue: 'black',
        implementation: Impl.setTextColor,
        implementationValue: function () {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function (val) {
            var ref;
            return ((ref = Impl.resources) != null ? ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        }(),
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val, "Text.color needs to be a string, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Text,
        name: 'linkColor',
        defaultValue: 'blue',
        implementation: Impl.setTextLinkColor,
        implementationValue: function () {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function (val) {
            var ref;
            return ((ref = Impl.resources) != null ? ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        }(),
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val);
        }
      });
      itemUtils.defineProperty({
        constructor: Text,
        name: 'lineHeight',
        defaultValue: 1,
        implementation: Impl.setTextLineHeight,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Text.lineHeight needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Text,
        name: 'contentWidth',
        defaultValue: 0,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        },
        setter: function setter(_super) {
          return function (val) {
            _super.call(this, val);

            if (this._autoWidth) {
              itemWidthSetter.call(this, val);
            }
          };
        }
      });
      itemUtils.defineProperty({
        constructor: Text,
        name: 'contentHeight',
        defaultValue: 0,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val);
        },
        setter: function setter(_super) {
          return function (val) {
            _super.call(this, val);

            if (this._autoHeight) {
              itemHeightSetter.call(this, val);
            }
          };
        }
      });
      Renderer.Item.createAlignment(Text);
      Text.createFont = require('./text/font')(Renderer, Impl, itemUtils);
      Text.createFont(Text);
      return Text;
    }(Renderer.Item);

    return Text;
  };
}).call(this);
},{"../../../assert":"lQvG","../../../util":"xr+4","../../../signal":"WtLN","../../../log":"fe8o","./text/font":"DPRb"}],"1OZd":[function(require,module,exports) {
(function () {
  'use strict';

  var IS_NATIVE,
      Resources,
      assert,
      callNativeFunction,
      colorUtils,
      log,
      onNativeEvent,
      ref,
      util,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty,
      slice = [].slice;

  util = require('../../../util');
  log = require('../../../log');
  assert = require('../../../assert');
  colorUtils = require('../../utils/color');
  Resources = require('../../../resources');
  IS_NATIVE = undefined;

  if (undefined) {
    ref = require('../../../native/handler'), callNativeFunction = ref.callNativeFunction, onNativeEvent = ref.onNativeEvent;
  }

  module.exports = function (Renderer, Impl, itemUtils) {
    var Native;

    Native = function (superClass) {
      var PROPERTY_TYPES, createNativeEventListener, eventListeners, getter, itemHeightSetter, itemWidthSetter;
      extend(Native, superClass);
      Native.__name__ = 'Native';
      Native.__path__ = 'Renderer.Native';

      Native.New = function (opts) {
        var item;
        item = new this();
        itemUtils.Object.initialize(item, opts);

        if (typeof this.Initialize === "function") {
          this.Initialize(item);
        }

        return item;
      };

      PROPERTY_TYPES = Object.create(null);

      PROPERTY_TYPES.text = function () {
        return {
          defaultValue: '',
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val);
          }
        };
      };

      PROPERTY_TYPES.number = function () {
        return {
          defaultValue: 0,
          developmentSetter: function developmentSetter(val) {
            return assert.isFloat(val);
          }
        };
      };

      PROPERTY_TYPES.boolean = function () {
        return {
          defaultValue: false,
          developmentSetter: function developmentSetter(val) {
            return assert.isBoolean(val);
          }
        };
      };

      PROPERTY_TYPES.resource = function (config) {
        return {
          defaultValue: '',
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val);
          },
          implementationValue: function () {
            var RESOURCE_REQUEST, getResourceResolutionByPath;
            RESOURCE_REQUEST = {
              resolution: 1
            };

            if (typeof requestAnimationFrame === "function") {
              requestAnimationFrame(function () {
                return RESOURCE_REQUEST.resolution = Renderer.Device.pixelRatio;
              });
            }

            getResourceResolutionByPath = function getResourceResolutionByPath(rsc, path) {
              var format, j, len, paths, ref1, resolution;
              ref1 = rsc.formats;

              for (j = 0, len = ref1.length; j < len; j++) {
                format = ref1[j];
                paths = rsc.paths[format];

                if (!paths) {
                  continue;
                }

                for (resolution in paths) {
                  if (paths[resolution] === path) {
                    return parseFloat(resolution);
                  }
                }
              }

              return 1;
            };

            return function (val) {
              var path, ref1, ref2, resource;

              if (!Resources.testUri(val)) {
                return val;
              }

              resource = (ref1 = Impl.resources) != null ? ref1.getResource(val) : void 0;

              if (resource) {
                path = resource.resolve(RESOURCE_REQUEST);

                if ((ref2 = config.onResolutionChange) != null) {
                  ref2.call(this, getResourceResolutionByPath(resource, path));
                }

                return path;
              } else {
                log.warn("Unknown resource given `" + val + "`");
                return '';
              }
            };
          }()
        };
      };

      PROPERTY_TYPES.color = function (config) {
        return {
          defaultValue: '',
          developmentSetter: function developmentSetter(val) {
            return assert.isString(val);
          },
          implementationValue: function () {
            var RESOURCE_REQUEST;
            RESOURCE_REQUEST = {
              property: 'color'
            };
            return function (val) {
              var ref1;
              val = ((ref1 = Impl.resources) != null ? ref1.resolve(val, RESOURCE_REQUEST) : void 0) || val;

              if (IS_NATIVE) {
                if (val != null) {
                  return colorUtils.toRGBAHex(val, config.defaultValue);
                } else {
                  return null;
                }
              } else {
                return val;
              }
            };
          }()
        };
      };

      PROPERTY_TYPES.item = function (config) {
        return {
          defaultValue: null,
          developmentSetter: function developmentSetter(val) {
            if (val != null) {
              return assert.instanceOf(val, Renderer.Item);
            }
          },
          implementationValue: function implementationValue(val) {
            if (IS_NATIVE) {
              if (val != null) {
                return val._impl.id;
              } else {
                return null;
              }
            } else {
              return val;
            }
          }
        };
      };

      Native.defineProperty = function (config) {
        var itemName, key, properties, typeConfig, typeConfigFunc, val;
        itemName = this.name;
        properties = this._properties != null ? this._properties : this._properties = [];
        config = util.clone(config);
        assert.isObject(config, 'NativeItem.defineProperty config parameter must be an object');
        assert.isString(config.name, 'NativeItem property name must be a string');
        assert.isNotDefined(properties[config.name], "Property " + config.name + " is already defined");

        if (config.type) {
          assert.isDefined(PROPERTY_TYPES[config.type], "Unknown property type " + config.type);
        }

        if (typeConfigFunc = PROPERTY_TYPES[config.type]) {
          typeConfig = typeConfigFunc(config);

          for (key in typeConfig) {
            val = typeConfig[key];

            if (!(key in config)) {
              config[key] = val;
            }
          }
        }

        config.constructor = this;
        config.internalName = itemUtils.getPropInternalName(config.name);

        config.implementation = function () {
          var ctorName, funcName, name;

          if (config.enabled === false) {
            return util.NOP;
          }

          ctorName = util.capitalize(itemName);
          name = util.capitalize(config.name);

          if (IS_NATIVE) {
            funcName = "rendererSet" + ctorName + name;
            return function (val) {
              return callNativeFunction(funcName, [this._impl.id, val]);
            };
          } else {
            funcName = "set" + ctorName + name;
            return function (val) {
              var ref1;
              return (ref1 = Impl[funcName]) != null ? ref1.call(this, val) : void 0;
            };
          }
        }();

        properties.push(config);
        return itemUtils.defineProperty(config);
      };

      Native.setPropertyValue = itemUtils.setPropertyValue;

      Native.addTypeImplementation = function (impl) {
        return Impl.addTypeImplementation(this.constructor.name, impl);
      };

      function Native() {
        var j, len, properties, property;

        Native.__super__.constructor.call(this);

        this._autoWidth = true;
        this._autoHeight = true;
        this._width = -1;
        this._height = -1;

        if (properties = this.constructor._properties) {
          for (j = 0, len = properties.length; j < len; j++) {
            property = properties[j];
            this[property.internalName] = property.defaultValue;
          }
        }

        return;
      }

      Native.prototype._width = -1;
      getter = util.lookupGetter(Native.prototype, 'width');
      itemWidthSetter = util.lookupSetter(Native.prototype, 'width');
      util.defineProperty(Native.prototype, 'width', null, getter, function (_super) {
        return function (val) {
          if (this._autoWidth = val === -1) {
            Impl.updateNativeSize.call(this);
          } else {
            _super.call(this, val);
          }
        };
      }(itemWidthSetter));
      Native.prototype._height = -1;
      getter = util.lookupGetter(Native.prototype, 'height');
      itemHeightSetter = util.lookupSetter(Native.prototype, 'height');
      util.defineProperty(Native.prototype, 'height', null, getter, function (_super) {
        return function (val) {
          if (this._autoHeight = val === -1) {
            Impl.updateNativeSize.call(this);
          } else {
            _super.call(this, val);
          }
        };
      }(itemHeightSetter));

      Native.prototype.set = function (name, val) {
        var ctorName, funcName, id, ref1;
        assert.isString(name, "NativeItem.set name must be a string, but " + name + " given");
        ctorName = util.capitalize(this.constructor.name);
        id = this._impl.id;
        name = util.capitalize(name);

        if (IS_NATIVE) {
          funcName = "rendererSet" + ctorName + name;
          callNativeFunction(funcName, [id, val]);
        } else {
          funcName = "set" + ctorName + name;

          if ((ref1 = Impl[funcName]) != null) {
            ref1.call(this, val);
          }
        }
      };

      Native.prototype.call = function () {
        var args, callArgs, ctorName, funcName, id, name, ref1;
        name = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
        assert.isString(name, "NativeItem.call name must be a string, but " + name + " given");
        ctorName = util.capitalize(this.constructor.name);
        id = this._impl.id;
        name = util.capitalize(name);

        if (IS_NATIVE) {
          funcName = "rendererCall" + ctorName + name;
          callArgs = [funcName, [id].concat(slice.call(args))];
          callNativeFunction.apply(null, callArgs);
        } else {
          funcName = "call" + ctorName + name;

          if ((ref1 = Impl[funcName]) != null) {
            ref1.apply(this, args);
          }
        }
      };

      eventListeners = Object.create(null);

      createNativeEventListener = function createNativeEventListener(listeners, eventName) {
        return function (id) {
          var args, i, item, itemListeners, j, k, length, ref1, ref2;

          if (!(itemListeners = listeners[id])) {
            log.warn("Got a native event '" + eventName + "' for an item which " + "didn't register a listener on this event; check if you " + "properly call 'on()' method with a signal listener");
            return;
          }

          length = arguments.length;
          args = new Array(length - 1);

          for (i = j = 0, ref1 = length - 1; j < ref1; i = j += 1) {
            args[i] = arguments[i + 1];
          }

          item = itemListeners[0];

          for (i = k = 1, ref2 = itemListeners.length; k < ref2; i = k += 1) {
            itemListeners[i].apply(item, args);
          }
        };
      };

      Native.prototype.on = function (name, func) {
        var ctorName, eventName, itemListeners, listeners, name1, ref1;
        assert.isString(name, "NativeItem.on name must be a string, but " + name + " given");
        assert.isFunction(func, "NativeItem.on listener must be a function, but " + func + " given");
        name = util.capitalize(name);

        if (IS_NATIVE) {
          ctorName = util.capitalize(this.constructor.name);
          eventName = "rendererOn" + ctorName + name;

          if (!(listeners = eventListeners[eventName])) {
            listeners = eventListeners[eventName] = Object.create(null);
            onNativeEvent(eventName, createNativeEventListener(listeners, eventName));
          }

          itemListeners = listeners[name1 = this._impl.id] != null ? listeners[name1] : listeners[name1] = [this];
          itemListeners.push(func);
        } else {
          eventName = "on" + name;

          if ((ref1 = this._impl[eventName]) != null) {
            ref1.connect(func, this);
          }
        }
      };

      return Native;
    }(Renderer.Item);

    return Native;
  };
}).call(this);
},{"../../../util":"xr+4","../../../log":"fe8o","../../../assert":"lQvG","../../utils/color":"jPDc","../../../resources":"fuji"}],"rJQq":[function(require,module,exports) {
(function () {
  'use strict';

  var Resources,
      assert,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../../assert');
  utils = require('../../../util');
  log = require('../../../log');
  Resources = require('../../../resources');
  log = log.scope('Renderer', 'Rectangle');

  module.exports = function (Renderer, Impl, itemUtils) {
    var Border, DEFAULT_COLOR, Rectangle, getColor;
    DEFAULT_COLOR = 'transparent';

    getColor = function () {
      var RESOURCE_REQUEST;
      RESOURCE_REQUEST = {
        property: 'color'
      };
      return function (val) {
        var ref1, rscVal;

        if (Resources.testUri(val)) {
          if (rscVal = (ref1 = Impl.resources) != null ? ref1.resolve(val, RESOURCE_REQUEST) : void 0) {
            return rscVal;
          } else {
            log.warn("Unknown resource given `" + val + "`");
            return DEFAULT_COLOR;
          }
        }

        return val;
      };
    }();

    Rectangle = function (superClass) {
      extend(Rectangle, superClass);
      Rectangle.__name__ = 'Rectangle';
      Rectangle.__path__ = 'Renderer.Rectangle';

      Rectangle.New = function (opts) {
        var item;
        item = new Rectangle();
        itemUtils.Object.initialize(item, opts);
        return item;
      };

      function Rectangle() {
        Rectangle.__super__.constructor.call(this);

        this._color = DEFAULT_COLOR;
        this._radius = 0;
        this._border = null;
      }

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'color',
        defaultValue: DEFAULT_COLOR,
        implementation: Impl.setRectangleColor,
        implementationValue: getColor,
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val, "Rectangle.color needs to be a string, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'radius',
        defaultValue: 0,
        implementation: Impl.setRectangleRadius,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Rectangle.radius needs to be a float, but " + val + " given");
        }
      });
      return Rectangle;
    }(Renderer.Item);

    Border = function (superClass) {
      extend(Border, superClass);
      Border.__name__ = 'Border';
      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'border',
        valueConstructor: Border,
        developmentSetter: function developmentSetter(val) {
          return assert.isObject(val);
        },
        setter: function setter(_super) {
          return function (val) {
            var border;
            border = this.border;

            if (val.width != null) {
              border.width = val.width;
            }

            if (val.color != null) {
              border.color = val.color;
            }

            _super.call(this, val);
          };
        }
      });

      function Border(ref) {
        this._width = 0;
        this._color = DEFAULT_COLOR;

        Border.__super__.constructor.call(this, ref);
      }

      itemUtils.defineProperty({
        constructor: Border,
        name: 'width',
        defaultValue: 0,
        namespace: 'border',
        parentConstructor: Rectangle,
        implementation: Impl.setRectangleBorderWidth,
        developmentSetter: function developmentSetter(val) {
          return assert.isFloat(val, "Rectangle.border.width needs to be a float, but " + val + " given");
        }
      });
      itemUtils.defineProperty({
        constructor: Border,
        name: 'color',
        defaultValue: DEFAULT_COLOR,
        namespace: 'border',
        parentConstructor: Rectangle,
        implementation: Impl.setRectangleBorderColor,
        implementationValue: getColor,
        developmentSetter: function developmentSetter(val) {
          return assert.isString(val, "Rectangle.border.color needs to be a string, but " + val + " given");
        }
      });

      Border.prototype.toJSON = function () {
        return {
          width: this.width,
          color: this.color
        };
      };

      return Border;
    }(itemUtils.DeepObject);

    return Rectangle;
  };
}).call(this);
},{"../../../assert":"lQvG","../../../util":"xr+4","../../../log":"fe8o","../../../resources":"fuji"}],"tAoW":[function(require,module,exports) {
(function () {
  'use strict';

  var assert, log, signal, utils;
  assert = require('../../../assert');
  utils = require('../../../util');
  log = require('../../../log');
  signal = require('../../../signal');
  log = log.scope('Renderer', 'FontLoader');

  module.exports = function (Renderer, Impl, itemUtils) {
    var FontLoader;
    return FontLoader = function () {
      var WEIGHTS, fontsByName, getFontWeight, isItalic;
      fontsByName = Object.create(null);
      WEIGHTS = [/hairline/i, /thin/i, /ultra.*light/i, /extra.*light/i, /light/i, /book/i, /normal|regular|roman|plain/i, /medium/i, /demi.*bold|semi.*bold/i, /bold/i, /extra.*bold|extra/i, /heavy/i, /black/i, /extra.*black/i, /ultra.*black|ultra/i];

      getFontWeight = function getFontWeight(source) {
        var found, i, j, len, re;
        found = -1;

        for (i = j = 0, len = WEIGHTS.length; j < len; i = ++j) {
          re = WEIGHTS[i];

          if (re.test(source)) {
            found = i;

            if (i <= WEIGHTS.length / 2) {
              break;
            }
          }
        }

        if (found >= 0) {
          return found / (WEIGHTS.length - 1);
        }

        log.warn("Can't find font weight in the got source; `" + source + "` got");
        return 0.4;
      };

      isItalic = function isItalic(source) {
        return /italic|oblique/i.test(source);
      };

      FontLoader.getInternalFontName = function (name, weight, italic) {
        var closest, closestLeft, closestRight, i, j, k, obj, ref, ref1, ref2, result, weightInt;
        result = '';

        if (obj = fontsByName[name]) {
          if (!obj[italic]) {
            log.warn("Font '" + name + "' italic style is not loaded");
          }

          if (obj = obj[italic] || obj[!italic]) {
            weightInt = Math.round(weight * WEIGHTS.length);

            if (!(result = obj[weightInt])) {
              closestLeft = -1;

              for (i = j = ref = weightInt - 1; j >= 0; i = j += -1) {
                if (obj[i]) {
                  closestLeft = i;
                  break;
                }
              }

              closestRight = -1;

              for (i = k = ref1 = weightInt + 1, ref2 = WEIGHTS.length; k < ref2; i = k += 1) {
                if (obj[i]) {
                  closestRight = i;
                  break;
                }
              }

              if (closestLeft >= 0 && closestRight >= 0) {
                if (closestRight - weightInt < weightInt - closestLeft) {
                  closest = closestRight;
                } else {
                  closest = closestLeft;
                }
              } else if (closestLeft >= 0) {
                closest = closestLeft;
              } else if (closestRight >= 0) {
                closest = closestRight;
              }

              result = obj[closest];
            }
          }
        }

        return result;
      };

      function FontLoader(name1, source1) {
        this.name = name1;
        this.source = source1;
        assert.isString(this.name, "FontLoader.name needs to be a string, but " + this.name + " given");
        assert.notLengthOf(this.name, 0, "FontLoader.name cannot be an empty string");
        assert.isString(this.source, "FontLoader.source needs to be a string, but " + this.source + " given");
        assert.notLengthOf(this.source, 0, "FontLoader.source cannot be an empty string");
        Object.freeze(this);
      }

      FontLoader.prototype.load = function (callback) {
        var _, i, italic, italicStr, j, len, name, name1, obj, path, ref, ref1, ref2, rsc, source, sources, weight, weightInt;

        source = ((ref = Impl.resources) != null ? ref.resolve(this.source) : void 0) || this.source;

        if (rsc = (ref1 = Impl.resources) != null ? ref1.getResource(source) : void 0) {
          sources = [];
          ref2 = rsc.paths;

          for (_ in ref2) {
            path = ref2[_];
            sources.push(path[1]);
          }
        } else {
          sources = [source];
        }

        weight = 0.4;
        italic = false;

        for (i = j = 0, len = sources.length; j < len; i = ++j) {
          source = sources[i];

          if (weight !== (weight = getFontWeight(source)) && i > 0) {
            log.warn("'" + this.source + "' sources have different weights");
          }

          if (italic !== (italic = isItalic(source)) && i > 0) {
            log.warn("'" + this.source + "' sources have different 'italic' styles");
          }
        }

        weightInt = Math.round(weight * WEIGHTS.length);
        italicStr = italic ? 'italic' : 'normal';
        name = "neft-" + this.name + "-" + weightInt + "-" + italicStr;
        obj = fontsByName[name1 = this.name] != null ? fontsByName[name1] : fontsByName[name1] = {};
        obj = obj[italic] != null ? obj[italic] : obj[italic] = new Array(WEIGHTS.length);
        obj[weightInt] = name;
        Impl.loadFont(name, source, sources, callback);
      };

      return FontLoader;
    }();
  };
}).call(this);
},{"../../../assert":"lQvG","../../../util":"xr+4","../../../log":"fe8o","../../../signal":"WtLN"}],"e2eB":[function(require,module,exports) {
var _require = require('../signal'),
    SignalDispatcher = _require.SignalDispatcher;

var assert = require('../assert');

exports.onReady = new SignalDispatcher();
exports.onWindowItemChange = new SignalDispatcher();

var Impl = require('./impl')(exports);

exports.Impl = {
  addTypeImplementation: Impl.addTypeImplementation,
  Types: Impl.Types,
  onWindowItemReady: Impl.onWindowItemReady,
  utils: Impl.utils
};

var itemUtils = require('./utils/item')(exports, Impl);

exports.itemUtils = itemUtils;
exports.sizeUtils = require('./utils/size')(exports);
exports.colorUtils = require('./utils/color');
exports.Screen = require('./types/namespace/screen')(exports, Impl, itemUtils);
exports.Device = require('./types/namespace/device')(exports, Impl, itemUtils);
exports.Navigator = require('./types/namespace/navigator')(exports, Impl, itemUtils);
exports.Extension = require('./types/extension')(exports, Impl, itemUtils);
exports.Class = require('./types/extensions/class')(exports, Impl, itemUtils);
exports.Animation = require('./types/extensions/animation')(exports, Impl, itemUtils);
exports.PropertyAnimation = require('./types/extensions/animation/types/property')(exports, Impl, itemUtils);
exports.NumberAnimation = require('./types/extensions/animation/types/property/types/number')(exports, Impl, itemUtils);
exports.SequentialAnimation = require('./types/extensions/animation/types/sequential')(exports, Impl, itemUtils);
exports.ParallelAnimation = require('./types/extensions/animation/types/parallel')(exports, Impl, itemUtils);
exports.Transition = require('./types/extensions/transition')(exports, Impl, itemUtils);
exports.Item = require('./types/basics/item')(exports, Impl, itemUtils);
exports.Image = require('./types/basics/image')(exports, Impl, itemUtils);
exports.Text = require('./types/basics/text')(exports, Impl, itemUtils);
exports.Native = require('./types/basics/native')(exports, Impl, itemUtils);
exports.Rectangle = require('./types/shapes/rectangle')(exports, Impl, itemUtils);
exports.FontLoader = require('./types/loader/font')(exports, Impl, itemUtils);

exports.setWindowItem = function (val) {
  assert.instanceOf(val, exports.Item);
  Impl.setWindow(val);
  exports.onWindowItemChange.emit(null);
};

exports.setServerUrl = function (val) {
  Impl.serverUrl = val;
};

exports.setResources = function (val) {
  Impl.resources = val;
};

exports.getResource = function (path) {
  return Impl.resources != null ? Impl.resources.getResource(path) : null;
};

exports.loadFont = function (_ref) {
  var name = _ref.name,
      source = _ref.source;
  return new Promise(function (resolve, reject) {
    var loader = new exports.FontLoader(name, source);
    loader.load(function (err) {
      if (err) reject(err);else resolve();
    });
  });
};

exports.onReady.emit();
},{"../signal":"WtLN","../assert":"lQvG","./impl":"2vQI","./utils/item":"jRFR","./utils/size":"aX08","./utils/color":"jPDc","./types/namespace/screen":"bLcb","./types/namespace/device":"OiVh","./types/namespace/navigator":"iSrG","./types/extension":"rImO","./types/extensions/class":"+F8w","./types/extensions/animation":"Utkc","./types/extensions/animation/types/property":"2FpY","./types/extensions/animation/types/property/types/number":"xqCq","./types/extensions/animation/types/sequential":"6ZTd","./types/extensions/animation/types/parallel":"Jgr6","./types/extensions/transition":"Ro6R","./types/basics/item":"6G0o","./types/basics/image":"59g0","./types/basics/text":"ppxw","./types/basics/native":"1OZd","./types/shapes/rectangle":"rJQq","./types/loader/font":"tAoW"}],"E1EV":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var log = require('../log');

var assert = require('../assert');

var eventLoop = require('../event-loop');

var Use =
/*#__PURE__*/
function () {
  function Use(document, element) {
    _classCallCheck(this, Use);

    this.document = document;
    this.element = document.element.getChildByAccessPath(element);
    this.name = '';
    this.refName = '';
    this.component = null;
    this.hiddenDepth = 0;
    this.immediateRenderPending = false;
    this.onElementPropsChange = this.element.onPropsChange.asSignalDispatcher();
    this.element.onPropsChange.connect(this.handleElementPropsChange, this);
    var anyElement = this.element;

    while (anyElement) {
      if ('n-if' in anyElement.props) {
        anyElement.onVisibleChange.connect(this.handleElementVisibleChange, this);
      }

      anyElement = anyElement.parent;
    }
  }

  _createClass(Use, [{
    key: "handleElementVisibleChange",
    value: function handleElementVisibleChange(oldValue) {
      var value = !oldValue;
      var hiddenInc = value ? -1 : 1;
      this.hiddenDepth += hiddenInc;

      if (this.document.rendered && !this.component && this.hiddenDepth === 0) {
        this.renderImmediate();
      } else if (this.document.rendered && this.component && this.hiddenDepth > 0) {
        this.revert();
      }
    }
  }, {
    key: "handleElementPropsChange",
    value: function handleElementPropsChange(propName) {
      if (propName !== 'n-component') return;
      if (!this.document.rendered) return;
      this.revert();
      this.renderImmediate();
    }
  }, {
    key: "renderImmediate",
    value: function renderImmediate() {
      var _this = this;

      if (this.immediateRenderPending) return;
      this.immediateRenderPending = true;
      eventLoop.setImmediate(function () {
        _this.immediateRenderPending = false;
        if (_this.document.rendered && !_this.component) _this.render();
      });
    }
  }, {
    key: "render",
    value: function render() {
      assert.notOk(this.component, '<n-use /> is already rendered');
      if (this.hiddenDepth > 0) return;
      var name = this.element.props['n-component'];
      if (!name) return;
      var component = this.document.getComponent(name);

      if (!component) {
        log.warning("Cannot find ".concat(name, " component to render"));
        return;
      }

      component.render({
        context: this.document.context,
        props: this.element.props,
        onPropsChange: this.onElementPropsChange,
        sourceElement: this.element
      });
      component.element.parent = this.element;
      this.name = name;
      this.refName = this.element.props['n-ref'] || this.element.props.ref;
      this.component = component;

      if (this.refName) {
        this.document.setRef(this.refName, component.exported);
      }
    }
  }, {
    key: "revert",
    value: function revert() {
      if (!this.component) return;
      this.component.revert();
      this.component.element.parent = null;
      this.document.returnComponent(this.name, this.component);

      if (this.refName) {
        this.document.deleteRef(this.refName);
      }

      this.name = '';
      this.refName = '';
      this.component = null;
    }
  }]);

  return Use;
}();

module.exports = Use;
},{"../log":"fe8o","../assert":"lQvG","../event-loop":"jt0G"}],"4b8H":[function(require,module,exports) {
function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

/* eslint-disable no-console */
var utils = require('../util');

var eventLoop = require('../event-loop');

var _require = require('./element'),
    Text = _require.Text;

var listenOnTextChange = function listenOnTextChange(element, log) {
  if (element instanceof Text) {
    element.onTextChange.connect(log.renderOnChange, log);
  } else {
    element.children.forEach(function (child) {
      return listenOnTextChange(child, log);
    });
  }
};

var Log =
/*#__PURE__*/
function () {
  function Log(document, element) {
    _classCallCheck(this, Log);

    this.document = document;
    this.element = document.element.getChildByAccessPath(element);
    this.isRenderPending = false;
    this.log = utils.bindFunctionContext(this.log, this);
    this.element.onPropsChange.connect(this.renderOnChange, this);
    listenOnTextChange(this.element, this);
  }

  _createClass(Log, [{
    key: "renderOnChange",
    value: function renderOnChange() {
      if (this.document.rendered) {
        this.render();
      }
    }
  }, {
    key: "render",
    value: function render() {
      if (!this.isRenderPending) {
        this.isRenderPending = true;
        eventLoop.setImmediate(this.log);
      }
    }
  }, {
    key: "log",
    value: function log() {
      this.isRenderPending = false;

      if (utils.isEmpty(this.element.props)) {
        console.log(this.element.stringifyChildren());
      } else {
        var _console;

        var props = this.element.props;
        var log = [];
        var content = this.element.stringifyChildren();

        if (content) {
          log.push(content);
        }

        Object.entries(props).forEach(function (_ref) {
          var _ref2 = _slicedToArray(_ref, 2),
              key = _ref2[0],
              value = _ref2[1];

          log.push(key, '=', value);
        });

        (_console = console).log.apply(_console, log);
      }
    }
  }]);

  return Log;
}();

module.exports = Log;
},{"../util":"xr+4","../event-loop":"jt0G","./element":"7MrE"}],"M3fp":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Condition =
/*#__PURE__*/
function () {
  function Condition(document, _ref) {
    var element = _ref.element,
        elseElement = _ref.elseElement;

    _classCallCheck(this, Condition);

    this.document = document;
    this.element = document.element.getChildByAccessPath(element);
    this.elseElement = elseElement && document.element.getChildByAccessPath(elseElement);
    this.element.onPropsChange.connect(this.onPropsChange, this);
  }

  _createClass(Condition, [{
    key: "onPropsChange",
    value: function onPropsChange(name) {
      if (name === 'n-if') {
        this.update();
      }
    }
  }, {
    key: "update",
    value: function update() {
      var element = this.element,
          elseElement = this.elseElement;
      var visible = !!element.props['n-if'];
      element.visible = visible;

      if (elseElement) {
        elseElement.visible = !visible;
      }
    }
  }, {
    key: "render",
    value: function render() {
      this.update();
    }
  }, {
    key: "revert",
    value: function revert() {// NOP
    }
  }]);

  return Condition;
}();

module.exports = Condition;
},{}],"8zsn":[function(require,module,exports) {
(function () {
  'use strict';

  var Binding,
      DocumentBinding,
      Input,
      SignalsEmitter,
      assert,
      eventLoop,
      log,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  utils = require('../util');
  assert = require('../assert');
  log = require('../log');
  SignalsEmitter = require('../signal').SignalsEmitter;
  eventLoop = require('../event-loop');
  Binding = require('../binding');
  assert = assert.scope('View.Input');
  log = log.scope('View', 'Input');

  DocumentBinding = function (superClass) {
    extend(DocumentBinding, superClass);

    DocumentBinding.New = function (binding, input, target) {
      if (target == null) {
        target = new DocumentBinding(binding, input);
      }

      return Binding.New(binding, input.target, target);
    };

    function DocumentBinding(binding, input1) {
      this.input = input1;

      DocumentBinding.__super__.constructor.call(this, binding, this.input.target);
    }

    DocumentBinding.prototype.getItemById = function (item) {
      if (item === 'this') {
        return this.ctx;
      }
    }; //<development>;


    DocumentBinding.prototype.onError = function (err) {
      log.error("Failed `" + this.input.text + "` binding in file `" + this.input.document.path + "`: `" + err + "`");
    }; //</development>;


    DocumentBinding.prototype.update = function () {
      if (!this.input.isRendered) {
        return;
      }

      eventLoop.lock();

      DocumentBinding.__super__.update.call(this);

      eventLoop.release();
    };

    DocumentBinding.prototype.getValue = function () {
      return this.input.getValue();
    };

    DocumentBinding.prototype.setValue = function (val) {
      return this.input.setValue(val);
    };

    return DocumentBinding;
  }(Binding);

  module.exports = Input = function (superClass) {
    var initBindingConfig;
    extend(Input, superClass);

    initBindingConfig = function initBindingConfig(cfg) {
      if (cfg.func == null) {
        cfg.func = new Function('self', cfg.body);
      }

      if (cfg.tree == null) {
        cfg.tree = [cfg.func, cfg.connections];
      }
    };

    function Input(document, element, interpolation, text) {
      this.document = document;
      this.interpolation = interpolation;
      this.text = text;

      Input.__super__.constructor.call(this);

      this.element = this.document.element.getChildByAccessPath(element);
      this.isRendered = false;
      this.target = null;
      this.binding = null;
      initBindingConfig(this.interpolation);
    }

    Input.prototype.render = function () {
      assert.isNotDefined(this.binding);
      this.target = this.document.exported;
      this.binding = DocumentBinding.New(this.interpolation.tree, this);
      this.isRendered = true;
      this.binding.update();
    };

    Input.prototype.revert = function () {
      this.binding.destroy();
      this.binding = null;
      this.isRendered = false;
    };

    return Input;
  }(SignalsEmitter);
}).call(this);
},{"../util":"xr+4","../assert":"lQvG","../log":"fe8o","../signal":"WtLN","../event-loop":"jt0G","../binding":"fqjs"}],"glk2":[function(require,module,exports) {
(function () {
  'use strict';

  var Input,
      InputText,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  Input = require('../input');

  module.exports = InputText = function (superClass) {
    extend(InputText, superClass);

    function InputText(document, arg) {
      var element, interpolation, text;
      element = arg.element, interpolation = arg.interpolation, text = arg.text;

      InputText.__super__.constructor.call(this, document, element, interpolation, text);
    }

    InputText.prototype.getValue = function () {
      return this.element.text;
    };

    InputText.prototype.setValue = function (val) {
      if (val == null) {
        val = '';
      } else if (typeof val !== 'string') {
        val += '';
      }

      return this.element.text = val;
    };

    return InputText;
  }(Input);
}).call(this);
},{"../input":"8zsn"}],"4AzR":[function(require,module,exports) {
(function () {
  'use strict';

  var Input,
      InputProp,
      assert,
      utils,
      extend = function extend(child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key)) child[key] = parent[key];
    }

    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  },
      hasProp = {}.hasOwnProperty;

  assert = require('../../assert');
  utils = require('../../util');
  Input = require('../input');

  module.exports = InputProp = function (superClass) {
    var createHandlerFunc, isHandler;
    extend(InputProp, superClass);

    InputProp.isHandler = isHandler = function isHandler(node, prop) {
      if (/(?:^|:)on[A-Z][A-Za-z0-9_$]*$/.test(prop)) {
        return true;
      } else {
        return false;
      }
    };

    function InputProp(document, arg) {
      var element, interpolation, text;
      element = arg.element, this.prop = arg.prop, interpolation = arg.interpolation, text = arg.text;

      InputProp.__super__.constructor.call(this, document, element, interpolation, text);

      if (isHandler(this.element, this.prop)) {
        this.handlerFunc = createHandlerFunc(this);
        this.element.props.set(this.prop, this.handlerFunc);
      } else {
        this.handlerFunc = null;
      }
    }

    InputProp.prototype.getValue = function () {
      return this.element.props[this.prop];
    };

    InputProp.prototype.setValue = function (val) {
      return this.element.props.set(this.prop, val);
    };

    InputProp.prototype.render = function () {
      if (!this.handlerFunc) {
        return InputProp.__super__.render.call(this);
      }
    };

    InputProp.prototype.revert = function () {
      if (!this.handlerFunc) {
        return InputProp.__super__.revert.call(this);
      }
    };

    createHandlerFunc = function createHandlerFunc(input) {
      return function () {
        var r;

        if (!input.document.rendered) {
          return;
        }

        r = input.interpolation.func.call(input.document.exported, this);

        if (typeof r === 'function') {
          r = r.apply(this, arguments);
        }

        return r;
      };
    };

    return InputProp;
  }(Input);
}).call(this);
},{"../../assert":"lQvG","../../util":"xr+4","../input":"8zsn"}],"4Y+I":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var util = require('../util');

var assert = require('../assert');

var eventLoop = require('../event-loop');

var _require = require('../signal'),
    SignalsEmitter = _require.SignalsEmitter;

var privatePropOpts = util.CONFIGURABLE | util.WRITABLE;
var propOpts = util.CONFIGURABLE | util.ENUMERABLE;

var createProperty = function createProperty(struct, key, value) {
  var privateKey = "_".concat(key);
  var signalName = "on".concat(util.capitalize(key), "Change");
  util.defineProperty(struct, privateKey, privatePropOpts, value);
  SignalsEmitter.createSignal(struct, signalName);

  var getter = function getter() {
    return this[privateKey];
  };

  var setter = function setter(newValue) {
    var oldVal = this[privateKey];
    if (newValue === oldVal) return;
    this[privateKey] = newValue;
    this.emit(signalName, oldVal);
  };

  util.defineProperty(struct, key, propOpts, getter, eventLoop.bindInLock(setter));
};

var Struct =
/*#__PURE__*/
function (_SignalsEmitter) {
  _inherits(Struct, _SignalsEmitter);

  function Struct(obj) {
    var _this;

    _classCallCheck(this, Struct);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(Struct).call(this));
    assert.instanceOf(_assertThisInitialized(_this), Struct, "Constructor Struct requires 'new'");

    if (util.isPlainObject(obj)) {
      Object.keys(obj).forEach(function (key) {
        createProperty(_assertThisInitialized(_this), key, obj[key]);
      });
    }

    if (_this.constructor === Struct) {
      Object.seal(_assertThisInitialized(_this));
    }

    return _this;
  }

  return Struct;
}(SignalsEmitter);

module.exports = Struct;
},{"../util":"xr+4","../assert":"lQvG","../event-loop":"jt0G","../signal":"WtLN"}],"y4Kp":[function(require,module,exports) {
function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var util = require('../util');

var Struct = require('../struct');

var _require = require('../signal'),
    SignalsEmitter = _require.SignalsEmitter;

var PROP_OPTS = 0;

var ScriptExported =
/*#__PURE__*/
function (_Struct) {
  _inherits(ScriptExported, _Struct);

  function ScriptExported(document, obj) {
    var _this;

    _classCallCheck(this, ScriptExported);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(ScriptExported).call(this, obj));
    util.defineProperty(_assertThisInitialized(_this), '$element', PROP_OPTS, document.element);
    util.defineProperty(_assertThisInitialized(_this), '$refs', PROP_OPTS, document.refs);
    util.defineProperty(_assertThisInitialized(_this), '$context', PROP_OPTS, function () {
      return document.context;
    }, null);
    return _this;
  }

  return ScriptExported;
}(Struct);

util.defineProperty(ScriptExported.prototype, 'constructor', PROP_OPTS, ScriptExported);
SignalsEmitter.createSignal(ScriptExported, 'on$RefsChange');

var Script =
/*#__PURE__*/
function () {
  function Script(document, script) {
    _classCallCheck(this, Script);

    var ComponentScript =
    /*#__PURE__*/
    function (_ScriptExported) {
      _inherits(ComponentScript, _ScriptExported);

      function ComponentScript() {
        _classCallCheck(this, ComponentScript);

        return _possibleConstructorReturn(this, _getPrototypeOf(ComponentScript).apply(this, arguments));
      }

      return ComponentScript;
    }(ScriptExported);

    this.document = document;
    this.produceInstanceFields = null;
    this.ExportedConstructor = ComponentScript;

    if (typeof script === 'function') {
      this.produceInstanceFields = script;
    } else if (util.isObject(script)) {
      Object.keys(script).forEach(function (key) {
        if (key !== 'default') ComponentScript.prototype[key] = script[key];
      });

      if (typeof script.default === 'function') {
        this.produceInstanceFields = script.default;
      } else {
        this.produceInstanceFields = function () {
          return script.default;
        };
      }
    } else {
      this.produceInstanceFields = function () {
        return null;
      };
    }
  }

  _createClass(Script, [{
    key: "produceExported",
    value: function produceExported() {
      // produce object with combined static methods and instance fields
      var object = this.produceInstanceFields() || {}; // add props

      Object.keys(this.document.props).forEach(function (prop) {
        if (!(prop in object)) {
          object[prop] = null;
        }
      }); // create struct

      var exported = new this.ExportedConstructor(this.document, object); // bind instance methods

      Object.keys(object).forEach(function (field) {
        if (typeof object[field] === 'function') {
          exported[field] = exported[field].bind(exported);
        }
      });
      return exported;
    }
  }, {
    key: "afterRender",
    value: function afterRender() {
      if (typeof this.document.exported.onRender === 'function') {
        this.document.exported.onRender();
      }
    }
  }, {
    key: "beforeRevert",
    value: function beforeRevert() {
      if (typeof this.document.exported.onRevert === 'function') {
        this.document.exported.onRevert();
      }
    }
  }]);

  return Script;
}();

module.exports = Script;
},{"../util":"xr+4","../struct":"4Y+I","../signal":"WtLN"}],"F/rD":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Slot =
/*#__PURE__*/
function () {
  function Slot(document, element) {
    _classCallCheck(this, Slot);

    this.document = document;
    this.element = document.element.getChildByAccessPath(element);
    this.sourceElement = null;
  }

  _createClass(Slot, [{
    key: "render",
    value: function render(sourceElement) {
      var _this = this;

      if (!sourceElement) return;
      this.sourceElement = sourceElement;
      sourceElement.children.forEach(function (child) {
        child.parent = _this.element;
      });
    }
  }, {
    key: "revert",
    value: function revert() {
      var _this2 = this;

      if (!this.sourceElement) return;
      this.element.children.forEach(function (child) {
        child.parent = _this2.sourceElement;
      });
      this.sourceElement = null;
    }
  }]);

  return Slot;
}();

module.exports = Slot;
},{}],"emeY":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var util = require('../util');

var assert = require('../assert');

var eventLoop = require('../event-loop');

var ObservableArray = require('../observable-array');

var Iterator =
/*#__PURE__*/
function () {
  function Iterator(document, _ref) {
    var element = _ref.element,
        component = _ref.component,
        naming = _ref.naming;

    _classCallCheck(this, Iterator);

    this.document = document;
    this.element = document.element.getChildByAccessPath(element);
    this.component = component;
    this.naming = naming;
    this.data = null;
    this.pool = [];
    this.usedComponents = [];
    this.refs = {};
    this.hiddenDepth = 0;
    this.immediateRenderPending = false;
    this.componentListeners = {
      refSet: this.setRef.bind(this),
      refDelete: this.deleteRef.bind(this)
    };
    this.element.onPropsChange.connect(this.handleElementPropsChange, this);
    var anyElement = this.element;

    while (anyElement) {
      if ('n-if' in anyElement.props) {
        anyElement.onVisibleChange.connect(this.handleElementVisibleChange, this);
      }

      anyElement = anyElement.parent;
    }
  }

  _createClass(Iterator, [{
    key: "handleElementVisibleChange",
    value: function handleElementVisibleChange(oldValue) {
      var value = !oldValue;
      var hiddenInc = value ? -1 : 1;
      this.hiddenDepth += hiddenInc;

      if (this.document.rendered && this.data === null && this.hiddenDepth === 0) {
        this.renderImmediate();
      } else if (this.document.rendered && this.data !== null && this.hiddenDepth > 0) {
        this.revert();
      }
    }
  }, {
    key: "handleElementPropsChange",
    value: function handleElementPropsChange(propName) {
      if (propName !== 'n-for') return;
      if (!this.document.rendered) return;
      this.revert();
      this.renderImmediate();
    }
  }, {
    key: "setRef",
    value: function setRef(name, value) {
      var array = this.document.refs[name];

      if (!array) {
        array = new ObservableArray();
        this.document.setRef(name, array);
      }

      array.push(value);
    }
  }, {
    key: "deleteRef",
    value: function deleteRef(name, value) {
      var array = this.document.refs[name];

      if (Array.isArray(array)) {
        util.remove(array, value);
      }
    }
  }, {
    key: "forEachComponentBaseRef",
    value: function forEachComponentBaseRef(component, func) {
      var _this = this;

      var refs = Object.getPrototypeOf(component.refs);
      Object.keys(refs).forEach(function (ref) {
        _this[func](ref, refs[ref]);
      });
    }
  }, {
    key: "renderImmediate",
    value: function renderImmediate() {
      var _this2 = this;

      if (this.immediateRenderPending) return;
      this.immediateRenderPending = true;
      eventLoop.setImmediate(function () {
        _this2.immediateRenderPending = false;
        if (_this2.document.rendered && !_this2.data) _this2.render();
      });
    }
  }, {
    key: "render",
    value: function render() {
      if (this.hiddenDepth > 0) return;
      var data = this.element.props['n-for']; // stop if nothing changed

      if (data === this.data) return; // stop if no data found

      if (!Array.isArray(data)) return; // set as data

      this.data = data; // listen on changes

      if (data instanceof ObservableArray) {
        data.onPush.connect(this.insertItem, this);
        data.onPop.connect(this.popItem, this);
      } // add items


      data.forEach(this.insertItem, this);
    }
  }, {
    key: "revert",
    value: function revert() {
      var data = this.data;

      if (data) {
        this.popAllItems();

        if (data instanceof ObservableArray) {
          data.onPush.disconnect(this.insertItem, this);
          data.onPop.disconnect(this.popItem, this);
        }
      }

      this.data = null;
    }
  }, {
    key: "updateItem",
    value: function updateItem(elem) {
      var index = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : elem;
      assert.isObject(this.data);
      assert.isInteger(index);
      this.popItem(index);
      this.insertItem(index);
    }
  }, {
    key: "getComponent",
    value: function getComponent() {
      if (this.pool.length) return this.pool.pop();
      var component = this.component({
        parent: this.document,
        root: false
      });
      return component;
    }
  }, {
    key: "insertItem",
    value: function insertItem(elem) {
      var index = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : elem;
      assert.isObject(this.data);
      assert.isInteger(index);
      var data = this.data,
          naming = this.naming;
      var usedComponent = this.getComponent();
      var exported = Object.create(this.document.exported);
      this.usedComponents.splice(index, 0, usedComponent);
      if (naming.item) exported[naming.item] = data[index];
      if (naming.index) exported[naming.index] = index;
      if (naming.array) exported[naming.array] = data;
      var newChild = usedComponent.element;
      newChild.parent = this.element;
      newChild.index = index;
      this.forEachComponentBaseRef(usedComponent, 'setRef');
      usedComponent.render({
        exported: exported,
        context: this.document.context,
        listeners: this.componentListeners
      });
    }
  }, {
    key: "popItem",
    value: function popItem(elem) {
      var index = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : elem;
      assert.isObject(this.data);
      assert.isInteger(index);
      var usedComponent = this.usedComponents[index];
      this.forEachComponentBaseRef(usedComponent, 'deleteRef');
      if (usedComponent.rendered) usedComponent.revert();
      usedComponent.element.parent = null;
      this.pool.push(usedComponent);
      this.usedComponents.splice(index, 1);
    }
  }, {
    key: "popAllItems",
    value: function popAllItems() {
      assert.isObject(this.data);

      while (this.usedComponents.length) {
        this.popItem(this.usedComponents.length - 1);
      }
    }
  }]);

  return Iterator;
}();

module.exports = Iterator;
},{"../util":"xr+4","../assert":"lQvG","../event-loop":"jt0G","../observable-array":"JLX2"}],"oZSz":[function(require,module,exports) {
(function () {
  'use strict';

  var DEFAULT_PROP_ALIASES, InputProp, PROPS_CLASS_PRIORITY, PROP_PREFIX, Renderer, STYLE_ID_PROP, Signal, StyleItem, Tag, Text, assert, eventLoop, log, ref, utils;
  assert = require('../assert');
  utils = require('../util');
  Signal = require('../signal/signal').Signal;
  log = require('../log');
  eventLoop = require('../event-loop');
  Renderer = require('../renderer');
  InputProp = require('./input/prop');
  ref = require('./element'), Tag = ref.Tag, Text = ref.Text;
  log = log.scope('Styles');
  PROPS_CLASS_PRIORITY = 9999;
  PROP_PREFIX = 'style:';
  STYLE_ID_PROP = 'n-style';
  DEFAULT_PROP_ALIASES = {
    onClick: 'pointer:onClick',
    onPress: 'pointer:onPress',
    onRelease: 'pointer:onRelease',
    onMove: 'pointer:onMove'
  };

  module.exports = StyleItem = function () {
    var findItemWithParent, isHandler;
    isHandler = InputProp.isHandler;

    function StyleItem(document, arg, parent1) {
      var children, element, styleAttr;
      this.document = document;
      element = arg.element, children = arg.children;
      this.parent = parent1 != null ? parent1 : null;
      this.element = this.document.element.getChildByAccessPath(element);
      this.children = children != null ? children.map(function (_this) {
        return function (child) {
          return new StyleItem(_this.document, child, _this);
        };
      }(this)) : void 0;
      this.item = null;
      this.propsClass = null;
      this.scope = null;
      this.hasText = false;

      if (this.element instanceof Tag) {
        styleAttr = this.element.props[STYLE_ID_PROP];
        this.isAutoParent = !/^(.+?)\:(.+?)$/.test(styleAttr);
      } else {
        this.isAutoParent = true;
      }

      this.element._documentStyle = this;

      if (!this.parent) {
        this.createItemDeeply();
      }

      Object.seal(this);
    }

    StyleItem.prototype.createClassWithPriority = function (priority) {
      var r;
      assert.ok(this.item);
      r = Renderer.Class.New();
      r.target = this.item;

      if (priority != null) {
        r.priority = priority;
      }

      return r;
    };

    StyleItem.prototype.updateText = function () {
      if (this.element instanceof Tag) {
        this.item.text = this.element.stringifyChildren();
      } else if (this.element instanceof Text) {
        this.item.text = this.element.text;
      }
    };

    StyleItem.prototype.setPropsClassAttribute = function (attr, val) {
      var propsClass;
      assert.instanceOf(this, StyleItem);

      if (!this.propsClass) {
        this.propsClass = this.createClassWithPriority(PROPS_CLASS_PRIORITY);
      }

      propsClass = this.propsClass;

      if (propsClass.changes._attributes[attr] === val) {
        return;
      }

      propsClass.running = false;
      propsClass.changes.setAttribute(attr, val);
      propsClass.running = true;
    };

    StyleItem.prototype.setProp = function () {
      var getInternalProperty, getPropWithoutPrefix, getPropertyPath, getSplitProp, isStyleProp;

      isStyleProp = function isStyleProp(prop) {
        return prop.startsWith(PROP_PREFIX);
      };

      getPropWithoutPrefix = function getPropWithoutPrefix(prop) {
        return prop.slice(PROP_PREFIX.length);
      };

      getSplitProp = function () {
        var cache;
        cache = Object.create(null);
        return function (prop) {
          return cache[prop] || (cache[prop] = prop.split(':'));
        };
      }();

      getPropertyPath = function () {
        var cache;
        cache = Object.create(null);
        return function (prop) {
          return cache[prop] || (cache[prop] = prop.replace(/:/g, '.'));
        };
      }();

      getInternalProperty = function () {
        var cache;
        cache = Object.create(null);
        return function (prop) {
          return cache[prop] || (cache[prop] = "_" + prop);
        };
      }();

      return function (prop, val, oldVal) {
        var alias, i, internalProp, j, lastPart, obj, parts, ref1;
        assert.instanceOf(this, StyleItem);

        if (prop.startsWith('n-')) {
          return false;
        }

        if (isStyleProp(prop)) {
          prop = getPropWithoutPrefix(prop);
        } else if (this.element.constructor._styleAliasesByName) {
          parts = getSplitProp(prop);
          alias = this.element.constructor._styleAliasesByName[parts[0]];

          if (alias) {
            prop = alias.styleName;
          } else {
            return false;
          }
        } else {
          prop = DEFAULT_PROP_ALIASES[prop];

          if (!prop) {
            return false;
          }
        }

        parts = getSplitProp(prop);
        obj = this.item;

        if (!obj) {
          return;
        }

        for (i = j = 0, ref1 = parts.length - 1; j < ref1; i = j += 1) {
          if (!(obj = obj[parts[i]])) {
            return false;
          }
        }

        lastPart = utils.last(parts);

        if (!(lastPart in obj)) {
          return false;
        }

        internalProp = getInternalProperty(lastPart);

        if (obj[lastPart] instanceof Signal) {
          if (typeof oldVal === 'function') {
            obj[lastPart].disconnect(oldVal, this.element);
          }

          if (typeof val === 'function') {
            obj[lastPart].connect(val, this.element);
          }
        } else {
          this.setPropsClassAttribute(getPropertyPath(prop), val);
        }

        return true;
      };
    }();

    StyleItem.prototype.findAndSetVisibility = function () {
      var element, tmp;
      assert.isDefined(this.item);
      element = this.element;
      tmp = element;

      while (tmp) {
        if (tmp._documentStyle && tmp !== element) {
          break;
        }

        if (!tmp.visible) {
          this.setVisibility(false);
          break;
        }

        tmp = tmp.parent;
      }
    };
    /*
    Sets the item visibility.
     */


    StyleItem.prototype.setVisibility = function (val) {
      assert.isBoolean(val);

      if (this.item) {
        this.setPropsClassAttribute('visible', val);
      }
    };
    /*
    Creates and initializes renderer item based on the element 'n-style' attribute.
    The style element 'n-style' attribute may be:
        - a 'Renderer.Item' instance - item will be used as is,
        - a string in format:
            - File, Style, SubId,
            - File, Style.
    
    The newly created or found item is initialized.
     */


    StyleItem.prototype.createItem = function () {
      var element, file, id, isMainItem, key, parent, parentStyle, ref1, ref2, ref3, scope, style, subid;
      assert.isNotDefined(this.item, "Can't create a style item, because it already exists");
      assert.isNotDefined(this.element.style, 'Can\'t create a style item, because the element already has a style');
      element = this.element;
      isMainItem = true;

      if (element instanceof Tag) {
        id = element.props[STYLE_ID_PROP];
        assert.isDefined(id, "Tag must specify " + STYLE_ID_PROP + " prop to create an item for it");
      } else if (element instanceof Text) {
        id = Renderer.Text.New();
      }

      if (id instanceof Renderer.Item) {
        this.item = id;
        this.isAutoParent = !id.parent;
      } else if (Array.isArray(id)) {
        file = id[0], style = id[1], subid = id[2];

        if (subid) {
          isMainItem = false;
          parent = this.parent;

          while (true) {
            parentStyle = parent != null ? parent.element.props[STYLE_ID_PROP] : void 0;

            if (parentStyle && parentStyle[0] === file && parentStyle[1] === style) {
              scope = parent.scope;
              this.item = scope != null ? scope.objects[subid] : void 0;
            }

            if (this.item || !parent) {
              break;
            }

            parent = parent.parent;
          }

          if (!this.item) {
            log.warn("Can't find `" + id + "` style item");
            return;
          }
        } else {
          this.scope = (ref1 = this.document.style[file]) != null ? typeof ref1[style] === "function" ? ref1[style]() : void 0 : void 0;
          this.scope || (this.scope = (ref2 = this.document.parent) != null ? (ref3 = ref2.style[file]) != null ? typeof ref3[style] === "function" ? ref3[style]() : void 0 : void 0 : void 0);

          if (this.scope) {
            this.item = this.scope.item;
          } else {
            log.warn("Style file `" + id + "` can't be find");
          }
        }
      } else {
        throw new Error("Unexpected n-style; '" + id + "' given");
      }

      if (this.item) {
        this.isAutoParent = !this.item.parent;
        this.findAndSetVisibility();
        this.hasText = element instanceof Text;
        this.hasText || (this.hasText = element instanceof Tag && 'text' in this.item);

        if (this.hasText) {
          this.updateText();
        }

        if (element instanceof Tag) {
          for (key in element.props) {
            if (isHandler(this.element, key)) {
              this.setProp(key, element.props[key], null);
            }
          }
        }

        if (this.isAutoParent) {
          this.findItemParent();
        } else if (isMainItem) {
          this.findItemIndex();
        }

        element.style = this.item;
        this.item.element = element;
      }
    };
    /*
    Create an item for this style and for children recursively.
    Item may not be created if it won't be used, that is:
        - parent is a text style.
     */


    StyleItem.prototype.createItemDeeply = eventLoop.bindInLock(function () {
      var child, j, len, ref1;
      this.createItem();

      if (!this.hasText) {
        ref1 = this.children;

        for (j = 0, len = ref1.length; j < len; j++) {
          child = ref1[j];
          child.createItemDeeply();
        }
      }
    });

    StyleItem.prototype.findItemParent = function () {
      var element, item, style, tmpNode;

      if (!this.isAutoParent) {
        return false;
      }

      element = this.element;
      tmpNode = element.parent;

      while (tmpNode) {
        if (style = tmpNode._documentStyle) {
          if (item = style.item) {
            this.item.parent = item;
            break;
          }
        }

        tmpNode = tmpNode.parent;
      }

      if (!item) {
        this.item.parent = null;
        return false;
      }

      return true;
    };

    StyleItem.prototype.setItemParent = function (val) {
      if (this.isAutoParent && this.item) {
        this.item.parent = val;
        this.findItemIndex();
      }
    };

    findItemWithParent = function findItemWithParent(item, parent) {
      var tmp, tmpParent;
      tmp = item;

      while (tmp && (tmpParent = tmp._parent)) {
        if (tmpParent === parent) {
          return tmp;
        }

        tmp = tmpParent;
      }
    };

    StyleItem.prototype.findItemIndex = function () {
      var child, element, item, parent, ref1, ref2, ref3, targetChild, tmpIndexNode, tmpSiblingDocStyle, tmpSiblingItem, tmpSiblingNode, tmpSiblingTargetItem;
      ref1 = this, element = ref1.element, item = ref1.item;

      if (!(parent = item.parent)) {
        return false;
      }

      tmpIndexNode = element;
      parent = ((ref2 = parent._children) != null ? ref2._target : void 0) || parent;
      tmpSiblingNode = tmpIndexNode;

      while (tmpIndexNode) {
        while (tmpSiblingNode) {
          if (tmpSiblingNode !== element) {
            tmpSiblingDocStyle = tmpSiblingNode._documentStyle;

            if (tmpSiblingDocStyle && tmpSiblingDocStyle.isAutoParent) {
              if (tmpSiblingItem = tmpSiblingDocStyle.item) {
                if (tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)) {
                  if (item !== tmpSiblingTargetItem) {
                    item.previousSibling = tmpSiblingTargetItem;
                  }

                  return true;
                }
              }
            } else if (!tmpSiblingDocStyle) {
              tmpIndexNode = tmpSiblingNode;
              tmpSiblingNode = utils.last(tmpIndexNode.children);
              continue;
            }
          }

          tmpSiblingNode = tmpSiblingNode._previousSibling;
        }

        if (tmpIndexNode !== element && tmpIndexNode.style) {
          return true;
        }

        if (tmpSiblingNode = tmpIndexNode._previousSibling) {
          tmpIndexNode = tmpSiblingNode;
        } else if (tmpIndexNode = tmpIndexNode._parent) {
          if (((ref3 = tmpIndexNode._documentStyle) != null ? ref3.item : void 0) === parent) {
            targetChild = null;
            child = parent.children.firstChild;

            while (child) {
              if (child !== item && child.element) {
                targetChild = child;
                break;
              }

              child = child.nextSibling;
            }

            item.nextSibling = targetChild;
            return true;
          }
        }
      }

      return false;
    };

    StyleItem.prototype.render = function () {
      var j, key, len, ref1, style;

      if (this.element instanceof Tag) {
        for (key in this.element.props) {
          if (!isHandler(this.element, key)) {
            this.setProp(key, this.element.props[key], null);
          }
        }
      }

      if (this.children) {
        ref1 = this.children;

        for (j = 0, len = ref1.length; j < len; j++) {
          style = ref1[j];
          style.render();
        }
      }
    };

    StyleItem.prototype.revert = function () {};

    return StyleItem;
  }();
}).call(this);
},{"../assert":"lQvG","../util":"xr+4","../signal/signal":"XbcT","../log":"fe8o","../event-loop":"jt0G","../renderer":"e2eB","./input/prop":"4AzR","./element":"7MrE"}],"yOtl":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

var util = require('../util');

var assert = require('../assert');

var eventLoop = require('../event-loop');

var Renderer = require('../renderer');

var log = require('../log');

var Use = require('./use');

var Log = require('./log');

var Condition = require('./condition');

var TextInput = require('./input/text');

var PropInput = require('./input/prop');

var Script = require('./script');

var Slot = require('./slot');

var Iterator = require('./iterator');

var StyleItem = require('./style-item');

var parseImports = function parseImports(imports) {
  Object.keys(imports).forEach(function (name) {
    var file = imports[name];

    if (_typeof(file) === 'object' && file != null) {
      imports[name] = file.default;
    }
  });
  return imports;
};

var parseRefs = function parseRefs(refs, element) {
  return Object.create(Object.keys(refs).reduce(function (result, key) {
    result[key] = element.getChildByAccessPath(refs[key]);
    return result;
  }, {}));
};

var mapToTypes = function mapToTypes(Type, list, document) {
  if (list) return list.map(function (opts) {
    return new Type(document, opts);
  });
  return [];
};

var createInitLocalPool = function createInitLocalPool(components) {
  var pool = {};
  Object.keys(components).forEach(function (key) {
    pool[key] = [];
  });
  return pool;
};

var isInternalProp = function isInternalProp(prop) {
  return prop[0] === 'n' && prop[1] === '-' || prop === 'ref';
};

var attachStyles = function attachStyles(styles, element) {
  Object.values(styles).forEach(function (style) {
    var selects = style.selects;
    if (!selects) return;
    selects.forEach(function (selectGen) {
      var _selectGen = selectGen(),
          select = _selectGen.select;

      select.target = new Renderer.Class.ElementTarget(element);
      select.running = true;
    });
  });
};

var documents = Object.create(null);
var globalPool = Object.create(null);
var localPool = Symbol('localPool');
var renderProps = Symbol('renderProps');
var renderOnPropsChange = Symbol('renderOnPropsChange');
var renderSourceElement = Symbol('renderSourceElement');
var renderListeners = Symbol('renderListeners');
var callRenderListener = Symbol('callRenderListener');
var instances;
var saveInstance;

if ("development" === 'development') {
  instances = {};

  saveInstance = function saveInstance(document) {
    var path = document.path;
    instances[path] = instances[path] || [];
    instances[path].push(document);
  };
}

var Document =
/*#__PURE__*/
function () {
  function Document(path, config, options) {
    _classCallCheck(this, Document);

    assert.isString(path);
    assert.notLengthOf(path, 0);
    this.path = path;
    this.parent = options && options.parent || null;
    this.element = config.element;
    this.imports = config.imports ? parseImports(config.imports) : {};
    this.components = config.components || {};
    this.refs = config.refs ? parseRefs(config.refs, this.element) : {};
    this.props = config.props || {};
    this.script = new Script(this, config.script);
    this.exported = null;
    this.root = options && options.root != null ? options.root : true;
    this.inputs = mapToTypes(TextInput, config.textInputs, this).concat(mapToTypes(PropInput, config.propInputs, this));
    this.conditions = mapToTypes(Condition, config.conditions, this);
    this.iterators = mapToTypes(Iterator, config.iterators, this);
    this.logs = mapToTypes(Log, config.logs, this);
    this.style = config.style || {};
    this.styleItems = mapToTypes(StyleItem, config.styleItems, this);
    this.slot = config.slot ? new Slot(this, config.slot) : null;
    this.uses = mapToTypes(Use, config.uses, this);
    this.context = null;
    this.rendered = false;
    this[localPool] = createInitLocalPool(this.components);
    this[renderProps] = null;
    this[renderOnPropsChange] = null;
    this[renderSourceElement] = null;
    this[renderListeners] = null;
    this.uid = util.uid();
    Object.seal(this);

    if ("development" === 'development') {
      saveInstance(this);
    }

    attachStyles(this.style, this.element);
  }

  _createClass(Document, [{
    key: callRenderListener,
    value: function value(name, arg1, arg2) {
      var listeners = this[renderListeners];

      if (listeners && typeof listeners[name] === 'function') {
        listeners[name](arg1, arg2);
      }
    }
  }, {
    key: "getComponent",
    value: function getComponent(name) {
      var imported = this.imports[name];

      if (imported) {
        var pool = globalPool[imported];

        if (pool) {
          if (pool.length > 0) return pool.pop();
          return documents[imported].constructor();
        }
      }

      var local = this.components[name];

      if (local) {
        var _pool = this[localPool][name];

        if (_pool) {
          if (_pool.length > 0) return _pool.pop();
          return local({
            parent: this
          });
        }
      }

      return this.parent ? this.parent.getComponent(name) : null;
    }
  }, {
    key: "returnComponent",
    value: function returnComponent(name, component) {
      assert.notOk(component.rendered, 'Cannot return rendered component');
      var imported = this.imports[name];

      if (imported) {
        globalPool[imported].push(component);
        return;
      }

      var local = this.components[name];

      if (local) {
        this[localPool][name].push(component);
        return;
      }

      if (this.parent) {
        this.parent.returnComponent(name, component);
      } else {
        throw new Error('Unknown component given to return');
      }
    }
  }, {
    key: "reloadProp",
    value: function reloadProp(name) {
      if (isInternalProp(name)) return;

      if (!this.props[name]) {
        log.warn("Trying to set unknown `".concat(name, "` prop on component `").concat(this.path, "`"));
        return;
      }

      this.exported[name] = this[renderProps][name];
    }
  }, {
    key: "setRef",
    value: function setRef(ref, value) {
      if (!value) return;
      var oldValue = this.refs[ref];
      if (oldValue) this[callRenderListener]('refDelete', ref, oldValue);
      this.refs[ref] = value;
      this[callRenderListener]('refSet', ref, value);
      this.exported.emit('on$RefsChange');
    }
  }, {
    key: "deleteRef",
    value: function deleteRef(ref) {
      var oldValue = this.refs[ref];
      delete this.refs[ref];
      this[callRenderListener]('refDelete', ref, oldValue);
      this.exported.emit('on$RefsChange');
    }
  }, {
    key: "render",
    value: function render() {
      var _ref = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
          _ref$context = _ref.context,
          context = _ref$context === void 0 ? null : _ref$context,
          _ref$props = _ref.props,
          props = _ref$props === void 0 ? null : _ref$props,
          onPropsChange = _ref.onPropsChange,
          _ref$sourceElement = _ref.sourceElement,
          sourceElement = _ref$sourceElement === void 0 ? null : _ref$sourceElement,
          _ref$listeners = _ref.listeners,
          listeners = _ref$listeners === void 0 ? null : _ref$listeners,
          _ref$exported = _ref.exported,
          exported = _ref$exported === void 0 ? null : _ref$exported;

      assert.notOk(this.rendered, 'Document is already rendered');
      this.exported = exported === null ? this.script.produceExported() : exported;
      this.context = context;

      if (_typeof(props) === 'object' && props !== null) {
        this[renderProps] = props;
        Object.keys(props).forEach(this.reloadProp, this);
      }

      if (onPropsChange && typeof onPropsChange.connect === 'function') {
        this[renderOnPropsChange] = onPropsChange;
        onPropsChange.connect(this.reloadProp, this);
      }

      this[renderSourceElement] = sourceElement;
      this[renderListeners] = listeners;
      this.inputs.forEach(function (input) {
        return input.render();
      });
      this.conditions.forEach(function (condition) {
        return condition.render();
      });
      this.uses.forEach(function (use) {
        return use.render();
      });
      this.iterators.forEach(function (iterator) {
        return iterator.render();
      });
      if (this.slot) this.slot.render(sourceElement);
      this.styleItems.forEach(function (styleItem) {
        return styleItem.render();
      });
      this.logs.forEach(function (docLog) {
        return docLog.render();
      });
      this.rendered = true;
      if (this.root) this.script.afterRender();
    }
  }, {
    key: "revert",
    value: function revert() {
      assert.ok(this.rendered, 'Document is not rendered');
      if (this.root) this.script.beforeRevert();
      this[renderProps] = null;

      if (this[renderOnPropsChange]) {
        this[renderOnPropsChange].disconnect(this.reloadProp, this);
        this[renderOnPropsChange] = null;
      }

      this[renderSourceElement] = null;
      this.inputs.forEach(function (input) {
        return input.revert();
      });
      this.conditions.forEach(function (condition) {
        return condition.revert();
      });
      this.uses.forEach(function (use) {
        return use.revert();
      });
      this.iterators.forEach(function (iterator) {
        return iterator.revert();
      });
      if (this.slot) this.slot.revert();
      this.styleItems.forEach(function (styleItem) {
        return styleItem.revert();
      });
      this.rendered = false;
      this[renderListeners] = null;
      this.exported = null;
    }
  }]);

  return Document;
}();

Document.prototype.render = eventLoop.bindInLock(Document.prototype.render);
Document.prototype.revert = eventLoop.bindInLock(Document.prototype.revert);

Document.register = function (path, constructor, _ref2) {
  var dependencies = _ref2.dependencies;
  documents[path] = {
    constructor: constructor,
    dependencies: dependencies
  };
  globalPool[path] = [];
};

Document.getComponentConstructorOf = function (path) {
  var config = documents[path];
  return config ? config.constructor : null;
};

if ("development" === 'development') {
  Document.reload = function (path) {
    instances[path] = [];
    globalPool[path] = [];
    Object.keys(documents).filter(function (docPath) {
      return documents[docPath].dependencies.includes(path);
    }).forEach(function (docPath) {
      instances[docPath].filter(function (doc) {
        return doc.rendered;
      }).forEach(function (doc) {
        eventLoop.callInLock(function () {
          var context = doc.context,
              exported = doc.exported;
          var props = doc[renderProps];
          var onPropsChange = doc[renderOnPropsChange];
          var sourceElement = doc[renderSourceElement];
          var listeners = doc[renderListeners];
          doc.revert();
          globalPool[path] = [];
          doc.render({
            context: context,
            props: props,
            onPropsChange: onPropsChange,
            sourceElement: sourceElement,
            listeners: listeners,
            exported: exported
          });
        });
      });
    });
  };
}

module.exports = Document;
},{"../util":"xr+4","../assert":"lQvG","../event-loop":"jt0G","../renderer":"e2eB","../log":"fe8o","./use":"E1EV","./log":"4b8H","./condition":"M3fp","./input/text":"glk2","./input/prop":"4AzR","./script":"y4Kp","./slot":"F/rD","./iterator":"emeY","./style-item":"oZSz"}],"9MP4":[function(require,module,exports) {
var Renderer = require('../renderer');

var Document = require('../document');

var Element = require('../document/element');

var eventLoop = require('../event-loop');

var createWindowDocument = function createWindowDocument(Content, options) {
  var windowElement = new Element.Tag();
  windowElement.props.set('n-component', 'Content');
  windowElement.props.set('n-style', ['__default__', 'item']);
  var windowDocument = new Document('__window__', {
    style: {
      __default__: {
        item: function item() {
          var item = Renderer.Item.New({
            layout: 'flow'
          });
          return {
            objects: {
              item: item
            },
            item: item
          };
        }
      }
    },
    styleItems: [{
      element: [],
      children: []
    }],
    imports: {
      Content: Content
    },
    uses: [[]],
    element: windowElement
  });
  windowDocument.render(options);
  Renderer.setWindowItem(windowElement.style);
  return windowDocument;
};

var windowDocument;

module.exports = function (documentImport, options) {
  eventLoop.setImmediate(function () {
    Document.register('__window__', null, {
      dependencies: [documentImport]
    });

    if (windowDocument) {
      if (windowDocument.rendered) windowDocument.revert();
      windowDocument.imports.Content = documentImport;
      windowDocument.render(options);
    } else {
      windowDocument = createWindowDocument(documentImport, options);
    }
  });
};
},{"../renderer":"e2eB","../document":"yOtl","../document/element":"7MrE","../event-loop":"jt0G"}],"fIYE":[function(require,module,exports) {
if (undefined) require('./runtime/android');
if (undefined) require('./runtime/ios');
exports.render = require('./render');
},{"./render":"9MP4"}],"HdfL":[function(require,module,exports) {
{
  var i = -1;
  exports.in = {
    EVENT: i += 1,
    SCREEN_SIZE: i += 1,
    SCREEN_ORIENTATION: i += 1,
    SCREEN_STATUSBAR_HEIGHT: i += 1,
    SCREEN_NAVIGATIONBAR_HEIGHT: i += 1,
    NAVIGATOR_LANGUAGE: i += 1,
    NAVIGATOR_ONLINE: i += 1,
    DEVICE_PIXEL_RATIO: i += 1,
    DEVICE_IS_PHONE: i += 1,
    POINTER_PRESS: i += 1,
    POINTER_RELEASE: i += 1,
    POINTER_MOVE: i += 1,
    DEVICE_KEYBOARD_SHOW: i += 1,
    DEVICE_KEYBOARD_HIDE: i += 1,
    DEVICE_KEYBOARD_HEIGHT: i += 1,
    KEY_PRESS: i += 1,
    KEY_HOLD: i += 1,
    KEY_INPUT: i += 1,
    KEY_RELEASE: i += 1,
    IMAGE_SIZE: i += 1,
    TEXT_SIZE: i += 1,
    FONT_LOAD: i += 1,
    NATIVE_ITEM_WIDTH: i += 1,
    NATIVE_ITEM_HEIGHT: i += 1,
    WINDOW_RESIZE: i += 1,
    ITEM_KEYS_FOCUS: i += 1
  };
}
{
  var _i = -1;

  exports.out = {
    LOCK: _i += 1,
    RELEASE_LOCK: _i += 1,
    CALL_FUNCTION: _i += 1,
    SET_SCREEN_STATUSBAR_COLOR: _i += 1,
    DEVICE_LOG: _i += 1,
    DEVICE_SHOW_KEYBOARD: _i += 1,
    DEVICE_HIDE_KEYBOARD: _i += 1,
    SET_WINDOW: _i += 1,
    CREATE_ITEM: _i += 1,
    SET_ITEM_PARENT: _i += 1,
    INSERT_ITEM_BEFORE: _i += 1,
    SET_ITEM_VISIBLE: _i += 1,
    SET_ITEM_CLIP: _i += 1,
    SET_ITEM_WIDTH: _i += 1,
    SET_ITEM_HEIGHT: _i += 1,
    SET_ITEM_X: _i += 1,
    SET_ITEM_Y: _i += 1,
    SET_ITEM_SCALE: _i += 1,
    SET_ITEM_ROTATION: _i += 1,
    SET_ITEM_OPACITY: _i += 1,
    SET_ITEM_KEYS_FOCUS: _i += 1,
    CREATE_IMAGE: _i += 1,
    SET_IMAGE_SOURCE: _i += 1,
    CREATE_TEXT: _i += 1,
    SET_TEXT: _i += 1,
    SET_TEXT_WRAP: _i += 1,
    UPDATE_TEXT_CONTENT_SIZE: _i += 1,
    SET_TEXT_COLOR: _i += 1,
    SET_TEXT_LINE_HEIGHT: _i += 1,
    SET_TEXT_FONT_FAMILY: _i += 1,
    SET_TEXT_FONT_PIXEL_SIZE: _i += 1,
    SET_TEXT_FONT_WORD_SPACING: _i += 1,
    SET_TEXT_FONT_LETTER_SPACING: _i += 1,
    SET_TEXT_ALIGNMENT_HORIZONTAL: _i += 1,
    SET_TEXT_ALIGNMENT_VERTICAL: _i += 1,
    CREATE_NATIVE_ITEM: _i += 1,
    ON_NATIVE_ITEM_POINTER_PRESS: _i += 1,
    ON_NATIVE_ITEM_POINTER_RELEASE: _i += 1,
    ON_NATIVE_ITEM_POINTER_MOVE: _i += 1,
    LOAD_FONT: _i += 1,
    CREATE_RECTANGLE: _i += 1,
    SET_RECTANGLE_COLOR: _i += 1,
    SET_RECTANGLE_RADIUS: _i += 1,
    SET_RECTANGLE_BORDER_COLOR: _i += 1,
    SET_RECTANGLE_BORDER_WIDTH: _i += 1
  };
}
},{}],"v5vf":[function(require,module,exports) {
var i = -1;
module.exports = {
  EVENT_NULL_TYPE: i += 1,
  EVENT_BOOLEAN_TYPE: i += 1,
  EVENT_INTEGER_TYPE: i += 1,
  EVENT_FLOAT_TYPE: i += 1,
  EVENT_STRING_TYPE: i += 1
};
},{}],"NCaV":[function(require,module,exports) {
/* eslint-disable global-require */

/* eslint-disable no-plusplus */
var utils = require('../util');

var log = require('../log');

var assert = require('../assert');

var eventLoop = require('../event-loop');

var listeners = Object.create(null);
var reader = {
  booleans: null,
  booleansIndex: 0,
  integers: null,
  integersIndex: 0,
  floats: null,
  floatsIndex: 0,
  strings: null,
  stringsIndex: 0,
  getBoolean: function getBoolean() {
    // <development>;
    if (this.booleansIndex >= this.booleans.length) {
      throw new Error("Index ".concat(this.booleansIndex, " out of range for native booleans array"));
    } // </development>;


    return this.booleans[this.booleansIndex++];
  },
  getInteger: function getInteger() {
    // <development>;
    if (this.integersIndex >= this.integers.length) {
      throw new Error("Index ".concat(this.booleansIndex, " out of range for native integers array"));
    } // </development>;


    return this.integers[this.integersIndex++];
  },
  getFloat: function getFloat() {
    // <development>;
    if (this.floatsIndex >= this.floats.length) {
      throw new Error("Index ".concat(this.booleansIndex, " out of range for native floats array"));
    } // </development>;


    return this.floats[this.floatsIndex++];
  },
  getString: function getString() {
    // <development>;
    if (this.stringsIndex >= this.strings.length) {
      throw new Error("Index ".concat(this.booleansIndex, " out of range for native strings array"));
    } // </development>;


    return this.strings[this.stringsIndex++];
  }
};
Object.seal(reader);

exports.onData = function (actions, booleans, integers, floats, strings) {
  reader.booleans = booleans;
  reader.booleansIndex = 0;
  reader.integers = integers;
  reader.integersIndex = 0;
  reader.floats = floats;
  reader.floatsIndex = 0;
  reader.strings = strings;
  reader.stringsIndex = 0;
  eventLoop.lock();
  actions.forEach(function (action) {
    var func = listeners[action];

    try {
      assert.isFunction(func, "Unknown native action got '".concat(action, "'"));
      func(reader);
    } catch (error) {
      log.error('Uncaught error when processing native events', error);
    }
  });
  eventLoop.release();
  exports.sendData();
};

exports.addActionListener = function (action, listener) {
  assert.isInteger(action);
  assert.isFunction(listener);
  assert.isNotDefined(listeners[action], "action '".concat(action, "' already has a listener"));
  listeners[action] = listener;
};

exports.sendData = function () {};

exports.pushAction = function () {};

exports.pushBoolean = function () {};

exports.pushInteger = function () {};

exports.pushFloat = function () {};

exports.pushString = function () {};

exports.registerNativeFunction = function () {};

exports.publishNativeEvent = function () {};

exports.sendDataInLock = function () {
  return exports.sendData();
};

var impl;

if (undefined) {
  impl = require('./impl/android/bridge');
}

if (undefined) {
  impl = require('./impl/ios/bridge');
}

if (undefined) {
  impl = require('./impl/macos/bridge');
}

if (undefined) {
  impl = require('./impl/browser/bridge');
}

if (impl != null) {
  utils.merge(exports, impl(exports));
}

if ("development" !== 'production') {
  exports.pushAction = function (_super) {
    return function (val) {
      assert.isInteger(val, "integer action expected, but '".concat(val, "' given"));

      _super(val);
    };
  }(exports.pushAction);

  exports.pushBoolean = function (_super) {
    return function (val) {
      assert.isBoolean(val, "boolean expected, but '".concat(val, "' given"));

      _super(val);
    };
  }(exports.pushBoolean);

  exports.pushInteger = function (_super) {
    return function (val) {
      assert.isInteger(val, "integer expected, but '".concat(val, "' given"));

      _super(val);
    };
  }(exports.pushInteger);

  exports.pushFloat = function (_super) {
    return function (val) {
      assert.isFloat(val, "float expected, but '".concat(val, "' given"));

      _super(val);
    };
  }(exports.pushFloat);

  exports.pushString = function (_super) {
    return function (val) {
      assert.isString(val, "string expected, but '".concat(val, "' given"));

      _super(val);
    };
  }(exports.pushString);
}
},{"../util":"xr+4","../log":"fe8o","../assert":"lQvG","../event-loop":"jt0G"}],"Wi5V":[function(require,module,exports) {
/* eslint-disable prefer-rest-params */
var util = require('../util');

var assert = require('../assert');

var log = require('../log');

var actions = require('./actions');

var eventTypes = require('./event-types');

var bridge = require('./bridge');

var CALL_FUNCTION = actions.out.CALL_FUNCTION;
var EVENT_NULL_TYPE = eventTypes.EVENT_NULL_TYPE,
    EVENT_BOOLEAN_TYPE = eventTypes.EVENT_BOOLEAN_TYPE,
    EVENT_INTEGER_TYPE = eventTypes.EVENT_INTEGER_TYPE,
    EVENT_FLOAT_TYPE = eventTypes.EVENT_FLOAT_TYPE,
    EVENT_STRING_TYPE = eventTypes.EVENT_STRING_TYPE;
var listeners = Object.create(null);
bridge.addActionListener(actions.in.EVENT, function (reader) {
  var args = [];
  var name = reader.getString();
  var argsLen = reader.getInteger();

  for (var i = 0; i < argsLen; i += 1) {
    var type = reader.getInteger();

    switch (type) {
      case EVENT_NULL_TYPE:
        args[i] = null;
        break;

      case EVENT_BOOLEAN_TYPE:
        args[i] = reader.getBoolean();
        break;

      case EVENT_INTEGER_TYPE:
        args[i] = reader.getInteger();
        break;

      case EVENT_FLOAT_TYPE:
        args[i] = reader.getFloat();
        break;

      case EVENT_STRING_TYPE:
        args[i] = reader.getString();
        break;

      default:
        throw new Error('Unexpected native event argument type');
    }
  }

  var eventListeners = listeners[name];

  if (eventListeners) {
    eventListeners.forEach(function (listener) {
      listener.apply(void 0, args);
    });
  } else {
    log.warn("No listeners registered for the native event '".concat(name, "'"));
  }
});
var pushPending = false;

var sendData = function sendData() {
  pushPending = false;
  bridge.sendData();
};

exports.callNativeFunction = function (name, args) {
  assert.isString(name, "native.callFunction name needs to be a string, but ".concat(name, " given"));
  assert.notLengthOf(name, 0, 'native.callFunction name cannot be an empty string');
  bridge.pushAction(CALL_FUNCTION);
  bridge.pushString(name);
  bridge.pushInteger(args.length);
  args.forEach(function (arg) {
    switch (true) {
      case typeof arg === 'boolean':
        bridge.pushInteger(EVENT_BOOLEAN_TYPE);
        bridge.pushBoolean(arg);
        break;

      case typeof arg === 'string':
        bridge.pushInteger(EVENT_STRING_TYPE);
        bridge.pushString(arg);
        break;

      case util.isInteger(arg):
        bridge.pushInteger(EVENT_INTEGER_TYPE);
        bridge.pushInteger(arg);
        break;

      case typeof arg === 'number':
        bridge.pushInteger(EVENT_FLOAT_TYPE);
        bridge.pushFloat(arg || 0);
        break;

      default:
        if (arg != null) {
          log.warn("Native function can be called with a boolean, integer, float or a string, but '".concat(arg, "' given"));
        }

        bridge.pushInteger(EVENT_NULL_TYPE);
    }
  });

  if (!pushPending && undefined) {
    pushPending = true;
    setImmediate(sendData);
  }
};

exports.onNativeEvent = function (name, listener) {
  assert.isString(name, "native.onEvent name needs to be a string, but ".concat(name, " given"));
  assert.notLengthOf(name, 0, 'native.onEvent name cannot be an empty string');
  assert.isFunction(listener, "native.onEvent listener needs to be a function, but ".concat(listener, " given"));
  if (!listeners[name]) listeners[name] = [];
  listeners[name].push(listener);
};

exports.registerNativeFunction = bridge.registerNativeFunction;
exports.publishNativeEvent = bridge.publishNativeEvent;
},{"../util":"xr+4","../assert":"lQvG","../log":"fe8o","./actions":"HdfL","./event-types":"v5vf","./bridge":"NCaV"}],"7W34":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var _require = require('./handler'),
    _callNativeFunction = _require.callNativeFunction,
    _onNativeEvent = _require.onNativeEvent;

var getFullName = Symbol('getFullName');

var NativeClientBinding =
/*#__PURE__*/
function () {
  function NativeClientBinding(module) {
    _classCallCheck(this, NativeClientBinding);

    this.module = module;
    this.callNativeFunction = this.callNativeFunction.bind(this);
    this.onNativeEvent = this.onNativeEvent.bind(this);
    Object.freeze(this);
  }

  _createClass(NativeClientBinding, [{
    key: getFullName,
    value: function value(name) {
      return "".concat(this.module, "/").concat(name);
    }
  }, {
    key: "callNativeFunction",
    value: function callNativeFunction(name) {
      for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
        args[_key - 1] = arguments[_key];
      }

      _callNativeFunction(this[getFullName](name), args);
    }
  }, {
    key: "onNativeEvent",
    value: function onNativeEvent(name, listener) {
      _onNativeEvent(this[getFullName](name), listener);
    }
  }]);

  return NativeClientBinding;
}();

module.exports = NativeClientBinding;
},{"./handler":"Wi5V"}],"0+Jn":[function(require,module,exports) {
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var _require = require('./handler'),
    registerNativeFunction = _require.registerNativeFunction,
    publishNativeEvent = _require.publishNativeEvent;

var getFullName = Symbol('getFullName');

var NativeServerBinding =
/*#__PURE__*/
function () {
  function NativeServerBinding(module) {
    _classCallCheck(this, NativeServerBinding);

    this.module = module;
    this.onCall = this.onCall.bind(this);
    this.pushEvent = this.pushEvent.bind(this);
    Object.freeze(this);
  }

  _createClass(NativeServerBinding, [{
    key: getFullName,
    value: function value(name) {
      return "".concat(this.module, "/").concat(name);
    }
  }, {
    key: "onCall",
    value: function onCall(name, handler) {
      registerNativeFunction(this[getFullName](name), handler);
      return this;
    }
  }, {
    key: "pushEvent",
    value: function pushEvent(name, args) {
      publishNativeEvent(this[getFullName](name), args);
    }
  }]);

  return NativeServerBinding;
}();

module.exports = NativeServerBinding;
},{"./handler":"Wi5V"}],"Z/3Q":[function(require,module,exports) {
var NativeClientBinding = require('./NativeClientBinding');

var NativeServerBinding = require('./NativeServerBinding');

exports.NativeClientBinding = NativeClientBinding;
exports.NativeServerBinding = NativeServerBinding;
},{"./NativeClientBinding":"7W34","./NativeServerBinding":"0+Jn"}],"Ue2/":[function(require,module,exports) {
var _require = require('./initializer'),
    render = _require.render;

var _require2 = require('./native'),
    NativeClientBinding = _require2.NativeClientBinding,
    NativeServerBinding = _require2.NativeServerBinding;

var _require3 = require('./signal'),
    SignalDispatcher = _require3.SignalDispatcher,
    SignalsEmitter = _require3.SignalsEmitter;

var Resources = require('./resources');

var Renderer = require('./renderer');

var log = require('./log');

var Document = require('./document');

var Element = require('./document/element'); // native


exports.NativeClientBinding = NativeClientBinding;
exports.NativeServerBinding = NativeServerBinding; // utilities

exports.logger = log;
exports.util = require('./util');
exports.Struct = require('./struct');
exports.ObservableArray = require('./observable-array'); // signal

exports.SignalDispatcher = SignalDispatcher;
exports.SignalsEmitter = SignalsEmitter; // document

exports.Document = Document;
exports.Element = Element;
exports.CustomTag = Element.Tag.CustomTag; // renderer

exports.render = render;
exports.Renderer = Renderer;
exports.loadFont = Renderer.loadFont;
exports.NativeStyleItem = Renderer.Native;
exports.Device = Renderer.Device;
exports.Screen = Renderer.Screen;
exports.Navigator = Renderer.Navigator; // resources

exports.Resource = Resources.Resource;
exports.Resources = Resources;
exports.resources = new Resources();
Renderer.setResources(exports.resources);
Object.freeze(exports);
},{"./initializer":"fIYE","./native":"Z/3Q","./signal":"WtLN","./resources":"fuji","./renderer":"e2eB","./log":"fe8o","./document":"yOtl","./document/element":"7MrE","./util":"xr+4","./struct":"4Y+I","./observable-array":"JLX2"}],"lp4R":[function(require,module,exports) {
module.exports = require('./src');
},{"./src":"Ue2/"}],"OBhE":[function(require,module,exports) {
const IN_TAG = 1 << 0
const TAG_OPEN = 1 << 1
const ATTR_VALUE = 1 << 2
const TAG_CLOSE = 1 << 3
const ATTR_QUOTE = 1 << 4
const ATTR_SINGLE_QUOTE = 1 << 5
const ATTR_DOUBLE_QUOTE = 1 << 6
const ATTR_BRACE = 1 << 7
const IN_INSTRUCTION = 1 << 8
const IN_COMMENT = 1 << 9
const IN_SCRIPT = 1 << 10
const IN_STYLE = 1 << 11

const SCRIPT_ENDING = ['<', '/', 's', 'c', 'r', 'i', 'p', 't', '>']
const STYLE_ENDING = ['<', '/', 's', 't', 'y', 'l', 'e', '>']

const OPTIONS = {
  noAttributeValue: ''
}

exports.parse = (xhtml, handlers, options = OPTIONS) => {
  const { opentag, closetag, attribute, text, comment, instruction } = handlers
  const { noAttributeValue } = options
  let commentStep = 0
  let scriptStep = 0
  let styleStep = 0
  let attrRest = ''
  let tagRest = ''
  let tagName = ''
  let rest = ''
  let state = 0
  let line = 0
  let row = 0

  const bitOn = (bit) => { state |= bit }
  const bitOff = (bit) => { state = state & ~bit }
  const isBitOn = bit => (state & bit) > 0

  const sayOpentag = () => {
    bitOn(TAG_OPEN)
    opentag(rest, line, row)
    tagName = rest
    rest = ''
  }

  const sayAttribute = () => {
    if (!attrRest) {
      attrRest = rest
      rest = noAttributeValue
    }
    attribute(attrRest, rest, line, row)
    attrRest = ''
    rest = ''
    bitOff(ATTR_VALUE)
  }

  const { length } = xhtml
  for (let index = 0; index < length; index += 1) {
    const char = xhtml[index]

    if (char === '\n') {
      line += 1
      row = 0
    }

    if (isBitOn(IN_COMMENT)) {
      if (char === '-' && (commentStep === 0 || commentStep === 1)) {
        rest += char
        commentStep += 1
      } else if (char === '>' && commentStep === 2) {
        comment(rest.slice(2, -2), line, row)
        rest = ''
        commentStep = 0
        bitOff(IN_INSTRUCTION)
        bitOff(IN_COMMENT)
        bitOff(IN_TAG)
      } else {
        rest += char
        if (char !== '-') {
          commentStep = 0
        }
      }
    } else if (isBitOn(IN_INSTRUCTION) && char === '-' && commentStep === 0) {
      rest += char
      commentStep += 1
    } else if (isBitOn(IN_INSTRUCTION) && char === '-' && commentStep === 1) {
      rest += char
      bitOn(IN_COMMENT)
      commentStep = 0
    } else if (isBitOn(IN_INSTRUCTION) && char === '>') {
      instruction(rest, line, row)
      rest = ''
      bitOff(IN_INSTRUCTION)
      bitOff(IN_TAG)
    } else if (isBitOn(IN_INSTRUCTION)) {
      rest += char
      commentStep = -1
    } else if (char === '!' && isBitOn(IN_TAG) && !isBitOn(TAG_OPEN) && !isBitOn(ATTR_VALUE) && !rest) {
      bitOn(IN_INSTRUCTION)
    } else if (isBitOn(IN_SCRIPT)) {
      if (char.toLowerCase() === SCRIPT_ENDING[scriptStep]) {
        if (scriptStep === 8) {
          text(rest.slice(0, -8), line, row)
          closetag('script', line, row)
          rest = ''
          scriptStep = 0
          bitOff(IN_SCRIPT)
          bitOff(IN_TAG)
        } else {
          rest += char
          scriptStep += 1
        }
      } else {
        rest += char
        scriptStep = 0
      }
    } else if (isBitOn(IN_STYLE)) {
      if (char.toLowerCase() === STYLE_ENDING[styleStep]) {
        if (styleStep === 7) {
          text(rest.slice(0, -7), line, row)
          closetag('style', line, row)
          rest = ''
          styleStep = 0
          bitOff(IN_STYLE)
          bitOff(IN_TAG)
        } else {
          rest += char
          styleStep += 1
        }
      } else {
        rest += char
        styleStep = 0
      }
    } else if (char === '<' && !isBitOn(IN_TAG)) {
      bitOn(IN_TAG)
      if (rest) {
        text(rest, line, row)
        rest = ''
      }
    } else if (char === '"' && isBitOn(ATTR_DOUBLE_QUOTE)) {
      bitOff(ATTR_DOUBLE_QUOTE)
      bitOff(ATTR_QUOTE)
      bitOff(ATTR_VALUE)
    } else if (char === '"' && isBitOn(ATTR_VALUE) && !isBitOn(ATTR_QUOTE)) {
      bitOn(ATTR_DOUBLE_QUOTE)
      bitOn(ATTR_QUOTE)
    } else if (char === "'" && isBitOn(ATTR_SINGLE_QUOTE)) {
      bitOff(ATTR_SINGLE_QUOTE)
      bitOff(ATTR_QUOTE)
      bitOff(ATTR_VALUE)
    } else if (char === "'" && isBitOn(ATTR_VALUE) && !isBitOn(ATTR_QUOTE)) {
      bitOn(ATTR_SINGLE_QUOTE)
      bitOn(ATTR_QUOTE)
    } else if (char === '}' && isBitOn(ATTR_BRACE)) {
      bitOff(ATTR_BRACE)
      bitOff(ATTR_QUOTE)
      bitOff(ATTR_VALUE)
      rest += char
    } else if (char === '{' && isBitOn(ATTR_VALUE) && !isBitOn(ATTR_QUOTE)) {
      bitOn(ATTR_BRACE)
      bitOn(ATTR_QUOTE)
      rest += char
    } else if (char === '/' && isBitOn(IN_TAG) && !isBitOn(ATTR_VALUE)) {
      bitOn(TAG_CLOSE)
    } else if (char === '>' && isBitOn(IN_TAG) && !isBitOn(ATTR_QUOTE)) {
      if (!tagRest && !isBitOn(TAG_OPEN) && (rest || !isBitOn(TAG_CLOSE))) {
        sayOpentag()
      }
      if (attrRest || rest) sayAttribute()
      if (isBitOn(TAG_CLOSE)) {
        closetag(tagRest, line, row)
        tagRest = ''
      } else {
        if (tagName.toLowerCase() === 'script') bitOn(IN_SCRIPT)
        if (tagName.toLowerCase() === 'style') bitOn(IN_STYLE)
      }
      bitOff(IN_TAG)
      bitOff(TAG_OPEN)
      bitOff(TAG_CLOSE)
    } else if (char === ' ' && isBitOn(IN_TAG) && !isBitOn(TAG_OPEN)) {
      sayOpentag()
    } else if (char === ' ' && isBitOn(IN_TAG) && !isBitOn(ATTR_QUOTE) && (attrRest || rest)) {
      sayAttribute()
    } else if (char === '=' && isBitOn(IN_TAG) && !isBitOn(ATTR_VALUE)) {
      bitOn(ATTR_VALUE)
      attrRest = rest
      rest = ''
    } else if (char === ' ' && isBitOn(IN_TAG) && !isBitOn(ATTR_VALUE)) {
      // NOP
    } else if (char === '\n' && isBitOn(IN_TAG)) {
      // NOP
    } else if (isBitOn(TAG_CLOSE)) {
      tagRest += char
    } else {
      rest += char
    }

    row += 1
  }

  if (rest) {
    text(rest, line, row)
  }
}

},{}],"CH8g":[function(require,module,exports) {
const xhtmlParser = require('lite-html-parser')
const { util, Element } = require('@neft/core')

const { Tag } = Element
const { customTags } = Tag.CustomTag

class ParserError extends Error {
  constructor(message, xhtml, line, row) {
    super(message)
    this.message = message
    this.xhtml = xhtml
    this.line = line
    this.row = row
    this.name = 'ParserError'
  }
}

module.exports = (xhtml) => {
  const head = new Element.Tag()
  const stack = []
  const getLastElement = () => util.last(stack)
  const addElement = (element) => {
    const lastElement = getLastElement() || head
    element.parent = lastElement
  }
  xhtmlParser.parse(xhtml, {
    opentag(name) {
      const Ctor = customTags[name] || Tag
      const tag = new Ctor()
      tag.name = name
      addElement(tag)
      return stack.push(tag)
    },
    closetag(name, line, row) {
      const element = getLastElement()
      if ((element.name === '' || name !== '') && element.name !== name) {
        throw new ParserError(`Expected \`${element.name}\` tag to be closed, but \`${name}\` found`, xhtml, line, row)
      }
      return stack.pop()
    },
    attribute(name, value) {
      const element = getLastElement()
      element.props.set(name, value)
    },
    text(text) {
      if (!text.replace(/[\t\n]/gm, '')) {
        return
      }
      const element = new Element.Text()
      element.text = text
      addElement(element)
    },
    comment() {},
    instruction() {},
  }, {
    noAttributeValue: '{true}',
  })

  if (stack.length > 0) {
    const lines = xhtml.split('\n')
    const maxLine = lines.length - 1
    const maxRow = util.last(lines).length
    throw new ParserError(`Element ${stack[0].name} is not closed`, xhtml, maxLine, maxRow)
  }

  return head
}

},{"lite-html-parser":"OBhE","@neft/core":"lp4R"}],"86VO":[function(require,module,exports) {
const { Element } = require('@neft/core')

const { Tag, Text } = Element

const checkNode = function (node) {
  if (node instanceof Text) {
    if (node.text.indexOf('\n') === -1) {
      return
    }
    node.text = node.text.replace(/^\s+$/gm, '')
    node.text = node.text.replace(/^[\n\r]|[\n\r]$/g, '')
    const minIndent = Math.min(...node.text.match(/^( *)/gm).map(str => str.length))
    if (minIndent > 0) {
      node.text = node.text.replace(new RegExp(`^ {${minIndent}}`, 'gm'), '')
    }
    if (node.text.length === 0) {
      node.parent = null
    }
  }

  if (node instanceof Tag) {
    node.children.slice().forEach(checkNode)
  }
}

module.exports = checkNode

},{"@neft/core":"lp4R"}],"caHh":[function(require,module,exports) {
const findImports = (element, parser) => {
  const imports = []
  element.queryAll('n-import').forEach((child) => {
    const { src, as } = child.props
    child.parent = null
    if (!src || !as) {
      parser.warning(new Error('<n-import> must provide src="" and as="" properties'))
      return
    }
    imports.push({ src, name: as })
  })
  return imports
}

module.exports = function (element, parser) {
  let imports = ''
  let components = ''

  // merge components from files
  const links = findImports(element, parser)
  links.forEach((link) => {
    parser.dependencies.push(link.src)
    imports += `"${link.name}": require('${link.src}'),`
  })

  if (imports.length) parser.addProp('imports', () => `{${imports}}`)

  // find components in file
  element.queryAll('n-component').forEach((child) => {
    const { name } = child.props
    if (!name) return
    if (child.queryParents('n-component')) return

    child.name = ''
    child.parent = null
    const options = {
      resourcePath: `${parser.resourcePath}#${name}`,
    }
    components += `"${name}": ${parser.parseComponentElement(child, options)}, `
  })

  if (components.length) parser.addProp('components', () => `{${components}}`)
}

},{}],"wPCc":[function(require,module,exports) {
const { Element } = require('@neft/core')

const { Text, Tag } = Element

const applyStyleQueriesInElement = (rootElement, queries, parser) => {
  Object.keys(queries).forEach((query) => {
    const elements = rootElement.queryAll(query)
    elements.forEach((element) => {
      if (element instanceof Tag) {
        element.props.set('n-style', queries[query])
      } else {
        parser.warning(`Styles cannot be attached to texts; ${query} has been omitted`)
      }
    })
  })
}

const findDefinitions = (rootElement, element) => {
  const isTag = element instanceof Tag
  const isText = element instanceof Text
  const nStyle = isTag && element.props['n-style']

  const children = []
  if (isTag) {
    element.children.forEach((child) => {
      children.push(...findDefinitions(rootElement, child))
    })
  }

  if (isText || nStyle) {
    return [{
      element: element.getAccessPath(rootElement),
      children: isTag ? children : null,
    }]
  }

  return children
}

const getStyleFiles = (styles) => {
  let result = '{ '
  styles.forEach((style) => {
    const value = style.link ? `require('${style.href}')` : `((module) => {\n\n${style.bundle}\n\nreturn module.exports\n})({})`
    result += `'${style.name}': ${value}, `
  })
  result += ' }'
  return result
}

module.exports = (element, parser) => {
  const styles = []
  const queries = {}

  const addStyle = (name, nml, { link = false } = false) => {
    const styleQueries = {}
    Object.entries(nml.queries).forEach(([query, queryPath]) => {
      styleQueries[query] = [name, ...queryPath]
    })
    Object.assign(queries, styleQueries)
    styles.push({
      ...nml, name, href: nml.path, link,
    })
  }

  let bare = false
  const docStyle = element.query('style')
  if (docStyle) {
    docStyle.parent = null
    bare = !!docStyle.props.bare
  }

  if (!bare) {
    parser.defaultStyles
      .forEach((style) => { addStyle(style.name, style, { link: !!style.path }) })
  }
  if (docStyle) {
    const parserStyle = parser.styles[parser.resourcePath]
    addStyle('__default__', {
      bundle: parserStyle.value,
      queries: parserStyle.queries,
    })
  }
  if (styles.length) applyStyleQueriesInElement(element, queries, parser)

  parser.addProp('style', () => getStyleFiles(styles))

  parser.addProp('styleItems', () => {
    const definitions = findDefinitions(element, element)
    return JSON.stringify(definitions)
  })

  const nextStyles = element.queryAll('style')
  if (nextStyles.length > 0) {
    parser.warning(new Error('Component file can contain only one <style> tag'))

    nextStyles.forEach((nextStyle) => {
      nextStyle.parent = null
    })
  }
}

},{"@neft/core":"lp4R"}],"Cd4l":[function(require,module,exports) {
const { Element } = require('@neft/core')

const parseNForSyntax = (nFor) => {
  if (!nFor.includes(' in ')) return null
  const inParts = nFor.split(' in ')
  let left = inParts[0]
  if (left[0] === '(' && left[left.length - 1] === ')') {
    left = left.slice(1, -1)
  }

  // set binding scope
  const parts = left.split(',').map(part => part.trim())

  return {
    item: parts[0] || '',
    index: parts[1] || '',
    array: parts[2] || '',
    binding: inParts[1],
  }
}

module.exports = (element, parser) => {
  const iterators = []

  element.queryAll('[n-for]').forEach((forElem, index) => {
    if (forElem.queryParents('[n-for]')) return
    const nFor = forElem.props['n-for']
    if (typeof nFor !== 'string') return
    const container = new Element.Tag()
    forElem.children.forEach((child) => { child.parent = container })
    const forComponent = parser.parseComponentElement(container, {
      resourcePath: `${parser.resourcePath}#n-for-${index}`,
      defaultStyles: [],
    })
    const syntax = parseNForSyntax(nFor)
    if (!syntax) parser.error(new Error(`Invalid syntax of \`n-for="${forElem.props['n-for']}"\``))
    forElem.props['n-for'] = syntax.binding
    iterators.push({ forElem, forComponent, syntax })
  })

  if (iterators.length) {
    parser.addProp('iterators', () => {
      let code = ''
      iterators.forEach(({ forElem, forComponent, syntax }) => {
        code += `{ element: ${JSON.stringify(forElem.getAccessPath(element))}, \
component: ${forComponent}, naming: ${JSON.stringify(syntax)} \
}, `
      })
      return `[${code}]`
    })
  }
}

},{"@neft/core":"lp4R"}],"57Dr":[function(require,module,exports) {
module.exports = function (element, parser) {
  const script = element.query('script')
  if (!script) return

  script.parent = null

  parser.addProp('script', () => `((module) => {\
      const { exports } = module;\n
      (() => {\n\n${parser.scripts[parser.resourcePath].value}\n\n})();\n
      return module.exports;
    })({ exports: {} })`)

  const nextScripts = element.queryAll('script')
  if (nextScripts.length > 0) {
    parser.warning(new Error('Component file can contain only one <script> tag'))

    nextScripts.forEach((nextScript) => {
      nextScript.parent = null
    })
  }
}

},{}],"o8zv":[function(require,module,exports) {
module.exports = function (element, parser) {
  const nProps = element.query('n-props')
  if (!nProps) return

  nProps.parent = null
  parser.addProp('props', () => JSON.stringify(nProps.props))

  const nextNPropos = element.query('n-props')
  if (nextNPropos) {
    parser.warning(new Error('Component file can contain only one <n-props> tag'))
  }
}

},{}],"1WFF":[function(require,module,exports) {
const getElseElement = (node) => {
  if (!node.nextSibling) return null
  if (!node.nextSibling.props) return null
  if (!node.nextSibling.props.has('n-else')) return null
  return node.nextSibling
}

module.exports = (element, parser) => {
  const elements = element.queryAll('[n-if]')
  if (!elements.length) return

  parser.addProp('conditions', () => {
    let conditions = ''
    elements.forEach((child) => {
      const elseElement = getElseElement(child)
      const elementPath = child.getAccessPath(element)
      const elseElementPath = elseElement ? elseElement.getAccessPath(element) : null
      conditions += `{element: ${JSON.stringify(elementPath)}, `
      conditions += `elseElement: ${JSON.stringify(elseElementPath)}}, `
    })
    return `[${conditions}]`
  })
}

},{}],"ipVS":[function(require,module,exports) {
const { Element } = require('@neft/core')

module.exports = (element, parser) => {
  const nUses = []

  const forChild = (child) => {
    if (!(child instanceof Element.Tag)) return
    child.children.forEach(forChild)
    const { name } = child

    // short syntax
    if (name.length > 0 && name[0].toUpperCase() === name[0]) {
      child.props['n-component'] = name
      nUses.push(child)
    }

    // long formula
    if (child.name === 'n-use') {
      nUses.push(child)
      child.name = 'blank'
    }
  }

  forChild(element)

  if (nUses.length) {
    parser.addProp('uses', () => JSON.stringify(nUses.map(nUse => nUse.getAccessPath(element))))
  }
}

},{"@neft/core":"lp4R"}],"a2Ly":[function(require,module,exports) {
var CHANGE_THIS_TO_SELF, BINDING_THIS_TO_TARGET_OPTS, isArrayElementIndexer, repeatString;

exports.BINDING_THIS_TO_TARGET_OPTS = BINDING_THIS_TO_TARGET_OPTS = 1 << 0;

exports.CHANGE_THIS_TO_SELF = CHANGE_THIS_TO_SELF = 1 << 1;

repeatString = function(str, amount) {
  var i, j, r, ref;
  r = str;
  for (i = j = 0, ref = amount - 1; j < ref; i = j += 1) {
    r += str;
  }
  return r;
};

isArrayElementIndexer = function(string, index) {
  var char;
  if (string[index] !== '[') {
    return false;
  }
  while (index++ < string.length) {
    char = string[index];
    if (char === ']') {
      return true;
    }
    if (!/[0-9]/.test(char)) {
      return false;
    }
  }
  return false;
};

exports.isBinding = function(code) {
  var func;
  try {
    func = new Function('console', "'use strict'; return " + code + ";");
    func.call(null);
    return false;
  } catch (error) {}
  return true;
};

exports.parse = function(val, isPublicId, opts, objOpts, isVariableId) {
  var binding, char, elem, hash, i, id, isArrayIndexer, isCurrentArrayIndexer, isString, j, k, l, lastBinding, len, len1, len2, len3, m, n, ref, ref1, text, useThis;
  if (opts == null) {
    opts = 0;
  }
  if (objOpts == null) {
    objOpts = {};
  }
  if (isVariableId == null) {
    isVariableId = function() {
      return false;
    };
  }
  binding = [''];
  val += ' ';
  lastBinding = null;
  isString = false;
  isArrayIndexer = false;
  for (i = j = 0, len = val.length; j < len; i = ++j) {
    char = val[i];
    if (isArrayIndexer && char === ']') {
      isArrayIndexer = false;
      continue;
    }
    isCurrentArrayIndexer = !isString && isArrayElementIndexer(val, i);
    if ((char === '.' || isCurrentArrayIndexer) && lastBinding) {
      isArrayIndexer = isCurrentArrayIndexer;
      lastBinding.push('');
      continue;
    }
    if (lastBinding && (isString || /[a-zA-Z_0-9$]/.test(char))) {
      lastBinding[lastBinding.length - 1] += char;
    } else if (!isString && /[a-zA-Z_$]/.test(char)) {
      lastBinding = [char];
      binding.push(lastBinding);
    } else {
      if (lastBinding === null) {
        binding[binding.length - 1] += char;
      } else {
        lastBinding = null;
        binding.push(char);
      }
    }
    if ((char === '\'' || char === '"') && val[i - 1] !== '\\') {
      isString = !isString;
    }
  }
  for (i = k = 0, len1 = binding.length; k < len1; i = ++k) {
    elem = binding[i];
    if (!(typeof elem !== 'string')) {
      continue;
    }
    elem = (typeof objOpts.modifyBindingPart === "function" ? objOpts.modifyBindingPart(elem) : void 0) || elem;
    if (opts & CHANGE_THIS_TO_SELF && elem[0] === 'this') {
      elem[0] = 'self'
    }
    useThis = (ref = elem[0]) === 'parent' || ref === 'nextSibling' || ref === 'previousSibling' || ref === 'target';
    useThis || (useThis = (ref1 = objOpts.globalIdToThis) != null ? ref1[elem[0]] : void 0);
    useThis || (useThis = typeof objOpts.shouldPrefixByThis === "function" ? objOpts.shouldPrefixByThis(elem[0]) : void 0);
    if (useThis) {
      elem.unshift("this");
    }
    if (opts & BINDING_THIS_TO_TARGET_OPTS && elem[0] === 'this') {
      elem.splice(1, 0, 'target');
    }
    if (isPublicId(elem[0]) && (i === 0 || binding[i - 1][binding[i - 1].length - 1] !== '.')) {
      continue;
    } else {
      binding[i] = elem.join('.');
    }
  }
  i = -1;
  n = binding.length;
  while (++i < n) {
    if (typeof binding[i] === 'string') {
      if (typeof binding[i - 1] === 'string') {
        binding[i - 1] += binding[i];
      } else if (binding[i].trim() !== '') {
        continue;
      }
      binding.splice(i, 1);
      n--;
    }
  }
  text = '';
  hash = '';
  for (i = l = 0, len2 = binding.length; l < len2; i = ++l) {
    elem = binding[i];
    if (typeof elem === 'string') {
      hash += elem;
    } else if (elem.length > 1) {
      if ((binding[i - 1] != null) && text) {
        text += ", ";
      }
      text += repeatString('[', elem.length - 1);
      if (isVariableId(elem[0])) {
        text += "" + elem[0];
      } else {
        text += "'" + elem[0] + "'";
      }
      if (elem[0] === "this") {
        hash += "this";
      } else {
        hash += "" + elem[0];
      }
      elem.shift();
      for (i = m = 0, len3 = elem.length; m < len3; i = ++m) {
        id = elem[i];
        text += ", '" + id + "']";
        if (isFinite(id)) {
          hash += "[" + id + "]";
        } else {
          hash += "." + id;
        }
      }
    } else {
      if (elem[0] === "this") {
        hash += "this";
      } else {
        hash += "" + elem[0];
      }
    }
  }
  hash = hash.trim();
  text = "[" + (text.trim()) + "]";
  return {
    hash: hash,
    connections: text
  };
};

},{}],"52Yg":[function(require,module,exports) {
var PARSER_FLAGS, PARSER_OPTS, bindingParser, isPublicId, logger, shouldBeUpdatedOnCreate;

logger = require('@neft/core').logger;

bindingParser = require('@neft/compiler-binding');

PARSER_FLAGS = bindingParser.CHANGE_THIS_TO_SELF;

// comes from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects
const GLOBAL_KEYS = [
  // value properties
  'Infinity', 'NaN', 'undefined', 'null',

  // function properties
  'isFinite', 'isNaN', 'parseFloat', 'parseInt',
  'decodeURI', 'decodeURIComponent',
  'encodeURI', 'encodeURIComponent',

  // fundamental objects
  'Object', 'Function', 'Boolean', 'Symbol',
  'Error', 'EvalError', 'InternalError', 'RangeError', 'ReferenceError',
  'SyntaxError', 'TypeError', 'URIError',

  // numbers and dates
  'Number', 'Math', 'Date',

  // text processing
  'String', 'RegExp',

  // collections
  'Array', 'Map', 'Set', 'WeakMap', 'WeakSet',

  // structured data
  'JSON',

  // control abstraction objects
  'Promise', 'Generator', 'GeneratorFunction', 'AsyncFunction',
]

PARSER_OPTS = {
  shouldPrefixByThis: function(key) {
    return (key !== 'this' && key !== 'global' && key !== 'Neft' && key !== 'typeof' && key !== 'true' && key !== 'false' && key !== 'null' && key !== 'undefined' && key !== 'self') && GLOBAL_KEYS.indexOf(key) === -1;
  }
};

isPublicId = function(id) {
  return id === 'this';
};

shouldBeUpdatedOnCreate = function(connection) {
  var key;
  key = connection[0];
  if (Array.isArray(key)) {
    return shouldBeUpdatedOnCreate(key);
  } else {
    return !(key === 'this' || key === 'context');
  }
};

module.exports = function(text, scopeProps) {
  var blocks, charStr, connections, err, funcBody, hash, i, innerBlocks, isBlock, isString, n, parsed, str;
  text = text.replace(/[\t\n]/gm, '');
  str = '';
  hash = '';
  connections = [];
  isString = isBlock = false;
  blocks = 0;
  innerBlocks = 0;
  i = 0;
  n = text.length;
  while (i < n) {
    charStr = text[i];
    if (charStr === '{') {
      isBlock = true;
      blocks += 1;
      if (str !== '' || blocks > 1) {
        hash += '"' + str + '" + ';
      }
      str = '';
    } else if (charStr === '{') {
      innerBlocks += 1;
      str += charStr;
    } else if (charStr === '}') {
      if (innerBlocks > 0) {
        innerBlocks -= 1;
        str += charStr;
      } else if (isBlock) {
        parsed = bindingParser.parse(str, isPublicId, PARSER_FLAGS, PARSER_OPTS);
        hash += "(" + parsed.hash + ") + ";
        connections.push.apply(connections, eval(parsed.connections));
        str = '';
      } else {
        logger.error("Interpolated string parse error: '" + text + "'");
        return;
      }
    } else {
      str += charStr;
    }
    i++;
  }
  if (str === '') {
    hash = hash.slice(0, -3);
  } else {
    hash += '"' + str + '"';
  }
  funcBody = "return " + hash;
  try {
    new Function(funcBody);
  } catch (error) {
    err = error;
    logger.error("Can't parse string literal:\n" + text + "\n" + err.message);
    return null;
  }
  return {
    body: funcBody,
    connections: connections
  };
};

},{"@neft/core":"lp4R","@neft/compiler-binding":"a2Ly"}],"bEyb":[function(require,module,exports) {
const { Element } = require('@neft/core')

const parse = require('./input-parser')

const { Tag, Text } = Element

const InputRE = /{([^}]*)}/g

const testInput = (text) => {
  InputRE.lastIndex = 0
  return text && InputRE.test(text)
}

module.exports = function (rootElement, parser) {
  const textInputs = []
  const propInputs = []

  const forElement = (element) => {
    // text
    if (element instanceof Text) {
      const { text } = element
      if (testInput(text)) {
        const interpolation = parse(text)
        if (interpolation) {
          textInputs.push({ element, interpolation, text })
          element.text = ''
        }
      }
    // props
    } else if (element instanceof Tag) {
      const { props, children } = element

      Object.keys(props).forEach((prop) => {
        const text = props[prop]
        if (testInput(text)) {
          const interpolation = parse(text)
          props.set(prop, null)
          const pushWay = prop[0] === 'n' && prop[1] === '-' ? 'unshift' : 'push'
          propInputs[pushWay]({
            element, prop, interpolation, text,
          })
        }
      })

      children.forEach(forElement)
    }
  }

  forElement(rootElement)

  const stringify = list => JSON.stringify(list.map(({ element, ...rest }) => ({
    element: element.getAccessPath(rootElement),
    ...rest,
  })))

  if (textInputs.length) {
    parser.addProp('textInputs', () => stringify(textInputs))
  }

  if (propInputs.length) {
    parser.addProp('propInputs', () => stringify(propInputs))
  }
}

},{"@neft/core":"lp4R","./input-parser":"52Yg"}],"dKVp":[function(require,module,exports) {
module.exports = (element, parser) => {
  const refs = {}

  element.queryAll('[n-ref]').concat(element.queryAll('[ref]')).forEach((nRef) => {
    const ref = nRef.props['n-ref'] || nRef.props.ref
    if (refs[ref]) {
      parser.warning(new Error(`n-ref ${ref} is already defined`))
      return
    }
    refs[ref] = nRef
  })

  if (!Object.keys(refs).length) return

  parser.addProp('refs', () => {
    const json = Object.keys(refs).reduce((result, ref) => {
      result[ref] = refs[ref].getAccessPath(element)
      return result
    }, {})
    return JSON.stringify(json)
  })
}

},{}],"TsZT":[function(require,module,exports) {
module.exports = (element, parser) => {
  const nLogs = element.queryAll('n-log')
  if (!nLogs.length) return

  nLogs.forEach((nLog) => {
    nLog.visible = false
  })

  parser.addProp('logs', () => JSON.stringify(nLogs.map(nLog => nLog.getAccessPath(element))))
}

},{}],"KhSE":[function(require,module,exports) {
module.exports = (element) => {
  const nCalls = element.queryAll('n-call')
  if (!nCalls.length) return

  nCalls.forEach((nCall) => {
    nCall.visible = false
  })
}

},{}],"DfhC":[function(require,module,exports) {
module.exports = (element, parser) => {
  const [nSlot, rest] = element.queryAll('n-slot').concat(element.queryAll('n-target'))
  if (!nSlot) return
  if (rest) parser.error(new Error('Component can have only one <n-slot />'))
  nSlot.name = 'blank'
  parser.addProp('slot', () => JSON.stringify(nSlot.getAccessPath(element)))
}

},{}],"y4su":[function(require,module,exports) {
const { Element: { Tag } } = require('@neft/core')

module.exports = (element, parser) => {
  const forElement = (child) => {
    if (!(child instanceof Tag)) return
    if (child.name.startsWith('n-') && child.visible) {
      parser.error(new Error(`Unknown tag ${child.name}`))
    }
    child.children.forEach(forElement)
  }

  forElement(element)
}

},{"@neft/core":"lp4R"}],"JaWY":[function(require,module,exports) {
const parseXHTML = require('./xhtml-parser')

/* eslint-disable global-require */
const PARSERS = [
  require('./parse/clear'),
  require('./parse/components'),
  require('./parse/styles'),
  require('./parse/iterators'),
  require('./parse/scripts'),
  require('./parse/props'),
  require('./parse/conditions'),
  require('./parse/uses'),
  require('./parse/storage'),
  require('./parse/refs'),
  require('./parse/logs'),
  require('./parse/calls'),
  require('./parse/slot'),
  require('./parse/unknowns'),
]
/* eslint-enable global-require */

const props = Symbol('props')
const propsToAdd = Symbol('propsToAdd')

class ComponentParser {
  constructor({
    scripts, styles, resourcePath, defaultStyles,
  }) {
    this.error = console.error
    this.warning = console.warn
    this.scripts = scripts
    this.styles = styles
    this.resourcePath = resourcePath
    this.defaultStyles = defaultStyles
    this.dependencies = []
    this[props] = {}
    this[propsToAdd] = {}
  }

  addProp(name, generator) {
    this[propsToAdd][name] = generator
  }

  propsToCode() {
    let result = '{\n'
    Object.keys(this[props]).forEach((key) => {
      result += `${key}: ${this[props][key]},\n`
    })
    result += '}'
    return result
  }

  parseComponentElement(element, options) {
    const componentCode = new ComponentParser({ ...this, ...options }).toCode(element)
    return componentCode.exports
  }

  toCode(element) {
    PARSERS.forEach(parser => parser(element, this))
    this.addProp('element', () => `Element.fromJSON(${JSON.stringify(element)})`)
    Object.keys(this[propsToAdd]).forEach((key) => { this[props][key] = this[propsToAdd][key]() })
    return {
      exports: `(options) => new Document('${this.resourcePath}', ${this.propsToCode()}, options)`,
      dependencies: this.dependencies,
    }
  }
}

const parseComponent = (parser, ast) => {
  const documentCode = parser.toCode(ast)
  const dependencies = parser.dependencies.map(src => `require('${src}')`)
  const code = `const { Document, Element } = require('@neft/core')
Document.register('${parser.resourcePath}', ${documentCode.exports}, {
  dependencies: [${dependencies}],
})
module.exports = '${parser.resourcePath}'
if (module.hot) {
  module.hot.accept(() => {
    Document.reload('${parser.resourcePath}')
  })
}
`
  return {
    code,
    dependencies: documentCode.dependencies,
  }
}

exports.parseToAst = parseXHTML

exports.parseToCode = (ast, {
  resourcePath,
  scripts,
  styles,
  defaultStyles = [],
} = {}) => {
  const parser = new ComponentParser({
    resourcePath,
    scripts,
    styles,
    defaultStyles,
  })

  return parseComponent(parser, ast)
}

},{"./xhtml-parser":"CH8g","./parse/clear":"86VO","./parse/components":"caHh","./parse/styles":"wPCc","./parse/iterators":"Cd4l","./parse/scripts":"57Dr","./parse/props":"o8zv","./parse/conditions":"1WFF","./parse/uses":"ipVS","./parse/storage":"bEyb","./parse/refs":"dKVp","./parse/logs":"TsZT","./parse/calls":"KhSE","./parse/slot":"DfhC","./parse/unknowns":"y4su"}],"mEVg":[function(require,module,exports) {
"use strict";
/* Array utilities. */

var arrays = {
  range: function (start, stop) {
    var length = stop - start,
        result = new Array(length),
        i,
        j;

    for (i = 0, j = start; i < length; i++, j++) {
      result[i] = j;
    }

    return result;
  },
  find: function (array, valueOrPredicate) {
    var length = array.length,
        i;

    if (typeof valueOrPredicate === "function") {
      for (i = 0; i < length; i++) {
        if (valueOrPredicate(array[i])) {
          return array[i];
        }
      }
    } else {
      for (i = 0; i < length; i++) {
        if (array[i] === valueOrPredicate) {
          return array[i];
        }
      }
    }
  },
  indexOf: function (array, valueOrPredicate) {
    var length = array.length,
        i;

    if (typeof valueOrPredicate === "function") {
      for (i = 0; i < length; i++) {
        if (valueOrPredicate(array[i])) {
          return i;
        }
      }
    } else {
      for (i = 0; i < length; i++) {
        if (array[i] === valueOrPredicate) {
          return i;
        }
      }
    }

    return -1;
  },
  contains: function (array, valueOrPredicate) {
    return arrays.indexOf(array, valueOrPredicate) !== -1;
  },
  each: function (array, iterator) {
    var length = array.length,
        i;

    for (i = 0; i < length; i++) {
      iterator(array[i], i);
    }
  },
  map: function (array, iterator) {
    var length = array.length,
        result = new Array(length),
        i;

    for (i = 0; i < length; i++) {
      result[i] = iterator(array[i], i);
    }

    return result;
  },
  pluck: function (array, key) {
    return arrays.map(array, function (e) {
      return e[key];
    });
  },
  every: function (array, predicate) {
    var length = array.length,
        i;

    for (i = 0; i < length; i++) {
      if (!predicate(array[i])) {
        return false;
      }
    }

    return true;
  },
  some: function (array, predicate) {
    var length = array.length,
        i;

    for (i = 0; i < length; i++) {
      if (predicate(array[i])) {
        return true;
      }
    }

    return false;
  }
};
module.exports = arrays;
},{}],"1HYV":[function(require,module,exports) {
"use strict";
/* Object utilities. */

var objects = {
  keys: function (object) {
    var result = [],
        key;

    for (key in object) {
      if (object.hasOwnProperty(key)) {
        result.push(key);
      }
    }

    return result;
  },
  values: function (object) {
    var result = [],
        key;

    for (key in object) {
      if (object.hasOwnProperty(key)) {
        result.push(object[key]);
      }
    }

    return result;
  },
  clone: function (object) {
    var result = {},
        key;

    for (key in object) {
      if (object.hasOwnProperty(key)) {
        result[key] = object[key];
      }
    }

    return result;
  },
  defaults: function (object, defaults) {
    var key;

    for (key in defaults) {
      if (defaults.hasOwnProperty(key)) {
        if (!(key in object)) {
          object[key] = defaults[key];
        }
      }
    }
  }
};
module.exports = objects;
},{}],"d4UV":[function(require,module,exports) {
"use strict";
/* Class utilities */

var classes = {
  subclass: function (child, parent) {
    function ctor() {
      this.constructor = child;
    }

    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
  }
};
module.exports = classes;
},{}],"vvJ7":[function(require,module,exports) {
"use strict";

var classes = require("./utils/classes");
/* Thrown when the grammar contains an error. */


function GrammarError(message, location) {
  this.name = "GrammarError";
  this.message = message;
  this.location = location;

  if (typeof Error.captureStackTrace === "function") {
    Error.captureStackTrace(this, GrammarError);
  }
}

classes.subclass(GrammarError, Error);
module.exports = GrammarError;
},{"./utils/classes":"d4UV"}],"Wwef":[function(require,module,exports) {
/* eslint-env node, amd */

/* eslint no-unused-vars: 0 */

/*
 * Generated by PEG.js 0.10.0.
 *
 * http://pegjs.org/
 */
"use strict";

function peg$subclass(child, parent) {
  function ctor() {
    this.constructor = child;
  }

  ctor.prototype = parent.prototype;
  child.prototype = new ctor();
}

function peg$SyntaxError(message, expected, found, location) {
  this.message = message;
  this.expected = expected;
  this.found = found;
  this.location = location;
  this.name = "SyntaxError";

  if (typeof Error.captureStackTrace === "function") {
    Error.captureStackTrace(this, peg$SyntaxError);
  }
}

peg$subclass(peg$SyntaxError, Error);

peg$SyntaxError.buildMessage = function (expected, found) {
  var DESCRIBE_EXPECTATION_FNS = {
    literal: function (expectation) {
      return "\"" + literalEscape(expectation.text) + "\"";
    },
    "class": function (expectation) {
      var escapedParts = "",
          i;

      for (i = 0; i < expectation.parts.length; i++) {
        escapedParts += expectation.parts[i] instanceof Array ? classEscape(expectation.parts[i][0]) + "-" + classEscape(expectation.parts[i][1]) : classEscape(expectation.parts[i]);
      }

      return "[" + (expectation.inverted ? "^" : "") + escapedParts + "]";
    },
    any: function (expectation) {
      return "any character";
    },
    end: function (expectation) {
      return "end of input";
    },
    other: function (expectation) {
      return expectation.description;
    }
  };

  function hex(ch) {
    return ch.charCodeAt(0).toString(16).toUpperCase();
  }

  function literalEscape(s) {
    return s.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\0/g, '\\0').replace(/\t/g, '\\t').replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/[\x00-\x0F]/g, function (ch) {
      return '\\x0' + hex(ch);
    }).replace(/[\x10-\x1F\x7F-\x9F]/g, function (ch) {
      return '\\x' + hex(ch);
    });
  }

  function classEscape(s) {
    return s.replace(/\\/g, '\\\\').replace(/\]/g, '\\]').replace(/\^/g, '\\^').replace(/-/g, '\\-').replace(/\0/g, '\\0').replace(/\t/g, '\\t').replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/[\x00-\x0F]/g, function (ch) {
      return '\\x0' + hex(ch);
    }).replace(/[\x10-\x1F\x7F-\x9F]/g, function (ch) {
      return '\\x' + hex(ch);
    });
  }

  function describeExpectation(expectation) {
    return DESCRIBE_EXPECTATION_FNS[expectation.type](expectation);
  }

  function describeExpected(expected) {
    var descriptions = new Array(expected.length),
        i,
        j;

    for (i = 0; i < expected.length; i++) {
      descriptions[i] = describeExpectation(expected[i]);
    }

    descriptions.sort();

    if (descriptions.length > 0) {
      for (i = 1, j = 1; i < descriptions.length; i++) {
        if (descriptions[i - 1] !== descriptions[i]) {
          descriptions[j] = descriptions[i];
          j++;
        }
      }

      descriptions.length = j;
    }

    switch (descriptions.length) {
      case 1:
        return descriptions[0];

      case 2:
        return descriptions[0] + " or " + descriptions[1];

      default:
        return descriptions.slice(0, -1).join(", ") + ", or " + descriptions[descriptions.length - 1];
    }
  }

  function describeFound(found) {
    return found ? "\"" + literalEscape(found) + "\"" : "end of input";
  }

  return "Expected " + describeExpected(expected) + " but " + describeFound(found) + " found.";
};

function peg$parse(input, options) {
  options = options !== void 0 ? options : {};

  var peg$FAILED = {},
      peg$startRuleFunctions = {
    Grammar: peg$parseGrammar
  },
      peg$startRuleFunction = peg$parseGrammar,
      peg$c0 = function (initializer, rules) {
    return {
      type: "grammar",
      initializer: extractOptional(initializer, 0),
      rules: extractList(rules, 0),
      location: location()
    };
  },
      peg$c1 = function (code) {
    return {
      type: "initializer",
      code: code,
      location: location()
    };
  },
      peg$c2 = "=",
      peg$c3 = peg$literalExpectation("=", false),
      peg$c4 = function (name, displayName, expression) {
    return {
      type: "rule",
      name: name,
      expression: displayName !== null ? {
        type: "named",
        name: displayName[0],
        expression: expression,
        location: location()
      } : expression,
      location: location()
    };
  },
      peg$c5 = "/",
      peg$c6 = peg$literalExpectation("/", false),
      peg$c7 = function (head, tail) {
    return tail.length > 0 ? {
      type: "choice",
      alternatives: buildList(head, tail, 3),
      location: location()
    } : head;
  },
      peg$c8 = function (expression, code) {
    return code !== null ? {
      type: "action",
      expression: expression,
      code: code[1],
      location: location()
    } : expression;
  },
      peg$c9 = function (head, tail) {
    return tail.length > 0 ? {
      type: "sequence",
      elements: buildList(head, tail, 1),
      location: location()
    } : head;
  },
      peg$c10 = ":",
      peg$c11 = peg$literalExpectation(":", false),
      peg$c12 = function (label, expression) {
    return {
      type: "labeled",
      label: label,
      expression: expression,
      location: location()
    };
  },
      peg$c13 = function (operator, expression) {
    return {
      type: OPS_TO_PREFIXED_TYPES[operator],
      expression: expression,
      location: location()
    };
  },
      peg$c14 = "$",
      peg$c15 = peg$literalExpectation("$", false),
      peg$c16 = "&",
      peg$c17 = peg$literalExpectation("&", false),
      peg$c18 = "!",
      peg$c19 = peg$literalExpectation("!", false),
      peg$c20 = function (expression, operator) {
    return {
      type: OPS_TO_SUFFIXED_TYPES[operator],
      expression: expression,
      location: location()
    };
  },
      peg$c21 = "?",
      peg$c22 = peg$literalExpectation("?", false),
      peg$c23 = "*",
      peg$c24 = peg$literalExpectation("*", false),
      peg$c25 = "+",
      peg$c26 = peg$literalExpectation("+", false),
      peg$c27 = "(",
      peg$c28 = peg$literalExpectation("(", false),
      peg$c29 = ")",
      peg$c30 = peg$literalExpectation(")", false),
      peg$c31 = function (expression) {
    /*
     * The purpose of the "group" AST node is just to isolate label scope. We
     * don't need to put it around nodes that can't contain any labels or
     * nodes that already isolate label scope themselves. This leaves us with
     * "labeled" and "sequence".
     */
    return expression.type === 'labeled' || expression.type === 'sequence' ? {
      type: "group",
      expression: expression
    } : expression;
  },
      peg$c32 = function (name) {
    return {
      type: "rule_ref",
      name: name,
      location: location()
    };
  },
      peg$c33 = function (operator, code) {
    return {
      type: OPS_TO_SEMANTIC_PREDICATE_TYPES[operator],
      code: code,
      location: location()
    };
  },
      peg$c34 = peg$anyExpectation(),
      peg$c35 = peg$otherExpectation("whitespace"),
      peg$c36 = "\t",
      peg$c37 = peg$literalExpectation("\t", false),
      peg$c38 = "\x0B",
      peg$c39 = peg$literalExpectation("\x0B", false),
      peg$c40 = "\f",
      peg$c41 = peg$literalExpectation("\f", false),
      peg$c42 = " ",
      peg$c43 = peg$literalExpectation(" ", false),
      peg$c44 = "\xA0",
      peg$c45 = peg$literalExpectation("\xA0", false),
      peg$c46 = "\uFEFF",
      peg$c47 = peg$literalExpectation("\uFEFF", false),
      peg$c48 = /^[\n\r\u2028\u2029]/,
      peg$c49 = peg$classExpectation(["\n", "\r", "\u2028", "\u2029"], false, false),
      peg$c50 = peg$otherExpectation("end of line"),
      peg$c51 = "\n",
      peg$c52 = peg$literalExpectation("\n", false),
      peg$c53 = "\r\n",
      peg$c54 = peg$literalExpectation("\r\n", false),
      peg$c55 = "\r",
      peg$c56 = peg$literalExpectation("\r", false),
      peg$c57 = "\u2028",
      peg$c58 = peg$literalExpectation("\u2028", false),
      peg$c59 = "\u2029",
      peg$c60 = peg$literalExpectation("\u2029", false),
      peg$c61 = peg$otherExpectation("comment"),
      peg$c62 = "/*",
      peg$c63 = peg$literalExpectation("/*", false),
      peg$c64 = "*/",
      peg$c65 = peg$literalExpectation("*/", false),
      peg$c66 = "//",
      peg$c67 = peg$literalExpectation("//", false),
      peg$c68 = function (name) {
    return name;
  },
      peg$c69 = peg$otherExpectation("identifier"),
      peg$c70 = function (head, tail) {
    return head + tail.join("");
  },
      peg$c71 = "_",
      peg$c72 = peg$literalExpectation("_", false),
      peg$c73 = "\\",
      peg$c74 = peg$literalExpectation("\\", false),
      peg$c75 = function (sequence) {
    return sequence;
  },
      peg$c76 = "\u200C",
      peg$c77 = peg$literalExpectation("\u200C", false),
      peg$c78 = "\u200D",
      peg$c79 = peg$literalExpectation("\u200D", false),
      peg$c80 = peg$otherExpectation("literal"),
      peg$c81 = "i",
      peg$c82 = peg$literalExpectation("i", false),
      peg$c83 = function (value, ignoreCase) {
    return {
      type: "literal",
      value: value,
      ignoreCase: ignoreCase !== null,
      location: location()
    };
  },
      peg$c84 = peg$otherExpectation("string"),
      peg$c85 = "\"",
      peg$c86 = peg$literalExpectation("\"", false),
      peg$c87 = function (chars) {
    return chars.join("");
  },
      peg$c88 = "'",
      peg$c89 = peg$literalExpectation("'", false),
      peg$c90 = function () {
    return text();
  },
      peg$c91 = peg$otherExpectation("character class"),
      peg$c92 = "[",
      peg$c93 = peg$literalExpectation("[", false),
      peg$c94 = "^",
      peg$c95 = peg$literalExpectation("^", false),
      peg$c96 = "]",
      peg$c97 = peg$literalExpectation("]", false),
      peg$c98 = function (inverted, parts, ignoreCase) {
    return {
      type: "class",
      parts: filterEmptyStrings(parts),
      inverted: inverted !== null,
      ignoreCase: ignoreCase !== null,
      location: location()
    };
  },
      peg$c99 = "-",
      peg$c100 = peg$literalExpectation("-", false),
      peg$c101 = function (begin, end) {
    if (begin.charCodeAt(0) > end.charCodeAt(0)) {
      error("Invalid character range: " + text() + ".");
    }

    return [begin, end];
  },
      peg$c102 = function () {
    return "";
  },
      peg$c103 = "0",
      peg$c104 = peg$literalExpectation("0", false),
      peg$c105 = function () {
    return "\0";
  },
      peg$c106 = "b",
      peg$c107 = peg$literalExpectation("b", false),
      peg$c108 = function () {
    return "\b";
  },
      peg$c109 = "f",
      peg$c110 = peg$literalExpectation("f", false),
      peg$c111 = function () {
    return "\f";
  },
      peg$c112 = "n",
      peg$c113 = peg$literalExpectation("n", false),
      peg$c114 = function () {
    return "\n";
  },
      peg$c115 = "r",
      peg$c116 = peg$literalExpectation("r", false),
      peg$c117 = function () {
    return "\r";
  },
      peg$c118 = "t",
      peg$c119 = peg$literalExpectation("t", false),
      peg$c120 = function () {
    return "\t";
  },
      peg$c121 = "v",
      peg$c122 = peg$literalExpectation("v", false),
      peg$c123 = function () {
    return "\x0B";
  },
      peg$c124 = "x",
      peg$c125 = peg$literalExpectation("x", false),
      peg$c126 = "u",
      peg$c127 = peg$literalExpectation("u", false),
      peg$c128 = function (digits) {
    return String.fromCharCode(parseInt(digits, 16));
  },
      peg$c129 = /^[0-9]/,
      peg$c130 = peg$classExpectation([["0", "9"]], false, false),
      peg$c131 = /^[0-9a-f]/i,
      peg$c132 = peg$classExpectation([["0", "9"], ["a", "f"]], false, true),
      peg$c133 = ".",
      peg$c134 = peg$literalExpectation(".", false),
      peg$c135 = function () {
    return {
      type: "any",
      location: location()
    };
  },
      peg$c136 = peg$otherExpectation("code block"),
      peg$c137 = "{",
      peg$c138 = peg$literalExpectation("{", false),
      peg$c139 = "}",
      peg$c140 = peg$literalExpectation("}", false),
      peg$c141 = function (code) {
    return code;
  },
      peg$c142 = /^[{}]/,
      peg$c143 = peg$classExpectation(["{", "}"], false, false),
      peg$c144 = /^[a-z\xB5\xDF-\xF6\xF8-\xFF\u0101\u0103\u0105\u0107\u0109\u010B\u010D\u010F\u0111\u0113\u0115\u0117\u0119\u011B\u011D\u011F\u0121\u0123\u0125\u0127\u0129\u012B\u012D\u012F\u0131\u0133\u0135\u0137-\u0138\u013A\u013C\u013E\u0140\u0142\u0144\u0146\u0148-\u0149\u014B\u014D\u014F\u0151\u0153\u0155\u0157\u0159\u015B\u015D\u015F\u0161\u0163\u0165\u0167\u0169\u016B\u016D\u016F\u0171\u0173\u0175\u0177\u017A\u017C\u017E-\u0180\u0183\u0185\u0188\u018C-\u018D\u0192\u0195\u0199-\u019B\u019E\u01A1\u01A3\u01A5\u01A8\u01AA-\u01AB\u01AD\u01B0\u01B4\u01B6\u01B9-\u01BA\u01BD-\u01BF\u01C6\u01C9\u01CC\u01CE\u01D0\u01D2\u01D4\u01D6\u01D8\u01DA\u01DC-\u01DD\u01DF\u01E1\u01E3\u01E5\u01E7\u01E9\u01EB\u01ED\u01EF-\u01F0\u01F3\u01F5\u01F9\u01FB\u01FD\u01FF\u0201\u0203\u0205\u0207\u0209\u020B\u020D\u020F\u0211\u0213\u0215\u0217\u0219\u021B\u021D\u021F\u0221\u0223\u0225\u0227\u0229\u022B\u022D\u022F\u0231\u0233-\u0239\u023C\u023F-\u0240\u0242\u0247\u0249\u024B\u024D\u024F-\u0293\u0295-\u02AF\u0371\u0373\u0377\u037B-\u037D\u0390\u03AC-\u03CE\u03D0-\u03D1\u03D5-\u03D7\u03D9\u03DB\u03DD\u03DF\u03E1\u03E3\u03E5\u03E7\u03E9\u03EB\u03ED\u03EF-\u03F3\u03F5\u03F8\u03FB-\u03FC\u0430-\u045F\u0461\u0463\u0465\u0467\u0469\u046B\u046D\u046F\u0471\u0473\u0475\u0477\u0479\u047B\u047D\u047F\u0481\u048B\u048D\u048F\u0491\u0493\u0495\u0497\u0499\u049B\u049D\u049F\u04A1\u04A3\u04A5\u04A7\u04A9\u04AB\u04AD\u04AF\u04B1\u04B3\u04B5\u04B7\u04B9\u04BB\u04BD\u04BF\u04C2\u04C4\u04C6\u04C8\u04CA\u04CC\u04CE-\u04CF\u04D1\u04D3\u04D5\u04D7\u04D9\u04DB\u04DD\u04DF\u04E1\u04E3\u04E5\u04E7\u04E9\u04EB\u04ED\u04EF\u04F1\u04F3\u04F5\u04F7\u04F9\u04FB\u04FD\u04FF\u0501\u0503\u0505\u0507\u0509\u050B\u050D\u050F\u0511\u0513\u0515\u0517\u0519\u051B\u051D\u051F\u0521\u0523\u0525\u0527\u0529\u052B\u052D\u052F\u0561-\u0587\u13F8-\u13FD\u1D00-\u1D2B\u1D6B-\u1D77\u1D79-\u1D9A\u1E01\u1E03\u1E05\u1E07\u1E09\u1E0B\u1E0D\u1E0F\u1E11\u1E13\u1E15\u1E17\u1E19\u1E1B\u1E1D\u1E1F\u1E21\u1E23\u1E25\u1E27\u1E29\u1E2B\u1E2D\u1E2F\u1E31\u1E33\u1E35\u1E37\u1E39\u1E3B\u1E3D\u1E3F\u1E41\u1E43\u1E45\u1E47\u1E49\u1E4B\u1E4D\u1E4F\u1E51\u1E53\u1E55\u1E57\u1E59\u1E5B\u1E5D\u1E5F\u1E61\u1E63\u1E65\u1E67\u1E69\u1E6B\u1E6D\u1E6F\u1E71\u1E73\u1E75\u1E77\u1E79\u1E7B\u1E7D\u1E7F\u1E81\u1E83\u1E85\u1E87\u1E89\u1E8B\u1E8D\u1E8F\u1E91\u1E93\u1E95-\u1E9D\u1E9F\u1EA1\u1EA3\u1EA5\u1EA7\u1EA9\u1EAB\u1EAD\u1EAF\u1EB1\u1EB3\u1EB5\u1EB7\u1EB9\u1EBB\u1EBD\u1EBF\u1EC1\u1EC3\u1EC5\u1EC7\u1EC9\u1ECB\u1ECD\u1ECF\u1ED1\u1ED3\u1ED5\u1ED7\u1ED9\u1EDB\u1EDD\u1EDF\u1EE1\u1EE3\u1EE5\u1EE7\u1EE9\u1EEB\u1EED\u1EEF\u1EF1\u1EF3\u1EF5\u1EF7\u1EF9\u1EFB\u1EFD\u1EFF-\u1F07\u1F10-\u1F15\u1F20-\u1F27\u1F30-\u1F37\u1F40-\u1F45\u1F50-\u1F57\u1F60-\u1F67\u1F70-\u1F7D\u1F80-\u1F87\u1F90-\u1F97\u1FA0-\u1FA7\u1FB0-\u1FB4\u1FB6-\u1FB7\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FC7\u1FD0-\u1FD3\u1FD6-\u1FD7\u1FE0-\u1FE7\u1FF2-\u1FF4\u1FF6-\u1FF7\u210A\u210E-\u210F\u2113\u212F\u2134\u2139\u213C-\u213D\u2146-\u2149\u214E\u2184\u2C30-\u2C5E\u2C61\u2C65-\u2C66\u2C68\u2C6A\u2C6C\u2C71\u2C73-\u2C74\u2C76-\u2C7B\u2C81\u2C83\u2C85\u2C87\u2C89\u2C8B\u2C8D\u2C8F\u2C91\u2C93\u2C95\u2C97\u2C99\u2C9B\u2C9D\u2C9F\u2CA1\u2CA3\u2CA5\u2CA7\u2CA9\u2CAB\u2CAD\u2CAF\u2CB1\u2CB3\u2CB5\u2CB7\u2CB9\u2CBB\u2CBD\u2CBF\u2CC1\u2CC3\u2CC5\u2CC7\u2CC9\u2CCB\u2CCD\u2CCF\u2CD1\u2CD3\u2CD5\u2CD7\u2CD9\u2CDB\u2CDD\u2CDF\u2CE1\u2CE3-\u2CE4\u2CEC\u2CEE\u2CF3\u2D00-\u2D25\u2D27\u2D2D\uA641\uA643\uA645\uA647\uA649\uA64B\uA64D\uA64F\uA651\uA653\uA655\uA657\uA659\uA65B\uA65D\uA65F\uA661\uA663\uA665\uA667\uA669\uA66B\uA66D\uA681\uA683\uA685\uA687\uA689\uA68B\uA68D\uA68F\uA691\uA693\uA695\uA697\uA699\uA69B\uA723\uA725\uA727\uA729\uA72B\uA72D\uA72F-\uA731\uA733\uA735\uA737\uA739\uA73B\uA73D\uA73F\uA741\uA743\uA745\uA747\uA749\uA74B\uA74D\uA74F\uA751\uA753\uA755\uA757\uA759\uA75B\uA75D\uA75F\uA761\uA763\uA765\uA767\uA769\uA76B\uA76D\uA76F\uA771-\uA778\uA77A\uA77C\uA77F\uA781\uA783\uA785\uA787\uA78C\uA78E\uA791\uA793-\uA795\uA797\uA799\uA79B\uA79D\uA79F\uA7A1\uA7A3\uA7A5\uA7A7\uA7A9\uA7B5\uA7B7\uA7FA\uAB30-\uAB5A\uAB60-\uAB65\uAB70-\uABBF\uFB00-\uFB06\uFB13-\uFB17\uFF41-\uFF5A]/,
      peg$c145 = peg$classExpectation([["a", "z"], "\xB5", ["\xDF", "\xF6"], ["\xF8", "\xFF"], "\u0101", "\u0103", "\u0105", "\u0107", "\u0109", "\u010B", "\u010D", "\u010F", "\u0111", "\u0113", "\u0115", "\u0117", "\u0119", "\u011B", "\u011D", "\u011F", "\u0121", "\u0123", "\u0125", "\u0127", "\u0129", "\u012B", "\u012D", "\u012F", "\u0131", "\u0133", "\u0135", ["\u0137", "\u0138"], "\u013A", "\u013C", "\u013E", "\u0140", "\u0142", "\u0144", "\u0146", ["\u0148", "\u0149"], "\u014B", "\u014D", "\u014F", "\u0151", "\u0153", "\u0155", "\u0157", "\u0159", "\u015B", "\u015D", "\u015F", "\u0161", "\u0163", "\u0165", "\u0167", "\u0169", "\u016B", "\u016D", "\u016F", "\u0171", "\u0173", "\u0175", "\u0177", "\u017A", "\u017C", ["\u017E", "\u0180"], "\u0183", "\u0185", "\u0188", ["\u018C", "\u018D"], "\u0192", "\u0195", ["\u0199", "\u019B"], "\u019E", "\u01A1", "\u01A3", "\u01A5", "\u01A8", ["\u01AA", "\u01AB"], "\u01AD", "\u01B0", "\u01B4", "\u01B6", ["\u01B9", "\u01BA"], ["\u01BD", "\u01BF"], "\u01C6", "\u01C9", "\u01CC", "\u01CE", "\u01D0", "\u01D2", "\u01D4", "\u01D6", "\u01D8", "\u01DA", ["\u01DC", "\u01DD"], "\u01DF", "\u01E1", "\u01E3", "\u01E5", "\u01E7", "\u01E9", "\u01EB", "\u01ED", ["\u01EF", "\u01F0"], "\u01F3", "\u01F5", "\u01F9", "\u01FB", "\u01FD", "\u01FF", "\u0201", "\u0203", "\u0205", "\u0207", "\u0209", "\u020B", "\u020D", "\u020F", "\u0211", "\u0213", "\u0215", "\u0217", "\u0219", "\u021B", "\u021D", "\u021F", "\u0221", "\u0223", "\u0225", "\u0227", "\u0229", "\u022B", "\u022D", "\u022F", "\u0231", ["\u0233", "\u0239"], "\u023C", ["\u023F", "\u0240"], "\u0242", "\u0247", "\u0249", "\u024B", "\u024D", ["\u024F", "\u0293"], ["\u0295", "\u02AF"], "\u0371", "\u0373", "\u0377", ["\u037B", "\u037D"], "\u0390", ["\u03AC", "\u03CE"], ["\u03D0", "\u03D1"], ["\u03D5", "\u03D7"], "\u03D9", "\u03DB", "\u03DD", "\u03DF", "\u03E1", "\u03E3", "\u03E5", "\u03E7", "\u03E9", "\u03EB", "\u03ED", ["\u03EF", "\u03F3"], "\u03F5", "\u03F8", ["\u03FB", "\u03FC"], ["\u0430", "\u045F"], "\u0461", "\u0463", "\u0465", "\u0467", "\u0469", "\u046B", "\u046D", "\u046F", "\u0471", "\u0473", "\u0475", "\u0477", "\u0479", "\u047B", "\u047D", "\u047F", "\u0481", "\u048B", "\u048D", "\u048F", "\u0491", "\u0493", "\u0495", "\u0497", "\u0499", "\u049B", "\u049D", "\u049F", "\u04A1", "\u04A3", "\u04A5", "\u04A7", "\u04A9", "\u04AB", "\u04AD", "\u04AF", "\u04B1", "\u04B3", "\u04B5", "\u04B7", "\u04B9", "\u04BB", "\u04BD", "\u04BF", "\u04C2", "\u04C4", "\u04C6", "\u04C8", "\u04CA", "\u04CC", ["\u04CE", "\u04CF"], "\u04D1", "\u04D3", "\u04D5", "\u04D7", "\u04D9", "\u04DB", "\u04DD", "\u04DF", "\u04E1", "\u04E3", "\u04E5", "\u04E7", "\u04E9", "\u04EB", "\u04ED", "\u04EF", "\u04F1", "\u04F3", "\u04F5", "\u04F7", "\u04F9", "\u04FB", "\u04FD", "\u04FF", "\u0501", "\u0503", "\u0505", "\u0507", "\u0509", "\u050B", "\u050D", "\u050F", "\u0511", "\u0513", "\u0515", "\u0517", "\u0519", "\u051B", "\u051D", "\u051F", "\u0521", "\u0523", "\u0525", "\u0527", "\u0529", "\u052B", "\u052D", "\u052F", ["\u0561", "\u0587"], ["\u13F8", "\u13FD"], ["\u1D00", "\u1D2B"], ["\u1D6B", "\u1D77"], ["\u1D79", "\u1D9A"], "\u1E01", "\u1E03", "\u1E05", "\u1E07", "\u1E09", "\u1E0B", "\u1E0D", "\u1E0F", "\u1E11", "\u1E13", "\u1E15", "\u1E17", "\u1E19", "\u1E1B", "\u1E1D", "\u1E1F", "\u1E21", "\u1E23", "\u1E25", "\u1E27", "\u1E29", "\u1E2B", "\u1E2D", "\u1E2F", "\u1E31", "\u1E33", "\u1E35", "\u1E37", "\u1E39", "\u1E3B", "\u1E3D", "\u1E3F", "\u1E41", "\u1E43", "\u1E45", "\u1E47", "\u1E49", "\u1E4B", "\u1E4D", "\u1E4F", "\u1E51", "\u1E53", "\u1E55", "\u1E57", "\u1E59", "\u1E5B", "\u1E5D", "\u1E5F", "\u1E61", "\u1E63", "\u1E65", "\u1E67", "\u1E69", "\u1E6B", "\u1E6D", "\u1E6F", "\u1E71", "\u1E73", "\u1E75", "\u1E77", "\u1E79", "\u1E7B", "\u1E7D", "\u1E7F", "\u1E81", "\u1E83", "\u1E85", "\u1E87", "\u1E89", "\u1E8B", "\u1E8D", "\u1E8F", "\u1E91", "\u1E93", ["\u1E95", "\u1E9D"], "\u1E9F", "\u1EA1", "\u1EA3", "\u1EA5", "\u1EA7", "\u1EA9", "\u1EAB", "\u1EAD", "\u1EAF", "\u1EB1", "\u1EB3", "\u1EB5", "\u1EB7", "\u1EB9", "\u1EBB", "\u1EBD", "\u1EBF", "\u1EC1", "\u1EC3", "\u1EC5", "\u1EC7", "\u1EC9", "\u1ECB", "\u1ECD", "\u1ECF", "\u1ED1", "\u1ED3", "\u1ED5", "\u1ED7", "\u1ED9", "\u1EDB", "\u1EDD", "\u1EDF", "\u1EE1", "\u1EE3", "\u1EE5", "\u1EE7", "\u1EE9", "\u1EEB", "\u1EED", "\u1EEF", "\u1EF1", "\u1EF3", "\u1EF5", "\u1EF7", "\u1EF9", "\u1EFB", "\u1EFD", ["\u1EFF", "\u1F07"], ["\u1F10", "\u1F15"], ["\u1F20", "\u1F27"], ["\u1F30", "\u1F37"], ["\u1F40", "\u1F45"], ["\u1F50", "\u1F57"], ["\u1F60", "\u1F67"], ["\u1F70", "\u1F7D"], ["\u1F80", "\u1F87"], ["\u1F90", "\u1F97"], ["\u1FA0", "\u1FA7"], ["\u1FB0", "\u1FB4"], ["\u1FB6", "\u1FB7"], "\u1FBE", ["\u1FC2", "\u1FC4"], ["\u1FC6", "\u1FC7"], ["\u1FD0", "\u1FD3"], ["\u1FD6", "\u1FD7"], ["\u1FE0", "\u1FE7"], ["\u1FF2", "\u1FF4"], ["\u1FF6", "\u1FF7"], "\u210A", ["\u210E", "\u210F"], "\u2113", "\u212F", "\u2134", "\u2139", ["\u213C", "\u213D"], ["\u2146", "\u2149"], "\u214E", "\u2184", ["\u2C30", "\u2C5E"], "\u2C61", ["\u2C65", "\u2C66"], "\u2C68", "\u2C6A", "\u2C6C", "\u2C71", ["\u2C73", "\u2C74"], ["\u2C76", "\u2C7B"], "\u2C81", "\u2C83", "\u2C85", "\u2C87", "\u2C89", "\u2C8B", "\u2C8D", "\u2C8F", "\u2C91", "\u2C93", "\u2C95", "\u2C97", "\u2C99", "\u2C9B", "\u2C9D", "\u2C9F", "\u2CA1", "\u2CA3", "\u2CA5", "\u2CA7", "\u2CA9", "\u2CAB", "\u2CAD", "\u2CAF", "\u2CB1", "\u2CB3", "\u2CB5", "\u2CB7", "\u2CB9", "\u2CBB", "\u2CBD", "\u2CBF", "\u2CC1", "\u2CC3", "\u2CC5", "\u2CC7", "\u2CC9", "\u2CCB", "\u2CCD", "\u2CCF", "\u2CD1", "\u2CD3", "\u2CD5", "\u2CD7", "\u2CD9", "\u2CDB", "\u2CDD", "\u2CDF", "\u2CE1", ["\u2CE3", "\u2CE4"], "\u2CEC", "\u2CEE", "\u2CF3", ["\u2D00", "\u2D25"], "\u2D27", "\u2D2D", "\uA641", "\uA643", "\uA645", "\uA647", "\uA649", "\uA64B", "\uA64D", "\uA64F", "\uA651", "\uA653", "\uA655", "\uA657", "\uA659", "\uA65B", "\uA65D", "\uA65F", "\uA661", "\uA663", "\uA665", "\uA667", "\uA669", "\uA66B", "\uA66D", "\uA681", "\uA683", "\uA685", "\uA687", "\uA689", "\uA68B", "\uA68D", "\uA68F", "\uA691", "\uA693", "\uA695", "\uA697", "\uA699", "\uA69B", "\uA723", "\uA725", "\uA727", "\uA729", "\uA72B", "\uA72D", ["\uA72F", "\uA731"], "\uA733", "\uA735", "\uA737", "\uA739", "\uA73B", "\uA73D", "\uA73F", "\uA741", "\uA743", "\uA745", "\uA747", "\uA749", "\uA74B", "\uA74D", "\uA74F", "\uA751", "\uA753", "\uA755", "\uA757", "\uA759", "\uA75B", "\uA75D", "\uA75F", "\uA761", "\uA763", "\uA765", "\uA767", "\uA769", "\uA76B", "\uA76D", "\uA76F", ["\uA771", "\uA778"], "\uA77A", "\uA77C", "\uA77F", "\uA781", "\uA783", "\uA785", "\uA787", "\uA78C", "\uA78E", "\uA791", ["\uA793", "\uA795"], "\uA797", "\uA799", "\uA79B", "\uA79D", "\uA79F", "\uA7A1", "\uA7A3", "\uA7A5", "\uA7A7", "\uA7A9", "\uA7B5", "\uA7B7", "\uA7FA", ["\uAB30", "\uAB5A"], ["\uAB60", "\uAB65"], ["\uAB70", "\uABBF"], ["\uFB00", "\uFB06"], ["\uFB13", "\uFB17"], ["\uFF41", "\uFF5A"]], false, false),
      peg$c146 = /^[\u02B0-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0374\u037A\u0559\u0640\u06E5-\u06E6\u07F4-\u07F5\u07FA\u081A\u0824\u0828\u0971\u0E46\u0EC6\u10FC\u17D7\u1843\u1AA7\u1C78-\u1C7D\u1D2C-\u1D6A\u1D78\u1D9B-\u1DBF\u2071\u207F\u2090-\u209C\u2C7C-\u2C7D\u2D6F\u2E2F\u3005\u3031-\u3035\u303B\u309D-\u309E\u30FC-\u30FE\uA015\uA4F8-\uA4FD\uA60C\uA67F\uA69C-\uA69D\uA717-\uA71F\uA770\uA788\uA7F8-\uA7F9\uA9CF\uA9E6\uAA70\uAADD\uAAF3-\uAAF4\uAB5C-\uAB5F\uFF70\uFF9E-\uFF9F]/,
      peg$c147 = peg$classExpectation([["\u02B0", "\u02C1"], ["\u02C6", "\u02D1"], ["\u02E0", "\u02E4"], "\u02EC", "\u02EE", "\u0374", "\u037A", "\u0559", "\u0640", ["\u06E5", "\u06E6"], ["\u07F4", "\u07F5"], "\u07FA", "\u081A", "\u0824", "\u0828", "\u0971", "\u0E46", "\u0EC6", "\u10FC", "\u17D7", "\u1843", "\u1AA7", ["\u1C78", "\u1C7D"], ["\u1D2C", "\u1D6A"], "\u1D78", ["\u1D9B", "\u1DBF"], "\u2071", "\u207F", ["\u2090", "\u209C"], ["\u2C7C", "\u2C7D"], "\u2D6F", "\u2E2F", "\u3005", ["\u3031", "\u3035"], "\u303B", ["\u309D", "\u309E"], ["\u30FC", "\u30FE"], "\uA015", ["\uA4F8", "\uA4FD"], "\uA60C", "\uA67F", ["\uA69C", "\uA69D"], ["\uA717", "\uA71F"], "\uA770", "\uA788", ["\uA7F8", "\uA7F9"], "\uA9CF", "\uA9E6", "\uAA70", "\uAADD", ["\uAAF3", "\uAAF4"], ["\uAB5C", "\uAB5F"], "\uFF70", ["\uFF9E", "\uFF9F"]], false, false),
      peg$c148 = /^[\xAA\xBA\u01BB\u01C0-\u01C3\u0294\u05D0-\u05EA\u05F0-\u05F2\u0620-\u063F\u0641-\u064A\u066E-\u066F\u0671-\u06D3\u06D5\u06EE-\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u0800-\u0815\u0840-\u0858\u08A0-\u08B4\u0904-\u0939\u093D\u0950\u0958-\u0961\u0972-\u0980\u0985-\u098C\u098F-\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC-\u09DD\u09DF-\u09E1\u09F0-\u09F1\u0A05-\u0A0A\u0A0F-\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32-\u0A33\u0A35-\u0A36\u0A38-\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2-\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0-\u0AE1\u0AF9\u0B05-\u0B0C\u0B0F-\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32-\u0B33\u0B35-\u0B39\u0B3D\u0B5C-\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99-\u0B9A\u0B9C\u0B9E-\u0B9F\u0BA3-\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C39\u0C3D\u0C58-\u0C5A\u0C60-\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0-\u0CE1\u0CF1-\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D5F-\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32-\u0E33\u0E40-\u0E45\u0E81-\u0E82\u0E84\u0E87-\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA-\u0EAB\u0EAD-\u0EB0\u0EB2-\u0EB3\u0EBD\u0EC0-\u0EC4\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065-\u1066\u106E-\u1070\u1075-\u1081\u108E\u10D0-\u10FA\u10FD-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u16F1-\u16F8\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17DC\u1820-\u1842\u1844-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191E\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19B0-\u19C9\u1A00-\u1A16\u1A20-\u1A54\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE-\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C77\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5-\u1CF6\u2135-\u2138\u2D30-\u2D67\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u3006\u303C\u3041-\u3096\u309F\u30A1-\u30FA\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FD5\uA000-\uA014\uA016-\uA48C\uA4D0-\uA4F7\uA500-\uA60B\uA610-\uA61F\uA62A-\uA62B\uA66E\uA6A0-\uA6E5\uA78F\uA7F7\uA7FB-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA8FD\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9E0-\uA9E4\uA9E7-\uA9EF\uA9FA-\uA9FE\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA6F\uAA71-\uAA76\uAA7A\uAA7E-\uAAAF\uAAB1\uAAB5-\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADC\uAAE0-\uAAEA\uAAF2\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40-\uFB41\uFB43-\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF66-\uFF6F\uFF71-\uFF9D\uFFA0-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]/,
      peg$c149 = peg$classExpectation(["\xAA", "\xBA", "\u01BB", ["\u01C0", "\u01C3"], "\u0294", ["\u05D0", "\u05EA"], ["\u05F0", "\u05F2"], ["\u0620", "\u063F"], ["\u0641", "\u064A"], ["\u066E", "\u066F"], ["\u0671", "\u06D3"], "\u06D5", ["\u06EE", "\u06EF"], ["\u06FA", "\u06FC"], "\u06FF", "\u0710", ["\u0712", "\u072F"], ["\u074D", "\u07A5"], "\u07B1", ["\u07CA", "\u07EA"], ["\u0800", "\u0815"], ["\u0840", "\u0858"], ["\u08A0", "\u08B4"], ["\u0904", "\u0939"], "\u093D", "\u0950", ["\u0958", "\u0961"], ["\u0972", "\u0980"], ["\u0985", "\u098C"], ["\u098F", "\u0990"], ["\u0993", "\u09A8"], ["\u09AA", "\u09B0"], "\u09B2", ["\u09B6", "\u09B9"], "\u09BD", "\u09CE", ["\u09DC", "\u09DD"], ["\u09DF", "\u09E1"], ["\u09F0", "\u09F1"], ["\u0A05", "\u0A0A"], ["\u0A0F", "\u0A10"], ["\u0A13", "\u0A28"], ["\u0A2A", "\u0A30"], ["\u0A32", "\u0A33"], ["\u0A35", "\u0A36"], ["\u0A38", "\u0A39"], ["\u0A59", "\u0A5C"], "\u0A5E", ["\u0A72", "\u0A74"], ["\u0A85", "\u0A8D"], ["\u0A8F", "\u0A91"], ["\u0A93", "\u0AA8"], ["\u0AAA", "\u0AB0"], ["\u0AB2", "\u0AB3"], ["\u0AB5", "\u0AB9"], "\u0ABD", "\u0AD0", ["\u0AE0", "\u0AE1"], "\u0AF9", ["\u0B05", "\u0B0C"], ["\u0B0F", "\u0B10"], ["\u0B13", "\u0B28"], ["\u0B2A", "\u0B30"], ["\u0B32", "\u0B33"], ["\u0B35", "\u0B39"], "\u0B3D", ["\u0B5C", "\u0B5D"], ["\u0B5F", "\u0B61"], "\u0B71", "\u0B83", ["\u0B85", "\u0B8A"], ["\u0B8E", "\u0B90"], ["\u0B92", "\u0B95"], ["\u0B99", "\u0B9A"], "\u0B9C", ["\u0B9E", "\u0B9F"], ["\u0BA3", "\u0BA4"], ["\u0BA8", "\u0BAA"], ["\u0BAE", "\u0BB9"], "\u0BD0", ["\u0C05", "\u0C0C"], ["\u0C0E", "\u0C10"], ["\u0C12", "\u0C28"], ["\u0C2A", "\u0C39"], "\u0C3D", ["\u0C58", "\u0C5A"], ["\u0C60", "\u0C61"], ["\u0C85", "\u0C8C"], ["\u0C8E", "\u0C90"], ["\u0C92", "\u0CA8"], ["\u0CAA", "\u0CB3"], ["\u0CB5", "\u0CB9"], "\u0CBD", "\u0CDE", ["\u0CE0", "\u0CE1"], ["\u0CF1", "\u0CF2"], ["\u0D05", "\u0D0C"], ["\u0D0E", "\u0D10"], ["\u0D12", "\u0D3A"], "\u0D3D", "\u0D4E", ["\u0D5F", "\u0D61"], ["\u0D7A", "\u0D7F"], ["\u0D85", "\u0D96"], ["\u0D9A", "\u0DB1"], ["\u0DB3", "\u0DBB"], "\u0DBD", ["\u0DC0", "\u0DC6"], ["\u0E01", "\u0E30"], ["\u0E32", "\u0E33"], ["\u0E40", "\u0E45"], ["\u0E81", "\u0E82"], "\u0E84", ["\u0E87", "\u0E88"], "\u0E8A", "\u0E8D", ["\u0E94", "\u0E97"], ["\u0E99", "\u0E9F"], ["\u0EA1", "\u0EA3"], "\u0EA5", "\u0EA7", ["\u0EAA", "\u0EAB"], ["\u0EAD", "\u0EB0"], ["\u0EB2", "\u0EB3"], "\u0EBD", ["\u0EC0", "\u0EC4"], ["\u0EDC", "\u0EDF"], "\u0F00", ["\u0F40", "\u0F47"], ["\u0F49", "\u0F6C"], ["\u0F88", "\u0F8C"], ["\u1000", "\u102A"], "\u103F", ["\u1050", "\u1055"], ["\u105A", "\u105D"], "\u1061", ["\u1065", "\u1066"], ["\u106E", "\u1070"], ["\u1075", "\u1081"], "\u108E", ["\u10D0", "\u10FA"], ["\u10FD", "\u1248"], ["\u124A", "\u124D"], ["\u1250", "\u1256"], "\u1258", ["\u125A", "\u125D"], ["\u1260", "\u1288"], ["\u128A", "\u128D"], ["\u1290", "\u12B0"], ["\u12B2", "\u12B5"], ["\u12B8", "\u12BE"], "\u12C0", ["\u12C2", "\u12C5"], ["\u12C8", "\u12D6"], ["\u12D8", "\u1310"], ["\u1312", "\u1315"], ["\u1318", "\u135A"], ["\u1380", "\u138F"], ["\u1401", "\u166C"], ["\u166F", "\u167F"], ["\u1681", "\u169A"], ["\u16A0", "\u16EA"], ["\u16F1", "\u16F8"], ["\u1700", "\u170C"], ["\u170E", "\u1711"], ["\u1720", "\u1731"], ["\u1740", "\u1751"], ["\u1760", "\u176C"], ["\u176E", "\u1770"], ["\u1780", "\u17B3"], "\u17DC", ["\u1820", "\u1842"], ["\u1844", "\u1877"], ["\u1880", "\u18A8"], "\u18AA", ["\u18B0", "\u18F5"], ["\u1900", "\u191E"], ["\u1950", "\u196D"], ["\u1970", "\u1974"], ["\u1980", "\u19AB"], ["\u19B0", "\u19C9"], ["\u1A00", "\u1A16"], ["\u1A20", "\u1A54"], ["\u1B05", "\u1B33"], ["\u1B45", "\u1B4B"], ["\u1B83", "\u1BA0"], ["\u1BAE", "\u1BAF"], ["\u1BBA", "\u1BE5"], ["\u1C00", "\u1C23"], ["\u1C4D", "\u1C4F"], ["\u1C5A", "\u1C77"], ["\u1CE9", "\u1CEC"], ["\u1CEE", "\u1CF1"], ["\u1CF5", "\u1CF6"], ["\u2135", "\u2138"], ["\u2D30", "\u2D67"], ["\u2D80", "\u2D96"], ["\u2DA0", "\u2DA6"], ["\u2DA8", "\u2DAE"], ["\u2DB0", "\u2DB6"], ["\u2DB8", "\u2DBE"], ["\u2DC0", "\u2DC6"], ["\u2DC8", "\u2DCE"], ["\u2DD0", "\u2DD6"], ["\u2DD8", "\u2DDE"], "\u3006", "\u303C", ["\u3041", "\u3096"], "\u309F", ["\u30A1", "\u30FA"], "\u30FF", ["\u3105", "\u312D"], ["\u3131", "\u318E"], ["\u31A0", "\u31BA"], ["\u31F0", "\u31FF"], ["\u3400", "\u4DB5"], ["\u4E00", "\u9FD5"], ["\uA000", "\uA014"], ["\uA016", "\uA48C"], ["\uA4D0", "\uA4F7"], ["\uA500", "\uA60B"], ["\uA610", "\uA61F"], ["\uA62A", "\uA62B"], "\uA66E", ["\uA6A0", "\uA6E5"], "\uA78F", "\uA7F7", ["\uA7FB", "\uA801"], ["\uA803", "\uA805"], ["\uA807", "\uA80A"], ["\uA80C", "\uA822"], ["\uA840", "\uA873"], ["\uA882", "\uA8B3"], ["\uA8F2", "\uA8F7"], "\uA8FB", "\uA8FD", ["\uA90A", "\uA925"], ["\uA930", "\uA946"], ["\uA960", "\uA97C"], ["\uA984", "\uA9B2"], ["\uA9E0", "\uA9E4"], ["\uA9E7", "\uA9EF"], ["\uA9FA", "\uA9FE"], ["\uAA00", "\uAA28"], ["\uAA40", "\uAA42"], ["\uAA44", "\uAA4B"], ["\uAA60", "\uAA6F"], ["\uAA71", "\uAA76"], "\uAA7A", ["\uAA7E", "\uAAAF"], "\uAAB1", ["\uAAB5", "\uAAB6"], ["\uAAB9", "\uAABD"], "\uAAC0", "\uAAC2", ["\uAADB", "\uAADC"], ["\uAAE0", "\uAAEA"], "\uAAF2", ["\uAB01", "\uAB06"], ["\uAB09", "\uAB0E"], ["\uAB11", "\uAB16"], ["\uAB20", "\uAB26"], ["\uAB28", "\uAB2E"], ["\uABC0", "\uABE2"], ["\uAC00", "\uD7A3"], ["\uD7B0", "\uD7C6"], ["\uD7CB", "\uD7FB"], ["\uF900", "\uFA6D"], ["\uFA70", "\uFAD9"], "\uFB1D", ["\uFB1F", "\uFB28"], ["\uFB2A", "\uFB36"], ["\uFB38", "\uFB3C"], "\uFB3E", ["\uFB40", "\uFB41"], ["\uFB43", "\uFB44"], ["\uFB46", "\uFBB1"], ["\uFBD3", "\uFD3D"], ["\uFD50", "\uFD8F"], ["\uFD92", "\uFDC7"], ["\uFDF0", "\uFDFB"], ["\uFE70", "\uFE74"], ["\uFE76", "\uFEFC"], ["\uFF66", "\uFF6F"], ["\uFF71", "\uFF9D"], ["\uFFA0", "\uFFBE"], ["\uFFC2", "\uFFC7"], ["\uFFCA", "\uFFCF"], ["\uFFD2", "\uFFD7"], ["\uFFDA", "\uFFDC"]], false, false),
      peg$c150 = /^[\u01C5\u01C8\u01CB\u01F2\u1F88-\u1F8F\u1F98-\u1F9F\u1FA8-\u1FAF\u1FBC\u1FCC\u1FFC]/,
      peg$c151 = peg$classExpectation(["\u01C5", "\u01C8", "\u01CB", "\u01F2", ["\u1F88", "\u1F8F"], ["\u1F98", "\u1F9F"], ["\u1FA8", "\u1FAF"], "\u1FBC", "\u1FCC", "\u1FFC"], false, false),
      peg$c152 = /^[A-Z\xC0-\xD6\xD8-\xDE\u0100\u0102\u0104\u0106\u0108\u010A\u010C\u010E\u0110\u0112\u0114\u0116\u0118\u011A\u011C\u011E\u0120\u0122\u0124\u0126\u0128\u012A\u012C\u012E\u0130\u0132\u0134\u0136\u0139\u013B\u013D\u013F\u0141\u0143\u0145\u0147\u014A\u014C\u014E\u0150\u0152\u0154\u0156\u0158\u015A\u015C\u015E\u0160\u0162\u0164\u0166\u0168\u016A\u016C\u016E\u0170\u0172\u0174\u0176\u0178-\u0179\u017B\u017D\u0181-\u0182\u0184\u0186-\u0187\u0189-\u018B\u018E-\u0191\u0193-\u0194\u0196-\u0198\u019C-\u019D\u019F-\u01A0\u01A2\u01A4\u01A6-\u01A7\u01A9\u01AC\u01AE-\u01AF\u01B1-\u01B3\u01B5\u01B7-\u01B8\u01BC\u01C4\u01C7\u01CA\u01CD\u01CF\u01D1\u01D3\u01D5\u01D7\u01D9\u01DB\u01DE\u01E0\u01E2\u01E4\u01E6\u01E8\u01EA\u01EC\u01EE\u01F1\u01F4\u01F6-\u01F8\u01FA\u01FC\u01FE\u0200\u0202\u0204\u0206\u0208\u020A\u020C\u020E\u0210\u0212\u0214\u0216\u0218\u021A\u021C\u021E\u0220\u0222\u0224\u0226\u0228\u022A\u022C\u022E\u0230\u0232\u023A-\u023B\u023D-\u023E\u0241\u0243-\u0246\u0248\u024A\u024C\u024E\u0370\u0372\u0376\u037F\u0386\u0388-\u038A\u038C\u038E-\u038F\u0391-\u03A1\u03A3-\u03AB\u03CF\u03D2-\u03D4\u03D8\u03DA\u03DC\u03DE\u03E0\u03E2\u03E4\u03E6\u03E8\u03EA\u03EC\u03EE\u03F4\u03F7\u03F9-\u03FA\u03FD-\u042F\u0460\u0462\u0464\u0466\u0468\u046A\u046C\u046E\u0470\u0472\u0474\u0476\u0478\u047A\u047C\u047E\u0480\u048A\u048C\u048E\u0490\u0492\u0494\u0496\u0498\u049A\u049C\u049E\u04A0\u04A2\u04A4\u04A6\u04A8\u04AA\u04AC\u04AE\u04B0\u04B2\u04B4\u04B6\u04B8\u04BA\u04BC\u04BE\u04C0-\u04C1\u04C3\u04C5\u04C7\u04C9\u04CB\u04CD\u04D0\u04D2\u04D4\u04D6\u04D8\u04DA\u04DC\u04DE\u04E0\u04E2\u04E4\u04E6\u04E8\u04EA\u04EC\u04EE\u04F0\u04F2\u04F4\u04F6\u04F8\u04FA\u04FC\u04FE\u0500\u0502\u0504\u0506\u0508\u050A\u050C\u050E\u0510\u0512\u0514\u0516\u0518\u051A\u051C\u051E\u0520\u0522\u0524\u0526\u0528\u052A\u052C\u052E\u0531-\u0556\u10A0-\u10C5\u10C7\u10CD\u13A0-\u13F5\u1E00\u1E02\u1E04\u1E06\u1E08\u1E0A\u1E0C\u1E0E\u1E10\u1E12\u1E14\u1E16\u1E18\u1E1A\u1E1C\u1E1E\u1E20\u1E22\u1E24\u1E26\u1E28\u1E2A\u1E2C\u1E2E\u1E30\u1E32\u1E34\u1E36\u1E38\u1E3A\u1E3C\u1E3E\u1E40\u1E42\u1E44\u1E46\u1E48\u1E4A\u1E4C\u1E4E\u1E50\u1E52\u1E54\u1E56\u1E58\u1E5A\u1E5C\u1E5E\u1E60\u1E62\u1E64\u1E66\u1E68\u1E6A\u1E6C\u1E6E\u1E70\u1E72\u1E74\u1E76\u1E78\u1E7A\u1E7C\u1E7E\u1E80\u1E82\u1E84\u1E86\u1E88\u1E8A\u1E8C\u1E8E\u1E90\u1E92\u1E94\u1E9E\u1EA0\u1EA2\u1EA4\u1EA6\u1EA8\u1EAA\u1EAC\u1EAE\u1EB0\u1EB2\u1EB4\u1EB6\u1EB8\u1EBA\u1EBC\u1EBE\u1EC0\u1EC2\u1EC4\u1EC6\u1EC8\u1ECA\u1ECC\u1ECE\u1ED0\u1ED2\u1ED4\u1ED6\u1ED8\u1EDA\u1EDC\u1EDE\u1EE0\u1EE2\u1EE4\u1EE6\u1EE8\u1EEA\u1EEC\u1EEE\u1EF0\u1EF2\u1EF4\u1EF6\u1EF8\u1EFA\u1EFC\u1EFE\u1F08-\u1F0F\u1F18-\u1F1D\u1F28-\u1F2F\u1F38-\u1F3F\u1F48-\u1F4D\u1F59\u1F5B\u1F5D\u1F5F\u1F68-\u1F6F\u1FB8-\u1FBB\u1FC8-\u1FCB\u1FD8-\u1FDB\u1FE8-\u1FEC\u1FF8-\u1FFB\u2102\u2107\u210B-\u210D\u2110-\u2112\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u2130-\u2133\u213E-\u213F\u2145\u2183\u2C00-\u2C2E\u2C60\u2C62-\u2C64\u2C67\u2C69\u2C6B\u2C6D-\u2C70\u2C72\u2C75\u2C7E-\u2C80\u2C82\u2C84\u2C86\u2C88\u2C8A\u2C8C\u2C8E\u2C90\u2C92\u2C94\u2C96\u2C98\u2C9A\u2C9C\u2C9E\u2CA0\u2CA2\u2CA4\u2CA6\u2CA8\u2CAA\u2CAC\u2CAE\u2CB0\u2CB2\u2CB4\u2CB6\u2CB8\u2CBA\u2CBC\u2CBE\u2CC0\u2CC2\u2CC4\u2CC6\u2CC8\u2CCA\u2CCC\u2CCE\u2CD0\u2CD2\u2CD4\u2CD6\u2CD8\u2CDA\u2CDC\u2CDE\u2CE0\u2CE2\u2CEB\u2CED\u2CF2\uA640\uA642\uA644\uA646\uA648\uA64A\uA64C\uA64E\uA650\uA652\uA654\uA656\uA658\uA65A\uA65C\uA65E\uA660\uA662\uA664\uA666\uA668\uA66A\uA66C\uA680\uA682\uA684\uA686\uA688\uA68A\uA68C\uA68E\uA690\uA692\uA694\uA696\uA698\uA69A\uA722\uA724\uA726\uA728\uA72A\uA72C\uA72E\uA732\uA734\uA736\uA738\uA73A\uA73C\uA73E\uA740\uA742\uA744\uA746\uA748\uA74A\uA74C\uA74E\uA750\uA752\uA754\uA756\uA758\uA75A\uA75C\uA75E\uA760\uA762\uA764\uA766\uA768\uA76A\uA76C\uA76E\uA779\uA77B\uA77D-\uA77E\uA780\uA782\uA784\uA786\uA78B\uA78D\uA790\uA792\uA796\uA798\uA79A\uA79C\uA79E\uA7A0\uA7A2\uA7A4\uA7A6\uA7A8\uA7AA-\uA7AD\uA7B0-\uA7B4\uA7B6\uFF21-\uFF3A]/,
      peg$c153 = peg$classExpectation([["A", "Z"], ["\xC0", "\xD6"], ["\xD8", "\xDE"], "\u0100", "\u0102", "\u0104", "\u0106", "\u0108", "\u010A", "\u010C", "\u010E", "\u0110", "\u0112", "\u0114", "\u0116", "\u0118", "\u011A", "\u011C", "\u011E", "\u0120", "\u0122", "\u0124", "\u0126", "\u0128", "\u012A", "\u012C", "\u012E", "\u0130", "\u0132", "\u0134", "\u0136", "\u0139", "\u013B", "\u013D", "\u013F", "\u0141", "\u0143", "\u0145", "\u0147", "\u014A", "\u014C", "\u014E", "\u0150", "\u0152", "\u0154", "\u0156", "\u0158", "\u015A", "\u015C", "\u015E", "\u0160", "\u0162", "\u0164", "\u0166", "\u0168", "\u016A", "\u016C", "\u016E", "\u0170", "\u0172", "\u0174", "\u0176", ["\u0178", "\u0179"], "\u017B", "\u017D", ["\u0181", "\u0182"], "\u0184", ["\u0186", "\u0187"], ["\u0189", "\u018B"], ["\u018E", "\u0191"], ["\u0193", "\u0194"], ["\u0196", "\u0198"], ["\u019C", "\u019D"], ["\u019F", "\u01A0"], "\u01A2", "\u01A4", ["\u01A6", "\u01A7"], "\u01A9", "\u01AC", ["\u01AE", "\u01AF"], ["\u01B1", "\u01B3"], "\u01B5", ["\u01B7", "\u01B8"], "\u01BC", "\u01C4", "\u01C7", "\u01CA", "\u01CD", "\u01CF", "\u01D1", "\u01D3", "\u01D5", "\u01D7", "\u01D9", "\u01DB", "\u01DE", "\u01E0", "\u01E2", "\u01E4", "\u01E6", "\u01E8", "\u01EA", "\u01EC", "\u01EE", "\u01F1", "\u01F4", ["\u01F6", "\u01F8"], "\u01FA", "\u01FC", "\u01FE", "\u0200", "\u0202", "\u0204", "\u0206", "\u0208", "\u020A", "\u020C", "\u020E", "\u0210", "\u0212", "\u0214", "\u0216", "\u0218", "\u021A", "\u021C", "\u021E", "\u0220", "\u0222", "\u0224", "\u0226", "\u0228", "\u022A", "\u022C", "\u022E", "\u0230", "\u0232", ["\u023A", "\u023B"], ["\u023D", "\u023E"], "\u0241", ["\u0243", "\u0246"], "\u0248", "\u024A", "\u024C", "\u024E", "\u0370", "\u0372", "\u0376", "\u037F", "\u0386", ["\u0388", "\u038A"], "\u038C", ["\u038E", "\u038F"], ["\u0391", "\u03A1"], ["\u03A3", "\u03AB"], "\u03CF", ["\u03D2", "\u03D4"], "\u03D8", "\u03DA", "\u03DC", "\u03DE", "\u03E0", "\u03E2", "\u03E4", "\u03E6", "\u03E8", "\u03EA", "\u03EC", "\u03EE", "\u03F4", "\u03F7", ["\u03F9", "\u03FA"], ["\u03FD", "\u042F"], "\u0460", "\u0462", "\u0464", "\u0466", "\u0468", "\u046A", "\u046C", "\u046E", "\u0470", "\u0472", "\u0474", "\u0476", "\u0478", "\u047A", "\u047C", "\u047E", "\u0480", "\u048A", "\u048C", "\u048E", "\u0490", "\u0492", "\u0494", "\u0496", "\u0498", "\u049A", "\u049C", "\u049E", "\u04A0", "\u04A2", "\u04A4", "\u04A6", "\u04A8", "\u04AA", "\u04AC", "\u04AE", "\u04B0", "\u04B2", "\u04B4", "\u04B6", "\u04B8", "\u04BA", "\u04BC", "\u04BE", ["\u04C0", "\u04C1"], "\u04C3", "\u04C5", "\u04C7", "\u04C9", "\u04CB", "\u04CD", "\u04D0", "\u04D2", "\u04D4", "\u04D6", "\u04D8", "\u04DA", "\u04DC", "\u04DE", "\u04E0", "\u04E2", "\u04E4", "\u04E6", "\u04E8", "\u04EA", "\u04EC", "\u04EE", "\u04F0", "\u04F2", "\u04F4", "\u04F6", "\u04F8", "\u04FA", "\u04FC", "\u04FE", "\u0500", "\u0502", "\u0504", "\u0506", "\u0508", "\u050A", "\u050C", "\u050E", "\u0510", "\u0512", "\u0514", "\u0516", "\u0518", "\u051A", "\u051C", "\u051E", "\u0520", "\u0522", "\u0524", "\u0526", "\u0528", "\u052A", "\u052C", "\u052E", ["\u0531", "\u0556"], ["\u10A0", "\u10C5"], "\u10C7", "\u10CD", ["\u13A0", "\u13F5"], "\u1E00", "\u1E02", "\u1E04", "\u1E06", "\u1E08", "\u1E0A", "\u1E0C", "\u1E0E", "\u1E10", "\u1E12", "\u1E14", "\u1E16", "\u1E18", "\u1E1A", "\u1E1C", "\u1E1E", "\u1E20", "\u1E22", "\u1E24", "\u1E26", "\u1E28", "\u1E2A", "\u1E2C", "\u1E2E", "\u1E30", "\u1E32", "\u1E34", "\u1E36", "\u1E38", "\u1E3A", "\u1E3C", "\u1E3E", "\u1E40", "\u1E42", "\u1E44", "\u1E46", "\u1E48", "\u1E4A", "\u1E4C", "\u1E4E", "\u1E50", "\u1E52", "\u1E54", "\u1E56", "\u1E58", "\u1E5A", "\u1E5C", "\u1E5E", "\u1E60", "\u1E62", "\u1E64", "\u1E66", "\u1E68", "\u1E6A", "\u1E6C", "\u1E6E", "\u1E70", "\u1E72", "\u1E74", "\u1E76", "\u1E78", "\u1E7A", "\u1E7C", "\u1E7E", "\u1E80", "\u1E82", "\u1E84", "\u1E86", "\u1E88", "\u1E8A", "\u1E8C", "\u1E8E", "\u1E90", "\u1E92", "\u1E94", "\u1E9E", "\u1EA0", "\u1EA2", "\u1EA4", "\u1EA6", "\u1EA8", "\u1EAA", "\u1EAC", "\u1EAE", "\u1EB0", "\u1EB2", "\u1EB4", "\u1EB6", "\u1EB8", "\u1EBA", "\u1EBC", "\u1EBE", "\u1EC0", "\u1EC2", "\u1EC4", "\u1EC6", "\u1EC8", "\u1ECA", "\u1ECC", "\u1ECE", "\u1ED0", "\u1ED2", "\u1ED4", "\u1ED6", "\u1ED8", "\u1EDA", "\u1EDC", "\u1EDE", "\u1EE0", "\u1EE2", "\u1EE4", "\u1EE6", "\u1EE8", "\u1EEA", "\u1EEC", "\u1EEE", "\u1EF0", "\u1EF2", "\u1EF4", "\u1EF6", "\u1EF8", "\u1EFA", "\u1EFC", "\u1EFE", ["\u1F08", "\u1F0F"], ["\u1F18", "\u1F1D"], ["\u1F28", "\u1F2F"], ["\u1F38", "\u1F3F"], ["\u1F48", "\u1F4D"], "\u1F59", "\u1F5B", "\u1F5D", "\u1F5F", ["\u1F68", "\u1F6F"], ["\u1FB8", "\u1FBB"], ["\u1FC8", "\u1FCB"], ["\u1FD8", "\u1FDB"], ["\u1FE8", "\u1FEC"], ["\u1FF8", "\u1FFB"], "\u2102", "\u2107", ["\u210B", "\u210D"], ["\u2110", "\u2112"], "\u2115", ["\u2119", "\u211D"], "\u2124", "\u2126", "\u2128", ["\u212A", "\u212D"], ["\u2130", "\u2133"], ["\u213E", "\u213F"], "\u2145", "\u2183", ["\u2C00", "\u2C2E"], "\u2C60", ["\u2C62", "\u2C64"], "\u2C67", "\u2C69", "\u2C6B", ["\u2C6D", "\u2C70"], "\u2C72", "\u2C75", ["\u2C7E", "\u2C80"], "\u2C82", "\u2C84", "\u2C86", "\u2C88", "\u2C8A", "\u2C8C", "\u2C8E", "\u2C90", "\u2C92", "\u2C94", "\u2C96", "\u2C98", "\u2C9A", "\u2C9C", "\u2C9E", "\u2CA0", "\u2CA2", "\u2CA4", "\u2CA6", "\u2CA8", "\u2CAA", "\u2CAC", "\u2CAE", "\u2CB0", "\u2CB2", "\u2CB4", "\u2CB6", "\u2CB8", "\u2CBA", "\u2CBC", "\u2CBE", "\u2CC0", "\u2CC2", "\u2CC4", "\u2CC6", "\u2CC8", "\u2CCA", "\u2CCC", "\u2CCE", "\u2CD0", "\u2CD2", "\u2CD4", "\u2CD6", "\u2CD8", "\u2CDA", "\u2CDC", "\u2CDE", "\u2CE0", "\u2CE2", "\u2CEB", "\u2CED", "\u2CF2", "\uA640", "\uA642", "\uA644", "\uA646", "\uA648", "\uA64A", "\uA64C", "\uA64E", "\uA650", "\uA652", "\uA654", "\uA656", "\uA658", "\uA65A", "\uA65C", "\uA65E", "\uA660", "\uA662", "\uA664", "\uA666", "\uA668", "\uA66A", "\uA66C", "\uA680", "\uA682", "\uA684", "\uA686", "\uA688", "\uA68A", "\uA68C", "\uA68E", "\uA690", "\uA692", "\uA694", "\uA696", "\uA698", "\uA69A", "\uA722", "\uA724", "\uA726", "\uA728", "\uA72A", "\uA72C", "\uA72E", "\uA732", "\uA734", "\uA736", "\uA738", "\uA73A", "\uA73C", "\uA73E", "\uA740", "\uA742", "\uA744", "\uA746", "\uA748", "\uA74A", "\uA74C", "\uA74E", "\uA750", "\uA752", "\uA754", "\uA756", "\uA758", "\uA75A", "\uA75C", "\uA75E", "\uA760", "\uA762", "\uA764", "\uA766", "\uA768", "\uA76A", "\uA76C", "\uA76E", "\uA779", "\uA77B", ["\uA77D", "\uA77E"], "\uA780", "\uA782", "\uA784", "\uA786", "\uA78B", "\uA78D", "\uA790", "\uA792", "\uA796", "\uA798", "\uA79A", "\uA79C", "\uA79E", "\uA7A0", "\uA7A2", "\uA7A4", "\uA7A6", "\uA7A8", ["\uA7AA", "\uA7AD"], ["\uA7B0", "\uA7B4"], "\uA7B6", ["\uFF21", "\uFF3A"]], false, false),
      peg$c154 = /^[\u0903\u093B\u093E-\u0940\u0949-\u094C\u094E-\u094F\u0982-\u0983\u09BE-\u09C0\u09C7-\u09C8\u09CB-\u09CC\u09D7\u0A03\u0A3E-\u0A40\u0A83\u0ABE-\u0AC0\u0AC9\u0ACB-\u0ACC\u0B02-\u0B03\u0B3E\u0B40\u0B47-\u0B48\u0B4B-\u0B4C\u0B57\u0BBE-\u0BBF\u0BC1-\u0BC2\u0BC6-\u0BC8\u0BCA-\u0BCC\u0BD7\u0C01-\u0C03\u0C41-\u0C44\u0C82-\u0C83\u0CBE\u0CC0-\u0CC4\u0CC7-\u0CC8\u0CCA-\u0CCB\u0CD5-\u0CD6\u0D02-\u0D03\u0D3E-\u0D40\u0D46-\u0D48\u0D4A-\u0D4C\u0D57\u0D82-\u0D83\u0DCF-\u0DD1\u0DD8-\u0DDF\u0DF2-\u0DF3\u0F3E-\u0F3F\u0F7F\u102B-\u102C\u1031\u1038\u103B-\u103C\u1056-\u1057\u1062-\u1064\u1067-\u106D\u1083-\u1084\u1087-\u108C\u108F\u109A-\u109C\u17B6\u17BE-\u17C5\u17C7-\u17C8\u1923-\u1926\u1929-\u192B\u1930-\u1931\u1933-\u1938\u1A19-\u1A1A\u1A55\u1A57\u1A61\u1A63-\u1A64\u1A6D-\u1A72\u1B04\u1B35\u1B3B\u1B3D-\u1B41\u1B43-\u1B44\u1B82\u1BA1\u1BA6-\u1BA7\u1BAA\u1BE7\u1BEA-\u1BEC\u1BEE\u1BF2-\u1BF3\u1C24-\u1C2B\u1C34-\u1C35\u1CE1\u1CF2-\u1CF3\u302E-\u302F\uA823-\uA824\uA827\uA880-\uA881\uA8B4-\uA8C3\uA952-\uA953\uA983\uA9B4-\uA9B5\uA9BA-\uA9BB\uA9BD-\uA9C0\uAA2F-\uAA30\uAA33-\uAA34\uAA4D\uAA7B\uAA7D\uAAEB\uAAEE-\uAAEF\uAAF5\uABE3-\uABE4\uABE6-\uABE7\uABE9-\uABEA\uABEC]/,
      peg$c155 = peg$classExpectation(["\u0903", "\u093B", ["\u093E", "\u0940"], ["\u0949", "\u094C"], ["\u094E", "\u094F"], ["\u0982", "\u0983"], ["\u09BE", "\u09C0"], ["\u09C7", "\u09C8"], ["\u09CB", "\u09CC"], "\u09D7", "\u0A03", ["\u0A3E", "\u0A40"], "\u0A83", ["\u0ABE", "\u0AC0"], "\u0AC9", ["\u0ACB", "\u0ACC"], ["\u0B02", "\u0B03"], "\u0B3E", "\u0B40", ["\u0B47", "\u0B48"], ["\u0B4B", "\u0B4C"], "\u0B57", ["\u0BBE", "\u0BBF"], ["\u0BC1", "\u0BC2"], ["\u0BC6", "\u0BC8"], ["\u0BCA", "\u0BCC"], "\u0BD7", ["\u0C01", "\u0C03"], ["\u0C41", "\u0C44"], ["\u0C82", "\u0C83"], "\u0CBE", ["\u0CC0", "\u0CC4"], ["\u0CC7", "\u0CC8"], ["\u0CCA", "\u0CCB"], ["\u0CD5", "\u0CD6"], ["\u0D02", "\u0D03"], ["\u0D3E", "\u0D40"], ["\u0D46", "\u0D48"], ["\u0D4A", "\u0D4C"], "\u0D57", ["\u0D82", "\u0D83"], ["\u0DCF", "\u0DD1"], ["\u0DD8", "\u0DDF"], ["\u0DF2", "\u0DF3"], ["\u0F3E", "\u0F3F"], "\u0F7F", ["\u102B", "\u102C"], "\u1031", "\u1038", ["\u103B", "\u103C"], ["\u1056", "\u1057"], ["\u1062", "\u1064"], ["\u1067", "\u106D"], ["\u1083", "\u1084"], ["\u1087", "\u108C"], "\u108F", ["\u109A", "\u109C"], "\u17B6", ["\u17BE", "\u17C5"], ["\u17C7", "\u17C8"], ["\u1923", "\u1926"], ["\u1929", "\u192B"], ["\u1930", "\u1931"], ["\u1933", "\u1938"], ["\u1A19", "\u1A1A"], "\u1A55", "\u1A57", "\u1A61", ["\u1A63", "\u1A64"], ["\u1A6D", "\u1A72"], "\u1B04", "\u1B35", "\u1B3B", ["\u1B3D", "\u1B41"], ["\u1B43", "\u1B44"], "\u1B82", "\u1BA1", ["\u1BA6", "\u1BA7"], "\u1BAA", "\u1BE7", ["\u1BEA", "\u1BEC"], "\u1BEE", ["\u1BF2", "\u1BF3"], ["\u1C24", "\u1C2B"], ["\u1C34", "\u1C35"], "\u1CE1", ["\u1CF2", "\u1CF3"], ["\u302E", "\u302F"], ["\uA823", "\uA824"], "\uA827", ["\uA880", "\uA881"], ["\uA8B4", "\uA8C3"], ["\uA952", "\uA953"], "\uA983", ["\uA9B4", "\uA9B5"], ["\uA9BA", "\uA9BB"], ["\uA9BD", "\uA9C0"], ["\uAA2F", "\uAA30"], ["\uAA33", "\uAA34"], "\uAA4D", "\uAA7B", "\uAA7D", "\uAAEB", ["\uAAEE", "\uAAEF"], "\uAAF5", ["\uABE3", "\uABE4"], ["\uABE6", "\uABE7"], ["\uABE9", "\uABEA"], "\uABEC"], false, false),
      peg$c156 = /^[\u0300-\u036F\u0483-\u0487\u0591-\u05BD\u05BF\u05C1-\u05C2\u05C4-\u05C5\u05C7\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7-\u06E8\u06EA-\u06ED\u0711\u0730-\u074A\u07A6-\u07B0\u07EB-\u07F3\u0816-\u0819\u081B-\u0823\u0825-\u0827\u0829-\u082D\u0859-\u085B\u08E3-\u0902\u093A\u093C\u0941-\u0948\u094D\u0951-\u0957\u0962-\u0963\u0981\u09BC\u09C1-\u09C4\u09CD\u09E2-\u09E3\u0A01-\u0A02\u0A3C\u0A41-\u0A42\u0A47-\u0A48\u0A4B-\u0A4D\u0A51\u0A70-\u0A71\u0A75\u0A81-\u0A82\u0ABC\u0AC1-\u0AC5\u0AC7-\u0AC8\u0ACD\u0AE2-\u0AE3\u0B01\u0B3C\u0B3F\u0B41-\u0B44\u0B4D\u0B56\u0B62-\u0B63\u0B82\u0BC0\u0BCD\u0C00\u0C3E-\u0C40\u0C46-\u0C48\u0C4A-\u0C4D\u0C55-\u0C56\u0C62-\u0C63\u0C81\u0CBC\u0CBF\u0CC6\u0CCC-\u0CCD\u0CE2-\u0CE3\u0D01\u0D41-\u0D44\u0D4D\u0D62-\u0D63\u0DCA\u0DD2-\u0DD4\u0DD6\u0E31\u0E34-\u0E3A\u0E47-\u0E4E\u0EB1\u0EB4-\u0EB9\u0EBB-\u0EBC\u0EC8-\u0ECD\u0F18-\u0F19\u0F35\u0F37\u0F39\u0F71-\u0F7E\u0F80-\u0F84\u0F86-\u0F87\u0F8D-\u0F97\u0F99-\u0FBC\u0FC6\u102D-\u1030\u1032-\u1037\u1039-\u103A\u103D-\u103E\u1058-\u1059\u105E-\u1060\u1071-\u1074\u1082\u1085-\u1086\u108D\u109D\u135D-\u135F\u1712-\u1714\u1732-\u1734\u1752-\u1753\u1772-\u1773\u17B4-\u17B5\u17B7-\u17BD\u17C6\u17C9-\u17D3\u17DD\u180B-\u180D\u18A9\u1920-\u1922\u1927-\u1928\u1932\u1939-\u193B\u1A17-\u1A18\u1A1B\u1A56\u1A58-\u1A5E\u1A60\u1A62\u1A65-\u1A6C\u1A73-\u1A7C\u1A7F\u1AB0-\u1ABD\u1B00-\u1B03\u1B34\u1B36-\u1B3A\u1B3C\u1B42\u1B6B-\u1B73\u1B80-\u1B81\u1BA2-\u1BA5\u1BA8-\u1BA9\u1BAB-\u1BAD\u1BE6\u1BE8-\u1BE9\u1BED\u1BEF-\u1BF1\u1C2C-\u1C33\u1C36-\u1C37\u1CD0-\u1CD2\u1CD4-\u1CE0\u1CE2-\u1CE8\u1CED\u1CF4\u1CF8-\u1CF9\u1DC0-\u1DF5\u1DFC-\u1DFF\u20D0-\u20DC\u20E1\u20E5-\u20F0\u2CEF-\u2CF1\u2D7F\u2DE0-\u2DFF\u302A-\u302D\u3099-\u309A\uA66F\uA674-\uA67D\uA69E-\uA69F\uA6F0-\uA6F1\uA802\uA806\uA80B\uA825-\uA826\uA8C4\uA8E0-\uA8F1\uA926-\uA92D\uA947-\uA951\uA980-\uA982\uA9B3\uA9B6-\uA9B9\uA9BC\uA9E5\uAA29-\uAA2E\uAA31-\uAA32\uAA35-\uAA36\uAA43\uAA4C\uAA7C\uAAB0\uAAB2-\uAAB4\uAAB7-\uAAB8\uAABE-\uAABF\uAAC1\uAAEC-\uAAED\uAAF6\uABE5\uABE8\uABED\uFB1E\uFE00-\uFE0F\uFE20-\uFE2F]/,
      peg$c157 = peg$classExpectation([["\u0300", "\u036F"], ["\u0483", "\u0487"], ["\u0591", "\u05BD"], "\u05BF", ["\u05C1", "\u05C2"], ["\u05C4", "\u05C5"], "\u05C7", ["\u0610", "\u061A"], ["\u064B", "\u065F"], "\u0670", ["\u06D6", "\u06DC"], ["\u06DF", "\u06E4"], ["\u06E7", "\u06E8"], ["\u06EA", "\u06ED"], "\u0711", ["\u0730", "\u074A"], ["\u07A6", "\u07B0"], ["\u07EB", "\u07F3"], ["\u0816", "\u0819"], ["\u081B", "\u0823"], ["\u0825", "\u0827"], ["\u0829", "\u082D"], ["\u0859", "\u085B"], ["\u08E3", "\u0902"], "\u093A", "\u093C", ["\u0941", "\u0948"], "\u094D", ["\u0951", "\u0957"], ["\u0962", "\u0963"], "\u0981", "\u09BC", ["\u09C1", "\u09C4"], "\u09CD", ["\u09E2", "\u09E3"], ["\u0A01", "\u0A02"], "\u0A3C", ["\u0A41", "\u0A42"], ["\u0A47", "\u0A48"], ["\u0A4B", "\u0A4D"], "\u0A51", ["\u0A70", "\u0A71"], "\u0A75", ["\u0A81", "\u0A82"], "\u0ABC", ["\u0AC1", "\u0AC5"], ["\u0AC7", "\u0AC8"], "\u0ACD", ["\u0AE2", "\u0AE3"], "\u0B01", "\u0B3C", "\u0B3F", ["\u0B41", "\u0B44"], "\u0B4D", "\u0B56", ["\u0B62", "\u0B63"], "\u0B82", "\u0BC0", "\u0BCD", "\u0C00", ["\u0C3E", "\u0C40"], ["\u0C46", "\u0C48"], ["\u0C4A", "\u0C4D"], ["\u0C55", "\u0C56"], ["\u0C62", "\u0C63"], "\u0C81", "\u0CBC", "\u0CBF", "\u0CC6", ["\u0CCC", "\u0CCD"], ["\u0CE2", "\u0CE3"], "\u0D01", ["\u0D41", "\u0D44"], "\u0D4D", ["\u0D62", "\u0D63"], "\u0DCA", ["\u0DD2", "\u0DD4"], "\u0DD6", "\u0E31", ["\u0E34", "\u0E3A"], ["\u0E47", "\u0E4E"], "\u0EB1", ["\u0EB4", "\u0EB9"], ["\u0EBB", "\u0EBC"], ["\u0EC8", "\u0ECD"], ["\u0F18", "\u0F19"], "\u0F35", "\u0F37", "\u0F39", ["\u0F71", "\u0F7E"], ["\u0F80", "\u0F84"], ["\u0F86", "\u0F87"], ["\u0F8D", "\u0F97"], ["\u0F99", "\u0FBC"], "\u0FC6", ["\u102D", "\u1030"], ["\u1032", "\u1037"], ["\u1039", "\u103A"], ["\u103D", "\u103E"], ["\u1058", "\u1059"], ["\u105E", "\u1060"], ["\u1071", "\u1074"], "\u1082", ["\u1085", "\u1086"], "\u108D", "\u109D", ["\u135D", "\u135F"], ["\u1712", "\u1714"], ["\u1732", "\u1734"], ["\u1752", "\u1753"], ["\u1772", "\u1773"], ["\u17B4", "\u17B5"], ["\u17B7", "\u17BD"], "\u17C6", ["\u17C9", "\u17D3"], "\u17DD", ["\u180B", "\u180D"], "\u18A9", ["\u1920", "\u1922"], ["\u1927", "\u1928"], "\u1932", ["\u1939", "\u193B"], ["\u1A17", "\u1A18"], "\u1A1B", "\u1A56", ["\u1A58", "\u1A5E"], "\u1A60", "\u1A62", ["\u1A65", "\u1A6C"], ["\u1A73", "\u1A7C"], "\u1A7F", ["\u1AB0", "\u1ABD"], ["\u1B00", "\u1B03"], "\u1B34", ["\u1B36", "\u1B3A"], "\u1B3C", "\u1B42", ["\u1B6B", "\u1B73"], ["\u1B80", "\u1B81"], ["\u1BA2", "\u1BA5"], ["\u1BA8", "\u1BA9"], ["\u1BAB", "\u1BAD"], "\u1BE6", ["\u1BE8", "\u1BE9"], "\u1BED", ["\u1BEF", "\u1BF1"], ["\u1C2C", "\u1C33"], ["\u1C36", "\u1C37"], ["\u1CD0", "\u1CD2"], ["\u1CD4", "\u1CE0"], ["\u1CE2", "\u1CE8"], "\u1CED", "\u1CF4", ["\u1CF8", "\u1CF9"], ["\u1DC0", "\u1DF5"], ["\u1DFC", "\u1DFF"], ["\u20D0", "\u20DC"], "\u20E1", ["\u20E5", "\u20F0"], ["\u2CEF", "\u2CF1"], "\u2D7F", ["\u2DE0", "\u2DFF"], ["\u302A", "\u302D"], ["\u3099", "\u309A"], "\uA66F", ["\uA674", "\uA67D"], ["\uA69E", "\uA69F"], ["\uA6F0", "\uA6F1"], "\uA802", "\uA806", "\uA80B", ["\uA825", "\uA826"], "\uA8C4", ["\uA8E0", "\uA8F1"], ["\uA926", "\uA92D"], ["\uA947", "\uA951"], ["\uA980", "\uA982"], "\uA9B3", ["\uA9B6", "\uA9B9"], "\uA9BC", "\uA9E5", ["\uAA29", "\uAA2E"], ["\uAA31", "\uAA32"], ["\uAA35", "\uAA36"], "\uAA43", "\uAA4C", "\uAA7C", "\uAAB0", ["\uAAB2", "\uAAB4"], ["\uAAB7", "\uAAB8"], ["\uAABE", "\uAABF"], "\uAAC1", ["\uAAEC", "\uAAED"], "\uAAF6", "\uABE5", "\uABE8", "\uABED", "\uFB1E", ["\uFE00", "\uFE0F"], ["\uFE20", "\uFE2F"]], false, false),
      peg$c158 = /^[0-9\u0660-\u0669\u06F0-\u06F9\u07C0-\u07C9\u0966-\u096F\u09E6-\u09EF\u0A66-\u0A6F\u0AE6-\u0AEF\u0B66-\u0B6F\u0BE6-\u0BEF\u0C66-\u0C6F\u0CE6-\u0CEF\u0D66-\u0D6F\u0DE6-\u0DEF\u0E50-\u0E59\u0ED0-\u0ED9\u0F20-\u0F29\u1040-\u1049\u1090-\u1099\u17E0-\u17E9\u1810-\u1819\u1946-\u194F\u19D0-\u19D9\u1A80-\u1A89\u1A90-\u1A99\u1B50-\u1B59\u1BB0-\u1BB9\u1C40-\u1C49\u1C50-\u1C59\uA620-\uA629\uA8D0-\uA8D9\uA900-\uA909\uA9D0-\uA9D9\uA9F0-\uA9F9\uAA50-\uAA59\uABF0-\uABF9\uFF10-\uFF19]/,
      peg$c159 = peg$classExpectation([["0", "9"], ["\u0660", "\u0669"], ["\u06F0", "\u06F9"], ["\u07C0", "\u07C9"], ["\u0966", "\u096F"], ["\u09E6", "\u09EF"], ["\u0A66", "\u0A6F"], ["\u0AE6", "\u0AEF"], ["\u0B66", "\u0B6F"], ["\u0BE6", "\u0BEF"], ["\u0C66", "\u0C6F"], ["\u0CE6", "\u0CEF"], ["\u0D66", "\u0D6F"], ["\u0DE6", "\u0DEF"], ["\u0E50", "\u0E59"], ["\u0ED0", "\u0ED9"], ["\u0F20", "\u0F29"], ["\u1040", "\u1049"], ["\u1090", "\u1099"], ["\u17E0", "\u17E9"], ["\u1810", "\u1819"], ["\u1946", "\u194F"], ["\u19D0", "\u19D9"], ["\u1A80", "\u1A89"], ["\u1A90", "\u1A99"], ["\u1B50", "\u1B59"], ["\u1BB0", "\u1BB9"], ["\u1C40", "\u1C49"], ["\u1C50", "\u1C59"], ["\uA620", "\uA629"], ["\uA8D0", "\uA8D9"], ["\uA900", "\uA909"], ["\uA9D0", "\uA9D9"], ["\uA9F0", "\uA9F9"], ["\uAA50", "\uAA59"], ["\uABF0", "\uABF9"], ["\uFF10", "\uFF19"]], false, false),
      peg$c160 = /^[\u16EE-\u16F0\u2160-\u2182\u2185-\u2188\u3007\u3021-\u3029\u3038-\u303A\uA6E6-\uA6EF]/,
      peg$c161 = peg$classExpectation([["\u16EE", "\u16F0"], ["\u2160", "\u2182"], ["\u2185", "\u2188"], "\u3007", ["\u3021", "\u3029"], ["\u3038", "\u303A"], ["\uA6E6", "\uA6EF"]], false, false),
      peg$c162 = /^[_\u203F-\u2040\u2054\uFE33-\uFE34\uFE4D-\uFE4F\uFF3F]/,
      peg$c163 = peg$classExpectation(["_", ["\u203F", "\u2040"], "\u2054", ["\uFE33", "\uFE34"], ["\uFE4D", "\uFE4F"], "\uFF3F"], false, false),
      peg$c164 = /^[ \xA0\u1680\u2000-\u200A\u202F\u205F\u3000]/,
      peg$c165 = peg$classExpectation([" ", "\xA0", "\u1680", ["\u2000", "\u200A"], "\u202F", "\u205F", "\u3000"], false, false),
      peg$c166 = "break",
      peg$c167 = peg$literalExpectation("break", false),
      peg$c168 = "case",
      peg$c169 = peg$literalExpectation("case", false),
      peg$c170 = "catch",
      peg$c171 = peg$literalExpectation("catch", false),
      peg$c172 = "class",
      peg$c173 = peg$literalExpectation("class", false),
      peg$c174 = "const",
      peg$c175 = peg$literalExpectation("const", false),
      peg$c176 = "continue",
      peg$c177 = peg$literalExpectation("continue", false),
      peg$c178 = "debugger",
      peg$c179 = peg$literalExpectation("debugger", false),
      peg$c180 = "default",
      peg$c181 = peg$literalExpectation("default", false),
      peg$c182 = "delete",
      peg$c183 = peg$literalExpectation("delete", false),
      peg$c184 = "do",
      peg$c185 = peg$literalExpectation("do", false),
      peg$c186 = "else",
      peg$c187 = peg$literalExpectation("else", false),
      peg$c188 = "enum",
      peg$c189 = peg$literalExpectation("enum", false),
      peg$c190 = "export",
      peg$c191 = peg$literalExpectation("export", false),
      peg$c192 = "extends",
      peg$c193 = peg$literalExpectation("extends", false),
      peg$c194 = "false",
      peg$c195 = peg$literalExpectation("false", false),
      peg$c196 = "finally",
      peg$c197 = peg$literalExpectation("finally", false),
      peg$c198 = "for",
      peg$c199 = peg$literalExpectation("for", false),
      peg$c200 = "function",
      peg$c201 = peg$literalExpectation("function", false),
      peg$c202 = "if",
      peg$c203 = peg$literalExpectation("if", false),
      peg$c204 = "import",
      peg$c205 = peg$literalExpectation("import", false),
      peg$c206 = "instanceof",
      peg$c207 = peg$literalExpectation("instanceof", false),
      peg$c208 = "in",
      peg$c209 = peg$literalExpectation("in", false),
      peg$c210 = "new",
      peg$c211 = peg$literalExpectation("new", false),
      peg$c212 = "null",
      peg$c213 = peg$literalExpectation("null", false),
      peg$c214 = "return",
      peg$c215 = peg$literalExpectation("return", false),
      peg$c216 = "super",
      peg$c217 = peg$literalExpectation("super", false),
      peg$c218 = "switch",
      peg$c219 = peg$literalExpectation("switch", false),
      peg$c220 = "this",
      peg$c221 = peg$literalExpectation("this", false),
      peg$c222 = "throw",
      peg$c223 = peg$literalExpectation("throw", false),
      peg$c224 = "true",
      peg$c225 = peg$literalExpectation("true", false),
      peg$c226 = "try",
      peg$c227 = peg$literalExpectation("try", false),
      peg$c228 = "typeof",
      peg$c229 = peg$literalExpectation("typeof", false),
      peg$c230 = "var",
      peg$c231 = peg$literalExpectation("var", false),
      peg$c232 = "void",
      peg$c233 = peg$literalExpectation("void", false),
      peg$c234 = "while",
      peg$c235 = peg$literalExpectation("while", false),
      peg$c236 = "with",
      peg$c237 = peg$literalExpectation("with", false),
      peg$c238 = ";",
      peg$c239 = peg$literalExpectation(";", false),
      peg$currPos = 0,
      peg$savedPos = 0,
      peg$posDetailsCache = [{
    line: 1,
    column: 1
  }],
      peg$maxFailPos = 0,
      peg$maxFailExpected = [],
      peg$silentFails = 0,
      peg$result;

  if ("startRule" in options) {
    if (!(options.startRule in peg$startRuleFunctions)) {
      throw new Error("Can't start parsing from rule \"" + options.startRule + "\".");
    }

    peg$startRuleFunction = peg$startRuleFunctions[options.startRule];
  }

  function text() {
    return input.substring(peg$savedPos, peg$currPos);
  }

  function location() {
    return peg$computeLocation(peg$savedPos, peg$currPos);
  }

  function expected(description, location) {
    location = location !== void 0 ? location : peg$computeLocation(peg$savedPos, peg$currPos);
    throw peg$buildStructuredError([peg$otherExpectation(description)], input.substring(peg$savedPos, peg$currPos), location);
  }

  function error(message, location) {
    location = location !== void 0 ? location : peg$computeLocation(peg$savedPos, peg$currPos);
    throw peg$buildSimpleError(message, location);
  }

  function peg$literalExpectation(text, ignoreCase) {
    return {
      type: "literal",
      text: text,
      ignoreCase: ignoreCase
    };
  }

  function peg$classExpectation(parts, inverted, ignoreCase) {
    return {
      type: "class",
      parts: parts,
      inverted: inverted,
      ignoreCase: ignoreCase
    };
  }

  function peg$anyExpectation() {
    return {
      type: "any"
    };
  }

  function peg$endExpectation() {
    return {
      type: "end"
    };
  }

  function peg$otherExpectation(description) {
    return {
      type: "other",
      description: description
    };
  }

  function peg$computePosDetails(pos) {
    var details = peg$posDetailsCache[pos],
        p;

    if (details) {
      return details;
    } else {
      p = pos - 1;

      while (!peg$posDetailsCache[p]) {
        p--;
      }

      details = peg$posDetailsCache[p];
      details = {
        line: details.line,
        column: details.column
      };

      while (p < pos) {
        if (input.charCodeAt(p) === 10) {
          details.line++;
          details.column = 1;
        } else {
          details.column++;
        }

        p++;
      }

      peg$posDetailsCache[pos] = details;
      return details;
    }
  }

  function peg$computeLocation(startPos, endPos) {
    var startPosDetails = peg$computePosDetails(startPos),
        endPosDetails = peg$computePosDetails(endPos);
    return {
      start: {
        offset: startPos,
        line: startPosDetails.line,
        column: startPosDetails.column
      },
      end: {
        offset: endPos,
        line: endPosDetails.line,
        column: endPosDetails.column
      }
    };
  }

  function peg$fail(expected) {
    if (peg$currPos < peg$maxFailPos) {
      return;
    }

    if (peg$currPos > peg$maxFailPos) {
      peg$maxFailPos = peg$currPos;
      peg$maxFailExpected = [];
    }

    peg$maxFailExpected.push(expected);
  }

  function peg$buildSimpleError(message, location) {
    return new peg$SyntaxError(message, null, null, location);
  }

  function peg$buildStructuredError(expected, found, location) {
    return new peg$SyntaxError(peg$SyntaxError.buildMessage(expected, found), expected, found, location);
  }

  function peg$parseGrammar() {
    var s0, s1, s2, s3, s4, s5, s6;
    s0 = peg$currPos;
    s1 = peg$parse__();

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      s3 = peg$parseInitializer();

      if (s3 !== peg$FAILED) {
        s4 = peg$parse__();

        if (s4 !== peg$FAILED) {
          s3 = [s3, s4];
          s2 = s3;
        } else {
          peg$currPos = s2;
          s2 = peg$FAILED;
        }
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 === peg$FAILED) {
        s2 = null;
      }

      if (s2 !== peg$FAILED) {
        s3 = [];
        s4 = peg$currPos;
        s5 = peg$parseRule();

        if (s5 !== peg$FAILED) {
          s6 = peg$parse__();

          if (s6 !== peg$FAILED) {
            s5 = [s5, s6];
            s4 = s5;
          } else {
            peg$currPos = s4;
            s4 = peg$FAILED;
          }
        } else {
          peg$currPos = s4;
          s4 = peg$FAILED;
        }

        if (s4 !== peg$FAILED) {
          while (s4 !== peg$FAILED) {
            s3.push(s4);
            s4 = peg$currPos;
            s5 = peg$parseRule();

            if (s5 !== peg$FAILED) {
              s6 = peg$parse__();

              if (s6 !== peg$FAILED) {
                s5 = [s5, s6];
                s4 = s5;
              } else {
                peg$currPos = s4;
                s4 = peg$FAILED;
              }
            } else {
              peg$currPos = s4;
              s4 = peg$FAILED;
            }
          }
        } else {
          s3 = peg$FAILED;
        }

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c0(s2, s3);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseInitializer() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$parseCodeBlock();

    if (s1 !== peg$FAILED) {
      s2 = peg$parseEOS();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c1(s1);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseRule() {
    var s0, s1, s2, s3, s4, s5, s6, s7;
    s0 = peg$currPos;
    s1 = peg$parseIdentifierName();

    if (s1 !== peg$FAILED) {
      s2 = peg$parse__();

      if (s2 !== peg$FAILED) {
        s3 = peg$currPos;
        s4 = peg$parseStringLiteral();

        if (s4 !== peg$FAILED) {
          s5 = peg$parse__();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }

        if (s3 === peg$FAILED) {
          s3 = null;
        }

        if (s3 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 61) {
            s4 = peg$c2;
            peg$currPos++;
          } else {
            s4 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c3);
            }
          }

          if (s4 !== peg$FAILED) {
            s5 = peg$parse__();

            if (s5 !== peg$FAILED) {
              s6 = peg$parseChoiceExpression();

              if (s6 !== peg$FAILED) {
                s7 = peg$parseEOS();

                if (s7 !== peg$FAILED) {
                  peg$savedPos = s0;
                  s1 = peg$c4(s1, s3, s6);
                  s0 = s1;
                } else {
                  peg$currPos = s0;
                  s0 = peg$FAILED;
                }
              } else {
                peg$currPos = s0;
                s0 = peg$FAILED;
              }
            } else {
              peg$currPos = s0;
              s0 = peg$FAILED;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseChoiceExpression() {
    var s0, s1, s2, s3, s4, s5, s6, s7;
    s0 = peg$currPos;
    s1 = peg$parseActionExpression();

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$parse__();

      if (s4 !== peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 47) {
          s5 = peg$c5;
          peg$currPos++;
        } else {
          s5 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c6);
          }
        }

        if (s5 !== peg$FAILED) {
          s6 = peg$parse__();

          if (s6 !== peg$FAILED) {
            s7 = peg$parseActionExpression();

            if (s7 !== peg$FAILED) {
              s4 = [s4, s5, s6, s7];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$FAILED;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$parse__();

        if (s4 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 47) {
            s5 = peg$c5;
            peg$currPos++;
          } else {
            s5 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c6);
            }
          }

          if (s5 !== peg$FAILED) {
            s6 = peg$parse__();

            if (s6 !== peg$FAILED) {
              s7 = peg$parseActionExpression();

              if (s7 !== peg$FAILED) {
                s4 = [s4, s5, s6, s7];
                s3 = s4;
              } else {
                peg$currPos = s3;
                s3 = peg$FAILED;
              }
            } else {
              peg$currPos = s3;
              s3 = peg$FAILED;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c7(s1, s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseActionExpression() {
    var s0, s1, s2, s3, s4;
    s0 = peg$currPos;
    s1 = peg$parseSequenceExpression();

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      s3 = peg$parse__();

      if (s3 !== peg$FAILED) {
        s4 = peg$parseCodeBlock();

        if (s4 !== peg$FAILED) {
          s3 = [s3, s4];
          s2 = s3;
        } else {
          peg$currPos = s2;
          s2 = peg$FAILED;
        }
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 === peg$FAILED) {
        s2 = null;
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c8(s1, s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSequenceExpression() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;
    s1 = peg$parseLabeledExpression();

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$parse__();

      if (s4 !== peg$FAILED) {
        s5 = peg$parseLabeledExpression();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$parse__();

        if (s4 !== peg$FAILED) {
          s5 = peg$parseLabeledExpression();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c9(s1, s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseLabeledExpression() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;
    s1 = peg$parseIdentifier();

    if (s1 !== peg$FAILED) {
      s2 = peg$parse__();

      if (s2 !== peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 58) {
          s3 = peg$c10;
          peg$currPos++;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c11);
          }
        }

        if (s3 !== peg$FAILED) {
          s4 = peg$parse__();

          if (s4 !== peg$FAILED) {
            s5 = peg$parsePrefixedExpression();

            if (s5 !== peg$FAILED) {
              peg$savedPos = s0;
              s1 = peg$c12(s1, s5);
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$FAILED;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$parsePrefixedExpression();
    }

    return s0;
  }

  function peg$parsePrefixedExpression() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;
    s1 = peg$parsePrefixedOperator();

    if (s1 !== peg$FAILED) {
      s2 = peg$parse__();

      if (s2 !== peg$FAILED) {
        s3 = peg$parseSuffixedExpression();

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c13(s1, s3);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$parseSuffixedExpression();
    }

    return s0;
  }

  function peg$parsePrefixedOperator() {
    var s0;

    if (input.charCodeAt(peg$currPos) === 36) {
      s0 = peg$c14;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c15);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 38) {
        s0 = peg$c16;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c17);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 33) {
          s0 = peg$c18;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c19);
          }
        }
      }
    }

    return s0;
  }

  function peg$parseSuffixedExpression() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;
    s1 = peg$parsePrimaryExpression();

    if (s1 !== peg$FAILED) {
      s2 = peg$parse__();

      if (s2 !== peg$FAILED) {
        s3 = peg$parseSuffixedOperator();

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c20(s1, s3);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$parsePrimaryExpression();
    }

    return s0;
  }

  function peg$parseSuffixedOperator() {
    var s0;

    if (input.charCodeAt(peg$currPos) === 63) {
      s0 = peg$c21;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c22);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 42) {
        s0 = peg$c23;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c24);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 43) {
          s0 = peg$c25;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c26);
          }
        }
      }
    }

    return s0;
  }

  function peg$parsePrimaryExpression() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$parseLiteralMatcher();

    if (s0 === peg$FAILED) {
      s0 = peg$parseCharacterClassMatcher();

      if (s0 === peg$FAILED) {
        s0 = peg$parseAnyMatcher();

        if (s0 === peg$FAILED) {
          s0 = peg$parseRuleReferenceExpression();

          if (s0 === peg$FAILED) {
            s0 = peg$parseSemanticPredicateExpression();

            if (s0 === peg$FAILED) {
              s0 = peg$currPos;

              if (input.charCodeAt(peg$currPos) === 40) {
                s1 = peg$c27;
                peg$currPos++;
              } else {
                s1 = peg$FAILED;

                if (peg$silentFails === 0) {
                  peg$fail(peg$c28);
                }
              }

              if (s1 !== peg$FAILED) {
                s2 = peg$parse__();

                if (s2 !== peg$FAILED) {
                  s3 = peg$parseChoiceExpression();

                  if (s3 !== peg$FAILED) {
                    s4 = peg$parse__();

                    if (s4 !== peg$FAILED) {
                      if (input.charCodeAt(peg$currPos) === 41) {
                        s5 = peg$c29;
                        peg$currPos++;
                      } else {
                        s5 = peg$FAILED;

                        if (peg$silentFails === 0) {
                          peg$fail(peg$c30);
                        }
                      }

                      if (s5 !== peg$FAILED) {
                        peg$savedPos = s0;
                        s1 = peg$c31(s3);
                        s0 = s1;
                      } else {
                        peg$currPos = s0;
                        s0 = peg$FAILED;
                      }
                    } else {
                      peg$currPos = s0;
                      s0 = peg$FAILED;
                    }
                  } else {
                    peg$currPos = s0;
                    s0 = peg$FAILED;
                  }
                } else {
                  peg$currPos = s0;
                  s0 = peg$FAILED;
                }
              } else {
                peg$currPos = s0;
                s0 = peg$FAILED;
              }
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseRuleReferenceExpression() {
    var s0, s1, s2, s3, s4, s5, s6, s7;
    s0 = peg$currPos;
    s1 = peg$parseIdentifierName();

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$currPos;
      s4 = peg$parse__();

      if (s4 !== peg$FAILED) {
        s5 = peg$currPos;
        s6 = peg$parseStringLiteral();

        if (s6 !== peg$FAILED) {
          s7 = peg$parse__();

          if (s7 !== peg$FAILED) {
            s6 = [s6, s7];
            s5 = s6;
          } else {
            peg$currPos = s5;
            s5 = peg$FAILED;
          }
        } else {
          peg$currPos = s5;
          s5 = peg$FAILED;
        }

        if (s5 === peg$FAILED) {
          s5 = null;
        }

        if (s5 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 61) {
            s6 = peg$c2;
            peg$currPos++;
          } else {
            s6 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c3);
            }
          }

          if (s6 !== peg$FAILED) {
            s4 = [s4, s5, s6];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c32(s1);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSemanticPredicateExpression() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;
    s1 = peg$parseSemanticPredicateOperator();

    if (s1 !== peg$FAILED) {
      s2 = peg$parse__();

      if (s2 !== peg$FAILED) {
        s3 = peg$parseCodeBlock();

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c33(s1, s3);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSemanticPredicateOperator() {
    var s0;

    if (input.charCodeAt(peg$currPos) === 38) {
      s0 = peg$c16;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c17);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 33) {
        s0 = peg$c18;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c19);
        }
      }
    }

    return s0;
  }

  function peg$parseSourceCharacter() {
    var s0;

    if (input.length > peg$currPos) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c34);
      }
    }

    return s0;
  }

  function peg$parseWhiteSpace() {
    var s0, s1;
    peg$silentFails++;

    if (input.charCodeAt(peg$currPos) === 9) {
      s0 = peg$c36;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c37);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 11) {
        s0 = peg$c38;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c39);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 12) {
          s0 = peg$c40;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c41);
          }
        }

        if (s0 === peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 32) {
            s0 = peg$c42;
            peg$currPos++;
          } else {
            s0 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c43);
            }
          }

          if (s0 === peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 160) {
              s0 = peg$c44;
              peg$currPos++;
            } else {
              s0 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c45);
              }
            }

            if (s0 === peg$FAILED) {
              if (input.charCodeAt(peg$currPos) === 65279) {
                s0 = peg$c46;
                peg$currPos++;
              } else {
                s0 = peg$FAILED;

                if (peg$silentFails === 0) {
                  peg$fail(peg$c47);
                }
              }

              if (s0 === peg$FAILED) {
                s0 = peg$parseZs();
              }
            }
          }
        }
      }
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c35);
      }
    }

    return s0;
  }

  function peg$parseLineTerminator() {
    var s0;

    if (peg$c48.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c49);
      }
    }

    return s0;
  }

  function peg$parseLineTerminatorSequence() {
    var s0, s1;
    peg$silentFails++;

    if (input.charCodeAt(peg$currPos) === 10) {
      s0 = peg$c51;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c52);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.substr(peg$currPos, 2) === peg$c53) {
        s0 = peg$c53;
        peg$currPos += 2;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c54);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 13) {
          s0 = peg$c55;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c56);
          }
        }

        if (s0 === peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 8232) {
            s0 = peg$c57;
            peg$currPos++;
          } else {
            s0 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c58);
            }
          }

          if (s0 === peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 8233) {
              s0 = peg$c59;
              peg$currPos++;
            } else {
              s0 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c60);
              }
            }
          }
        }
      }
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c50);
      }
    }

    return s0;
  }

  function peg$parseComment() {
    var s0, s1;
    peg$silentFails++;
    s0 = peg$parseMultiLineComment();

    if (s0 === peg$FAILED) {
      s0 = peg$parseSingleLineComment();
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c61);
      }
    }

    return s0;
  }

  function peg$parseMultiLineComment() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c62) {
      s1 = peg$c62;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c63);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$currPos;
      peg$silentFails++;

      if (input.substr(peg$currPos, 2) === peg$c64) {
        s5 = peg$c64;
        peg$currPos += 2;
      } else {
        s5 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c65);
        }
      }

      peg$silentFails--;

      if (s5 === peg$FAILED) {
        s4 = void 0;
      } else {
        peg$currPos = s4;
        s4 = peg$FAILED;
      }

      if (s4 !== peg$FAILED) {
        s5 = peg$parseSourceCharacter();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$currPos;
        peg$silentFails++;

        if (input.substr(peg$currPos, 2) === peg$c64) {
          s5 = peg$c64;
          peg$currPos += 2;
        } else {
          s5 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c65);
          }
        }

        peg$silentFails--;

        if (s5 === peg$FAILED) {
          s4 = void 0;
        } else {
          peg$currPos = s4;
          s4 = peg$FAILED;
        }

        if (s4 !== peg$FAILED) {
          s5 = peg$parseSourceCharacter();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }

      if (s2 !== peg$FAILED) {
        if (input.substr(peg$currPos, 2) === peg$c64) {
          s3 = peg$c64;
          peg$currPos += 2;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c65);
          }
        }

        if (s3 !== peg$FAILED) {
          s1 = [s1, s2, s3];
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseMultiLineCommentNoLineTerminator() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c62) {
      s1 = peg$c62;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c63);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$currPos;
      peg$silentFails++;

      if (input.substr(peg$currPos, 2) === peg$c64) {
        s5 = peg$c64;
        peg$currPos += 2;
      } else {
        s5 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c65);
        }
      }

      if (s5 === peg$FAILED) {
        s5 = peg$parseLineTerminator();
      }

      peg$silentFails--;

      if (s5 === peg$FAILED) {
        s4 = void 0;
      } else {
        peg$currPos = s4;
        s4 = peg$FAILED;
      }

      if (s4 !== peg$FAILED) {
        s5 = peg$parseSourceCharacter();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$currPos;
        peg$silentFails++;

        if (input.substr(peg$currPos, 2) === peg$c64) {
          s5 = peg$c64;
          peg$currPos += 2;
        } else {
          s5 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c65);
          }
        }

        if (s5 === peg$FAILED) {
          s5 = peg$parseLineTerminator();
        }

        peg$silentFails--;

        if (s5 === peg$FAILED) {
          s4 = void 0;
        } else {
          peg$currPos = s4;
          s4 = peg$FAILED;
        }

        if (s4 !== peg$FAILED) {
          s5 = peg$parseSourceCharacter();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }

      if (s2 !== peg$FAILED) {
        if (input.substr(peg$currPos, 2) === peg$c64) {
          s3 = peg$c64;
          peg$currPos += 2;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c65);
          }
        }

        if (s3 !== peg$FAILED) {
          s1 = [s1, s2, s3];
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSingleLineComment() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c66) {
      s1 = peg$c66;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c67);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$currPos;
      peg$silentFails++;
      s5 = peg$parseLineTerminator();
      peg$silentFails--;

      if (s5 === peg$FAILED) {
        s4 = void 0;
      } else {
        peg$currPos = s4;
        s4 = peg$FAILED;
      }

      if (s4 !== peg$FAILED) {
        s5 = peg$parseSourceCharacter();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$currPos;
        peg$silentFails++;
        s5 = peg$parseLineTerminator();
        peg$silentFails--;

        if (s5 === peg$FAILED) {
          s4 = void 0;
        } else {
          peg$currPos = s4;
          s4 = peg$FAILED;
        }

        if (s4 !== peg$FAILED) {
          s5 = peg$parseSourceCharacter();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseIdentifier() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$currPos;
    peg$silentFails++;
    s2 = peg$parseReservedWord();
    peg$silentFails--;

    if (s2 === peg$FAILED) {
      s1 = void 0;
    } else {
      peg$currPos = s1;
      s1 = peg$FAILED;
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseIdentifierName();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c68(s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseIdentifierName() {
    var s0, s1, s2, s3;
    peg$silentFails++;
    s0 = peg$currPos;
    s1 = peg$parseIdentifierStart();

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$parseIdentifierPart();

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$parseIdentifierPart();
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c70(s1, s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c69);
      }
    }

    return s0;
  }

  function peg$parseIdentifierStart() {
    var s0, s1, s2;
    s0 = peg$parseUnicodeLetter();

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 36) {
        s0 = peg$c14;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c15);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 95) {
          s0 = peg$c71;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c72);
          }
        }

        if (s0 === peg$FAILED) {
          s0 = peg$currPos;

          if (input.charCodeAt(peg$currPos) === 92) {
            s1 = peg$c73;
            peg$currPos++;
          } else {
            s1 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c74);
            }
          }

          if (s1 !== peg$FAILED) {
            s2 = peg$parseUnicodeEscapeSequence();

            if (s2 !== peg$FAILED) {
              peg$savedPos = s0;
              s1 = peg$c75(s2);
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$FAILED;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        }
      }
    }

    return s0;
  }

  function peg$parseIdentifierPart() {
    var s0;
    s0 = peg$parseIdentifierStart();

    if (s0 === peg$FAILED) {
      s0 = peg$parseUnicodeCombiningMark();

      if (s0 === peg$FAILED) {
        s0 = peg$parseNd();

        if (s0 === peg$FAILED) {
          s0 = peg$parsePc();

          if (s0 === peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 8204) {
              s0 = peg$c76;
              peg$currPos++;
            } else {
              s0 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c77);
              }
            }

            if (s0 === peg$FAILED) {
              if (input.charCodeAt(peg$currPos) === 8205) {
                s0 = peg$c78;
                peg$currPos++;
              } else {
                s0 = peg$FAILED;

                if (peg$silentFails === 0) {
                  peg$fail(peg$c79);
                }
              }
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseUnicodeLetter() {
    var s0;
    s0 = peg$parseLu();

    if (s0 === peg$FAILED) {
      s0 = peg$parseLl();

      if (s0 === peg$FAILED) {
        s0 = peg$parseLt();

        if (s0 === peg$FAILED) {
          s0 = peg$parseLm();

          if (s0 === peg$FAILED) {
            s0 = peg$parseLo();

            if (s0 === peg$FAILED) {
              s0 = peg$parseNl();
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseUnicodeCombiningMark() {
    var s0;
    s0 = peg$parseMn();

    if (s0 === peg$FAILED) {
      s0 = peg$parseMc();
    }

    return s0;
  }

  function peg$parseReservedWord() {
    var s0;
    s0 = peg$parseKeyword();

    if (s0 === peg$FAILED) {
      s0 = peg$parseFutureReservedWord();

      if (s0 === peg$FAILED) {
        s0 = peg$parseNullToken();

        if (s0 === peg$FAILED) {
          s0 = peg$parseBooleanLiteral();
        }
      }
    }

    return s0;
  }

  function peg$parseKeyword() {
    var s0;
    s0 = peg$parseBreakToken();

    if (s0 === peg$FAILED) {
      s0 = peg$parseCaseToken();

      if (s0 === peg$FAILED) {
        s0 = peg$parseCatchToken();

        if (s0 === peg$FAILED) {
          s0 = peg$parseContinueToken();

          if (s0 === peg$FAILED) {
            s0 = peg$parseDebuggerToken();

            if (s0 === peg$FAILED) {
              s0 = peg$parseDefaultToken();

              if (s0 === peg$FAILED) {
                s0 = peg$parseDeleteToken();

                if (s0 === peg$FAILED) {
                  s0 = peg$parseDoToken();

                  if (s0 === peg$FAILED) {
                    s0 = peg$parseElseToken();

                    if (s0 === peg$FAILED) {
                      s0 = peg$parseFinallyToken();

                      if (s0 === peg$FAILED) {
                        s0 = peg$parseForToken();

                        if (s0 === peg$FAILED) {
                          s0 = peg$parseFunctionToken();

                          if (s0 === peg$FAILED) {
                            s0 = peg$parseIfToken();

                            if (s0 === peg$FAILED) {
                              s0 = peg$parseInstanceofToken();

                              if (s0 === peg$FAILED) {
                                s0 = peg$parseInToken();

                                if (s0 === peg$FAILED) {
                                  s0 = peg$parseNewToken();

                                  if (s0 === peg$FAILED) {
                                    s0 = peg$parseReturnToken();

                                    if (s0 === peg$FAILED) {
                                      s0 = peg$parseSwitchToken();

                                      if (s0 === peg$FAILED) {
                                        s0 = peg$parseThisToken();

                                        if (s0 === peg$FAILED) {
                                          s0 = peg$parseThrowToken();

                                          if (s0 === peg$FAILED) {
                                            s0 = peg$parseTryToken();

                                            if (s0 === peg$FAILED) {
                                              s0 = peg$parseTypeofToken();

                                              if (s0 === peg$FAILED) {
                                                s0 = peg$parseVarToken();

                                                if (s0 === peg$FAILED) {
                                                  s0 = peg$parseVoidToken();

                                                  if (s0 === peg$FAILED) {
                                                    s0 = peg$parseWhileToken();

                                                    if (s0 === peg$FAILED) {
                                                      s0 = peg$parseWithToken();
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseFutureReservedWord() {
    var s0;
    s0 = peg$parseClassToken();

    if (s0 === peg$FAILED) {
      s0 = peg$parseConstToken();

      if (s0 === peg$FAILED) {
        s0 = peg$parseEnumToken();

        if (s0 === peg$FAILED) {
          s0 = peg$parseExportToken();

          if (s0 === peg$FAILED) {
            s0 = peg$parseExtendsToken();

            if (s0 === peg$FAILED) {
              s0 = peg$parseImportToken();

              if (s0 === peg$FAILED) {
                s0 = peg$parseSuperToken();
              }
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseBooleanLiteral() {
    var s0;
    s0 = peg$parseTrueToken();

    if (s0 === peg$FAILED) {
      s0 = peg$parseFalseToken();
    }

    return s0;
  }

  function peg$parseLiteralMatcher() {
    var s0, s1, s2;
    peg$silentFails++;
    s0 = peg$currPos;
    s1 = peg$parseStringLiteral();

    if (s1 !== peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 105) {
        s2 = peg$c81;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c82);
        }
      }

      if (s2 === peg$FAILED) {
        s2 = null;
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c83(s1, s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c80);
      }
    }

    return s0;
  }

  function peg$parseStringLiteral() {
    var s0, s1, s2, s3;
    peg$silentFails++;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 34) {
      s1 = peg$c85;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c86);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = [];
      s3 = peg$parseDoubleStringCharacter();

      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$parseDoubleStringCharacter();
      }

      if (s2 !== peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 34) {
          s3 = peg$c85;
          peg$currPos++;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c86);
          }
        }

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c87(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 39) {
        s1 = peg$c88;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c89);
        }
      }

      if (s1 !== peg$FAILED) {
        s2 = [];
        s3 = peg$parseSingleStringCharacter();

        while (s3 !== peg$FAILED) {
          s2.push(s3);
          s3 = peg$parseSingleStringCharacter();
        }

        if (s2 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 39) {
            s3 = peg$c88;
            peg$currPos++;
          } else {
            s3 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c89);
            }
          }

          if (s3 !== peg$FAILED) {
            peg$savedPos = s0;
            s1 = peg$c87(s2);
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c84);
      }
    }

    return s0;
  }

  function peg$parseDoubleStringCharacter() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$currPos;
    peg$silentFails++;

    if (input.charCodeAt(peg$currPos) === 34) {
      s2 = peg$c85;
      peg$currPos++;
    } else {
      s2 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c86);
      }
    }

    if (s2 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 92) {
        s2 = peg$c73;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s2 === peg$FAILED) {
        s2 = peg$parseLineTerminator();
      }
    }

    peg$silentFails--;

    if (s2 === peg$FAILED) {
      s1 = void 0;
    } else {
      peg$currPos = s1;
      s1 = peg$FAILED;
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseSourceCharacter();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c90();
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 92) {
        s1 = peg$c73;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s1 !== peg$FAILED) {
        s2 = peg$parseEscapeSequence();

        if (s2 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c75(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }

      if (s0 === peg$FAILED) {
        s0 = peg$parseLineContinuation();
      }
    }

    return s0;
  }

  function peg$parseSingleStringCharacter() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$currPos;
    peg$silentFails++;

    if (input.charCodeAt(peg$currPos) === 39) {
      s2 = peg$c88;
      peg$currPos++;
    } else {
      s2 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c89);
      }
    }

    if (s2 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 92) {
        s2 = peg$c73;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s2 === peg$FAILED) {
        s2 = peg$parseLineTerminator();
      }
    }

    peg$silentFails--;

    if (s2 === peg$FAILED) {
      s1 = void 0;
    } else {
      peg$currPos = s1;
      s1 = peg$FAILED;
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseSourceCharacter();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c90();
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 92) {
        s1 = peg$c73;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s1 !== peg$FAILED) {
        s2 = peg$parseEscapeSequence();

        if (s2 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c75(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }

      if (s0 === peg$FAILED) {
        s0 = peg$parseLineContinuation();
      }
    }

    return s0;
  }

  function peg$parseCharacterClassMatcher() {
    var s0, s1, s2, s3, s4, s5;
    peg$silentFails++;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 91) {
      s1 = peg$c92;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c93);
      }
    }

    if (s1 !== peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 94) {
        s2 = peg$c94;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c95);
        }
      }

      if (s2 === peg$FAILED) {
        s2 = null;
      }

      if (s2 !== peg$FAILED) {
        s3 = [];
        s4 = peg$parseClassCharacterRange();

        if (s4 === peg$FAILED) {
          s4 = peg$parseClassCharacter();
        }

        while (s4 !== peg$FAILED) {
          s3.push(s4);
          s4 = peg$parseClassCharacterRange();

          if (s4 === peg$FAILED) {
            s4 = peg$parseClassCharacter();
          }
        }

        if (s3 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 93) {
            s4 = peg$c96;
            peg$currPos++;
          } else {
            s4 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c97);
            }
          }

          if (s4 !== peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 105) {
              s5 = peg$c81;
              peg$currPos++;
            } else {
              s5 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c82);
              }
            }

            if (s5 === peg$FAILED) {
              s5 = null;
            }

            if (s5 !== peg$FAILED) {
              peg$savedPos = s0;
              s1 = peg$c98(s2, s3, s5);
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$FAILED;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c91);
      }
    }

    return s0;
  }

  function peg$parseClassCharacterRange() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;
    s1 = peg$parseClassCharacter();

    if (s1 !== peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 45) {
        s2 = peg$c99;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c100);
        }
      }

      if (s2 !== peg$FAILED) {
        s3 = peg$parseClassCharacter();

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c101(s1, s3);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseClassCharacter() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$currPos;
    peg$silentFails++;

    if (input.charCodeAt(peg$currPos) === 93) {
      s2 = peg$c96;
      peg$currPos++;
    } else {
      s2 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c97);
      }
    }

    if (s2 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 92) {
        s2 = peg$c73;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s2 === peg$FAILED) {
        s2 = peg$parseLineTerminator();
      }
    }

    peg$silentFails--;

    if (s2 === peg$FAILED) {
      s1 = void 0;
    } else {
      peg$currPos = s1;
      s1 = peg$FAILED;
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseSourceCharacter();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c90();
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 92) {
        s1 = peg$c73;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c74);
        }
      }

      if (s1 !== peg$FAILED) {
        s2 = peg$parseEscapeSequence();

        if (s2 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c75(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }

      if (s0 === peg$FAILED) {
        s0 = peg$parseLineContinuation();
      }
    }

    return s0;
  }

  function peg$parseLineContinuation() {
    var s0, s1, s2;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 92) {
      s1 = peg$c73;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c74);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseLineTerminatorSequence();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c102();
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseEscapeSequence() {
    var s0, s1, s2, s3;
    s0 = peg$parseCharacterEscapeSequence();

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 48) {
        s1 = peg$c103;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c104);
        }
      }

      if (s1 !== peg$FAILED) {
        s2 = peg$currPos;
        peg$silentFails++;
        s3 = peg$parseDecimalDigit();
        peg$silentFails--;

        if (s3 === peg$FAILED) {
          s2 = void 0;
        } else {
          peg$currPos = s2;
          s2 = peg$FAILED;
        }

        if (s2 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c105();
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }

      if (s0 === peg$FAILED) {
        s0 = peg$parseHexEscapeSequence();

        if (s0 === peg$FAILED) {
          s0 = peg$parseUnicodeEscapeSequence();
        }
      }
    }

    return s0;
  }

  function peg$parseCharacterEscapeSequence() {
    var s0;
    s0 = peg$parseSingleEscapeCharacter();

    if (s0 === peg$FAILED) {
      s0 = peg$parseNonEscapeCharacter();
    }

    return s0;
  }

  function peg$parseSingleEscapeCharacter() {
    var s0, s1;

    if (input.charCodeAt(peg$currPos) === 39) {
      s0 = peg$c88;
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c89);
      }
    }

    if (s0 === peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 34) {
        s0 = peg$c85;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c86);
        }
      }

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 92) {
          s0 = peg$c73;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c74);
          }
        }

        if (s0 === peg$FAILED) {
          s0 = peg$currPos;

          if (input.charCodeAt(peg$currPos) === 98) {
            s1 = peg$c106;
            peg$currPos++;
          } else {
            s1 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c107);
            }
          }

          if (s1 !== peg$FAILED) {
            peg$savedPos = s0;
            s1 = peg$c108();
          }

          s0 = s1;

          if (s0 === peg$FAILED) {
            s0 = peg$currPos;

            if (input.charCodeAt(peg$currPos) === 102) {
              s1 = peg$c109;
              peg$currPos++;
            } else {
              s1 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c110);
              }
            }

            if (s1 !== peg$FAILED) {
              peg$savedPos = s0;
              s1 = peg$c111();
            }

            s0 = s1;

            if (s0 === peg$FAILED) {
              s0 = peg$currPos;

              if (input.charCodeAt(peg$currPos) === 110) {
                s1 = peg$c112;
                peg$currPos++;
              } else {
                s1 = peg$FAILED;

                if (peg$silentFails === 0) {
                  peg$fail(peg$c113);
                }
              }

              if (s1 !== peg$FAILED) {
                peg$savedPos = s0;
                s1 = peg$c114();
              }

              s0 = s1;

              if (s0 === peg$FAILED) {
                s0 = peg$currPos;

                if (input.charCodeAt(peg$currPos) === 114) {
                  s1 = peg$c115;
                  peg$currPos++;
                } else {
                  s1 = peg$FAILED;

                  if (peg$silentFails === 0) {
                    peg$fail(peg$c116);
                  }
                }

                if (s1 !== peg$FAILED) {
                  peg$savedPos = s0;
                  s1 = peg$c117();
                }

                s0 = s1;

                if (s0 === peg$FAILED) {
                  s0 = peg$currPos;

                  if (input.charCodeAt(peg$currPos) === 116) {
                    s1 = peg$c118;
                    peg$currPos++;
                  } else {
                    s1 = peg$FAILED;

                    if (peg$silentFails === 0) {
                      peg$fail(peg$c119);
                    }
                  }

                  if (s1 !== peg$FAILED) {
                    peg$savedPos = s0;
                    s1 = peg$c120();
                  }

                  s0 = s1;

                  if (s0 === peg$FAILED) {
                    s0 = peg$currPos;

                    if (input.charCodeAt(peg$currPos) === 118) {
                      s1 = peg$c121;
                      peg$currPos++;
                    } else {
                      s1 = peg$FAILED;

                      if (peg$silentFails === 0) {
                        peg$fail(peg$c122);
                      }
                    }

                    if (s1 !== peg$FAILED) {
                      peg$savedPos = s0;
                      s1 = peg$c123();
                    }

                    s0 = s1;
                  }
                }
              }
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseNonEscapeCharacter() {
    var s0, s1, s2;
    s0 = peg$currPos;
    s1 = peg$currPos;
    peg$silentFails++;
    s2 = peg$parseEscapeCharacter();

    if (s2 === peg$FAILED) {
      s2 = peg$parseLineTerminator();
    }

    peg$silentFails--;

    if (s2 === peg$FAILED) {
      s1 = void 0;
    } else {
      peg$currPos = s1;
      s1 = peg$FAILED;
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseSourceCharacter();

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c90();
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseEscapeCharacter() {
    var s0;
    s0 = peg$parseSingleEscapeCharacter();

    if (s0 === peg$FAILED) {
      s0 = peg$parseDecimalDigit();

      if (s0 === peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 120) {
          s0 = peg$c124;
          peg$currPos++;
        } else {
          s0 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c125);
          }
        }

        if (s0 === peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 117) {
            s0 = peg$c126;
            peg$currPos++;
          } else {
            s0 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c127);
            }
          }
        }
      }
    }

    return s0;
  }

  function peg$parseHexEscapeSequence() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 120) {
      s1 = peg$c124;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c125);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      s3 = peg$currPos;
      s4 = peg$parseHexDigit();

      if (s4 !== peg$FAILED) {
        s5 = peg$parseHexDigit();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      if (s3 !== peg$FAILED) {
        s2 = input.substring(s2, peg$currPos);
      } else {
        s2 = s3;
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c128(s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseUnicodeEscapeSequence() {
    var s0, s1, s2, s3, s4, s5, s6, s7;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 117) {
      s1 = peg$c126;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c127);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      s3 = peg$currPos;
      s4 = peg$parseHexDigit();

      if (s4 !== peg$FAILED) {
        s5 = peg$parseHexDigit();

        if (s5 !== peg$FAILED) {
          s6 = peg$parseHexDigit();

          if (s6 !== peg$FAILED) {
            s7 = peg$parseHexDigit();

            if (s7 !== peg$FAILED) {
              s4 = [s4, s5, s6, s7];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$FAILED;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      if (s3 !== peg$FAILED) {
        s2 = input.substring(s2, peg$currPos);
      } else {
        s2 = s3;
      }

      if (s2 !== peg$FAILED) {
        peg$savedPos = s0;
        s1 = peg$c128(s2);
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseDecimalDigit() {
    var s0;

    if (peg$c129.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c130);
      }
    }

    return s0;
  }

  function peg$parseHexDigit() {
    var s0;

    if (peg$c131.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c132);
      }
    }

    return s0;
  }

  function peg$parseAnyMatcher() {
    var s0, s1;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 46) {
      s1 = peg$c133;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c134);
      }
    }

    if (s1 !== peg$FAILED) {
      peg$savedPos = s0;
      s1 = peg$c135();
    }

    s0 = s1;
    return s0;
  }

  function peg$parseCodeBlock() {
    var s0, s1, s2, s3;
    peg$silentFails++;
    s0 = peg$currPos;

    if (input.charCodeAt(peg$currPos) === 123) {
      s1 = peg$c137;
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c138);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$parseCode();

      if (s2 !== peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 125) {
          s3 = peg$c139;
          peg$currPos++;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c140);
          }
        }

        if (s3 !== peg$FAILED) {
          peg$savedPos = s0;
          s1 = peg$c141(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    peg$silentFails--;

    if (s0 === peg$FAILED) {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c136);
      }
    }

    return s0;
  }

  function peg$parseCode() {
    var s0, s1, s2, s3, s4, s5;
    s0 = peg$currPos;
    s1 = [];
    s2 = [];
    s3 = peg$currPos;
    s4 = peg$currPos;
    peg$silentFails++;

    if (peg$c142.test(input.charAt(peg$currPos))) {
      s5 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s5 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c143);
      }
    }

    peg$silentFails--;

    if (s5 === peg$FAILED) {
      s4 = void 0;
    } else {
      peg$currPos = s4;
      s4 = peg$FAILED;
    }

    if (s4 !== peg$FAILED) {
      s5 = peg$parseSourceCharacter();

      if (s5 !== peg$FAILED) {
        s4 = [s4, s5];
        s3 = s4;
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }
    } else {
      peg$currPos = s3;
      s3 = peg$FAILED;
    }

    if (s3 !== peg$FAILED) {
      while (s3 !== peg$FAILED) {
        s2.push(s3);
        s3 = peg$currPos;
        s4 = peg$currPos;
        peg$silentFails++;

        if (peg$c142.test(input.charAt(peg$currPos))) {
          s5 = input.charAt(peg$currPos);
          peg$currPos++;
        } else {
          s5 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c143);
          }
        }

        peg$silentFails--;

        if (s5 === peg$FAILED) {
          s4 = void 0;
        } else {
          peg$currPos = s4;
          s4 = peg$FAILED;
        }

        if (s4 !== peg$FAILED) {
          s5 = peg$parseSourceCharacter();

          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      }
    } else {
      s2 = peg$FAILED;
    }

    if (s2 === peg$FAILED) {
      s2 = peg$currPos;

      if (input.charCodeAt(peg$currPos) === 123) {
        s3 = peg$c137;
        peg$currPos++;
      } else {
        s3 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c138);
        }
      }

      if (s3 !== peg$FAILED) {
        s4 = peg$parseCode();

        if (s4 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 125) {
            s5 = peg$c139;
            peg$currPos++;
          } else {
            s5 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c140);
            }
          }

          if (s5 !== peg$FAILED) {
            s3 = [s3, s4, s5];
            s2 = s3;
          } else {
            peg$currPos = s2;
            s2 = peg$FAILED;
          }
        } else {
          peg$currPos = s2;
          s2 = peg$FAILED;
        }
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }
    }

    while (s2 !== peg$FAILED) {
      s1.push(s2);
      s2 = [];
      s3 = peg$currPos;
      s4 = peg$currPos;
      peg$silentFails++;

      if (peg$c142.test(input.charAt(peg$currPos))) {
        s5 = input.charAt(peg$currPos);
        peg$currPos++;
      } else {
        s5 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c143);
        }
      }

      peg$silentFails--;

      if (s5 === peg$FAILED) {
        s4 = void 0;
      } else {
        peg$currPos = s4;
        s4 = peg$FAILED;
      }

      if (s4 !== peg$FAILED) {
        s5 = peg$parseSourceCharacter();

        if (s5 !== peg$FAILED) {
          s4 = [s4, s5];
          s3 = s4;
        } else {
          peg$currPos = s3;
          s3 = peg$FAILED;
        }
      } else {
        peg$currPos = s3;
        s3 = peg$FAILED;
      }

      if (s3 !== peg$FAILED) {
        while (s3 !== peg$FAILED) {
          s2.push(s3);
          s3 = peg$currPos;
          s4 = peg$currPos;
          peg$silentFails++;

          if (peg$c142.test(input.charAt(peg$currPos))) {
            s5 = input.charAt(peg$currPos);
            peg$currPos++;
          } else {
            s5 = peg$FAILED;

            if (peg$silentFails === 0) {
              peg$fail(peg$c143);
            }
          }

          peg$silentFails--;

          if (s5 === peg$FAILED) {
            s4 = void 0;
          } else {
            peg$currPos = s4;
            s4 = peg$FAILED;
          }

          if (s4 !== peg$FAILED) {
            s5 = peg$parseSourceCharacter();

            if (s5 !== peg$FAILED) {
              s4 = [s4, s5];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$FAILED;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$FAILED;
          }
        }
      } else {
        s2 = peg$FAILED;
      }

      if (s2 === peg$FAILED) {
        s2 = peg$currPos;

        if (input.charCodeAt(peg$currPos) === 123) {
          s3 = peg$c137;
          peg$currPos++;
        } else {
          s3 = peg$FAILED;

          if (peg$silentFails === 0) {
            peg$fail(peg$c138);
          }
        }

        if (s3 !== peg$FAILED) {
          s4 = peg$parseCode();

          if (s4 !== peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 125) {
              s5 = peg$c139;
              peg$currPos++;
            } else {
              s5 = peg$FAILED;

              if (peg$silentFails === 0) {
                peg$fail(peg$c140);
              }
            }

            if (s5 !== peg$FAILED) {
              s3 = [s3, s4, s5];
              s2 = s3;
            } else {
              peg$currPos = s2;
              s2 = peg$FAILED;
            }
          } else {
            peg$currPos = s2;
            s2 = peg$FAILED;
          }
        } else {
          peg$currPos = s2;
          s2 = peg$FAILED;
        }
      }
    }

    if (s1 !== peg$FAILED) {
      s0 = input.substring(s0, peg$currPos);
    } else {
      s0 = s1;
    }

    return s0;
  }

  function peg$parseLl() {
    var s0;

    if (peg$c144.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c145);
      }
    }

    return s0;
  }

  function peg$parseLm() {
    var s0;

    if (peg$c146.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c147);
      }
    }

    return s0;
  }

  function peg$parseLo() {
    var s0;

    if (peg$c148.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c149);
      }
    }

    return s0;
  }

  function peg$parseLt() {
    var s0;

    if (peg$c150.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c151);
      }
    }

    return s0;
  }

  function peg$parseLu() {
    var s0;

    if (peg$c152.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c153);
      }
    }

    return s0;
  }

  function peg$parseMc() {
    var s0;

    if (peg$c154.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c155);
      }
    }

    return s0;
  }

  function peg$parseMn() {
    var s0;

    if (peg$c156.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c157);
      }
    }

    return s0;
  }

  function peg$parseNd() {
    var s0;

    if (peg$c158.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c159);
      }
    }

    return s0;
  }

  function peg$parseNl() {
    var s0;

    if (peg$c160.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c161);
      }
    }

    return s0;
  }

  function peg$parsePc() {
    var s0;

    if (peg$c162.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c163);
      }
    }

    return s0;
  }

  function peg$parseZs() {
    var s0;

    if (peg$c164.test(input.charAt(peg$currPos))) {
      s0 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s0 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c165);
      }
    }

    return s0;
  }

  function peg$parseBreakToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c166) {
      s1 = peg$c166;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c167);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseCaseToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c168) {
      s1 = peg$c168;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c169);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseCatchToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c170) {
      s1 = peg$c170;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c171);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseClassToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c172) {
      s1 = peg$c172;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c173);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseConstToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c174) {
      s1 = peg$c174;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c175);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseContinueToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 8) === peg$c176) {
      s1 = peg$c176;
      peg$currPos += 8;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c177);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseDebuggerToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 8) === peg$c178) {
      s1 = peg$c178;
      peg$currPos += 8;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c179);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseDefaultToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 7) === peg$c180) {
      s1 = peg$c180;
      peg$currPos += 7;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c181);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseDeleteToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c182) {
      s1 = peg$c182;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c183);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseDoToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c184) {
      s1 = peg$c184;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c185);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseElseToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c186) {
      s1 = peg$c186;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c187);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseEnumToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c188) {
      s1 = peg$c188;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c189);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseExportToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c190) {
      s1 = peg$c190;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c191);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseExtendsToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 7) === peg$c192) {
      s1 = peg$c192;
      peg$currPos += 7;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c193);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseFalseToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c194) {
      s1 = peg$c194;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c195);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseFinallyToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 7) === peg$c196) {
      s1 = peg$c196;
      peg$currPos += 7;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c197);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseForToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 3) === peg$c198) {
      s1 = peg$c198;
      peg$currPos += 3;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c199);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseFunctionToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 8) === peg$c200) {
      s1 = peg$c200;
      peg$currPos += 8;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c201);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseIfToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c202) {
      s1 = peg$c202;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c203);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseImportToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c204) {
      s1 = peg$c204;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c205);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseInstanceofToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 10) === peg$c206) {
      s1 = peg$c206;
      peg$currPos += 10;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c207);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseInToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 2) === peg$c208) {
      s1 = peg$c208;
      peg$currPos += 2;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c209);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseNewToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 3) === peg$c210) {
      s1 = peg$c210;
      peg$currPos += 3;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c211);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseNullToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c212) {
      s1 = peg$c212;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c213);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseReturnToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c214) {
      s1 = peg$c214;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c215);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSuperToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c216) {
      s1 = peg$c216;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c217);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseSwitchToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c218) {
      s1 = peg$c218;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c219);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseThisToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c220) {
      s1 = peg$c220;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c221);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseThrowToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c222) {
      s1 = peg$c222;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c223);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseTrueToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c224) {
      s1 = peg$c224;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c225);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseTryToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 3) === peg$c226) {
      s1 = peg$c226;
      peg$currPos += 3;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c227);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseTypeofToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 6) === peg$c228) {
      s1 = peg$c228;
      peg$currPos += 6;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c229);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseVarToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 3) === peg$c230) {
      s1 = peg$c230;
      peg$currPos += 3;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c231);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseVoidToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c232) {
      s1 = peg$c232;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c233);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseWhileToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 5) === peg$c234) {
      s1 = peg$c234;
      peg$currPos += 5;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c235);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parseWithToken() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;

    if (input.substr(peg$currPos, 4) === peg$c236) {
      s1 = peg$c236;
      peg$currPos += 4;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c237);
      }
    }

    if (s1 !== peg$FAILED) {
      s2 = peg$currPos;
      peg$silentFails++;
      s3 = peg$parseIdentifierPart();
      peg$silentFails--;

      if (s3 === peg$FAILED) {
        s2 = void 0;
      } else {
        peg$currPos = s2;
        s2 = peg$FAILED;
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  function peg$parse__() {
    var s0, s1;
    s0 = [];
    s1 = peg$parseWhiteSpace();

    if (s1 === peg$FAILED) {
      s1 = peg$parseLineTerminatorSequence();

      if (s1 === peg$FAILED) {
        s1 = peg$parseComment();
      }
    }

    while (s1 !== peg$FAILED) {
      s0.push(s1);
      s1 = peg$parseWhiteSpace();

      if (s1 === peg$FAILED) {
        s1 = peg$parseLineTerminatorSequence();

        if (s1 === peg$FAILED) {
          s1 = peg$parseComment();
        }
      }
    }

    return s0;
  }

  function peg$parse_() {
    var s0, s1;
    s0 = [];
    s1 = peg$parseWhiteSpace();

    if (s1 === peg$FAILED) {
      s1 = peg$parseMultiLineCommentNoLineTerminator();
    }

    while (s1 !== peg$FAILED) {
      s0.push(s1);
      s1 = peg$parseWhiteSpace();

      if (s1 === peg$FAILED) {
        s1 = peg$parseMultiLineCommentNoLineTerminator();
      }
    }

    return s0;
  }

  function peg$parseEOS() {
    var s0, s1, s2, s3;
    s0 = peg$currPos;
    s1 = peg$parse__();

    if (s1 !== peg$FAILED) {
      if (input.charCodeAt(peg$currPos) === 59) {
        s2 = peg$c238;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;

        if (peg$silentFails === 0) {
          peg$fail(peg$c239);
        }
      }

      if (s2 !== peg$FAILED) {
        s1 = [s1, s2];
        s0 = s1;
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    if (s0 === peg$FAILED) {
      s0 = peg$currPos;
      s1 = peg$parse_();

      if (s1 !== peg$FAILED) {
        s2 = peg$parseSingleLineComment();

        if (s2 === peg$FAILED) {
          s2 = null;
        }

        if (s2 !== peg$FAILED) {
          s3 = peg$parseLineTerminatorSequence();

          if (s3 !== peg$FAILED) {
            s1 = [s1, s2, s3];
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$FAILED;
      }

      if (s0 === peg$FAILED) {
        s0 = peg$currPos;
        s1 = peg$parse__();

        if (s1 !== peg$FAILED) {
          s2 = peg$parseEOF();

          if (s2 !== peg$FAILED) {
            s1 = [s1, s2];
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$FAILED;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$FAILED;
        }
      }
    }

    return s0;
  }

  function peg$parseEOF() {
    var s0, s1;
    s0 = peg$currPos;
    peg$silentFails++;

    if (input.length > peg$currPos) {
      s1 = input.charAt(peg$currPos);
      peg$currPos++;
    } else {
      s1 = peg$FAILED;

      if (peg$silentFails === 0) {
        peg$fail(peg$c34);
      }
    }

    peg$silentFails--;

    if (s1 === peg$FAILED) {
      s0 = void 0;
    } else {
      peg$currPos = s0;
      s0 = peg$FAILED;
    }

    return s0;
  }

  var OPS_TO_PREFIXED_TYPES = {
    "$": "text",
    "&": "simple_and",
    "!": "simple_not"
  };
  var OPS_TO_SUFFIXED_TYPES = {
    "?": "optional",
    "*": "zero_or_more",
    "+": "one_or_more"
  };
  var OPS_TO_SEMANTIC_PREDICATE_TYPES = {
    "&": "semantic_and",
    "!": "semantic_not"
  };

  function filterEmptyStrings(array) {
    var result = [],
        i;

    for (i = 0; i < array.length; i++) {
      if (array[i] !== "") {
        result.push(array[i]);
      }
    }

    return result;
  }

  function extractOptional(optional, index) {
    return optional ? optional[index] : null;
  }

  function extractList(list, index) {
    var result = new Array(list.length),
        i;

    for (i = 0; i < list.length; i++) {
      result[i] = list[i][index];
    }

    return result;
  }

  function buildList(head, tail, index) {
    return [head].concat(extractList(tail, index));
  }

  peg$result = peg$startRuleFunction();

  if (peg$result !== peg$FAILED && peg$currPos === input.length) {
    return peg$result;
  } else {
    if (peg$result !== peg$FAILED && peg$currPos < input.length) {
      peg$fail(peg$endExpectation());
    }

    throw peg$buildStructuredError(peg$maxFailExpected, peg$maxFailPos < input.length ? input.charAt(peg$maxFailPos) : null, peg$maxFailPos < input.length ? peg$computeLocation(peg$maxFailPos, peg$maxFailPos + 1) : peg$computeLocation(peg$maxFailPos, peg$maxFailPos));
  }
}

module.exports = {
  SyntaxError: peg$SyntaxError,
  parse: peg$parse
};
},{}],"NvoU":[function(require,module,exports) {
"use strict";

var objects = require("../utils/objects"),
    arrays = require("../utils/arrays");
/* Simple AST node visitor builder. */


var visitor = {
  build: function (functions) {
    function visit(node) {
      return functions[node.type].apply(null, arguments);
    }

    function visitNop() {}

    function visitExpression(node) {
      var extraArgs = Array.prototype.slice.call(arguments, 1);
      visit.apply(null, [node.expression].concat(extraArgs));
    }

    function visitChildren(property) {
      return function (node) {
        var extraArgs = Array.prototype.slice.call(arguments, 1);
        arrays.each(node[property], function (child) {
          visit.apply(null, [child].concat(extraArgs));
        });
      };
    }

    var DEFAULT_FUNCTIONS = {
      grammar: function (node) {
        var extraArgs = Array.prototype.slice.call(arguments, 1);

        if (node.initializer) {
          visit.apply(null, [node.initializer].concat(extraArgs));
        }

        arrays.each(node.rules, function (rule) {
          visit.apply(null, [rule].concat(extraArgs));
        });
      },
      initializer: visitNop,
      rule: visitExpression,
      named: visitExpression,
      choice: visitChildren("alternatives"),
      action: visitExpression,
      sequence: visitChildren("elements"),
      labeled: visitExpression,
      text: visitExpression,
      simple_and: visitExpression,
      simple_not: visitExpression,
      optional: visitExpression,
      zero_or_more: visitExpression,
      one_or_more: visitExpression,
      group: visitExpression,
      semantic_and: visitNop,
      semantic_not: visitNop,
      rule_ref: visitNop,
      literal: visitNop,
      "class": visitNop,
      any: visitNop
    };
    objects.defaults(functions, DEFAULT_FUNCTIONS);
    return visit;
  }
};
module.exports = visitor;
},{"../utils/objects":"1HYV","../utils/arrays":"mEVg"}],"WDMO":[function(require,module,exports) {
"use strict";

var arrays = require("../utils/arrays"),
    visitor = require("./visitor");
/* AST utilities. */


var asts = {
  findRule: function (ast, name) {
    return arrays.find(ast.rules, function (r) {
      return r.name === name;
    });
  },
  indexOfRule: function (ast, name) {
    return arrays.indexOf(ast.rules, function (r) {
      return r.name === name;
    });
  },
  alwaysConsumesOnSuccess: function (ast, node) {
    function consumesTrue() {
      return true;
    }

    function consumesFalse() {
      return false;
    }

    function consumesExpression(node) {
      return consumes(node.expression);
    }

    var consumes = visitor.build({
      rule: consumesExpression,
      named: consumesExpression,
      choice: function (node) {
        return arrays.every(node.alternatives, consumes);
      },
      action: consumesExpression,
      sequence: function (node) {
        return arrays.some(node.elements, consumes);
      },
      labeled: consumesExpression,
      text: consumesExpression,
      simple_and: consumesFalse,
      simple_not: consumesFalse,
      optional: consumesFalse,
      zero_or_more: consumesFalse,
      one_or_more: consumesExpression,
      group: consumesExpression,
      semantic_and: consumesFalse,
      semantic_not: consumesFalse,
      rule_ref: function (node) {
        return consumes(asts.findRule(ast, node.name));
      },
      literal: function (node) {
        return node.value !== "";
      },
      "class": consumesTrue,
      any: consumesTrue
    });
    return consumes(node);
  }
};
module.exports = asts;
},{"../utils/arrays":"mEVg","./visitor":"NvoU"}],"sC2i":[function(require,module,exports) {
"use strict";

var GrammarError = require("../../grammar-error"),
    asts = require("../asts"),
    visitor = require("../visitor");
/* Checks that all referenced rules exist. */


function reportUndefinedRules(ast) {
  var check = visitor.build({
    rule_ref: function (node) {
      if (!asts.findRule(ast, node.name)) {
        throw new GrammarError("Rule \"" + node.name + "\" is not defined.", node.location);
      }
    }
  });
  check(ast);
}

module.exports = reportUndefinedRules;
},{"../../grammar-error":"vvJ7","../asts":"WDMO","../visitor":"NvoU"}],"nxhj":[function(require,module,exports) {
"use strict";

var GrammarError = require("../../grammar-error"),
    visitor = require("../visitor");
/* Checks that each rule is defined only once. */


function reportDuplicateRules(ast) {
  var rules = {};
  var check = visitor.build({
    rule: function (node) {
      if (rules.hasOwnProperty(node.name)) {
        throw new GrammarError("Rule \"" + node.name + "\" is already defined " + "at line " + rules[node.name].start.line + ", " + "column " + rules[node.name].start.column + ".", node.location);
      }

      rules[node.name] = node.location;
    }
  });
  check(ast);
}

module.exports = reportDuplicateRules;
},{"../../grammar-error":"vvJ7","../visitor":"NvoU"}],"l5oL":[function(require,module,exports) {
"use strict";

var GrammarError = require("../../grammar-error"),
    arrays = require("../../utils/arrays"),
    objects = require("../../utils/objects"),
    visitor = require("../visitor");
/* Checks that each label is defined only once within each scope. */


function reportDuplicateLabels(ast) {
  function checkExpressionWithClonedEnv(node, env) {
    check(node.expression, objects.clone(env));
  }

  var check = visitor.build({
    rule: function (node) {
      check(node.expression, {});
    },
    choice: function (node, env) {
      arrays.each(node.alternatives, function (alternative) {
        check(alternative, objects.clone(env));
      });
    },
    action: checkExpressionWithClonedEnv,
    labeled: function (node, env) {
      if (env.hasOwnProperty(node.label)) {
        throw new GrammarError("Label \"" + node.label + "\" is already defined " + "at line " + env[node.label].start.line + ", " + "column " + env[node.label].start.column + ".", node.location);
      }

      check(node.expression, env);
      env[node.label] = node.location;
    },
    text: checkExpressionWithClonedEnv,
    simple_and: checkExpressionWithClonedEnv,
    simple_not: checkExpressionWithClonedEnv,
    optional: checkExpressionWithClonedEnv,
    zero_or_more: checkExpressionWithClonedEnv,
    one_or_more: checkExpressionWithClonedEnv,
    group: checkExpressionWithClonedEnv
  });
  check(ast);
}

module.exports = reportDuplicateLabels;
},{"../../grammar-error":"vvJ7","../../utils/arrays":"mEVg","../../utils/objects":"1HYV","../visitor":"NvoU"}],"AOtE":[function(require,module,exports) {
"use strict";

var arrays = require("../../utils/arrays"),
    GrammarError = require("../../grammar-error"),
    asts = require("../asts"),
    visitor = require("../visitor");
/*
 * Reports left recursion in the grammar, which prevents infinite recursion in
 * the generated parser.
 *
 * Both direct and indirect recursion is detected. The pass also correctly
 * reports cases like this:
 *
 *   start = "a"? start
 *
 * In general, if a rule reference can be reached without consuming any input,
 * it can lead to left recursion.
 */


function reportInfiniteRecursion(ast) {
  var visitedRules = [];
  var check = visitor.build({
    rule: function (node) {
      visitedRules.push(node.name);
      check(node.expression);
      visitedRules.pop(node.name);
    },
    sequence: function (node) {
      arrays.every(node.elements, function (element) {
        check(element);
        return !asts.alwaysConsumesOnSuccess(ast, element);
      });
    },
    rule_ref: function (node) {
      if (arrays.contains(visitedRules, node.name)) {
        visitedRules.push(node.name);
        throw new GrammarError("Possible infinite loop when parsing (left recursion: " + visitedRules.join(" -> ") + ").", node.location);
      }

      check(asts.findRule(ast, node.name));
    }
  });
  check(ast);
}

module.exports = reportInfiniteRecursion;
},{"../../utils/arrays":"mEVg","../../grammar-error":"vvJ7","../asts":"WDMO","../visitor":"NvoU"}],"9xzp":[function(require,module,exports) {
"use strict";

var GrammarError = require("../../grammar-error"),
    asts = require("../asts"),
    visitor = require("../visitor");
/*
 * Reports expressions that don't consume any input inside |*| or |+| in the
 * grammar, which prevents infinite loops in the generated parser.
 */


function reportInfiniteRepetition(ast) {
  var check = visitor.build({
    zero_or_more: function (node) {
      if (!asts.alwaysConsumesOnSuccess(ast, node.expression)) {
        throw new GrammarError("Possible infinite loop when parsing (repetition used with an expression that may not consume any input).", node.location);
      }
    },
    one_or_more: function (node) {
      if (!asts.alwaysConsumesOnSuccess(ast, node.expression)) {
        throw new GrammarError("Possible infinite loop when parsing (repetition used with an expression that may not consume any input).", node.location);
      }
    }
  });
  check(ast);
}

module.exports = reportInfiniteRepetition;
},{"../../grammar-error":"vvJ7","../asts":"WDMO","../visitor":"NvoU"}],"oWvK":[function(require,module,exports) {
"use strict";

var arrays = require("../../utils/arrays"),
    visitor = require("../visitor");
/*
 * Removes proxy rules -- that is, rules that only delegate to other rule.
 */


function removeProxyRules(ast, options) {
  function isProxyRule(node) {
    return node.type === "rule" && node.expression.type === "rule_ref";
  }

  function replaceRuleRefs(ast, from, to) {
    var replace = visitor.build({
      rule_ref: function (node) {
        if (node.name === from) {
          node.name = to;
        }
      }
    });
    replace(ast);
  }

  var indices = [];
  arrays.each(ast.rules, function (rule, i) {
    if (isProxyRule(rule)) {
      replaceRuleRefs(ast, rule.name, rule.expression.name);

      if (!arrays.contains(options.allowedStartRules, rule.name)) {
        indices.push(i);
      }
    }
  });
  indices.reverse();
  arrays.each(indices, function (i) {
    ast.rules.splice(i, 1);
  });
}

module.exports = removeProxyRules;
},{"../../utils/arrays":"mEVg","../visitor":"NvoU"}],"3S6x":[function(require,module,exports) {
"use strict";
/* Bytecode instruction opcodes. */

var opcodes = {
  /* Stack Manipulation */
  PUSH: 0,
  // PUSH c
  PUSH_UNDEFINED: 1,
  // PUSH_UNDEFINED
  PUSH_NULL: 2,
  // PUSH_NULL
  PUSH_FAILED: 3,
  // PUSH_FAILED
  PUSH_EMPTY_ARRAY: 4,
  // PUSH_EMPTY_ARRAY
  PUSH_CURR_POS: 5,
  // PUSH_CURR_POS
  POP: 6,
  // POP
  POP_CURR_POS: 7,
  // POP_CURR_POS
  POP_N: 8,
  // POP_N n
  NIP: 9,
  // NIP
  APPEND: 10,
  // APPEND
  WRAP: 11,
  // WRAP n
  TEXT: 12,
  // TEXT

  /* Conditions and Loops */
  IF: 13,
  // IF t, f
  IF_ERROR: 14,
  // IF_ERROR t, f
  IF_NOT_ERROR: 15,
  // IF_NOT_ERROR t, f
  WHILE_NOT_ERROR: 16,
  // WHILE_NOT_ERROR b

  /* Matching */
  MATCH_ANY: 17,
  // MATCH_ANY a, f, ...
  MATCH_STRING: 18,
  // MATCH_STRING s, a, f, ...
  MATCH_STRING_IC: 19,
  // MATCH_STRING_IC s, a, f, ...
  MATCH_REGEXP: 20,
  // MATCH_REGEXP r, a, f, ...
  ACCEPT_N: 21,
  // ACCEPT_N n
  ACCEPT_STRING: 22,
  // ACCEPT_STRING s
  FAIL: 23,
  // FAIL e

  /* Calls */
  LOAD_SAVED_POS: 24,
  // LOAD_SAVED_POS p
  UPDATE_SAVED_POS: 25,
  // UPDATE_SAVED_POS
  CALL: 26,
  // CALL f, n, pc, p1, p2, ..., pN

  /* Rules */
  RULE: 27,
  // RULE r

  /* Failure Reporting */
  SILENT_FAILS_ON: 28,
  // SILENT_FAILS_ON
  SILENT_FAILS_OFF: 29 // SILENT_FAILS_OFF

};
module.exports = opcodes;
},{}],"4CFN":[function(require,module,exports) {
"use strict";

function hex(ch) {
  return ch.charCodeAt(0).toString(16).toUpperCase();
}
/* JavaScript code generation helpers. */


var js = {
  stringEscape: function (s) {
    /*
     * ECMA-262, 5th ed., 7.8.4: All characters may appear literally in a string
     * literal except for the closing quote character, backslash, carriage
     * return, line separator, paragraph separator, and line feed. Any character
     * may appear in the form of an escape sequence.
     *
     * For portability, we also escape all control and non-ASCII characters.
     * Note that the "\v" escape sequence is not used because IE does not like
     * it.
     */
    return s.replace(/\\/g, '\\\\') // backslash
    .replace(/"/g, '\\"') // closing double quote
    .replace(/\0/g, '\\0') // null
    .replace(/\x08/g, '\\b') // backspace
    .replace(/\t/g, '\\t') // horizontal tab
    .replace(/\n/g, '\\n') // line feed
    .replace(/\f/g, '\\f') // form feed
    .replace(/\r/g, '\\r') // carriage return
    .replace(/[\x00-\x0F]/g, function (ch) {
      return '\\x0' + hex(ch);
    }).replace(/[\x10-\x1F\x7F-\xFF]/g, function (ch) {
      return '\\x' + hex(ch);
    }).replace(/[\u0100-\u0FFF]/g, function (ch) {
      return '\\u0' + hex(ch);
    }).replace(/[\u1000-\uFFFF]/g, function (ch) {
      return '\\u' + hex(ch);
    });
  },
  regexpClassEscape: function (s) {
    /*
     * Based on ECMA-262, 5th ed., 7.8.5 & 15.10.1.
     *
     * For portability, we also escape all control and non-ASCII characters.
     */
    return s.replace(/\\/g, '\\\\') // backslash
    .replace(/\//g, '\\/') // closing slash
    .replace(/\]/g, '\\]') // closing bracket
    .replace(/\^/g, '\\^') // caret
    .replace(/-/g, '\\-') // dash
    .replace(/\0/g, '\\0') // null
    .replace(/\t/g, '\\t') // horizontal tab
    .replace(/\n/g, '\\n') // line feed
    .replace(/\v/g, '\\x0B') // vertical tab
    .replace(/\f/g, '\\f') // form feed
    .replace(/\r/g, '\\r') // carriage return
    .replace(/[\x00-\x0F]/g, function (ch) {
      return '\\x0' + hex(ch);
    }).replace(/[\x10-\x1F\x7F-\xFF]/g, function (ch) {
      return '\\x' + hex(ch);
    }).replace(/[\u0100-\u0FFF]/g, function (ch) {
      return '\\u0' + hex(ch);
    }).replace(/[\u1000-\uFFFF]/g, function (ch) {
      return '\\u' + hex(ch);
    });
  }
};
module.exports = js;
},{}],"bclG":[function(require,module,exports) {
"use strict";

var arrays = require("../../utils/arrays"),
    objects = require("../../utils/objects"),
    asts = require("../asts"),
    visitor = require("../visitor"),
    op = require("../opcodes"),
    js = require("../js");
/* Generates bytecode.
 *
 * Instructions
 * ============
 *
 * Stack Manipulation
 * ------------------
 *
 *  [0] PUSH c
 *
 *        stack.push(consts[c]);
 *
 *  [1] PUSH_UNDEFINED
 *
 *        stack.push(undefined);
 *
 *  [2] PUSH_NULL
 *
 *        stack.push(null);
 *
 *  [3] PUSH_FAILED
 *
 *        stack.push(FAILED);
 *
 *  [4] PUSH_EMPTY_ARRAY
 *
 *        stack.push([]);
 *
 *  [5] PUSH_CURR_POS
 *
 *        stack.push(currPos);
 *
 *  [6] POP
 *
 *        stack.pop();
 *
 *  [7] POP_CURR_POS
 *
 *        currPos = stack.pop();
 *
 *  [8] POP_N n
 *
 *        stack.pop(n);
 *
 *  [9] NIP
 *
 *        value = stack.pop();
 *        stack.pop();
 *        stack.push(value);
 *
 * [10] APPEND
 *
 *        value = stack.pop();
 *        array = stack.pop();
 *        array.push(value);
 *        stack.push(array);
 *
 * [11] WRAP n
 *
 *        stack.push(stack.pop(n));
 *
 * [12] TEXT
 *
 *        stack.push(input.substring(stack.pop(), currPos));
 *
 * Conditions and Loops
 * --------------------
 *
 * [13] IF t, f
 *
 *        if (stack.top()) {
 *          interpret(ip + 3, ip + 3 + t);
 *        } else {
 *          interpret(ip + 3 + t, ip + 3 + t + f);
 *        }
 *
 * [14] IF_ERROR t, f
 *
 *        if (stack.top() === FAILED) {
 *          interpret(ip + 3, ip + 3 + t);
 *        } else {
 *          interpret(ip + 3 + t, ip + 3 + t + f);
 *        }
 *
 * [15] IF_NOT_ERROR t, f
 *
 *        if (stack.top() !== FAILED) {
 *          interpret(ip + 3, ip + 3 + t);
 *        } else {
 *          interpret(ip + 3 + t, ip + 3 + t + f);
 *        }
 *
 * [16] WHILE_NOT_ERROR b
 *
 *        while(stack.top() !== FAILED) {
 *          interpret(ip + 2, ip + 2 + b);
 *        }
 *
 * Matching
 * --------
 *
 * [17] MATCH_ANY a, f, ...
 *
 *        if (input.length > currPos) {
 *          interpret(ip + 3, ip + 3 + a);
 *        } else {
 *          interpret(ip + 3 + a, ip + 3 + a + f);
 *        }
 *
 * [18] MATCH_STRING s, a, f, ...
 *
 *        if (input.substr(currPos, consts[s].length) === consts[s]) {
 *          interpret(ip + 4, ip + 4 + a);
 *        } else {
 *          interpret(ip + 4 + a, ip + 4 + a + f);
 *        }
 *
 * [19] MATCH_STRING_IC s, a, f, ...
 *
 *        if (input.substr(currPos, consts[s].length).toLowerCase() === consts[s]) {
 *          interpret(ip + 4, ip + 4 + a);
 *        } else {
 *          interpret(ip + 4 + a, ip + 4 + a + f);
 *        }
 *
 * [20] MATCH_REGEXP r, a, f, ...
 *
 *        if (consts[r].test(input.charAt(currPos))) {
 *          interpret(ip + 4, ip + 4 + a);
 *        } else {
 *          interpret(ip + 4 + a, ip + 4 + a + f);
 *        }
 *
 * [21] ACCEPT_N n
 *
 *        stack.push(input.substring(currPos, n));
 *        currPos += n;
 *
 * [22] ACCEPT_STRING s
 *
 *        stack.push(consts[s]);
 *        currPos += consts[s].length;
 *
 * [23] FAIL e
 *
 *        stack.push(FAILED);
 *        fail(consts[e]);
 *
 * Calls
 * -----
 *
 * [24] LOAD_SAVED_POS p
 *
 *        savedPos = stack[p];
 *
 * [25] UPDATE_SAVED_POS
 *
 *        savedPos = currPos;
 *
 * [26] CALL f, n, pc, p1, p2, ..., pN
 *
 *        value = consts[f](stack[p1], ..., stack[pN]);
 *        stack.pop(n);
 *        stack.push(value);
 *
 * Rules
 * -----
 *
 * [27] RULE r
 *
 *        stack.push(parseRule(r));
 *
 * Failure Reporting
 * -----------------
 *
 * [28] SILENT_FAILS_ON
 *
 *        silentFails++;
 *
 * [29] SILENT_FAILS_OFF
 *
 *        silentFails--;
 */


function generateBytecode(ast) {
  var consts = [];

  function addConst(value) {
    var index = arrays.indexOf(consts, value);
    return index === -1 ? consts.push(value) - 1 : index;
  }

  function addFunctionConst(params, code) {
    return addConst("function(" + params.join(", ") + ") {" + code + "}");
  }

  function buildSequence() {
    return Array.prototype.concat.apply([], arguments);
  }

  function buildCondition(condCode, thenCode, elseCode) {
    return condCode.concat([thenCode.length, elseCode.length], thenCode, elseCode);
  }

  function buildLoop(condCode, bodyCode) {
    return condCode.concat([bodyCode.length], bodyCode);
  }

  function buildCall(functionIndex, delta, env, sp) {
    var params = arrays.map(objects.values(env), function (p) {
      return sp - p;
    });
    return [op.CALL, functionIndex, delta, params.length].concat(params);
  }

  function buildSimplePredicate(expression, negative, context) {
    return buildSequence([op.PUSH_CURR_POS], [op.SILENT_FAILS_ON], generate(expression, {
      sp: context.sp + 1,
      env: objects.clone(context.env),
      action: null
    }), [op.SILENT_FAILS_OFF], buildCondition([negative ? op.IF_ERROR : op.IF_NOT_ERROR], buildSequence([op.POP], [negative ? op.POP : op.POP_CURR_POS], [op.PUSH_UNDEFINED]), buildSequence([op.POP], [negative ? op.POP_CURR_POS : op.POP], [op.PUSH_FAILED])));
  }

  function buildSemanticPredicate(code, negative, context) {
    var functionIndex = addFunctionConst(objects.keys(context.env), code);
    return buildSequence([op.UPDATE_SAVED_POS], buildCall(functionIndex, 0, context.env, context.sp), buildCondition([op.IF], buildSequence([op.POP], negative ? [op.PUSH_FAILED] : [op.PUSH_UNDEFINED]), buildSequence([op.POP], negative ? [op.PUSH_UNDEFINED] : [op.PUSH_FAILED])));
  }

  function buildAppendLoop(expressionCode) {
    return buildLoop([op.WHILE_NOT_ERROR], buildSequence([op.APPEND], expressionCode));
  }

  var generate = visitor.build({
    grammar: function (node) {
      arrays.each(node.rules, generate);
      node.consts = consts;
    },
    rule: function (node) {
      node.bytecode = generate(node.expression, {
        sp: -1,
        // stack pointer
        env: {},
        // mapping of label names to stack positions
        action: null // action nodes pass themselves to children here

      });
    },
    named: function (node, context) {
      var nameIndex = addConst('peg$otherExpectation("' + js.stringEscape(node.name) + '")');
      /*
       * The code generated below is slightly suboptimal because |FAIL| pushes
       * to the stack, so we need to stick a |POP| in front of it. We lack a
       * dedicated instruction that would just report the failure and not touch
       * the stack.
       */

      return buildSequence([op.SILENT_FAILS_ON], generate(node.expression, context), [op.SILENT_FAILS_OFF], buildCondition([op.IF_ERROR], [op.FAIL, nameIndex], []));
    },
    choice: function (node, context) {
      function buildAlternativesCode(alternatives, context) {
        return buildSequence(generate(alternatives[0], {
          sp: context.sp,
          env: objects.clone(context.env),
          action: null
        }), alternatives.length > 1 ? buildCondition([op.IF_ERROR], buildSequence([op.POP], buildAlternativesCode(alternatives.slice(1), context)), []) : []);
      }

      return buildAlternativesCode(node.alternatives, context);
    },
    action: function (node, context) {
      var env = objects.clone(context.env),
          emitCall = node.expression.type !== "sequence" || node.expression.elements.length === 0,
          expressionCode = generate(node.expression, {
        sp: context.sp + (emitCall ? 1 : 0),
        env: env,
        action: node
      }),
          functionIndex = addFunctionConst(objects.keys(env), node.code);
      return emitCall ? buildSequence([op.PUSH_CURR_POS], expressionCode, buildCondition([op.IF_NOT_ERROR], buildSequence([op.LOAD_SAVED_POS, 1], buildCall(functionIndex, 1, env, context.sp + 2)), []), [op.NIP]) : expressionCode;
    },
    sequence: function (node, context) {
      function buildElementsCode(elements, context) {
        var processedCount, functionIndex;

        if (elements.length > 0) {
          processedCount = node.elements.length - elements.slice(1).length;
          return buildSequence(generate(elements[0], {
            sp: context.sp,
            env: context.env,
            action: null
          }), buildCondition([op.IF_NOT_ERROR], buildElementsCode(elements.slice(1), {
            sp: context.sp + 1,
            env: context.env,
            action: context.action
          }), buildSequence(processedCount > 1 ? [op.POP_N, processedCount] : [op.POP], [op.POP_CURR_POS], [op.PUSH_FAILED])));
        } else {
          if (context.action) {
            functionIndex = addFunctionConst(objects.keys(context.env), context.action.code);
            return buildSequence([op.LOAD_SAVED_POS, node.elements.length], buildCall(functionIndex, node.elements.length, context.env, context.sp), [op.NIP]);
          } else {
            return buildSequence([op.WRAP, node.elements.length], [op.NIP]);
          }
        }
      }

      return buildSequence([op.PUSH_CURR_POS], buildElementsCode(node.elements, {
        sp: context.sp + 1,
        env: context.env,
        action: context.action
      }));
    },
    labeled: function (node, context) {
      var env = objects.clone(context.env);
      context.env[node.label] = context.sp + 1;
      return generate(node.expression, {
        sp: context.sp,
        env: env,
        action: null
      });
    },
    text: function (node, context) {
      return buildSequence([op.PUSH_CURR_POS], generate(node.expression, {
        sp: context.sp + 1,
        env: objects.clone(context.env),
        action: null
      }), buildCondition([op.IF_NOT_ERROR], buildSequence([op.POP], [op.TEXT]), [op.NIP]));
    },
    simple_and: function (node, context) {
      return buildSimplePredicate(node.expression, false, context);
    },
    simple_not: function (node, context) {
      return buildSimplePredicate(node.expression, true, context);
    },
    optional: function (node, context) {
      return buildSequence(generate(node.expression, {
        sp: context.sp,
        env: objects.clone(context.env),
        action: null
      }), buildCondition([op.IF_ERROR], buildSequence([op.POP], [op.PUSH_NULL]), []));
    },
    zero_or_more: function (node, context) {
      var expressionCode = generate(node.expression, {
        sp: context.sp + 1,
        env: objects.clone(context.env),
        action: null
      });
      return buildSequence([op.PUSH_EMPTY_ARRAY], expressionCode, buildAppendLoop(expressionCode), [op.POP]);
    },
    one_or_more: function (node, context) {
      var expressionCode = generate(node.expression, {
        sp: context.sp + 1,
        env: objects.clone(context.env),
        action: null
      });
      return buildSequence([op.PUSH_EMPTY_ARRAY], expressionCode, buildCondition([op.IF_NOT_ERROR], buildSequence(buildAppendLoop(expressionCode), [op.POP]), buildSequence([op.POP], [op.POP], [op.PUSH_FAILED])));
    },
    group: function (node, context) {
      return generate(node.expression, {
        sp: context.sp,
        env: objects.clone(context.env),
        action: null
      });
    },
    semantic_and: function (node, context) {
      return buildSemanticPredicate(node.code, false, context);
    },
    semantic_not: function (node, context) {
      return buildSemanticPredicate(node.code, true, context);
    },
    rule_ref: function (node) {
      return [op.RULE, asts.indexOfRule(ast, node.name)];
    },
    literal: function (node) {
      var stringIndex, expectedIndex;

      if (node.value.length > 0) {
        stringIndex = addConst('"' + js.stringEscape(node.ignoreCase ? node.value.toLowerCase() : node.value) + '"');
        expectedIndex = addConst('peg$literalExpectation(' + '"' + js.stringEscape(node.value) + '", ' + node.ignoreCase + ')');
        /*
         * For case-sensitive strings the value must match the beginning of the
         * remaining input exactly. As a result, we can use |ACCEPT_STRING| and
         * save one |substr| call that would be needed if we used |ACCEPT_N|.
         */

        return buildCondition(node.ignoreCase ? [op.MATCH_STRING_IC, stringIndex] : [op.MATCH_STRING, stringIndex], node.ignoreCase ? [op.ACCEPT_N, node.value.length] : [op.ACCEPT_STRING, stringIndex], [op.FAIL, expectedIndex]);
      } else {
        stringIndex = addConst('""');
        return [op.PUSH, stringIndex];
      }
    },
    "class": function (node) {
      var regexp, parts, regexpIndex, expectedIndex;

      if (node.parts.length > 0) {
        regexp = '/^[' + (node.inverted ? '^' : '') + arrays.map(node.parts, function (part) {
          return part instanceof Array ? js.regexpClassEscape(part[0]) + '-' + js.regexpClassEscape(part[1]) : js.regexpClassEscape(part);
        }).join('') + ']/' + (node.ignoreCase ? 'i' : '');
      } else {
        /*
         * IE considers regexps /[]/ and /[^]/ as syntactically invalid, so we
         * translate them into equivalents it can handle.
         */
        regexp = node.inverted ? '/^[\\S\\s]/' : '/^(?!)/';
      }

      parts = '[' + arrays.map(node.parts, function (part) {
        return part instanceof Array ? '["' + js.stringEscape(part[0]) + '", "' + js.stringEscape(part[1]) + '"]' : '"' + js.stringEscape(part) + '"';
      }).join(', ') + ']';
      regexpIndex = addConst(regexp);
      expectedIndex = addConst('peg$classExpectation(' + parts + ', ' + node.inverted + ', ' + node.ignoreCase + ')');
      return buildCondition([op.MATCH_REGEXP, regexpIndex], [op.ACCEPT_N, 1], [op.FAIL, expectedIndex]);
    },
    any: function () {
      var expectedIndex = addConst('peg$anyExpectation()');
      return buildCondition([op.MATCH_ANY], [op.ACCEPT_N, 1], [op.FAIL, expectedIndex]);
    }
  });
  generate(ast);
}

module.exports = generateBytecode;
},{"../../utils/arrays":"mEVg","../../utils/objects":"1HYV","../asts":"WDMO","../visitor":"NvoU","../opcodes":"3S6x","../js":"4CFN"}],"j2YI":[function(require,module,exports) {
"use strict";

var arrays = require("../../utils/arrays"),
    objects = require("../../utils/objects"),
    asts = require("../asts"),
    op = require("../opcodes"),
    js = require("../js");
/* Generates parser JavaScript code. */


function generateJS(ast, options) {
  /* These only indent non-empty lines to avoid trailing whitespace. */
  function indent2(code) {
    return code.replace(/^(.+)$/gm, '  $1');
  }

  function indent6(code) {
    return code.replace(/^(.+)$/gm, '      $1');
  }

  function indent10(code) {
    return code.replace(/^(.+)$/gm, '          $1');
  }

  function generateTables() {
    if (options.optimize === "size") {
      return ['peg$consts = [', indent2(ast.consts.join(',\n')), '],', '', 'peg$bytecode = [', indent2(arrays.map(ast.rules, function (rule) {
        return 'peg$decode("' + js.stringEscape(arrays.map(rule.bytecode, function (b) {
          return String.fromCharCode(b + 32);
        }).join('')) + '")';
      }).join(',\n')), '],'].join('\n');
    } else {
      return arrays.map(ast.consts, function (c, i) {
        return 'peg$c' + i + ' = ' + c + ',';
      }).join('\n');
    }
  }

  function generateRuleHeader(ruleNameCode, ruleIndexCode) {
    var parts = [];
    parts.push('');

    if (options.trace) {
      parts.push(['peg$tracer.trace({', '  type:     "rule.enter",', '  rule:     ' + ruleNameCode + ',', '  location: peg$computeLocation(startPos, startPos)', '});', ''].join('\n'));
    }

    if (options.cache) {
      parts.push(['var key    = peg$currPos * ' + ast.rules.length + ' + ' + ruleIndexCode + ',', '    cached = peg$resultsCache[key];', '', 'if (cached) {', '  peg$currPos = cached.nextPos;', ''].join('\n'));

      if (options.trace) {
        parts.push(['if (cached.result !== peg$FAILED) {', '  peg$tracer.trace({', '    type:   "rule.match",', '    rule:   ' + ruleNameCode + ',', '    result: cached.result,', '    location: peg$computeLocation(startPos, peg$currPos)', '  });', '} else {', '  peg$tracer.trace({', '    type: "rule.fail",', '    rule: ' + ruleNameCode + ',', '    location: peg$computeLocation(startPos, startPos)', '  });', '}', ''].join('\n'));
      }

      parts.push(['  return cached.result;', '}', ''].join('\n'));
    }

    return parts.join('\n');
  }

  function generateRuleFooter(ruleNameCode, resultCode) {
    var parts = [];

    if (options.cache) {
      parts.push(['', 'peg$resultsCache[key] = { nextPos: peg$currPos, result: ' + resultCode + ' };'].join('\n'));
    }

    if (options.trace) {
      parts.push(['', 'if (' + resultCode + ' !== peg$FAILED) {', '  peg$tracer.trace({', '    type:   "rule.match",', '    rule:   ' + ruleNameCode + ',', '    result: ' + resultCode + ',', '    location: peg$computeLocation(startPos, peg$currPos)', '  });', '} else {', '  peg$tracer.trace({', '    type: "rule.fail",', '    rule: ' + ruleNameCode + ',', '    location: peg$computeLocation(startPos, startPos)', '  });', '}'].join('\n'));
    }

    parts.push(['', 'return ' + resultCode + ';'].join('\n'));
    return parts.join('\n');
  }

  function generateInterpreter() {
    var parts = [];

    function generateCondition(cond, argsLength) {
      var baseLength = argsLength + 3,
          thenLengthCode = 'bc[ip + ' + (baseLength - 2) + ']',
          elseLengthCode = 'bc[ip + ' + (baseLength - 1) + ']';
      return ['ends.push(end);', 'ips.push(ip + ' + baseLength + ' + ' + thenLengthCode + ' + ' + elseLengthCode + ');', '', 'if (' + cond + ') {', '  end = ip + ' + baseLength + ' + ' + thenLengthCode + ';', '  ip += ' + baseLength + ';', '} else {', '  end = ip + ' + baseLength + ' + ' + thenLengthCode + ' + ' + elseLengthCode + ';', '  ip += ' + baseLength + ' + ' + thenLengthCode + ';', '}', '', 'break;'].join('\n');
    }

    function generateLoop(cond) {
      var baseLength = 2,
          bodyLengthCode = 'bc[ip + ' + (baseLength - 1) + ']';
      return ['if (' + cond + ') {', '  ends.push(end);', '  ips.push(ip);', '', '  end = ip + ' + baseLength + ' + ' + bodyLengthCode + ';', '  ip += ' + baseLength + ';', '} else {', '  ip += ' + baseLength + ' + ' + bodyLengthCode + ';', '}', '', 'break;'].join('\n');
    }

    function generateCall() {
      var baseLength = 4,
          paramsLengthCode = 'bc[ip + ' + (baseLength - 1) + ']';
      return ['params = bc.slice(ip + ' + baseLength + ', ip + ' + baseLength + ' + ' + paramsLengthCode + ');', 'for (i = 0; i < ' + paramsLengthCode + '; i++) {', '  params[i] = stack[stack.length - 1 - params[i]];', '}', '', 'stack.splice(', '  stack.length - bc[ip + 2],', '  bc[ip + 2],', '  peg$consts[bc[ip + 1]].apply(null, params)', ');', '', 'ip += ' + baseLength + ' + ' + paramsLengthCode + ';', 'break;'].join('\n');
    }

    parts.push(['function peg$decode(s) {', '  var bc = new Array(s.length), i;', '', '  for (i = 0; i < s.length; i++) {', '    bc[i] = s.charCodeAt(i) - 32;', '  }', '', '  return bc;', '}', '', 'function peg$parseRule(index) {'].join('\n'));

    if (options.trace) {
      parts.push(['  var bc       = peg$bytecode[index],', '      ip       = 0,', '      ips      = [],', '      end      = bc.length,', '      ends     = [],', '      stack    = [],', '      startPos = peg$currPos,', '      params, i;'].join('\n'));
    } else {
      parts.push(['  var bc    = peg$bytecode[index],', '      ip    = 0,', '      ips   = [],', '      end   = bc.length,', '      ends  = [],', '      stack = [],', '      params, i;'].join('\n'));
    }

    parts.push(indent2(generateRuleHeader('peg$ruleNames[index]', 'index')));
    parts.push([
    /*
     * The point of the outer loop and the |ips| & |ends| stacks is to avoid
     * recursive calls for interpreting parts of bytecode. In other words, we
     * implement the |interpret| operation of the abstract machine without
     * function calls. Such calls would likely slow the parser down and more
     * importantly cause stack overflows for complex grammars.
     */
    '  while (true) {', '    while (ip < end) {', '      switch (bc[ip]) {', '        case ' + op.PUSH + ':', // PUSH c
    '          stack.push(peg$consts[bc[ip + 1]]);', '          ip += 2;', '          break;', '', '        case ' + op.PUSH_UNDEFINED + ':', // PUSH_UNDEFINED
    '          stack.push(void 0);', '          ip++;', '          break;', '', '        case ' + op.PUSH_NULL + ':', // PUSH_NULL
    '          stack.push(null);', '          ip++;', '          break;', '', '        case ' + op.PUSH_FAILED + ':', // PUSH_FAILED
    '          stack.push(peg$FAILED);', '          ip++;', '          break;', '', '        case ' + op.PUSH_EMPTY_ARRAY + ':', // PUSH_EMPTY_ARRAY
    '          stack.push([]);', '          ip++;', '          break;', '', '        case ' + op.PUSH_CURR_POS + ':', // PUSH_CURR_POS
    '          stack.push(peg$currPos);', '          ip++;', '          break;', '', '        case ' + op.POP + ':', // POP
    '          stack.pop();', '          ip++;', '          break;', '', '        case ' + op.POP_CURR_POS + ':', // POP_CURR_POS
    '          peg$currPos = stack.pop();', '          ip++;', '          break;', '', '        case ' + op.POP_N + ':', // POP_N n
    '          stack.length -= bc[ip + 1];', '          ip += 2;', '          break;', '', '        case ' + op.NIP + ':', // NIP
    '          stack.splice(-2, 1);', '          ip++;', '          break;', '', '        case ' + op.APPEND + ':', // APPEND
    '          stack[stack.length - 2].push(stack.pop());', '          ip++;', '          break;', '', '        case ' + op.WRAP + ':', // WRAP n
    '          stack.push(stack.splice(stack.length - bc[ip + 1], bc[ip + 1]));', '          ip += 2;', '          break;', '', '        case ' + op.TEXT + ':', // TEXT
    '          stack.push(input.substring(stack.pop(), peg$currPos));', '          ip++;', '          break;', '', '        case ' + op.IF + ':', // IF t, f
    indent10(generateCondition('stack[stack.length - 1]', 0)), '', '        case ' + op.IF_ERROR + ':', // IF_ERROR t, f
    indent10(generateCondition('stack[stack.length - 1] === peg$FAILED', 0)), '', '        case ' + op.IF_NOT_ERROR + ':', // IF_NOT_ERROR t, f
    indent10(generateCondition('stack[stack.length - 1] !== peg$FAILED', 0)), '', '        case ' + op.WHILE_NOT_ERROR + ':', // WHILE_NOT_ERROR b
    indent10(generateLoop('stack[stack.length - 1] !== peg$FAILED')), '', '        case ' + op.MATCH_ANY + ':', // MATCH_ANY a, f, ...
    indent10(generateCondition('input.length > peg$currPos', 0)), '', '        case ' + op.MATCH_STRING + ':', // MATCH_STRING s, a, f, ...
    indent10(generateCondition('input.substr(peg$currPos, peg$consts[bc[ip + 1]].length) === peg$consts[bc[ip + 1]]', 1)), '', '        case ' + op.MATCH_STRING_IC + ':', // MATCH_STRING_IC s, a, f, ...
    indent10(generateCondition('input.substr(peg$currPos, peg$consts[bc[ip + 1]].length).toLowerCase() === peg$consts[bc[ip + 1]]', 1)), '', '        case ' + op.MATCH_REGEXP + ':', // MATCH_REGEXP r, a, f, ...
    indent10(generateCondition('peg$consts[bc[ip + 1]].test(input.charAt(peg$currPos))', 1)), '', '        case ' + op.ACCEPT_N + ':', // ACCEPT_N n
    '          stack.push(input.substr(peg$currPos, bc[ip + 1]));', '          peg$currPos += bc[ip + 1];', '          ip += 2;', '          break;', '', '        case ' + op.ACCEPT_STRING + ':', // ACCEPT_STRING s
    '          stack.push(peg$consts[bc[ip + 1]]);', '          peg$currPos += peg$consts[bc[ip + 1]].length;', '          ip += 2;', '          break;', '', '        case ' + op.FAIL + ':', // FAIL e
    '          stack.push(peg$FAILED);', '          if (peg$silentFails === 0) {', '            peg$fail(peg$consts[bc[ip + 1]]);', '          }', '          ip += 2;', '          break;', '', '        case ' + op.LOAD_SAVED_POS + ':', // LOAD_SAVED_POS p
    '          peg$savedPos = stack[stack.length - 1 - bc[ip + 1]];', '          ip += 2;', '          break;', '', '        case ' + op.UPDATE_SAVED_POS + ':', // UPDATE_SAVED_POS
    '          peg$savedPos = peg$currPos;', '          ip++;', '          break;', '', '        case ' + op.CALL + ':', // CALL f, n, pc, p1, p2, ..., pN
    indent10(generateCall()), '', '        case ' + op.RULE + ':', // RULE r
    '          stack.push(peg$parseRule(bc[ip + 1]));', '          ip += 2;', '          break;', '', '        case ' + op.SILENT_FAILS_ON + ':', // SILENT_FAILS_ON
    '          peg$silentFails++;', '          ip++;', '          break;', '', '        case ' + op.SILENT_FAILS_OFF + ':', // SILENT_FAILS_OFF
    '          peg$silentFails--;', '          ip++;', '          break;', '', '        default:', '          throw new Error("Invalid opcode: " + bc[ip] + ".");', '      }', '    }', '', '    if (ends.length > 0) {', '      end = ends.pop();', '      ip = ips.pop();', '    } else {', '      break;', '    }', '  }'].join('\n'));
    parts.push(indent2(generateRuleFooter('peg$ruleNames[index]', 'stack[0]')));
    parts.push('}');
    return parts.join('\n');
  }

  function generateRuleFunction(rule) {
    var parts = [],
        code;

    function c(i) {
      return "peg$c" + i;
    } // |consts[i]| of the abstract machine


    function s(i) {
      return "s" + i;
    } // |stack[i]| of the abstract machine


    var stack = {
      sp: -1,
      maxSp: -1,
      push: function (exprCode) {
        var code = s(++this.sp) + ' = ' + exprCode + ';';

        if (this.sp > this.maxSp) {
          this.maxSp = this.sp;
        }

        return code;
      },
      pop: function (n) {
        var values;

        if (n === void 0) {
          return s(this.sp--);
        } else {
          values = arrays.map(arrays.range(this.sp - n + 1, this.sp + 1), s);
          this.sp -= n;
          return values;
        }
      },
      top: function () {
        return s(this.sp);
      },
      index: function (i) {
        return s(this.sp - i);
      }
    };

    function compile(bc) {
      var ip = 0,
          end = bc.length,
          parts = [],
          value;

      function compileCondition(cond, argCount) {
        var baseLength = argCount + 3,
            thenLength = bc[ip + baseLength - 2],
            elseLength = bc[ip + baseLength - 1],
            baseSp = stack.sp,
            thenCode,
            elseCode,
            thenSp,
            elseSp;
        ip += baseLength;
        thenCode = compile(bc.slice(ip, ip + thenLength));
        thenSp = stack.sp;
        ip += thenLength;

        if (elseLength > 0) {
          stack.sp = baseSp;
          elseCode = compile(bc.slice(ip, ip + elseLength));
          elseSp = stack.sp;
          ip += elseLength;

          if (thenSp !== elseSp) {
            throw new Error("Branches of a condition must move the stack pointer in the same way.");
          }
        }

        parts.push('if (' + cond + ') {');
        parts.push(indent2(thenCode));

        if (elseLength > 0) {
          parts.push('} else {');
          parts.push(indent2(elseCode));
        }

        parts.push('}');
      }

      function compileLoop(cond) {
        var baseLength = 2,
            bodyLength = bc[ip + baseLength - 1],
            baseSp = stack.sp,
            bodyCode,
            bodySp;
        ip += baseLength;
        bodyCode = compile(bc.slice(ip, ip + bodyLength));
        bodySp = stack.sp;
        ip += bodyLength;

        if (bodySp !== baseSp) {
          throw new Error("Body of a loop can't move the stack pointer.");
        }

        parts.push('while (' + cond + ') {');
        parts.push(indent2(bodyCode));
        parts.push('}');
      }

      function compileCall() {
        var baseLength = 4,
            paramsLength = bc[ip + baseLength - 1];
        var value = c(bc[ip + 1]) + '(' + arrays.map(bc.slice(ip + baseLength, ip + baseLength + paramsLength), function (p) {
          return stack.index(p);
        }).join(', ') + ')';
        stack.pop(bc[ip + 2]);
        parts.push(stack.push(value));
        ip += baseLength + paramsLength;
      }

      while (ip < end) {
        switch (bc[ip]) {
          case op.PUSH:
            // PUSH c
            parts.push(stack.push(c(bc[ip + 1])));
            ip += 2;
            break;

          case op.PUSH_CURR_POS:
            // PUSH_CURR_POS
            parts.push(stack.push('peg$currPos'));
            ip++;
            break;

          case op.PUSH_UNDEFINED:
            // PUSH_UNDEFINED
            parts.push(stack.push('void 0'));
            ip++;
            break;

          case op.PUSH_NULL:
            // PUSH_NULL
            parts.push(stack.push('null'));
            ip++;
            break;

          case op.PUSH_FAILED:
            // PUSH_FAILED
            parts.push(stack.push('peg$FAILED'));
            ip++;
            break;

          case op.PUSH_EMPTY_ARRAY:
            // PUSH_EMPTY_ARRAY
            parts.push(stack.push('[]'));
            ip++;
            break;

          case op.POP:
            // POP
            stack.pop();
            ip++;
            break;

          case op.POP_CURR_POS:
            // POP_CURR_POS
            parts.push('peg$currPos = ' + stack.pop() + ';');
            ip++;
            break;

          case op.POP_N:
            // POP_N n
            stack.pop(bc[ip + 1]);
            ip += 2;
            break;

          case op.NIP:
            // NIP
            value = stack.pop();
            stack.pop();
            parts.push(stack.push(value));
            ip++;
            break;

          case op.APPEND:
            // APPEND
            value = stack.pop();
            parts.push(stack.top() + '.push(' + value + ');');
            ip++;
            break;

          case op.WRAP:
            // WRAP n
            parts.push(stack.push('[' + stack.pop(bc[ip + 1]).join(', ') + ']'));
            ip += 2;
            break;

          case op.TEXT:
            // TEXT
            parts.push(stack.push('input.substring(' + stack.pop() + ', peg$currPos)'));
            ip++;
            break;

          case op.IF:
            // IF t, f
            compileCondition(stack.top(), 0);
            break;

          case op.IF_ERROR:
            // IF_ERROR t, f
            compileCondition(stack.top() + ' === peg$FAILED', 0);
            break;

          case op.IF_NOT_ERROR:
            // IF_NOT_ERROR t, f
            compileCondition(stack.top() + ' !== peg$FAILED', 0);
            break;

          case op.WHILE_NOT_ERROR:
            // WHILE_NOT_ERROR b
            compileLoop(stack.top() + ' !== peg$FAILED', 0);
            break;

          case op.MATCH_ANY:
            // MATCH_ANY a, f, ...
            compileCondition('input.length > peg$currPos', 0);
            break;

          case op.MATCH_STRING:
            // MATCH_STRING s, a, f, ...
            compileCondition(eval(ast.consts[bc[ip + 1]]).length > 1 ? 'input.substr(peg$currPos, ' + eval(ast.consts[bc[ip + 1]]).length + ') === ' + c(bc[ip + 1]) : 'input.charCodeAt(peg$currPos) === ' + eval(ast.consts[bc[ip + 1]]).charCodeAt(0), 1);
            break;

          case op.MATCH_STRING_IC:
            // MATCH_STRING_IC s, a, f, ...
            compileCondition('input.substr(peg$currPos, ' + eval(ast.consts[bc[ip + 1]]).length + ').toLowerCase() === ' + c(bc[ip + 1]), 1);
            break;

          case op.MATCH_REGEXP:
            // MATCH_REGEXP r, a, f, ...
            compileCondition(c(bc[ip + 1]) + '.test(input.charAt(peg$currPos))', 1);
            break;

          case op.ACCEPT_N:
            // ACCEPT_N n
            parts.push(stack.push(bc[ip + 1] > 1 ? 'input.substr(peg$currPos, ' + bc[ip + 1] + ')' : 'input.charAt(peg$currPos)'));
            parts.push(bc[ip + 1] > 1 ? 'peg$currPos += ' + bc[ip + 1] + ';' : 'peg$currPos++;');
            ip += 2;
            break;

          case op.ACCEPT_STRING:
            // ACCEPT_STRING s
            parts.push(stack.push(c(bc[ip + 1])));
            parts.push(eval(ast.consts[bc[ip + 1]]).length > 1 ? 'peg$currPos += ' + eval(ast.consts[bc[ip + 1]]).length + ';' : 'peg$currPos++;');
            ip += 2;
            break;

          case op.FAIL:
            // FAIL e
            parts.push(stack.push('peg$FAILED'));
            parts.push('if (peg$silentFails === 0) { peg$fail(' + c(bc[ip + 1]) + '); }');
            ip += 2;
            break;

          case op.LOAD_SAVED_POS:
            // LOAD_SAVED_POS p
            parts.push('peg$savedPos = ' + stack.index(bc[ip + 1]) + ';');
            ip += 2;
            break;

          case op.UPDATE_SAVED_POS:
            // UPDATE_SAVED_POS
            parts.push('peg$savedPos = peg$currPos;');
            ip++;
            break;

          case op.CALL:
            // CALL f, n, pc, p1, p2, ..., pN
            compileCall();
            break;

          case op.RULE:
            // RULE r
            parts.push(stack.push("peg$parse" + ast.rules[bc[ip + 1]].name + "()"));
            ip += 2;
            break;

          case op.SILENT_FAILS_ON:
            // SILENT_FAILS_ON
            parts.push('peg$silentFails++;');
            ip++;
            break;

          case op.SILENT_FAILS_OFF:
            // SILENT_FAILS_OFF
            parts.push('peg$silentFails--;');
            ip++;
            break;

          default:
            throw new Error("Invalid opcode: " + bc[ip] + ".");
        }
      }

      return parts.join('\n');
    }

    code = compile(rule.bytecode);
    parts.push('function peg$parse' + rule.name + '() {');

    if (options.trace) {
      parts.push(['  var ' + arrays.map(arrays.range(0, stack.maxSp + 1), s).join(', ') + ',', '      startPos = peg$currPos;'].join('\n'));
    } else {
      parts.push('  var ' + arrays.map(arrays.range(0, stack.maxSp + 1), s).join(', ') + ';');
    }

    parts.push(indent2(generateRuleHeader('"' + js.stringEscape(rule.name) + '"', asts.indexOfRule(ast, rule.name))));
    parts.push(indent2(code));
    parts.push(indent2(generateRuleFooter('"' + js.stringEscape(rule.name) + '"', s(0))));
    parts.push('}');
    return parts.join('\n');
  }

  function generateToplevel() {
    var parts = [],
        startRuleIndices,
        startRuleIndex,
        startRuleFunctions,
        startRuleFunction,
        ruleNames;
    parts.push(['function peg$subclass(child, parent) {', '  function ctor() { this.constructor = child; }', '  ctor.prototype = parent.prototype;', '  child.prototype = new ctor();', '}', '', 'function peg$SyntaxError(message, expected, found, location) {', '  this.message  = message;', '  this.expected = expected;', '  this.found    = found;', '  this.location = location;', '  this.name     = "SyntaxError";', '', '  if (typeof Error.captureStackTrace === "function") {', '    Error.captureStackTrace(this, peg$SyntaxError);', '  }', '}', '', 'peg$subclass(peg$SyntaxError, Error);', '', 'peg$SyntaxError.buildMessage = function(expected, found) {', '  var DESCRIBE_EXPECTATION_FNS = {', '        literal: function(expectation) {', '          return "\\\"" + literalEscape(expectation.text) + "\\\"";', '        },', '', '        "class": function(expectation) {', '          var escapedParts = "",', '              i;', '', '          for (i = 0; i < expectation.parts.length; i++) {', '            escapedParts += expectation.parts[i] instanceof Array', '              ? classEscape(expectation.parts[i][0]) + "-" + classEscape(expectation.parts[i][1])', '              : classEscape(expectation.parts[i]);', '          }', '', '          return "[" + (expectation.inverted ? "^" : "") + escapedParts + "]";', '        },', '', '        any: function(expectation) {', '          return "any character";', '        },', '', '        end: function(expectation) {', '          return "end of input";', '        },', '', '        other: function(expectation) {', '          return expectation.description;', '        }', '      };', '', '  function hex(ch) {', '    return ch.charCodeAt(0).toString(16).toUpperCase();', '  }', '', '  function literalEscape(s) {', '    return s', '      .replace(/\\\\/g, \'\\\\\\\\\')', // backslash
    '      .replace(/"/g,  \'\\\\"\')', // closing double quote
    '      .replace(/\\0/g, \'\\\\0\')', // null
    '      .replace(/\\t/g, \'\\\\t\')', // horizontal tab
    '      .replace(/\\n/g, \'\\\\n\')', // line feed
    '      .replace(/\\r/g, \'\\\\r\')', // carriage return
    '      .replace(/[\\x00-\\x0F]/g,          function(ch) { return \'\\\\x0\' + hex(ch); })', '      .replace(/[\\x10-\\x1F\\x7F-\\x9F]/g, function(ch) { return \'\\\\x\'  + hex(ch); });', '  }', '', '  function classEscape(s) {', '    return s', '      .replace(/\\\\/g, \'\\\\\\\\\')', // backslash
    '      .replace(/\\]/g, \'\\\\]\')', // closing bracket
    '      .replace(/\\^/g, \'\\\\^\')', // caret
    '      .replace(/-/g,  \'\\\\-\')', // dash
    '      .replace(/\\0/g, \'\\\\0\')', // null
    '      .replace(/\\t/g, \'\\\\t\')', // horizontal tab
    '      .replace(/\\n/g, \'\\\\n\')', // line feed
    '      .replace(/\\r/g, \'\\\\r\')', // carriage return
    '      .replace(/[\\x00-\\x0F]/g,          function(ch) { return \'\\\\x0\' + hex(ch); })', '      .replace(/[\\x10-\\x1F\\x7F-\\x9F]/g, function(ch) { return \'\\\\x\'  + hex(ch); });', '  }', '', '  function describeExpectation(expectation) {', '    return DESCRIBE_EXPECTATION_FNS[expectation.type](expectation);', '  }', '', '  function describeExpected(expected) {', '    var descriptions = new Array(expected.length),', '        i, j;', '', '    for (i = 0; i < expected.length; i++) {', '      descriptions[i] = describeExpectation(expected[i]);', '    }', '', '    descriptions.sort();', '', '    if (descriptions.length > 0) {', '      for (i = 1, j = 1; i < descriptions.length; i++) {', '        if (descriptions[i - 1] !== descriptions[i]) {', '          descriptions[j] = descriptions[i];', '          j++;', '        }', '      }', '      descriptions.length = j;', '    }', '', '    switch (descriptions.length) {', '      case 1:', '        return descriptions[0];', '', '      case 2:', '        return descriptions[0] + " or " + descriptions[1];', '', '      default:', '        return descriptions.slice(0, -1).join(", ")', '          + ", or "', '          + descriptions[descriptions.length - 1];', '    }', '  }', '', '  function describeFound(found) {', '    return found ? "\\"" + literalEscape(found) + "\\"" : "end of input";', '  }', '', '  return "Expected " + describeExpected(expected) + " but " + describeFound(found) + " found.";', '};', ''].join('\n'));

    if (options.trace) {
      parts.push(['function peg$DefaultTracer() {', '  this.indentLevel = 0;', '}', '', 'peg$DefaultTracer.prototype.trace = function(event) {', '  var that = this;', '', '  function log(event) {', '    function repeat(string, n) {', '       var result = "", i;', '', '       for (i = 0; i < n; i++) {', '         result += string;', '       }', '', '       return result;', '    }', '', '    function pad(string, length) {', '      return string + repeat(" ", length - string.length);', '    }', '', '    if (typeof console === "object") {', // IE 8-10
      '      console.log(', '        event.location.start.line + ":" + event.location.start.column + "-"', '          + event.location.end.line + ":" + event.location.end.column + " "', '          + pad(event.type, 10) + " "', '          + repeat("  ", that.indentLevel) + event.rule', '      );', '    }', '  }', '', '  switch (event.type) {', '    case "rule.enter":', '      log(event);', '      this.indentLevel++;', '      break;', '', '    case "rule.match":', '      this.indentLevel--;', '      log(event);', '      break;', '', '    case "rule.fail":', '      this.indentLevel--;', '      log(event);', '      break;', '', '    default:', '      throw new Error("Invalid event type: " + event.type + ".");', '  }', '};', ''].join('\n'));
    }

    parts.push(['function peg$parse(input, options) {', '  options = options !== void 0 ? options : {};', '', '  var peg$FAILED = {},', ''].join('\n'));

    if (options.optimize === "size") {
      startRuleIndices = '{ ' + arrays.map(options.allowedStartRules, function (r) {
        return r + ': ' + asts.indexOfRule(ast, r);
      }).join(', ') + ' }';
      startRuleIndex = asts.indexOfRule(ast, options.allowedStartRules[0]);
      parts.push(['      peg$startRuleIndices = ' + startRuleIndices + ',', '      peg$startRuleIndex   = ' + startRuleIndex + ','].join('\n'));
    } else {
      startRuleFunctions = '{ ' + arrays.map(options.allowedStartRules, function (r) {
        return r + ': peg$parse' + r;
      }).join(', ') + ' }';
      startRuleFunction = 'peg$parse' + options.allowedStartRules[0];
      parts.push(['      peg$startRuleFunctions = ' + startRuleFunctions + ',', '      peg$startRuleFunction  = ' + startRuleFunction + ','].join('\n'));
    }

    parts.push('');
    parts.push(indent6(generateTables()));
    parts.push(['', '      peg$currPos          = 0,', '      peg$savedPos         = 0,', '      peg$posDetailsCache  = [{ line: 1, column: 1 }],', '      peg$maxFailPos       = 0,', '      peg$maxFailExpected  = [],', '      peg$silentFails      = 0,', // 0 = report failures, > 0 = silence failures
    ''].join('\n'));

    if (options.cache) {
      parts.push(['      peg$resultsCache = {},', ''].join('\n'));
    }

    if (options.trace) {
      if (options.optimize === "size") {
        ruleNames = '[' + arrays.map(ast.rules, function (r) {
          return '"' + js.stringEscape(r.name) + '"';
        }).join(', ') + ']';
        parts.push(['      peg$ruleNames = ' + ruleNames + ',', ''].join('\n'));
      }

      parts.push(['      peg$tracer = "tracer" in options ? options.tracer : new peg$DefaultTracer(),', ''].join('\n'));
    }

    parts.push(['      peg$result;', ''].join('\n'));

    if (options.optimize === "size") {
      parts.push(['  if ("startRule" in options) {', '    if (!(options.startRule in peg$startRuleIndices)) {', '      throw new Error("Can\'t start parsing from rule \\"" + options.startRule + "\\".");', '    }', '', '    peg$startRuleIndex = peg$startRuleIndices[options.startRule];', '  }'].join('\n'));
    } else {
      parts.push(['  if ("startRule" in options) {', '    if (!(options.startRule in peg$startRuleFunctions)) {', '      throw new Error("Can\'t start parsing from rule \\"" + options.startRule + "\\".");', '    }', '', '    peg$startRuleFunction = peg$startRuleFunctions[options.startRule];', '  }'].join('\n'));
    }

    parts.push(['', '  function text() {', '    return input.substring(peg$savedPos, peg$currPos);', '  }', '', '  function location() {', '    return peg$computeLocation(peg$savedPos, peg$currPos);', '  }', '', '  function expected(description, location) {', '    location = location !== void 0 ? location : peg$computeLocation(peg$savedPos, peg$currPos)', '', '    throw peg$buildStructuredError(', '      [peg$otherExpectation(description)],', '      input.substring(peg$savedPos, peg$currPos),', '      location', '    );', '  }', '', '  function error(message, location) {', '    location = location !== void 0 ? location : peg$computeLocation(peg$savedPos, peg$currPos)', '', '    throw peg$buildSimpleError(message, location);', '  }', '', '  function peg$literalExpectation(text, ignoreCase) {', '    return { type: "literal", text: text, ignoreCase: ignoreCase };', '  }', '', '  function peg$classExpectation(parts, inverted, ignoreCase) {', '    return { type: "class", parts: parts, inverted: inverted, ignoreCase: ignoreCase };', '  }', '', '  function peg$anyExpectation() {', '    return { type: "any" };', '  }', '', '  function peg$endExpectation() {', '    return { type: "end" };', '  }', '', '  function peg$otherExpectation(description) {', '    return { type: "other", description: description };', '  }', '', '  function peg$computePosDetails(pos) {', '    var details = peg$posDetailsCache[pos], p;', '', '    if (details) {', '      return details;', '    } else {', '      p = pos - 1;', '      while (!peg$posDetailsCache[p]) {', '        p--;', '      }', '', '      details = peg$posDetailsCache[p];', '      details = {', '        line:   details.line,', '        column: details.column', '      };', '', '      while (p < pos) {', '        if (input.charCodeAt(p) === 10) {', '          details.line++;', '          details.column = 1;', '        } else {', '          details.column++;', '        }', '', '        p++;', '      }', '', '      peg$posDetailsCache[pos] = details;', '      return details;', '    }', '  }', '', '  function peg$computeLocation(startPos, endPos) {', '    var startPosDetails = peg$computePosDetails(startPos),', '        endPosDetails   = peg$computePosDetails(endPos);', '', '    return {', '      start: {', '        offset: startPos,', '        line:   startPosDetails.line,', '        column: startPosDetails.column', '      },', '      end: {', '        offset: endPos,', '        line:   endPosDetails.line,', '        column: endPosDetails.column', '      }', '    };', '  }', '', '  function peg$fail(expected) {', '    if (peg$currPos < peg$maxFailPos) { return; }', '', '    if (peg$currPos > peg$maxFailPos) {', '      peg$maxFailPos = peg$currPos;', '      peg$maxFailExpected = [];', '    }', '', '    peg$maxFailExpected.push(expected);', '  }', '', '  function peg$buildSimpleError(message, location) {', '    return new peg$SyntaxError(message, null, null, location);', '  }', '', '  function peg$buildStructuredError(expected, found, location) {', '    return new peg$SyntaxError(', '      peg$SyntaxError.buildMessage(expected, found),', '      expected,', '      found,', '      location', '    );', '  }', ''].join('\n'));

    if (options.optimize === "size") {
      parts.push(indent2(generateInterpreter()));
      parts.push('');
    } else {
      arrays.each(ast.rules, function (rule) {
        parts.push(indent2(generateRuleFunction(rule)));
        parts.push('');
      });
    }

    if (ast.initializer) {
      parts.push(indent2(ast.initializer.code));
      parts.push('');
    }

    if (options.optimize === "size") {
      parts.push('  peg$result = peg$parseRule(peg$startRuleIndex);');
    } else {
      parts.push('  peg$result = peg$startRuleFunction();');
    }

    parts.push(['', '  if (peg$result !== peg$FAILED && peg$currPos === input.length) {', '    return peg$result;', '  } else {', '    if (peg$result !== peg$FAILED && peg$currPos < input.length) {', '      peg$fail(peg$endExpectation());', '    }', '', '    throw peg$buildStructuredError(', '      peg$maxFailExpected,', '      peg$maxFailPos < input.length ? input.charAt(peg$maxFailPos) : null,', '      peg$maxFailPos < input.length', '        ? peg$computeLocation(peg$maxFailPos, peg$maxFailPos + 1)', '        : peg$computeLocation(peg$maxFailPos, peg$maxFailPos)', '    );', '  }', '}'].join('\n'));
    return parts.join('\n');
  }

  function generateWrapper(toplevelCode) {
    function generateGeneratedByComment() {
      return ['/*', ' * Generated by PEG.js 0.10.0.', ' *', ' * http://pegjs.org/', ' */'].join('\n');
    }

    function generateParserObject() {
      return options.trace ? ['{', '  SyntaxError:   peg$SyntaxError,', '  DefaultTracer: peg$DefaultTracer,', '  parse:         peg$parse', '}'].join('\n') : ['{', '  SyntaxError: peg$SyntaxError,', '  parse:       peg$parse', '}'].join('\n');
    }

    var generators = {
      bare: function () {
        return [generateGeneratedByComment(), '(function() {', '  "use strict";', '', indent2(toplevelCode), '', indent2('return ' + generateParserObject() + ';'), '})()'].join('\n');
      },
      commonjs: function () {
        var parts = [],
            dependencyVars = objects.keys(options.dependencies),
            requires = arrays.map(dependencyVars, function (variable) {
          return variable + ' = require("' + js.stringEscape(options.dependencies[variable]) + '")';
        });
        parts.push([generateGeneratedByComment(), '', '"use strict";', ''].join('\n'));

        if (requires.length > 0) {
          parts.push('var ' + requires.join(', ') + ';');
          parts.push('');
        }

        parts.push([toplevelCode, '', 'module.exports = ' + generateParserObject() + ';', ''].join('\n'));
        return parts.join('\n');
      },
      amd: function () {
        var dependencyIds = objects.values(options.dependencies),
            dependencyVars = objects.keys(options.dependencies),
            dependencies = '[' + arrays.map(dependencyIds, function (id) {
          return '"' + js.stringEscape(id) + '"';
        }).join(', ') + ']',
            params = dependencyVars.join(', ');
        return [generateGeneratedByComment(), 'define(' + dependencies + ', function(' + params + ') {', '  "use strict";', '', indent2(toplevelCode), '', indent2('return ' + generateParserObject() + ';'), '});', ''].join('\n');
      },
      globals: function () {
        return [generateGeneratedByComment(), '(function(root) {', '  "use strict";', '', indent2(toplevelCode), '', indent2('root.' + options.exportVar + ' = ' + generateParserObject() + ';'), '})(this);', ''].join('\n');
      },
      umd: function () {
        var parts = [],
            dependencyIds = objects.values(options.dependencies),
            dependencyVars = objects.keys(options.dependencies),
            dependencies = '[' + arrays.map(dependencyIds, function (id) {
          return '"' + js.stringEscape(id) + '"';
        }).join(', ') + ']',
            requires = arrays.map(dependencyIds, function (id) {
          return 'require("' + js.stringEscape(id) + '")';
        }).join(', '),
            params = dependencyVars.join(', ');
        parts.push([generateGeneratedByComment(), '(function(root, factory) {', '  if (typeof define === "function" && define.amd) {', '    define(' + dependencies + ', factory);', '  } else if (typeof module === "object" && module.exports) {', '    module.exports = factory(' + requires + ');'].join('\n'));

        if (options.exportVar !== null) {
          parts.push(['  } else {', '    root.' + options.exportVar + ' = factory();'].join('\n'));
        }

        parts.push(['  }', '})(this, function(' + params + ') {', '  "use strict";', '', indent2(toplevelCode), '', indent2('return ' + generateParserObject() + ';'), '});', ''].join('\n'));
        return parts.join('\n');
      }
    };
    return generators[options.format]();
  }

  ast.code = generateWrapper(generateToplevel());
}

module.exports = generateJS;
},{"../../utils/arrays":"mEVg","../../utils/objects":"1HYV","../asts":"WDMO","../opcodes":"3S6x","../js":"4CFN"}],"bAKt":[function(require,module,exports) {
"use strict";

var arrays = require("../utils/arrays"),
    objects = require("../utils/objects");

var compiler = {
  /*
   * AST node visitor builder. Useful mainly for plugins which manipulate the
   * AST.
   */
  visitor: require("./visitor"),

  /*
   * Compiler passes.
   *
   * Each pass is a function that is passed the AST. It can perform checks on it
   * or modify it as needed. If the pass encounters a semantic error, it throws
   * |peg.GrammarError|.
   */
  passes: {
    check: {
      reportUndefinedRules: require("./passes/report-undefined-rules"),
      reportDuplicateRules: require("./passes/report-duplicate-rules"),
      reportDuplicateLabels: require("./passes/report-duplicate-labels"),
      reportInfiniteRecursion: require("./passes/report-infinite-recursion"),
      reportInfiniteRepetition: require("./passes/report-infinite-repetition")
    },
    transform: {
      removeProxyRules: require("./passes/remove-proxy-rules")
    },
    generate: {
      generateBytecode: require("./passes/generate-bytecode"),
      generateJS: require("./passes/generate-js")
    }
  },

  /*
   * Generates a parser from a specified grammar AST. Throws |peg.GrammarError|
   * if the AST contains a semantic error. Note that not all errors are detected
   * during the generation and some may protrude to the generated parser and
   * cause its malfunction.
   */
  compile: function (ast, passes, options) {
    options = options !== void 0 ? options : {};
    var stage;
    options = objects.clone(options);
    objects.defaults(options, {
      allowedStartRules: [ast.rules[0].name],
      cache: false,
      dependencies: {},
      exportVar: null,
      format: "bare",
      optimize: "speed",
      output: "parser",
      trace: false
    });

    for (stage in passes) {
      if (passes.hasOwnProperty(stage)) {
        arrays.each(passes[stage], function (p) {
          p(ast, options);
        });
      }
    }

    switch (options.output) {
      case "parser":
        return eval(ast.code);

      case "source":
        return ast.code;
    }
  }
};
module.exports = compiler;
},{"../utils/arrays":"mEVg","../utils/objects":"1HYV","./visitor":"NvoU","./passes/report-undefined-rules":"sC2i","./passes/report-duplicate-rules":"nxhj","./passes/report-duplicate-labels":"l5oL","./passes/report-infinite-recursion":"AOtE","./passes/report-infinite-repetition":"9xzp","./passes/remove-proxy-rules":"oWvK","./passes/generate-bytecode":"bclG","./passes/generate-js":"j2YI"}],"o2oZ":[function(require,module,exports) {
"use strict";

var arrays = require("./utils/arrays"),
    objects = require("./utils/objects");

var peg = {
  /* PEG.js version (uses semantic versioning). */
  VERSION: "0.10.0",
  GrammarError: require("./grammar-error"),
  parser: require("./parser"),
  compiler: require("./compiler"),

  /*
   * Generates a parser from a specified grammar and returns it.
   *
   * The grammar must be a string in the format described by the metagramar in
   * the parser.pegjs file.
   *
   * Throws |peg.parser.SyntaxError| if the grammar contains a syntax error or
   * |peg.GrammarError| if it contains a semantic error. Note that not all
   * errors are detected during the generation and some may protrude to the
   * generated parser and cause its malfunction.
   */
  generate: function (grammar, options) {
    options = options !== void 0 ? options : {};

    function convertPasses(passes) {
      var converted = {},
          stage;

      for (stage in passes) {
        if (passes.hasOwnProperty(stage)) {
          converted[stage] = objects.values(passes[stage]);
        }
      }

      return converted;
    }

    options = objects.clone(options);
    var plugins = "plugins" in options ? options.plugins : [],
        config = {
      parser: peg.parser,
      passes: convertPasses(peg.compiler.passes)
    };
    arrays.each(plugins, function (p) {
      p.use(config, options);
    });
    return peg.compiler.compile(config.parser.parse(grammar), config.passes, options);
  }
};
module.exports = peg;
},{"./utils/arrays":"mEVg","./utils/objects":"1HYV","./grammar-error":"vvJ7","./parser":"Wwef","./compiler":"bAKt"}],"SZ6B":[function(require,module,exports) {
(function () {
  'use strict';

  var PEG, fs, getErrorMessage, grammar, pegParser;
  fs = require('fs');
  PEG = require('pegjs');
  grammar = "{\n    var RESERVED_ATTRIBUTES = {id: true};\n\n    function warning(msg) {\n        var startLocation = location().start;\n        options.warnings.push({\n            message: msg,\n            line: startLocation.line,\n            column: startLocation.column\n        });\n    }\n\n    function forEachType(arr, type, callback){\n        for (var i = 0, n = arr.length; i < n; i++){\n            if (arr[i].type === type) callback(arr[i], i, arr);\n        }\n    }\n\n    function flattenArray(arr){\n        for (var i = 0, n = arr.length; i < n; i++){\n            if (!Array.isArray(arr[i]))\n                continue;\n\n            var child = arr[i];\n\n            child.unshift(i, 1);\n            arr.splice.apply(arr, child);\n\n            i--;\n            n += child.length - 3;\n        }\n\n        return arr;\n    }\n}\n\nStart\n    = constants:Constant* objects:MainType* {\n        return {\n            constants: constants,\n            objects: objects\n        };\n    }\n\n/* HELPERS */\n\nSourceCharacter\n    = .\n\nLetter \"letter\"\n    = [a-zA-Z_$]\n\nWord \"word\"\n    = $[a-zA-Z0-9_$]+\n\nVariable\n    = $(Letter Word?)\n\nReference\n    = $(Variable (\".\" Variable)+)\n\nLineTerminator \"line terminator\"\n    = [\\n\\r\\u2028\\u2029]\n\nLineTerminatorSequence \"end of line\"\n    = \"\\n\"\n    / \"\\r\\n\"\n    / \"\\r\"\n    / \"\\u2028\"\n    / \"\\u2029\"\n\nZs = [\\u0020\\u00A0\\u1680\\u2000-\\u200A\\u202F\\u205F\\u3000]\nWhiteSpace \"whitespace\"\n    = \"\\t\"\n    / \"\\v\"\n    / \"\\f\"\n    / \" \"\n    / \"\\u00A0\"\n    / \"\\uFEFF\"\n    / Zs\n\nHexDigit\n    = [0-9a-f]i\n\nDecimalDigit\n    = [0-9]\n\nSingleEscapeCharacter \"escape character\"\n    = \"'\"\n    / '\"'\n    / \"\\\\\"\n    / \"b\"  { return \"\\b\";   }\n    / \"f\"  { return \"\\f\";   }\n    / \"n\"  { return \"\\n\";   }\n    / \"r\"  { return \"\\r\";   }\n    / \"t\"  { return \"\\t\";   }\n    / \"v\"  { return \"\\x0B\"; }   // IE does not recognize \"\\v\".\n\nNonEscapeCharacter\n  = !(EscapeCharacter / LineTerminator) SourceCharacter { return text(); }\n\nEscapeCharacter\n    = SingleEscapeCharacter\n    / DecimalDigit\n    / \"x\"\n    / \"u\"\n\nComment \"comment\"\n    = MultiLineComment\n    / SingleLineComment\n\nMultiLineComment\n    = WhiteSpace* \"/*\" (!\"*/\" SourceCharacter)* \"*/\"\n\nSingleLineComment\n    = WhiteSpace* \"//\" (!LineTerminator SourceCharacter)*\n\nStringLiteral \"string literal\"\n    = '\"' chars:$DoubleStringCharacter* '\"' {\n        return chars;\n    }\n    / \"'\" chars:$SingleStringCharacter* \"'\" {\n        return chars;\n    }\n\nDoubleStringCharacter\n    = !('\"' / \"\\\\\" / LineTerminator) SourceCharacter { return text(); }\n    / \"\\\\\" sequence:EscapeSequence { return sequence; }\n    / LineContinuation\n\nSingleStringCharacter\n    = !(\"'\" / \"\\\\\" / LineTerminator) SourceCharacter { return text(); }\n    / \"\\\\\" sequence:EscapeSequence { return sequence; }\n    / LineContinuation\n\nLineContinuation\n    = \"\\\\\" LineTerminatorSequence { return \"\"; }\n\nInlineBrackets\n    = '(' (!')' (StringLiteral / InlineBrackets / SourceCharacter))* ')'\n\nEscapeSequence\n    = CharacterEscapeSequence\n    / \"0\" !DecimalDigit { return \"\\0\"; }\n    / HexEscapeSequence\n    / UnicodeEscapeSequence\n\nCharacterEscapeSequence\n    = SingleEscapeCharacter\n    / NonEscapeCharacter\n\nHexEscapeSequence\n    = \"x\" digits:$(HexDigit HexDigit) {\n        return String.fromCharCode(parseInt(digits, 16));\n    }\n\nUnicodeEscapeSequence\n    = \"u\" digits:$(HexDigit HexDigit HexDigit HexDigit) {\n        return String.fromCharCode(parseInt(digits, 16));\n    }\n\n__\n    = (WhiteSpace / LineTerminatorSequence / Comment)*\n\n/* ATTRIBUTE */\n\nAttributeName \"attribute name\"\n    = name:(Reference / Variable) {\n        if (RESERVED_ATTRIBUTES[name]){\n            error(name+\" syntax error\");\n        }\n        return name;\n    }\n\nAttributeEnds\n    = \";\"\n    / LineTerminator\n    / Comment\n\nAttributeBody\n    = d:Type AttributeEnds? { return d }\n    / \"{\" __ \"}\" AttributeEnds { return \"{}\" }\n    / \"[\" __ \"]\" AttributeEnds { return \"[]\" }\n    / \"{\" d:(__ d:Declaration __ { return d })* __ \"}\" AttributeEnds { return d }\n    / \"[\" d:Type* \"]\" AttributeEnds { return d }\n    / d:$StringLiteral AttributeEnds { return d }\n    / value:(!AttributeEnds d:($StringLiteral/SourceCharacter) {return d})+ AttributeEnds {\n        return value.join('').trim()\n    }\n\nAttributeDeclaration\n    = name:AttributeName \":\" WhiteSpace* {return name}\n\nAttribute \"attribute\"\n    = name:AttributeDeclaration value:AttributeBody {\n        return { type: 'attribute', name: name, value: value };\n    }\n\n/* PROPERTY */\n\nPropertyToken\n    = \"property\"\n\nPropertyValue\n    = Function\n    / Attribute\n    / d:AttributeName AttributeEnds {return d}\n\nFullProperty\n    = PropertyToken WhiteSpace+ value:PropertyValue {\n        var name = value.name || value;\n        var obj = { type: 'property', name: name };\n        return typeof value === 'string' ? obj : [obj, value];\n    }\n\nFunctionProperty\n    = d:NamedFunction {\n        return [\n            { type: 'property', name: d.name },\n            d\n        ];\n    }\n\nProperty \"custom property\"\n    = FullProperty\n    / FunctionProperty\n\n/* SIGNAL */\n\nSignalToken\n    = \"signal\"\n\nSignalValue\n    = Function\n    / d:AttributeName AttributeEnds {return d}\n\nSignal \"custom signal\"\n    = SignalToken WhiteSpace+ value:SignalValue {\n        var name = value.name || value;\n        var obj = { type: 'signal', name: name };\n        return typeof value === 'string' ? obj : [obj, value];\n    }\n\n/* ID */\n\nIdToken\n    = \"id\"\n\nId \"id declaration\"\n    = IdToken \":\" WhiteSpace* value:Variable AttributeEnds {\n        if (options.ids[value]) {\n            error(\"Id '\" + value + \"' is already defined\");\n        }\n        options.ids[value] = true;\n        return { type: 'id', value: value };\n    }\n\n/* FUNCTION */\n\nFunctionToken\n    = \"function\"\n\nFunctionBody \"function brackets\"\n    = \"{\" FunctionInnerBody \"}\"\n\nFunctionInnerBody \"function brackets\"\n    = (!\"}\" FunctionBodyText)*\n\nFunctionBodyText \"function code\"\n    = StringLiteral / Comment / FunctionBody / SourceCharacter\n\nFunctionParams \"function parameters\"\n    = \"(\" first:Variable? rest:(WhiteSpace* \",\" WhiteSpace* d:Variable { return d })* \")\" {\n        return first ? flattenArray([first, rest]) : [];\n    }\n\nFunctionName \"function name\"\n    = (Variable \".\")* Variable\n\nFunction \"function\"\n    = name:$FunctionName (\":\" WhiteSpace* FunctionToken)? WhiteSpace* params:FunctionParams WhiteSpace* \"{\" body:$FunctionInnerBody \"}\" AttributeEnds {\n        return { type: 'function', name: name, params: params, code: body };\n    }\n\n/* NAMED FUNCTION */\n\nNamedFunction \"function with name\"\n    = FunctionToken WhiteSpace+ name:$FunctionName WhiteSpace* params:FunctionParams WhiteSpace* \"{\" body:$FunctionInnerBody \"}\" AttributeEnds {\n        return { type: 'function', name: name, params: params, code: body };\n    }\n\n/* ANONYMOUS FUNCTION */\n\nAnonymousFunction \"anonymous function\"\n    = FunctionToken WhiteSpace* params:FunctionParams WhiteSpace* \"{\" body:$FunctionInnerBody \"}\" AttributeEnds {\n        return { type: 'function', name: '', params: params, code: body };\n    }\n\n/* DECLARATION */\n\nDeclaration\n    = __ d:(Function / Id / Attribute / Property / Signal / Type) {\n        return d\n    }\n\nDeclarations\n    = d:(Declaration / ConditionStatement / SelectStatement)* { return flattenArray(d) }\n\n/* TYPE */\n\nTypeNameRest\n    = \".\" (\"/\"? Variable)+\n    / \"['\" ((\".\" / \"/\")? Variable)+ \"']\"\n    / \"[\\\"\" ((\".\" / \"/\")? Variable)+ \"\\\"]\"\n\nTypeName \"renderer type name\"\n    = \"@\" d:$(Variable TypeNameRest?) {\n        if (d.indexOf('/') !== -1 && d.indexOf('[') === -1){\n            return d.replace(/\\.([a-zA-Z0-9_/]+)$/, \"['$1\") + \"']\";\n        }\n        return d;\n    }\n\nTypeBody \"renderer type body\"\n    = __ d:Declarations __ { return d }\n\nType \"renderer type\"\n    = __ name:TypeName query:$(WhiteSpace+ SelectCondition)? WhiteSpace* \"{\" body:TypeBody \"}\" __ {\n        var obj = { type: 'object', name: name, id: '', body: body };\n\n        forEachType(body, \"id\", function(elem){\n            if (obj.id){\n                error(\"item can has only one id\");\n            }\n            obj.id = elem.value;\n        });\n\n        if (!obj.id) {\n            obj.id = \"_i\" + options.lastUid++;\n        }\n\n        if (query) {\n        \tobj.body.unshift({ type: 'attribute', name: 'query', value: \"'\" + query.trim() + \"'\" })\n        }\n\n        return obj;\n    }\n\nMainType\n    = Type / SelectStatement\n\n/* CONDITION STATEMENT */\n\nConditionToken\n    = \"if\"\n\nConditionStatement \"condition statement\"\n    = __ ConditionToken WhiteSpace* \"(\" WhiteSpace* cond:$(!\")\" d:($StringLiteral/$InlineBrackets/SourceCharacter) {return d})+ WhiteSpace* \")\" WhiteSpace* \"{\" body:TypeBody \"}\" __ {\n        return { type: 'condition', condition: cond, body: body };\n    }\n\n/* SELECT STATEMENT */\n\nSelectCondition\n\t= $[^{}\\n@]+\n\nSelectStatement \"select statement\"\n    = __ cond:SelectCondition WhiteSpace* \"{\" body:TypeBody \"}\" __ {\n        return { type: 'select', query: \"'\" + cond.trim() + \"'\", body: body };\n    }\n\n/* CONSTANT */\n\nConstantToken\n    = \"const\"\n\nConstantValue \"constant value\"\n    = $NamedFunction\n    / $AnonymousFunction\n    / $StringLiteral\n    / $FunctionBody\n    / d:$(!AttributeEnds SourceCharacter)+ AttributeEnds {return d}\n\nConstant \"constant value\"\n    = __ ConstantToken WhiteSpace+ name:$(!\"=\" .)+ \"=\" WhiteSpace+ value:ConstantValue AttributeEnds? __ {\n        return {\n            name: name.trim(),\n            value: value\n        };\n    }\n";
  pegParser = PEG.generate(grammar);

  getErrorMessage = function (nml, error) {
    var end, i, j, lines, msg, ref, ref1, ref2, start;

    if (!error.location) {
      return error;
    }

    lines = nml.split('\n');
    ref = error.location, start = ref.start, end = ref.end;
    msg = '\n';

    for (i = j = ref1 = start.line - 1, ref2 = end.line - 1; ref1 <= ref2 ? j <= ref2 : j >= ref2; i = ref1 <= ref2 ? ++j : --j) {
      msg += '    ' + lines[i] + '\n';
    }

    msg += "Line: " + start.line + "\n\nColumn: " + start.column + "\n\n" + error.message;
    return msg;
  };

  exports.parse = function (nml, parser) {
    var error, j, len, result, warning, warnings;
    warnings = [];

    try {
      result = pegParser.parse(nml, {
        warnings: warnings,
        ids: {},
        lastUid: 0
      });
    } catch (error1) {
      error = error1;
      throw Error(getErrorMessage(nml, error));
    }

    for (j = 0, len = warnings.length; j < len; j++) {
      warning = warnings[j];
      parser.warning(warning.message);
    }

    return result;
  };
}).call(this);
},{"fs":"8ITs","pegjs":"o2oZ"}],"ylvh":[function(require,module,exports) {
(function() {
  'use strict';
  exports.ID_TYPE = 'id';

  exports.ATTRIBUTE_TYPE = 'attribute';

  exports.FUNCTION_TYPE = 'function';

  exports.OBJECT_TYPE = 'object';

  exports.PROPERTY_TYPE = 'property';

  exports.SIGNAL_TYPE = 'signal';

  exports.CONDITION_TYPE = 'condition';

  exports.SELECT_TYPE = 'select';

  exports.NESTING_TYPE = 'nesting';

  exports.forEachLeaf = function(arg, callback) {
    var ast, config, deeply, includeGiven, includeValues, isOk, omitDeepTypes, omitTypes, onlyType, parent, ref, ref1, ref2, ref3, ref4, ref5, ref6, result;
    ast = arg.ast, onlyType = arg.onlyType, omitTypes = arg.omitTypes, omitDeepTypes = arg.omitDeepTypes, includeGiven = (ref = arg.includeGiven) != null ? ref : false, includeValues = (ref1 = arg.includeValues) != null ? ref1 : false, deeply = (ref2 = arg.deeply) != null ? ref2 : false, parent = (ref3 = arg.parent) != null ? ref3 : null;
    if (!callback) {
      result = [];
      callback = function(elem) {
        return result.push(elem);
      };
    }
    config = {
      ast: ast.value,
      onlyType: onlyType,
      omitTypes: omitTypes,
      omitDeepTypes: omitDeepTypes,
      deeply: deeply,
      includeValues: includeValues
    };
    isOk = function(type) {
      var ok;
      ok = !onlyType || type === onlyType;
      ok && (ok = !omitTypes || !omitTypes.has(type));
      return ok;
    };
    if (includeGiven) {
      if (isOk(ast.type)) {
        callback(ast, parent);
      }
    }
    if (includeValues && ((ref4 = ast.value) != null ? ref4.type : void 0)) {
      exports.forEachLeaf(Object.assign({}, config, {
        ast: ast.value,
        includeGiven: true,
        includeValues: includeValues && deeply,
        parent: ast
      }), callback);
    }
    if (deeply) {
      if ((ref5 = ast.body) != null) {
        ref5.forEach(function(elem) {
          if (!omitDeepTypes || !omitDeepTypes.has(elem.type)) {
            return exports.forEachLeaf(Object.assign({}, config, {
              ast: elem,
              includeGiven: true,
              parent: ast
            }), callback);
          }
        });
      }
    } else {
      if ((ref6 = ast.body) != null) {
        ref6.forEach(function(elem) {
          if (isOk(elem.type)) {
            return callback(elem, ast);
          }
        });
      }
    }
    return result;
  };

}).call(this);

},{}],"XDfx":[function(require,module,exports) {
(function() {
  'use strict';
  var BINDING_PARSER_OPTS, BINDING_THIS_TO_TARGET_OPTS, PRIMITIVE_TYPE, PUBLIC_BINDING_VARIABLES, RESERVED_MAIN_IDS, Renderer, Stringifier, bindingParser, nmlAst, ref, util,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    slice = [].slice;

  ref = require('@neft/core'), util = ref.util, Renderer = ref.Renderer;

  bindingParser = require('@neft/compiler-binding');

  nmlAst = require('./nmlAst');

  PRIMITIVE_TYPE = 'primitive';

  PUBLIC_BINDING_VARIABLES = {
    __proto__: null,
    Renderer: true
  };

  RESERVED_MAIN_IDS = {
    __proto__: null,
    New: true
  };

  BINDING_THIS_TO_TARGET_OPTS = bindingParser.BINDING_THIS_TO_TARGET_OPTS;

  BINDING_PARSER_OPTS = {
    modifyBindingPart: function(elem) {
      if (Renderer[elem[0]]) {
        elem.unshift('Renderer');
      }
      return elem;
    }
  };

  Stringifier = (function() {
    function Stringifier(ast1, path1, lastUID) {
      this.ast = ast1;
      this.path = path1;
      if (lastUID == null) {
        lastUID = 0;
      }
      this.isBindingPublicId = bind(this.isBindingPublicId, this);
      this.isBindingPublicVariable = bind(this.isBindingPublicVariable, this);
      this.lastUID = lastUID;
      this.objects = nmlAst.forEachLeaf({
        ast: this.ast,
        onlyType: nmlAst.OBJECT_TYPE,
        includeGiven: true,
        includeValues: true,
        deeply: true,
        omitDeepTypes: new Set([nmlAst.NESTING_TYPE])
      });
      this.ids = this.objects.map(function(elem) {
        return elem.id;
      });
      this.publicIds = this.ids.filter(function(elem) {
        return elem[0] !== '_';
      });
    }

    Stringifier.prototype.getNextUID = function() {
      return "_r" + (this.lastUID++);
    };

    Stringifier.prototype.isBindingPublicVariable = function(id) {
      return PUBLIC_BINDING_VARIABLES[id] || util.has(this.publicIds, id);
    };

    Stringifier.prototype.isBindingPublicId = function(id) {
      return id === 'this' || this.isBindingPublicVariable(id);
    };

    Stringifier.prototype.stringifyObject = function(ast) {
      var attributes, child, children, elem, functions, i, ids, j, len, len1, nesting, nestingStringifier, nestingType, opts, ref1;
      ids = [];
      attributes = [];
      functions = [];
      children = [];
      nesting = [];
      ref1 = ast.body;
      for (i = 0, len = ref1.length; i < len; i++) {
        child = ref1[i];
        switch (child.type) {
          case nmlAst.ID_TYPE:
            ids.push(child);
            break;
          case nmlAst.ATTRIBUTE_TYPE:
            attributes.push(child);
            break;
          case nmlAst.FUNCTION_TYPE:
            functions.push(child);
            break;
          case nmlAst.OBJECT_TYPE:
          case nmlAst.CONDITION_TYPE:
          case nmlAst.SELECT_TYPE:
            children.push(child);
            break;
          case nmlAst.NESTING_TYPE:
            nesting.push.apply(nesting, child.body);
            break;
          case nmlAst.PROPERTY_TYPE:
          case nmlAst.SIGNAL_TYPE:
            null;
            break;
          default:
            throw new Error("Unknown object type '" + child.type + "'");
        }
      }
      opts = [];
      for (j = 0, len1 = ids.length; j < len1; j++) {
        elem = ids[j];
        opts.push({
          type: PRIMITIVE_TYPE,
          name: 'id',
          value: "\"" + elem.value + "\""
        });
      }
      if (!util.isEmpty(attributes)) {
        opts.push.apply(opts, attributes);
      }
      if (!util.isEmpty(functions)) {
        opts.push.apply(opts, functions);
      }
      if (!util.isEmpty(children)) {
        opts.push({
          type: nmlAst.ATTRIBUTE_TYPE,
          name: 'children',
          value: children
        });
      }
      if (!util.isEmpty(nesting)) {
        nestingType = {
          type: nmlAst.NESTING_TYPE,
          body: nesting
        };
        nestingStringifier = new Stringifier(nestingType, this.path, this.lastUID * 10);
        opts.push({
          type: nmlAst.ATTRIBUTE_TYPE,
          name: 'nesting',
          value: {
            type: nmlAst.FUNCTION_TYPE,
            params: [],
            code: "\n" + (nestingStringifier.stringify())
          }
        });
      }
      if (util.isEmpty(opts)) {
        return ast.id;
      } else {
        return "_RendererObject.setOpts(" + ast.id + ", " + (this.stringifyOpts(opts)) + ")";
      }
    };

    Stringifier.prototype.stringifyAttribute = function(ast) {
      var value;
      value = ast.value;
      if (Array.isArray(value)) {
        return this.stringifyAttributeListValue(value);
      } else if (value != null ? value.type : void 0) {
        return this.stringifyAnyObject(value);
      } else if (this.isAnchor(ast)) {
        return this.anchorToString(value);
      } else if (this.isReference(value)) {
        return this.referenceToString(value);
      } else if (bindingParser.isBinding(value)) {
        return this.bindingToString(value);
      } else {
        return value;
      }
    };

    Stringifier.prototype.stringifyAttributeListValue = function(values) {
      var child, children, types, useObject;
      types = values.map(function(value) {
        return value.type;
      });
      useObject = util.has(types, nmlAst.ATTRIBUTE_TYPE);
      useObject || (useObject = util.has(types, nmlAst.FUNCTION_TYPE));
      useObject || (useObject = util.has(types, PRIMITIVE_TYPE));
      if (useObject) {
        return this.stringifyOpts(values);
      } else {
        children = (function() {
          var i, len, results1;
          results1 = [];
          for (i = 0, len = values.length; i < len; i++) {
            child = values[i];
            results1.push(this.stringifyAnyObject(child));
          }
          return results1;
        }).call(this);
        return "[" + (children.join(', ')) + "]";
      }
    };

    Stringifier.prototype.stringifyFunction = function(ast) {
      var args;
      args = '';
      if (args && String(ast.params)) {
        args += ",";
      }
      args += String(ast.params);
      return "function(" + args + "){" + ast.code + "}";
    };

    Stringifier.prototype.createClass = function(ast) {
      var body, changes, child, i, len, object, ref1;
      changes = [];
      body = [];
      ref1 = ast.body;
      for (i = 0, len = ref1.length; i < len; i++) {
        child = ref1[i];
        switch (child.type) {
          case nmlAst.ATTRIBUTE_TYPE:
          case nmlAst.FUNCTION_TYPE:
            changes.push(child);
            break;
          default:
            body.push(child);
        }
      }
      object = {
        type: nmlAst.OBJECT_TYPE,
        name: 'Class',
        id: this.getNextUID(),
        body: [{
            type: nmlAst.ATTRIBUTE_TYPE,
            name: 'changes',
            value: changes
          }].concat(slice.call(body))
      };
      this.objects.push(object);
      this.ids.push(object.id);
      return object;
    };

    Stringifier.prototype.stringifyCondition = function(ast) {
      var object;
      object = this.createClass(ast);
      object.body.unshift({
        type: nmlAst.ATTRIBUTE_TYPE,
        name: 'running',
        value: {
          type: PRIMITIVE_TYPE,
          value: this.bindingToString(ast.condition, BINDING_THIS_TO_TARGET_OPTS)
        }
      });
      return this.stringifyObject(object);
    };

    Stringifier.prototype.stringifySelect = function(ast) {
      var object;
      object = this.createClass(ast);
      object.body.unshift({
        type: nmlAst.ATTRIBUTE_TYPE,
        name: 'document.query',
        value: ast.query
      });
      return this.stringifyObject(object);
    };

    Stringifier.prototype.stringifyNesting = function(ast) {
      return "return " + (this.stringifyAttributeListValue(ast.body));
    };

    Stringifier.prototype.stringifyPrimitiveType = function(ast) {
      return ast.value;
    };

    Stringifier.prototype.stringifyAnyObject = function(ast) {
      switch (ast.type) {
        case nmlAst.ATTRIBUTE_TYPE:
          return this.stringifyAttribute(ast);
        case nmlAst.FUNCTION_TYPE:
          return this.stringifyFunction(ast);
        case nmlAst.OBJECT_TYPE:
          return this.stringifyObject(ast);
        case nmlAst.CONDITION_TYPE:
          return this.stringifyCondition(ast);
        case nmlAst.SELECT_TYPE:
          return this.stringifySelect(ast);
        case nmlAst.NESTING_TYPE:
          return this.stringifyNesting(ast);
        case PRIMITIVE_TYPE:
          return this.stringifyPrimitiveType(ast);
        default:
          throw new Error("Unknown NML object '" + ast.type + "'");
      }
    };

    Stringifier.prototype.bindingToString = function(value, opts) {
      var binding, func;
      if (opts == null) {
        opts = 0;
      }
      binding = bindingParser.parse(value, this.isBindingPublicId, opts, BINDING_PARSER_OPTS, this.isBindingPublicVariable);
      func = "function(){return " + binding.hash + "}";
      return "[" + func + ", " + binding.connections + "]";
    };

    Stringifier.prototype.isAnchor = function(ast) {
      return ast.name.indexOf('anchors.') === 0;
    };

    Stringifier.prototype.anchorToString = function(value) {
      return JSON.stringify(value.split('.'));
    };

    Stringifier.prototype.isReference = function(value) {
      return typeof value === 'string' && util.has(this.publicIds, value);
    };

    Stringifier.prototype.referenceToString = function(value) {
      return value;
    };

    Stringifier.prototype.getIdsObject = function(ast) {
      var elems, i, key, len, ref1;
      elems = [];
      ref1 = this.ids;
      for (i = 0, len = ref1.length; i < len; i++) {
        key = ref1[i];
        elems.push("\"" + key + "\": " + key);
      }
      return "{" + (elems.join(', ')) + "}";
    };

    Stringifier.prototype.stringifyOpts = function(opts) {
      var opt, results;
      results = (function() {
        var i, len, results1;
        results1 = [];
        for (i = 0, len = opts.length; i < len; i++) {
          opt = opts[i];
          results1.push("\"" + opt.name + "\": " + (this.stringifyAnyObject(opt)));
        }
        return results1;
      }).call(this);
      return "{" + (results.join(', ')) + "}";
    };

    Stringifier.prototype.getItemsCreator = function() {
      var child, i, len, ref1, result;
      result = "";
      ref1 = this.objects;
      for (i = 0, len = ref1.length; i < len; i++) {
        child = ref1[i];
        result += "const " + child.id + " = " + child.name + ".New()\n";
        if (this.path) {
          result += child.id + "._path = \"" + this.path + "\"\n";
        }
      }
      return result;
    };

    Stringifier.prototype.getItemsProperties = function() {
      var child, i, j, len, len1, properties, property, ref1, result;
      result = "";
      ref1 = this.objects;
      for (i = 0, len = ref1.length; i < len; i++) {
        child = ref1[i];
        properties = nmlAst.forEachLeaf({
          ast: child,
          onlyType: nmlAst.PROPERTY_TYPE
        });
        for (j = 0, len1 = properties.length; j < len1; j++) {
          property = properties[j];
          result += "_RendererObject.createProperty(" + child.id + ", \"" + property.name + "\")\n";
        }
      }
      return result;
    };

    Stringifier.prototype.getItemsSignals = function() {
      var child, i, j, len, len1, ref1, result, signal, signals;
      result = "";
      ref1 = this.objects;
      for (i = 0, len = ref1.length; i < len; i++) {
        child = ref1[i];
        signals = nmlAst.forEachLeaf({
          ast: child,
          onlyType: nmlAst.SIGNAL_TYPE
        });
        for (j = 0, len1 = signals.length; j < len1; j++) {
          signal = signals[j];
          result += "_RendererObject.createSignal(" + child.id + ", \"" + signal.name + "\")\n";
        }
      }
      return result;
    };

    Stringifier.prototype.stringify = function() {
      var itemCode, result;
      if (RESERVED_MAIN_IDS[this.ast.id]) {
        throw new Error("Reserved NML id '" + this.ast.id + "'");
      }
      result = "";
      itemCode = this.stringifyAnyObject(this.ast);
      result += this.getItemsCreator();
      result += this.getItemsProperties();
      result += this.getItemsSignals();
      if (itemCode) {
        result += itemCode + "\n";
      }
      if (this.ast.type === nmlAst.NESTING_TYPE) {
        return result;
      }
      result += "return { objects: " + (this.getIdsObject(this.ast));
      if (this.ast.id) {
        result += ", item: " + this.ast.id;
      } else {
        result += ", select: " + this.ids[0];
      }
      result += ' }';
      return result;
    };

    return Stringifier;

  })();

  exports.stringify = function(ast, path) {
    return new Stringifier(ast, path).stringify();
  };

}).call(this);

},{"@neft/core":"lp4R","@neft/compiler-binding":"a2Ly","./nmlAst":"ylvh"}],"dxB6":[function(require,module,exports) {
var process = require("process");
// .dirname, .basename, and .extname methods are extracted from Node.js v8.11.1,
// backported and transplited with Babel, with backwards-compat fixes

// Copyright Joyent, Inc. and other Node contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
// NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

// resolves . and .. elements in a path array with directory names there
// must be no slashes, empty elements, or device names (c:\) in the array
// (so also no leading and trailing slashes - it does not distinguish
// relative and absolute paths)
function normalizeArray(parts, allowAboveRoot) {
  // if the path tries to go above the root, `up` ends up > 0
  var up = 0;
  for (var i = parts.length - 1; i >= 0; i--) {
    var last = parts[i];
    if (last === '.') {
      parts.splice(i, 1);
    } else if (last === '..') {
      parts.splice(i, 1);
      up++;
    } else if (up) {
      parts.splice(i, 1);
      up--;
    }
  }

  // if the path is allowed to go above the root, restore leading ..s
  if (allowAboveRoot) {
    for (; up--; up) {
      parts.unshift('..');
    }
  }

  return parts;
}

// path.resolve([from ...], to)
// posix version
exports.resolve = function() {
  var resolvedPath = '',
      resolvedAbsolute = false;

  for (var i = arguments.length - 1; i >= -1 && !resolvedAbsolute; i--) {
    var path = (i >= 0) ? arguments[i] : process.cwd();

    // Skip empty and invalid entries
    if (typeof path !== 'string') {
      throw new TypeError('Arguments to path.resolve must be strings');
    } else if (!path) {
      continue;
    }

    resolvedPath = path + '/' + resolvedPath;
    resolvedAbsolute = path.charAt(0) === '/';
  }

  // At this point the path should be resolved to a full absolute path, but
  // handle relative paths to be safe (might happen when process.cwd() fails)

  // Normalize the path
  resolvedPath = normalizeArray(filter(resolvedPath.split('/'), function(p) {
    return !!p;
  }), !resolvedAbsolute).join('/');

  return ((resolvedAbsolute ? '/' : '') + resolvedPath) || '.';
};

// path.normalize(path)
// posix version
exports.normalize = function(path) {
  var isAbsolute = exports.isAbsolute(path),
      trailingSlash = substr(path, -1) === '/';

  // Normalize the path
  path = normalizeArray(filter(path.split('/'), function(p) {
    return !!p;
  }), !isAbsolute).join('/');

  if (!path && !isAbsolute) {
    path = '.';
  }
  if (path && trailingSlash) {
    path += '/';
  }

  return (isAbsolute ? '/' : '') + path;
};

// posix version
exports.isAbsolute = function(path) {
  return path.charAt(0) === '/';
};

// posix version
exports.join = function() {
  var paths = Array.prototype.slice.call(arguments, 0);
  return exports.normalize(filter(paths, function(p, index) {
    if (typeof p !== 'string') {
      throw new TypeError('Arguments to path.join must be strings');
    }
    return p;
  }).join('/'));
};


// path.relative(from, to)
// posix version
exports.relative = function(from, to) {
  from = exports.resolve(from).substr(1);
  to = exports.resolve(to).substr(1);

  function trim(arr) {
    var start = 0;
    for (; start < arr.length; start++) {
      if (arr[start] !== '') break;
    }

    var end = arr.length - 1;
    for (; end >= 0; end--) {
      if (arr[end] !== '') break;
    }

    if (start > end) return [];
    return arr.slice(start, end - start + 1);
  }

  var fromParts = trim(from.split('/'));
  var toParts = trim(to.split('/'));

  var length = Math.min(fromParts.length, toParts.length);
  var samePartsLength = length;
  for (var i = 0; i < length; i++) {
    if (fromParts[i] !== toParts[i]) {
      samePartsLength = i;
      break;
    }
  }

  var outputParts = [];
  for (var i = samePartsLength; i < fromParts.length; i++) {
    outputParts.push('..');
  }

  outputParts = outputParts.concat(toParts.slice(samePartsLength));

  return outputParts.join('/');
};

exports.sep = '/';
exports.delimiter = ':';

exports.dirname = function (path) {
  if (typeof path !== 'string') path = path + '';
  if (path.length === 0) return '.';
  var code = path.charCodeAt(0);
  var hasRoot = code === 47 /*/*/;
  var end = -1;
  var matchedSlash = true;
  for (var i = path.length - 1; i >= 1; --i) {
    code = path.charCodeAt(i);
    if (code === 47 /*/*/) {
        if (!matchedSlash) {
          end = i;
          break;
        }
      } else {
      // We saw the first non-path separator
      matchedSlash = false;
    }
  }

  if (end === -1) return hasRoot ? '/' : '.';
  if (hasRoot && end === 1) {
    // return '//';
    // Backwards-compat fix:
    return '/';
  }
  return path.slice(0, end);
};

function basename(path) {
  if (typeof path !== 'string') path = path + '';

  var start = 0;
  var end = -1;
  var matchedSlash = true;
  var i;

  for (i = path.length - 1; i >= 0; --i) {
    if (path.charCodeAt(i) === 47 /*/*/) {
        // If we reached a path separator that was not part of a set of path
        // separators at the end of the string, stop now
        if (!matchedSlash) {
          start = i + 1;
          break;
        }
      } else if (end === -1) {
      // We saw the first non-path separator, mark this as the end of our
      // path component
      matchedSlash = false;
      end = i + 1;
    }
  }

  if (end === -1) return '';
  return path.slice(start, end);
}

// Uses a mixed approach for backwards-compatibility, as ext behavior changed
// in new Node.js versions, so only basename() above is backported here
exports.basename = function (path, ext) {
  var f = basename(path);
  if (ext && f.substr(-1 * ext.length) === ext) {
    f = f.substr(0, f.length - ext.length);
  }
  return f;
};

exports.extname = function (path) {
  if (typeof path !== 'string') path = path + '';
  var startDot = -1;
  var startPart = 0;
  var end = -1;
  var matchedSlash = true;
  // Track the state of characters (if any) we see before our first dot and
  // after any path separator we find
  var preDotState = 0;
  for (var i = path.length - 1; i >= 0; --i) {
    var code = path.charCodeAt(i);
    if (code === 47 /*/*/) {
        // If we reached a path separator that was not part of a set of path
        // separators at the end of the string, stop now
        if (!matchedSlash) {
          startPart = i + 1;
          break;
        }
        continue;
      }
    if (end === -1) {
      // We saw the first non-path separator, mark this as the end of our
      // extension
      matchedSlash = false;
      end = i + 1;
    }
    if (code === 46 /*.*/) {
        // If this is our first dot, mark it as the start of our extension
        if (startDot === -1)
          startDot = i;
        else if (preDotState !== 1)
          preDotState = 1;
    } else if (startDot !== -1) {
      // We saw a non-dot and non-path separator before our dot, so we should
      // have a good chance at having a non-empty extension
      preDotState = -1;
    }
  }

  if (startDot === -1 || end === -1 ||
      // We saw a non-dot character immediately before the dot
      preDotState === 0 ||
      // The (right-most) trimmed path component is exactly '..'
      preDotState === 1 && startDot === end - 1 && startDot === startPart + 1) {
    return '';
  }
  return path.slice(startDot, end);
};

function filter (xs, f) {
    if (xs.filter) return xs.filter(f);
    var res = [];
    for (var i = 0; i < xs.length; i++) {
        if (f(xs[i], i, xs)) res.push(xs[i]);
    }
    return res;
}

// String.prototype.substr - negative index don't work in IE8
var substr = 'ab'.substr(-1) === 'b'
    ? function (str, start, len) { return str.substr(start, len) }
    : function (str, start, len) {
        if (start < 0) start = str.length + start;
        return str.substr(start, len);
    }
;

},{"process":"r7L2"}],"0j3C":[function(require,module,exports) {
(function() {
  'use strict';
  var PADDING, fs, getConstants, getFileMeta, getImportValue, getImports, getObjectsCode, pathUtils;

  pathUtils = require('path');

  fs = require('fs');

  PADDING = '  ';

  getImportValue = function(cfg) {
    if (cfg.ref) {
      return cfg.ref;
    }
    if (cfg.path) {
      return "require(\"" + cfg.path + "\")";
    }
    throw new Error("Unsupported import config object '" + cfg + "'");
  };

  getImports = function(imports) {
    var importConfig, j, len, result, value;
    result = "";
    for (j = 0, len = imports.length; j < len; j++) {
      importConfig = imports[j];
      value = getImportValue(importConfig);
      result += "const " + importConfig.name + " = " + value + "\n";
    }
    return result;
  };

  getConstants = function(constants) {
    var constant, j, len, result;
    result = "";
    for (j = 0, len = constants.length; j < len; j++) {
      constant = constants[j];
      result += "const " + constant.name + " = " + constant.value + "\n";
    }
    return result;
  };

  getObjectsCode = function(objects, objectCodes) {
    var code, i, j, len, objectCode, result;
    result = "";
    for (i = j = 0, len = objectCodes.length; j < len; i = ++j) {
      objectCode = objectCodes[i];
      code = PADDING + objectCode.code.replace(/\n/g, '\n' + PADDING);
      if (objects[i].type === 'select') {
        result += "exports.selects.push(() => {\n" + code + "\n})\n";
      } else {
        result += "exports." + objectCode.id + " = () => {\n" + code + "\n}\n";
      }
    }
    return result;
  };

  getFileMeta = function(path) {
    var relPath;
    relPath = path;
    if (pathUtils.isAbsolute(path)) {
      relPath = pathUtils.relative(fs.realpathSync('.'), path);
    }
    return "exports._path = \"" + relPath + "\"\n";
  };

  exports.bundle = function(arg) {
    var constants, hasSelect, imports, objectCodes, objects, path, queries, result;
    path = arg.path, imports = arg.imports, constants = arg.constants, objects = arg.objects, objectCodes = arg.objectCodes, queries = arg.queries;
    hasSelect = objects.find(function(obj) {
      return obj.type === 'select';
    });
    result = 'const exports = {}\n\nconst { Renderer } = require(\'@neft/core\')\nconst _RendererObject = Renderer.itemUtils.Object\n';
    result += getImports(imports);
    result += getConstants(constants);
    if (hasSelect) {
      result += 'exports.selects = []\n';
    }
    result += getObjectsCode(objects, objectCodes);
    if (path) {
      result += getFileMeta(path);
    }
    result += 'return exports';
    return result;
  };

}).call(this);

},{"path":"dxB6","fs":"8ITs"}],"tJn+":[function(require,module,exports) {
(function() {
  'use strict';
  var nmlAst,
    slice = [].slice;

  nmlAst = require('./nmlAst');

  exports.getQueries = function(objects) {
    var byObject, i, len, object, queries, queryCache;
    queries = {};
    queryCache = {};
    byObject = function(object, ids) {
      var child, i, index, j, len, parentQuery, query, ref, ref1, ref2, results;
      if (object.id) {
        ids = slice.call(ids).concat([object.id]);
      }
      if (Array.isArray(object.body)) {
        ref = object.body;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          child = ref[i];
          results.push(byObject(child, ids));
        }
        return results;
      } else if (Array.isArray((ref1 = object.value) != null ? ref1.body : void 0)) {
        return byObject(object.value, ids);
      } else if (object.type === nmlAst.ATTRIBUTE_TYPE && object.name === 'query') {
        query = object.value.slice(1, -1);
        if (ids.length > 1) {
          parentQuery = '';
          for (index = j = ref2 = ids.length - 2; j >= 0; index = j += -1) {
            if (parentQuery = queryCache[ids[index]]) {
              break;
            }
          }
          if (parentQuery) {
            query = parentQuery + " " + query;
          }
        }
        queryCache[ids[ids.length - 1]] = query;
        return queries[query] = (function() {
          if (ids.length > 1) {
            return [ids[0], ids[ids.length - 1]];
          } else {
            return [ids[0]];
          }
        })();
      }
    };
    for (i = 0, len = objects.length; i < len; i++) {
      object = objects[i];
      byObject(object, []);
    }
    return queries;
  };

}).call(this);

},{"./nmlAst":"ylvh"}],"Xv0R":[function(require,module,exports) {
(function() {
  'use strict';
  var ImportsFinder, Renderer, nmlAst;

  Renderer = require('@neft/core').Renderer;

  nmlAst = require('./nmlAst');

  ImportsFinder = (function() {
    function ImportsFinder(objects1) {
      this.objects = objects1;
      this.usedTypes = this.getUsedTypes();
    }

    ImportsFinder.prototype.getUsedTypes = function() {
      var i, len, object, ref, used;
      used = {
        __proto__: null,
        Class: true,
        Device: true,
        Navigator: true,
        Screen: true
      };
      ref = this.objects;
      for (i = 0, len = ref.length; i < len; i++) {
        object = ref[i];
        nmlAst.forEachLeaf({
          ast: object,
          onlyType: nmlAst.OBJECT_TYPE,
          includeGiven: true,
          includeValues: true,
          deeply: true
        }, function(elem) {
          return used[elem.name] = true;
        });
      }
      return Object.keys(used);
    };

    ImportsFinder.prototype.getDefaultImports = function() {
      var i, key, len, ref, result;
      result = [];
      ref = this.usedTypes;
      for (i = 0, len = ref.length; i < len; i++) {
        key = ref[i];
        if (Renderer[key] != null) {
          result.push({
            name: key,
            ref: "Renderer." + key
          });
        }
      }
      return result;
    };

    ImportsFinder.prototype.findAll = function() {
      return this.getDefaultImports();
    };

    return ImportsFinder;

  })();

  exports.getImports = function(arg) {
    var objects;
    objects = arg.objects;
    return new ImportsFinder(objects).findAll();
  };

}).call(this);

},{"@neft/core":"lp4R","./nmlAst":"ylvh"}],"U/hf":[function(require,module,exports) {
(function() {
  var ATTRIBUTE_TYPE, NAMESPACES, TRANSFORM_FUNCTIONS, forEachLeaf, isStringValue, ref, transformAlignment, transformMargin,
    slice = [].slice;

  ref = require('./nmlAst'), ATTRIBUTE_TYPE = ref.ATTRIBUTE_TYPE, forEachLeaf = ref.forEachLeaf;

  NAMESPACES = {
    margin: ['left', 'right', 'top', 'bottom'],
    padding: ['left', 'right', 'top', 'bottom'],
    alignment: ['horizontal', 'vertical']
  };

  isStringValue = function(value) {
    var isString;
    isString = value.startsWith("'") && value.endsWith("'");
    isString || (isString = value.startsWith('"') && value.endsWith('"'));
    return isString;
  };

  transformMargin = function(elem) {
    var bottom, isNumber, isString, left, parts, right, top;
    isString = isStringValue(elem.value);
    isNumber = !isNaN(elem.value);
    if (isString) {
      parts = elem.value.slice(1, -1).split(' ');
      if (parts.every(function(str) {
        return !isNaN(str);
      })) {
        parts = parts.map(function(str) {
          return parseFloat(str) || 0;
        });
        switch (parts.length) {
          case 1:
            left = top = right = bottom = parts[0];
            break;
          case 2:
            top = bottom = parts[0];
            left = right = parts[1];
            break;
          case 3:
            top = parts[0];
            left = right = parts[1];
            bottom = parts[2];
            break;
          default:
            top = parts[0];
            right = parts[1];
            bottom = parts[2];
            left = parts[3];
        }
      } else {
        return [];
      }
    } else if (isNumber) {
      left = top = right = bottom = parseFloat(elem.value) || 0;
    } else {
      top = elem.value;
      left = right = bottom = "this." + elem.name + ".left";
    }
    return [
      {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".top",
        value: top
      }, {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".right",
        value: right
      }, {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".bottom",
        value: bottom
      }, {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".left",
        value: left
      }
    ];
  };

  transformAlignment = function(elem) {
    var horizontal, isString, vertical;
    isString = isStringValue(elem.value);
    if (isString) {
      horizontal = vertical = elem.value;
    } else {
      horizontal = elem.value;
      vertical = 'this.alignment.horizontal';
    }
    return [
      {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".horizontal",
        value: horizontal
      }, {
        type: ATTRIBUTE_TYPE,
        name: elem.name + ".vertical",
        value: vertical
      }
    ];
  };

  TRANSFORM_FUNCTIONS = {
    margin: transformMargin,
    padding: transformMargin,
    alignment: transformAlignment
  };

  exports.transform = function(ast) {
    var modify;
    modify = [];
    forEachLeaf({
      ast: ast,
      onlyType: ATTRIBUTE_TYPE,
      includeValues: true,
      deeply: true
    }, function(elem, parent) {
      var func;
      func = TRANSFORM_FUNCTIONS[elem.name];
      if (func) {
        modify.push({
          elem: elem,
          parent: parent
        });
      }
    });
    modify.forEach(function(arg) {
      var elem, elemIndex, func, parent, ref1;
      elem = arg.elem, parent = arg.parent;
      func = TRANSFORM_FUNCTIONS[elem.name];
      elemIndex = parent.body.indexOf(elem);
      return (ref1 = parent.body).splice.apply(ref1, [elemIndex, 1].concat(slice.call(func(elem))));
    });
  };

}).call(this);

},{"./nmlAst":"ylvh"}],"zKWu":[function(require,module,exports) {
(function() {
  var CONDITION_TYPE, NESTING_TYPE, OBJECT_TYPE, OBJECT_TYPES, SELECT_TYPE, addNesting, forEachLeaf, ref,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ref = require('./nmlAst'), SELECT_TYPE = ref.SELECT_TYPE, OBJECT_TYPE = ref.OBJECT_TYPE, CONDITION_TYPE = ref.CONDITION_TYPE, NESTING_TYPE = ref.NESTING_TYPE, forEachLeaf = ref.forEachLeaf;

  OBJECT_TYPES = [SELECT_TYPE, OBJECT_TYPE, CONDITION_TYPE];

  addNesting = function(elem) {
    var nesting;
    nesting = [];
    elem.body.forEach(function(child) {
      var ref1;
      if (ref1 = child.type, indexOf.call(OBJECT_TYPES, ref1) >= 0) {
        return nesting.push(child);
      }
    });
    elem.body = elem.body.filter(function(child) {
      var ref1;
      return ref1 = child.type, indexOf.call(OBJECT_TYPES, ref1) < 0;
    });
    if (nesting.length > 0) {
      elem.body.push({
        type: NESTING_TYPE,
        body: nesting
      });
    }
  };

  exports.transform = function(ast) {
    forEachLeaf({
      ast: ast,
      includeGiven: true,
      includeValues: true,
      deeply: true
    }, function(elem, parent) {
      var nest;
      nest = elem.type === SELECT_TYPE;
      nest || (nest = elem.type === CONDITION_TYPE);
      nest || (nest = elem.type === OBJECT_TYPE && elem.name === 'Class');
      if (nest) {
        return addNesting(elem);
      }
    });
  };

}).call(this);

},{"./nmlAst":"ylvh"}],"jwep":[function(require,module,exports) {
(function() {
  var astParser, bundler, codeStringifier, importsFinder, queriesFinder, transformClassNesting, transformNamespaceSetters;

  astParser = require('./astParser');

  codeStringifier = require('./codeStringifier');

  bundler = require('./bundler');

  queriesFinder = require('./queriesFinder');

  importsFinder = require('./importsFinder');

  transformNamespaceSetters = require('./transformNamespaceSetters');

  transformClassNesting = require('./transformClassNesting');

  exports.getAST = function(nml, parser) {
    return astParser.parse(nml, parser);
  };

  exports.getObjectCode = function(arg) {
    var ast, path;
    ast = arg.ast, path = arg.path;
    return codeStringifier.stringify(ast, path);
  };

  exports.getQueries = function(objects) {
    return queriesFinder.getQueries(objects);
  };

  exports.getImports = function(ast) {
    return importsFinder.getImports(ast);
  };

  exports.transformNamespaceSetters = function(ast) {
    return transformNamespaceSetters.transform(ast);
  };

  exports.transformClassNesting = function(ast) {
    return transformClassNesting.transform(ast);
  };

  exports.bundle = function(nml, parser) {
    var ast, bundle, i, imports, len, object, objects, queries, ref;
    ast = exports.getAST(nml, parser);
    objects = [];
    ref = ast.objects;
    for (i = 0, len = ref.length; i < len; i++) {
      object = ref[i];
      exports.transformNamespaceSetters(object);
      exports.transformClassNesting(object);
      objects.push({
        id: object.id,
        code: exports.getObjectCode({
          ast: object,
          path: parser.resourcePath
        })
      });
    }
    queries = exports.getQueries(ast.objects);
    imports = exports.getImports(ast);
    bundle = bundler.bundle({
      path: parser.resourcePath,
      imports: imports,
      constants: ast.constants,
      objects: ast.objects,
      objectCodes: objects,
      queries: queries
    });
    return {
      bundle: bundle,
      queries: queries
    };
  };

}).call(this);

},{"./astParser":"SZ6B","./codeStringifier":"XDfx","./bundler":"0j3C","./queriesFinder":"tJn+","./importsFinder":"Xv0R","./transformNamespaceSetters":"U/hf","./transformClassNesting":"zKWu"}],"TMaW":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var _require = require('@neft/core'),
    CustomTag = _require.CustomTag;

var InputTag =
/*#__PURE__*/
function (_CustomTag) {
  _inherits(InputTag, _CustomTag);

  function InputTag() {
    _classCallCheck(this, InputTag);

    return _possibleConstructorReturn(this, _getPrototypeOf(InputTag).apply(this, arguments));
  }

  return InputTag;
}(CustomTag);

InputTag.registerAs('input');
InputTag.defineStyleProperty({
  name: 'value',
  styleName: 'text'
});
InputTag.defineStyleProperty({
  name: 'placeholder'
});
InputTag.defineStyleProperty({
  name: 'keyboardType'
});
InputTag.defineStyleProperty({
  name: 'multiline'
});
InputTag.defineStyleProperty({
  name: 'returnKeyType'
});
InputTag.defineStyleProperty({
  name: 'secureTextEntry'
});
module.exports = InputTag;
},{"@neft/core":"lp4R"}],"JEeZ":[function(require,module,exports) {
function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var _require = require('@neft/core'),
    Renderer = _require.Renderer;

var setPropertyValue = Renderer.itemUtils.setPropertyValue;

var TextInput =
/*#__PURE__*/
function (_Renderer$Native) {
  _inherits(TextInput, _Renderer$Native);

  function TextInput() {
    _classCallCheck(this, TextInput);

    return _possibleConstructorReturn(this, _getPrototypeOf(TextInput).apply(this, arguments));
  }

  _createClass(TextInput, [{
    key: "focus",
    value: function focus() {
      this.call('focus');
    }
  }]);

  return TextInput;
}(Renderer.Native);

TextInput.Initialize = function (item) {
  item.on('textChange', function (value) {
    setPropertyValue(this, 'text', value);
  });
};

TextInput.defineProperty({
  type: 'text',
  name: 'text'
});
TextInput.defineProperty({
  type: 'color',
  name: 'textColor'
});
TextInput.defineProperty({
  type: 'text',
  name: 'placeholder'
});
TextInput.defineProperty({
  type: 'color',
  name: 'placeholderColor'
}); // text, numeric, email, tel

TextInput.defineProperty({
  type: 'text',
  name: 'keyboardType',
  implementationValue: function implementationValue(val) {
    return val && val.toLowerCase();
  }
});
TextInput.defineProperty({
  type: 'boolean',
  name: 'multiline'
}); // done, go, next, search, send, null

TextInput.defineProperty({
  type: 'text',
  name: 'returnKeyType',
  implementationValue: function implementationValue(val) {
    return val && val.toLowerCase();
  }
});
TextInput.defineProperty({
  type: 'boolean',
  name: 'secureTextEntry'
});
module.exports = TextInput;
},{"@neft/core":"lp4R"}],"RVfa":[function(require,module,exports) {
var InputTag = require('./input-tag');

var TextInput = require('./text-input-style');

exports.InputTag = InputTag;
exports.TextInput = TextInput;
},{"./input-tag":"TMaW","./text-input-style":"JEeZ"}],"Focm":[function(require,module,exports) {
/* eslint-env browser */

/* global Babel */
var fs = require('fs');

var _require = require('@neft/core'),
    util = _require.util;

var _require2 = require('@neft/compiler-document'),
    parseToAst = _require2.parseToAst,
    parseToCode = _require2.parseToCode;

var _require3 = require('@neft/compiler-style'),
    parseNml = _require3.bundle;

require('@neft/input');

var DEFAULT_STYLES = [{
  name: '@neft/default-styles',
  file: "@Item body, div, li, pre, layer, article, aside, footer, header, hgroup, main, nav, section, ul, menu, dir, ol, li, dl, dt, dd, form, fieldset, pre {\n  layout: 'flow'\n  fillWidth: true\n}\n\n@Text p, address, blockquote, h1, h2, h3, h4, h5, h6, h7, legend {\n  fillWidth: true\n}\n\n@Text span, u, strong, b, i, em, code, mark {}\n\n@Image img {}\n"
}, {
  name: '@neft/button',
  file: "const { Button } = require('./index')\n\n@Button button {}\n"
}, {
  name: '@neft/input',
  file: "const { TextInput } = require('./index')\n\n@TextInput input[type=\"text\"] {}\n"
}].map(function (_ref) {
  var name = _ref.name,
      file = _ref.file;

  var _parseNml = parseNml(file, {
    resourcePath: name
  }),
      queries = _parseNml.queries;

  return {
    name: name,
    queries: queries,
    path: "".concat(name, "/style.nml")
  };
});
window.NeftEditor = {
  compile: function compile(html) {
    var ast = parseToAst(html);
    var resourcePath = "editor-".concat(util.uid(), ".neft");
    var scripts = {};
    ast.queryAll('script').forEach(function (script) {
      var nComponent = script.queryParents('n-component');
      var key = resourcePath;
      if (nComponent) key += "#".concat(nComponent.props.name);
      if (key in scripts) return;
      var value = script.stringifyChildren();
      value = Babel.transform(value, {
        presets: ['es2015']
      }).code;
      scripts[key] = {
        value: value
      };
    });
    var styles = {};
    ast.queryAll('style').forEach(function (style) {
      var nComponent = style.queryParents('n-component');
      var key = resourcePath;
      if (nComponent) key += "#".concat(nComponent.props.name);
      if (key in styles) return;
      var value = style.stringifyChildren();
      var bundled = parseNml(value, {
        resourcePath: resourcePath
      });
      value = bundled.bundle;
      value = "module.exports = (() => { ".concat(value, " })()");
      value = Babel.transform(value, {
        presets: ['es2015']
      }).code;
      styles[key] = {
        value: value,
        queries: bundled.queries
      };
    });

    var _parseToCode = parseToCode(ast, {
      defaultStyles: DEFAULT_STYLES,
      resourcePath: resourcePath,
      scripts: scripts,
      styles: styles
    }),
        code = _parseToCode.code;

    return code;
  }
};
},{"fs":"8ITs","@neft/core":"lp4R","@neft/compiler-document":"JaWY","@neft/compiler-style":"jwep","@neft/input":"RVfa"}]},{},["Focm"], null)
//# sourceMappingURL=/index.js.map