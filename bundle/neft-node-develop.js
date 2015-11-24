/*
Neft.io - Server + Native + Browser
Contact: <contact@neft.io>

Version: 0.7.1
Target: node
Mode: develop

Copyright (C) 2014-2015 Neft.io - All Rights Reserved
Unauthorized copying of this file, via any medium is strictly prohibited
Proprietary and confidential

*/
var Neft = (function(){
'use strict';

// list of modules with empty objects
var modules = {"../utils/namespace.coffee.md":{},"../utils/stringifying.coffee.md":{},"../utils/async.coffee.md":{},"../utils/index.coffee.md":{},"../neft-assert/index.coffee.md":{},"../log/impls/node/index.coffee":{},"../log/index.coffee.md":{},"../signal/emitter.coffee":{},"../signal/index.coffee.md":{},"../list/index.coffee.md":{},"../dict/index.coffee.md":{},"../db/implementations/memory.coffee":{},"../db/implementation.coffee":{},"../db/index.coffee.md":{},"../schema/validators/array.coffee.md":{},"../schema/validators/object.coffee.md":{},"../schema/validators/optional.coffee.md":{},"../schema/validators/max.coffee.md":{},"../schema/validators/min.coffee.md":{},"../schema/validators/options.coffee.md":{},"../schema/validators/regexp.coffee.md":{},"../schema/validators/type.coffee.md":{},"../schema/index.coffee.md":{},"../networking/node_modules/form-data/node_modules/combined-stream/node_modules/delayed-stream/lib/delayed_stream.js":{},"../networking/node_modules/form-data/node_modules/combined-stream/lib/combined_stream.js":{},"../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/db.json":{},"../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/index.js":{},"../networking/node_modules/form-data/node_modules/mime-types/index.js":{},"../networking/node_modules/form-data/node_modules/async/lib/async.js":{},"../networking/node_modules/form-data/lib/form_data.js":{},"../networking/impl/node/index.coffee":{},"../networking/impl.coffee":{},"../networking/impl/node/request.coffee":{},"node_modules/expect/index.coffee.md":{},"../emitter/index.coffee.md":{},"../document/element/element/tag/stringify.coffee":{},"../typed-array/index.coffee":{},"../renderer/impl.coffee":{},"../renderer/impl/base/level0/item.coffee":{},"../renderer/impl/base/level0/image.coffee":{},"../renderer/impl/base/level0/text.coffee":{},"../renderer/impl/base/level0/textInput.coffee":{},"../renderer/impl/base/level0/loader/font.coffee":{},"../renderer/impl/base/level0/loader/resources.coffee":{},"../renderer/impl/base/level0/device.coffee":{},"../renderer/impl/base/level0/screen.coffee":{},"../renderer/impl/base/level0/navigator.coffee":{},"../renderer/impl/base/level0/sensor/rotation.coffee":{},"../renderer/impl/base/level0/sound/ambient.coffee":{},"../renderer/impl/base/level1/rectangle.coffee":{},"../renderer/impl/base/level1/grid.coffee":{},"../renderer/impl/base/level1/column.coffee":{},"../renderer/impl/base/level1/row.coffee":{},"../renderer/impl/base/level1/flow.coffee":{},"../renderer/impl/base/level1/animation.coffee":{},"../renderer/impl/base/level1/animation/property.coffee":{},"../renderer/impl/base/level1/animation/number.coffee":{},"../renderer/impl/base/level2/scrollable.coffee":{},"../renderer/impl/base/level1/binding.coffee":{},"../renderer/impl/base/level1/anchors.coffee":{},"../renderer/impl/base/utils.coffee":{},"../renderer/impl/base/utils/grid.coffee":{},"../renderer/impl/base/index.coffee":{},"../renderer/utils/item.coffee":{},"../renderer/types/namespace/screen.coffee.md":{},"../renderer/types/namespace/device.coffee.md":{},"../renderer/types/namespace/navigator.coffee.md":{},"../renderer/types/namespace/sensor/rotation.coffee.md":{},"../renderer/types/extension.coffee":{},"../renderer/types/extensions/class.coffee.md":{},"../renderer/types/extensions/animation.coffee.md":{},"../renderer/types/extensions/animation/types/property.coffee.md":{},"../renderer/types/extensions/animation/types/property/types/number.coffee.md":{},"../renderer/types/extensions/transition.coffee.md":{},"../renderer/types/basics/component.coffee":{},"../renderer/types/basics/item.coffee.md":{},"../renderer/types/basics/item/spacing.coffee.md":{},"../renderer/types/basics/item/alignment.coffee.md":{},"../renderer/types/basics/item/anchors.coffee.md":{},"../renderer/types/basics/item/layout.coffee.md":{},"../renderer/types/basics/item/margin.coffee.md":{},"../renderer/types/basics/item/pointer.coffee.md":{},"../renderer/types/basics/item/keys.coffee.md":{},"../renderer/types/basics/item/document.coffee.md":{},"../renderer/types/basics/item/types/image.coffee.md":{},"../renderer/types/basics/item/types/text.coffee.md":{},"../renderer/types/basics/item/types/text/font.coffee.md":{},"../renderer/types/basics/item/types/textInput.coffee.md":{},"../renderer/types/shapes/rectangle.coffee.md":{},"../renderer/types/layout/grid.coffee.md":{},"../renderer/types/layout/column.coffee.md":{},"../renderer/types/layout/row.coffee.md":{},"../renderer/types/layout/flow.coffee.md":{},"../renderer/types/layout/scrollable.coffee.md":{},"../renderer/types/sound/ambient.coffee.md":{},"../resources/resource.coffee.md":{},"../resources/index.coffee.md":{},"../renderer/types/loader/resources.coffee.md":{},"../renderer/types/loader/font.coffee.md":{},"../renderer/index.coffee.md":{},"../document/element/element/tag.coffee.md":{},"../document/element/element/tag/attrs.coffee.md":{},"../document/element/element/tag/query.coffee":{},"../document/element/element/text.coffee.md":{},"../document/node_modules/htmlparser2/node_modules/entities/maps/decode.json":{},"../document/node_modules/htmlparser2/node_modules/entities/lib/decode_codepoint.js":{},"../document/node_modules/htmlparser2/node_modules/entities/maps/entities.json":{},"../document/node_modules/htmlparser2/node_modules/entities/maps/legacy.json":{},"../document/node_modules/htmlparser2/node_modules/entities/maps/xml.json":{},"../document/node_modules/htmlparser2/lib/Tokenizer.js":{},"../document/node_modules/htmlparser2/lib/Parser.js":{},"../document/node_modules/htmlparser2/node_modules/domelementtype/index.js":{},"../document/node_modules/htmlparser2/node_modules/domhandler/lib/node.js":{},"../document/node_modules/htmlparser2/node_modules/domhandler/lib/element.js":{},"../document/node_modules/htmlparser2/node_modules/domhandler/index.js":{},"../document/node_modules/htmlparser2/lib/index.js":{},"../document/element/element/parser.coffee":{},"../document/element/element.coffee.md":{},"../document/element/index.coffee":{},"../document/attrChange.coffee":{},"../document/fragment.coffee":{},"../document/use.coffee":{},"../document/input.coffee":{},"../document/input/text.coffee":{},"../document/input/attr.coffee":{},"../document/condition.coffee":{},"../document/iterator.coffee":{},"../document/log.coffee":{},"../document/func.coffee.md":{},"../document/attrsToSet.coffee":{},"../document/file/clear.coffee":{},"../document/file/parse/rules.coffee.md":{},"../document/file/parse/fragments/links.coffee.md":{},"../document/file/parse/fragments.coffee.md":{},"../document/file/parse/attrs.coffee.md":{},"../document/file/parse/attrChanges.coffee.md":{},"../document/file/parse/iterators.coffee.md":{},"../document/file/parse/target.coffee.md":{},"../document/file/parse/uses.coffee.md":{},"../document/file/parse/storage.coffee.md":{},"../document/file/parse/conditions.coffee.md":{},"../document/file/parse/ids.coffee.md":{},"../document/file/parse/logs.coffee.md":{},"../document/file/parse/funcs.coffee.md":{},"../document/file/parse/attrSetting.coffee.md":{},"../document/file/render/parse/target.coffee":{},"../document/file/render/revert/listeners.coffee":{},"../document/file/render/revert/target.coffee":{},"../document/file.coffee.md":{},"../document/index.coffee.md":{},"../networking/impl/node/response.coffee":{},"../networking/uri.coffee.md":{},"../networking/handler.coffee.md":{},"../networking/request.coffee.md":{},"../networking/response.coffee.md":{},"../networking/response/error.coffee.md":{},"../networking/index.coffee.md":{},"route.coffee.md":{},"bootstrap/route.node.coffee.md":{},"package.json":{},"../styles/file/parse/styles.coffee.md":{},"../styles/file/styles.coffee":{},"../styles/style.coffee":{},"../styles/index.coffee.md":{},"index.coffee.md":{}};

// global object
var globalRequire = typeof require !== 'undefined' && require;
var setImmediate = setTimeout;
var global = Object.create(null, {
	setImmediate: {
		enumerable: true,
		get: function(){ return setImmediate; },
		set: function(val){ setImmediate = val; }
	}
});

// standard polyfills
console.assert = console.assert.bind(console);

// used as `require`
function getModule(paths, name){
	return modules[paths[name]] ||
	       (typeof Neft !== "undefined" && Neft[name]) ||
	       (typeof globalRequire === 'function' && globalRequire(name)) ||
	       (function(){throw new Error("Cannot find module '"+name+"'");}());
};

// fill modules by their bodies
modules['../utils/namespace.coffee.md'] = (function(){
var module = {exports: modules["../utils/namespace.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  module.exports = function(utils) {
    var OptionsArray, get, isStringArray;
    get = utils.get = function(obj, path, target) {
      var elem, i, key, _i, _j, _len, _len1;
      if (path == null) {
        path = '';
      }
      switch (typeof path) {
        case 'object':
          path = exports.clone(path);
          break;
        case 'string':
          path = path.split('.');
          break;
        default:
          throw new TypeError;
      }
      for (i = _i = 0, _len = path.length; _i < _len; i = ++_i) {
        key = path[i];
        if (!key.length && i) {
          throw new ReferenceError("utils.get(): empty properties are not supported");
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
          for (_j = 0, _len1 = obj.length; _j < _len1; _j++) {
            elem = obj[_j];
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
        if (typeof obj !== 'object' && typeof obj !== 'function') {
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
    get.OptionsArray = OptionsArray = (function(_super) {
      __extends(OptionsArray, _super);

      function OptionsArray() {
        OptionsArray.__super__.constructor.apply(this, arguments);
      }

      return OptionsArray;

    })(Array);
    return isStringArray = utils.isStringArray = function(arg) {
      null;
      //<development>;
      if (typeof arg !== 'string') {
        throw new Error("utils.isStringArray value must be a string");
      }
      //</development>;
      return /\[\]$/.test(arg);
    };
  };

}).call(this);


return module.exports;
})();modules['../utils/stringifying.coffee.md'] = (function(){
var module = {exports: modules["../utils/stringifying.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var isArray;

  isArray = Array.isArray;

  module.exports = function(utils) {
    utils.simplify = (function() {
      var nativeCtors, nativeProtos;
      nativeProtos = [Array.prototype, Object.prototype];
      nativeCtors = [Array, Object];
      return function(obj, opts) {
        var ctors, cyclic, i, ids, objs, optsCtors, optsInsts, optsProps, optsProtos, parse, protos, references, value, _i, _len;
        if (opts == null) {
          opts = {};
        }
        null;
        //<development>;
        if (!utils.isObject(obj)) {
          throw new Error("utils.simplify object must be an object");
        }
        if (!utils.isPlainObject(opts)) {
          throw new Error("utils.simplify options must be a plain object");
        }
        //</development>;
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
        cyclic = function(obj) {
          var i, key, len, objIds, proto, value;
          len = objs.push(obj);
          ids.push(objIds = []);
          for (key in obj) {
            value = obj[key];
            if (!(obj.hasOwnProperty(key))) {
              continue;
            }
            if (!(value && typeof value === 'object')) {
              continue;
            }
            if (optsProps && exports.lookupGetter(obj, key)) {
              objIds.push(null);
              continue;
            }
            if (!~(i = objs.indexOf(value))) {
              i = cyclic(value);
            }
            objIds.push(i);
          }
          if (optsProtos && (proto = getPrototypeOf(obj))) {
            if (~(nativeProtos.indexOf(proto))) {
              i = null;
            } else if (!~(i = objs.indexOf(proto))) {
              i = cyclic(proto);
            }
            objIds.push(i);
          }
          return len - 1;
        };
        parse = function(obj, index) {
          var ctor, desc, isReference, key, objId, objIds, objReferences, obji, protoObjId, r, value;
          r = isArray(obj) ? [] : {};
          objIds = ids[index];
          obji = 0;
          objReferences = null;
          for (key in obj) {
            value = obj[key];
            if (!(obj.hasOwnProperty(key))) {
              continue;
            }
            r[key] = value;
            isReference = false;
            if (value && typeof value === 'object') {
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
            if (optsInsts || obj.hasOwnProperty('constructor')) {
              if (!~(nativeCtors.indexOf(ctor))) {
                ctors[index] = ctor;
              }
            }
          }
          if (objReferences) {
            references[index] = objReferences;
          }
          return r;
        };
        cyclic(obj);
        for (i = _i = 0, _len = objs.length; _i < _len; i = ++_i) {
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
    })();
    return utils.assemble = (function() {
      var ctorPropConfig;
      ctorPropConfig = {
        value: null
      };
      return function(obj) {
        var constructors, func, key, objI, object, objects, opts, optsCtors, optsInsts, optsProps, optsProtos, protos, ref, refI, refId, references, refs, refsIds, value, _i, _j, _k, _l, _len, _len1, _len2, _len3;
        null;
        //<development>;
        if (!utils.isPlainObject(obj)) {
          throw new Error("utils.assemble object must be a plain object");
        }
        //</development>;
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
            for (_i = 0, _len = refs.length; _i < _len; _i++) {
              ref = refs[_i];
              refsIds.push(obj[ref].value);
              obj[ref].value = objects[obj[ref].value];
            }
          }
        } else {
          for (objI in references) {
            refs = references[objI];
            obj = objects[objI];
            for (_j = 0, _len1 = refs.length; _j < _len1; _j++) {
              ref = refs[_j];
              refsIds.push(obj[ref]);
              obj[ref] = objects[obj[ref]];
            }
          }
        }
        if (optsProps) {
          for (_k = 0, _len2 = objects.length; _k < _len2; _k++) {
            obj = objects[_k];
            for (key in obj) {
              value = obj[key];
              if (obj.hasOwnProperty(key)) {
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
          for (_l = 0, _len3 = refs.length; _l < _len3; _l++) {
            ref = refs[_l];
            obj[ref] = objects[refsIds[refId++]];
          }
        }
        return objects[0];
      };
    })();
  };

}).call(this);


return module.exports;
})();modules['../utils/async.coffee.md'] = (function(){
var module = {exports: modules["../utils/async.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var NOP, Stack, assert, exports, forEach, isArray, shift, utils,
    __slice = [].slice;

  utils = null;

  assert = console.assert;

  exports = module.exports;

  shift = Array.prototype.shift;

  isArray = Array.isArray;

  NOP = function() {};

  forEach = (function() {
    var forArray, forObject;
    forArray = function(arr, callback, onEnd, thisArg) {
      var i, n, next;
      i = 0;
      n = arr.length;
      next = function() {
        if (i === n) {
          return onEnd();
        }
        i++;
        return callback.call(thisArg, arr[i - 1], i - 1, arr, next);
      };
      return next();
    };
    forObject = function(obj, callback, onEnd, thisArg) {
      var i, keys, n, next;
      keys = Object.keys(obj);
      i = 0;
      n = keys.length;
      next = function() {
        var key;
        if (i === n) {
          return onEnd();
        }
        key = keys[i];
        callback.call(thisArg, key, obj[key], obj, next);
        return i++;
      };
      return next();
    };
    return function(list, callback, onEnd, thisArg) {
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
  })();

  Stack = (function() {
    function Stack() {
      this._arr = [];
      this.length = 0;
      Object.preventExtensions(this);
    }

    Stack.prototype.add = function(func, context, args) {
      if (args != null) {
        assert(utils.isObject(args));
      }
      this._arr.push(func, context, args);
      this.length++;
      return this;
    };

    Stack.prototype.callNext = function(args, callback) {
      var arg, callbackWrapper, called, context, func, funcArgs, funcLength, i, syncError, _i, _len;
      if (typeof args === 'function' && (callback == null)) {
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
        throw new TypeError("ASync Stack::callNext(): function to call is not a function");
      }
      funcLength = func.length || Math.max((args != null ? args.length : void 0) || 0, (funcArgs != null ? funcArgs.length : void 0) || 0) + 1;
      syncError = null;
      called = false;
      callbackWrapper = function() {
        assert(!called || !syncError, "Callback can't be called if function throws an error;\n" + ("Function: `" + func + "`\nSynchronous error: `" + syncError + "`"));
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
        for (i = _i = 0, _len = args.length; _i < _len; i = ++_i) {
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

    Stack.prototype.runAll = function(callback, ctx) {
      var callNext, onNextCalled;
      if (callback == null) {
        callback = NOP;
      }
      if (ctx == null) {
        ctx = null;
      }
      if (typeof callback !== 'function') {
        throw new TypeError("ASync runAll(): passed callback is not a function");
      }
      if (!this._arr.length) {
        return callback.call(ctx, null);
      }
      onNextCalled = (function(_this) {
        return function() {
          var args, err;
          err = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
          if (err != null) {
            return callback.call(ctx, err);
          }
          if (_this._arr.length) {
            return callNext(args);
          }
          return callback.apply(ctx, arguments);
        };
      })(this);
      callNext = (function(_this) {
        return function(args) {
          return _this.callNext(args, onNextCalled);
        };
      })(this);
      callNext();
      return null;
    };

    Stack.prototype.runAllSimultaneously = function(callback, ctx) {
      var done, length, n, onDone;
      if (callback == null) {
        callback = NOP;
      }
      if (ctx == null) {
        ctx = null;
      }
      assert(typeof callback === 'function');
      length = n = this._arr.length / 3;
      done = 0;
      if (!length) {
        return callback.call(ctx);
      }
      onDone = function(err) {
        ++done;
        if (done > length) {
          return;
        }
        if (err) {
          done = length;
          return callback.call(ctx, err);
        }
        if (done === length) {
          return callback.call(ctx);
        }
      };
      while (n--) {
        this.callNext(onDone);
      }
      return null;
    };

    return Stack;

  })();


  /*
  	Exports
   */

  module.exports = function() {
    utils = arguments[0];
    return utils.async = {
      forEach: forEach,
      Stack: Stack
    };
  };

}).call(this);


return module.exports;
})();modules['../utils/index.coffee.md'] = (function(){
var module = {exports: modules["../utils/index.coffee.md"]};
var require = getModule.bind(null, {"./namespace":"../utils/namespace.coffee.md","./stringifying":"../utils/stringifying.coffee.md","./async":"../utils/async.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var clone, cloneDeep, createObject, defObjProp, funcToString, getObjOwnPropDesc, getOwnPropertyNames, getPrototypeOf, has, hasOwnProp, isArray, isEqual, isObject, isPrimitive, merge, mergeDeep, objKeys, pop, random, setPrototypeOf, shift, toString, _ref;

  toString = Object.prototype.toString;

  funcToString = Function.prototype.toString;

  isArray = Array.isArray;

  _ref = Array.prototype, shift = _ref.shift, pop = _ref.pop;

  createObject = Object.create;

  getPrototypeOf = Object.getPrototypeOf, getOwnPropertyNames = Object.getOwnPropertyNames;

  objKeys = Object.keys;

  hasOwnProp = Object.hasOwnProperty;

  getObjOwnPropDesc = Object.getOwnPropertyDescriptor;

  defObjProp = Object.defineProperty;

  random = Math.random;


  /*
  	Link subfiles
   */

  require('./namespace')(exports);

  require('./stringifying')(exports);

  require('./async')(exports);

  exports.isNode = exports.isServer = exports.isClient = exports.isBrowser = exports.isQml = exports.isAndroid = false;

  switch (true) {
    case (typeof window !== "undefined" && window !== null ? window.document : void 0) != null:
      exports.isClient = exports.isBrowser = true;
      break;
    case (typeof Qt !== "undefined" && Qt !== null ? Qt.include : void 0) != null:
      exports.isClient = exports.isQml = true;
      break;
    case typeof android !== "undefined" && android !== null:
      exports.isClient = exports.isAndroid = true;
      break;
    case (typeof process !== "undefined" && process !== null) && Object.prototype.toString.call(process) === '[object process]':
      exports.isNode = exports.isServer = true;
  }

  exports.NOP = function() {};

  exports.is = Object.is || function(val1, val2) {
    if (val1 === 0 && val2 === 0) {
      return 1 / val1 === 1 / val2;
    } else if (val1 !== val1) {
      return val2 !== val2;
    } else {
      return val1 === val2;
    }
  };

  exports.isFloat = function(val) {
    return typeof val === 'number' && isFinite(val);
  };

  exports.isInteger = function(val) {
    return typeof val === 'number' && isFinite(val) && val > -9007199254740992 && val < 9007199254740992 && Math.floor(val) === val;
  };

  isPrimitive = exports.isPrimitive = function(val) {
    return val === null || typeof val === 'string' || typeof val === 'number' || typeof val === 'boolean' || typeof val === 'undefined';
  };

  isObject = exports.isObject = function(param) {
    return param !== null && typeof param === 'object';
  };

  exports.isPlainObject = function(param) {
    var proto;
    if (!isObject(param)) {
      return false;
    }
    proto = getPrototypeOf(param);
    if (!proto) {
      return true;
    }
    if ((proto === Object.prototype) && !getPrototypeOf(proto)) {
      return true;
    }
    return false;
  };

  exports.isArguments = function(param) {
    return toString.call(param) === '[object Arguments]';
  };

  merge = exports.merge = function(source, obj) {
    var key, value;
    null;
    //<development>;
    if (isPrimitive(source)) {
      throw new Error("utils.merge source cannot be primitive");
    }
    if (isPrimitive(obj)) {
      throw new Error("utils.merge object cannot be primitive");
    }
    if (source === obj) {
      throw new Error("utils.merge source and object are the same");
    }
    //</development>;
    for (key in obj) {
      value = obj[key];
      if (obj.hasOwnProperty(key)) {
        source[key] = value;
      }
    }
    return source;
  };

  mergeDeep = exports.mergeDeep = function(source, obj) {
    var key, sourceValue, value;
    null;
    //<development>;
    if (isPrimitive(source)) {
      throw new Error("utils.mergeDeep source cannot be primitive");
    }
    if (isPrimitive(obj)) {
      throw new Error("utils.mergeDeep object cannot be primitive");
    }
    if (source === obj) {
      throw new Error("utils.mergeDeep source and object are the same");
    }
    //</development>;
    for (key in obj) {
      value = obj[key];
      if (!(hasOwnProp.call(obj, key))) {
        continue;
      }
      sourceValue = source[key];
      if (value && typeof value === 'object' && !isArray(value) && sourceValue && typeof sourceValue === 'object' && !isArray(sourceValue)) {
        mergeDeep(sourceValue, value);
        continue;
      }
      source[key] = value;
    }
    return source;
  };

  exports.fill = function(source, obj) {
    var key, value;
    null;
    //<development>;
    if (isPrimitive(source)) {
      throw new Error("utils.fill source cannot be primitive");
    }
    if (isPrimitive(obj)) {
      throw new Error("utils.fill object cannot be primitive");
    }
    if (source === obj) {
      throw new Error("utils.fill source and object are the same");
    }
    //</development>;
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

  exports.remove = function(obj, elem) {
    var index;
    null;
    //<development>;
    if (isPrimitive(obj)) {
      throw new Error("utils.remove object cannot be primitive");
    }
    //</development>;
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

  exports.removeFromUnorderedArray = function(arr, elem) {
    var index;
    null;
    //<development>;
    if (!Array.isArray(arr)) {
      throw new Error("utils.removeFromUnorderedArray array must be an Array");
    }
    //</development>;
    index = arr.indexOf(elem);
    if (index !== -1) {
      arr[index] = arr[arr.length - 1];
      arr.pop();
    }
  };

  exports.getPropertyDescriptor = function(obj, prop) {
    var desc;
    null;
    //<development>;
    if (isPrimitive(obj)) {
      throw new Error("utils.getPropertyDescriptor object cannot be primitive");
    }
    if (typeof prop !== 'string') {
      throw new Error("utils.getPropertyDescriptor property must be a string");
    }
    //</development>;
    while (obj && !desc) {
      desc = getObjOwnPropDesc(obj, prop);
      obj = getPrototypeOf(obj);
    }
    return desc;
  };

  exports.lookupGetter = (function() {
    var lookupGetter;
    if (Object.prototype.__lookupGetter__) {
      lookupGetter = Object.prototype.lookupGetter;
      (function(obj, prop) {
        var getter;
        getter = lookupGetter.call(obj, prop);
        return (getter != null ? getter.trueGetter : void 0) || getter;
      });
    }
    return function(obj, prop) {
      var desc, _ref1;
      if (desc = exports.getPropertyDescriptor(obj, prop)) {
        return ((_ref1 = desc.get) != null ? _ref1.trueGetter : void 0) || desc.get;
      }
    };
  })();

  exports.lookupSetter = (function() {
    if (Object.prototype.__lookupSetter__) {
      return Function.call.bind(Object.prototype.__lookupSetter__);
    }
    return function(obj, prop) {
      var desc;
      desc = exports.getPropertyDescriptor(obj, prop);
      return desc != null ? desc.set : void 0;
    };
  })();

  defObjProp(exports, 'WRITABLE', {
    value: 1 << 0
  });

  defObjProp(exports, 'ENUMERABLE', {
    value: 1 << 1
  });

  defObjProp(exports, 'CONFIGURABLE', {
    value: 1 << 2
  });

  exports.defineProperty = (function() {
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
    return function(obj, prop, desc, getter, setter) {
      var cfg, _getter;
      null;
      //<development>;
      if (isPrimitive(obj)) {
        throw new Error("utils.defineProperty object cannot be primitive");
      }
      if (typeof prop !== 'string') {
        throw new Error("utils.defineProperty property must be a string");
      }
      if ((desc != null) && (!exports.isInteger(desc) || desc < 0)) {
        throw new Error("utils.defineProperty descriptors bitmask must be a positive integer");
      }
      //</development>;
      if (setter === void 0) {
        cfg = valueCfg;
        valueCfg.value = getter;
        valueCfg.writable = desc & WRITABLE;
      } else {
        if (isSafari && getter) {
          _getter = getter;
          getter = function() {
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
  })();

  clone = exports.clone = function(param) {
    var key, result, _i, _len, _ref1;
    if (isArray(param)) {
      return param.slice();
    }
    if (isObject(param)) {
      result = createObject(getPrototypeOf(param));
      _ref1 = objKeys(param);
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        key = _ref1[_i];
        result[key] = param[key];
      }
      return result;
    }
    return param;
  };

  cloneDeep = exports.cloneDeep = function(param) {
    var key, result, _i, _len, _ref1;
    result = clone(param);
    if (isObject(result)) {
      _ref1 = objKeys(result);
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        key = _ref1[_i];
        result[key] = cloneDeep(result[key]);
      }
    }
    return result;
  };

  exports.isEmpty = function(object) {
    var key;
    if (typeof object === 'string') {
      return object === '';
    }
    //<development>;
    if (isPrimitive(object)) {
      throw new Error("utils.isEmpty object must be a string or not primitive");
    }
    //</development>;
    if (isArray(object)) {
      return !object.length;
    } else {
      for (key in object) {
        return false;
      }
      return true;
    }
  };

  exports.last = function(arg) {
    null;
    //<development>;
    if (isPrimitive(arg)) {
      throw new Error("utils.last array cannot be primitive");
    }
    //</development>;
    return arg[arg.length - 1];
  };

  exports.clear = function(obj) {
    var key, _, _i, _j, _len, _ref1, _ref2;
    null;
    //<development>;
    if (isPrimitive(obj)) {
      throw new Error("utils.clear object cannot be primitive");
    }
    //</development>;
    if (isArray(obj)) {
      for (_ = _i = 0, _ref1 = obj.length; _i < _ref1; _ = _i += 1) {
        obj.pop();
      }
    } else {
      _ref2 = objKeys(obj);
      for (_j = 0, _len = _ref2.length; _j < _len; _j++) {
        key = _ref2[_j];
        delete obj[key];
      }
    }
    return obj;
  };

  setPrototypeOf = exports.setPrototypeOf = (function() {
    var tmp;
    if (typeof Object.setPrototypeOf === 'function') {
      return Object.setPrototypeOf;
    }
    tmp = {};
    tmp.__proto__ = {
      a: 1
    };
    if (tmp.a === 1) {
      return function(obj, proto) {
        null;
        //<development>;
        if (isPrimitive(obj)) {
          throw new Error("utils.setPrototypeOf object cannot be primitive");
        }
        if ((proto != null) && isPrimitive(proto)) {
          throw new Error("utils.setPrototypeOf prototype cannot be primitive");
        }
        //</development>;
        obj.__proto__ = proto;
        return obj;
      };
    }
    return function(obj, proto) {
      var newObj;
      null;
      //<development>;
      if (isPrimitive(obj)) {
        throw new Error("utils.setPrototypeOf object cannot be primitive");
      }
      if ((proto != null) && isPrimitive(proto)) {
        throw new Error("utils.setPrototypeOf prototype cannot be primitive");
      }
      //</development>;
      if (typeof obj === 'object') {
        newObj = createObject(proto);
        merge(newObj, obj);
      } else {
        merge(obj, proto);
      }
      return newObj;
    };
  })();

  has = exports.has = function(obj, val) {
    var key, value;
    if (typeof obj === 'string') {
      return !!~obj.indexOf(val);
    } else {
      //<development>;
      if (isPrimitive(obj)) {
        throw new Error("utils.has object must be a string or not primitive");
      }
      //</development>;
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

  exports.objectToArray = function(obj, valueGen, target) {
    var i, key, keys, value, _i, _len;
    keys = objKeys(obj);
    if (target == null) {
      target = keys;
    }
    //<development>;
    if (!isObject(obj)) {
      throw new Error("utils.objectToArray object must be an object");
    }
    if ((valueGen != null) && typeof valueGen !== 'function') {
      throw new Error("utils.objectToArray valueGen must be a function");
    }
    if (!isArray(target)) {
      throw new Error("utils.objectToArray target must be an array");
    }
    //</development>;
    for (i = _i = 0, _len = keys.length; _i < _len; i = ++_i) {
      key = keys[i];
      value = valueGen ? valueGen(key, obj[key], obj) : obj[key];
      target[i] = value;
    }
    return target;
  };

  exports.arrayToObject = function(arr, keyGen, valueGen, target) {
    var elem, i, key, value, _i, _len;
    if (target == null) {
      target = {};
    }
    null;
    //<development>;
    if (!isArray(arr)) {
      throw new Error("utils.arrayToObject array must be an array");
    }
    if ((keyGen != null) && typeof keyGen !== 'function') {
      throw new Error("utils.arrayToObject keyGen must be a function");
    }
    if ((valueGen != null) && typeof valueGen !== 'function') {
      throw new Error("utils.arrayToObject valueGen must be a function");
    }
    if (!isObject(target)) {
      throw new Error("utils.arrayToObject target must be an object");
    }
    //</development>;
    for (i = _i = 0, _len = arr.length; _i < _len; i = ++_i) {
      elem = arr[i];
      key = keyGen ? keyGen(i, elem, arr) : i;
      value = valueGen ? valueGen(i, elem, arr) : elem;
      if (key != null) {
        target[key] = value;
      }
    }
    return target;
  };

  exports.capitalize = function(str) {
    null;
    //<development>;
    if (typeof str !== 'string') {
      throw new Error("utils.capitalize string must be a string");
    }
    //</development>;
    if (!str.length) {
      return '';
    }
    return str[0].toUpperCase() + str.slice(1);
  };

  exports.addSlashes = (function() {
    var NEW_SUB_STR, SLASHES_RE;
    SLASHES_RE = /'|"/g;
    NEW_SUB_STR = '\\$\&';
    return function(str) {
      null;
      //<development>;
      if (typeof str !== 'string') {
        throw new Error("utils.addSlashes string must be a string");
      }
      //</development>;
      if (!str.length) {
        return str;
      }
      return str.replace(SLASHES_RE, NEW_SUB_STR);
    };
  })();

  exports.uid = function(n) {
    var str;
    if (n == null) {
      n = 8;
    }
    null;
    //<development>;
    if (typeof n !== 'number' || n <= 0 || !isFinite(n)) {
      throw new Error("utils.uid length must be a positive finite number");
    }
    //</development>;
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

  exports.tryFunction = function(func, context, args, onfail) {
    var err;
    null;
    //<development>;
    if (typeof func !== 'function') {
      throw new Error("utils.tryFunction function must be a function");
    }
    if ((args != null) && !isObject(args)) {
      throw new Error("utils.tryFunction arguments must be an object");
    }
    //</development>;
    try {
      return func.apply(context, args);
    } catch (_error) {
      err = _error;
      if (typeof onfail === 'function') {
        return onfail(err);
      } else {
        return onfail;
      }
    }
  };

  exports.catchError = function(func, context, args) {
    var err;
    null;
    //<development>;
    if (typeof func !== 'function') {
      throw new Error("utils.catchError function must be a function");
    }
    if ((args != null) && !isObject(args)) {
      throw new Error("utils.catchError arguments must be an object");
    }
    //</development>;
    try {
      func.apply(context, args);
    } catch (_error) {
      err = _error;
      return err;
    }
  };

  exports.bindFunctionContext = (function() {
    var anyLengthBindFunc, bindFuncs;
    bindFuncs = [
      function(func, ctx) {
        return function() {
          return func.call(ctx);
        };
      }, function(func, ctx) {
        return function(a1) {
          return func.call(ctx, a1);
        };
      }, function(func, ctx) {
        return function(a1, a2) {
          return func.call(ctx, a1, a2);
        };
      }, function(func, ctx) {
        return function(a1, a2, a3) {
          return func.call(ctx, a1, a2, a3);
        };
      }, function(func, ctx) {
        return function(a1, a2, a3, a4) {
          return func.call(ctx, a1, a2, a3, a4);
        };
      }, function(func, ctx) {
        return function(a1, a2, a3, a4, a5) {
          return func.call(ctx, a1, a2, a3, a4, a5);
        };
      }, function(func, ctx) {
        return function(a1, a2, a3, a4, a5, a6) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6);
        };
      }, function(func, ctx) {
        return function(a1, a2, a3, a4, a5, a6, a7) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6, a7);
        };
      }
    ];
    anyLengthBindFunc = function(func, ctx) {
      return function() {
        return func.apply(ctx, arguments);
      };
    };
    return function(func, ctx) {
      var _name;
      null;
      //<development>;
      if (typeof func !== 'function') {
        throw new Error("utils.bindFunctionContext function must be a function");
      }
      //</development>;
      return (typeof bindFuncs[_name = func.length] === "function" ? bindFuncs[_name](func, ctx) : void 0) || anyLengthBindFunc(func, ctx);
    };
  })();

  exports.errorToObject = function(error) {
    var result;
    null;
    //<development>;
    if (!(error instanceof Error)) {
      throw new Error("utils.errorToObject error must be an Error instance");
    }
    //</development>;
    result = {
      name: error.name,
      message: error.message
    };
    exports.merge(result, error);
    return result;
  };

  exports.getOwnProperties = function(obj) {
    var result;
    null;
    //<development>;
    if (!isObject(obj)) {
      throw new Error("utils.getOwnProperties object must be an object");
    }
    //</development>;
    result = isArray(obj) ? [] : {};
    merge(result, obj);
    return result;
  };

  isEqual = exports.isEqual = (function() {
    var defaultComparison, forArrays, forObjects;
    defaultComparison = function(a, b) {
      return a === b;
    };
    forArrays = function(a, b, compareFunc) {
      var aValue, bValue, isTrue, _i, _j, _k, _l, _len, _len1, _len2, _len3;
      if (getPrototypeOf(a) !== getPrototypeOf(b)) {
        return false;
      }
      if (a.length !== b.length) {
        return false;
      }
      for (_i = 0, _len = a.length; _i < _len; _i++) {
        aValue = a[_i];
        isTrue = false;
        for (_j = 0, _len1 = b.length; _j < _len1; _j++) {
          bValue = b[_j];
          if (bValue && typeof bValue === 'object') {
            if (isEqual(aValue, bValue, compareFunc)) {
              isTrue = true;
            }
            continue;
          }
          if (compareFunc(aValue, bValue)) {
            isTrue = true;
            break;
          }
        }
        if (!isTrue) {
          return false;
        }
      }
      for (_k = 0, _len2 = b.length; _k < _len2; _k++) {
        bValue = b[_k];
        isTrue = false;
        for (_l = 0, _len3 = a.length; _l < _len3; _l++) {
          aValue = a[_l];
          if (aValue && typeof aValue === 'object') {
            if (isEqual(bValue, aValue, compareFunc)) {
              isTrue = true;
            }
            continue;
          }
          if (compareFunc(bValue, aValue)) {
            isTrue = true;
            break;
          }
        }
        if (!isTrue) {
          return false;
        }
      }
      return true;
    };
    forObjects = function(a, b, compareFunc) {
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
      for (key in a) {
        value = a[key];
        if (!(a.hasOwnProperty(key))) {
          continue;
        }
        if (value && typeof value === 'object') {
          if (!isEqual(value, b[key], compareFunc)) {
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
    return function(a, b, compareFunc) {
      if (compareFunc == null) {
        compareFunc = defaultComparison;
      }
      null;
      //<development>;
      if (typeof compareFunc !== 'function') {
        throw new Error("utils.isEqual compareFunction must be a function");
      }
      //</development>;
      if (isArray(a) && isArray(b)) {
        return forArrays(a, b, compareFunc);
      } else if (isObject(a) && isObject(b)) {
        return forObjects(a, b, compareFunc);
      } else {
        return compareFunc(a, b);
      }
    };
  })();

}).call(this);


return module.exports;
})();modules['../neft-assert/index.coffee.md'] = (function(){
var module = {exports: modules["../neft-assert/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var AssertionError, assert, createFailFunction, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = module.exports = function(expr, msg) {
    if (!expr) {
      return assert.fail(expr, true, msg, '==', assert);
    }
  };

  assert.AssertionError = AssertionError = (function(_super) {
    __extends(AssertionError, _super);

    AssertionError.generateMessage = function(error, msg) {
      var msgDef, standardMsg, where;
      standardMsg = "" + error.actual + " " + error.operator + " " + error.expected;
      if (/\.\.\.$/.test(msg)) {
        msgDef = msg.slice(0, -3).split(' ');
        if (msgDef[2] == null) {
          msgDef[2] = '';
        }
        msgDef[2] += '';
        where = "" + error.scope + msgDef[0];
        return ("" + standardMsg + "\n") + ("  " + where + " " + msgDef[1] + msgDef[2] + " (got `" + error.actual + "`, type " + (typeof error.actual) + ")") + (", but `" + error.operator + " " + error.expected + "` asserted;\n") + ("  Documentation: http://neft.io/docs/" + where + "\n");
      } else if (msg) {
        return msg;
      } else {
        return standardMsg;
      }
    };

    function AssertionError(opts) {
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

  })(Error);

  createFailFunction = function(assert) {
    var func;
    return func = function(actual, expected, msg, operator, stackStartFunction) {
      throw new assert.AssertionError({
        actual: actual,
        expected: expected,
        message: msg,
        operator: operator,
        scope: assert._scope,
        stackStartFunction: stackStartFunction || func
      });
    };
  };

  assert.scope = function(msg) {
    var func;
    msg = "" + this._scope + msg;
    func = function(expr, msg) {
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

  assert.notOk = function(expr, msg) {
    if (expr) {
      return this.fail(expr, true, msg, '!=', assert.notOk);
    }
  };

  assert.is = function(actual, expected, msg) {
    if (!utils.is(actual, expected)) {
      return this.fail(actual, expected, msg, '===', assert.is);
    }
  };

  assert.isNot = function(actual, expected, msg) {
    if (utils.is(actual, expected)) {
      return this.fail(actual, expected, msg, '!==', assert.isNot);
    }
  };

  assert.isDefined = function(val, msg) {
    if (val == null) {
      return this.fail(val, null, msg, '!=', assert.isDefined);
    }
  };

  assert.isNotDefined = function(val, msg) {
    if (val != null) {
      return this.fail(val, null, msg, '==', assert.isNotDefined);
    }
  };

  assert.isPrimitive = function(val, msg) {
    if (!utils.isPrimitive(val)) {
      return this.fail(val, 'primitive', msg, 'is', assert.isPrimitive);
    }
  };

  assert.isNotPrimitive = function(val, msg) {
    if (utils.isPrimitive(val)) {
      return this.fail(val, 'primitive', msg, 'isn\'t', assert.isNotPrimitive);
    }
  };

  assert.isString = function(val, msg) {
    if (typeof val !== 'string') {
      return this.fail(val, 'string', msg, 'is', assert.isString);
    }
  };

  assert.isNotString = function(val, msg) {
    if (typeof val === 'string') {
      return this.fail(val, 'string', msg, 'isn\'t', assert.isNotString);
    }
  };

  assert.isFloat = function(val, msg) {
    if (!utils.isFloat(val)) {
      return this.fail(val, 'float', msg, 'is', assert.isFloat);
    }
  };

  assert.isNotFloat = function(val, msg) {
    if (utils.isFloat(val)) {
      return this.fail(val, 'float', msg, 'isn\'t', assert.isNotFloat);
    }
  };

  assert.isInteger = function(val, msg) {
    if (!utils.isInteger(val)) {
      return this.fail(val, 'integer', msg, 'is', assert.isInteger);
    }
  };

  assert.isNotInteger = function(val, msg) {
    if (utils.isInteger(val)) {
      return this.fail(val, 'integer', msg, 'isn\'t', assert.isNotInteger);
    }
  };

  assert.isBoolean = function(val, msg) {
    if (typeof val !== 'boolean') {
      return this.fail(val, 'boolean', msg, 'is', assert.isBoolean);
    }
  };

  assert.isNotBoolean = function(val, msg) {
    if (typeof val === 'boolean') {
      return this.fail(val, 'boolean', msg, 'isn\'t', assert.isNotBoolean);
    }
  };

  assert.isFunction = function(val, msg) {
    if (typeof val !== 'function') {
      return this.fail(val, 'function', msg, 'is', assert.isFunction);
    }
  };

  assert.isNotFunction = function(val, msg) {
    if (typeof val === 'function') {
      return this.fail(val, 'function', msg, 'isn\'t', assert.isNotFunction);
    }
  };

  assert.isObject = function(val, msg) {
    if (val === null || typeof val !== 'object') {
      return this.fail(val, 'object', msg, 'is', assert.isObject);
    }
  };

  assert.isNotObject = function(val, msg) {
    if (val !== null && typeof val === 'object') {
      return this.fail(val, 'object', msg, 'isn\'t', assert.isNotObject);
    }
  };

  assert.isPlainObject = function(val, msg) {
    if (!utils.isPlainObject(val)) {
      return this.fail(val, 'plain object', msg, 'is', assert.isPlainObject);
    }
  };

  assert.isNotPlainObject = function(val, msg) {
    if (utils.isPlainObject(val)) {
      return this.fail(val, 'plain object', msg, 'isn\'t', assert.isNotPlainObject);
    }
  };

  assert.isArray = function(val, msg) {
    if (!Array.isArray(val)) {
      return this.fail(val, 'array', msg, 'is', assert.isArray);
    }
  };

  assert.isNotArray = function(val, msg) {
    if (Array.isArray(val)) {
      return this.fail(val, 'array', msg, 'isn\'t', assert.isNotArray);
    }
  };

  assert.isEqual = function(val1, val2, msg) {
    if (!utils.isEqual(val1, val2)) {
      return this.fail(val1, val2, msg, 'equal', assert.isEqual);
    }
  };

  assert.isNotEqual = function(val1, val2, msg) {
    if (utils.isEqual(val1, val2)) {
      return this.fail(val1, val2, msg, 'isn\'t equal', assert.isNotEqual);
    }
  };

  assert.instanceOf = function(val, ctor, msg) {
    var ctorName;
    if (!(val instanceof ctor)) {
      ctorName = ctor.__path__ || ctor.__name__ || ctor.name || ctor;
      return this.fail(val, ctorName, msg, 'instanceof', assert.instanceOf);
    }
  };

  assert.notInstanceOf = function(val, ctor, msg) {
    var ctorName;
    if (val instanceof ctor) {
      ctorName = ctor.__path__ || ctor.__name__ || ctor.name || ctor;
      return this.fail(val, ctorName, msg, 'instanceof', assert.notInstanceOf);
    }
  };

  assert.lengthOf = function(val, length, msg) {
    if ((val != null ? val.length : void 0) !== length) {
      return this.fail(val, length, msg, '.length ===', assert.lengthOf);
    }
  };

  assert.notLengthOf = function(val, length, msg) {
    if ((val != null ? val.length : void 0) === length) {
      return this.fail(val, length, msg, '.length !==', assert.notLengthOf);
    }
  };

  assert.operator = function(val1, operator, val2, msg) {
    var pass;
    pass = (function() {
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
          throw "Unexpected operator `" + operator + "`";
      }
    })();
    if (!pass) {
      return this.fail(val1, val2, msg, operator, assert.operator);
    }
  };

  assert.match = function(val, regexp, msg) {
    if (!regexp.test(val)) {
      return this.fail(val, regexp, msg, 'match', assert.match);
    }
  };

  assert.notMatch = function(val, regexp, msg) {
    if (regexp.test(val)) {
      return this.fail(val, regexp, msg, 'not match', assert.match);
    }
  };

}).call(this);


return module.exports;
})();modules['../log/impls/node/index.coffee'] = (function(){
var module = {exports: modules["../log/impls/node/index.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var writeStdout,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  writeStdout = process.stdout.write.bind(process.stdout);

  module.exports = function(Log) {
    var LogNode;
    return LogNode = (function(_super) {
      __extends(LogNode, _super);

      function LogNode() {
        return LogNode.__super__.constructor.apply(this, arguments);
      }

      LogNode.MARKERS = {
        white: function(str) {
          return "\u001b[37m" + str + "\u001b[39m";
        },
        green: function(str) {
          return "\u001b[32m" + str + "\u001b[39m";
        },
        gray: function(str) {
          return "\u001b[90m" + str + "\u001b[39m";
        },
        blue: function(str) {
          return "\u001b[34m" + str + "\u001b[39m";
        },
        yellow: function(str) {
          return "\u001b[33m" + str + "\u001b[39m";
        },
        red: function(str) {
          return "\u001b[31m" + str + "\u001b[39m";
        },
        bold: function(str) {
          return "\u001b[1m" + str + "\u001b[22m";
        }
      };

      LogNode.time = process.hrtime;

      LogNode.timeDiff = function(since) {
        var diff;
        diff = process.hrtime(since);
        return (diff[0] * 1e9 + diff[1]) / 1e6;
      };

      LogNode.prototype._write = function(msg) {
        return writeStdout(msg + "\n");
      };

      return LogNode;

    })(Log);
  };

}).call(this);


return module.exports;
})();modules['../log/index.coffee.md'] = (function(){
var module = {exports: modules["../log/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","./impls/node/index.coffee":"../log/impls/node/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Log, LogImpl, assert, bind, fromArgs, impl, isArray, unshift, utils,
    __slice = [].slice;

  utils = require('utils');

  assert = require('neft-assert');

  bind = Function.bind;

  isArray = Array.isArray;

  unshift = Array.prototype.unshift;

  fromArgs = function(args) {
    var arg, str, _i, _len;
    str = '';
    for (_i = 0, _len = args.length; _i < _len; _i++) {
      arg = args[_i];
      str += "" + arg + " → ";
    }
    return str.substring(0, str.length - 3);
  };

  Log = (function() {
    var i, _, _i, _len, _ref;

    Log.LOGS_METHODS = ['info', 'warn', 'error', 'time', 'ok'];

    Log.TIMES_LEN = 50;

    Log.MARKERS = {
      white: function(str) {
        return "LOG: " + str;
      },
      green: function(str) {
        return "OK: " + str;
      },
      gray: function(str) {
        return "" + str;
      },
      blue: function(str) {
        return "INFO: " + str;
      },
      yellow: function(str) {
        return "WARN: " + str;
      },
      red: function(str) {
        return "ERROR: " + str;
      },
      bold: function(str) {
        return "**" + str + "**";
      }
    };

    Log.time = Date.now;

    Log.timeDiff = function(since) {
      return Log.time() - since;
    };

    Log.times = new Array(Log.TIMES_LEN);

    _ref = Log.times;
    for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
      _ = _ref[i];
      Log.times[i] = [0, ''];
    }

    function Log(prefixes) {
      var args, func, key, name, value, _j, _len1, _ref1;
      this.prefixes = prefixes;
      if (prefixes) {
        assert.isArray(prefixes);
        args = utils.clone(prefixes);
        args.unshift(this);
        _ref1 = LogImpl.LOGS_METHODS;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          name = _ref1[_j];
          this[name] = bind.apply(this[name], args);
        }
      }
      for (key in this) {
        value = this[key];
        this[key] = value;
      }
      if (typeof this['lo' + 'g'] === 'function') {
        func = (function(_this) {
          return function() {
            return _this.log.apply(func, arguments);
          };
        })(this);
        return utils.merge(func, this);
      }
    }

    Log.prototype._write = (typeof console !== "undefined" && console !== null ? console['lo' + 'g'].bind(console) : void 0) || (function() {});

    i = 0;

    Log.prototype.LOG = 1 << i++;

    Log.prototype.INFO = 1 << i++;

    Log.prototype.OK = 1 << i++;

    Log.prototype.WARN = 1 << i++;

    Log.prototype.ERROR = 1 << i++;

    Log.prototype.TIME = 1 << i++;

    Log.prototype.ALL = (1 << i++) - 1;

    Log.prototype.enabled = Log.prototype.ALL;

    Log.prototype['log'] = function() {
      if (this.enabled & this.LOG) {
        this._write(LogImpl.MARKERS.white(fromArgs(arguments)));
      }
    };

    Log.prototype.info = function() {
      if (this.enabled & this.INFO) {
        this._write(LogImpl.MARKERS.blue(fromArgs(arguments)));
      }
    };

    Log.prototype.ok = function() {
      if (this.enabled & this.OK) {
        this._write(LogImpl.MARKERS.green(fromArgs(arguments)));
      }
    };

    Log.prototype.warn = function() {
      if (this.enabled & this.WARN) {
        this._write(LogImpl.MARKERS.yellow(fromArgs(arguments)));
      }
    };

    Log.prototype.error = function() {
      if (this.enabled & this.ERROR) {
        this._write(LogImpl.MARKERS.red(fromArgs(arguments)));
      }
    };

    Log.prototype.time = function() {
      var id, times, v, _j, _len1;
      if (!(this.enabled & this.TIME)) {
        return -1;
      }
      times = LogImpl.times;
      for (i = _j = 0, _len1 = times.length; _j < _len1; i = ++_j) {
        v = times[i];
        if (!(!v[0])) {
          continue;
        }
        id = i;
        times[i][0] = LogImpl.time();
        times[i][1] = fromArgs(arguments);
        break;
      }
      assert(id != null, "Log times out of range");
      return id;
    };

    Log.prototype.end = function(id) {
      var diff, str, time;
      if (id === -1) {
        return;
      }
      time = LogImpl.times[id];
      diff = LogImpl.timeDiff(time[0]);
      diff = diff.toFixed(2);
      str = "" + time[1] + ": " + diff + " ms";
      this._write(LogImpl.MARKERS.gray(str));
      time[0] = 0;
    };

    Log.prototype.scope = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (this.prefixes) {
        unshift.apply(args, this.prefixes);
      }
      return new LogImpl(args);
    };

    return Log;

  })();

  impl = (function() {
    switch (true) {
      case utils.isNode:
        return require('./impls/node/index.coffee');
      case utils.isBrowser:
        return require('./impls/browser/index.coffee');
    }
  })();

  LogImpl = typeof impl === 'function' ? impl(Log) : Log;

  module.exports = new LogImpl;

}).call(this);


return module.exports;
})();modules['../signal/emitter.coffee'] = (function(){
var module = {exports: modules["../signal/emitter.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('neft-assert');

  module.exports = function(signal) {
    var SignalsEmitter;
    return SignalsEmitter = (function() {
      var NOP, callSignal, handlerFunc;

      callSignal = signal.callSignal;

      NOP = function() {};

      handlerFunc = signal.createSignalFunction();

      SignalsEmitter.emitSignal = function(obj, name, arg1, arg2) {
        var listeners;
        assert.isString(name);
        assert.notLengthOf(name, 0);
        if (listeners = obj._signals[name]) {
          return callSignal(obj, listeners, arg1, arg2);
        }
      };

      SignalsEmitter.createSignalOnObject = function(obj, name, onInitialized) {
        var getter;
        assert.isObject(obj);
        assert.isString(name);
        assert.notLengthOf(name, 0);
        if (onInitialized != null) {
          assert.isFunction(onInitialized);
        }
        getter = function() {
          var listeners, signals;
          assert.instanceOf(this, SignalsEmitter);
          signals = this._signals;
          if (!(listeners = signals[name])) {
            listeners = signals[name] = [null, null, null, null];
            if (typeof onInitialized === "function") {
              onInitialized(this, name);
            }
          }
          handlerFunc.obj = this;
          handlerFunc.listeners = listeners;
          return handlerFunc;
        };
        utils.defineProperty(obj, name, null, getter, null);
        return getter;
      };

      SignalsEmitter.createSignal = function(ctor, name, onInitialized) {
        assert.isFunction(ctor);
        return SignalsEmitter.createSignalOnObject(ctor.prototype, name, onInitialized);
      };

      function SignalsEmitter() {
        this._signals = {};
      }

      return SignalsEmitter;

    })();
  };

}).call(this);


return module.exports;
})();modules['../signal/index.coffee.md'] = (function(){
var module = {exports: modules["../signal/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","./emitter":"../signal/emitter.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var STOP_PROPAGATION, SignalPrototype, assert, callSignal, createSignalFunction, utils;

  utils = require('utils');

  assert = require('neft-assert');

  STOP_PROPAGATION = exports.STOP_PROPAGATION = 1 << 30;

  exports.create = function(obj, name) {
    var signal;
    signal = createSignalFunction(obj);
    if (name === void 0) {
      return signal;
    }
    assert.isNotPrimitive(obj);
    assert.isString(name);
    assert.notLengthOf(name, 0);
    assert(!obj.hasOwnProperty(name, ("Signal `" + name + "` can't be created, because passed object ") + "has such property"));
    return obj[name] = signal;
  };

  callSignal = function(obj, listeners, arg1, arg2) {
    var ctx, func, i, n, result, shift;
    i = shift = 0;
    n = listeners.length;
    result = 0;
    while (i < n) {
      func = listeners[i];
      if (func === null) {
        shift -= 2;
      } else {
        ctx = listeners[i + 1];
        if (shift !== 0) {
          listeners[i + shift] = func;
          listeners[i + shift + 1] = ctx;
          listeners[i] = null;
          listeners[i + 1] = null;
        }
        if (result === 0 && func.call(ctx || obj, arg1, arg2) === STOP_PROPAGATION) {
          result = STOP_PROPAGATION;
        }
      }
      i += 2;
    }
    return result;
  };

  createSignalFunction = function(obj) {
    var handler;
    handler = function(listener, ctx) {
      return handler.connect(listener, ctx);
    };
    handler.obj = obj;
    handler.listeners = [];
    utils.setPrototypeOf(handler, SignalPrototype);
    return handler;
  };

  SignalPrototype = {
    emit: function(arg1, arg2) {
      assert.isFunction(this);
      assert.isArray(this.listeners);
      assert.operator(arguments.length, '<', 3, 'Signal accepts maximally two parameters; use object instead');
      return callSignal(this.obj, this.listeners, arg1, arg2);
    },
    connect: function(listener, ctx) {
      var i, listeners, n;
      if (ctx == null) {
        ctx = null;
      }
      assert.isFunction(this);
      assert.isFunction(listener);
      listeners = this.listeners;
      i = n = listeners.length;
      while ((i -= 2) >= 0) {
        if (listeners[i] !== null) {
          break;
        }
      }
      if (i + 2 === n) {
        listeners.push(listener, ctx);
      } else {
        listeners[i + 2] = listener;
        listeners[i + 3] = ctx;
      }
    },
    disconnect: function(listener, ctx) {
      var index, listeners;
      if (ctx == null) {
        ctx = null;
      }
      assert.isFunction(this);
      assert.isFunction(listener);
      listeners = this.listeners;
      index = 0;
      while (true) {
        index = listeners.indexOf(listener, index);
        if (index === -1 || listeners[index + 1] === ctx) {
          break;
        }
        index += 2;
      }
      assert.isNot(index, -1);
      assert.is(listeners[index], listener);
      assert.is(listeners[index + 1], ctx);
      listeners[index] = null;
      listeners[index + 1] = null;
    },
    disconnectAll: function() {
      var i, listeners, _, _i, _len;
      assert.isFunction(this);
      listeners = this.listeners;
      for (i = _i = 0, _len = listeners.length; _i < _len; i = ++_i) {
        _ = listeners[i];
        listeners[i] = null;
      }
    }
  };

  exports.Emitter = require('./emitter')({
    create: exports.create,
    createSignalFunction: createSignalFunction,
    callSignal: callSignal
  });

}).call(this);


return module.exports;
})();modules['../list/index.coffee.md'] = (function(){
var module = {exports: modules["../list/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  module.exports = List = (function(_super) {
    var desc;

    __extends(List, _super);

    List.__name__ = 'List';

    List.__path__ = 'List';

    function List(arr) {
      if (arr == null) {
        arr = [];
      }
      assert.isArray(arr);
      if (!(this instanceof List)) {
        return new List(arr);
      }
      List.__super__.constructor.call(this);
      this._data = arr;
    }

    utils.defineProperty(List.prototype, '0', null, function() {
      throw "You can't get elements from a list as standard properties; " + "use `List::get()` method instead";
    }, function() {
      throw "You can't set elements into a list as standard properties; " + "use `List::set()` method instead";
    });

    signal.Emitter.createSignal(List, 'onChange');

    signal.Emitter.createSignal(List, 'onInsert');

    signal.Emitter.createSignal(List, 'onPop');

    desc = utils.CONFIGURABLE;

    utils.defineProperty(List.prototype, 'length', desc, function() {
      return this._data.length;
    }, null);

    List.prototype.get = function(i) {
      assert.operator(i, '>=', 0);
      return this._data[i];
    };

    List.prototype.set = function(i, val) {
      var oldVal;
      assert.operator(i, '>=', 0);
      assert.operator(i, '<', this.length);
      assert.isNot(val, void 0);
      oldVal = this._data[i];
      if (oldVal === val) {
        return val;
      }
      this._data[i] = val;
      this.onChange.emit(oldVal, i);
      return val;
    };

    List.prototype.items = function() {
      return this._data;
    };

    List.prototype.append = function(val) {
      assert.isNot(val, void 0);
      this._data.push(val);
      this.onInsert.emit(val, this.length - 1);
      return val;
    };

    List.prototype.insert = function(i, val) {
      assert.operator(i, '>=', 0);
      assert.operator(i, '<=', this.length);
      assert.isNot(val, void 0);
      this._data.splice(i, 0, val);
      this.onInsert.emit(val, i);
      return val;
    };

    List.prototype.extend = function(items) {
      var arr, val, _i, _len;
      if (items instanceof List) {
        arr = items.items();
      } else {
        arr = items;
      }
      assert.isArray(arr);
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        val = arr[_i];
        this.append(val);
      }
      return items;
    };

    List.prototype.remove = function(val) {
      var i;
      assert.ok(utils.has(this._data, val));
      i = this.index(val);
      if (i !== -1) {
        this.pop(i);
      }
      return val;
    };

    List.prototype.pop = function(i) {
      var oldVal;
      if (i === void 0) {
        i = this.length - 1;
      }
      assert.operator(i, '>=', 0);
      assert.operator(i, '<', this.length);
      oldVal = this._data[i];
      this._data.splice(i, 1);
      this.onPop.emit(oldVal, i);
      return oldVal;
    };

    List.prototype.clear = function() {
      while (this._data.length) {
        this.pop();
      }
      return null;
    };

    List.prototype.index = function(val) {
      assert.isNot(val, void 0);
      return this._data.indexOf(val);
    };

    List.prototype.has = function(val) {
      return this.index(val) !== -1;
    };

    List.prototype.toJSON = function() {
      return this._data;
    };

    List.prototype.toString = function() {
      return this._data + '';
    };

    return List;

  })(signal.Emitter);

}).call(this);


return module.exports;
})();modules['../dict/index.coffee.md'] = (function(){
var module = {exports: modules["../dict/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  module.exports = Dict = (function(_super) {
    var ALL, ITEMS, KEYS, VALUES, desc;

    __extends(Dict, _super);

    Dict.__name__ = 'Dict';

    Dict.__path__ = 'Dict';

    KEYS = 1 << 0;

    VALUES = 1 << 1;

    ITEMS = 1 << 2;

    ALL = (ITEMS << 1) - 1;

    Dict.fromJSON = function(json) {
      json = utils.tryFunction(JSON.parse, JSON, [json], json);
      assert.isPlainObject(json);
      return new Dict(json);
    };

    function Dict(obj) {
      if (obj == null) {
        obj = {};
      }
      if (!(this instanceof Dict)) {
        return new Dict(obj);
      }
      assert.isObject(obj);
      Dict.__super__.constructor.call(this);
      this._data = obj;
      this._keys = null;
      this._values = null;
      this._items = null;
      this._dirty = ALL;
    }

    desc = utils.CONFIGURABLE | utils.ENUMERABLE;

    utils.defineProperty(Dict.prototype, 'length', desc, function() {
      return this.keys().length;
    }, null);

    signal.Emitter.createSignal(Dict, 'onChange');

    Dict.prototype.get = function(key) {
      assert.isString(key);
      assert.notLengthOf(key, 0);
      return this._data[key];
    };

    Dict.prototype.set = function(key, val) {
      var oldVal;
      assert.isString(key);
      assert.notLengthOf(key, 0);
      assert.isNot(val, void 0);
      oldVal = this._data[key];
      if (oldVal === val) {
        return this;
      }
      this._data[key] = val;
      this._dirty |= ALL;
      this.onChange.emit(key, oldVal);
      return val;
    };

    Dict.prototype.has = function(key) {
      assert.isString(key);
      assert.notLengthOf(key, 0);
      return this._data[key] !== void 0;
    };

    Dict.prototype.extend = function(items) {
      var key, obj, val;
      if (items instanceof Dict) {
        obj = items._data;
      } else {
        obj = items;
      }
      assert.isObject(obj);
      for (key in obj) {
        val = obj[key];
        this.set(key, val);
      }
      return items;
    };

    Dict.prototype.pop = function(key) {
      var oldVal;
      assert.isString(key);
      assert.notLengthOf(key, 0);
      assert.isNot(this._data[key], void 0);
      oldVal = this._data[key];
      this._data[key] = void 0;
      this._dirty |= ALL;
      this.onChange.emit(key, oldVal);
    };

    Dict.prototype.clear = function() {
      var key, val, _ref;
      _ref = this._data;
      for (key in _ref) {
        val = _ref[key];
        if (val !== void 0) {
          this.pop(key);
        }
      }
    };

    Dict.prototype.keys = function() {
      var arr, i, key, val, _ref;
      if (this._dirty & KEYS) {
        this._dirty ^= KEYS;
        arr = this._keys != null ? this._keys : this._keys = [];
        i = 0;
        _ref = this._data;
        for (key in _ref) {
          val = _ref[key];
          if (val !== void 0) {
            arr[i] = key;
            i++;
          }
        }
        arr.length = i;
      }
      return this._keys;
    };

    Dict.prototype.values = function() {
      var arr, i, key, val, _ref;
      if (this._dirty & VALUES) {
        this._dirty ^= VALUES;
        arr = this._values != null ? this._values : this._values = [];
        i = 0;
        _ref = this._data;
        for (key in _ref) {
          val = _ref[key];
          if (val !== void 0) {
            arr[i] = val;
            i++;
          }
        }
        arr.length = i;
      }
      return this._values;
    };

    Dict.prototype.items = function() {
      var arr, i, key, val, _ref;
      if (this._dirty & ITEMS) {
        arr = this._values != null ? this._values : this._values = [];
        i = 0;
        _ref = this._data;
        for (key in _ref) {
          val = _ref[key];
          if (val !== void 0) {
            if (arr[i] == null) {
              arr[i] = ['', null];
            }
            arr[i][0] = key;
            arr[i][1] = val;
            i++;
          }
        }
        arr.length = i;
      }
      return this._values;
    };

    Dict.prototype.toJSON = function() {
      return this._data;
    };

    Dict.prototype.toString = function() {
      return this._data + '';
    };

    return Dict;

  })(signal.Emitter);

}).call(this);


return module.exports;
})();modules['../db/implementations/memory.coffee'] = (function(){
var module = {exports: modules["../db/implementations/memory.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var data, utils;

  utils = require('utils');

  data = Object.create(null);

  exports.get = function(key, callback) {
    var val;
    val = data[key];
    val = utils.cloneDeep(val);
    return callback(null, val);
  };

  exports.set = function(key, val, callback) {
    data[key] = val;
    return callback(null);
  };

  exports.remove = function(key, callback) {
    data[key] = void 0;
    return callback(null);
  };

}).call(this);


return module.exports;
})();modules['../db/implementation.coffee'] = (function(){
var module = {exports: modules["../db/implementation.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./implementations/memory":"../db/implementations/memory.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var browserLocalStorage, memory, utils;

  utils = require('utils');

  if (utils.isBrowser) {
    browserLocalStorage = require('./implementations/browser/localStorage');
  }

  memory = require('./implementations/memory');

  if ((typeof window !== "undefined" && window !== null) && (window.localStorage != null)) {
    module.exports = browserLocalStorage;
  } else {
    module.exports = memory;
  }

}).call(this);


return module.exports;
})();modules['../db/index.coffee.md'] = (function(){
var module = {exports: modules["../db/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","list":"../list/index.coffee.md","dict":"../dict/index.coffee.md","./implementation":"../db/implementation.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var BITMASK, DbDict, DbList, Dict, List, NOP, assert, createPassProperty, impl, utils, watchers, watchersCount,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  List = require('list');

  Dict = require('dict');

  assert = assert.scope('Database');

  NOP = function() {};

  impl = require('./implementation');

  watchersCount = Object.create(null);

  watchers = Object.create(null);

  exports.OBSERVABLE = 1 << 29;

  BITMASK = exports.OBSERVABLE;

  exports.get = function(key, opts, callback) {
    if (typeof opts === 'function') {
      callback = opts;
      opts = 0;
    }
    assert.isString(key);
    assert.notLengthOf(key, 0);
    assert.isInteger(opts);
    assert.is(opts | BITMASK, BITMASK, 'Invalid options bitmask');
    assert.isFunction(callback);
    if (opts & exports.OBSERVABLE && (watchers[key] != null)) {
      return callback(null, watchers[key].spawn());
    }
    impl.get(key, function(err, data) {
      var _ref;
      if ((err != null) || !data) {
        return callback(err, data);
      }
      if (opts & exports.OBSERVABLE) {
        if (Array.isArray(data)) {
          data = new DbList(key, data, opts);
        } else if (utils.isObject(data)) {
          data = new DbDict(key, data, opts);
        }
        data = ((_ref = watchers[key]) != null ? _ref.spawn() : void 0) || data;
      }
      return callback(null, data);
    });
  };

  exports.set = function(key, val, callback) {
    var _ref;
    if (callback == null) {
      callback = NOP;
    }
    assert.isString(key);
    assert.notLengthOf(key, 0);
    assert.isFunction(callback);
    if ((_ref = watchers[key]) != null) {
      _ref.disconnect();
    }
    impl.set(key, val, callback);
  };

  exports.remove = function(key, val, callback) {
    var _ref;
    if (callback == null) {
      callback = NOP;
    }
    if (typeof val === 'function') {
      callback = val;
      val = null;
    }
    assert.isString(key);
    assert.notLengthOf(key, 0);
    assert.isFunction(callback);
    if (val != null) {
      exports.get(key, function(err, data) {
        var i, index, item, list, _i, _j, _len, _len1, _ref;
        if (err != null) {
          return callback(err);
        }
        if (!Array.isArray(data)) {
          return callback(new Error("'" + key + "' is not an array"));
        }
        if (list = watchers[key]) {
          if ((index = list.items().indexOf(val)) !== -1) {
            list.pop(index);
          } else {
            _ref = list.items();
            for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
              item = _ref[i];
              if (utils.isEqual(item, val)) {
                list.pop(i);
                break;
              }
            }
          }
        }
        if ((index = data.indexOf(val)) !== -1) {
          data.splice(index, 1);
        } else {
          for (i = _j = 0, _len1 = data.length; _j < _len1; i = ++_j) {
            item = data[i];
            if (utils.isEqual(item, val)) {
              data.splice(i, 1);
              break;
            }
          }
        }
        return impl.set(key, data, callback);
      });
    } else {
      if ((_ref = watchers[key]) != null) {
        _ref.disconnect();
      }
      impl.remove(key, callback);
    }
  };

  exports.append = function(key, val, callback) {
    if (callback == null) {
      callback = NOP;
    }
    assert.isString(key);
    assert.notLengthOf(key, 0);
    assert.isFunction(callback);
    exports.get(key, function(err, data) {
      var _ref;
      if (err != null) {
        return callback(err);
      }
      if (data == null) {
        data = [];
      }
      if (!Array.isArray(data)) {
        return callback(new Error("'" + key + "' is not an array"));
      }
      if ((_ref = watchers[key]) != null) {
        _ref.append(val);
      }
      data.push(val);
      return impl.set(key, data, callback);
    });
  };

  createPassProperty = function(object, name) {
    return utils.defineProperty(object, name, null, function() {
      return Object.getPrototypeOf(this)[name];
    }, function(val) {
      return Object.getPrototypeOf(this)[name] = val;
    });
  };

  DbList = (function(_super) {
    var onChange;

    __extends(DbList, _super);

    onChange = function(key) {
      if (this._isConnected) {
        impl.set(this._key, this._data, NOP);
      }
    };

    function DbList(key, data, opts) {
      this._key = key;
      DbList.__super__.constructor.call(this, data);
      watchers[key] = this;
      this.onChange(onChange);
      this.onInsert(onChange);
      this.onPop(onChange);
    }

    DbList.prototype.spawn = function() {
      var watcher;
      watchersCount[this._key] = watchersCount[this._key] + 1 || 1;
      watcher = Object.create(watchers[this._key]);
      watcher._isConnected = true;
      Object.preventExtensions(watcher);
      return watcher;
    };

    DbList.prototype.disconnect = function() {
      if (this._isConnected) {
        this._isConnected = false;
        if (!--watchersCount[this._key]) {
          watchers[this._key] = null;
        }
      }
    };

    return DbList;

  })(List);

  DbDict = (function(_super) {
    var onChange;

    __extends(DbDict, _super);

    onChange = function(key) {
      if (this._isConnected) {
        impl.set(this._key, this._data, NOP);
      }
    };

    function DbDict(key, data, opts) {
      this._key = key;
      DbDict.__super__.constructor.call(this, data);
      watchers[key] = this;
      this.onChange(onChange);
    }

    DbDict.prototype.spawn = function() {
      var watcher;
      watchersCount[this._key] = watchersCount[this._key] + 1 || 1;
      watcher = Object.create(watchers[this._key]);
      watcher._isConnected = true;
      createPassProperty(watcher, '_keys');
      createPassProperty(watcher, '_values');
      createPassProperty(watcher, '_items');
      createPassProperty(watcher, '_dirty');
      Object.preventExtensions(watcher);
      return watcher;
    };

    DbDict.prototype.disconnect = function() {
      if (this._isConnected) {
        this._isConnected = false;
        if (!--watchersCount[this._key]) {
          watchers[this._key] = null;
        }
      }
    };

    return DbDict;

  })(Dict);

}).call(this);


return module.exports;
})();modules['../schema/validators/array.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/array.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var isArray;

  isArray = Array.isArray;

  module.exports = function(Schema) {
    return function(row, value, expected) {
      if (expected && !isArray(value)) {
        throw new Schema.Error(row, 'array', "" + row + " must be an array");
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/object.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/object.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, isArray, utils;

  assert = require('neft-assert');

  utils = require('utils');

  isArray = Array.isArray;

  module.exports = function(Schema) {
    return function(row, value, expected) {
      var prop, props;
      if (!expected) {
        return;
      }
      if (!utils.isObject(value)) {
        throw new Schema.Error(row, 'object', "" + row + " must be an object");
      }
      if (props = expected != null ? expected.properties : void 0) {
        assert.isArray(props);
        for (prop in value) {
          if (!~props.indexOf(prop)) {
            throw new Schema.Error(row, 'object.properties', "" + row + " doesn't provide " + prop + " property");
          }
        }
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/optional.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/optional.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  module.exports = function(Schema) {
    return function() {};
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/max.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/max.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('neft-assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert.isFloat(expected, "max validator option for " + row + " property must be float");
      if (!value || value.length > expected) {
        throw new Schema.Error(row, 'max', "Maximum range of " + row + " is " + expected);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/min.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/min.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('neft-assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert.isFloat(expected, "min validator option for " + row + " property must be float");
      if (!value || value.length < expected) {
        throw new Schema.Error(row, 'min', "Minimum range of " + row + " is " + expected);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/options.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/options.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  assert = require('neft-assert');

  utils = require('utils');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      var passed;
      assert.isObject(expected, "options validator option for " + row + " property must be an object or array");
      if (Array.isArray(expected)) {
        passed = utils.has(expected, value);
      } else {
        passed = expected.hasOwnProperty(value);
      }
      if (!passed) {
        throw new Schema.Error(row, 'options', "Passed " + row + " value is not acceptable");
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/regexp.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/regexp.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('neft-assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert(expected instanceof RegExp, "regexp validator option for " + row + " property must be a regular expression");
      if (!expected.test(value)) {
        throw new Schema.Error(row, 'regexp', "" + row + " doesn't pass regular expression");
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/type.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/type.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('neft-assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert.isString(expected, "type validator option for " + row + " property must be a string");
      if (isNaN(value) || value === null) {
        value = void 0;
      }
      if ((value != null) && typeof value !== expected) {
        throw new Schema.Error(row, 'type', "" + row + " must be a " + expected);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/index.coffee.md'] = (function(){
var module = {exports: modules["../schema/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","./validators/array":"../schema/validators/array.coffee.md","./validators/object":"../schema/validators/object.coffee.md","./validators/optional":"../schema/validators/optional.coffee.md","./validators/max":"../schema/validators/max.coffee.md","./validators/min":"../schema/validators/min.coffee.md","./validators/options":"../schema/validators/options.coffee.md","./validators/regexp":"../schema/validators/regexp.coffee.md","./validators/type":"../schema/validators/type.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Schema, SchemaError, assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  SchemaError = (function(_super) {
    __extends(SchemaError, _super);

    function SchemaError(property, validator, message) {
      this.property = property;
      this.validator = validator;
      this.message = message;
      SchemaError.__super__.constructor.apply(this, arguments);
    }

    SchemaError.prototype.name = 'SchemaError';

    SchemaError.prototype.message = '';

    return SchemaError;

  })(Error);

  module.exports = Schema = (function() {
    var validators;

    Schema.Error = SchemaError;

    function Schema(schema) {
      var elem, row;
      this.schema = schema;
      assert.isPlainObject(schema);
      assert.notOk(utils.isEmpty(schema), "Schema: schema can't be empty");
      for (row in schema) {
        elem = schema[row];
        assert(utils.isPlainObject(elem), "Schema: schema for " + row + " row is not an object");
      }
      Object.preventExtensions(this);
    }

    Schema.prototype.schema = null;

    validators = {
      array: require('./validators/array')(Schema),
      object: require('./validators/object')(Schema),
      optional: require('./validators/optional')(Schema),
      max: require('./validators/max')(Schema),
      min: require('./validators/min')(Schema),
      options: require('./validators/options')(Schema),
      regexp: require('./validators/regexp')(Schema),
      type: require('./validators/type')(Schema)
    };

    Schema.prototype.validate = function(data) {
      var i, row, rowValidators, validator, validatorName, validatorOpts, value, values, _i, _len, _ref;
      assert.isNotPrimitive(data);
      for (row in data) {
        if (!this.schema.hasOwnProperty(row)) {
          throw new SchemaError(row, null, "Unexpected " + row + " property");
        }
      }
      _ref = this.schema;
      for (row in _ref) {
        rowValidators = _ref[row];
        values = utils.get(data, row);
        if ((values == null) && !rowValidators.optional) {
          throw new SchemaError(row, 'optional', "Required property " + row + " not found");
        }
        for (validatorName in rowValidators) {
          validatorOpts = rowValidators[validatorName];
          validator = validators[validatorName];
          assert(validator, "Schema validator " + validatorName + " not found");
          if (values instanceof utils.get.OptionsArray) {
            for (i = _i = 0, _len = values.length; _i < _len; i = ++_i) {
              value = values[i];
              validator(row, value, validatorOpts);
            }
          } else {
            validator(row, values, validatorOpts);
          }
        }
      }
      return true;
    };

    return Schema;

  })();

}).call(this);


return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/combined-stream/node_modules/delayed-stream/lib/delayed_stream.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/combined-stream/node_modules/delayed-stream/lib/delayed_stream.js"]};
var require = getModule.bind(null, {});
var exports = module.exports;

var Stream = require('stream').Stream;
var util = require('util');

module.exports = DelayedStream;
function DelayedStream() {
  this.source = null;
  this.dataSize = 0;
  this.maxDataSize = 1024 * 1024;
  this.pauseStream = true;

  this._maxDataSizeExceeded = false;
  this._released = false;
  this._bufferedEvents = [];
}
util.inherits(DelayedStream, Stream);

DelayedStream.create = function(source, options) {
  var delayedStream = new this();

  options = options || {};
  for (var option in options) {
    delayedStream[option] = options[option];
  }

  delayedStream.source = source;

  var realEmit = source.emit;
  source.emit = function() {
    delayedStream._handleEmit(arguments);
    return realEmit.apply(source, arguments);
  };

  source.on('error', function() {});
  if (delayedStream.pauseStream) {
    source.pause();
  }

  return delayedStream;
};

Object.defineProperty(DelayedStream.prototype, 'readable', {
  configurable: true,
  enumerable: true,
  get: function() {
    return this.source.readable;
  }
});

DelayedStream.prototype.setEncoding = function() {
  return this.source.setEncoding.apply(this.source, arguments);
};

DelayedStream.prototype.resume = function() {
  if (!this._released) {
    this.release();
  }

  this.source.resume();
};

DelayedStream.prototype.pause = function() {
  this.source.pause();
};

DelayedStream.prototype.release = function() {
  this._released = true;

  this._bufferedEvents.forEach(function(args) {
    this.emit.apply(this, args);
  }.bind(this));
  this._bufferedEvents = [];
};

DelayedStream.prototype.pipe = function() {
  var r = Stream.prototype.pipe.apply(this, arguments);
  this.resume();
  return r;
};

DelayedStream.prototype._handleEmit = function(args) {
  if (this._released) {
    this.emit.apply(this, args);
    return;
  }

  if (args[0] === 'data') {
    this.dataSize += args[1].length;
    this._checkIfMaxDataSizeExceeded();
  }

  this._bufferedEvents.push(args);
};

DelayedStream.prototype._checkIfMaxDataSizeExceeded = function() {
  if (this._maxDataSizeExceeded) {
    return;
  }

  if (this.dataSize <= this.maxDataSize) {
    return;
  }

  this._maxDataSizeExceeded = true;
  var message =
    'DelayedStream#maxDataSize of ' + this.maxDataSize + ' bytes exceeded.'
  this.emit('error', new Error(message));
};


return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/combined-stream/lib/combined_stream.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/combined-stream/lib/combined_stream.js"]};
var require = getModule.bind(null, {"delayed-stream":"../networking/node_modules/form-data/node_modules/combined-stream/node_modules/delayed-stream/lib/delayed_stream.js"});
var exports = module.exports;

var util = require('util');
var Stream = require('stream').Stream;
var DelayedStream = require('delayed-stream');

module.exports = CombinedStream;
function CombinedStream() {
  this.writable = false;
  this.readable = true;
  this.dataSize = 0;
  this.maxDataSize = 2 * 1024 * 1024;
  this.pauseStreams = true;

  this._released = false;
  this._streams = [];
  this._currentStream = null;
}
util.inherits(CombinedStream, Stream);

CombinedStream.create = function(options) {
  var combinedStream = new this();

  options = options || {};
  for (var option in options) {
    combinedStream[option] = options[option];
  }

  return combinedStream;
};

CombinedStream.isStreamLike = function(stream) {
  return (typeof stream !== 'function')
    && (typeof stream !== 'string')
    && (typeof stream !== 'boolean')
    && (typeof stream !== 'number')
    && (!Buffer.isBuffer(stream));
};

CombinedStream.prototype.append = function(stream) {
  var isStreamLike = CombinedStream.isStreamLike(stream);

  if (isStreamLike) {
    if (!(stream instanceof DelayedStream)) {
      var newStream = DelayedStream.create(stream, {
        maxDataSize: Infinity,
        pauseStream: this.pauseStreams,
      });
      stream.on('data', this._checkDataSize.bind(this));
      stream = newStream;
    }

    this._handleErrors(stream);

    if (this.pauseStreams) {
      stream.pause();
    }
  }

  this._streams.push(stream);
  return this;
};

CombinedStream.prototype.pipe = function(dest, options) {
  Stream.prototype.pipe.call(this, dest, options);
  this.resume();
  return dest;
};

CombinedStream.prototype._getNext = function() {
  this._currentStream = null;
  var stream = this._streams.shift();


  if (typeof stream == 'undefined') {
    this.end();
    return;
  }

  if (typeof stream !== 'function') {
    this._pipeNext(stream);
    return;
  }

  var getStream = stream;
  getStream(function(stream) {
    var isStreamLike = CombinedStream.isStreamLike(stream);
    if (isStreamLike) {
      stream.on('data', this._checkDataSize.bind(this));
      this._handleErrors(stream);
    }

    this._pipeNext(stream);
  }.bind(this));
};

CombinedStream.prototype._pipeNext = function(stream) {
  this._currentStream = stream;

  var isStreamLike = CombinedStream.isStreamLike(stream);
  if (isStreamLike) {
    stream.on('end', this._getNext.bind(this));
    stream.pipe(this, {end: false});
    return;
  }

  var value = stream;
  this.write(value);
  this._getNext();
};

CombinedStream.prototype._handleErrors = function(stream) {
  var self = this;
  stream.on('error', function(err) {
    self._emitError(err);
  });
};

CombinedStream.prototype.write = function(data) {
  this.emit('data', data);
};

CombinedStream.prototype.pause = function() {
  if (!this.pauseStreams) {
    return;
  }

  if(this.pauseStreams && this._currentStream && typeof(this._currentStream.pause) == 'function') this._currentStream.pause();
  this.emit('pause');
};

CombinedStream.prototype.resume = function() {
  if (!this._released) {
    this._released = true;
    this.writable = true;
    this._getNext();
  }

  if(this.pauseStreams && this._currentStream && typeof(this._currentStream.resume) == 'function') this._currentStream.resume();
  this.emit('resume');
};

CombinedStream.prototype.end = function() {
  this._reset();
  this.emit('end');
};

CombinedStream.prototype.destroy = function() {
  this._reset();
  this.emit('close');
};

CombinedStream.prototype._reset = function() {
  this.writable = false;
  this._streams = [];
  this._currentStream = null;
};

CombinedStream.prototype._checkDataSize = function() {
  this._updateDataSize();
  if (this.dataSize <= this.maxDataSize) {
    return;
  }

  var message =
    'DelayedStream#maxDataSize of ' + this.maxDataSize + ' bytes exceeded.';
  this._emitError(new Error(message));
};

CombinedStream.prototype._updateDataSize = function() {
  this.dataSize = 0;

  var self = this;
  this._streams.forEach(function(stream) {
    if (!stream.dataSize) {
      return;
    }

    self.dataSize += stream.dataSize;
  });

  if (this._currentStream && this._currentStream.dataSize) {
    this.dataSize += this._currentStream.dataSize;
  }
};

CombinedStream.prototype._emitError = function(err) {
  this._reset();
  this.emit('error', err);
};


return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/db.json'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/db.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {
  "application/1d-interleaved-parityfec": {
    "source": "iana"
  },
  "application/3gpdash-qoe-report+xml": {
    "source": "iana"
  },
  "application/3gpp-ims+xml": {
    "source": "iana"
  },
  "application/a2l": {
    "source": "iana"
  },
  "application/activemessage": {
    "source": "iana"
  },
  "application/alto-costmap+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-costmapfilter+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-directory+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-endpointcost+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-endpointcostparams+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-endpointprop+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-endpointpropparams+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-error+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-networkmap+json": {
    "source": "iana",
    "compressible": true
  },
  "application/alto-networkmapfilter+json": {
    "source": "iana",
    "compressible": true
  },
  "application/aml": {
    "source": "iana"
  },
  "application/andrew-inset": {
    "source": "iana",
    "extensions": ["ez"]
  },
  "application/applefile": {
    "source": "iana"
  },
  "application/applixware": {
    "source": "apache",
    "extensions": ["aw"]
  },
  "application/atf": {
    "source": "iana"
  },
  "application/atfx": {
    "source": "iana"
  },
  "application/atom+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["atom"]
  },
  "application/atomcat+xml": {
    "source": "iana",
    "extensions": ["atomcat"]
  },
  "application/atomdeleted+xml": {
    "source": "iana"
  },
  "application/atomicmail": {
    "source": "iana"
  },
  "application/atomsvc+xml": {
    "source": "iana",
    "extensions": ["atomsvc"]
  },
  "application/atxml": {
    "source": "iana"
  },
  "application/auth-policy+xml": {
    "source": "iana"
  },
  "application/bacnet-xdd+zip": {
    "source": "iana"
  },
  "application/batch-smtp": {
    "source": "iana"
  },
  "application/bdoc": {
    "compressible": false,
    "extensions": ["bdoc"]
  },
  "application/beep+xml": {
    "source": "iana"
  },
  "application/calendar+json": {
    "source": "iana",
    "compressible": true
  },
  "application/calendar+xml": {
    "source": "iana"
  },
  "application/call-completion": {
    "source": "iana"
  },
  "application/cals-1840": {
    "source": "iana"
  },
  "application/cbor": {
    "source": "iana"
  },
  "application/ccmp+xml": {
    "source": "iana"
  },
  "application/ccxml+xml": {
    "source": "iana",
    "extensions": ["ccxml"]
  },
  "application/cdfx+xml": {
    "source": "iana"
  },
  "application/cdmi-capability": {
    "source": "iana",
    "extensions": ["cdmia"]
  },
  "application/cdmi-container": {
    "source": "iana",
    "extensions": ["cdmic"]
  },
  "application/cdmi-domain": {
    "source": "iana",
    "extensions": ["cdmid"]
  },
  "application/cdmi-object": {
    "source": "iana",
    "extensions": ["cdmio"]
  },
  "application/cdmi-queue": {
    "source": "iana",
    "extensions": ["cdmiq"]
  },
  "application/cea": {
    "source": "iana"
  },
  "application/cea-2018+xml": {
    "source": "iana"
  },
  "application/cellml+xml": {
    "source": "iana"
  },
  "application/cfw": {
    "source": "iana"
  },
  "application/cms": {
    "source": "iana"
  },
  "application/cnrp+xml": {
    "source": "iana"
  },
  "application/coap-group+json": {
    "source": "iana",
    "compressible": true
  },
  "application/commonground": {
    "source": "iana"
  },
  "application/conference-info+xml": {
    "source": "iana"
  },
  "application/cpl+xml": {
    "source": "iana"
  },
  "application/csrattrs": {
    "source": "iana"
  },
  "application/csta+xml": {
    "source": "iana"
  },
  "application/cstadata+xml": {
    "source": "iana"
  },
  "application/cu-seeme": {
    "source": "apache",
    "extensions": ["cu"]
  },
  "application/cybercash": {
    "source": "iana"
  },
  "application/dart": {
    "compressible": true
  },
  "application/dash+xml": {
    "source": "iana",
    "extensions": ["mdp"]
  },
  "application/dashdelta": {
    "source": "iana"
  },
  "application/davmount+xml": {
    "source": "iana",
    "extensions": ["davmount"]
  },
  "application/dca-rft": {
    "source": "iana"
  },
  "application/dcd": {
    "source": "iana"
  },
  "application/dec-dx": {
    "source": "iana"
  },
  "application/dialog-info+xml": {
    "source": "iana"
  },
  "application/dicom": {
    "source": "iana"
  },
  "application/dii": {
    "source": "iana"
  },
  "application/dit": {
    "source": "iana"
  },
  "application/dns": {
    "source": "iana"
  },
  "application/docbook+xml": {
    "source": "apache",
    "extensions": ["dbk"]
  },
  "application/dskpp+xml": {
    "source": "iana"
  },
  "application/dssc+der": {
    "source": "iana",
    "extensions": ["dssc"]
  },
  "application/dssc+xml": {
    "source": "iana",
    "extensions": ["xdssc"]
  },
  "application/dvcs": {
    "source": "iana"
  },
  "application/ecmascript": {
    "source": "iana",
    "compressible": true,
    "extensions": ["ecma"]
  },
  "application/edi-consent": {
    "source": "iana"
  },
  "application/edi-x12": {
    "source": "iana",
    "compressible": false
  },
  "application/edifact": {
    "source": "iana",
    "compressible": false
  },
  "application/emma+xml": {
    "source": "iana",
    "extensions": ["emma"]
  },
  "application/emotionml+xml": {
    "source": "iana"
  },
  "application/encaprtp": {
    "source": "iana"
  },
  "application/epp+xml": {
    "source": "iana"
  },
  "application/epub+zip": {
    "source": "iana",
    "extensions": ["epub"]
  },
  "application/eshop": {
    "source": "iana"
  },
  "application/exi": {
    "source": "iana",
    "extensions": ["exi"]
  },
  "application/fastinfoset": {
    "source": "iana"
  },
  "application/fastsoap": {
    "source": "iana"
  },
  "application/fdt+xml": {
    "source": "iana"
  },
  "application/fits": {
    "source": "iana"
  },
  "application/font-sfnt": {
    "source": "iana"
  },
  "application/font-tdpfr": {
    "source": "iana",
    "extensions": ["pfr"]
  },
  "application/font-woff": {
    "source": "iana",
    "compressible": false,
    "extensions": ["woff"]
  },
  "application/font-woff2": {
    "compressible": false,
    "extensions": ["woff2"]
  },
  "application/framework-attributes+xml": {
    "source": "iana"
  },
  "application/gml+xml": {
    "source": "apache",
    "extensions": ["gml"]
  },
  "application/gpx+xml": {
    "source": "apache",
    "extensions": ["gpx"]
  },
  "application/gxf": {
    "source": "apache",
    "extensions": ["gxf"]
  },
  "application/gzip": {
    "source": "iana",
    "compressible": false
  },
  "application/h224": {
    "source": "iana"
  },
  "application/held+xml": {
    "source": "iana"
  },
  "application/http": {
    "source": "iana"
  },
  "application/hyperstudio": {
    "source": "iana",
    "extensions": ["stk"]
  },
  "application/ibe-key-request+xml": {
    "source": "iana"
  },
  "application/ibe-pkg-reply+xml": {
    "source": "iana"
  },
  "application/ibe-pp-data": {
    "source": "iana"
  },
  "application/iges": {
    "source": "iana"
  },
  "application/im-iscomposing+xml": {
    "source": "iana"
  },
  "application/index": {
    "source": "iana"
  },
  "application/index.cmd": {
    "source": "iana"
  },
  "application/index.obj": {
    "source": "iana"
  },
  "application/index.response": {
    "source": "iana"
  },
  "application/index.vnd": {
    "source": "iana"
  },
  "application/inkml+xml": {
    "source": "iana",
    "extensions": ["ink","inkml"]
  },
  "application/iotp": {
    "source": "iana"
  },
  "application/ipfix": {
    "source": "iana",
    "extensions": ["ipfix"]
  },
  "application/ipp": {
    "source": "iana"
  },
  "application/isup": {
    "source": "iana"
  },
  "application/its+xml": {
    "source": "iana"
  },
  "application/java-archive": {
    "source": "apache",
    "compressible": false,
    "extensions": ["jar","war","ear"]
  },
  "application/java-serialized-object": {
    "source": "apache",
    "compressible": false,
    "extensions": ["ser"]
  },
  "application/java-vm": {
    "source": "apache",
    "compressible": false,
    "extensions": ["class"]
  },
  "application/javascript": {
    "source": "iana",
    "charset": "UTF-8",
    "compressible": true,
    "extensions": ["js"]
  },
  "application/jose": {
    "source": "iana"
  },
  "application/jose+json": {
    "source": "iana",
    "compressible": true
  },
  "application/jrd+json": {
    "source": "iana",
    "compressible": true
  },
  "application/json": {
    "source": "iana",
    "charset": "UTF-8",
    "compressible": true,
    "extensions": ["json","map"]
  },
  "application/json-patch+json": {
    "source": "iana",
    "compressible": true
  },
  "application/json-seq": {
    "source": "iana"
  },
  "application/json5": {
    "extensions": ["json5"]
  },
  "application/jsonml+json": {
    "source": "apache",
    "compressible": true,
    "extensions": ["jsonml"]
  },
  "application/jwk+json": {
    "source": "iana",
    "compressible": true
  },
  "application/jwk-set+json": {
    "source": "iana",
    "compressible": true
  },
  "application/jwt": {
    "source": "iana"
  },
  "application/kpml-request+xml": {
    "source": "iana"
  },
  "application/kpml-response+xml": {
    "source": "iana"
  },
  "application/ld+json": {
    "source": "iana",
    "compressible": true,
    "extensions": ["jsonld"]
  },
  "application/link-format": {
    "source": "iana"
  },
  "application/load-control+xml": {
    "source": "iana"
  },
  "application/lost+xml": {
    "source": "iana",
    "extensions": ["lostxml"]
  },
  "application/lostsync+xml": {
    "source": "iana"
  },
  "application/lxf": {
    "source": "iana"
  },
  "application/mac-binhex40": {
    "source": "iana",
    "extensions": ["hqx"]
  },
  "application/mac-compactpro": {
    "source": "apache",
    "extensions": ["cpt"]
  },
  "application/macwriteii": {
    "source": "iana"
  },
  "application/mads+xml": {
    "source": "iana",
    "extensions": ["mads"]
  },
  "application/manifest+json": {
    "charset": "UTF-8",
    "compressible": true,
    "extensions": ["webmanifest"]
  },
  "application/marc": {
    "source": "iana",
    "extensions": ["mrc"]
  },
  "application/marcxml+xml": {
    "source": "iana",
    "extensions": ["mrcx"]
  },
  "application/mathematica": {
    "source": "iana",
    "extensions": ["ma","nb","mb"]
  },
  "application/mathml+xml": {
    "source": "iana",
    "extensions": ["mathml"]
  },
  "application/mathml-content+xml": {
    "source": "iana"
  },
  "application/mathml-presentation+xml": {
    "source": "iana"
  },
  "application/mbms-associated-procedure-description+xml": {
    "source": "iana"
  },
  "application/mbms-deregister+xml": {
    "source": "iana"
  },
  "application/mbms-envelope+xml": {
    "source": "iana"
  },
  "application/mbms-msk+xml": {
    "source": "iana"
  },
  "application/mbms-msk-response+xml": {
    "source": "iana"
  },
  "application/mbms-protection-description+xml": {
    "source": "iana"
  },
  "application/mbms-reception-report+xml": {
    "source": "iana"
  },
  "application/mbms-register+xml": {
    "source": "iana"
  },
  "application/mbms-register-response+xml": {
    "source": "iana"
  },
  "application/mbms-schedule+xml": {
    "source": "iana"
  },
  "application/mbms-user-service-description+xml": {
    "source": "iana"
  },
  "application/mbox": {
    "source": "iana",
    "extensions": ["mbox"]
  },
  "application/media-policy-dataset+xml": {
    "source": "iana"
  },
  "application/media_control+xml": {
    "source": "iana"
  },
  "application/mediaservercontrol+xml": {
    "source": "iana",
    "extensions": ["mscml"]
  },
  "application/merge-patch+json": {
    "source": "iana",
    "compressible": true
  },
  "application/metalink+xml": {
    "source": "apache",
    "extensions": ["metalink"]
  },
  "application/metalink4+xml": {
    "source": "iana",
    "extensions": ["meta4"]
  },
  "application/mets+xml": {
    "source": "iana",
    "extensions": ["mets"]
  },
  "application/mf4": {
    "source": "iana"
  },
  "application/mikey": {
    "source": "iana"
  },
  "application/mods+xml": {
    "source": "iana",
    "extensions": ["mods"]
  },
  "application/moss-keys": {
    "source": "iana"
  },
  "application/moss-signature": {
    "source": "iana"
  },
  "application/mosskey-data": {
    "source": "iana"
  },
  "application/mosskey-request": {
    "source": "iana"
  },
  "application/mp21": {
    "source": "iana",
    "extensions": ["m21","mp21"]
  },
  "application/mp4": {
    "source": "iana",
    "extensions": ["mp4s","m4p"]
  },
  "application/mpeg4-generic": {
    "source": "iana"
  },
  "application/mpeg4-iod": {
    "source": "iana"
  },
  "application/mpeg4-iod-xmt": {
    "source": "iana"
  },
  "application/mrb-consumer+xml": {
    "source": "iana"
  },
  "application/mrb-publish+xml": {
    "source": "iana"
  },
  "application/msc-ivr+xml": {
    "source": "iana"
  },
  "application/msc-mixer+xml": {
    "source": "iana"
  },
  "application/msword": {
    "source": "iana",
    "compressible": false,
    "extensions": ["doc","dot"]
  },
  "application/mxf": {
    "source": "iana",
    "extensions": ["mxf"]
  },
  "application/nasdata": {
    "source": "iana"
  },
  "application/news-checkgroups": {
    "source": "iana"
  },
  "application/news-groupinfo": {
    "source": "iana"
  },
  "application/news-transmission": {
    "source": "iana"
  },
  "application/nlsml+xml": {
    "source": "iana"
  },
  "application/nss": {
    "source": "iana"
  },
  "application/ocsp-request": {
    "source": "iana"
  },
  "application/ocsp-response": {
    "source": "iana"
  },
  "application/octet-stream": {
    "source": "iana",
    "compressible": false,
    "extensions": ["bin","dms","lrf","mar","so","dist","distz","pkg","bpk","dump","elc","deploy","exe","dll","deb","dmg","iso","img","msi","msp","msm","buffer"]
  },
  "application/oda": {
    "source": "iana",
    "extensions": ["oda"]
  },
  "application/odx": {
    "source": "iana"
  },
  "application/oebps-package+xml": {
    "source": "iana",
    "extensions": ["opf"]
  },
  "application/ogg": {
    "source": "iana",
    "compressible": false,
    "extensions": ["ogx"]
  },
  "application/omdoc+xml": {
    "source": "apache",
    "extensions": ["omdoc"]
  },
  "application/onenote": {
    "source": "apache",
    "extensions": ["onetoc","onetoc2","onetmp","onepkg"]
  },
  "application/oxps": {
    "source": "iana",
    "extensions": ["oxps"]
  },
  "application/p2p-overlay+xml": {
    "source": "iana"
  },
  "application/parityfec": {
    "source": "iana"
  },
  "application/patch-ops-error+xml": {
    "source": "iana",
    "extensions": ["xer"]
  },
  "application/pdf": {
    "source": "iana",
    "compressible": false,
    "extensions": ["pdf"]
  },
  "application/pdx": {
    "source": "iana"
  },
  "application/pgp-encrypted": {
    "source": "iana",
    "compressible": false,
    "extensions": ["pgp"]
  },
  "application/pgp-keys": {
    "source": "iana"
  },
  "application/pgp-signature": {
    "source": "iana",
    "extensions": ["asc","sig"]
  },
  "application/pics-rules": {
    "source": "apache",
    "extensions": ["prf"]
  },
  "application/pidf+xml": {
    "source": "iana"
  },
  "application/pidf-diff+xml": {
    "source": "iana"
  },
  "application/pkcs10": {
    "source": "iana",
    "extensions": ["p10"]
  },
  "application/pkcs12": {
    "source": "iana"
  },
  "application/pkcs7-mime": {
    "source": "iana",
    "extensions": ["p7m","p7c"]
  },
  "application/pkcs7-signature": {
    "source": "iana",
    "extensions": ["p7s"]
  },
  "application/pkcs8": {
    "source": "iana",
    "extensions": ["p8"]
  },
  "application/pkix-attr-cert": {
    "source": "iana",
    "extensions": ["ac"]
  },
  "application/pkix-cert": {
    "source": "iana",
    "extensions": ["cer"]
  },
  "application/pkix-crl": {
    "source": "iana",
    "extensions": ["crl"]
  },
  "application/pkix-pkipath": {
    "source": "iana",
    "extensions": ["pkipath"]
  },
  "application/pkixcmp": {
    "source": "iana",
    "extensions": ["pki"]
  },
  "application/pls+xml": {
    "source": "iana",
    "extensions": ["pls"]
  },
  "application/poc-settings+xml": {
    "source": "iana"
  },
  "application/postscript": {
    "source": "iana",
    "compressible": true,
    "extensions": ["ai","eps","ps"]
  },
  "application/provenance+xml": {
    "source": "iana"
  },
  "application/prs.alvestrand.titrax-sheet": {
    "source": "iana"
  },
  "application/prs.cww": {
    "source": "iana",
    "extensions": ["cww"]
  },
  "application/prs.hpub+zip": {
    "source": "iana"
  },
  "application/prs.nprend": {
    "source": "iana"
  },
  "application/prs.plucker": {
    "source": "iana"
  },
  "application/prs.rdf-xml-crypt": {
    "source": "iana"
  },
  "application/prs.xsf+xml": {
    "source": "iana"
  },
  "application/pskc+xml": {
    "source": "iana",
    "extensions": ["pskcxml"]
  },
  "application/qsig": {
    "source": "iana"
  },
  "application/raptorfec": {
    "source": "iana"
  },
  "application/rdap+json": {
    "source": "iana",
    "compressible": true
  },
  "application/rdf+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["rdf"]
  },
  "application/reginfo+xml": {
    "source": "iana",
    "extensions": ["rif"]
  },
  "application/relax-ng-compact-syntax": {
    "source": "iana",
    "extensions": ["rnc"]
  },
  "application/remote-printing": {
    "source": "iana"
  },
  "application/reputon+json": {
    "source": "iana",
    "compressible": true
  },
  "application/resource-lists+xml": {
    "source": "iana",
    "extensions": ["rl"]
  },
  "application/resource-lists-diff+xml": {
    "source": "iana",
    "extensions": ["rld"]
  },
  "application/riscos": {
    "source": "iana"
  },
  "application/rlmi+xml": {
    "source": "iana"
  },
  "application/rls-services+xml": {
    "source": "iana",
    "extensions": ["rs"]
  },
  "application/rpki-ghostbusters": {
    "source": "iana",
    "extensions": ["gbr"]
  },
  "application/rpki-manifest": {
    "source": "iana",
    "extensions": ["mft"]
  },
  "application/rpki-roa": {
    "source": "iana",
    "extensions": ["roa"]
  },
  "application/rpki-updown": {
    "source": "iana"
  },
  "application/rsd+xml": {
    "source": "apache",
    "extensions": ["rsd"]
  },
  "application/rss+xml": {
    "source": "apache",
    "compressible": true,
    "extensions": ["rss"]
  },
  "application/rtf": {
    "source": "iana",
    "compressible": true,
    "extensions": ["rtf"]
  },
  "application/rtploopback": {
    "source": "iana"
  },
  "application/rtx": {
    "source": "iana"
  },
  "application/samlassertion+xml": {
    "source": "iana"
  },
  "application/samlmetadata+xml": {
    "source": "iana"
  },
  "application/sbml+xml": {
    "source": "iana",
    "extensions": ["sbml"]
  },
  "application/scaip+xml": {
    "source": "iana"
  },
  "application/scim+json": {
    "source": "iana",
    "compressible": true
  },
  "application/scvp-cv-request": {
    "source": "iana",
    "extensions": ["scq"]
  },
  "application/scvp-cv-response": {
    "source": "iana",
    "extensions": ["scs"]
  },
  "application/scvp-vp-request": {
    "source": "iana",
    "extensions": ["spq"]
  },
  "application/scvp-vp-response": {
    "source": "iana",
    "extensions": ["spp"]
  },
  "application/sdp": {
    "source": "iana",
    "extensions": ["sdp"]
  },
  "application/sep+xml": {
    "source": "iana"
  },
  "application/sep-exi": {
    "source": "iana"
  },
  "application/session-info": {
    "source": "iana"
  },
  "application/set-payment": {
    "source": "iana"
  },
  "application/set-payment-initiation": {
    "source": "iana",
    "extensions": ["setpay"]
  },
  "application/set-registration": {
    "source": "iana"
  },
  "application/set-registration-initiation": {
    "source": "iana",
    "extensions": ["setreg"]
  },
  "application/sgml": {
    "source": "iana"
  },
  "application/sgml-open-catalog": {
    "source": "iana"
  },
  "application/shf+xml": {
    "source": "iana",
    "extensions": ["shf"]
  },
  "application/sieve": {
    "source": "iana"
  },
  "application/simple-filter+xml": {
    "source": "iana"
  },
  "application/simple-message-summary": {
    "source": "iana"
  },
  "application/simplesymbolcontainer": {
    "source": "iana"
  },
  "application/slate": {
    "source": "iana"
  },
  "application/smil": {
    "source": "iana"
  },
  "application/smil+xml": {
    "source": "iana",
    "extensions": ["smi","smil"]
  },
  "application/smpte336m": {
    "source": "iana"
  },
  "application/soap+fastinfoset": {
    "source": "iana"
  },
  "application/soap+xml": {
    "source": "iana",
    "compressible": true
  },
  "application/sparql-query": {
    "source": "iana",
    "extensions": ["rq"]
  },
  "application/sparql-results+xml": {
    "source": "iana",
    "extensions": ["srx"]
  },
  "application/spirits-event+xml": {
    "source": "iana"
  },
  "application/sql": {
    "source": "iana"
  },
  "application/srgs": {
    "source": "iana",
    "extensions": ["gram"]
  },
  "application/srgs+xml": {
    "source": "iana",
    "extensions": ["grxml"]
  },
  "application/sru+xml": {
    "source": "iana",
    "extensions": ["sru"]
  },
  "application/ssdl+xml": {
    "source": "apache",
    "extensions": ["ssdl"]
  },
  "application/ssml+xml": {
    "source": "iana",
    "extensions": ["ssml"]
  },
  "application/tamp-apex-update": {
    "source": "iana"
  },
  "application/tamp-apex-update-confirm": {
    "source": "iana"
  },
  "application/tamp-community-update": {
    "source": "iana"
  },
  "application/tamp-community-update-confirm": {
    "source": "iana"
  },
  "application/tamp-error": {
    "source": "iana"
  },
  "application/tamp-sequence-adjust": {
    "source": "iana"
  },
  "application/tamp-sequence-adjust-confirm": {
    "source": "iana"
  },
  "application/tamp-status-query": {
    "source": "iana"
  },
  "application/tamp-status-response": {
    "source": "iana"
  },
  "application/tamp-update": {
    "source": "iana"
  },
  "application/tamp-update-confirm": {
    "source": "iana"
  },
  "application/tar": {
    "compressible": true
  },
  "application/tei+xml": {
    "source": "iana",
    "extensions": ["tei","teicorpus"]
  },
  "application/thraud+xml": {
    "source": "iana",
    "extensions": ["tfi"]
  },
  "application/timestamp-query": {
    "source": "iana"
  },
  "application/timestamp-reply": {
    "source": "iana"
  },
  "application/timestamped-data": {
    "source": "iana",
    "extensions": ["tsd"]
  },
  "application/ttml+xml": {
    "source": "iana"
  },
  "application/tve-trigger": {
    "source": "iana"
  },
  "application/ulpfec": {
    "source": "iana"
  },
  "application/urc-grpsheet+xml": {
    "source": "iana"
  },
  "application/urc-ressheet+xml": {
    "source": "iana"
  },
  "application/urc-targetdesc+xml": {
    "source": "iana"
  },
  "application/urc-uisocketdesc+xml": {
    "source": "iana"
  },
  "application/vcard+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vcard+xml": {
    "source": "iana"
  },
  "application/vemmi": {
    "source": "iana"
  },
  "application/vividence.scriptfile": {
    "source": "apache"
  },
  "application/vnd.3gpp-prose+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp-prose-pc3ch+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp.bsf+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp.mid-call+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp.pic-bw-large": {
    "source": "iana",
    "extensions": ["plb"]
  },
  "application/vnd.3gpp.pic-bw-small": {
    "source": "iana",
    "extensions": ["psb"]
  },
  "application/vnd.3gpp.pic-bw-var": {
    "source": "iana",
    "extensions": ["pvb"]
  },
  "application/vnd.3gpp.sms": {
    "source": "iana"
  },
  "application/vnd.3gpp.srvcc-info+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp.state-and-event-info+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp.ussd+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp2.bcmcsinfo+xml": {
    "source": "iana"
  },
  "application/vnd.3gpp2.sms": {
    "source": "iana"
  },
  "application/vnd.3gpp2.tcap": {
    "source": "iana",
    "extensions": ["tcap"]
  },
  "application/vnd.3m.post-it-notes": {
    "source": "iana",
    "extensions": ["pwn"]
  },
  "application/vnd.accpac.simply.aso": {
    "source": "iana",
    "extensions": ["aso"]
  },
  "application/vnd.accpac.simply.imp": {
    "source": "iana",
    "extensions": ["imp"]
  },
  "application/vnd.acucobol": {
    "source": "iana",
    "extensions": ["acu"]
  },
  "application/vnd.acucorp": {
    "source": "iana",
    "extensions": ["atc","acutc"]
  },
  "application/vnd.adobe.air-application-installer-package+zip": {
    "source": "apache",
    "extensions": ["air"]
  },
  "application/vnd.adobe.flash.movie": {
    "source": "iana"
  },
  "application/vnd.adobe.formscentral.fcdt": {
    "source": "iana",
    "extensions": ["fcdt"]
  },
  "application/vnd.adobe.fxp": {
    "source": "iana",
    "extensions": ["fxp","fxpl"]
  },
  "application/vnd.adobe.partial-upload": {
    "source": "iana"
  },
  "application/vnd.adobe.xdp+xml": {
    "source": "iana",
    "extensions": ["xdp"]
  },
  "application/vnd.adobe.xfdf": {
    "source": "iana",
    "extensions": ["xfdf"]
  },
  "application/vnd.aether.imp": {
    "source": "iana"
  },
  "application/vnd.ah-barcode": {
    "source": "iana"
  },
  "application/vnd.ahead.space": {
    "source": "iana",
    "extensions": ["ahead"]
  },
  "application/vnd.airzip.filesecure.azf": {
    "source": "iana",
    "extensions": ["azf"]
  },
  "application/vnd.airzip.filesecure.azs": {
    "source": "iana",
    "extensions": ["azs"]
  },
  "application/vnd.amazon.ebook": {
    "source": "apache",
    "extensions": ["azw"]
  },
  "application/vnd.americandynamics.acc": {
    "source": "iana",
    "extensions": ["acc"]
  },
  "application/vnd.amiga.ami": {
    "source": "iana",
    "extensions": ["ami"]
  },
  "application/vnd.amundsen.maze+xml": {
    "source": "iana"
  },
  "application/vnd.android.package-archive": {
    "source": "apache",
    "compressible": false,
    "extensions": ["apk"]
  },
  "application/vnd.anki": {
    "source": "iana"
  },
  "application/vnd.anser-web-certificate-issue-initiation": {
    "source": "iana",
    "extensions": ["cii"]
  },
  "application/vnd.anser-web-funds-transfer-initiation": {
    "source": "apache",
    "extensions": ["fti"]
  },
  "application/vnd.antix.game-component": {
    "source": "iana",
    "extensions": ["atx"]
  },
  "application/vnd.apache.thrift.binary": {
    "source": "iana"
  },
  "application/vnd.apache.thrift.compact": {
    "source": "iana"
  },
  "application/vnd.apache.thrift.json": {
    "source": "iana"
  },
  "application/vnd.api+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.apple.installer+xml": {
    "source": "iana",
    "extensions": ["mpkg"]
  },
  "application/vnd.apple.mpegurl": {
    "source": "iana",
    "extensions": ["m3u8"]
  },
  "application/vnd.apple.pkpass": {
    "compressible": false,
    "extensions": ["pkpass"]
  },
  "application/vnd.arastra.swi": {
    "source": "iana"
  },
  "application/vnd.aristanetworks.swi": {
    "source": "iana",
    "extensions": ["swi"]
  },
  "application/vnd.artsquare": {
    "source": "iana"
  },
  "application/vnd.astraea-software.iota": {
    "source": "iana",
    "extensions": ["iota"]
  },
  "application/vnd.audiograph": {
    "source": "iana",
    "extensions": ["aep"]
  },
  "application/vnd.autopackage": {
    "source": "iana"
  },
  "application/vnd.avistar+xml": {
    "source": "iana"
  },
  "application/vnd.balsamiq.bmml+xml": {
    "source": "iana"
  },
  "application/vnd.balsamiq.bmpr": {
    "source": "iana"
  },
  "application/vnd.bekitzur-stech+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.biopax.rdf+xml": {
    "source": "iana"
  },
  "application/vnd.blueice.multipass": {
    "source": "iana",
    "extensions": ["mpm"]
  },
  "application/vnd.bluetooth.ep.oob": {
    "source": "iana"
  },
  "application/vnd.bluetooth.le.oob": {
    "source": "iana"
  },
  "application/vnd.bmi": {
    "source": "iana",
    "extensions": ["bmi"]
  },
  "application/vnd.businessobjects": {
    "source": "iana",
    "extensions": ["rep"]
  },
  "application/vnd.cab-jscript": {
    "source": "iana"
  },
  "application/vnd.canon-cpdl": {
    "source": "iana"
  },
  "application/vnd.canon-lips": {
    "source": "iana"
  },
  "application/vnd.cendio.thinlinc.clientconf": {
    "source": "iana"
  },
  "application/vnd.century-systems.tcp_stream": {
    "source": "iana"
  },
  "application/vnd.chemdraw+xml": {
    "source": "iana",
    "extensions": ["cdxml"]
  },
  "application/vnd.chipnuts.karaoke-mmd": {
    "source": "iana",
    "extensions": ["mmd"]
  },
  "application/vnd.cinderella": {
    "source": "iana",
    "extensions": ["cdy"]
  },
  "application/vnd.cirpack.isdn-ext": {
    "source": "iana"
  },
  "application/vnd.citationstyles.style+xml": {
    "source": "iana"
  },
  "application/vnd.claymore": {
    "source": "iana",
    "extensions": ["cla"]
  },
  "application/vnd.cloanto.rp9": {
    "source": "iana",
    "extensions": ["rp9"]
  },
  "application/vnd.clonk.c4group": {
    "source": "iana",
    "extensions": ["c4g","c4d","c4f","c4p","c4u"]
  },
  "application/vnd.cluetrust.cartomobile-config": {
    "source": "iana",
    "extensions": ["c11amc"]
  },
  "application/vnd.cluetrust.cartomobile-config-pkg": {
    "source": "iana",
    "extensions": ["c11amz"]
  },
  "application/vnd.coffeescript": {
    "source": "iana"
  },
  "application/vnd.collection+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.collection.doc+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.collection.next+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.commerce-battelle": {
    "source": "iana"
  },
  "application/vnd.commonspace": {
    "source": "iana",
    "extensions": ["csp"]
  },
  "application/vnd.contact.cmsg": {
    "source": "iana",
    "extensions": ["cdbcmsg"]
  },
  "application/vnd.cosmocaller": {
    "source": "iana",
    "extensions": ["cmc"]
  },
  "application/vnd.crick.clicker": {
    "source": "iana",
    "extensions": ["clkx"]
  },
  "application/vnd.crick.clicker.keyboard": {
    "source": "iana",
    "extensions": ["clkk"]
  },
  "application/vnd.crick.clicker.palette": {
    "source": "iana",
    "extensions": ["clkp"]
  },
  "application/vnd.crick.clicker.template": {
    "source": "iana",
    "extensions": ["clkt"]
  },
  "application/vnd.crick.clicker.wordbank": {
    "source": "iana",
    "extensions": ["clkw"]
  },
  "application/vnd.criticaltools.wbs+xml": {
    "source": "iana",
    "extensions": ["wbs"]
  },
  "application/vnd.ctc-posml": {
    "source": "iana",
    "extensions": ["pml"]
  },
  "application/vnd.ctct.ws+xml": {
    "source": "iana"
  },
  "application/vnd.cups-pdf": {
    "source": "iana"
  },
  "application/vnd.cups-postscript": {
    "source": "iana"
  },
  "application/vnd.cups-ppd": {
    "source": "iana",
    "extensions": ["ppd"]
  },
  "application/vnd.cups-raster": {
    "source": "iana"
  },
  "application/vnd.cups-raw": {
    "source": "iana"
  },
  "application/vnd.curl": {
    "source": "iana"
  },
  "application/vnd.curl.car": {
    "source": "apache",
    "extensions": ["car"]
  },
  "application/vnd.curl.pcurl": {
    "source": "apache",
    "extensions": ["pcurl"]
  },
  "application/vnd.cyan.dean.root+xml": {
    "source": "iana"
  },
  "application/vnd.cybank": {
    "source": "iana"
  },
  "application/vnd.dart": {
    "source": "iana",
    "compressible": true,
    "extensions": ["dart"]
  },
  "application/vnd.data-vision.rdz": {
    "source": "iana",
    "extensions": ["rdz"]
  },
  "application/vnd.debian.binary-package": {
    "source": "iana"
  },
  "application/vnd.dece.data": {
    "source": "iana",
    "extensions": ["uvf","uvvf","uvd","uvvd"]
  },
  "application/vnd.dece.ttml+xml": {
    "source": "iana",
    "extensions": ["uvt","uvvt"]
  },
  "application/vnd.dece.unspecified": {
    "source": "iana",
    "extensions": ["uvx","uvvx"]
  },
  "application/vnd.dece.zip": {
    "source": "iana",
    "extensions": ["uvz","uvvz"]
  },
  "application/vnd.denovo.fcselayout-link": {
    "source": "iana",
    "extensions": ["fe_launch"]
  },
  "application/vnd.desmume-movie": {
    "source": "iana"
  },
  "application/vnd.dir-bi.plate-dl-nosuffix": {
    "source": "iana"
  },
  "application/vnd.dm.delegation+xml": {
    "source": "iana"
  },
  "application/vnd.dna": {
    "source": "iana",
    "extensions": ["dna"]
  },
  "application/vnd.document+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.dolby.mlp": {
    "source": "apache",
    "extensions": ["mlp"]
  },
  "application/vnd.dolby.mobile.1": {
    "source": "iana"
  },
  "application/vnd.dolby.mobile.2": {
    "source": "iana"
  },
  "application/vnd.doremir.scorecloud-binary-document": {
    "source": "iana"
  },
  "application/vnd.dpgraph": {
    "source": "iana",
    "extensions": ["dpg"]
  },
  "application/vnd.dreamfactory": {
    "source": "iana",
    "extensions": ["dfac"]
  },
  "application/vnd.drive+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ds-keypoint": {
    "source": "apache",
    "extensions": ["kpxx"]
  },
  "application/vnd.dtg.local": {
    "source": "iana"
  },
  "application/vnd.dtg.local.flash": {
    "source": "iana"
  },
  "application/vnd.dtg.local.html": {
    "source": "iana"
  },
  "application/vnd.dvb.ait": {
    "source": "iana",
    "extensions": ["ait"]
  },
  "application/vnd.dvb.dvbj": {
    "source": "iana"
  },
  "application/vnd.dvb.esgcontainer": {
    "source": "iana"
  },
  "application/vnd.dvb.ipdcdftnotifaccess": {
    "source": "iana"
  },
  "application/vnd.dvb.ipdcesgaccess": {
    "source": "iana"
  },
  "application/vnd.dvb.ipdcesgaccess2": {
    "source": "iana"
  },
  "application/vnd.dvb.ipdcesgpdd": {
    "source": "iana"
  },
  "application/vnd.dvb.ipdcroaming": {
    "source": "iana"
  },
  "application/vnd.dvb.iptv.alfec-base": {
    "source": "iana"
  },
  "application/vnd.dvb.iptv.alfec-enhancement": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-aggregate-root+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-container+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-generic+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-ia-msglist+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-ia-registration-request+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-ia-registration-response+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.notif-init+xml": {
    "source": "iana"
  },
  "application/vnd.dvb.pfr": {
    "source": "iana"
  },
  "application/vnd.dvb.service": {
    "source": "iana",
    "extensions": ["svc"]
  },
  "application/vnd.dxr": {
    "source": "iana"
  },
  "application/vnd.dynageo": {
    "source": "iana",
    "extensions": ["geo"]
  },
  "application/vnd.dzr": {
    "source": "iana"
  },
  "application/vnd.easykaraoke.cdgdownload": {
    "source": "iana"
  },
  "application/vnd.ecdis-update": {
    "source": "iana"
  },
  "application/vnd.ecowin.chart": {
    "source": "iana",
    "extensions": ["mag"]
  },
  "application/vnd.ecowin.filerequest": {
    "source": "iana"
  },
  "application/vnd.ecowin.fileupdate": {
    "source": "iana"
  },
  "application/vnd.ecowin.series": {
    "source": "iana"
  },
  "application/vnd.ecowin.seriesrequest": {
    "source": "iana"
  },
  "application/vnd.ecowin.seriesupdate": {
    "source": "iana"
  },
  "application/vnd.emclient.accessrequest+xml": {
    "source": "iana"
  },
  "application/vnd.enliven": {
    "source": "iana",
    "extensions": ["nml"]
  },
  "application/vnd.enphase.envoy": {
    "source": "iana"
  },
  "application/vnd.eprints.data+xml": {
    "source": "iana"
  },
  "application/vnd.epson.esf": {
    "source": "iana",
    "extensions": ["esf"]
  },
  "application/vnd.epson.msf": {
    "source": "iana",
    "extensions": ["msf"]
  },
  "application/vnd.epson.quickanime": {
    "source": "iana",
    "extensions": ["qam"]
  },
  "application/vnd.epson.salt": {
    "source": "iana",
    "extensions": ["slt"]
  },
  "application/vnd.epson.ssf": {
    "source": "iana",
    "extensions": ["ssf"]
  },
  "application/vnd.ericsson.quickcall": {
    "source": "iana"
  },
  "application/vnd.eszigno3+xml": {
    "source": "iana",
    "extensions": ["es3","et3"]
  },
  "application/vnd.etsi.aoc+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.asic-e+zip": {
    "source": "iana"
  },
  "application/vnd.etsi.asic-s+zip": {
    "source": "iana"
  },
  "application/vnd.etsi.cug+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvcommand+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvdiscovery+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvprofile+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvsad-bc+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvsad-cod+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvsad-npvr+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvservice+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvsync+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.iptvueprofile+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.mcid+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.mheg5": {
    "source": "iana"
  },
  "application/vnd.etsi.overload-control-policy-dataset+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.pstn+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.sci+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.simservs+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.timestamp-token": {
    "source": "iana"
  },
  "application/vnd.etsi.tsl+xml": {
    "source": "iana"
  },
  "application/vnd.etsi.tsl.der": {
    "source": "iana"
  },
  "application/vnd.eudora.data": {
    "source": "iana"
  },
  "application/vnd.ezpix-album": {
    "source": "iana",
    "extensions": ["ez2"]
  },
  "application/vnd.ezpix-package": {
    "source": "iana",
    "extensions": ["ez3"]
  },
  "application/vnd.f-secure.mobile": {
    "source": "iana"
  },
  "application/vnd.fastcopy-disk-image": {
    "source": "iana"
  },
  "application/vnd.fdf": {
    "source": "iana",
    "extensions": ["fdf"]
  },
  "application/vnd.fdsn.mseed": {
    "source": "iana",
    "extensions": ["mseed"]
  },
  "application/vnd.fdsn.seed": {
    "source": "iana",
    "extensions": ["seed","dataless"]
  },
  "application/vnd.ffsns": {
    "source": "iana"
  },
  "application/vnd.fints": {
    "source": "iana"
  },
  "application/vnd.firemonkeys.cloudcell": {
    "source": "iana"
  },
  "application/vnd.flographit": {
    "source": "iana",
    "extensions": ["gph"]
  },
  "application/vnd.fluxtime.clip": {
    "source": "iana",
    "extensions": ["ftc"]
  },
  "application/vnd.font-fontforge-sfd": {
    "source": "iana"
  },
  "application/vnd.framemaker": {
    "source": "iana",
    "extensions": ["fm","frame","maker","book"]
  },
  "application/vnd.frogans.fnc": {
    "source": "iana",
    "extensions": ["fnc"]
  },
  "application/vnd.frogans.ltf": {
    "source": "iana",
    "extensions": ["ltf"]
  },
  "application/vnd.fsc.weblaunch": {
    "source": "iana",
    "extensions": ["fsc"]
  },
  "application/vnd.fujitsu.oasys": {
    "source": "iana",
    "extensions": ["oas"]
  },
  "application/vnd.fujitsu.oasys2": {
    "source": "iana",
    "extensions": ["oa2"]
  },
  "application/vnd.fujitsu.oasys3": {
    "source": "iana",
    "extensions": ["oa3"]
  },
  "application/vnd.fujitsu.oasysgp": {
    "source": "iana",
    "extensions": ["fg5"]
  },
  "application/vnd.fujitsu.oasysprs": {
    "source": "iana",
    "extensions": ["bh2"]
  },
  "application/vnd.fujixerox.art-ex": {
    "source": "iana"
  },
  "application/vnd.fujixerox.art4": {
    "source": "iana"
  },
  "application/vnd.fujixerox.ddd": {
    "source": "iana",
    "extensions": ["ddd"]
  },
  "application/vnd.fujixerox.docuworks": {
    "source": "iana",
    "extensions": ["xdw"]
  },
  "application/vnd.fujixerox.docuworks.binder": {
    "source": "iana",
    "extensions": ["xbd"]
  },
  "application/vnd.fujixerox.docuworks.container": {
    "source": "iana"
  },
  "application/vnd.fujixerox.hbpl": {
    "source": "iana"
  },
  "application/vnd.fut-misnet": {
    "source": "iana"
  },
  "application/vnd.fuzzysheet": {
    "source": "iana",
    "extensions": ["fzs"]
  },
  "application/vnd.genomatix.tuxedo": {
    "source": "iana",
    "extensions": ["txd"]
  },
  "application/vnd.geo+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.geocube+xml": {
    "source": "iana"
  },
  "application/vnd.geogebra.file": {
    "source": "iana",
    "extensions": ["ggb"]
  },
  "application/vnd.geogebra.tool": {
    "source": "iana",
    "extensions": ["ggt"]
  },
  "application/vnd.geometry-explorer": {
    "source": "iana",
    "extensions": ["gex","gre"]
  },
  "application/vnd.geonext": {
    "source": "iana",
    "extensions": ["gxt"]
  },
  "application/vnd.geoplan": {
    "source": "iana",
    "extensions": ["g2w"]
  },
  "application/vnd.geospace": {
    "source": "iana",
    "extensions": ["g3w"]
  },
  "application/vnd.gerber": {
    "source": "iana"
  },
  "application/vnd.globalplatform.card-content-mgt": {
    "source": "iana"
  },
  "application/vnd.globalplatform.card-content-mgt-response": {
    "source": "iana"
  },
  "application/vnd.gmx": {
    "source": "iana",
    "extensions": ["gmx"]
  },
  "application/vnd.google-earth.kml+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["kml"]
  },
  "application/vnd.google-earth.kmz": {
    "source": "iana",
    "compressible": false,
    "extensions": ["kmz"]
  },
  "application/vnd.gov.sk.e-form+xml": {
    "source": "iana"
  },
  "application/vnd.gov.sk.e-form+zip": {
    "source": "iana"
  },
  "application/vnd.gov.sk.xmldatacontainer+xml": {
    "source": "iana"
  },
  "application/vnd.grafeq": {
    "source": "iana",
    "extensions": ["gqf","gqs"]
  },
  "application/vnd.gridmp": {
    "source": "iana"
  },
  "application/vnd.groove-account": {
    "source": "iana",
    "extensions": ["gac"]
  },
  "application/vnd.groove-help": {
    "source": "iana",
    "extensions": ["ghf"]
  },
  "application/vnd.groove-identity-message": {
    "source": "iana",
    "extensions": ["gim"]
  },
  "application/vnd.groove-injector": {
    "source": "iana",
    "extensions": ["grv"]
  },
  "application/vnd.groove-tool-message": {
    "source": "iana",
    "extensions": ["gtm"]
  },
  "application/vnd.groove-tool-template": {
    "source": "iana",
    "extensions": ["tpl"]
  },
  "application/vnd.groove-vcard": {
    "source": "iana",
    "extensions": ["vcg"]
  },
  "application/vnd.hal+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.hal+xml": {
    "source": "iana",
    "extensions": ["hal"]
  },
  "application/vnd.handheld-entertainment+xml": {
    "source": "iana",
    "extensions": ["zmm"]
  },
  "application/vnd.hbci": {
    "source": "iana",
    "extensions": ["hbci"]
  },
  "application/vnd.hcl-bireports": {
    "source": "iana"
  },
  "application/vnd.heroku+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.hhe.lesson-player": {
    "source": "iana",
    "extensions": ["les"]
  },
  "application/vnd.hp-hpgl": {
    "source": "iana",
    "extensions": ["hpgl"]
  },
  "application/vnd.hp-hpid": {
    "source": "iana",
    "extensions": ["hpid"]
  },
  "application/vnd.hp-hps": {
    "source": "iana",
    "extensions": ["hps"]
  },
  "application/vnd.hp-jlyt": {
    "source": "iana",
    "extensions": ["jlt"]
  },
  "application/vnd.hp-pcl": {
    "source": "iana",
    "extensions": ["pcl"]
  },
  "application/vnd.hp-pclxl": {
    "source": "iana",
    "extensions": ["pclxl"]
  },
  "application/vnd.httphone": {
    "source": "iana"
  },
  "application/vnd.hydrostatix.sof-data": {
    "source": "iana",
    "extensions": ["sfd-hdstx"]
  },
  "application/vnd.hyperdrive+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.hzn-3d-crossword": {
    "source": "iana"
  },
  "application/vnd.ibm.afplinedata": {
    "source": "iana"
  },
  "application/vnd.ibm.electronic-media": {
    "source": "iana"
  },
  "application/vnd.ibm.minipay": {
    "source": "iana",
    "extensions": ["mpy"]
  },
  "application/vnd.ibm.modcap": {
    "source": "iana",
    "extensions": ["afp","listafp","list3820"]
  },
  "application/vnd.ibm.rights-management": {
    "source": "iana",
    "extensions": ["irm"]
  },
  "application/vnd.ibm.secure-container": {
    "source": "iana",
    "extensions": ["sc"]
  },
  "application/vnd.iccprofile": {
    "source": "iana",
    "extensions": ["icc","icm"]
  },
  "application/vnd.ieee.1905": {
    "source": "iana"
  },
  "application/vnd.igloader": {
    "source": "iana",
    "extensions": ["igl"]
  },
  "application/vnd.immervision-ivp": {
    "source": "iana",
    "extensions": ["ivp"]
  },
  "application/vnd.immervision-ivu": {
    "source": "iana",
    "extensions": ["ivu"]
  },
  "application/vnd.ims.imsccv1p1": {
    "source": "iana"
  },
  "application/vnd.ims.imsccv1p2": {
    "source": "iana"
  },
  "application/vnd.ims.imsccv1p3": {
    "source": "iana"
  },
  "application/vnd.ims.lis.v2.result+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ims.lti.v2.toolconsumerprofile+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ims.lti.v2.toolproxy+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ims.lti.v2.toolproxy.id+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ims.lti.v2.toolsettings+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.ims.lti.v2.toolsettings.simple+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.informedcontrol.rms+xml": {
    "source": "iana"
  },
  "application/vnd.informix-visionary": {
    "source": "iana"
  },
  "application/vnd.infotech.project": {
    "source": "iana"
  },
  "application/vnd.infotech.project+xml": {
    "source": "iana"
  },
  "application/vnd.innopath.wamp.notification": {
    "source": "iana"
  },
  "application/vnd.insors.igm": {
    "source": "iana",
    "extensions": ["igm"]
  },
  "application/vnd.intercon.formnet": {
    "source": "iana",
    "extensions": ["xpw","xpx"]
  },
  "application/vnd.intergeo": {
    "source": "iana",
    "extensions": ["i2g"]
  },
  "application/vnd.intertrust.digibox": {
    "source": "iana"
  },
  "application/vnd.intertrust.nncp": {
    "source": "iana"
  },
  "application/vnd.intu.qbo": {
    "source": "iana",
    "extensions": ["qbo"]
  },
  "application/vnd.intu.qfx": {
    "source": "iana",
    "extensions": ["qfx"]
  },
  "application/vnd.iptc.g2.catalogitem+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.conceptitem+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.knowledgeitem+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.newsitem+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.newsmessage+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.packageitem+xml": {
    "source": "iana"
  },
  "application/vnd.iptc.g2.planningitem+xml": {
    "source": "iana"
  },
  "application/vnd.ipunplugged.rcprofile": {
    "source": "iana",
    "extensions": ["rcprofile"]
  },
  "application/vnd.irepository.package+xml": {
    "source": "iana",
    "extensions": ["irp"]
  },
  "application/vnd.is-xpr": {
    "source": "iana",
    "extensions": ["xpr"]
  },
  "application/vnd.isac.fcs": {
    "source": "iana",
    "extensions": ["fcs"]
  },
  "application/vnd.jam": {
    "source": "iana",
    "extensions": ["jam"]
  },
  "application/vnd.japannet-directory-service": {
    "source": "iana"
  },
  "application/vnd.japannet-jpnstore-wakeup": {
    "source": "iana"
  },
  "application/vnd.japannet-payment-wakeup": {
    "source": "iana"
  },
  "application/vnd.japannet-registration": {
    "source": "iana"
  },
  "application/vnd.japannet-registration-wakeup": {
    "source": "iana"
  },
  "application/vnd.japannet-setstore-wakeup": {
    "source": "iana"
  },
  "application/vnd.japannet-verification": {
    "source": "iana"
  },
  "application/vnd.japannet-verification-wakeup": {
    "source": "iana"
  },
  "application/vnd.jcp.javame.midlet-rms": {
    "source": "iana",
    "extensions": ["rms"]
  },
  "application/vnd.jisp": {
    "source": "iana",
    "extensions": ["jisp"]
  },
  "application/vnd.joost.joda-archive": {
    "source": "iana",
    "extensions": ["joda"]
  },
  "application/vnd.jsk.isdn-ngn": {
    "source": "iana"
  },
  "application/vnd.kahootz": {
    "source": "iana",
    "extensions": ["ktz","ktr"]
  },
  "application/vnd.kde.karbon": {
    "source": "iana",
    "extensions": ["karbon"]
  },
  "application/vnd.kde.kchart": {
    "source": "iana",
    "extensions": ["chrt"]
  },
  "application/vnd.kde.kformula": {
    "source": "iana",
    "extensions": ["kfo"]
  },
  "application/vnd.kde.kivio": {
    "source": "iana",
    "extensions": ["flw"]
  },
  "application/vnd.kde.kontour": {
    "source": "iana",
    "extensions": ["kon"]
  },
  "application/vnd.kde.kpresenter": {
    "source": "iana",
    "extensions": ["kpr","kpt"]
  },
  "application/vnd.kde.kspread": {
    "source": "iana",
    "extensions": ["ksp"]
  },
  "application/vnd.kde.kword": {
    "source": "iana",
    "extensions": ["kwd","kwt"]
  },
  "application/vnd.kenameaapp": {
    "source": "iana",
    "extensions": ["htke"]
  },
  "application/vnd.kidspiration": {
    "source": "iana",
    "extensions": ["kia"]
  },
  "application/vnd.kinar": {
    "source": "iana",
    "extensions": ["kne","knp"]
  },
  "application/vnd.koan": {
    "source": "iana",
    "extensions": ["skp","skd","skt","skm"]
  },
  "application/vnd.kodak-descriptor": {
    "source": "iana",
    "extensions": ["sse"]
  },
  "application/vnd.las.las+xml": {
    "source": "iana",
    "extensions": ["lasxml"]
  },
  "application/vnd.liberty-request+xml": {
    "source": "iana"
  },
  "application/vnd.llamagraphics.life-balance.desktop": {
    "source": "iana",
    "extensions": ["lbd"]
  },
  "application/vnd.llamagraphics.life-balance.exchange+xml": {
    "source": "iana",
    "extensions": ["lbe"]
  },
  "application/vnd.lotus-1-2-3": {
    "source": "iana",
    "extensions": ["123"]
  },
  "application/vnd.lotus-approach": {
    "source": "iana",
    "extensions": ["apr"]
  },
  "application/vnd.lotus-freelance": {
    "source": "iana",
    "extensions": ["pre"]
  },
  "application/vnd.lotus-notes": {
    "source": "iana",
    "extensions": ["nsf"]
  },
  "application/vnd.lotus-organizer": {
    "source": "iana",
    "extensions": ["org"]
  },
  "application/vnd.lotus-screencam": {
    "source": "iana",
    "extensions": ["scm"]
  },
  "application/vnd.lotus-wordpro": {
    "source": "iana",
    "extensions": ["lwp"]
  },
  "application/vnd.macports.portpkg": {
    "source": "iana",
    "extensions": ["portpkg"]
  },
  "application/vnd.marlin.drm.actiontoken+xml": {
    "source": "iana"
  },
  "application/vnd.marlin.drm.conftoken+xml": {
    "source": "iana"
  },
  "application/vnd.marlin.drm.license+xml": {
    "source": "iana"
  },
  "application/vnd.marlin.drm.mdcf": {
    "source": "iana"
  },
  "application/vnd.mason+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.maxmind.maxmind-db": {
    "source": "iana"
  },
  "application/vnd.mcd": {
    "source": "iana",
    "extensions": ["mcd"]
  },
  "application/vnd.medcalcdata": {
    "source": "iana",
    "extensions": ["mc1"]
  },
  "application/vnd.mediastation.cdkey": {
    "source": "iana",
    "extensions": ["cdkey"]
  },
  "application/vnd.meridian-slingshot": {
    "source": "iana"
  },
  "application/vnd.mfer": {
    "source": "iana",
    "extensions": ["mwf"]
  },
  "application/vnd.mfmp": {
    "source": "iana",
    "extensions": ["mfm"]
  },
  "application/vnd.micro+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.micrografx.flo": {
    "source": "iana",
    "extensions": ["flo"]
  },
  "application/vnd.micrografx.igx": {
    "source": "iana",
    "extensions": ["igx"]
  },
  "application/vnd.microsoft.portable-executable": {
    "source": "iana"
  },
  "application/vnd.miele+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.mif": {
    "source": "iana",
    "extensions": ["mif"]
  },
  "application/vnd.minisoft-hp3000-save": {
    "source": "iana"
  },
  "application/vnd.mitsubishi.misty-guard.trustweb": {
    "source": "iana"
  },
  "application/vnd.mobius.daf": {
    "source": "iana",
    "extensions": ["daf"]
  },
  "application/vnd.mobius.dis": {
    "source": "iana",
    "extensions": ["dis"]
  },
  "application/vnd.mobius.mbk": {
    "source": "iana",
    "extensions": ["mbk"]
  },
  "application/vnd.mobius.mqy": {
    "source": "iana",
    "extensions": ["mqy"]
  },
  "application/vnd.mobius.msl": {
    "source": "iana",
    "extensions": ["msl"]
  },
  "application/vnd.mobius.plc": {
    "source": "iana",
    "extensions": ["plc"]
  },
  "application/vnd.mobius.txf": {
    "source": "iana",
    "extensions": ["txf"]
  },
  "application/vnd.mophun.application": {
    "source": "iana",
    "extensions": ["mpn"]
  },
  "application/vnd.mophun.certificate": {
    "source": "iana",
    "extensions": ["mpc"]
  },
  "application/vnd.motorola.flexsuite": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.adsi": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.fis": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.gotap": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.kmr": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.ttc": {
    "source": "iana"
  },
  "application/vnd.motorola.flexsuite.wem": {
    "source": "iana"
  },
  "application/vnd.motorola.iprm": {
    "source": "iana"
  },
  "application/vnd.mozilla.xul+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["xul"]
  },
  "application/vnd.ms-3mfdocument": {
    "source": "iana"
  },
  "application/vnd.ms-artgalry": {
    "source": "iana",
    "extensions": ["cil"]
  },
  "application/vnd.ms-asf": {
    "source": "iana"
  },
  "application/vnd.ms-cab-compressed": {
    "source": "iana",
    "extensions": ["cab"]
  },
  "application/vnd.ms-color.iccprofile": {
    "source": "apache"
  },
  "application/vnd.ms-excel": {
    "source": "iana",
    "compressible": false,
    "extensions": ["xls","xlm","xla","xlc","xlt","xlw"]
  },
  "application/vnd.ms-excel.addin.macroenabled.12": {
    "source": "iana",
    "extensions": ["xlam"]
  },
  "application/vnd.ms-excel.sheet.binary.macroenabled.12": {
    "source": "iana",
    "extensions": ["xlsb"]
  },
  "application/vnd.ms-excel.sheet.macroenabled.12": {
    "source": "iana",
    "extensions": ["xlsm"]
  },
  "application/vnd.ms-excel.template.macroenabled.12": {
    "source": "iana",
    "extensions": ["xltm"]
  },
  "application/vnd.ms-fontobject": {
    "source": "iana",
    "compressible": true,
    "extensions": ["eot"]
  },
  "application/vnd.ms-htmlhelp": {
    "source": "iana",
    "extensions": ["chm"]
  },
  "application/vnd.ms-ims": {
    "source": "iana",
    "extensions": ["ims"]
  },
  "application/vnd.ms-lrm": {
    "source": "iana",
    "extensions": ["lrm"]
  },
  "application/vnd.ms-office.activex+xml": {
    "source": "iana"
  },
  "application/vnd.ms-officetheme": {
    "source": "iana",
    "extensions": ["thmx"]
  },
  "application/vnd.ms-opentype": {
    "source": "apache",
    "compressible": true
  },
  "application/vnd.ms-package.obfuscated-opentype": {
    "source": "apache"
  },
  "application/vnd.ms-pki.seccat": {
    "source": "apache",
    "extensions": ["cat"]
  },
  "application/vnd.ms-pki.stl": {
    "source": "apache",
    "extensions": ["stl"]
  },
  "application/vnd.ms-playready.initiator+xml": {
    "source": "iana"
  },
  "application/vnd.ms-powerpoint": {
    "source": "iana",
    "compressible": false,
    "extensions": ["ppt","pps","pot"]
  },
  "application/vnd.ms-powerpoint.addin.macroenabled.12": {
    "source": "iana",
    "extensions": ["ppam"]
  },
  "application/vnd.ms-powerpoint.presentation.macroenabled.12": {
    "source": "iana",
    "extensions": ["pptm"]
  },
  "application/vnd.ms-powerpoint.slide.macroenabled.12": {
    "source": "iana",
    "extensions": ["sldm"]
  },
  "application/vnd.ms-powerpoint.slideshow.macroenabled.12": {
    "source": "iana",
    "extensions": ["ppsm"]
  },
  "application/vnd.ms-powerpoint.template.macroenabled.12": {
    "source": "iana",
    "extensions": ["potm"]
  },
  "application/vnd.ms-printing.printticket+xml": {
    "source": "apache"
  },
  "application/vnd.ms-project": {
    "source": "iana",
    "extensions": ["mpp","mpt"]
  },
  "application/vnd.ms-tnef": {
    "source": "iana"
  },
  "application/vnd.ms-windows.printerpairing": {
    "source": "iana"
  },
  "application/vnd.ms-wmdrm.lic-chlg-req": {
    "source": "iana"
  },
  "application/vnd.ms-wmdrm.lic-resp": {
    "source": "iana"
  },
  "application/vnd.ms-wmdrm.meter-chlg-req": {
    "source": "iana"
  },
  "application/vnd.ms-wmdrm.meter-resp": {
    "source": "iana"
  },
  "application/vnd.ms-word.document.macroenabled.12": {
    "source": "iana",
    "extensions": ["docm"]
  },
  "application/vnd.ms-word.template.macroenabled.12": {
    "source": "iana",
    "extensions": ["dotm"]
  },
  "application/vnd.ms-works": {
    "source": "iana",
    "extensions": ["wps","wks","wcm","wdb"]
  },
  "application/vnd.ms-wpl": {
    "source": "iana",
    "extensions": ["wpl"]
  },
  "application/vnd.ms-xpsdocument": {
    "source": "iana",
    "compressible": false,
    "extensions": ["xps"]
  },
  "application/vnd.msa-disk-image": {
    "source": "iana"
  },
  "application/vnd.mseq": {
    "source": "iana",
    "extensions": ["mseq"]
  },
  "application/vnd.msign": {
    "source": "iana"
  },
  "application/vnd.multiad.creator": {
    "source": "iana"
  },
  "application/vnd.multiad.creator.cif": {
    "source": "iana"
  },
  "application/vnd.music-niff": {
    "source": "iana"
  },
  "application/vnd.musician": {
    "source": "iana",
    "extensions": ["mus"]
  },
  "application/vnd.muvee.style": {
    "source": "iana",
    "extensions": ["msty"]
  },
  "application/vnd.mynfc": {
    "source": "iana",
    "extensions": ["taglet"]
  },
  "application/vnd.ncd.control": {
    "source": "iana"
  },
  "application/vnd.ncd.reference": {
    "source": "iana"
  },
  "application/vnd.nervana": {
    "source": "iana"
  },
  "application/vnd.netfpx": {
    "source": "iana"
  },
  "application/vnd.neurolanguage.nlu": {
    "source": "iana",
    "extensions": ["nlu"]
  },
  "application/vnd.nintendo.nitro.rom": {
    "source": "iana"
  },
  "application/vnd.nintendo.snes.rom": {
    "source": "iana"
  },
  "application/vnd.nitf": {
    "source": "iana",
    "extensions": ["ntf","nitf"]
  },
  "application/vnd.noblenet-directory": {
    "source": "iana",
    "extensions": ["nnd"]
  },
  "application/vnd.noblenet-sealer": {
    "source": "iana",
    "extensions": ["nns"]
  },
  "application/vnd.noblenet-web": {
    "source": "iana",
    "extensions": ["nnw"]
  },
  "application/vnd.nokia.catalogs": {
    "source": "iana"
  },
  "application/vnd.nokia.conml+wbxml": {
    "source": "iana"
  },
  "application/vnd.nokia.conml+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.iptv.config+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.isds-radio-presets": {
    "source": "iana"
  },
  "application/vnd.nokia.landmark+wbxml": {
    "source": "iana"
  },
  "application/vnd.nokia.landmark+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.landmarkcollection+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.n-gage.ac+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.n-gage.data": {
    "source": "iana",
    "extensions": ["ngdat"]
  },
  "application/vnd.nokia.n-gage.symbian.install": {
    "source": "iana",
    "extensions": ["n-gage"]
  },
  "application/vnd.nokia.ncd": {
    "source": "iana"
  },
  "application/vnd.nokia.pcd+wbxml": {
    "source": "iana"
  },
  "application/vnd.nokia.pcd+xml": {
    "source": "iana"
  },
  "application/vnd.nokia.radio-preset": {
    "source": "iana",
    "extensions": ["rpst"]
  },
  "application/vnd.nokia.radio-presets": {
    "source": "iana",
    "extensions": ["rpss"]
  },
  "application/vnd.novadigm.edm": {
    "source": "iana",
    "extensions": ["edm"]
  },
  "application/vnd.novadigm.edx": {
    "source": "iana",
    "extensions": ["edx"]
  },
  "application/vnd.novadigm.ext": {
    "source": "iana",
    "extensions": ["ext"]
  },
  "application/vnd.ntt-local.content-share": {
    "source": "iana"
  },
  "application/vnd.ntt-local.file-transfer": {
    "source": "iana"
  },
  "application/vnd.ntt-local.ogw_remote-access": {
    "source": "iana"
  },
  "application/vnd.ntt-local.sip-ta_remote": {
    "source": "iana"
  },
  "application/vnd.ntt-local.sip-ta_tcp_stream": {
    "source": "iana"
  },
  "application/vnd.oasis.opendocument.chart": {
    "source": "iana",
    "extensions": ["odc"]
  },
  "application/vnd.oasis.opendocument.chart-template": {
    "source": "iana",
    "extensions": ["otc"]
  },
  "application/vnd.oasis.opendocument.database": {
    "source": "iana",
    "extensions": ["odb"]
  },
  "application/vnd.oasis.opendocument.formula": {
    "source": "iana",
    "extensions": ["odf"]
  },
  "application/vnd.oasis.opendocument.formula-template": {
    "source": "iana",
    "extensions": ["odft"]
  },
  "application/vnd.oasis.opendocument.graphics": {
    "source": "iana",
    "compressible": false,
    "extensions": ["odg"]
  },
  "application/vnd.oasis.opendocument.graphics-template": {
    "source": "iana",
    "extensions": ["otg"]
  },
  "application/vnd.oasis.opendocument.image": {
    "source": "iana",
    "extensions": ["odi"]
  },
  "application/vnd.oasis.opendocument.image-template": {
    "source": "iana",
    "extensions": ["oti"]
  },
  "application/vnd.oasis.opendocument.presentation": {
    "source": "iana",
    "compressible": false,
    "extensions": ["odp"]
  },
  "application/vnd.oasis.opendocument.presentation-template": {
    "source": "iana",
    "extensions": ["otp"]
  },
  "application/vnd.oasis.opendocument.spreadsheet": {
    "source": "iana",
    "compressible": false,
    "extensions": ["ods"]
  },
  "application/vnd.oasis.opendocument.spreadsheet-template": {
    "source": "iana",
    "extensions": ["ots"]
  },
  "application/vnd.oasis.opendocument.text": {
    "source": "iana",
    "compressible": false,
    "extensions": ["odt"]
  },
  "application/vnd.oasis.opendocument.text-master": {
    "source": "iana",
    "extensions": ["odm"]
  },
  "application/vnd.oasis.opendocument.text-template": {
    "source": "iana",
    "extensions": ["ott"]
  },
  "application/vnd.oasis.opendocument.text-web": {
    "source": "iana",
    "extensions": ["oth"]
  },
  "application/vnd.obn": {
    "source": "iana"
  },
  "application/vnd.oftn.l10n+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.oipf.contentaccessdownload+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.contentaccessstreaming+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.cspg-hexbinary": {
    "source": "iana"
  },
  "application/vnd.oipf.dae.svg+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.dae.xhtml+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.mippvcontrolmessage+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.pae.gem": {
    "source": "iana"
  },
  "application/vnd.oipf.spdiscovery+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.spdlist+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.ueprofile+xml": {
    "source": "iana"
  },
  "application/vnd.oipf.userprofile+xml": {
    "source": "iana"
  },
  "application/vnd.olpc-sugar": {
    "source": "iana",
    "extensions": ["xo"]
  },
  "application/vnd.oma-scws-config": {
    "source": "iana"
  },
  "application/vnd.oma-scws-http-request": {
    "source": "iana"
  },
  "application/vnd.oma-scws-http-response": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.associated-procedure-parameter+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.drm-trigger+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.imd+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.ltkm": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.notification+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.provisioningtrigger": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.sgboot": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.sgdd+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.sgdu": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.simple-symbol-container": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.smartcard-trigger+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.sprov+xml": {
    "source": "iana"
  },
  "application/vnd.oma.bcast.stkm": {
    "source": "iana"
  },
  "application/vnd.oma.cab-address-book+xml": {
    "source": "iana"
  },
  "application/vnd.oma.cab-feature-handler+xml": {
    "source": "iana"
  },
  "application/vnd.oma.cab-pcc+xml": {
    "source": "iana"
  },
  "application/vnd.oma.cab-subs-invite+xml": {
    "source": "iana"
  },
  "application/vnd.oma.cab-user-prefs+xml": {
    "source": "iana"
  },
  "application/vnd.oma.dcd": {
    "source": "iana"
  },
  "application/vnd.oma.dcdc": {
    "source": "iana"
  },
  "application/vnd.oma.dd2+xml": {
    "source": "iana",
    "extensions": ["dd2"]
  },
  "application/vnd.oma.drm.risd+xml": {
    "source": "iana"
  },
  "application/vnd.oma.group-usage-list+xml": {
    "source": "iana"
  },
  "application/vnd.oma.pal+xml": {
    "source": "iana"
  },
  "application/vnd.oma.poc.detailed-progress-report+xml": {
    "source": "iana"
  },
  "application/vnd.oma.poc.final-report+xml": {
    "source": "iana"
  },
  "application/vnd.oma.poc.groups+xml": {
    "source": "iana"
  },
  "application/vnd.oma.poc.invocation-descriptor+xml": {
    "source": "iana"
  },
  "application/vnd.oma.poc.optimized-progress-report+xml": {
    "source": "iana"
  },
  "application/vnd.oma.push": {
    "source": "iana"
  },
  "application/vnd.oma.scidm.messages+xml": {
    "source": "iana"
  },
  "application/vnd.oma.xcap-directory+xml": {
    "source": "iana"
  },
  "application/vnd.omads-email+xml": {
    "source": "iana"
  },
  "application/vnd.omads-file+xml": {
    "source": "iana"
  },
  "application/vnd.omads-folder+xml": {
    "source": "iana"
  },
  "application/vnd.omaloc-supl-init": {
    "source": "iana"
  },
  "application/vnd.openblox.game+xml": {
    "source": "iana"
  },
  "application/vnd.openblox.game-binary": {
    "source": "iana"
  },
  "application/vnd.openeye.oeb": {
    "source": "iana"
  },
  "application/vnd.openofficeorg.extension": {
    "source": "apache",
    "extensions": ["oxt"]
  },
  "application/vnd.openxmlformats-officedocument.custom-properties+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.customxmlproperties+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawing+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.chart+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.chartshapes+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.diagramcolors+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.diagramdata+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.diagramlayout+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.drawingml.diagramstyle+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.extended-properties+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml-template": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.commentauthors+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.comments+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.handoutmaster+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.notesmaster+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.notesslide+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.presentation": {
    "source": "iana",
    "compressible": false,
    "extensions": ["pptx"]
  },
  "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.presprops+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slide": {
    "source": "iana",
    "extensions": ["sldx"]
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slide+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slidelayout+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slidemaster+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slideshow": {
    "source": "iana",
    "extensions": ["ppsx"]
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slideshow.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.slideupdateinfo+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.tablestyles+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.tags+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.template": {
    "source": "apache",
    "extensions": ["potx"]
  },
  "application/vnd.openxmlformats-officedocument.presentationml.template.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.presentationml.viewprops+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml-template": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.calcchain+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.chartsheet+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.comments+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.connections+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.dialogsheet+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.externallink+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.pivotcachedefinition+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.pivotcacherecords+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.pivottable+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.querytable+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.revisionheaders+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.revisionlog+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sharedstrings+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": {
    "source": "iana",
    "compressible": false,
    "extensions": ["xlsx"]
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheetmetadata+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.table+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.tablesinglecells+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.template": {
    "source": "apache",
    "extensions": ["xltx"]
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.template.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.usernames+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.volatiledependencies+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.theme+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.themeoverride+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.vmldrawing": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml-template": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.comments+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document": {
    "source": "iana",
    "compressible": false,
    "extensions": ["docx"]
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document.glossary+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.endnotes+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.fonttable+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.footnotes+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.template": {
    "source": "apache",
    "extensions": ["dotx"]
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.template.main+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-officedocument.wordprocessingml.websettings+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-package.core-properties+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-package.digital-signature-xmlsignature+xml": {
    "source": "iana"
  },
  "application/vnd.openxmlformats-package.relationships+xml": {
    "source": "iana"
  },
  "application/vnd.oracle.resource+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.orange.indata": {
    "source": "iana"
  },
  "application/vnd.osa.netdeploy": {
    "source": "iana"
  },
  "application/vnd.osgeo.mapguide.package": {
    "source": "iana",
    "extensions": ["mgp"]
  },
  "application/vnd.osgi.bundle": {
    "source": "iana"
  },
  "application/vnd.osgi.dp": {
    "source": "iana",
    "extensions": ["dp"]
  },
  "application/vnd.osgi.subsystem": {
    "source": "iana",
    "extensions": ["esa"]
  },
  "application/vnd.otps.ct-kip+xml": {
    "source": "iana"
  },
  "application/vnd.palm": {
    "source": "iana",
    "extensions": ["pdb","pqa","oprc"]
  },
  "application/vnd.panoply": {
    "source": "iana"
  },
  "application/vnd.paos+xml": {
    "source": "iana"
  },
  "application/vnd.paos.xml": {
    "source": "apache"
  },
  "application/vnd.pawaafile": {
    "source": "iana",
    "extensions": ["paw"]
  },
  "application/vnd.pcos": {
    "source": "iana"
  },
  "application/vnd.pg.format": {
    "source": "iana",
    "extensions": ["str"]
  },
  "application/vnd.pg.osasli": {
    "source": "iana",
    "extensions": ["ei6"]
  },
  "application/vnd.piaccess.application-licence": {
    "source": "iana"
  },
  "application/vnd.picsel": {
    "source": "iana",
    "extensions": ["efif"]
  },
  "application/vnd.pmi.widget": {
    "source": "iana",
    "extensions": ["wg"]
  },
  "application/vnd.poc.group-advertisement+xml": {
    "source": "iana"
  },
  "application/vnd.pocketlearn": {
    "source": "iana",
    "extensions": ["plf"]
  },
  "application/vnd.powerbuilder6": {
    "source": "iana",
    "extensions": ["pbd"]
  },
  "application/vnd.powerbuilder6-s": {
    "source": "iana"
  },
  "application/vnd.powerbuilder7": {
    "source": "iana"
  },
  "application/vnd.powerbuilder7-s": {
    "source": "iana"
  },
  "application/vnd.powerbuilder75": {
    "source": "iana"
  },
  "application/vnd.powerbuilder75-s": {
    "source": "iana"
  },
  "application/vnd.preminet": {
    "source": "iana"
  },
  "application/vnd.previewsystems.box": {
    "source": "iana",
    "extensions": ["box"]
  },
  "application/vnd.proteus.magazine": {
    "source": "iana",
    "extensions": ["mgz"]
  },
  "application/vnd.publishare-delta-tree": {
    "source": "iana",
    "extensions": ["qps"]
  },
  "application/vnd.pvi.ptid1": {
    "source": "iana",
    "extensions": ["ptid"]
  },
  "application/vnd.pwg-multiplexed": {
    "source": "iana"
  },
  "application/vnd.pwg-xhtml-print+xml": {
    "source": "iana"
  },
  "application/vnd.qualcomm.brew-app-res": {
    "source": "iana"
  },
  "application/vnd.quark.quarkxpress": {
    "source": "iana",
    "extensions": ["qxd","qxt","qwd","qwt","qxl","qxb"]
  },
  "application/vnd.quobject-quoxdocument": {
    "source": "iana"
  },
  "application/vnd.radisys.moml+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-audit+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-audit-conf+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-audit-conn+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-audit-dialog+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-audit-stream+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-conf+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-base+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-fax-detect+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-fax-sendrecv+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-group+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-speech+xml": {
    "source": "iana"
  },
  "application/vnd.radisys.msml-dialog-transform+xml": {
    "source": "iana"
  },
  "application/vnd.rainstor.data": {
    "source": "iana"
  },
  "application/vnd.rapid": {
    "source": "iana"
  },
  "application/vnd.realvnc.bed": {
    "source": "iana",
    "extensions": ["bed"]
  },
  "application/vnd.recordare.musicxml": {
    "source": "iana",
    "extensions": ["mxl"]
  },
  "application/vnd.recordare.musicxml+xml": {
    "source": "iana",
    "extensions": ["musicxml"]
  },
  "application/vnd.renlearn.rlprint": {
    "source": "iana"
  },
  "application/vnd.rig.cryptonote": {
    "source": "iana",
    "extensions": ["cryptonote"]
  },
  "application/vnd.rim.cod": {
    "source": "apache",
    "extensions": ["cod"]
  },
  "application/vnd.rn-realmedia": {
    "source": "apache",
    "extensions": ["rm"]
  },
  "application/vnd.rn-realmedia-vbr": {
    "source": "apache",
    "extensions": ["rmvb"]
  },
  "application/vnd.route66.link66+xml": {
    "source": "iana",
    "extensions": ["link66"]
  },
  "application/vnd.rs-274x": {
    "source": "iana"
  },
  "application/vnd.ruckus.download": {
    "source": "iana"
  },
  "application/vnd.s3sms": {
    "source": "iana"
  },
  "application/vnd.sailingtracker.track": {
    "source": "iana",
    "extensions": ["st"]
  },
  "application/vnd.sbm.cid": {
    "source": "iana"
  },
  "application/vnd.sbm.mid2": {
    "source": "iana"
  },
  "application/vnd.scribus": {
    "source": "iana"
  },
  "application/vnd.sealed.3df": {
    "source": "iana"
  },
  "application/vnd.sealed.csf": {
    "source": "iana"
  },
  "application/vnd.sealed.doc": {
    "source": "iana"
  },
  "application/vnd.sealed.eml": {
    "source": "iana"
  },
  "application/vnd.sealed.mht": {
    "source": "iana"
  },
  "application/vnd.sealed.net": {
    "source": "iana"
  },
  "application/vnd.sealed.ppt": {
    "source": "iana"
  },
  "application/vnd.sealed.tiff": {
    "source": "iana"
  },
  "application/vnd.sealed.xls": {
    "source": "iana"
  },
  "application/vnd.sealedmedia.softseal.html": {
    "source": "iana"
  },
  "application/vnd.sealedmedia.softseal.pdf": {
    "source": "iana"
  },
  "application/vnd.seemail": {
    "source": "iana",
    "extensions": ["see"]
  },
  "application/vnd.sema": {
    "source": "iana",
    "extensions": ["sema"]
  },
  "application/vnd.semd": {
    "source": "iana",
    "extensions": ["semd"]
  },
  "application/vnd.semf": {
    "source": "iana",
    "extensions": ["semf"]
  },
  "application/vnd.shana.informed.formdata": {
    "source": "iana",
    "extensions": ["ifm"]
  },
  "application/vnd.shana.informed.formtemplate": {
    "source": "iana",
    "extensions": ["itp"]
  },
  "application/vnd.shana.informed.interchange": {
    "source": "iana",
    "extensions": ["iif"]
  },
  "application/vnd.shana.informed.package": {
    "source": "iana",
    "extensions": ["ipk"]
  },
  "application/vnd.simtech-mindmapper": {
    "source": "iana",
    "extensions": ["twd","twds"]
  },
  "application/vnd.siren+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.smaf": {
    "source": "iana",
    "extensions": ["mmf"]
  },
  "application/vnd.smart.notebook": {
    "source": "iana"
  },
  "application/vnd.smart.teacher": {
    "source": "iana",
    "extensions": ["teacher"]
  },
  "application/vnd.software602.filler.form+xml": {
    "source": "iana"
  },
  "application/vnd.software602.filler.form-xml-zip": {
    "source": "iana"
  },
  "application/vnd.solent.sdkm+xml": {
    "source": "iana",
    "extensions": ["sdkm","sdkd"]
  },
  "application/vnd.spotfire.dxp": {
    "source": "iana",
    "extensions": ["dxp"]
  },
  "application/vnd.spotfire.sfs": {
    "source": "iana",
    "extensions": ["sfs"]
  },
  "application/vnd.sss-cod": {
    "source": "iana"
  },
  "application/vnd.sss-dtf": {
    "source": "iana"
  },
  "application/vnd.sss-ntf": {
    "source": "iana"
  },
  "application/vnd.stardivision.calc": {
    "source": "apache",
    "extensions": ["sdc"]
  },
  "application/vnd.stardivision.draw": {
    "source": "apache",
    "extensions": ["sda"]
  },
  "application/vnd.stardivision.impress": {
    "source": "apache",
    "extensions": ["sdd"]
  },
  "application/vnd.stardivision.math": {
    "source": "apache",
    "extensions": ["smf"]
  },
  "application/vnd.stardivision.writer": {
    "source": "apache",
    "extensions": ["sdw","vor"]
  },
  "application/vnd.stardivision.writer-global": {
    "source": "apache",
    "extensions": ["sgl"]
  },
  "application/vnd.stepmania.package": {
    "source": "iana",
    "extensions": ["smzip"]
  },
  "application/vnd.stepmania.stepchart": {
    "source": "iana",
    "extensions": ["sm"]
  },
  "application/vnd.street-stream": {
    "source": "iana"
  },
  "application/vnd.sun.wadl+xml": {
    "source": "iana"
  },
  "application/vnd.sun.xml.calc": {
    "source": "apache",
    "extensions": ["sxc"]
  },
  "application/vnd.sun.xml.calc.template": {
    "source": "apache",
    "extensions": ["stc"]
  },
  "application/vnd.sun.xml.draw": {
    "source": "apache",
    "extensions": ["sxd"]
  },
  "application/vnd.sun.xml.draw.template": {
    "source": "apache",
    "extensions": ["std"]
  },
  "application/vnd.sun.xml.impress": {
    "source": "apache",
    "extensions": ["sxi"]
  },
  "application/vnd.sun.xml.impress.template": {
    "source": "apache",
    "extensions": ["sti"]
  },
  "application/vnd.sun.xml.math": {
    "source": "apache",
    "extensions": ["sxm"]
  },
  "application/vnd.sun.xml.writer": {
    "source": "apache",
    "extensions": ["sxw"]
  },
  "application/vnd.sun.xml.writer.global": {
    "source": "apache",
    "extensions": ["sxg"]
  },
  "application/vnd.sun.xml.writer.template": {
    "source": "apache",
    "extensions": ["stw"]
  },
  "application/vnd.sus-calendar": {
    "source": "iana",
    "extensions": ["sus","susp"]
  },
  "application/vnd.svd": {
    "source": "iana",
    "extensions": ["svd"]
  },
  "application/vnd.swiftview-ics": {
    "source": "iana"
  },
  "application/vnd.symbian.install": {
    "source": "apache",
    "extensions": ["sis","sisx"]
  },
  "application/vnd.syncml+xml": {
    "source": "iana",
    "extensions": ["xsm"]
  },
  "application/vnd.syncml.dm+wbxml": {
    "source": "iana",
    "extensions": ["bdm"]
  },
  "application/vnd.syncml.dm+xml": {
    "source": "iana",
    "extensions": ["xdm"]
  },
  "application/vnd.syncml.dm.notification": {
    "source": "iana"
  },
  "application/vnd.syncml.dmddf+wbxml": {
    "source": "iana"
  },
  "application/vnd.syncml.dmddf+xml": {
    "source": "iana"
  },
  "application/vnd.syncml.dmtnds+wbxml": {
    "source": "iana"
  },
  "application/vnd.syncml.dmtnds+xml": {
    "source": "iana"
  },
  "application/vnd.syncml.ds.notification": {
    "source": "iana"
  },
  "application/vnd.tao.intent-module-archive": {
    "source": "iana",
    "extensions": ["tao"]
  },
  "application/vnd.tcpdump.pcap": {
    "source": "iana",
    "extensions": ["pcap","cap","dmp"]
  },
  "application/vnd.tmd.mediaflex.api+xml": {
    "source": "iana"
  },
  "application/vnd.tmobile-livetv": {
    "source": "iana",
    "extensions": ["tmo"]
  },
  "application/vnd.trid.tpt": {
    "source": "iana",
    "extensions": ["tpt"]
  },
  "application/vnd.triscape.mxs": {
    "source": "iana",
    "extensions": ["mxs"]
  },
  "application/vnd.trueapp": {
    "source": "iana",
    "extensions": ["tra"]
  },
  "application/vnd.truedoc": {
    "source": "iana"
  },
  "application/vnd.ubisoft.webplayer": {
    "source": "iana"
  },
  "application/vnd.ufdl": {
    "source": "iana",
    "extensions": ["ufd","ufdl"]
  },
  "application/vnd.uiq.theme": {
    "source": "iana",
    "extensions": ["utz"]
  },
  "application/vnd.umajin": {
    "source": "iana",
    "extensions": ["umj"]
  },
  "application/vnd.unity": {
    "source": "iana",
    "extensions": ["unityweb"]
  },
  "application/vnd.uoml+xml": {
    "source": "iana",
    "extensions": ["uoml"]
  },
  "application/vnd.uplanet.alert": {
    "source": "iana"
  },
  "application/vnd.uplanet.alert-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.bearer-choice": {
    "source": "iana"
  },
  "application/vnd.uplanet.bearer-choice-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.cacheop": {
    "source": "iana"
  },
  "application/vnd.uplanet.cacheop-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.channel": {
    "source": "iana"
  },
  "application/vnd.uplanet.channel-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.list": {
    "source": "iana"
  },
  "application/vnd.uplanet.list-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.listcmd": {
    "source": "iana"
  },
  "application/vnd.uplanet.listcmd-wbxml": {
    "source": "iana"
  },
  "application/vnd.uplanet.signal": {
    "source": "iana"
  },
  "application/vnd.uri-map": {
    "source": "iana"
  },
  "application/vnd.valve.source.material": {
    "source": "iana"
  },
  "application/vnd.vcx": {
    "source": "iana",
    "extensions": ["vcx"]
  },
  "application/vnd.vd-study": {
    "source": "iana"
  },
  "application/vnd.vectorworks": {
    "source": "iana"
  },
  "application/vnd.verimatrix.vcas": {
    "source": "iana"
  },
  "application/vnd.vidsoft.vidconference": {
    "source": "iana"
  },
  "application/vnd.visio": {
    "source": "iana",
    "extensions": ["vsd","vst","vss","vsw"]
  },
  "application/vnd.visionary": {
    "source": "iana",
    "extensions": ["vis"]
  },
  "application/vnd.vividence.scriptfile": {
    "source": "iana"
  },
  "application/vnd.vsf": {
    "source": "iana",
    "extensions": ["vsf"]
  },
  "application/vnd.wap.sic": {
    "source": "iana"
  },
  "application/vnd.wap.slc": {
    "source": "iana"
  },
  "application/vnd.wap.wbxml": {
    "source": "iana",
    "extensions": ["wbxml"]
  },
  "application/vnd.wap.wmlc": {
    "source": "iana",
    "extensions": ["wmlc"]
  },
  "application/vnd.wap.wmlscriptc": {
    "source": "iana",
    "extensions": ["wmlsc"]
  },
  "application/vnd.webturbo": {
    "source": "iana",
    "extensions": ["wtb"]
  },
  "application/vnd.wfa.p2p": {
    "source": "iana"
  },
  "application/vnd.wfa.wsc": {
    "source": "iana"
  },
  "application/vnd.windows.devicepairing": {
    "source": "iana"
  },
  "application/vnd.wmc": {
    "source": "iana"
  },
  "application/vnd.wmf.bootstrap": {
    "source": "iana"
  },
  "application/vnd.wolfram.mathematica": {
    "source": "iana"
  },
  "application/vnd.wolfram.mathematica.package": {
    "source": "iana"
  },
  "application/vnd.wolfram.player": {
    "source": "iana",
    "extensions": ["nbp"]
  },
  "application/vnd.wordperfect": {
    "source": "iana",
    "extensions": ["wpd"]
  },
  "application/vnd.wqd": {
    "source": "iana",
    "extensions": ["wqd"]
  },
  "application/vnd.wrq-hp3000-labelled": {
    "source": "iana"
  },
  "application/vnd.wt.stf": {
    "source": "iana",
    "extensions": ["stf"]
  },
  "application/vnd.wv.csp+wbxml": {
    "source": "iana"
  },
  "application/vnd.wv.csp+xml": {
    "source": "iana"
  },
  "application/vnd.wv.ssp+xml": {
    "source": "iana"
  },
  "application/vnd.xacml+json": {
    "source": "iana",
    "compressible": true
  },
  "application/vnd.xara": {
    "source": "iana",
    "extensions": ["xar"]
  },
  "application/vnd.xfdl": {
    "source": "iana",
    "extensions": ["xfdl"]
  },
  "application/vnd.xfdl.webform": {
    "source": "iana"
  },
  "application/vnd.xmi+xml": {
    "source": "iana"
  },
  "application/vnd.xmpie.cpkg": {
    "source": "iana"
  },
  "application/vnd.xmpie.dpkg": {
    "source": "iana"
  },
  "application/vnd.xmpie.plan": {
    "source": "iana"
  },
  "application/vnd.xmpie.ppkg": {
    "source": "iana"
  },
  "application/vnd.xmpie.xlim": {
    "source": "iana"
  },
  "application/vnd.yamaha.hv-dic": {
    "source": "iana",
    "extensions": ["hvd"]
  },
  "application/vnd.yamaha.hv-script": {
    "source": "iana",
    "extensions": ["hvs"]
  },
  "application/vnd.yamaha.hv-voice": {
    "source": "iana",
    "extensions": ["hvp"]
  },
  "application/vnd.yamaha.openscoreformat": {
    "source": "iana",
    "extensions": ["osf"]
  },
  "application/vnd.yamaha.openscoreformat.osfpvg+xml": {
    "source": "iana",
    "extensions": ["osfpvg"]
  },
  "application/vnd.yamaha.remote-setup": {
    "source": "iana"
  },
  "application/vnd.yamaha.smaf-audio": {
    "source": "iana",
    "extensions": ["saf"]
  },
  "application/vnd.yamaha.smaf-phrase": {
    "source": "iana",
    "extensions": ["spf"]
  },
  "application/vnd.yamaha.through-ngn": {
    "source": "iana"
  },
  "application/vnd.yamaha.tunnel-udpencap": {
    "source": "iana"
  },
  "application/vnd.yaoweme": {
    "source": "iana"
  },
  "application/vnd.yellowriver-custom-menu": {
    "source": "iana",
    "extensions": ["cmp"]
  },
  "application/vnd.zul": {
    "source": "iana",
    "extensions": ["zir","zirz"]
  },
  "application/vnd.zzazz.deck+xml": {
    "source": "iana",
    "extensions": ["zaz"]
  },
  "application/voicexml+xml": {
    "source": "iana",
    "extensions": ["vxml"]
  },
  "application/vq-rtcpxr": {
    "source": "iana"
  },
  "application/watcherinfo+xml": {
    "source": "iana"
  },
  "application/whoispp-query": {
    "source": "iana"
  },
  "application/whoispp-response": {
    "source": "iana"
  },
  "application/widget": {
    "source": "iana",
    "extensions": ["wgt"]
  },
  "application/winhlp": {
    "source": "apache",
    "extensions": ["hlp"]
  },
  "application/wita": {
    "source": "iana"
  },
  "application/wordperfect5.1": {
    "source": "iana"
  },
  "application/wsdl+xml": {
    "source": "iana",
    "extensions": ["wsdl"]
  },
  "application/wspolicy+xml": {
    "source": "iana",
    "extensions": ["wspolicy"]
  },
  "application/x-7z-compressed": {
    "source": "apache",
    "compressible": false,
    "extensions": ["7z"]
  },
  "application/x-abiword": {
    "source": "apache",
    "extensions": ["abw"]
  },
  "application/x-ace-compressed": {
    "source": "apache",
    "extensions": ["ace"]
  },
  "application/x-amf": {
    "source": "apache"
  },
  "application/x-apple-diskimage": {
    "source": "apache",
    "extensions": ["dmg"]
  },
  "application/x-authorware-bin": {
    "source": "apache",
    "extensions": ["aab","x32","u32","vox"]
  },
  "application/x-authorware-map": {
    "source": "apache",
    "extensions": ["aam"]
  },
  "application/x-authorware-seg": {
    "source": "apache",
    "extensions": ["aas"]
  },
  "application/x-bcpio": {
    "source": "apache",
    "extensions": ["bcpio"]
  },
  "application/x-bdoc": {
    "compressible": false,
    "extensions": ["bdoc"]
  },
  "application/x-bittorrent": {
    "source": "apache",
    "extensions": ["torrent"]
  },
  "application/x-blorb": {
    "source": "apache",
    "extensions": ["blb","blorb"]
  },
  "application/x-bzip": {
    "source": "apache",
    "compressible": false,
    "extensions": ["bz"]
  },
  "application/x-bzip2": {
    "source": "apache",
    "compressible": false,
    "extensions": ["bz2","boz"]
  },
  "application/x-cbr": {
    "source": "apache",
    "extensions": ["cbr","cba","cbt","cbz","cb7"]
  },
  "application/x-cdlink": {
    "source": "apache",
    "extensions": ["vcd"]
  },
  "application/x-cfs-compressed": {
    "source": "apache",
    "extensions": ["cfs"]
  },
  "application/x-chat": {
    "source": "apache",
    "extensions": ["chat"]
  },
  "application/x-chess-pgn": {
    "source": "apache",
    "extensions": ["pgn"]
  },
  "application/x-chrome-extension": {
    "extensions": ["crx"]
  },
  "application/x-cocoa": {
    "source": "nginx",
    "extensions": ["cco"]
  },
  "application/x-compress": {
    "source": "apache"
  },
  "application/x-conference": {
    "source": "apache",
    "extensions": ["nsc"]
  },
  "application/x-cpio": {
    "source": "apache",
    "extensions": ["cpio"]
  },
  "application/x-csh": {
    "source": "apache",
    "extensions": ["csh"]
  },
  "application/x-deb": {
    "compressible": false
  },
  "application/x-debian-package": {
    "source": "apache",
    "extensions": ["deb","udeb"]
  },
  "application/x-dgc-compressed": {
    "source": "apache",
    "extensions": ["dgc"]
  },
  "application/x-director": {
    "source": "apache",
    "extensions": ["dir","dcr","dxr","cst","cct","cxt","w3d","fgd","swa"]
  },
  "application/x-doom": {
    "source": "apache",
    "extensions": ["wad"]
  },
  "application/x-dtbncx+xml": {
    "source": "apache",
    "extensions": ["ncx"]
  },
  "application/x-dtbook+xml": {
    "source": "apache",
    "extensions": ["dtb"]
  },
  "application/x-dtbresource+xml": {
    "source": "apache",
    "extensions": ["res"]
  },
  "application/x-dvi": {
    "source": "apache",
    "compressible": false,
    "extensions": ["dvi"]
  },
  "application/x-envoy": {
    "source": "apache",
    "extensions": ["evy"]
  },
  "application/x-eva": {
    "source": "apache",
    "extensions": ["eva"]
  },
  "application/x-font-bdf": {
    "source": "apache",
    "extensions": ["bdf"]
  },
  "application/x-font-dos": {
    "source": "apache"
  },
  "application/x-font-framemaker": {
    "source": "apache"
  },
  "application/x-font-ghostscript": {
    "source": "apache",
    "extensions": ["gsf"]
  },
  "application/x-font-libgrx": {
    "source": "apache"
  },
  "application/x-font-linux-psf": {
    "source": "apache",
    "extensions": ["psf"]
  },
  "application/x-font-otf": {
    "source": "apache",
    "compressible": true,
    "extensions": ["otf"]
  },
  "application/x-font-pcf": {
    "source": "apache",
    "extensions": ["pcf"]
  },
  "application/x-font-snf": {
    "source": "apache",
    "extensions": ["snf"]
  },
  "application/x-font-speedo": {
    "source": "apache"
  },
  "application/x-font-sunos-news": {
    "source": "apache"
  },
  "application/x-font-ttf": {
    "source": "apache",
    "compressible": true,
    "extensions": ["ttf","ttc"]
  },
  "application/x-font-type1": {
    "source": "apache",
    "extensions": ["pfa","pfb","pfm","afm"]
  },
  "application/x-font-vfont": {
    "source": "apache"
  },
  "application/x-freearc": {
    "source": "apache",
    "extensions": ["arc"]
  },
  "application/x-futuresplash": {
    "source": "apache",
    "extensions": ["spl"]
  },
  "application/x-gca-compressed": {
    "source": "apache",
    "extensions": ["gca"]
  },
  "application/x-glulx": {
    "source": "apache",
    "extensions": ["ulx"]
  },
  "application/x-gnumeric": {
    "source": "apache",
    "extensions": ["gnumeric"]
  },
  "application/x-gramps-xml": {
    "source": "apache",
    "extensions": ["gramps"]
  },
  "application/x-gtar": {
    "source": "apache",
    "extensions": ["gtar"]
  },
  "application/x-gzip": {
    "source": "apache"
  },
  "application/x-hdf": {
    "source": "apache",
    "extensions": ["hdf"]
  },
  "application/x-httpd-php": {
    "compressible": true,
    "extensions": ["php"]
  },
  "application/x-install-instructions": {
    "source": "apache",
    "extensions": ["install"]
  },
  "application/x-iso9660-image": {
    "source": "apache",
    "extensions": ["iso"]
  },
  "application/x-java-archive-diff": {
    "source": "nginx",
    "extensions": ["jardiff"]
  },
  "application/x-java-jnlp-file": {
    "source": "apache",
    "compressible": false,
    "extensions": ["jnlp"]
  },
  "application/x-javascript": {
    "compressible": true
  },
  "application/x-latex": {
    "source": "apache",
    "compressible": false,
    "extensions": ["latex"]
  },
  "application/x-lua-bytecode": {
    "extensions": ["luac"]
  },
  "application/x-lzh-compressed": {
    "source": "apache",
    "extensions": ["lzh","lha"]
  },
  "application/x-makeself": {
    "source": "nginx",
    "extensions": ["run"]
  },
  "application/x-mie": {
    "source": "apache",
    "extensions": ["mie"]
  },
  "application/x-mobipocket-ebook": {
    "source": "apache",
    "extensions": ["prc","mobi"]
  },
  "application/x-mpegurl": {
    "compressible": false
  },
  "application/x-ms-application": {
    "source": "apache",
    "extensions": ["application"]
  },
  "application/x-ms-shortcut": {
    "source": "apache",
    "extensions": ["lnk"]
  },
  "application/x-ms-wmd": {
    "source": "apache",
    "extensions": ["wmd"]
  },
  "application/x-ms-wmz": {
    "source": "apache",
    "extensions": ["wmz"]
  },
  "application/x-ms-xbap": {
    "source": "apache",
    "extensions": ["xbap"]
  },
  "application/x-msaccess": {
    "source": "apache",
    "extensions": ["mdb"]
  },
  "application/x-msbinder": {
    "source": "apache",
    "extensions": ["obd"]
  },
  "application/x-mscardfile": {
    "source": "apache",
    "extensions": ["crd"]
  },
  "application/x-msclip": {
    "source": "apache",
    "extensions": ["clp"]
  },
  "application/x-msdos-program": {
    "extensions": ["exe"]
  },
  "application/x-msdownload": {
    "source": "apache",
    "extensions": ["exe","dll","com","bat","msi"]
  },
  "application/x-msmediaview": {
    "source": "apache",
    "extensions": ["mvb","m13","m14"]
  },
  "application/x-msmetafile": {
    "source": "apache",
    "extensions": ["wmf","wmz","emf","emz"]
  },
  "application/x-msmoney": {
    "source": "apache",
    "extensions": ["mny"]
  },
  "application/x-mspublisher": {
    "source": "apache",
    "extensions": ["pub"]
  },
  "application/x-msschedule": {
    "source": "apache",
    "extensions": ["scd"]
  },
  "application/x-msterminal": {
    "source": "apache",
    "extensions": ["trm"]
  },
  "application/x-mswrite": {
    "source": "apache",
    "extensions": ["wri"]
  },
  "application/x-netcdf": {
    "source": "apache",
    "extensions": ["nc","cdf"]
  },
  "application/x-ns-proxy-autoconfig": {
    "compressible": true,
    "extensions": ["pac"]
  },
  "application/x-nzb": {
    "source": "apache",
    "extensions": ["nzb"]
  },
  "application/x-perl": {
    "source": "nginx",
    "extensions": ["pl","pm"]
  },
  "application/x-pilot": {
    "source": "nginx",
    "extensions": ["prc","pdb"]
  },
  "application/x-pkcs12": {
    "source": "apache",
    "compressible": false,
    "extensions": ["p12","pfx"]
  },
  "application/x-pkcs7-certificates": {
    "source": "apache",
    "extensions": ["p7b","spc"]
  },
  "application/x-pkcs7-certreqresp": {
    "source": "apache",
    "extensions": ["p7r"]
  },
  "application/x-rar-compressed": {
    "source": "apache",
    "compressible": false,
    "extensions": ["rar"]
  },
  "application/x-redhat-package-manager": {
    "source": "nginx",
    "extensions": ["rpm"]
  },
  "application/x-research-info-systems": {
    "source": "apache",
    "extensions": ["ris"]
  },
  "application/x-sea": {
    "source": "nginx",
    "extensions": ["sea"]
  },
  "application/x-sh": {
    "source": "apache",
    "compressible": true,
    "extensions": ["sh"]
  },
  "application/x-shar": {
    "source": "apache",
    "extensions": ["shar"]
  },
  "application/x-shockwave-flash": {
    "source": "apache",
    "compressible": false,
    "extensions": ["swf"]
  },
  "application/x-silverlight-app": {
    "source": "apache",
    "extensions": ["xap"]
  },
  "application/x-sql": {
    "source": "apache",
    "extensions": ["sql"]
  },
  "application/x-stuffit": {
    "source": "apache",
    "compressible": false,
    "extensions": ["sit"]
  },
  "application/x-stuffitx": {
    "source": "apache",
    "extensions": ["sitx"]
  },
  "application/x-subrip": {
    "source": "apache",
    "extensions": ["srt"]
  },
  "application/x-sv4cpio": {
    "source": "apache",
    "extensions": ["sv4cpio"]
  },
  "application/x-sv4crc": {
    "source": "apache",
    "extensions": ["sv4crc"]
  },
  "application/x-t3vm-image": {
    "source": "apache",
    "extensions": ["t3"]
  },
  "application/x-tads": {
    "source": "apache",
    "extensions": ["gam"]
  },
  "application/x-tar": {
    "source": "apache",
    "compressible": true,
    "extensions": ["tar"]
  },
  "application/x-tcl": {
    "source": "apache",
    "extensions": ["tcl","tk"]
  },
  "application/x-tex": {
    "source": "apache",
    "extensions": ["tex"]
  },
  "application/x-tex-tfm": {
    "source": "apache",
    "extensions": ["tfm"]
  },
  "application/x-texinfo": {
    "source": "apache",
    "extensions": ["texinfo","texi"]
  },
  "application/x-tgif": {
    "source": "apache",
    "extensions": ["obj"]
  },
  "application/x-ustar": {
    "source": "apache",
    "extensions": ["ustar"]
  },
  "application/x-wais-source": {
    "source": "apache",
    "extensions": ["src"]
  },
  "application/x-web-app-manifest+json": {
    "compressible": true,
    "extensions": ["webapp"]
  },
  "application/x-www-form-urlencoded": {
    "source": "iana",
    "compressible": true
  },
  "application/x-x509-ca-cert": {
    "source": "apache",
    "extensions": ["der","crt","pem"]
  },
  "application/x-xfig": {
    "source": "apache",
    "extensions": ["fig"]
  },
  "application/x-xliff+xml": {
    "source": "apache",
    "extensions": ["xlf"]
  },
  "application/x-xpinstall": {
    "source": "apache",
    "compressible": false,
    "extensions": ["xpi"]
  },
  "application/x-xz": {
    "source": "apache",
    "extensions": ["xz"]
  },
  "application/x-zmachine": {
    "source": "apache",
    "extensions": ["z1","z2","z3","z4","z5","z6","z7","z8"]
  },
  "application/x400-bp": {
    "source": "iana"
  },
  "application/xacml+xml": {
    "source": "iana"
  },
  "application/xaml+xml": {
    "source": "apache",
    "extensions": ["xaml"]
  },
  "application/xcap-att+xml": {
    "source": "iana"
  },
  "application/xcap-caps+xml": {
    "source": "iana"
  },
  "application/xcap-diff+xml": {
    "source": "iana",
    "extensions": ["xdf"]
  },
  "application/xcap-el+xml": {
    "source": "iana"
  },
  "application/xcap-error+xml": {
    "source": "iana"
  },
  "application/xcap-ns+xml": {
    "source": "iana"
  },
  "application/xcon-conference-info+xml": {
    "source": "iana"
  },
  "application/xcon-conference-info-diff+xml": {
    "source": "iana"
  },
  "application/xenc+xml": {
    "source": "iana",
    "extensions": ["xenc"]
  },
  "application/xhtml+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["xhtml","xht"]
  },
  "application/xhtml-voice+xml": {
    "source": "apache"
  },
  "application/xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["xml","xsl","xsd"]
  },
  "application/xml-dtd": {
    "source": "iana",
    "compressible": true,
    "extensions": ["dtd"]
  },
  "application/xml-external-parsed-entity": {
    "source": "iana"
  },
  "application/xml-patch+xml": {
    "source": "iana"
  },
  "application/xmpp+xml": {
    "source": "iana"
  },
  "application/xop+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["xop"]
  },
  "application/xproc+xml": {
    "source": "apache",
    "extensions": ["xpl"]
  },
  "application/xslt+xml": {
    "source": "iana",
    "extensions": ["xslt"]
  },
  "application/xspf+xml": {
    "source": "apache",
    "extensions": ["xspf"]
  },
  "application/xv+xml": {
    "source": "iana",
    "extensions": ["mxml","xhvml","xvml","xvm"]
  },
  "application/yang": {
    "source": "iana",
    "extensions": ["yang"]
  },
  "application/yin+xml": {
    "source": "iana",
    "extensions": ["yin"]
  },
  "application/zip": {
    "source": "iana",
    "compressible": false,
    "extensions": ["zip"]
  },
  "application/zlib": {
    "source": "iana"
  },
  "audio/1d-interleaved-parityfec": {
    "source": "iana"
  },
  "audio/32kadpcm": {
    "source": "iana"
  },
  "audio/3gpp": {
    "source": "iana"
  },
  "audio/3gpp2": {
    "source": "iana"
  },
  "audio/ac3": {
    "source": "iana"
  },
  "audio/adpcm": {
    "source": "apache",
    "extensions": ["adp"]
  },
  "audio/amr": {
    "source": "iana"
  },
  "audio/amr-wb": {
    "source": "iana"
  },
  "audio/amr-wb+": {
    "source": "iana"
  },
  "audio/aptx": {
    "source": "iana"
  },
  "audio/asc": {
    "source": "iana"
  },
  "audio/atrac-advanced-lossless": {
    "source": "iana"
  },
  "audio/atrac-x": {
    "source": "iana"
  },
  "audio/atrac3": {
    "source": "iana"
  },
  "audio/basic": {
    "source": "iana",
    "compressible": false,
    "extensions": ["au","snd"]
  },
  "audio/bv16": {
    "source": "iana"
  },
  "audio/bv32": {
    "source": "iana"
  },
  "audio/clearmode": {
    "source": "iana"
  },
  "audio/cn": {
    "source": "iana"
  },
  "audio/dat12": {
    "source": "iana"
  },
  "audio/dls": {
    "source": "iana"
  },
  "audio/dsr-es201108": {
    "source": "iana"
  },
  "audio/dsr-es202050": {
    "source": "iana"
  },
  "audio/dsr-es202211": {
    "source": "iana"
  },
  "audio/dsr-es202212": {
    "source": "iana"
  },
  "audio/dv": {
    "source": "iana"
  },
  "audio/dvi4": {
    "source": "iana"
  },
  "audio/eac3": {
    "source": "iana"
  },
  "audio/encaprtp": {
    "source": "iana"
  },
  "audio/evrc": {
    "source": "iana"
  },
  "audio/evrc-qcp": {
    "source": "iana"
  },
  "audio/evrc0": {
    "source": "iana"
  },
  "audio/evrc1": {
    "source": "iana"
  },
  "audio/evrcb": {
    "source": "iana"
  },
  "audio/evrcb0": {
    "source": "iana"
  },
  "audio/evrcb1": {
    "source": "iana"
  },
  "audio/evrcnw": {
    "source": "iana"
  },
  "audio/evrcnw0": {
    "source": "iana"
  },
  "audio/evrcnw1": {
    "source": "iana"
  },
  "audio/evrcwb": {
    "source": "iana"
  },
  "audio/evrcwb0": {
    "source": "iana"
  },
  "audio/evrcwb1": {
    "source": "iana"
  },
  "audio/fwdred": {
    "source": "iana"
  },
  "audio/g711-0": {
    "source": "iana"
  },
  "audio/g719": {
    "source": "iana"
  },
  "audio/g722": {
    "source": "iana"
  },
  "audio/g7221": {
    "source": "iana"
  },
  "audio/g723": {
    "source": "iana"
  },
  "audio/g726-16": {
    "source": "iana"
  },
  "audio/g726-24": {
    "source": "iana"
  },
  "audio/g726-32": {
    "source": "iana"
  },
  "audio/g726-40": {
    "source": "iana"
  },
  "audio/g728": {
    "source": "iana"
  },
  "audio/g729": {
    "source": "iana"
  },
  "audio/g7291": {
    "source": "iana"
  },
  "audio/g729d": {
    "source": "iana"
  },
  "audio/g729e": {
    "source": "iana"
  },
  "audio/gsm": {
    "source": "iana"
  },
  "audio/gsm-efr": {
    "source": "iana"
  },
  "audio/gsm-hr-08": {
    "source": "iana"
  },
  "audio/ilbc": {
    "source": "iana"
  },
  "audio/ip-mr_v2.5": {
    "source": "iana"
  },
  "audio/isac": {
    "source": "apache"
  },
  "audio/l16": {
    "source": "iana"
  },
  "audio/l20": {
    "source": "iana"
  },
  "audio/l24": {
    "source": "iana",
    "compressible": false
  },
  "audio/l8": {
    "source": "iana"
  },
  "audio/lpc": {
    "source": "iana"
  },
  "audio/midi": {
    "source": "apache",
    "extensions": ["mid","midi","kar","rmi"]
  },
  "audio/mobile-xmf": {
    "source": "iana"
  },
  "audio/mp4": {
    "source": "iana",
    "compressible": false,
    "extensions": ["mp4a","m4a"]
  },
  "audio/mp4a-latm": {
    "source": "iana"
  },
  "audio/mpa": {
    "source": "iana"
  },
  "audio/mpa-robust": {
    "source": "iana"
  },
  "audio/mpeg": {
    "source": "iana",
    "compressible": false,
    "extensions": ["mpga","mp2","mp2a","mp3","m2a","m3a"]
  },
  "audio/mpeg4-generic": {
    "source": "iana"
  },
  "audio/musepack": {
    "source": "apache"
  },
  "audio/ogg": {
    "source": "iana",
    "compressible": false,
    "extensions": ["oga","ogg","spx"]
  },
  "audio/opus": {
    "source": "iana"
  },
  "audio/parityfec": {
    "source": "iana"
  },
  "audio/pcma": {
    "source": "iana"
  },
  "audio/pcma-wb": {
    "source": "iana"
  },
  "audio/pcmu": {
    "source": "iana"
  },
  "audio/pcmu-wb": {
    "source": "iana"
  },
  "audio/prs.sid": {
    "source": "iana"
  },
  "audio/qcelp": {
    "source": "iana"
  },
  "audio/raptorfec": {
    "source": "iana"
  },
  "audio/red": {
    "source": "iana"
  },
  "audio/rtp-enc-aescm128": {
    "source": "iana"
  },
  "audio/rtp-midi": {
    "source": "iana"
  },
  "audio/rtploopback": {
    "source": "iana"
  },
  "audio/rtx": {
    "source": "iana"
  },
  "audio/s3m": {
    "source": "apache",
    "extensions": ["s3m"]
  },
  "audio/silk": {
    "source": "apache",
    "extensions": ["sil"]
  },
  "audio/smv": {
    "source": "iana"
  },
  "audio/smv-qcp": {
    "source": "iana"
  },
  "audio/smv0": {
    "source": "iana"
  },
  "audio/sp-midi": {
    "source": "iana"
  },
  "audio/speex": {
    "source": "iana"
  },
  "audio/t140c": {
    "source": "iana"
  },
  "audio/t38": {
    "source": "iana"
  },
  "audio/telephone-event": {
    "source": "iana"
  },
  "audio/tone": {
    "source": "iana"
  },
  "audio/uemclip": {
    "source": "iana"
  },
  "audio/ulpfec": {
    "source": "iana"
  },
  "audio/vdvi": {
    "source": "iana"
  },
  "audio/vmr-wb": {
    "source": "iana"
  },
  "audio/vnd.3gpp.iufp": {
    "source": "iana"
  },
  "audio/vnd.4sb": {
    "source": "iana"
  },
  "audio/vnd.audiokoz": {
    "source": "iana"
  },
  "audio/vnd.celp": {
    "source": "iana"
  },
  "audio/vnd.cisco.nse": {
    "source": "iana"
  },
  "audio/vnd.cmles.radio-events": {
    "source": "iana"
  },
  "audio/vnd.cns.anp1": {
    "source": "iana"
  },
  "audio/vnd.cns.inf1": {
    "source": "iana"
  },
  "audio/vnd.dece.audio": {
    "source": "iana",
    "extensions": ["uva","uvva"]
  },
  "audio/vnd.digital-winds": {
    "source": "iana",
    "extensions": ["eol"]
  },
  "audio/vnd.dlna.adts": {
    "source": "iana"
  },
  "audio/vnd.dolby.heaac.1": {
    "source": "iana"
  },
  "audio/vnd.dolby.heaac.2": {
    "source": "iana"
  },
  "audio/vnd.dolby.mlp": {
    "source": "iana"
  },
  "audio/vnd.dolby.mps": {
    "source": "iana"
  },
  "audio/vnd.dolby.pl2": {
    "source": "iana"
  },
  "audio/vnd.dolby.pl2x": {
    "source": "iana"
  },
  "audio/vnd.dolby.pl2z": {
    "source": "iana"
  },
  "audio/vnd.dolby.pulse.1": {
    "source": "iana"
  },
  "audio/vnd.dra": {
    "source": "iana",
    "extensions": ["dra"]
  },
  "audio/vnd.dts": {
    "source": "iana",
    "extensions": ["dts"]
  },
  "audio/vnd.dts.hd": {
    "source": "iana",
    "extensions": ["dtshd"]
  },
  "audio/vnd.dvb.file": {
    "source": "iana"
  },
  "audio/vnd.everad.plj": {
    "source": "iana"
  },
  "audio/vnd.hns.audio": {
    "source": "iana"
  },
  "audio/vnd.lucent.voice": {
    "source": "iana",
    "extensions": ["lvp"]
  },
  "audio/vnd.ms-playready.media.pya": {
    "source": "iana",
    "extensions": ["pya"]
  },
  "audio/vnd.nokia.mobile-xmf": {
    "source": "iana"
  },
  "audio/vnd.nortel.vbk": {
    "source": "iana"
  },
  "audio/vnd.nuera.ecelp4800": {
    "source": "iana",
    "extensions": ["ecelp4800"]
  },
  "audio/vnd.nuera.ecelp7470": {
    "source": "iana",
    "extensions": ["ecelp7470"]
  },
  "audio/vnd.nuera.ecelp9600": {
    "source": "iana",
    "extensions": ["ecelp9600"]
  },
  "audio/vnd.octel.sbc": {
    "source": "iana"
  },
  "audio/vnd.qcelp": {
    "source": "iana"
  },
  "audio/vnd.rhetorex.32kadpcm": {
    "source": "iana"
  },
  "audio/vnd.rip": {
    "source": "iana",
    "extensions": ["rip"]
  },
  "audio/vnd.rn-realaudio": {
    "compressible": false
  },
  "audio/vnd.sealedmedia.softseal.mpeg": {
    "source": "iana"
  },
  "audio/vnd.vmx.cvsd": {
    "source": "iana"
  },
  "audio/vnd.wave": {
    "compressible": false
  },
  "audio/vorbis": {
    "source": "iana",
    "compressible": false
  },
  "audio/vorbis-config": {
    "source": "iana"
  },
  "audio/wav": {
    "compressible": false,
    "extensions": ["wav"]
  },
  "audio/wave": {
    "compressible": false,
    "extensions": ["wav"]
  },
  "audio/webm": {
    "source": "apache",
    "compressible": false,
    "extensions": ["weba"]
  },
  "audio/x-aac": {
    "source": "apache",
    "compressible": false,
    "extensions": ["aac"]
  },
  "audio/x-aiff": {
    "source": "apache",
    "extensions": ["aif","aiff","aifc"]
  },
  "audio/x-caf": {
    "source": "apache",
    "compressible": false,
    "extensions": ["caf"]
  },
  "audio/x-flac": {
    "source": "apache",
    "extensions": ["flac"]
  },
  "audio/x-m4a": {
    "source": "nginx",
    "extensions": ["m4a"]
  },
  "audio/x-matroska": {
    "source": "apache",
    "extensions": ["mka"]
  },
  "audio/x-mpegurl": {
    "source": "apache",
    "extensions": ["m3u"]
  },
  "audio/x-ms-wax": {
    "source": "apache",
    "extensions": ["wax"]
  },
  "audio/x-ms-wma": {
    "source": "apache",
    "extensions": ["wma"]
  },
  "audio/x-pn-realaudio": {
    "source": "apache",
    "extensions": ["ram","ra"]
  },
  "audio/x-pn-realaudio-plugin": {
    "source": "apache",
    "extensions": ["rmp"]
  },
  "audio/x-realaudio": {
    "source": "nginx",
    "extensions": ["ra"]
  },
  "audio/x-tta": {
    "source": "apache"
  },
  "audio/x-wav": {
    "source": "apache",
    "extensions": ["wav"]
  },
  "audio/xm": {
    "source": "apache",
    "extensions": ["xm"]
  },
  "chemical/x-cdx": {
    "source": "apache",
    "extensions": ["cdx"]
  },
  "chemical/x-cif": {
    "source": "apache",
    "extensions": ["cif"]
  },
  "chemical/x-cmdf": {
    "source": "apache",
    "extensions": ["cmdf"]
  },
  "chemical/x-cml": {
    "source": "apache",
    "extensions": ["cml"]
  },
  "chemical/x-csml": {
    "source": "apache",
    "extensions": ["csml"]
  },
  "chemical/x-pdb": {
    "source": "apache"
  },
  "chemical/x-xyz": {
    "source": "apache",
    "extensions": ["xyz"]
  },
  "font/opentype": {
    "compressible": true,
    "extensions": ["otf"]
  },
  "image/bmp": {
    "source": "apache",
    "compressible": true,
    "extensions": ["bmp"]
  },
  "image/cgm": {
    "source": "iana",
    "extensions": ["cgm"]
  },
  "image/fits": {
    "source": "iana"
  },
  "image/g3fax": {
    "source": "iana",
    "extensions": ["g3"]
  },
  "image/gif": {
    "source": "iana",
    "compressible": false,
    "extensions": ["gif"]
  },
  "image/ief": {
    "source": "iana",
    "extensions": ["ief"]
  },
  "image/jp2": {
    "source": "iana"
  },
  "image/jpeg": {
    "source": "iana",
    "compressible": false,
    "extensions": ["jpeg","jpg","jpe"]
  },
  "image/jpm": {
    "source": "iana"
  },
  "image/jpx": {
    "source": "iana"
  },
  "image/ktx": {
    "source": "iana",
    "extensions": ["ktx"]
  },
  "image/naplps": {
    "source": "iana"
  },
  "image/pjpeg": {
    "compressible": false
  },
  "image/png": {
    "source": "iana",
    "compressible": false,
    "extensions": ["png"]
  },
  "image/prs.btif": {
    "source": "iana",
    "extensions": ["btif"]
  },
  "image/prs.pti": {
    "source": "iana"
  },
  "image/pwg-raster": {
    "source": "iana"
  },
  "image/sgi": {
    "source": "apache",
    "extensions": ["sgi"]
  },
  "image/svg+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["svg","svgz"]
  },
  "image/t38": {
    "source": "iana"
  },
  "image/tiff": {
    "source": "iana",
    "compressible": false,
    "extensions": ["tiff","tif"]
  },
  "image/tiff-fx": {
    "source": "iana"
  },
  "image/vnd.adobe.photoshop": {
    "source": "iana",
    "compressible": true,
    "extensions": ["psd"]
  },
  "image/vnd.airzip.accelerator.azv": {
    "source": "iana"
  },
  "image/vnd.cns.inf2": {
    "source": "iana"
  },
  "image/vnd.dece.graphic": {
    "source": "iana",
    "extensions": ["uvi","uvvi","uvg","uvvg"]
  },
  "image/vnd.djvu": {
    "source": "iana",
    "extensions": ["djvu","djv"]
  },
  "image/vnd.dvb.subtitle": {
    "source": "iana",
    "extensions": ["sub"]
  },
  "image/vnd.dwg": {
    "source": "iana",
    "extensions": ["dwg"]
  },
  "image/vnd.dxf": {
    "source": "iana",
    "extensions": ["dxf"]
  },
  "image/vnd.fastbidsheet": {
    "source": "iana",
    "extensions": ["fbs"]
  },
  "image/vnd.fpx": {
    "source": "iana",
    "extensions": ["fpx"]
  },
  "image/vnd.fst": {
    "source": "iana",
    "extensions": ["fst"]
  },
  "image/vnd.fujixerox.edmics-mmr": {
    "source": "iana",
    "extensions": ["mmr"]
  },
  "image/vnd.fujixerox.edmics-rlc": {
    "source": "iana",
    "extensions": ["rlc"]
  },
  "image/vnd.globalgraphics.pgb": {
    "source": "iana"
  },
  "image/vnd.microsoft.icon": {
    "source": "iana"
  },
  "image/vnd.mix": {
    "source": "iana"
  },
  "image/vnd.mozilla.apng": {
    "source": "iana"
  },
  "image/vnd.ms-modi": {
    "source": "iana",
    "extensions": ["mdi"]
  },
  "image/vnd.ms-photo": {
    "source": "apache",
    "extensions": ["wdp"]
  },
  "image/vnd.net-fpx": {
    "source": "iana",
    "extensions": ["npx"]
  },
  "image/vnd.radiance": {
    "source": "iana"
  },
  "image/vnd.sealed.png": {
    "source": "iana"
  },
  "image/vnd.sealedmedia.softseal.gif": {
    "source": "iana"
  },
  "image/vnd.sealedmedia.softseal.jpg": {
    "source": "iana"
  },
  "image/vnd.svf": {
    "source": "iana"
  },
  "image/vnd.tencent.tap": {
    "source": "iana"
  },
  "image/vnd.valve.source.texture": {
    "source": "iana"
  },
  "image/vnd.wap.wbmp": {
    "source": "iana",
    "extensions": ["wbmp"]
  },
  "image/vnd.xiff": {
    "source": "iana",
    "extensions": ["xif"]
  },
  "image/vnd.zbrush.pcx": {
    "source": "iana"
  },
  "image/webp": {
    "source": "apache",
    "extensions": ["webp"]
  },
  "image/x-3ds": {
    "source": "apache",
    "extensions": ["3ds"]
  },
  "image/x-cmu-raster": {
    "source": "apache",
    "extensions": ["ras"]
  },
  "image/x-cmx": {
    "source": "apache",
    "extensions": ["cmx"]
  },
  "image/x-freehand": {
    "source": "apache",
    "extensions": ["fh","fhc","fh4","fh5","fh7"]
  },
  "image/x-icon": {
    "source": "apache",
    "compressible": true,
    "extensions": ["ico"]
  },
  "image/x-jng": {
    "source": "nginx",
    "extensions": ["jng"]
  },
  "image/x-mrsid-image": {
    "source": "apache",
    "extensions": ["sid"]
  },
  "image/x-ms-bmp": {
    "source": "nginx",
    "compressible": true,
    "extensions": ["bmp"]
  },
  "image/x-pcx": {
    "source": "apache",
    "extensions": ["pcx"]
  },
  "image/x-pict": {
    "source": "apache",
    "extensions": ["pic","pct"]
  },
  "image/x-portable-anymap": {
    "source": "apache",
    "extensions": ["pnm"]
  },
  "image/x-portable-bitmap": {
    "source": "apache",
    "extensions": ["pbm"]
  },
  "image/x-portable-graymap": {
    "source": "apache",
    "extensions": ["pgm"]
  },
  "image/x-portable-pixmap": {
    "source": "apache",
    "extensions": ["ppm"]
  },
  "image/x-rgb": {
    "source": "apache",
    "extensions": ["rgb"]
  },
  "image/x-tga": {
    "source": "apache",
    "extensions": ["tga"]
  },
  "image/x-xbitmap": {
    "source": "apache",
    "extensions": ["xbm"]
  },
  "image/x-xcf": {
    "compressible": false
  },
  "image/x-xpixmap": {
    "source": "apache",
    "extensions": ["xpm"]
  },
  "image/x-xwindowdump": {
    "source": "apache",
    "extensions": ["xwd"]
  },
  "message/cpim": {
    "source": "iana"
  },
  "message/delivery-status": {
    "source": "iana"
  },
  "message/disposition-notification": {
    "source": "iana"
  },
  "message/external-body": {
    "source": "iana"
  },
  "message/feedback-report": {
    "source": "iana"
  },
  "message/global": {
    "source": "iana"
  },
  "message/global-delivery-status": {
    "source": "iana"
  },
  "message/global-disposition-notification": {
    "source": "iana"
  },
  "message/global-headers": {
    "source": "iana"
  },
  "message/http": {
    "source": "iana",
    "compressible": false
  },
  "message/imdn+xml": {
    "source": "iana",
    "compressible": true
  },
  "message/news": {
    "source": "iana"
  },
  "message/partial": {
    "source": "iana",
    "compressible": false
  },
  "message/rfc822": {
    "source": "iana",
    "compressible": true,
    "extensions": ["eml","mime"]
  },
  "message/s-http": {
    "source": "iana"
  },
  "message/sip": {
    "source": "iana"
  },
  "message/sipfrag": {
    "source": "iana"
  },
  "message/tracking-status": {
    "source": "iana"
  },
  "message/vnd.si.simp": {
    "source": "iana"
  },
  "message/vnd.wfa.wsc": {
    "source": "iana"
  },
  "model/iges": {
    "source": "iana",
    "compressible": false,
    "extensions": ["igs","iges"]
  },
  "model/mesh": {
    "source": "iana",
    "compressible": false,
    "extensions": ["msh","mesh","silo"]
  },
  "model/vnd.collada+xml": {
    "source": "iana",
    "extensions": ["dae"]
  },
  "model/vnd.dwf": {
    "source": "iana",
    "extensions": ["dwf"]
  },
  "model/vnd.flatland.3dml": {
    "source": "iana"
  },
  "model/vnd.gdl": {
    "source": "iana",
    "extensions": ["gdl"]
  },
  "model/vnd.gs-gdl": {
    "source": "apache"
  },
  "model/vnd.gs.gdl": {
    "source": "iana"
  },
  "model/vnd.gtw": {
    "source": "iana",
    "extensions": ["gtw"]
  },
  "model/vnd.moml+xml": {
    "source": "iana"
  },
  "model/vnd.mts": {
    "source": "iana",
    "extensions": ["mts"]
  },
  "model/vnd.opengex": {
    "source": "iana"
  },
  "model/vnd.parasolid.transmit.binary": {
    "source": "iana"
  },
  "model/vnd.parasolid.transmit.text": {
    "source": "iana"
  },
  "model/vnd.valve.source.compiled-map": {
    "source": "iana"
  },
  "model/vnd.vtu": {
    "source": "iana",
    "extensions": ["vtu"]
  },
  "model/vrml": {
    "source": "iana",
    "compressible": false,
    "extensions": ["wrl","vrml"]
  },
  "model/x3d+binary": {
    "source": "apache",
    "compressible": false,
    "extensions": ["x3db","x3dbz"]
  },
  "model/x3d+fastinfoset": {
    "source": "iana"
  },
  "model/x3d+vrml": {
    "source": "apache",
    "compressible": false,
    "extensions": ["x3dv","x3dvz"]
  },
  "model/x3d+xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["x3d","x3dz"]
  },
  "model/x3d-vrml": {
    "source": "iana"
  },
  "multipart/alternative": {
    "source": "iana",
    "compressible": false
  },
  "multipart/appledouble": {
    "source": "iana"
  },
  "multipart/byteranges": {
    "source": "iana"
  },
  "multipart/digest": {
    "source": "iana"
  },
  "multipart/encrypted": {
    "source": "iana",
    "compressible": false
  },
  "multipart/form-data": {
    "source": "iana",
    "compressible": false
  },
  "multipart/header-set": {
    "source": "iana"
  },
  "multipart/mixed": {
    "source": "iana",
    "compressible": false
  },
  "multipart/parallel": {
    "source": "iana"
  },
  "multipart/related": {
    "source": "iana",
    "compressible": false
  },
  "multipart/report": {
    "source": "iana"
  },
  "multipart/signed": {
    "source": "iana",
    "compressible": false
  },
  "multipart/voice-message": {
    "source": "iana"
  },
  "multipart/x-mixed-replace": {
    "source": "iana"
  },
  "text/1d-interleaved-parityfec": {
    "source": "iana"
  },
  "text/cache-manifest": {
    "source": "iana",
    "compressible": true,
    "extensions": ["appcache","manifest"]
  },
  "text/calendar": {
    "source": "iana",
    "extensions": ["ics","ifb"]
  },
  "text/calender": {
    "compressible": true
  },
  "text/cmd": {
    "compressible": true
  },
  "text/coffeescript": {
    "extensions": ["coffee","litcoffee"]
  },
  "text/css": {
    "source": "iana",
    "compressible": true,
    "extensions": ["css"]
  },
  "text/csv": {
    "source": "iana",
    "compressible": true,
    "extensions": ["csv"]
  },
  "text/csv-schema": {
    "source": "iana"
  },
  "text/directory": {
    "source": "iana"
  },
  "text/dns": {
    "source": "iana"
  },
  "text/ecmascript": {
    "source": "iana"
  },
  "text/encaprtp": {
    "source": "iana"
  },
  "text/enriched": {
    "source": "iana"
  },
  "text/fwdred": {
    "source": "iana"
  },
  "text/grammar-ref-list": {
    "source": "iana"
  },
  "text/hjson": {
    "extensions": ["hjson"]
  },
  "text/html": {
    "source": "iana",
    "compressible": true,
    "extensions": ["html","htm","shtml"]
  },
  "text/jade": {
    "extensions": ["jade"]
  },
  "text/javascript": {
    "source": "iana",
    "compressible": true
  },
  "text/jcr-cnd": {
    "source": "iana"
  },
  "text/jsx": {
    "compressible": true,
    "extensions": ["jsx"]
  },
  "text/less": {
    "extensions": ["less"]
  },
  "text/markdown": {
    "source": "iana"
  },
  "text/mathml": {
    "source": "nginx",
    "extensions": ["mml"]
  },
  "text/mizar": {
    "source": "iana"
  },
  "text/n3": {
    "source": "iana",
    "compressible": true,
    "extensions": ["n3"]
  },
  "text/parameters": {
    "source": "iana"
  },
  "text/parityfec": {
    "source": "iana"
  },
  "text/plain": {
    "source": "iana",
    "compressible": true,
    "extensions": ["txt","text","conf","def","list","log","in","ini"]
  },
  "text/provenance-notation": {
    "source": "iana"
  },
  "text/prs.fallenstein.rst": {
    "source": "iana"
  },
  "text/prs.lines.tag": {
    "source": "iana",
    "extensions": ["dsc"]
  },
  "text/raptorfec": {
    "source": "iana"
  },
  "text/red": {
    "source": "iana"
  },
  "text/rfc822-headers": {
    "source": "iana"
  },
  "text/richtext": {
    "source": "iana",
    "compressible": true,
    "extensions": ["rtx"]
  },
  "text/rtf": {
    "source": "iana",
    "compressible": true,
    "extensions": ["rtf"]
  },
  "text/rtp-enc-aescm128": {
    "source": "iana"
  },
  "text/rtploopback": {
    "source": "iana"
  },
  "text/rtx": {
    "source": "iana"
  },
  "text/sgml": {
    "source": "iana",
    "extensions": ["sgml","sgm"]
  },
  "text/stylus": {
    "extensions": ["stylus","styl"]
  },
  "text/t140": {
    "source": "iana"
  },
  "text/tab-separated-values": {
    "source": "iana",
    "compressible": true,
    "extensions": ["tsv"]
  },
  "text/troff": {
    "source": "iana",
    "extensions": ["t","tr","roff","man","me","ms"]
  },
  "text/turtle": {
    "source": "iana",
    "extensions": ["ttl"]
  },
  "text/ulpfec": {
    "source": "iana"
  },
  "text/uri-list": {
    "source": "iana",
    "compressible": true,
    "extensions": ["uri","uris","urls"]
  },
  "text/vcard": {
    "source": "iana",
    "compressible": true,
    "extensions": ["vcard"]
  },
  "text/vnd.a": {
    "source": "iana"
  },
  "text/vnd.abc": {
    "source": "iana"
  },
  "text/vnd.curl": {
    "source": "iana",
    "extensions": ["curl"]
  },
  "text/vnd.curl.dcurl": {
    "source": "apache",
    "extensions": ["dcurl"]
  },
  "text/vnd.curl.mcurl": {
    "source": "apache",
    "extensions": ["mcurl"]
  },
  "text/vnd.curl.scurl": {
    "source": "apache",
    "extensions": ["scurl"]
  },
  "text/vnd.debian.copyright": {
    "source": "iana"
  },
  "text/vnd.dmclientscript": {
    "source": "iana"
  },
  "text/vnd.dvb.subtitle": {
    "source": "iana",
    "extensions": ["sub"]
  },
  "text/vnd.esmertec.theme-descriptor": {
    "source": "iana"
  },
  "text/vnd.fly": {
    "source": "iana",
    "extensions": ["fly"]
  },
  "text/vnd.fmi.flexstor": {
    "source": "iana",
    "extensions": ["flx"]
  },
  "text/vnd.graphviz": {
    "source": "iana",
    "extensions": ["gv"]
  },
  "text/vnd.in3d.3dml": {
    "source": "iana",
    "extensions": ["3dml"]
  },
  "text/vnd.in3d.spot": {
    "source": "iana",
    "extensions": ["spot"]
  },
  "text/vnd.iptc.newsml": {
    "source": "iana"
  },
  "text/vnd.iptc.nitf": {
    "source": "iana"
  },
  "text/vnd.latex-z": {
    "source": "iana"
  },
  "text/vnd.motorola.reflex": {
    "source": "iana"
  },
  "text/vnd.ms-mediapackage": {
    "source": "iana"
  },
  "text/vnd.net2phone.commcenter.command": {
    "source": "iana"
  },
  "text/vnd.radisys.msml-basic-layout": {
    "source": "iana"
  },
  "text/vnd.si.uricatalogue": {
    "source": "iana"
  },
  "text/vnd.sun.j2me.app-descriptor": {
    "source": "iana",
    "extensions": ["jad"]
  },
  "text/vnd.trolltech.linguist": {
    "source": "iana"
  },
  "text/vnd.wap.si": {
    "source": "iana"
  },
  "text/vnd.wap.sl": {
    "source": "iana"
  },
  "text/vnd.wap.wml": {
    "source": "iana",
    "extensions": ["wml"]
  },
  "text/vnd.wap.wmlscript": {
    "source": "iana",
    "extensions": ["wmls"]
  },
  "text/vtt": {
    "charset": "UTF-8",
    "compressible": true,
    "extensions": ["vtt"]
  },
  "text/x-asm": {
    "source": "apache",
    "extensions": ["s","asm"]
  },
  "text/x-c": {
    "source": "apache",
    "extensions": ["c","cc","cxx","cpp","h","hh","dic"]
  },
  "text/x-component": {
    "source": "nginx",
    "extensions": ["htc"]
  },
  "text/x-fortran": {
    "source": "apache",
    "extensions": ["f","for","f77","f90"]
  },
  "text/x-gwt-rpc": {
    "compressible": true
  },
  "text/x-handlebars-template": {
    "extensions": ["hbs"]
  },
  "text/x-java-source": {
    "source": "apache",
    "extensions": ["java"]
  },
  "text/x-jquery-tmpl": {
    "compressible": true
  },
  "text/x-lua": {
    "extensions": ["lua"]
  },
  "text/x-markdown": {
    "compressible": true,
    "extensions": ["markdown","md","mkd"]
  },
  "text/x-nfo": {
    "source": "apache",
    "extensions": ["nfo"]
  },
  "text/x-opml": {
    "source": "apache",
    "extensions": ["opml"]
  },
  "text/x-pascal": {
    "source": "apache",
    "extensions": ["p","pas"]
  },
  "text/x-processing": {
    "compressible": true,
    "extensions": ["pde"]
  },
  "text/x-sass": {
    "extensions": ["sass"]
  },
  "text/x-scss": {
    "extensions": ["scss"]
  },
  "text/x-setext": {
    "source": "apache",
    "extensions": ["etx"]
  },
  "text/x-sfv": {
    "source": "apache",
    "extensions": ["sfv"]
  },
  "text/x-uuencode": {
    "source": "apache",
    "extensions": ["uu"]
  },
  "text/x-vcalendar": {
    "source": "apache",
    "extensions": ["vcs"]
  },
  "text/x-vcard": {
    "source": "apache",
    "extensions": ["vcf"]
  },
  "text/xml": {
    "source": "iana",
    "compressible": true,
    "extensions": ["xml"]
  },
  "text/xml-external-parsed-entity": {
    "source": "iana"
  },
  "text/yaml": {
    "extensions": ["yaml","yml"]
  },
  "video/1d-interleaved-parityfec": {
    "source": "apache"
  },
  "video/3gpp": {
    "source": "apache",
    "extensions": ["3gp","3gpp"]
  },
  "video/3gpp-tt": {
    "source": "apache"
  },
  "video/3gpp2": {
    "source": "apache",
    "extensions": ["3g2"]
  },
  "video/bmpeg": {
    "source": "apache"
  },
  "video/bt656": {
    "source": "apache"
  },
  "video/celb": {
    "source": "apache"
  },
  "video/dv": {
    "source": "apache"
  },
  "video/h261": {
    "source": "apache",
    "extensions": ["h261"]
  },
  "video/h263": {
    "source": "apache",
    "extensions": ["h263"]
  },
  "video/h263-1998": {
    "source": "apache"
  },
  "video/h263-2000": {
    "source": "apache"
  },
  "video/h264": {
    "source": "apache",
    "extensions": ["h264"]
  },
  "video/h264-rcdo": {
    "source": "apache"
  },
  "video/h264-svc": {
    "source": "apache"
  },
  "video/jpeg": {
    "source": "apache",
    "extensions": ["jpgv"]
  },
  "video/jpeg2000": {
    "source": "apache"
  },
  "video/jpm": {
    "source": "apache",
    "extensions": ["jpm","jpgm"]
  },
  "video/mj2": {
    "source": "apache",
    "extensions": ["mj2","mjp2"]
  },
  "video/mp1s": {
    "source": "apache"
  },
  "video/mp2p": {
    "source": "apache"
  },
  "video/mp2t": {
    "source": "apache",
    "extensions": ["ts"]
  },
  "video/mp4": {
    "source": "apache",
    "compressible": false,
    "extensions": ["mp4","mp4v","mpg4"]
  },
  "video/mp4v-es": {
    "source": "apache"
  },
  "video/mpeg": {
    "source": "apache",
    "compressible": false,
    "extensions": ["mpeg","mpg","mpe","m1v","m2v"]
  },
  "video/mpeg4-generic": {
    "source": "apache"
  },
  "video/mpv": {
    "source": "apache"
  },
  "video/nv": {
    "source": "apache"
  },
  "video/ogg": {
    "source": "apache",
    "compressible": false,
    "extensions": ["ogv"]
  },
  "video/parityfec": {
    "source": "apache"
  },
  "video/pointer": {
    "source": "apache"
  },
  "video/quicktime": {
    "source": "apache",
    "compressible": false,
    "extensions": ["qt","mov"]
  },
  "video/raw": {
    "source": "apache"
  },
  "video/rtp-enc-aescm128": {
    "source": "apache"
  },
  "video/rtx": {
    "source": "apache"
  },
  "video/smpte292m": {
    "source": "apache"
  },
  "video/ulpfec": {
    "source": "apache"
  },
  "video/vc1": {
    "source": "apache"
  },
  "video/vnd.cctv": {
    "source": "apache"
  },
  "video/vnd.dece.hd": {
    "source": "apache",
    "extensions": ["uvh","uvvh"]
  },
  "video/vnd.dece.mobile": {
    "source": "apache",
    "extensions": ["uvm","uvvm"]
  },
  "video/vnd.dece.mp4": {
    "source": "apache"
  },
  "video/vnd.dece.pd": {
    "source": "apache",
    "extensions": ["uvp","uvvp"]
  },
  "video/vnd.dece.sd": {
    "source": "apache",
    "extensions": ["uvs","uvvs"]
  },
  "video/vnd.dece.video": {
    "source": "apache",
    "extensions": ["uvv","uvvv"]
  },
  "video/vnd.directv.mpeg": {
    "source": "apache"
  },
  "video/vnd.directv.mpeg-tts": {
    "source": "apache"
  },
  "video/vnd.dlna.mpeg-tts": {
    "source": "apache"
  },
  "video/vnd.dvb.file": {
    "source": "apache",
    "extensions": ["dvb"]
  },
  "video/vnd.fvt": {
    "source": "apache",
    "extensions": ["fvt"]
  },
  "video/vnd.hns.video": {
    "source": "apache"
  },
  "video/vnd.iptvforum.1dparityfec-1010": {
    "source": "apache"
  },
  "video/vnd.iptvforum.1dparityfec-2005": {
    "source": "apache"
  },
  "video/vnd.iptvforum.2dparityfec-1010": {
    "source": "apache"
  },
  "video/vnd.iptvforum.2dparityfec-2005": {
    "source": "apache"
  },
  "video/vnd.iptvforum.ttsavc": {
    "source": "apache"
  },
  "video/vnd.iptvforum.ttsmpeg2": {
    "source": "apache"
  },
  "video/vnd.motorola.video": {
    "source": "apache"
  },
  "video/vnd.motorola.videop": {
    "source": "apache"
  },
  "video/vnd.mpegurl": {
    "source": "apache",
    "extensions": ["mxu","m4u"]
  },
  "video/vnd.ms-playready.media.pyv": {
    "source": "apache",
    "extensions": ["pyv"]
  },
  "video/vnd.nokia.interleaved-multimedia": {
    "source": "apache"
  },
  "video/vnd.nokia.videovoip": {
    "source": "apache"
  },
  "video/vnd.objectvideo": {
    "source": "apache"
  },
  "video/vnd.sealed.mpeg1": {
    "source": "apache"
  },
  "video/vnd.sealed.mpeg4": {
    "source": "apache"
  },
  "video/vnd.sealed.swf": {
    "source": "apache"
  },
  "video/vnd.sealedmedia.softseal.mov": {
    "source": "apache"
  },
  "video/vnd.uvvu.mp4": {
    "source": "apache",
    "extensions": ["uvu","uvvu"]
  },
  "video/vnd.vivo": {
    "source": "apache",
    "extensions": ["viv"]
  },
  "video/webm": {
    "source": "apache",
    "compressible": false,
    "extensions": ["webm"]
  },
  "video/x-f4v": {
    "source": "apache",
    "extensions": ["f4v"]
  },
  "video/x-fli": {
    "source": "apache",
    "extensions": ["fli"]
  },
  "video/x-flv": {
    "source": "apache",
    "compressible": false,
    "extensions": ["flv"]
  },
  "video/x-m4v": {
    "source": "apache",
    "extensions": ["m4v"]
  },
  "video/x-matroska": {
    "source": "apache",
    "compressible": false,
    "extensions": ["mkv","mk3d","mks"]
  },
  "video/x-mng": {
    "source": "apache",
    "extensions": ["mng"]
  },
  "video/x-ms-asf": {
    "source": "apache",
    "extensions": ["asf","asx"]
  },
  "video/x-ms-vob": {
    "source": "apache",
    "extensions": ["vob"]
  },
  "video/x-ms-wm": {
    "source": "apache",
    "extensions": ["wm"]
  },
  "video/x-ms-wmv": {
    "source": "apache",
    "compressible": false,
    "extensions": ["wmv"]
  },
  "video/x-ms-wmx": {
    "source": "apache",
    "extensions": ["wmx"]
  },
  "video/x-ms-wvx": {
    "source": "apache",
    "extensions": ["wvx"]
  },
  "video/x-msvideo": {
    "source": "apache",
    "extensions": ["avi"]
  },
  "video/x-sgi-movie": {
    "source": "apache",
    "extensions": ["movie"]
  },
  "video/x-smv": {
    "source": "apache",
    "extensions": ["smv"]
  },
  "x-conference/x-cooltalk": {
    "source": "apache",
    "extensions": ["ice"]
  },
  "x-shader/x-fragment": {
    "compressible": true
  },
  "x-shader/x-vertex": {
    "compressible": true
  }
}
;

return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/index.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/index.js"]};
var require = getModule.bind(null, {"./db.json":"../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/db.json"});
var exports = module.exports;

/*!
 * mime-db
 * Copyright(c) 2014 Jonathan Ong
 * MIT Licensed
 */

/**
 * Module exports.
 */

module.exports = require('./db.json')


return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/mime-types/index.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/mime-types/index.js"]};
var require = getModule.bind(null, {"mime-db":"../networking/node_modules/form-data/node_modules/mime-types/node_modules/mime-db/index.js"});
var exports = module.exports;

/*!
 * mime-types
 * Copyright(c) 2014 Jonathan Ong
 * Copyright(c) 2015 Douglas Christopher Wilson
 * MIT Licensed
 */

'use strict'

/**
 * Module dependencies.
 * @private
 */

var db = require('mime-db')
var extname = require('path').extname

/**
 * Module variables.
 * @private
 */

var extractTypeRegExp = /^\s*([^;\s]*)(?:;|\s|$)/
var textTypeRegExp = /^text\//i

/**
 * Module exports.
 * @public
 */

exports.charset = charset
exports.charsets = { lookup: charset }
exports.contentType = contentType
exports.extension = extension
exports.extensions = Object.create(null)
exports.lookup = lookup
exports.types = Object.create(null)

// Populate the extensions/types maps
populateMaps(exports.extensions, exports.types)

/**
 * Get the default charset for a MIME type.
 *
 * @param {string} type
 * @return {boolean|string}
 */

function charset(type) {
  if (!type || typeof type !== 'string') {
    return false
  }

  // TODO: use media-typer
  var match = extractTypeRegExp.exec(type)
  var mime = match && db[match[1].toLowerCase()]

  if (mime && mime.charset) {
    return mime.charset
  }

  // default text/* to utf-8
  if (match && textTypeRegExp.test(match[1])) {
    return 'UTF-8'
  }

  return false
}

/**
 * Create a full Content-Type header given a MIME type or extension.
 *
 * @param {string} str
 * @return {boolean|string}
 */

function contentType(str) {
  // TODO: should this even be in this module?
  if (!str || typeof str !== 'string') {
    return false
  }

  var mime = str.indexOf('/') === -1
    ? exports.lookup(str)
    : str

  if (!mime) {
    return false
  }

  // TODO: use content-type or other module
  if (mime.indexOf('charset') === -1) {
    var charset = exports.charset(mime)
    if (charset) mime += '; charset=' + charset.toLowerCase()
  }

  return mime
}

/**
 * Get the default extension for a MIME type.
 *
 * @param {string} type
 * @return {boolean|string}
 */

function extension(type) {
  if (!type || typeof type !== 'string') {
    return false
  }

  // TODO: use media-typer
  var match = extractTypeRegExp.exec(type)

  // get extensions
  var exts = match && exports.extensions[match[1].toLowerCase()]

  if (!exts || !exts.length) {
    return false
  }

  return exts[0]
}

/**
 * Lookup the MIME type for a file path/extension.
 *
 * @param {string} path
 * @return {boolean|string}
 */

function lookup(path) {
  if (!path || typeof path !== 'string') {
    return false
  }

  // get the extension ("ext" or ".ext" or full path)
  var extension = extname('x.' + path)
    .toLowerCase()
    .substr(1)

  if (!extension) {
    return false
  }

  return exports.types[extension] || false
}

/**
 * Populate the extensions and types maps.
 * @private
 */

function populateMaps(extensions, types) {
  // source preference (least -> most)
  var preference = ['nginx', 'apache', undefined, 'iana']

  Object.keys(db).forEach(function forEachMimeType(type) {
    var mime = db[type]
    var exts = mime.extensions

    if (!exts || !exts.length) {
      return
    }

    // mime -> extensions
    extensions[type] = exts

    // extension -> mime
    for (var i = 0; i < exts.length; i++) {
      var extension = exts[i]

      if (types[extension]) {
        var from = preference.indexOf(db[types[extension]].source)
        var to = preference.indexOf(mime.source)

        if (types[extension] !== 'application/octet-stream'
          && from > to || (from === to && types[extension].substr(0, 12) === 'application/')) {
          // skip the remapping
          continue
        }
      }

      // set the extension -> mime
      types[extension] = type
    }
  })
}


return module.exports;
})();modules['../networking/node_modules/form-data/node_modules/async/lib/async.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/node_modules/async/lib/async.js"]};
var require = getModule.bind(null, {});
var exports = module.exports;

/*!
 * async
 * https://github.com/caolan/async
 *
 * Copyright 2010-2014 Caolan McMahon
 * Released under the MIT license
 */
(function () {

    var async = {};
    function noop() {}
    function identity(v) {
        return v;
    }
    function toBool(v) {
        return !!v;
    }
    function notId(v) {
        return !v;
    }

    // global on the server, window in the browser
    var previous_async;

    // Establish the root object, `window` (`self`) in the browser, `global`
    // on the server, or `this` in some virtual machines. We use `self`
    // instead of `window` for `WebWorker` support.
    var root = typeof self === 'object' && self.self === self && self ||
            typeof global === 'object' && global.global === global && global ||
            this;

    if (root != null) {
        previous_async = root.async;
    }

    async.noConflict = function () {
        root.async = previous_async;
        return async;
    };

    function only_once(fn) {
        return function() {
            if (fn === null) throw new Error("Callback was already called.");
            fn.apply(this, arguments);
            fn = null;
        };
    }

    function _once(fn) {
        return function() {
            if (fn === null) return;
            fn.apply(this, arguments);
            fn = null;
        };
    }

    //// cross-browser compatiblity functions ////

    var _toString = Object.prototype.toString;

    var _isArray = Array.isArray || function (obj) {
        return _toString.call(obj) === '[object Array]';
    };

    // Ported from underscore.js isObject
    var _isObject = function(obj) {
        var type = typeof obj;
        return type === 'function' || type === 'object' && !!obj;
    };

    function _isArrayLike(arr) {
        return _isArray(arr) || (
            // has a positive integer length property
            typeof arr.length === "number" &&
            arr.length >= 0 &&
            arr.length % 1 === 0
        );
    }

    function _arrayEach(arr, iterator) {
        var index = -1,
            length = arr.length;

        while (++index < length) {
            iterator(arr[index], index, arr);
        }
    }

    function _map(arr, iterator) {
        var index = -1,
            length = arr.length,
            result = Array(length);

        while (++index < length) {
            result[index] = iterator(arr[index], index, arr);
        }
        return result;
    }

    function _range(count) {
        return _map(Array(count), function (v, i) { return i; });
    }

    function _reduce(arr, iterator, memo) {
        _arrayEach(arr, function (x, i, a) {
            memo = iterator(memo, x, i, a);
        });
        return memo;
    }

    function _forEachOf(object, iterator) {
        _arrayEach(_keys(object), function (key) {
            iterator(object[key], key);
        });
    }

    function _indexOf(arr, item) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] === item) return i;
        }
        return -1;
    }

    var _keys = Object.keys || function (obj) {
        var keys = [];
        for (var k in obj) {
            if (obj.hasOwnProperty(k)) {
                keys.push(k);
            }
        }
        return keys;
    };

    function _keyIterator(coll) {
        var i = -1;
        var len;
        var keys;
        if (_isArrayLike(coll)) {
            len = coll.length;
            return function next() {
                i++;
                return i < len ? i : null;
            };
        } else {
            keys = _keys(coll);
            len = keys.length;
            return function next() {
                i++;
                return i < len ? keys[i] : null;
            };
        }
    }

    // Similar to ES6's rest param (http://ariya.ofilabs.com/2013/03/es6-and-rest-parameter.html)
    // This accumulates the arguments passed into an array, after a given index.
    // From underscore.js (https://github.com/jashkenas/underscore/pull/2140).
    function _restParam(func, startIndex) {
        startIndex = startIndex == null ? func.length - 1 : +startIndex;
        return function() {
            var length = Math.max(arguments.length - startIndex, 0);
            var rest = Array(length);
            for (var index = 0; index < length; index++) {
                rest[index] = arguments[index + startIndex];
            }
            switch (startIndex) {
                case 0: return func.call(this, rest);
                case 1: return func.call(this, arguments[0], rest);
            }
            // Currently unused but handle cases outside of the switch statement:
            // var args = Array(startIndex + 1);
            // for (index = 0; index < startIndex; index++) {
            //     args[index] = arguments[index];
            // }
            // args[startIndex] = rest;
            // return func.apply(this, args);
        };
    }

    function _withoutIndex(iterator) {
        return function (value, index, callback) {
            return iterator(value, callback);
        };
    }

    //// exported async module functions ////

    //// nextTick implementation with browser-compatible fallback ////

    // capture the global reference to guard against fakeTimer mocks
    var _setImmediate = typeof setImmediate === 'function' && setImmediate;

    var _delay = _setImmediate ? function(fn) {
        // not a direct alias for IE10 compatibility
        _setImmediate(fn);
    } : function(fn) {
        setTimeout(fn, 0);
    };

    if (typeof process === 'object' && typeof process.nextTick === 'function') {
        async.nextTick = process.nextTick;
    } else {
        async.nextTick = _delay;
    }
    async.setImmediate = _setImmediate ? _delay : async.nextTick;


    async.forEach =
    async.each = function (arr, iterator, callback) {
        return async.eachOf(arr, _withoutIndex(iterator), callback);
    };

    async.forEachSeries =
    async.eachSeries = function (arr, iterator, callback) {
        return async.eachOfSeries(arr, _withoutIndex(iterator), callback);
    };


    async.forEachLimit =
    async.eachLimit = function (arr, limit, iterator, callback) {
        return _eachOfLimit(limit)(arr, _withoutIndex(iterator), callback);
    };

    async.forEachOf =
    async.eachOf = function (object, iterator, callback) {
        callback = _once(callback || noop);
        object = object || [];

        var iter = _keyIterator(object);
        var key, completed = 0;

        while ((key = iter()) != null) {
            completed += 1;
            iterator(object[key], key, only_once(done));
        }

        if (completed === 0) callback(null);

        function done(err) {
            completed--;
            if (err) {
                callback(err);
            }
            // Check key is null in case iterator isn't exhausted
            // and done resolved synchronously.
            else if (key === null && completed <= 0) {
                callback(null);
            }
        }
    };

    async.forEachOfSeries =
    async.eachOfSeries = function (obj, iterator, callback) {
        callback = _once(callback || noop);
        obj = obj || [];
        var nextKey = _keyIterator(obj);
        var key = nextKey();
        function iterate() {
            var sync = true;
            if (key === null) {
                return callback(null);
            }
            iterator(obj[key], key, only_once(function (err) {
                if (err) {
                    callback(err);
                }
                else {
                    key = nextKey();
                    if (key === null) {
                        return callback(null);
                    } else {
                        if (sync) {
                            async.setImmediate(iterate);
                        } else {
                            iterate();
                        }
                    }
                }
            }));
            sync = false;
        }
        iterate();
    };



    async.forEachOfLimit =
    async.eachOfLimit = function (obj, limit, iterator, callback) {
        _eachOfLimit(limit)(obj, iterator, callback);
    };

    function _eachOfLimit(limit) {

        return function (obj, iterator, callback) {
            callback = _once(callback || noop);
            obj = obj || [];
            var nextKey = _keyIterator(obj);
            if (limit <= 0) {
                return callback(null);
            }
            var done = false;
            var running = 0;
            var errored = false;

            (function replenish () {
                if (done && running <= 0) {
                    return callback(null);
                }

                while (running < limit && !errored) {
                    var key = nextKey();
                    if (key === null) {
                        done = true;
                        if (running <= 0) {
                            callback(null);
                        }
                        return;
                    }
                    running += 1;
                    iterator(obj[key], key, only_once(function (err) {
                        running -= 1;
                        if (err) {
                            callback(err);
                            errored = true;
                        }
                        else {
                            replenish();
                        }
                    }));
                }
            })();
        };
    }


    function doParallel(fn) {
        return function (obj, iterator, callback) {
            return fn(async.eachOf, obj, iterator, callback);
        };
    }
    function doParallelLimit(fn) {
        return function (obj, limit, iterator, callback) {
            return fn(_eachOfLimit(limit), obj, iterator, callback);
        };
    }
    function doSeries(fn) {
        return function (obj, iterator, callback) {
            return fn(async.eachOfSeries, obj, iterator, callback);
        };
    }

    function _asyncMap(eachfn, arr, iterator, callback) {
        callback = _once(callback || noop);
        arr = arr || [];
        var results = _isArrayLike(arr) ? [] : {};
        eachfn(arr, function (value, index, callback) {
            iterator(value, function (err, v) {
                results[index] = v;
                callback(err);
            });
        }, function (err) {
            callback(err, results);
        });
    }

    async.map = doParallel(_asyncMap);
    async.mapSeries = doSeries(_asyncMap);
    async.mapLimit = doParallelLimit(_asyncMap);

    // reduce only has a series version, as doing reduce in parallel won't
    // work in many situations.
    async.inject =
    async.foldl =
    async.reduce = function (arr, memo, iterator, callback) {
        async.eachOfSeries(arr, function (x, i, callback) {
            iterator(memo, x, function (err, v) {
                memo = v;
                callback(err);
            });
        }, function (err) {
            callback(err, memo);
        });
    };

    async.foldr =
    async.reduceRight = function (arr, memo, iterator, callback) {
        var reversed = _map(arr, identity).reverse();
        async.reduce(reversed, memo, iterator, callback);
    };

    async.transform = function (arr, memo, iterator, callback) {
        if (arguments.length === 3) {
            callback = iterator;
            iterator = memo;
            memo = _isArray(arr) ? [] : {};
        }

        async.eachOf(arr, function(v, k, cb) {
            iterator(memo, v, k, cb);
        }, function(err) {
            callback(err, memo);
        });
    };

    function _filter(eachfn, arr, iterator, callback) {
        var results = [];
        eachfn(arr, function (x, index, callback) {
            iterator(x, function (v) {
                if (v) {
                    results.push({index: index, value: x});
                }
                callback();
            });
        }, function () {
            callback(_map(results.sort(function (a, b) {
                return a.index - b.index;
            }), function (x) {
                return x.value;
            }));
        });
    }

    async.select =
    async.filter = doParallel(_filter);

    async.selectLimit =
    async.filterLimit = doParallelLimit(_filter);

    async.selectSeries =
    async.filterSeries = doSeries(_filter);

    function _reject(eachfn, arr, iterator, callback) {
        _filter(eachfn, arr, function(value, cb) {
            iterator(value, function(v) {
                cb(!v);
            });
        }, callback);
    }
    async.reject = doParallel(_reject);
    async.rejectLimit = doParallelLimit(_reject);
    async.rejectSeries = doSeries(_reject);

    function _createTester(eachfn, check, getResult) {
        return function(arr, limit, iterator, cb) {
            function done() {
                if (cb) cb(getResult(false, void 0));
            }
            function iteratee(x, _, callback) {
                if (!cb) return callback();
                iterator(x, function (v) {
                    if (cb && check(v)) {
                        cb(getResult(true, x));
                        cb = iterator = false;
                    }
                    callback();
                });
            }
            if (arguments.length > 3) {
                eachfn(arr, limit, iteratee, done);
            } else {
                cb = iterator;
                iterator = limit;
                eachfn(arr, iteratee, done);
            }
        };
    }

    async.any =
    async.some = _createTester(async.eachOf, toBool, identity);

    async.someLimit = _createTester(async.eachOfLimit, toBool, identity);

    async.all =
    async.every = _createTester(async.eachOf, notId, notId);

    async.everyLimit = _createTester(async.eachOfLimit, notId, notId);

    function _findGetResult(v, x) {
        return x;
    }
    async.detect = _createTester(async.eachOf, identity, _findGetResult);
    async.detectSeries = _createTester(async.eachOfSeries, identity, _findGetResult);
    async.detectLimit = _createTester(async.eachOfLimit, identity, _findGetResult);

    async.sortBy = function (arr, iterator, callback) {
        async.map(arr, function (x, callback) {
            iterator(x, function (err, criteria) {
                if (err) {
                    callback(err);
                }
                else {
                    callback(null, {value: x, criteria: criteria});
                }
            });
        }, function (err, results) {
            if (err) {
                return callback(err);
            }
            else {
                callback(null, _map(results.sort(comparator), function (x) {
                    return x.value;
                }));
            }

        });

        function comparator(left, right) {
            var a = left.criteria, b = right.criteria;
            return a < b ? -1 : a > b ? 1 : 0;
        }
    };

    async.auto = function (tasks, concurrency, callback) {
        if (!callback) {
            // concurrency is optional, shift the args.
            callback = concurrency;
            concurrency = null;
        }
        callback = _once(callback || noop);
        var keys = _keys(tasks);
        var remainingTasks = keys.length;
        if (!remainingTasks) {
            return callback(null);
        }
        if (!concurrency) {
            concurrency = remainingTasks;
        }

        var results = {};
        var runningTasks = 0;

        var listeners = [];
        function addListener(fn) {
            listeners.unshift(fn);
        }
        function removeListener(fn) {
            var idx = _indexOf(listeners, fn);
            if (idx >= 0) listeners.splice(idx, 1);
        }
        function taskComplete() {
            remainingTasks--;
            _arrayEach(listeners.slice(0), function (fn) {
                fn();
            });
        }

        addListener(function () {
            if (!remainingTasks) {
                callback(null, results);
            }
        });

        _arrayEach(keys, function (k) {
            var task = _isArray(tasks[k]) ? tasks[k]: [tasks[k]];
            var taskCallback = _restParam(function(err, args) {
                runningTasks--;
                if (args.length <= 1) {
                    args = args[0];
                }
                if (err) {
                    var safeResults = {};
                    _forEachOf(results, function(val, rkey) {
                        safeResults[rkey] = val;
                    });
                    safeResults[k] = args;
                    callback(err, safeResults);
                }
                else {
                    results[k] = args;
                    async.setImmediate(taskComplete);
                }
            });
            var requires = task.slice(0, task.length - 1);
            // prevent dead-locks
            var len = requires.length;
            var dep;
            while (len--) {
                if (!(dep = tasks[requires[len]])) {
                    throw new Error('Has inexistant dependency');
                }
                if (_isArray(dep) && _indexOf(dep, k) >= 0) {
                    throw new Error('Has cyclic dependencies');
                }
            }
            function ready() {
                return runningTasks < concurrency && _reduce(requires, function (a, x) {
                    return (a && results.hasOwnProperty(x));
                }, true) && !results.hasOwnProperty(k);
            }
            if (ready()) {
                runningTasks++;
                task[task.length - 1](taskCallback, results);
            }
            else {
                addListener(listener);
            }
            function listener() {
                if (ready()) {
                    runningTasks++;
                    removeListener(listener);
                    task[task.length - 1](taskCallback, results);
                }
            }
        });
    };



    async.retry = function(times, task, callback) {
        var DEFAULT_TIMES = 5;
        var DEFAULT_INTERVAL = 0;

        var attempts = [];

        var opts = {
            times: DEFAULT_TIMES,
            interval: DEFAULT_INTERVAL
        };

        function parseTimes(acc, t){
            if(typeof t === 'number'){
                acc.times = parseInt(t, 10) || DEFAULT_TIMES;
            } else if(typeof t === 'object'){
                acc.times = parseInt(t.times, 10) || DEFAULT_TIMES;
                acc.interval = parseInt(t.interval, 10) || DEFAULT_INTERVAL;
            } else {
                throw new Error('Unsupported argument type for \'times\': ' + typeof t);
            }
        }

        var length = arguments.length;
        if (length < 1 || length > 3) {
            throw new Error('Invalid arguments - must be either (task), (task, callback), (times, task) or (times, task, callback)');
        } else if (length <= 2 && typeof times === 'function') {
            callback = task;
            task = times;
        }
        if (typeof times !== 'function') {
            parseTimes(opts, times);
        }
        opts.callback = callback;
        opts.task = task;

        function wrappedTask(wrappedCallback, wrappedResults) {
            function retryAttempt(task, finalAttempt) {
                return function(seriesCallback) {
                    task(function(err, result){
                        seriesCallback(!err || finalAttempt, {err: err, result: result});
                    }, wrappedResults);
                };
            }

            function retryInterval(interval){
                return function(seriesCallback){
                    setTimeout(function(){
                        seriesCallback(null);
                    }, interval);
                };
            }

            while (opts.times) {

                var finalAttempt = !(opts.times-=1);
                attempts.push(retryAttempt(opts.task, finalAttempt));
                if(!finalAttempt && opts.interval > 0){
                    attempts.push(retryInterval(opts.interval));
                }
            }

            async.series(attempts, function(done, data){
                data = data[data.length - 1];
                (wrappedCallback || opts.callback)(data.err, data.result);
            });
        }

        // If a callback is passed, run this as a controll flow
        return opts.callback ? wrappedTask() : wrappedTask;
    };

    async.waterfall = function (tasks, callback) {
        callback = _once(callback || noop);
        if (!_isArray(tasks)) {
            var err = new Error('First argument to waterfall must be an array of functions');
            return callback(err);
        }
        if (!tasks.length) {
            return callback();
        }
        function wrapIterator(iterator) {
            return _restParam(function (err, args) {
                if (err) {
                    callback.apply(null, [err].concat(args));
                }
                else {
                    var next = iterator.next();
                    if (next) {
                        args.push(wrapIterator(next));
                    }
                    else {
                        args.push(callback);
                    }
                    ensureAsync(iterator).apply(null, args);
                }
            });
        }
        wrapIterator(async.iterator(tasks))();
    };

    function _parallel(eachfn, tasks, callback) {
        callback = callback || noop;
        var results = _isArrayLike(tasks) ? [] : {};

        eachfn(tasks, function (task, key, callback) {
            task(_restParam(function (err, args) {
                if (args.length <= 1) {
                    args = args[0];
                }
                results[key] = args;
                callback(err);
            }));
        }, function (err) {
            callback(err, results);
        });
    }

    async.parallel = function (tasks, callback) {
        _parallel(async.eachOf, tasks, callback);
    };

    async.parallelLimit = function(tasks, limit, callback) {
        _parallel(_eachOfLimit(limit), tasks, callback);
    };

    async.series = function(tasks, callback) {
        _parallel(async.eachOfSeries, tasks, callback);
    };

    async.iterator = function (tasks) {
        function makeCallback(index) {
            function fn() {
                if (tasks.length) {
                    tasks[index].apply(null, arguments);
                }
                return fn.next();
            }
            fn.next = function () {
                return (index < tasks.length - 1) ? makeCallback(index + 1): null;
            };
            return fn;
        }
        return makeCallback(0);
    };

    async.apply = _restParam(function (fn, args) {
        return _restParam(function (callArgs) {
            return fn.apply(
                null, args.concat(callArgs)
            );
        });
    });

    function _concat(eachfn, arr, fn, callback) {
        var result = [];
        eachfn(arr, function (x, index, cb) {
            fn(x, function (err, y) {
                result = result.concat(y || []);
                cb(err);
            });
        }, function (err) {
            callback(err, result);
        });
    }
    async.concat = doParallel(_concat);
    async.concatSeries = doSeries(_concat);

    async.whilst = function (test, iterator, callback) {
        callback = callback || noop;
        if (test()) {
            var next = _restParam(function(err, args) {
                if (err) {
                    callback(err);
                } else if (test.apply(this, args)) {
                    iterator(next);
                } else {
                    callback(null);
                }
            });
            iterator(next);
        } else {
            callback(null);
        }
    };

    async.doWhilst = function (iterator, test, callback) {
        var calls = 0;
        return async.whilst(function() {
            return ++calls <= 1 || test.apply(this, arguments);
        }, iterator, callback);
    };

    async.until = function (test, iterator, callback) {
        return async.whilst(function() {
            return !test.apply(this, arguments);
        }, iterator, callback);
    };

    async.doUntil = function (iterator, test, callback) {
        return async.doWhilst(iterator, function() {
            return !test.apply(this, arguments);
        }, callback);
    };

    async.during = function (test, iterator, callback) {
        callback = callback || noop;

        var next = _restParam(function(err, args) {
            if (err) {
                callback(err);
            } else {
                args.push(check);
                test.apply(this, args);
            }
        });

        var check = function(err, truth) {
            if (err) {
                callback(err);
            } else if (truth) {
                iterator(next);
            } else {
                callback(null);
            }
        };

        test(check);
    };

    async.doDuring = function (iterator, test, callback) {
        var calls = 0;
        async.during(function(next) {
            if (calls++ < 1) {
                next(null, true);
            } else {
                test.apply(this, arguments);
            }
        }, iterator, callback);
    };

    function _queue(worker, concurrency, payload) {
        if (concurrency == null) {
            concurrency = 1;
        }
        else if(concurrency === 0) {
            throw new Error('Concurrency must not be zero');
        }
        function _insert(q, data, pos, callback) {
            if (callback != null && typeof callback !== "function") {
                throw new Error("task callback must be a function");
            }
            q.started = true;
            if (!_isArray(data)) {
                data = [data];
            }
            if(data.length === 0 && q.idle()) {
                // call drain immediately if there are no tasks
                return async.setImmediate(function() {
                    q.drain();
                });
            }
            _arrayEach(data, function(task) {
                var item = {
                    data: task,
                    callback: callback || noop
                };

                if (pos) {
                    q.tasks.unshift(item);
                } else {
                    q.tasks.push(item);
                }

                if (q.tasks.length === q.concurrency) {
                    q.saturated();
                }
            });
            async.setImmediate(q.process);
        }
        function _next(q, tasks) {
            return function(){
                workers -= 1;

                var removed = false;
                var args = arguments;
                _arrayEach(tasks, function (task) {
                    _arrayEach(workersList, function (worker, index) {
                        if (worker === task && !removed) {
                            workersList.splice(index, 1);
                            removed = true;
                        }
                    });

                    task.callback.apply(task, args);
                });
                if (q.tasks.length + workers === 0) {
                    q.drain();
                }
                q.process();
            };
        }

        var workers = 0;
        var workersList = [];
        var q = {
            tasks: [],
            concurrency: concurrency,
            payload: payload,
            saturated: noop,
            empty: noop,
            drain: noop,
            started: false,
            paused: false,
            push: function (data, callback) {
                _insert(q, data, false, callback);
            },
            kill: function () {
                q.drain = noop;
                q.tasks = [];
            },
            unshift: function (data, callback) {
                _insert(q, data, true, callback);
            },
            process: function () {
                if (!q.paused && workers < q.concurrency && q.tasks.length) {
                    while(workers < q.concurrency && q.tasks.length){
                        var tasks = q.payload ?
                            q.tasks.splice(0, q.payload) :
                            q.tasks.splice(0, q.tasks.length);

                        var data = _map(tasks, function (task) {
                            return task.data;
                        });

                        if (q.tasks.length === 0) {
                            q.empty();
                        }
                        workers += 1;
                        workersList.push(tasks[0]);
                        var cb = only_once(_next(q, tasks));
                        worker(data, cb);
                    }
                }
            },
            length: function () {
                return q.tasks.length;
            },
            running: function () {
                return workers;
            },
            workersList: function () {
                return workersList;
            },
            idle: function() {
                return q.tasks.length + workers === 0;
            },
            pause: function () {
                q.paused = true;
            },
            resume: function () {
                if (q.paused === false) { return; }
                q.paused = false;
                var resumeCount = Math.min(q.concurrency, q.tasks.length);
                // Need to call q.process once per concurrent
                // worker to preserve full concurrency after pause
                for (var w = 1; w <= resumeCount; w++) {
                    async.setImmediate(q.process);
                }
            }
        };
        return q;
    }

    async.queue = function (worker, concurrency) {
        var q = _queue(function (items, cb) {
            worker(items[0], cb);
        }, concurrency, 1);

        return q;
    };

    async.priorityQueue = function (worker, concurrency) {

        function _compareTasks(a, b){
            return a.priority - b.priority;
        }

        function _binarySearch(sequence, item, compare) {
            var beg = -1,
                end = sequence.length - 1;
            while (beg < end) {
                var mid = beg + ((end - beg + 1) >>> 1);
                if (compare(item, sequence[mid]) >= 0) {
                    beg = mid;
                } else {
                    end = mid - 1;
                }
            }
            return beg;
        }

        function _insert(q, data, priority, callback) {
            if (callback != null && typeof callback !== "function") {
                throw new Error("task callback must be a function");
            }
            q.started = true;
            if (!_isArray(data)) {
                data = [data];
            }
            if(data.length === 0) {
                // call drain immediately if there are no tasks
                return async.setImmediate(function() {
                    q.drain();
                });
            }
            _arrayEach(data, function(task) {
                var item = {
                    data: task,
                    priority: priority,
                    callback: typeof callback === 'function' ? callback : noop
                };

                q.tasks.splice(_binarySearch(q.tasks, item, _compareTasks) + 1, 0, item);

                if (q.tasks.length === q.concurrency) {
                    q.saturated();
                }
                async.setImmediate(q.process);
            });
        }

        // Start with a normal queue
        var q = async.queue(worker, concurrency);

        // Override push to accept second parameter representing priority
        q.push = function (data, priority, callback) {
            _insert(q, data, priority, callback);
        };

        // Remove unshift function
        delete q.unshift;

        return q;
    };

    async.cargo = function (worker, payload) {
        return _queue(worker, 1, payload);
    };

    function _console_fn(name) {
        return _restParam(function (fn, args) {
            fn.apply(null, args.concat([_restParam(function (err, args) {
                if (typeof console === 'object') {
                    if (err) {
                        if (console.error) {
                            console.error(err);
                        }
                    }
                    else if (console[name]) {
                        _arrayEach(args, function (x) {
                            console[name](x);
                        });
                    }
                }
            })]));
        });
    }
    async.log = _console_fn('log');
    async.dir = _console_fn('dir');
    /*async.info = _console_fn('info');
    async.warn = _console_fn('warn');
    async.error = _console_fn('error');*/

    async.memoize = function (fn, hasher) {
        var memo = {};
        var queues = {};
        hasher = hasher || identity;
        var memoized = _restParam(function memoized(args) {
            var callback = args.pop();
            var key = hasher.apply(null, args);
            if (key in memo) {
                async.setImmediate(function () {
                    callback.apply(null, memo[key]);
                });
            }
            else if (key in queues) {
                queues[key].push(callback);
            }
            else {
                queues[key] = [callback];
                fn.apply(null, args.concat([_restParam(function (args) {
                    memo[key] = args;
                    var q = queues[key];
                    delete queues[key];
                    for (var i = 0, l = q.length; i < l; i++) {
                        q[i].apply(null, args);
                    }
                })]));
            }
        });
        memoized.memo = memo;
        memoized.unmemoized = fn;
        return memoized;
    };

    async.unmemoize = function (fn) {
        return function () {
            return (fn.unmemoized || fn).apply(null, arguments);
        };
    };

    function _times(mapper) {
        return function (count, iterator, callback) {
            mapper(_range(count), iterator, callback);
        };
    }

    async.times = _times(async.map);
    async.timesSeries = _times(async.mapSeries);
    async.timesLimit = function (count, limit, iterator, callback) {
        return async.mapLimit(_range(count), limit, iterator, callback);
    };

    async.seq = function (/* functions... */) {
        var fns = arguments;
        return _restParam(function (args) {
            var that = this;

            var callback = args[args.length - 1];
            if (typeof callback == 'function') {
                args.pop();
            } else {
                callback = noop;
            }

            async.reduce(fns, args, function (newargs, fn, cb) {
                fn.apply(that, newargs.concat([_restParam(function (err, nextargs) {
                    cb(err, nextargs);
                })]));
            },
            function (err, results) {
                callback.apply(that, [err].concat(results));
            });
        });
    };

    async.compose = function (/* functions... */) {
        return async.seq.apply(null, Array.prototype.reverse.call(arguments));
    };


    function _applyEach(eachfn) {
        return _restParam(function(fns, args) {
            var go = _restParam(function(args) {
                var that = this;
                var callback = args.pop();
                return eachfn(fns, function (fn, _, cb) {
                    fn.apply(that, args.concat([cb]));
                },
                callback);
            });
            if (args.length) {
                return go.apply(this, args);
            }
            else {
                return go;
            }
        });
    }

    async.applyEach = _applyEach(async.eachOf);
    async.applyEachSeries = _applyEach(async.eachOfSeries);


    async.forever = function (fn, callback) {
        var done = only_once(callback || noop);
        var task = ensureAsync(fn);
        function next(err) {
            if (err) {
                return done(err);
            }
            task(next);
        }
        next();
    };

    function ensureAsync(fn) {
        return _restParam(function (args) {
            var callback = args.pop();
            args.push(function () {
                var innerArgs = arguments;
                if (sync) {
                    async.setImmediate(function () {
                        callback.apply(null, innerArgs);
                    });
                } else {
                    callback.apply(null, innerArgs);
                }
            });
            var sync = true;
            fn.apply(this, args);
            sync = false;
        });
    }

    async.ensureAsync = ensureAsync;

    async.constant = _restParam(function(values) {
        var args = [null].concat(values);
        return function (callback) {
            return callback.apply(this, args);
        };
    });

    async.wrapSync =
    async.asyncify = function asyncify(func) {
        return _restParam(function (args) {
            var callback = args.pop();
            var result;
            try {
                result = func.apply(this, args);
            } catch (e) {
                return callback(e);
            }
            // if result is Promise object
            if (_isObject(result) && typeof result.then === "function") {
                result.then(function(value) {
                    callback(null, value);
                })["catch"](function(err) {
                    callback(err.message ? err : new Error(err));
                });
            } else {
                callback(null, result);
            }
        });
    };

    // Node.js
    if (typeof module === 'object' && module.exports) {
        module.exports = async;
    }
    // AMD / RequireJS
    else if (typeof define === 'function' && define.amd) {
        define([], function () {
            return async;
        });
    }
    // included directly via <script> tag
    else {
        root.async = async;
    }

}());


return module.exports;
})();modules['../networking/node_modules/form-data/lib/form_data.js'] = (function(){
var module = {exports: modules["../networking/node_modules/form-data/lib/form_data.js"]};
var require = getModule.bind(null, {"combined-stream":"../networking/node_modules/form-data/node_modules/combined-stream/lib/combined_stream.js","mime-types":"../networking/node_modules/form-data/node_modules/mime-types/index.js","async":"../networking/node_modules/form-data/node_modules/async/lib/async.js"});
var exports = module.exports;

var CombinedStream = require('combined-stream');
var util = require('util');
var path = require('path');
var http = require('http');
var https = require('https');
var parseUrl = require('url').parse;
var fs = require('fs');
var mime = require('mime-types');
var async = require('async');

module.exports = FormData;
function FormData() {
  this._overheadLength = 0;
  this._valueLength = 0;
  this._lengthRetrievers = [];

  CombinedStream.call(this);
}
util.inherits(FormData, CombinedStream);

FormData.LINE_BREAK = '\r\n';
FormData.DEFAULT_CONTENT_TYPE = 'application/octet-stream';

FormData.prototype.append = function(field, value, options) {
  options = (typeof options === 'string')
    ? { filename: options }
    : options || {};

  var append = CombinedStream.prototype.append.bind(this);

  // all that streamy business can't handle numbers
  if (typeof value == 'number') value = ''+value;

  // https://github.com/felixge/node-form-data/issues/38
  if (util.isArray(value)) {
    // Please convert your array into string
    // the way web server expects it
    this._error(new Error('Arrays are not supported.'));
    return;
  }

  var header = this._multiPartHeader(field, value, options);
  var footer = this._multiPartFooter(field, value, options);

  append(header);
  append(value);
  append(footer);

  // pass along options.knownLength
  this._trackLength(header, value, options);
};

FormData.prototype._trackLength = function(header, value, options) {
  var valueLength = 0;

  // used w/ getLengthSync(), when length is known.
  // e.g. for streaming directly from a remote server,
  // w/ a known file a size, and not wanting to wait for
  // incoming file to finish to get its size.
  if (options.knownLength != null) {
    valueLength += +options.knownLength;
  } else if (Buffer.isBuffer(value)) {
    valueLength = value.length;
  } else if (typeof value === 'string') {
    valueLength = Buffer.byteLength(value);
  }

  this._valueLength += valueLength;

  // @check why add CRLF? does this account for custom/multiple CRLFs?
  this._overheadLength +=
    Buffer.byteLength(header) +
    FormData.LINE_BREAK.length;

  // empty or either doesn't have path or not an http response
  if (!value || ( !value.path && !(value.readable && value.hasOwnProperty('httpVersion')) )) {
    return;
  }

  // no need to bother with the length
  if (!options.knownLength)
  this._lengthRetrievers.push(function(next) {

    if (value.hasOwnProperty('fd')) {

      // take read range into a account
      // `end` = Infinity –> read file till the end
      //
      // TODO: Looks like there is bug in Node fs.createReadStream
      // it doesn't respect `end` options without `start` options
      // Fix it when node fixes it.
      // https://github.com/joyent/node/issues/7819
      if (value.end != undefined && value.end != Infinity && value.start != undefined) {

        // when end specified
        // no need to calculate range
        // inclusive, starts with 0
        next(null, value.end+1 - (value.start ? value.start : 0));

      // not that fast snoopy
      } else {
        // still need to fetch file size from fs
        fs.stat(value.path, function(err, stat) {

          var fileSize;

          if (err) {
            next(err);
            return;
          }

          // update final size based on the range options
          fileSize = stat.size - (value.start ? value.start : 0);
          next(null, fileSize);
        });
      }

    // or http response
    } else if (value.hasOwnProperty('httpVersion')) {
      next(null, +value.headers['content-length']);

    // or request stream http://github.com/mikeal/request
    } else if (value.hasOwnProperty('httpModule')) {
      // wait till response come back
      value.on('response', function(response) {
        value.pause();
        next(null, +response.headers['content-length']);
      });
      value.resume();

    // something else
    } else {
      next('Unknown stream');
    }
  });
};

FormData.prototype._multiPartHeader = function(field, value, options) {
  // custom header specified (as string)?
  // it becomes responsible for boundary
  // (e.g. to handle extra CRLFs on .NET servers)
  if (options.header != null) {
    return options.header;
  }

  var contents = '';
  var headers  = {
    'Content-Disposition': ['form-data', 'name="' + field + '"'],
    'Content-Type': []
  };

  // fs- and request- streams have path property
  // or use custom filename and/or contentType
  // TODO: Use request's response mime-type
  if (options.filename || value.path) {
    headers['Content-Disposition'].push(
      'filename="' + path.basename(options.filename || value.path) + '"'
    );
    headers['Content-Type'].push(
      options.contentType ||
      mime.lookup(options.filename || value.path) ||
      FormData.DEFAULT_CONTENT_TYPE
    );
  // http response has not
  } else if (value.readable && value.hasOwnProperty('httpVersion')) {
    headers['Content-Disposition'].push(
      'filename="' + path.basename(value.client._httpMessage.path) + '"'
    );
    headers['Content-Type'].push(
      options.contentType ||
      value.headers['content-type'] ||
      FormData.DEFAULT_CONTENT_TYPE
    );
  } else if (Buffer.isBuffer(value)) {
    headers['Content-Type'].push(
      options.contentType ||
      FormData.DEFAULT_CONTENT_TYPE
    );
  } else if (options.contentType) {
    headers['Content-Type'].push(options.contentType);
  }

  for (var prop in headers) {
    if (headers[prop].length) {
      contents += prop + ': ' + headers[prop].join('; ') + FormData.LINE_BREAK;
    }
  }
  
  return '--' + this.getBoundary() + FormData.LINE_BREAK + contents + FormData.LINE_BREAK;
};

FormData.prototype._multiPartFooter = function(field, value, options) {
  return function(next) {
    var footer = FormData.LINE_BREAK;

    var lastPart = (this._streams.length === 0);
    if (lastPart) {
      footer += this._lastBoundary();
    }

    next(footer);
  }.bind(this);
};

FormData.prototype._lastBoundary = function() {
  return '--' + this.getBoundary() + '--' + FormData.LINE_BREAK;
};

FormData.prototype.getHeaders = function(userHeaders) {
  var formHeaders = {
    'content-type': 'multipart/form-data; boundary=' + this.getBoundary()
  };

  for (var header in userHeaders) {
    formHeaders[header.toLowerCase()] = userHeaders[header];
  }

  return formHeaders;
}

FormData.prototype.getCustomHeaders = function(contentType) {
    contentType = contentType ? contentType : 'multipart/form-data';

    var formHeaders = {
        'content-type': contentType + '; boundary=' + this.getBoundary(),
        'content-length': this.getLengthSync()
    };

    return formHeaders;
}

FormData.prototype.getBoundary = function() {
  if (!this._boundary) {
    this._generateBoundary();
  }

  return this._boundary;
};

FormData.prototype._generateBoundary = function() {
  // This generates a 50 character boundary similar to those used by Firefox.
  // They are optimized for boyer-moore parsing.
  var boundary = '--------------------------';
  for (var i = 0; i < 24; i++) {
    boundary += Math.floor(Math.random() * 10).toString(16);
  }

  this._boundary = boundary;
};

// Note: getLengthSync DOESN'T calculate streams length
// As workaround one can calculate file size manually
// and add it as knownLength option
FormData.prototype.getLengthSync = function(debug) {
  var knownLength = this._overheadLength + this._valueLength;

  // Don't get confused, there are 3 "internal" streams for each keyval pair
  // so it basically checks if there is any value added to the form
  if (this._streams.length) {
    knownLength += this._lastBoundary().length;
  }

  // https://github.com/felixge/node-form-data/issues/40
  if (this._lengthRetrievers.length) {
    // Some async length retrivers are present
    // therefore synchronous length calculation is false.
    // Please use getLength(callback) to get proper length
    this._error(new Error('Cannot calculate proper length in synchronous way.'));
  }

  return knownLength;
};

FormData.prototype.getLength = function(cb) {
  var knownLength = this._overheadLength + this._valueLength;

  if (this._streams.length) {
    knownLength += this._lastBoundary().length;
  }

  if (!this._lengthRetrievers.length) {
    process.nextTick(cb.bind(this, null, knownLength));
    return;
  }

  async.parallel(this._lengthRetrievers, function(err, values) {
    if (err) {
      cb(err);
      return;
    }

    values.forEach(function(length) {
      knownLength += length;
    });

    cb(null, knownLength);
  });
};

FormData.prototype.submit = function(params, cb) {

  var request
    , options
    , defaults = {
        method : 'post'
    };

  // parse provided url if it's string
  // or treat it as options object
  if (typeof params == 'string') {
    params = parseUrl(params);

    options = populate({
      port: params.port,
      path: params.pathname,
      host: params.hostname
    }, defaults);
  }
  else // use custom params
  {
    options = populate(params, defaults);
    // if no port provided use default one
    if (!options.port) {
      options.port = options.protocol == 'https:' ? 443 : 80;
    }
  }

  // put that good code in getHeaders to some use
  options.headers = this.getHeaders(params.headers);

  // https if specified, fallback to http in any other case
  if (options.protocol == 'https:') {
    request = https.request(options);
  } else {
    request = http.request(options);
  }

  // get content length and fire away
  this.getLength(function(err, length) {

    // TODO: Add chunked encoding when no length (if err)

    // add content length
    request.setHeader('Content-Length', length);

    this.pipe(request);
    if (cb) {
      request.on('error', cb);
      request.on('response', cb.bind(this, null));
    }
  }.bind(this));

  return request;
};

FormData.prototype._error = function(err) {
  if (this.error) return;

  this.error = err;
  this.pause();
  this.emit('error', err);
};

/*
 * Santa's little helpers
 */

// populates missing values
function populate(dst, src) {
  for (var prop in src) {
    if (!dst[prop]) dst[prop] = src[prop];
  }
  return dst;
}


return module.exports;
})();modules['../networking/impl/node/index.coffee'] = (function(){
var module = {exports: modules["../networking/impl/node/index.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","form-data":"../networking/node_modules/form-data/lib/form_data.js","./request":"../networking/impl/node/request.coffee","./response":"../networking/impl/node/response.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var EXT_TYPES, FormData, assert, http, https, nodeStatic, pathUtils, pending, staticServer, urlUtils, utils;

  utils = require('utils');

  http = require('http');

  https = require('https');

  urlUtils = require('url');

  pathUtils = require('path');

  assert = require('neft-assert');

  nodeStatic = require('node-static');

  FormData = require('form-data');

  EXT_TYPES = {
    __proto__: null,
    '.js': 'text',
    '.txt': 'text',
    '.json': 'json'
  };

  pending = Object.create(null);

  staticServer = new nodeStatic.Server({
    gzip: true
  });

  module.exports = function(Networking) {
    var Response;
    return {
      Request: require('./request')(Networking, pending),
      Response: Response = require('./response')(Networking, pending),
      init: function(networking) {
        var server;
        assert.instanceOf(networking, Networking);
        switch (networking.protocol) {
          case 'http':
            server = http.createServer();
            break;
          case 'https':
            server = https.createServer();
            break;
          default:
            throw new Error("Unsupported protocol '" + networking.protocol + "'");
        }
        server.listen(networking.port, networking.host);
        return server.on('request', function(serverReq, serverRes) {
          var data;
          data = '';
          serverReq.on('data', function(chunk) {
            return data += chunk;
          });
          return serverReq.on('end', function() {
            var cookies, extname, obj, parsedUrl, reqData, type, uid, url;
            if (/^(?:\/static\/|\/build\/static\/)/.test(serverReq.url)) {
              staticServer.serve(serverReq, serverRes);
              return;
            }
            uid = utils.uid();
            parsedUrl = urlUtils.parse(serverReq.url);
            obj = pending[uid] = {
              networking: networking,
              server: server,
              req: null,
              serverReq: serverReq,
              serverRes: serverRes
            };
            type = serverReq.headers['x-expected-type'];
            if (!type) {
              extname = pathUtils.extname(parsedUrl.pathname);
              type = EXT_TYPES[extname];
            }
            type || (type = Networking.Request.HTML_TYPE);
            if (data !== '') {
              reqData = utils.tryFunction(JSON.parse, null, [data], data);
            } else {
              reqData = null;
            }
            url = serverReq.url;
            if (utils.has(url, '?')) {
              url = url.slice(0, url.indexOf('?'));
            }
            cookies = serverReq.headers['x-cookies'];
            if (typeof cookies === 'string') {
              cookies = utils.tryFunction(JSON.parse, null, [cookies], null);
            }
            return obj.req = networking.createLocalRequest({
              uid: uid,
              method: Networking.Request[serverReq.method],
              uri: url,
              data: reqData,
              type: type,
              headers: serverReq.headers,
              cookies: cookies
            });
          });
        });
      },
      sendRequest: function(req, res, callback) {
        var cookies, data, nodeReq, opts, reqModule, urlObject;
        urlObject = urlUtils.parse(req.uri);
        opts = {
          protocol: urlObject.protocol,
          hostname: urlObject.hostname,
          port: urlObject.port,
          auth: urlObject.auth,
          path: urlObject.path,
          method: req.method,
          headers: utils.clone(req.headers)
        };
        opts.headers['X-Expected-Type'] = req.type;
        if (cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)) {
          opts.headers['X-Cookies'] = cookies;
        }
        switch (urlObject.protocol) {
          case 'http:':
            reqModule = http;
            break;
          case 'https:':
            reqModule = https;
            break;
          default:
            callback({
              status: 500,
              data: new Error("Unsupported protocol '" + urlObject.protocol + "'")
            });
            return;
        }
        nodeReq = reqModule.request(opts, function(nodeRes) {
          var data;
          nodeRes.setEncoding(res.encoding);
          data = '';
          nodeRes.on('data', function(chunk) {
            return data += chunk;
          });
          return nodeRes.on('end', function() {
            var status;
            status = nodeRes.statusCode;
            if (req.type === Networking.Request.JSON_TYPE) {
              data = utils.tryFunction(JSON.parse, null, [data], data);
            }
            if (cookies = nodeRes.headers['x-cookies']) {
              cookies = utils.tryFunction(JSON.parse, null, [cookies], null);
            }
            return callback({
              status: status,
              data: data,
              headers: nodeRes.headers,
              cookies: cookies
            });
          });
        });
        nodeReq.on('error', function(e) {
          return callback({
            status: 500,
            data: e
          });
        });
        data = Response._prepareData(req.type, nodeReq, req.data);
        return Response._sendData(req.type, null, nodeReq, data, function(err) {
          if (err) {
            return callback(err);
          }
        });
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../networking/impl.coffee'] = (function(){
var module = {exports: modules["../networking/impl.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./impl/node/index":"../networking/impl/node/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var PlatformImpl, assert, utils;

  utils = require('utils');

  assert = console.assert;

  PlatformImpl = (function() {
    switch (true) {
      case utils.isNode:
        return require('./impl/node/index');
      case utils.isBrowser:
        return require('./impl/browser/index');
      case utils.isQml:
        return require('./impl/qml/index');
      case utils.isAndroid:
        return require('./impl/android/index');
    }
  })();

  assert(PlatformImpl, "No networking implementation found");

  module.exports = function(Networking) {
    return PlatformImpl(Networking);
  };

}).call(this);


return module.exports;
})();modules['../networking/impl/node/request.coffee'] = (function(){
var module = {exports: modules["../networking/impl/node/request.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(Networking, pending) {};

}).call(this);


return module.exports;
})();modules['node_modules/expect/index.coffee.md'] = (function(){
var module = {exports: modules["node_modules/expect/index.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var assert, createMatcher, createValidator, every, expect, inverse, isArray, isInteger, keys, raise, silent, some, validators, value;

  isArray = Array.isArray;

  assert = console.assert;

  value = null;

  silent = every = some = inverse = keys = false;

  createValidator = function(func) {
    return function(_value) {
      value = _value;
      func();
      return validators;
    };
  };

  raise = function(msg) {
    inverse = inverse ? ' not' : '';
    return assert(false, msg());
  };

  createMatcher = function(func, msg) {
    var exit, test;
    test = function(value) {
      if (silent && (value == null)) {
        return true;
      }
      return func(value);
    };
    exit = function(ok) {
      if (inverse) {
        ok = !ok;
      }
      if (!ok) {
        return raise(msg);
      }
    };
    return function() {
      var isObject, key, ok, val, values;
      values = value;
      if (every || some) {
        isObject = value && typeof value === 'object';
        assert(isObject, "expect.some/every() expects object, but `" + value + "` passed");
      }
      if (some || every) {
        ok = every;
        for (key in value) {
          val = value[key];
          if (test(keys ? key : val) === some) {
            ok = some;
            break;
          }
        }
      } else {
        ok = test(value);
      }
      exit(ok);
      return validators.toBe;
    };
  };

  expect = module.exports = createValidator(function() {
    return silent = every = some = inverse = keys = false;
  });

  validators = {};

  validators.defined = createValidator(function() {
    return silent = true;
  });

  validators.every = createValidator(function() {
    return every = true;
  });

  validators.some = createValidator(function() {
    return some = true;
  });

  validators.keys = createValidator(function() {
    var isObject;
    isObject = value !== null && typeof value === 'object' && !isArray(value);
    if (!some) {
      throw "Use `expect().keys()` with some()";
    }
    if (!isObject) {
      throw "Use `expect().some().keys()` with objects";
    }
    return keys = true;
  });

  validators.not = function() {
    inverse = true;
    return validators;
  };

  validators.toBe = (function() {
    var expected, matcher;
    expected = null;
    matcher = createMatcher(function(value) {
      return value === expected;
    }, function() {
      return "Expected `" + value + "`" + inverse + " to be `" + expected + "`";
    });
    return function(_expected) {
      expected = _expected;
      return matcher();
    };
  })();

  validators.toBe.object = createMatcher(function(value) {
    return typeof value === 'object' && value !== null;
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be an object";
  });

  validators.toBe.simpleObject = createMatcher(function(value) {
    var proto, r;
    r = typeof value === 'object';
    r && (r = value !== null);
    if (r && (proto = Object.getPrototypeOf(value))) {
      r && (r = proto === Object.prototype);
      r && (r = !Object.getPrototypeOf(proto));
    }
    return r;
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be a simple object";
  });

  validators.toBe.string = createMatcher(function(value) {
    return typeof value === 'string';
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be a string";
  });

  validators.toBe.boolean = createMatcher(function(value) {
    return typeof value === 'boolean';
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be a boolean";
  });

  validators.toBe["function"] = createMatcher(function(value) {
    return typeof value === 'function';
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be a function";
  });

  validators.toBe.float = createMatcher(function(value) {
    return typeof value === 'number' && isFinite(value);
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be a float";
  });

  isInteger = Number.isInteger || function(value) {
    return typeof value === "number" && isFinite(value) && value > -9007199254740992 && value < 9007199254740992 && Math.floor(value) === value;
  };

  validators.toBe.integer = createMatcher(isInteger, function() {
    return "Expected `" + value + "`" + inverse + " to be an integer";
  });

  validators.toBe.array = createMatcher(function(value) {
    return isArray(value);
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be an array";
  });

  validators.toBe.truthy = createMatcher(function(value) {
    return !!value;
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be truthy";
  });

  validators.toBe.falsy = createMatcher(function(value) {
    return !value;
  }, function() {
    return "Expected `" + value + "`" + inverse + " to be falsy";
  });

  validators.toBe.primitive = createMatcher(function(value) {
    return value === null || typeof value === 'string' || typeof value === 'number' || typeof value === 'boolean' || typeof value === 'undefined';
  }, function() {
    return "Expected `" + value + "`" + inverse + " not to be a primitive value";
  });

  validators.toBe.any = (function() {
    var ctor, matcher;
    ctor = null;
    matcher = createMatcher(function(value) {
      return value instanceof ctor;
    }, function() {
      return "Expected `" + value + "`" + inverse + " to be any " + ctor.name;
    });
    return function(_ctor) {
      ctor = _ctor;
      return matcher();
    };
  })();

  validators.toBe.greaterThan = (function() {
    var matcher, number;
    number = 0;
    matcher = createMatcher(function(value) {
      return value > number;
    }, function() {
      return "Expected `" + value + "`" + inverse + " to be greater than " + number;
    });
    return function(_number) {
      number = _number;
      return matcher();
    };
  })();

  validators.toBe.lessThan = (function() {
    var matcher, number;
    number = 0;
    matcher = createMatcher(function(value) {
      return value < number;
    }, function() {
      return "Expected `" + value + "`" + inverse + " to be less than " + number;
    });
    return function(_number) {
      number = _number;
      return matcher();
    };
  })();

  validators.toMatchRe = (function() {
    var expected, matcher;
    expected = null;
    matcher = createMatcher(function(value) {
      return expected.test(value);
    }, function() {
      return "Expected `" + value + "`" + inverse + " to test `" + expected + "`";
    });
    return function(_expected) {
      expected = _expected;
      return matcher();
    };
  })();

}).call(this);


return module.exports;
})();modules['../emitter/index.coffee.md'] = (function(){
var module = {exports: modules["../emitter/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","expect":"node_modules/expect/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Emitter, expect, utils;

  utils = require('utils');

  expect = require('expect');

  module.exports = Emitter = (function() {
    function Emitter() {
      utils.defineProperty(this, '_events', utils.CONFIGURABLE, null);
    }

    Emitter.prototype.getListeners = function(name) {
      var _base;
      expect(name).toBe.truthy().string();
      if (!this._events) {
        utils.defineProperty(this, '_events', null, {});
      }
      return (_base = this._events)[name] != null ? _base[name] : _base[name] = [];
    };

    Emitter.prototype.on = function(name, listener) {
      var listeners;
      expect(name).toBe.truthy().string();
      expect(listener).toBe["function"]();
      listeners = this.getListeners(name);
      listeners.push(listener);
      return this;
    };

    Emitter.prototype.once = function(name, listener) {
      var listenerOnce;
      expect(name).toBe.truthy().string();
      expect(listener).toBe["function"]();
      listenerOnce = (function(_this) {
        return function() {
          _this.off(name, listenerOnce);
          return listener.apply(_this, arguments);
        };
      })(this);
      return this.on(name, listenerOnce);
    };

    Emitter.prototype.off = function(name, listener) {
      var i, index, listeners, _, _i, _len;
      expect(name).toBe.truthy().string();
      expect(listener).toBe["function"]();
      switch (arguments.length) {
        case 2:
          listeners = this.getListeners(name);
          if (!listeners) {
            break;
          }
          index = listeners.indexOf(listener);
          if (~index) {
            listeners[index] = null;
          }
          break;
        case 1:
          listeners = this.getListeners(name);
          if (!listeners) {
            break;
          }
          for (i = _i = 0, _len = listeners.length; _i < _len; i = ++_i) {
            _ = listeners[i];
            listeners[i] = null;
          }
          break;
        case 0:
          for (name in this._events) {
            this.off(name);
          }
      }
      return this;
    };

    Emitter.prototype.trigger = function(name, param) {
      var i, listener, listeners, n, tmp;
      expect(name).toBe.truthy().string();
      expect(arguments.length).not().toBe.greaterThan(2);
      if (this._events && this._events.hasOwnProperty(name)) {
        listeners = this.getListeners(name);
        i = 0;
        n = listeners.length;
        while (i < n) {
          listener = listeners[i];
          if (listener === null) {
            if (i !== n - 1) {
              tmp = listeners[n - 1];
              listeners[n - 1] = listener;
              listeners[i] = tmp;
            }
            listeners.pop();
            n--;
            continue;
          }
          listener.call(this, param);
          i++;
        }
      }
      return this;
    };

    return Emitter;

  })();

}).call(this);


return module.exports;
})();modules['../document/element/element/tag/stringify.coffee'] = (function(){
var module = {exports: modules["../document/element/element/tag/stringify.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var SINGLE_TAG, booleanAttribs, getInnerHTML, getOuterHTML, isPublic;

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

  isPublic = function(name) {
    return name.indexOf('neft:') !== 0;
  };

  getInnerHTML = function(elem) {
    var child, r, _i, _len, _ref;
    if (elem.children) {
      r = "";
      _ref = elem.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        r += getOuterHTML(child);
      }
      return r;
    } else {
      return "";
    }
  };

  getOuterHTML = function(elem) {
    var attrName, attrValue, name, nameRet, ret, _ref;
    if (elem._visible === false) {
      return "";
    }
    if (elem._text !== void 0) {
      return elem._text;
    }
    name = elem.name;
    if (!name || !isPublic(name)) {
      return getInnerHTML(elem);
    }
    nameRet = ret = "<" + name;
    _ref = elem._attrs;
    for (attrName in _ref) {
      attrValue = _ref[attrName];
      if (/^neft:/.test(attrName)) {
        continue;
      }
      ret += " " + attrName;
      if (attrValue == null) {
        if (!booleanAttribs[attrName]) {
          ret += "=\"\"";
        }
      } else {
        ret += "=\"" + attrValue + "\"";
      }
    }
    if (name === 'div' && ret === nameRet) {
      return getInnerHTML(elem);
    }
    if (SINGLE_TAG[name]) {
      return ret + ">";
    } else {
      return ret + ">" + getInnerHTML(elem) + "</" + name + ">";
    }
  };

  module.exports = {
    getInnerHTML: getInnerHTML,
    getOuterHTML: getOuterHTML
  };

  booleanAttribs = {
    __proto__: null,
    async: true,
    autofocus: true,
    autoplay: true,
    checked: true,
    controls: true,
    defer: true,
    disabled: true,
    hidden: true,
    loop: true,
    multiple: true,
    open: true,
    readonly: true,
    required: true,
    scoped: true,
    selected: true
  };

}).call(this);


return module.exports;
})();modules['../typed-array/index.coffee'] = (function(){
var module = {exports: modules["../typed-array/index.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var polyfill;

  polyfill = function(n) {
    var arr, i, _i;
    arr = new Array(n);
    for (i = _i = 0; _i < n; i = _i += 1) {
      arr[i] = 0;
    }
    return arr;
  };

  exports.Int8 = (function() {
    if (typeof Int8Array !== 'undefined') {
      return Int8Array;
    } else {
      return polyfill;
    }
  })();

  exports.Uint8 = (function() {
    if (typeof Uint8Array !== 'undefined') {
      return Uint8Array;
    } else {
      return polyfill;
    }
  })();

  exports.Int16 = (function() {
    if (typeof Int16Array !== 'undefined') {
      return Int16Array;
    } else {
      return polyfill;
    }
  })();

  exports.Uint16 = (function() {
    if (typeof Uint16Array !== 'undefined') {
      return Uint16Array;
    } else {
      return polyfill;
    }
  })();

  exports.Int32 = (function() {
    if (typeof Int32Array !== 'undefined') {
      return Int32Array;
    } else {
      return polyfill;
    }
  })();

  exports.Uint32 = (function() {
    if (typeof Uint32Array !== 'undefined') {
      return Uint32Array;
    } else {
      return polyfill;
    }
  })();

  exports.Float32 = (function() {
    if (typeof Float32Array !== 'undefined') {
      return Float32Array;
    } else {
      return polyfill;
    }
  })();

  exports.Float64 = (function() {
    if (typeof Float64Array !== 'undefined') {
      return Float64Array;
    } else {
      return polyfill;
    }
  })();

}).call(this);


return module.exports;
})();modules['../renderer/impl.coffee'] = (function(){
var module = {exports: modules["../renderer/impl.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","./impl/base":"../renderer/impl/base/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils;

  assert = console.assert;

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer) {
    var TYPES, abstractImpl, extra, impl, name, platformImpl, type, _i, _j, _k, _len, _len1, _len2, _ref;
    impl = abstractImpl = require('./impl/base');
    impl.Renderer = Renderer;
    impl.window = null;
    signal.create(impl, 'onWindowReady');
    TYPES = ['Item', 'Image', 'Text', 'TextInput', 'FontLoader', 'ResourcesLoader', 'Device', 'Screen', 'Navigator', 'RotationSensor', 'Rectangle', 'Grid', 'Column', 'Row', 'Flow', 'Animation', 'PropertyAnimation', 'NumberAnimation', 'Scrollable', 'AmbientSound'];
    platformImpl = (function() {
      var r;
      r = null;
      if (utils.isBrowser && (window.HTMLCanvasElement != null)) {
        try {
          if (r == null) {
            r = require('./impl/pixi')(impl);
          }
        } catch (_error) {}
      }
      if (utils.isBrowser) {
        if (r == null) {
          r = require('./impl/css')(impl);
        }
      }
      if (utils.isQml) {
        if (r == null) {
          r = require('./impl/qml')(impl);
        }
      }
      return r;
    })();
    for (_i = 0, _len = TYPES.length; _i < _len; _i++) {
      name = TYPES[_i];
      type = impl.Types[name] = impl.Types[name](impl);
      utils.merge(impl, type);
    }
    if (platformImpl) {
      utils.mergeDeep(impl, platformImpl);
    }
    for (_j = 0, _len1 = TYPES.length; _j < _len1; _j++) {
      name = TYPES[_j];
      if (typeof impl.Types[name] === 'function') {
        type = impl.Types[name] = impl.Types[name](impl);
        utils.merge(impl, type);
      }
    }
    for (_k = 0, _len2 = TYPES.length; _k < _len2; _k++) {
      name = TYPES[_k];
      if (impl.Types[name].createData) {
        impl.Types[name].createData = impl.Types[name].createData();
      }
    }
    _ref = impl.Extras;
    for (name in _ref) {
      extra = _ref[name];
      extra = impl.Extras[name] = extra(impl);
      utils.merge(impl, extra);
    }
    impl.createObject = function(object, type) {
      var obj, _ref1, _ref2, _ref3;
      obj = object;
      while (type && (impl.Types[type] == null)) {
        obj = Object.getPrototypeOf(obj);
        type = obj.constructor.__name__;
      }
      object._impl = ((_ref1 = impl.Types[type]) != null ? typeof _ref1.createData === "function" ? _ref1.createData() : void 0 : void 0) || {
        bindings: null
      };
      Object.preventExtensions(object._impl);
      return (_ref2 = impl.Types[type]) != null ? (_ref3 = _ref2.create) != null ? _ref3.call(object, object._impl) : void 0 : void 0;
    };
    impl.setWindow = (function(_super) {
      return function(item) {
        utils.defineProperty(impl, 'window', utils.ENUMERABLE, item);
        _super.call(impl, item);
        impl.onWindowReady.emit();
        return item.keys.focus = true;
      };
    })(impl.setWindow);
    return impl;
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/item.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/item.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
    var DATA, NOP;
    NOP = function() {};
    DATA = {
      bindings: null,
      anchors: null
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function(data) {},
      setItemParent: function(val) {},
      setItemIndex: function(val) {
        var child, children, i, item, parent, tmp, _i, _j, _len, _ref;
        parent = this.parent;
        children = parent.children;
        tmp = [];
        impl.setItemParent.call(this, null);
        for (i = _i = val, _ref = children.length; _i < _ref; i = _i += 1) {
          child = children[i];
          if (child !== this) {
            impl.setItemParent.call(child, null);
            tmp.push(child);
          }
        }
        impl.setItemParent.call(this, parent);
        for (_j = 0, _len = tmp.length; _j < _len; _j++) {
          item = tmp[_j];
          impl.setItemParent.call(item, parent);
        }
      },
      setItemBackground: function(val) {},
      setItemForeground: function(val) {},
      setItemVisible: function(val) {},
      setItemClip: function(val) {},
      setItemWidth: function(val) {},
      setItemHeight: function(val) {},
      setItemX: function(val) {},
      setItemY: function(val) {},
      setItemZ: function(val) {},
      setItemScale: function(val) {},
      setItemRotation: function(val) {},
      setItemOpacity: function(val) {},
      setItemLinkUri: function(val) {},
      doItemOverlap: function(item) {
        var a, b, parent1, parent2, tmp, x1, x2, y1, y2;
        a = this;
        b = item;
        tmp = null;
        x1 = a._x;
        y1 = a._y;
        x2 = b._x;
        y2 = b._y;
        parent1 = a;
        while (tmp = parent1._parent) {
          x1 += tmp._x;
          y1 += tmp._y;
          parent1 = tmp;
        }
        parent2 = b;
        while (tmp = parent2._parent) {
          x1 += tmp._x;
          y1 += tmp._y;
          parent2 = tmp;
        }
        return parent1 === parent2 && x1 + a._width > x2 && y1 + a._height > y2 && x1 < x2 + b._width && y1 < y2 + b._height;
      },
      attachItemSignal: function(name, signal) {},
      setItemPointerEnabled: function(val) {},
      setItemPointerDraggable: function(val) {},
      setItemPointerDragging: function(val) {},
      setItemKeysFocus: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/image.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/image.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA;
    DATA = {
      source: ''
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        return impl.Types.Item.create.call(this, data);
      },
      setStaticImagePixelRatio: function(val) {},
      setImageSource: function(val) {
        return this._impl.source = val;
      },
      setImageSourceWidth: function(val) {},
      setImageSourceHeight: function(val) {},
      setImageFillMode: function(val) {},
      setImageOffsetX: function(val) {},
      setImageOffsetY: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/text.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/text.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA, items;
    items = impl.items;
    DATA = {
      text: '',
      linkColor: 'blue',
      color: 'black',
      lineHeight: 1,
      fontFamily: 'sans-serif',
      fontPixelSize: 14,
      fontWeight: 0.5,
      fontWordSpacing: 0,
      fontLetterSpacing: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        return impl.Types.Item.create.call(this, data);
      },
      setText: function(val) {},
      setTextColor: function(val) {},
      setTextLinkColor: function(val) {},
      setTextLineHeight: function(val) {},
      setTextFontFamily: function(val) {},
      setTextFontPixelSize: function(val) {},
      setTextFontWeight: function(val) {},
      setTextFontWordSpacing: function(val) {},
      setTextFontLetterSpacing: function(val) {},
      setTextAlignmentHorizontal: function(val) {},
      setTextAlignmentVertical: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/textInput.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/textInput.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA;
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Text', DATA),
      create: function(data) {
        return impl.Types.Text.create.call(this, data);
      },
      setTextInputText: function(val) {},
      setTextInputColor: function(val) {},
      setTextInputLineHeight: function(val) {},
      setTextInputMultiLine: function(val) {},
      setTextInputEchoMode: function(val) {},
      setTextInputFontFamily: function(val) {},
      setTextInputFontPixelSize: function(val) {},
      setTextInputFontWeight: function(val) {},
      setTextInputFontWordSpacing: function(val) {},
      setTextInputFontLetterSpacing: function(val) {},
      setTextInputFontItalic: function(val) {},
      setTextInputAlignmentHorizontal: function(val) {},
      setTextInputAlignmentVertical: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/loader/font.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/loader/font.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      loadFont: function(sources, name) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/loader/resources.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/loader/resources.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      loadResources: function(resources) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/device.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/device.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      initDeviceNamespace: function() {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/screen.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/screen.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      initScreenNamespace: function() {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/navigator.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/navigator.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      initNavigatorNamespace: function() {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/sensor/rotation.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/sensor/rotation.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    return {
      enableRotationSensor: function() {},
      disableRotationSensor: function() {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/sound/ambient.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/sound/ambient.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA;
    DATA = {
      bindings: null
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function(data) {},
      setAmbientSoundSource: function(val) {},
      setAmbientSoundLoop: function(val) {},
      startAmbientSound: function(val) {},
      stopAmbientSound: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/rectangle.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/rectangle.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var COLOR_RESOURCE_REQUEST, DATA, NOP, getRectangleSource, items, round, updateImage, updateImageIfNeeded;
    items = impl.items;
    round = Math.round;
    COLOR_RESOURCE_REQUEST = {
      property: 'color'
    };
    NOP = function() {};
    getRectangleSource = function(item) {
      var borderColor, color, height, pixelRatio, radius, strokeWidth, width, _ref, _ref1;
      pixelRatio = impl.pixelRatio;
      width = round(item.width * pixelRatio);
      height = round(item.height * pixelRatio);
      radius = round(item.radius * pixelRatio);
      strokeWidth = round(Math.min(item.border.width * 2 * pixelRatio, width, height));
      color = ((_ref = impl.Renderer.resources) != null ? _ref.resolve(item.color, COLOR_RESOURCE_REQUEST) : void 0) || item.color;
      borderColor = ((_ref1 = impl.Renderer.resources) != null ? _ref1.resolve(item.border.color, COLOR_RESOURCE_REQUEST) : void 0) || item.border.color;
      if (width <= 0 || height <= 0) {
        item._impl.isRectVisible = false;
        return null;
      } else {
        item._impl.isRectVisible = true;
      }
      return "data:image/svg+xml;utf8," + ("<svg width='" + width + "' height='" + height + "' xmlns='http://www.w3.org/2000/svg'>") + "<clipPath id='clip'>" + "<rect " + ("rx='" + radius + "' ") + ("width='" + width + "' height='" + height + "' />") + "</clipPath>" + "<rect " + "clip-path='url(#clip)' " + ("fill='" + color + "' ") + ("stroke='" + borderColor + "' ") + ("stroke-width='" + strokeWidth + "' ") + ("rx='" + radius + "' ") + ("width='" + width + "' height='" + height + "' />") + "</svg>";
    };
    updateImage = function() {
      impl.setImageSource.call(this, getRectangleSource(this), NOP);
    };
    updateImageIfNeeded = function() {
      if (!this._impl.isRectVisible || this.radius > 0 || this.border.width > 0) {
        updateImage.call(this);
      }
    };
    DATA = {
      isRectVisible: false
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Image', DATA),
      create: function(data) {
        impl.Types.Image.create.call(this, data);
        this.onWidthChange(updateImageIfNeeded);
        return this.onHeightChange(updateImageIfNeeded);
      },
      setRectangleColor: updateImage,
      setRectangleRadius: updateImage,
      setRectangleBorderColor: updateImage,
      setRectangleBorderWidth: updateImage
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/grid.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/grid.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
    var grid;
    grid = impl.utils.grid;
    return {
      DATA: grid.DATA,
      createData: impl.utils.createDataCloner('Item', grid.DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
        return grid.create(this, grid.COLUMN | grid.ROW);
      },
      setGridEffectItem: grid.setEffectItem,
      setGridColumns: grid.update,
      setGridRows: grid.update,
      setGridColumnSpacing: grid.update,
      setGridRowSpacing: grid.update,
      setGridAlignmentHorizontal: grid.update,
      setGridAlignmentVertical: grid.update,
      setGridIncludeBorderMargins: grid.update
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/column.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/column.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var grid;
    grid = impl.utils.grid;
    return {
      DATA: grid.DATA,
      createData: impl.utils.createDataCloner('Item', grid.DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
        return grid.create(this, grid.COLUMN);
      },
      setColumnEffectItem: grid.setEffectItem,
      setColumnSpacing: grid.update,
      setColumnAlignmentHorizontal: grid.update,
      setColumnAlignmentVertical: grid.update,
      setColumnIncludeBorderMargins: grid.update
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/row.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/row.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var grid;
    grid = impl.utils.grid;
    return {
      DATA: grid.data,
      createData: impl.utils.createDataCloner('Item', grid.DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
        return grid.create(this, grid.ROW);
      },
      setRowEffectItem: grid.setEffectItem,
      setRowSpacing: grid.update,
      setRowAlignmentHorizontal: grid.update,
      setRowAlignmentVertical: grid.update,
      setRowIncludeBorderMargins: grid.update
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/flow.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/flow.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","typed-array":"../typed-array/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var MAX_LOOPS, TypedArray, disableChild, elementsBottomMargin, elementsRow, elementsX, elementsY, enableChild, getArray, getCleanArray, log, max, min, onChildrenChange, onHeightChange, onWidthChange, pending, queue, queueIndex, queues, rowsFills, rowsHeight, rowsWidth, unusedFills, update, updateItem, updateItems, updateSize, utils;

  utils = require('utils');

  log = require('log');

  TypedArray = require('typed-array');

  log = log.scope('Renderer', 'Flow');

  MAX_LOOPS = 50;

  min = function(a, b) {
    if (a < b) {
      return a;
    } else {
      return b;
    }
  };

  max = function(a, b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  };

  getArray = function(arr, len) {
    if (arr.length < len) {
      return new arr.constructor(len * 1.4 | 0);
    } else {
      return arr;
    }
  };

  getCleanArray = function(arr, len) {
    var i, newArr, _i;
    newArr = getArray(arr, len);
    if (newArr === arr) {
      for (i = _i = 0; _i < len; i = _i += 1) {
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

  rowsWidth = new TypedArray.Uint32(64);

  rowsHeight = new TypedArray.Uint32(64);

  elementsX = new TypedArray.Uint32(64);

  elementsY = new TypedArray.Uint32(64);

  elementsRow = new TypedArray.Uint32(64);

  elementsBottomMargin = new TypedArray.Uint32(64);

  rowsFills = new TypedArray.Uint8(64);

  unusedFills = new TypedArray.Uint8(64);

  updateItem = function(item) {
    var alignH, alignV, anchors, autoHeight, autoWidth, bottom, bottomMargin, bottomPadding, cell, child, childLayoutMargin, children, collapseMargins, columnSpacing, currentRow, currentRowBottomMargin, currentRowY, currentYShift, data, effectItem, flowHeight, flowWidth, freeHeightSpace, height, i, includeBorderMargins, lastColumnRightMargin, lastRowBottomMargin, layout, leftMargin, leftPadding, length, margin, maxFlowWidth, maxLen, multiplierX, multiplierY, outerBottomMargin, outerLeftMargin, outerRightMargin, outerTopMargin, padding, perCell, plusY, right, rightMargin, rightPadding, row, rowSpacing, rowsFillsSum, topMargin, topPadding, update, visibleChildrenIndex, width, x, y, yShift, _i, _j, _k, _l, _len, _len1, _len2, _ref, _ref1, _ref2;
    if (!(effectItem = item._effectItem)) {
      return;
    }
    includeBorderMargins = item.includeBorderMargins, collapseMargins = item.collapseMargins;
    children = effectItem._children;
    data = item._impl;
    autoWidth = data.autoWidth, autoHeight = data.autoHeight;
    if ((_ref = item._children) != null ? _ref._layout : void 0) {
      return;
    }
    if (layout = effectItem._layout) {
      autoWidth && (autoWidth = !layout._fillWidth);
      autoHeight && (autoHeight = !layout._fillHeight);
    }
    if (data.loops === MAX_LOOPS) {
      log.error("Potential Flow loop detected. Recalculating on this item (" + (item.toString()) + ") has been disabled.");
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
    maxFlowWidth = autoWidth ? Infinity : effectItem._width - leftPadding - rightPadding;
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
    outerTopMargin = outerRightMargin = outerBottomMargin = outerLeftMargin = 0;
    currentRow = currentRowY = 0;
    lastColumnRightMargin = lastRowBottomMargin = currentRowBottomMargin = 0;
    x = y = right = bottom = 0;
    rowsFillsSum = visibleChildrenIndex = 0;
    for (i = _i = 0, _len = children.length; _i < _len; i = ++_i) {
      child = children[i];
      if (!child._visible) {
        continue;
      }
      margin = child._margin;
      layout = child._layout;
      width = child._width;
      height = child._height;
      if (margin) {
        topMargin = margin._top;
        rightMargin = margin._right;
        bottomMargin = margin._bottom;
        leftMargin = margin._left;
        if (childLayoutMargin = (_ref1 = child._children) != null ? (_ref2 = _ref1._layout) != null ? _ref2._margin : void 0 : void 0) {
          if (collapseMargins) {
            topMargin = max(topMargin, childLayoutMargin._top);
            rightMargin = max(rightMargin, childLayoutMargin._right);
            bottomMargin = max(bottomMargin, childLayoutMargin._bottom);
            leftMargin = max(leftMargin, childLayoutMargin._left);
          } else {
            topMargin += childLayoutMargin._top;
            rightMargin += childLayoutMargin._right;
            bottomMargin += childLayoutMargin._bottom;
            leftMargin += childLayoutMargin._left;
          }
        }
      } else {
        topMargin = rightMargin = bottomMargin = leftMargin = 0;
      }
      if (layout) {
        if (!layout._enabled) {
          continue;
        }
        if (layout._fillWidth && !autoWidth) {
          width = maxFlowWidth;
          if (includeBorderMargins) {
            width -= leftMargin + rightMargin;
          }
          child.width = width;
        }
      }
      right = 0;
      if (includeBorderMargins || x > 0) {
        if (collapseMargins) {
          x += max(leftMargin + (x > 0 ? columnSpacing : 0), lastColumnRightMargin);
        } else {
          x += leftMargin + lastColumnRightMargin + (x > 0 ? columnSpacing : 0);
        }
      }
      right += x + width;
      if (includeBorderMargins) {
        right += rightMargin;
      }
      if (right > maxFlowWidth && visibleChildrenIndex > 0) {
        right -= x;
        x = right - width;
        currentRowY += rowsHeight[currentRow];
        currentRow++;
        lastRowBottomMargin = currentRowBottomMargin;
        currentRowBottomMargin = 0;
        if (!includeBorderMargins) {
          outerRightMargin = max(outerRightMargin, lastColumnRightMargin);
        }
      }
      if (layout && layout._fillHeight && !autoHeight) {
        rowsFills[currentRow] = max(rowsFills[currentRow], rowsFills[currentRow] + 1);
        rowsFillsSum++;
        height = 0;
        elementsBottomMargin[i] = bottomMargin;
      }
      bottom = y + height;
      y = currentRowY;
      if (includeBorderMargins || y > 0) {
        if (collapseMargins) {
          y += max(lastRowBottomMargin, topMargin + (y > 0 ? rowSpacing : 0));
        } else {
          y += lastRowBottomMargin + topMargin + (y > 0 ? rowSpacing : 0);
        }
      }
      if (!includeBorderMargins && x === 0) {
        outerLeftMargin = max(outerLeftMargin, leftMargin);
      }
      if (!includeBorderMargins && y === 0) {
        outerTopMargin = max(outerTopMargin, topMargin);
      }
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
    if (includeBorderMargins) {
      flowHeight = max(flowHeight, flowHeight + currentRowBottomMargin);
    }
    if (!includeBorderMargins) {
      outerBottomMargin = currentRowBottomMargin;
    }
    item.margin.top = outerTopMargin;
    item.margin.right = outerRightMargin;
    item.margin.bottom = outerBottomMargin;
    item.margin.left = outerLeftMargin;
    if (effectItem !== item) {
      effectItem.onMarginChange.emit(effectItem.margin);
    }
    freeHeightSpace = effectItem._height - topPadding - bottomPadding - flowHeight;
    if (freeHeightSpace > 0 && rowsFillsSum > 0) {
      unusedFills = getCleanArray(unusedFills, currentRow + 1);
      length = currentRow + 1;
      perCell = (flowHeight + freeHeightSpace) / length;
      update = true;
      while (update) {
        update = false;
        for (i = _j = 0; _j <= currentRow; i = _j += 1) {
          if (unusedFills[i] === 0 && (rowsFills[i] === 0 || rowsHeight[i] > perCell)) {
            length--;
            perCell -= (rowsHeight[i] - perCell) / length;
            unusedFills[i] = 1;
            update = true;
          }
        }
      }
      yShift = currentYShift = 0;
      for (i = _k = 0, _len1 = children.length; _k < _len1; i = ++_k) {
        child = children[i];
        if (elementsRow[i] === row + 1 && unusedFills[row] === 0) {
          yShift += currentYShift;
          currentYShift = 0;
        }
        row = elementsRow[i];
        elementsY[i] += yShift;
        if (unusedFills[row] === 0) {
          layout = child._layout;
          if (layout && layout._fillHeight && layout._enabled) {
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
      flowWidth = effectItem._width - leftPadding - rightPadding;
    }
    if (!autoHeight) {
      flowHeight = effectItem._height - topPadding - bottomPadding;
    }
    for (i = _l = 0, _len2 = children.length; _l < _len2; i = ++_l) {
      child = children[i];
      if (!child._visible) {
        continue;
      }
      cell = elementsRow[i];
      anchors = child._anchors;
      layout = child._layout;
      if (layout && !layout._enabled) {
        continue;
      }
      if (!anchors || !anchors._autoX) {
        child.x = elementsX[i] + (flowWidth - rowsWidth[cell]) * multiplierX + leftPadding;
      }
      if (!anchors || !anchors._autoY) {
        child.y = elementsY[i] + plusY + (rowsHeight[cell] - child._height) * multiplierY + topPadding;
      }
    }
    if (autoWidth) {
      effectItem.width = flowWidth + leftPadding + rightPadding;
    }
    if (autoHeight) {
      effectItem.height = flowHeight + topPadding + bottomPadding;
    }
  };

  updateItems = function() {
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

  update = function() {
    var data, _ref;
    data = this._impl;
    if (data.pending || !((_ref = this._effectItem) != null ? _ref._visible : void 0)) {
      return;
    }
    if (data.updatePending) {
      data.loops++;
    } else {
      data.loops = 0;
    }
    data.pending = true;
    queue.push(this);
    if (!pending) {
      setImmediate(updateItems);
      pending = true;
    }
  };

  updateSize = function() {
    if (!this._impl.updatePending) {
      update.call(this);
    }
  };

  onWidthChange = function(oldVal) {
    var layout;
    if (this._effectItem && !this._impl.updatePending && (!(layout = this._effectItem._layout) || !layout._fillWidth)) {
      this._impl.autoWidth = this._effectItem._width === 0 && oldVal !== -1;
    }
    return updateSize.call(this);
  };

  onHeightChange = function(oldVal) {
    var layout;
    if (this._effectItem && !this._impl.updatePending && (!(layout = this._effectItem._layout) || !layout._fillHeight)) {
      this._impl.autoHeight = this._effectItem._height === 0 && oldVal !== -1;
    }
    return updateSize.call(this);
  };

  enableChild = function(child) {
    child.onVisibleChange(update, this);
    child.onWidthChange(update, this);
    child.onHeightChange(update, this);
    child.onMarginChange(update, this);
    child.onAnchorsChange(update, this);
    return child.onLayoutChange(update, this);
  };

  disableChild = function(child) {
    child.onVisibleChange.disconnect(update, this);
    child.onWidthChange.disconnect(update, this);
    child.onHeightChange.disconnect(update, this);
    child.onMarginChange.disconnect(update, this);
    child.onAnchorsChange.disconnect(update, this);
    return child.onLayoutChange.disconnect(update, this);
  };

  onChildrenChange = function(added, removed) {
    if (added) {
      enableChild.call(this, added);
    }
    if (removed) {
      disableChild.call(this, removed);
    }
    return update.call(this);
  };

  module.exports = function(impl) {
    var DATA;
    DATA = {
      loops: 0,
      pending: false,
      updatePending: false,
      autoWidth: true,
      autoHeight: true
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
        return this.onAlignmentChange(updateSize);
      },
      setFlowEffectItem: function(item, oldItem) {
        var child, _i, _j, _len, _len1, _ref, _ref1;
        if (oldItem) {
          oldItem.onVisibleChange.disconnect(update, this);
          oldItem.onChildrenChange.disconnect(onChildrenChange, this);
          oldItem.onLayoutChange.disconnect(update, this);
          oldItem.onWidthChange.disconnect(onWidthChange, this);
          oldItem.onHeightChange.disconnect(onHeightChange, this);
          if (this._impl.autoWidth) {
            oldItem.width = 0;
          }
          if (this._impl.autoHeight) {
            oldItem.height = 0;
          }
          _ref = oldItem.children;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            disableChild.call(this, child);
          }
        }
        if (item) {
          if (this._impl.autoWidth = item.width === 0) {
            item.width = -1;
          }
          if (this._impl.autoHeight = item.height === 0) {
            item.height = -1;
          }
          item.onVisibleChange(update, this);
          item.onChildrenChange(onChildrenChange, this);
          item.onLayoutChange(update, this);
          item.onWidthChange(onWidthChange, this);
          item.onHeightChange(onHeightChange, this);
          _ref1 = item.children;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            child = _ref1[_j];
            enableChild.call(this, child);
          }
          update.call(this);
        }
      },
      setFlowColumnSpacing: update,
      setFlowRowSpacing: update,
      setFlowIncludeBorderMargins: update,
      setFlowCollapseMargins: update
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/animation.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/animation.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA;
    DATA = {
      bindings: null
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function(data) {},
      setAnimationLoop: function(val) {},
      startAnimation: function() {},
      stopAnimation: function() {},
      resumeAnimation: function() {},
      pauseAnimation: function() {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/animation/property.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/animation/property.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA, EASINGS, Types, items;
    Types = impl.Types, items = impl.items;
    EASINGS = {
      Linear: function(t, b, c, d) {
        return c * (t / d) + b;
      },
      InQuad: function(t, b, c, d) {
        return c * (t /= d) * t + b;
      },
      OutQuad: function(t, b, c, d) {
        return -c * (t /= d) * (t - 2) + b;
      },
      InOutQuad: function(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t + b;
        } else {
          return -c / 2 * ((--t) * (t - 2) - 1) + b;
        }
      },
      InCubic: function(t, b, c, d) {
        return c * (t /= d) * t * t + b;
      },
      OutCubic: function(t, b, c, d) {
        return c * ((t = t / d - 1) * t * t + 1) + b;
      },
      InOutCubic: function(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t + b;
        } else {
          return c / 2 * ((t -= 2) * t * t + 2) + b;
        }
      },
      InQuart: function(t, b, c, d) {
        return c * (t /= d) * t * t * t + b;
      },
      OutQuart: function(t, b, c, d) {
        return -c * ((t = t / d - 1) * t * t * t - 1) + b;
      },
      InOutQuart: function(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t * t + b;
        } else {
          return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
        }
      },
      InQuint: function(t, b, c, d) {
        return c * (t /= d) * t * t * t * t + b;
      },
      OutQuint: function(t, b, c, d) {
        return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
      },
      InOutQuint: function(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return c / 2 * t * t * t * t * t + b;
        } else {
          return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
        }
      },
      InSine: function(t, b, c, d) {
        return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
      },
      OutSine: function(t, b, c, d) {
        return c * Math.sin(t / d * (Math.PI / 2)) + b;
      },
      InOutSine: function(t, b, c, d) {
        return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
      },
      InExpo: function(t, b, c, d) {
        if (t === 0) {
          return b;
        } else {
          return c * Math.pow(2, 10 * (t / d - 1)) + b;
        }
      },
      OutExpo: function(t, b, c, d) {
        if (t === d) {
          return b + c;
        } else {
          return c * (-Math.pow(2, -10 * t / d) + 1) + b;
        }
      },
      InOutExpo: function(t, b, c, d) {
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
      InCirc: function(t, b, c, d) {
        return -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b;
      },
      OutCirc: function(t, b, c, d) {
        return c * Math.sqrt(1 - (t = t / d - 1) * t) + b;
      },
      InOutCirc: function(t, b, c, d) {
        if ((t /= d / 2) < 1) {
          return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
        } else {
          return c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b;
        }
      },
      InElastic: function(t, b, c, d) {
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
      OutElastic: function(t, b, c, d) {
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
      InOutElastic: function(t, b, c, d) {
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
      InBack: function(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }
        return c * (t /= d) * t * ((s + 1) * t - s) + b;
      },
      OutBack: function(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }
        return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
      },
      InOutBack: function(t, b, c, d, s) {
        if (s == null) {
          s = 1.70158;
        }
        if ((t /= d / 2) < 1) {
          return c / 2 * (t * t * (((s *= 1.525) + 1) * t - s)) + b;
        } else {
          return c / 2 * ((t -= 2) * t * (((s *= 1.525) + 1) * t + s) + 2) + b;
        }
      },
      InBounce: function(t, b, c, d) {
        return c - EASINGS.OutBounce(d - t, 0, c, d) + b;
      },
      OutBounce: function(t, b, c, d) {
        if ((t /= d) < (1 / 2.75)) {
          return c * (7.5625 * t * t) + b;
        } else if (t < (2 / 2.75)) {
          return c * (7.5625 * (t -= 1.5 / 2.75) * t + .75) + b;
        } else if (t < (2.5 / 2.75)) {
          return c * (7.5625 * (t -= 2.25 / 2.75) * t + .9375) + b;
        } else {
          return c * (7.5625 * (t -= 2.625 / 2.75) * t + .984375) + b;
        }
      },
      InOutBounce: function(t, b, c, d) {
        if (t < d / 2) {
          return EASINGS.InBounce(t * 2, 0, c, d) * .5 + b;
        } else {
          return EASINGS.OutBounce(t * 2 - d, 0, c, d) * .5 + c * .5 + b;
        }
      }
    };
    DATA = {
      progress: 0,
      internalPropertyName: '',
      propertySetter: null,
      isIntegerProperty: false,
      easing: null,
      startDelay: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Animation', DATA),
      create: function(data) {
        data.easing = EASINGS.Linear;
        return impl.Types.Animation.create.call(this, data);
      },
      setPropertyAnimationTarget: function(val) {},
      setPropertyAnimationProperty: function(val) {
        this._impl.internalPropertyName = "_" + val;
        this._impl.propertySetter = impl.utils.SETTER_METHODS_NAMES[val];
        this._impl.isIntegerProperty = !!impl.utils.INTEGER_PROPERTIES[val];
      },
      setPropertyAnimationDuration: function(val) {},
      setPropertyAnimationStartDelay: function(val) {
        this._impl.startTime += val - this._impl.startDelay;
        return this._impl.startDelay = val;
      },
      setPropertyAnimationLoopDelay: function(val) {},
      setPropertyAnimationFrom: function(val) {
        return this._impl.from = val;
      },
      setPropertyAnimationTo: function(val) {
        return this._impl.to = val;
      },
      setPropertyAnimationUpdateData: function(val) {},
      setPropertyAnimationUpdateProperty: function(val) {},
      setPropertyAnimationEasingType: function(val) {
        return this._impl.easing = EASINGS[val] || EASINGS.Linear;
      },
      getPropertyAnimationProgress: function() {
        return this._impl.progress;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/animation/number.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/animation/number.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

  module.exports = function(impl) {
    var DATA, Types, now, nowTime, pending, round, updateAnimation, vsync;
    Types = impl.Types;
    now = Date.now;
    round = Math.round;
    pending = [];
    nowTime = now();
    vsync = function() {
      var anim, i, n;
      nowTime = now();
      i = 0;
      n = pending.length;
      while (i < n) {
        anim = pending[i];
        if (anim._running && !anim._paused) {
          updateAnimation(anim);
          i++;
        } else {
          pending[i] = pending[n - 1];
          pending[n - 1] = pending[pending.length - 1];
          pending.pop();
          n--;
        }
      }
      requestAnimationFrame(vsync);
    };
    if (typeof requestAnimationFrame === "function") {
      requestAnimationFrame(vsync);
    }
    updateAnimation = function(anim) {
      var data, progress, property, running, target, val;
      data = anim._impl;
      progress = (nowTime - data.startTime) / anim._duration;
      if (progress < 0) {
        data.progress = 0;
        return;
      } else if (progress > 1) {
        progress = 1;
      }
      data.progress = progress;
      running = progress !== 1 || (anim._running && anim._loop && anim._when);
      if (progress === 1) {
        val = data.to;
      } else {
        val = data.easing(anim._duration * progress, data.from, data.to - data.from, anim._duration);
      }
      target = anim._target;
      if (val === val && target && (property = anim._property)) {
        if (!running || anim._updateProperty || !data.propertySetter) {
          anim._updatePending = true;
          if (!running && target[data.internalPropertyName] === val) {
            target[data.internalPropertyName] = data.from;
          }
          target[property] = val;
          anim._updatePending = false;
          if (progress === 1 && data.propertySetter && target[property] === val) {
            impl[data.propertySetter].call(target, val);
          }
        } else {
          impl[data.propertySetter].call(target, val);
          if (anim._updateData) {
            target[data.internalPropertyName] = val;
          }
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
    DATA = {
      type: 'number',
      startTime: 0,
      pauseTime: 0,
      from: 0,
      to: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('PropertyAnimation', DATA),
      create: function(data) {
        return impl.Types.PropertyAnimation.create.call(this, data);
      },
      startAnimation: (function(_super) {
        return function() {
          var data;
          _super.call(this);
          if (this._impl.type === 'number') {
            data = this._impl;
            data.from = this._from;
            data.to = this._to;
            pending.push(this);
            data.startTime = nowTime;
            updateAnimation(this);
            data.startTime += this._startDelay;
          }
        };
      })(impl.startAnimation),
      stopAnimation: (function(_super) {
        return function() {
          var data;
          _super.call(this);
          data = this._impl;
          if (data.type === 'number' && data.startTime !== 0) {
            data.startTime = 0;
            updateAnimation(this);
          }
        };
      })(impl.stopAnimation),
      resumeAnimation: (function(_super) {
        return function() {
          var data;
          _super.call(this);
          if (this._impl.type === 'number') {
            data = this._impl;
            pending.push(this);
            data.startTime += Date.now() - data.pauseTime;
            data.pauseTime = 0;
          }
        };
      })(impl.resumeAnimation),
      pauseAnimation: (function(_super) {
        return function() {
          var data;
          _super.call(this);
          data = this._impl;
          if (data.type === 'number') {
            data.pauseTime = Date.now();
          }
        };
      })(impl.pauseAnimation)
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level2/scrollable.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level2/scrollable.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var MIN_POINTER_DELTA, WHEEL_DIVISOR, signal, utils;

  utils = require('utils');

  signal = require('signal');

  WHEEL_DIVISOR = 3;

  MIN_POINTER_DELTA = 7;

  module.exports = function(impl) {
    var DATA, DELTA_VALIDATION_PENDING, Types, createContinuous, getDeltaX, getDeltaY, getItemGlobalScale, getLimitedX, getLimitedY, lastActionTimestamp, onHeightChange, onImplReady, onWidthChange, outQuint, pointerUsed, pointerWindowMoveListeners, scroll, usePointer, useWheel, wheelUsed;
    Types = impl.Types;
    if (impl._scrollableUsePointer == null) {
      impl._scrollableUsePointer = true;
    }
    if (impl._scrollableUseWheel == null) {
      impl._scrollableUseWheel = true;
    }
    outQuint = function(t, b, c, d) {
      return c * (t / d) + b;
    };

    /*
    	Scroll container by given x and y deltas
     */
    scroll = (function() {
      return function(item, x, y) {
        var deltaX, deltaY, limitedX, limitedY;
        if (x == null) {
          x = 0;
        }
        if (y == null) {
          y = 0;
        }
        deltaX = getDeltaX(item, x);
        deltaY = getDeltaY(item, y);
        x = Math.round(item._contentX - deltaX);
        y = Math.round(item._contentY - deltaY);
        x = limitedX = getLimitedX(item, x);
        y = limitedY = getLimitedY(item, y);
        if (item._contentX !== x || item._contentY !== y) {
          item.contentX = x;
          item.contentY = y;
          return signal.STOP_PROPAGATION;
        }
      };
    })();
    getDeltaX = function(item, x) {
      return x / item._impl.globalScale;
    };
    getDeltaY = function(item, y) {
      return y / item._impl.globalScale;
    };
    getLimitedX = function(item, x) {
      var max;
      max = item._impl.contentItem._width - item._width;
      return Math.round(Math.max(0, Math.min(max, x)));
    };
    getLimitedY = function(item, y) {
      var max;
      max = item._impl.contentItem._height - item._height;
      return Math.round(Math.max(0, Math.min(max, y)));
    };
    getItemGlobalScale = function(item) {
      var val;
      val = item.scale;
      while (item = item.parent) {
        val *= item.scale;
      }
      return val;
    };
    createContinuous = function(item, prop) {
      var MIN_DISTANCE_TO_SNAP, amplitude, anim, contentProp, getSnapTarget, lastSnapTargetProp, positionProp, reversed, scrollAxis, shouldSnap, sizeProp, target, timestamp, velocity;
      MIN_DISTANCE_TO_SNAP = 4;
      velocity = 0;
      amplitude = 0;
      timestamp = 0;
      target = 0;
      reversed = false;
      shouldSnap = false;
      lastSnapTargetProp = (function() {
        switch (prop) {
          case 'x':
            return 'lastSnapTargetX';
          case 'y':
            return 'lastSnapTargetY';
        }
      })();
      scrollAxis = (function() {
        switch (prop) {
          case 'x':
            return function(val) {
              return scroll(item, val, 0);
            };
          case 'y':
            return function(val) {
              return scroll(item, 0, val);
            };
        }
      })();
      contentProp = (function() {
        switch (prop) {
          case 'x':
            return '_contentX';
          case 'y':
            return '_contentY';
        }
      })();
      positionProp = (function() {
        switch (prop) {
          case 'x':
            return '_x';
          case 'y':
            return '_y';
        }
      })();
      sizeProp = (function() {
        switch (prop) {
          case 'x':
            return '_width';
          case 'y':
            return '_height';
        }
      })();
      anim = function() {
        var delta, elapsed, targetDelta;
        if (amplitude !== 0) {
          elapsed = Date.now() - timestamp;
          if (shouldSnap) {
            targetDelta = item[contentProp] - target;
            if ((amplitude < 0 && targetDelta < 0) || (amplitude > 0 && targetDelta > 0)) {
              amplitude = -amplitude;
              if (reversed) {
                amplitude *= 0.3;
              } else {
                reversed = true;
              }
            }
          }
          delta = -amplitude * 0.7 * Math.exp(-elapsed / 325);
          if (shouldSnap) {
            if (targetDelta > MIN_DISTANCE_TO_SNAP || targetDelta < -MIN_DISTANCE_TO_SNAP) {
              if ((delta > 0 && delta < MIN_DISTANCE_TO_SNAP) || (delta === 0 && targetDelta > 0)) {
                delta = Math.min(targetDelta, 7);
              } else if ((delta < 0 && delta > -7) || delta === 0) {
                delta = Math.max(targetDelta, -7);
              }
            }
          }
          if ((!shouldSnap || targetDelta > MIN_DISTANCE_TO_SNAP || targetDelta < -MIN_DISTANCE_TO_SNAP) && (delta > 0.5 || delta < -0.5)) {
            scrollAxis(delta);
            requestAnimationFrame(anim);
          } else {
            scrollAxis(targetDelta);
          }
        }
      };
      getSnapTarget = function(contentPos) {
        var child, children, diff, minDiff, minVal, _i, _len, _ref, _ref1;
        children = ((_ref = item._snapItem) != null ? _ref._children : void 0) || ((_ref1 = item._contentItem) != null ? _ref1._children : void 0);
        minDiff = Infinity;
        minVal = 0;
        if (children) {
          for (_i = 0, _len = children.length; _i < _len; _i++) {
            child = children[_i];
            diff = contentPos - child[positionProp];
            if (velocity > 0) {
              diff += child[sizeProp] * 0.5;
            } else {
              diff -= child[sizeProp] * 0.5;
            }
            if (velocity >= 0 && diff >= 0 || velocity <= 0 && diff <= 0) {
              diff = Math.abs(diff);
              if (diff < minDiff) {
                minDiff = diff;
                minVal = child[positionProp];
              }
            }
          }
        }
        if (minDiff === Infinity) {
          return (child != null ? child[positionProp] : void 0) || 0;
        } else {
          return minVal;
        }
      };
      return {
        press: function() {
          velocity = amplitude = 0;
          reversed = false;
          return timestamp = Date.now();
        },
        release: function() {
          var data, shouldAnimate, snap, snapTarget;
          data = item._impl;
          snap = data.snap;
          if (Math.abs(velocity) < 5) {
            return;
          }
          amplitude = 0.8 * velocity;
          timestamp = Date.now();
          target = item[contentProp] + amplitude * 4;
          if (snap) {
            snapTarget = getSnapTarget(target);
            shouldSnap = data[lastSnapTargetProp] !== snapTarget;
            if (shouldSnap) {
              target = snapTarget;
              data[lastSnapTargetProp] = snapTarget;
            }
          }
          shouldAnimate = Math.abs(velocity) > 10;
          shouldAnimate || (shouldAnimate = snap && target === snapTarget);
          if (shouldAnimate) {
            anim();
          }
        },
        update: function(val) {
          var elapsed, now, v;
          now = Date.now();
          elapsed = now - timestamp;
          timestamp = now;
          v = 100 * -val / (1 + elapsed);
          velocity = 0.8 * v + 0.2 * velocity;
        }
      };
    };
    DELTA_VALIDATION_PENDING = 1;
    pointerWindowMoveListeners = [];
    onImplReady = function() {
      return impl.window.pointer.onMove(function(e) {
        var listener, r, stop, _i, _len;
        stop = false;
        for (_i = 0, _len = pointerWindowMoveListeners.length; _i < _len; _i++) {
          listener = pointerWindowMoveListeners[_i];
          r = listener(e);
          if (r === signal.STOP_PROPAGATION) {
            stop = true;
            break;
          }
          if (r === DELTA_VALIDATION_PENDING) {
            stop = true;
          }
        }
        if (stop) {
          return signal.STOP_PROPAGATION;
        }
      });
    };
    if (impl.window != null) {
      onImplReady();
    } else {
      impl.onWindowReady(onImplReady);
    }
    pointerUsed = false;
    usePointer = function(item) {
      var dx, dy, focus, horizontalContinuous, listen, moveMovement, verticalContinuous;
      horizontalContinuous = createContinuous(item, 'x');
      verticalContinuous = createContinuous(item, 'y');
      focus = false;
      listen = false;
      dx = dy = 0;
      moveMovement = function(e) {
        return scroll(item, e.movementX + dx, e.movementY + dy);
      };
      onImplReady = function() {
        pointerWindowMoveListeners.push(function(e) {
          var limitedX, limitedY;
          if (!listen) {
            return;
          }
          if (!focus) {
            if (pointerUsed) {
              return;
            }
            dx += e.movementX;
            dy += e.movementY;
            limitedX = getLimitedX(item, dx);
            limitedY = getLimitedY(item, dy);
            if (limitedX !== item._contentX || limitedY !== item._contentY) {
              if (Math.abs(limitedX - item._contentX) < MIN_POINTER_DELTA && Math.abs(limitedY - item._contentY) < MIN_POINTER_DELTA) {
                return DELTA_VALIDATION_PENDING;
              }
            }
            dx = dy = 0;
          }
          if (moveMovement(e) === signal.STOP_PROPAGATION) {
            focus = true;
            pointerUsed = true;
            item._impl.swingDisabled = true;
            horizontalContinuous.update(dx + e.movementX);
            verticalContinuous.update(dy + e.movementY);
          }
          return signal.STOP_PROPAGATION;
        });
        return impl.window.pointer.onRelease(function(e) {
          listen = false;
          dx = dy = 0;
          if (!focus) {
            return;
          }
          focus = false;
          pointerUsed = false;
          item._impl.swingDisabled = false;
          moveMovement(e);
          horizontalContinuous.release();
          verticalContinuous.release();
        });
      };
      if (impl.window != null) {
        onImplReady();
      } else {
        impl.onWindowReady(onImplReady);
      }
      return item.pointer.onPress(function(e) {
        listen = true;
        item._impl.globalScale = getItemGlobalScale(item);
        horizontalContinuous.press();
        verticalContinuous.press();
      });
    };
    wheelUsed = false;
    lastActionTimestamp = 0;
    useWheel = function(item) {
      var accepts, clear, horizontalContinuous, i, lastAcceptedActionTimestamp, maxX, maxY, minX, minY, pending, timer, used, verticalContinuous, x, y;
      i = 0;
      used = false;
      accepts = false;
      pending = false;
      clear = true;
      lastAcceptedActionTimestamp = 0;
      horizontalContinuous = createContinuous(item, 'x');
      verticalContinuous = createContinuous(item, 'y');
      x = y = 0;
      minX = minY = maxX = maxY = 0;
      timer = function() {
        var now;
        now = Date.now();
        if (accepts || now - lastAcceptedActionTimestamp > 70) {
          pending = false;
          accepts = true;
          horizontalContinuous.update(x);
          verticalContinuous.update(y);
          horizontalContinuous.release();
          verticalContinuous.release();
        } else {
          requestAnimationFrame(timer);
        }
      };
      item.pointer.onWheel(function(e) {
        var now;
        if (!item._impl.snap) {
          x = e.deltaX / WHEEL_DIVISOR;
          y = e.deltaY / WHEEL_DIVISOR;
          item._impl.globalScale = getItemGlobalScale(item);
          return scroll(item, x, y);
        }
        now = Date.now();
        if (now - lastActionTimestamp > 300) {
          wheelUsed = false;
        }
        lastActionTimestamp = now;
        if (wheelUsed && !used) {
          return;
        }
        if (!wheelUsed && !clear) {
          used = false;
          accepts = false;
          i = 0;
          minX = minY = maxX = maxY = 0;
        }
        i++;
        clear = false;
        x = e.deltaX / WHEEL_DIVISOR;
        y = e.deltaY / WHEEL_DIVISOR;
        if (x > 0 && x > maxX) {
          maxX = (maxX * (i - 1) + x) / i;
        } else if (x < minX) {
          minX = (minX * (i - 1) + x) / i;
        }
        if (y > 0 && y > maxY) {
          maxY = (maxY * (i - 1) + y) / i;
        } else if (y < minY) {
          minY = (minY * (i - 1) + y) / i;
        }
        if ((x > 0 && x < maxX * 0.3) || (x < 0 && x > minX * 0.3) || (y > 0 && y < maxY * 0.3) || (y < 0 && y > minY * 0.3)) {
          if (!accepts) {
            accepts = true;
            return signal.STOP_PROPAGATION;
          }
        } else {
          accepts = false;
        }
        if (accepts) {
          return signal.STOP_PROPAGATION;
        }
        item._impl.globalScale = getItemGlobalScale(item);
        if (scroll(item, x, y) === signal.STOP_PROPAGATION) {
          lastAcceptedActionTimestamp = now;
          if (!pending) {
            pending = true;
            horizontalContinuous.press();
            verticalContinuous.press();
            requestAnimationFrame(timer);
          } else {
            horizontalContinuous.update(x);
            verticalContinuous.update(y);
          }
          wheelUsed = true;
          used = true;
        }
        if (used) {
          return signal.STOP_PROPAGATION;
        }
      });
    };
    onWidthChange = function(oldVal) {
      if (this.contentItem.width < oldVal) {
        scroll(this);
      }
    };
    onHeightChange = function(oldVal) {
      if (this.contentItem.height < oldVal) {
        scroll(this);
      }
    };
    DATA = {
      contentItem: null,
      globalScale: 1,
      snap: false,
      lastSnapTargetX: 0,
      lastSnapTargetY: 0,
      swingPending: false,
      swingDisabled: false
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
        impl.setItemClip.call(this, true);
        if (impl._scrollableUsePointer) {
          usePointer(this);
        }
        if (impl._scrollableUseWheel) {
          useWheel(this);
        }
      },
      setScrollableContentItem: function(val) {
        var oldVal;
        if (oldVal = this._impl.contentItem) {
          impl.setItemParent.call(oldVal, null);
          oldVal.onWidthChange.disconnect(onWidthChange, this);
          oldVal.onHeightChange.disconnect(onHeightChange, this);
        }
        if (val) {
          impl.setItemParent.call(val, this);
          this._impl.contentItem = val;
          val.onWidthChange(onWidthChange, this);
          val.onHeightChange(onHeightChange, this);
        }
      },
      setScrollableContentX: function(val) {
        var _ref;
        if ((_ref = this._impl.contentItem) != null) {
          _ref.x = -val;
        }
      },
      setScrollableContentY: function(val) {
        var _ref;
        if ((_ref = this._impl.contentItem) != null) {
          _ref.y = -val;
        }
      },
      setScrollableSnap: function(val) {
        this._impl.snap = val;
      },
      setScrollableSnapItem: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/binding.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/binding.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var MAX_LOOPS, assert, getPropHandlerName, isArray, log, signal, utils;

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  assert = require('assert');

  log = log.scope('Renderer', 'Binding');

  isArray = Array.isArray;

  getPropHandlerName = (function() {
    var cache;
    cache = Object.create(null);
    return function(prop) {
      return cache[prop] || (cache[prop] = "on" + (utils.capitalize(prop)) + "Change");
    };
  })();

  MAX_LOOPS = 50;

  module.exports = function(impl) {
    var Binding, Connection, items;
    items = impl.items;
    Connection = (function() {
      var getSignalChangeListener, pool;

      pool = [];

      Connection.factory = function(binding, item, prop, parent) {
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

      function Connection(binding, item, prop, parent) {
        this.binding = binding;
        this.prop = prop;
        this.parent = parent;
        this.handlerName = getPropHandlerName(prop);
        this.isConnected = false;
        this.itemId = '';
        if (isArray(item)) {
          this.child = Connection.factory(binding, item[0], item[1], this);
          this.item = this.child.getValue();
        } else {
          this.itemId = item;
          this.child = null;
          this.item = Binding.getItemById(binding, item);
        }
        this.connect();
        Object.preventExtensions(this);
      }

      getSignalChangeListener = (function() {
        var noParent, withParent;
        withParent = function() {
          return this.parent.updateItem();
        };
        noParent = function() {
          return this.binding.update();
        };
        return function(connection) {
          if (connection.parent) {
            return withParent;
          } else {
            return noParent;
          }
        };
      })();

      Connection.prototype.update = function() {
        return getSignalChangeListener(this).call(this);
      };

      Connection.prototype.connect = function() {
        var handler;
        if (this.item) {
          handler = this.item[this.handlerName];
          if (handler != null) {
            this.isConnected = true;
            handler(getSignalChangeListener(this), this);
          }
        }
      };

      Connection.prototype.disconnect = function() {
        if (this.item && this.isConnected) {
          this.item[this.handlerName].disconnect(getSignalChangeListener(this), this);
        }
        this.isConnected = false;
      };

      Connection.prototype.updateItem = function() {
        var oldVal, val;
        oldVal = this.item;
        if (this.child) {
          val = this.child.getValue();
        } else {
          val = Binding.getItemById(this.binding, this.itemId);
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

      Connection.prototype.getValue = function() {
        var _ref;
        return (_ref = this.item) != null ? _ref[this.prop] : void 0;
      };

      Connection.prototype.destroy = function() {
        var _ref;
        this.disconnect();
        if ((_ref = this.child) != null) {
          _ref.destroy();
        }
        pool.push(this);
      };

      return Connection;

    })();
    Binding = (function() {
      var getDefaultValue, onComponentObjectChange, pool;

      pool = [];

      Binding.factory = function(obj, prop, binding, component, ctx) {
        var elem;
        if (elem = pool.pop()) {
          Binding.call(elem, obj, prop, binding, component, ctx);
          return elem;
        } else {
          return new Binding(obj, prop, binding, component, ctx);
        }
      };

      Binding.getItemById = function(binding, item) {
        if (item === 'this') {
          return binding.ctx;
        } else if (item === 'view') {
          return impl.Renderer.window;
        } else {
          return binding.component.objects[item] || impl.Renderer[item];
        }
      };

      onComponentObjectChange = function(id) {
        var conn, _i, _len, _ref;
        _ref = this.connections;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          conn = _ref[_i];
          while (conn.child) {
            conn = conn.child;
          }
          if (conn.itemId === id) {
            conn.updateItem();
          }
        }
      };

      function Binding(obj, prop, binding, component, ctx) {
        var connections, elem, item, _i, _len, _ref;
        this.obj = obj;
        this.prop = prop;
        this.component = component;
        this.ctx = ctx;
        assert.lengthOf(binding, 2);
        assert.isFunction(binding[0]);
        assert.isArray(binding[1]);
        item = this.item = obj._ref || obj;
        if (typeof component.onObjectChange === "function") {
          component.onObjectChange(onComponentObjectChange, this);
        }
        this.func = binding[0];
        this.args = component.objectsOrder;
        connections = this.connections || (this.connections = []);
        _ref = binding[1];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          elem = _ref[_i];
          if (isArray(elem)) {
            connections.push(Connection.factory(this, elem[0], elem[1]));
          }
        }
        //<development>;
        this.updatePending = false;
        this.updateLoop = 0;
        //</development>;
        Object.preventExtensions(this);
        this.update();
      }

      getDefaultValue = function(binding) {
        var val;
        val = binding.obj[binding.prop];
        switch (typeof val) {
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

      Binding.prototype.update = function() {
        var result;
        if (!this.args) {
          return;
        }
        //<development>;
        if (this.updatePending) {
          if (this.updateLoop > MAX_LOOPS) {
            return;
          }
          if (++this.updateLoop === MAX_LOOPS) {
            log.error("Potential loop detected. Property binding '" + this.prop + "' on item '" + (this.item.toString()) + "' has been disabled.");
            return;
          }
        } else {
          this.updateLoop = 0;
        }
        //</development>;
        result = utils.tryFunction(this.func, this.ctx, this.args);
        if (result == null) {
          result = getDefaultValue(this);
        }
        if (typeof result === 'number' && !isFinite(result)) {
          result = getDefaultValue(this);
        }
        //<development>;
        this.updatePending = true;
        //</development>;
        this.obj[this.prop] = result;
        //<development>;
        this.updatePending = false;
        //</development>;
      };

      Binding.prototype.destroy = function() {
        var connection, _i, _len, _ref, _ref1;
        _ref = this.connections;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          connection = _ref[_i];
          connection.destroy();
        }
        this.obj._impl.bindings[this.prop] = null;
        this.args = null;
        utils.clear(this.connections);
        if ((_ref1 = this.component.onObjectChange) != null) {
          _ref1.disconnect(onComponentObjectChange, this);
        }
        pool.push(this);
      };

      return Binding;

    })();
    return {
      setItemBinding: function(prop, binding, component, ctx) {
        var data, _ref;
        data = this._impl;
        if (data.bindings == null) {
          data.bindings = {};
        }
        if ((_ref = data.bindings[prop]) != null) {
          _ref.destroy();
        }
        if (binding != null) {
          data.bindings[prop] = Binding.factory(this, prop, binding, component, ctx);
        }
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level1/anchors.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level1/anchors.coffee"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, isArray, log;

  assert = require('neft-assert');

  log = require('log');

  log = log.scope('Renderer', 'Anchors');

  isArray = Array.isArray;

  module.exports = function(impl) {
    var Anchor, GET_ZERO, MAX_LOOPS, MultiAnchor, createAnchor, exports, getBaseAnchors, getBaseAnchorsPerAnchorType, getItemProp, getMarginValue, getSourceValue, getSourceWatchProps, getTargetValue, getTargetWatchProps, isMultiAnchor, onChildInsert, onChildPop, onChildrenChange, onNextSiblingChange, onParentChange, onPreviousSiblingChange, pending, queue, queueIndex, queues, update, updateItems;
    GET_ZERO = function() {
      return 0;
    };
    MAX_LOOPS = 10;
    queueIndex = 0;
    queues = [[], []];
    queue = queues[queueIndex];
    pending = false;
    updateItems = function() {
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
    update = function() {
      if (this.pending) {
        return;
      }
      this.pending = true;
      queue.push(this);
      if (!pending) {
        setImmediate(updateItems);
        pending = true;
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
      left: function(item) {
        return 0;
      },
      top: function(item) {
        return 0;
      },
      right: function(item) {
        return -item._width;
      },
      bottom: function(item) {
        return -item._height;
      },
      horizontalCenter: function(item) {
        return -item._width / 2;
      },
      verticalCenter: function(item) {
        return -item._height / 2;
      },
      fillWidthSize: function(item) {
        return 0;
      },
      fillHeightSize: function(item) {
        return 0;
      }
    };
    getTargetValue = {
      left: {
        parent: function(target) {
          return 0;
        },
        children: function(target) {
          return 0;
        },
        sibling: function(target) {
          return target._x;
        }
      },
      top: {
        parent: function(target) {
          return 0;
        },
        children: function(target) {
          return 0;
        },
        sibling: function(target) {
          return target._y;
        }
      },
      right: {
        parent: function(target) {
          return target._width;
        },
        sibling: function(target) {
          return target._x + target._width;
        }
      },
      bottom: {
        parent: function(target) {
          return target._height;
        },
        sibling: function(target) {
          return target._y + target._height;
        }
      },
      horizontalCenter: {
        parent: function(target) {
          return target._width / 2;
        },
        sibling: function(target) {
          return target._x + target._width / 2;
        }
      },
      verticalCenter: {
        parent: function(target) {
          return target._height / 2;
        },
        sibling: function(target) {
          return target._y + target._height / 2;
        }
      },
      fillWidthSize: {
        parent: function(target) {
          return target._width;
        },
        children: function(target) {
          var child, size, tmp, _i, _len;
          tmp = 0;
          size = 0;
          for (_i = 0, _len = target.length; _i < _len; _i++) {
            child = target[_i];
            if (child._visible) {
              tmp = child._width;
              if (tmp > size) {
                size = tmp;
              }
            }
          }
          return size;
        },
        sibling: function(target) {
          return target._width;
        }
      },
      fillHeightSize: {
        parent: function(target) {
          return target._height;
        },
        children: function(target) {
          var child, size, tmp, _i, _len;
          tmp = 0;
          size = 0;
          for (_i = 0, _len = target.length; _i < _len; _i++) {
            child = target[_i];
            if (child._visible) {
              tmp = child._height;
              if (tmp > size) {
                size = tmp;
              }
            }
          }
          return size;
        },
        sibling: function(target) {
          return target._height;
        }
      }
    };
    getMarginValue = {
      left: function(margin) {
        return margin._left;
      },
      top: function(margin) {
        return margin._top;
      },
      right: function(margin) {
        return -margin._right;
      },
      bottom: function(margin) {
        return -margin._bottom;
      },
      horizontalCenter: function(margin) {
        return margin._left - margin._right;
      },
      verticalCenter: function(margin) {
        return margin._top - margin._bottom;
      },
      fillWidthSize: function(margin) {
        return -margin._left - margin._right;
      },
      fillHeightSize: function(margin) {
        return -margin._top - margin._bottom;
      }
    };
    onParentChange = function(oldVal) {
      var handler, val, _i, _j, _len, _len1, _ref, _ref1;
      if (oldVal) {
        _ref = getTargetWatchProps[this.line].parent;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          oldVal[handler].disconnect(update, this);
        }
      }
      if (val = this.targetItem = this.item._parent) {
        _ref1 = getTargetWatchProps[this.line].parent;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          handler = _ref1[_j];
          val[handler](update, this);
        }
      }
      update.call(this);
    };
    onNextSiblingChange = function(oldVal) {
      var handler, val, _i, _j, _len, _len1, _ref, _ref1;
      if (oldVal) {
        _ref = getTargetWatchProps[this.line].sibling;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          oldVal[handler].disconnect(update, this);
        }
      }
      if (val = this.targetItem = this.item._nextSibling) {
        _ref1 = getTargetWatchProps[this.line].sibling;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          handler = _ref1[_j];
          val[handler](update, this);
        }
      }
      update.call(this);
    };
    onPreviousSiblingChange = function(oldVal) {
      var handler, val, _i, _j, _len, _len1, _ref, _ref1;
      if (oldVal) {
        _ref = getTargetWatchProps[this.line].sibling;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          oldVal[handler].disconnect(update, this);
        }
      }
      if (val = this.targetItem = this.item._previousSibling) {
        _ref1 = getTargetWatchProps[this.line].sibling;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          handler = _ref1[_j];
          val[handler](update, this);
        }
      }
      update.call(this);
    };
    onChildInsert = function(child) {
      child.onVisibleChange(update, this);
      if (this.source === 'fillWidthSize') {
        child.onWidthChange(update, this);
      }
      if (this.source === 'fillHeightSize') {
        child.onHeightChange(update, this);
      }
      update.call(this);
    };
    onChildPop = function(child) {
      child.onVisibleChange.disconnect(update, this);
      if (this.source === 'fillWidthSize') {
        child.onWidthChange.disconnect(update, this);
      }
      if (this.source === 'fillHeightSize') {
        child.onHeightChange.disconnect(update, this);
      }
      update.call(this);
    };
    onChildrenChange = function(added, removed) {
      if (added) {
        onChildInsert.call(this, added);
      }
      if (removed) {
        return onChildPop.call(this, removed);
      }
    };
    Anchor = (function() {
      var pool;

      pool = [];

      Anchor.factory = function(item, source, def) {
        var elem;
        if (pool.length > 0 && (elem = pool.pop())) {
          Anchor.call(elem, item, source, def);
          return elem;
        } else {
          return new Anchor(item, source, def);
        }
      };

      function Anchor(item, source, def) {
        var child, handler, line, target, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        this.item = item;
        this.source = source;
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
        _ref = getSourceWatchProps[source];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          item[handler](update, this);
        }
        this.prop = getItemProp[source];
        this.getSourceValue = getSourceValue[source];
        this.getTargetValue = getTargetValue[line][this.type];
        if (typeof this.getTargetValue !== 'function') {
          this.getTargetValue = GET_ZERO;
          log.error("Anchor '" + this.source + ": " + (def.join('.')) + "' is not supported");
        }
        switch (target) {
          case 'parent':
            this.targetItem = item._parent;
            item.onParentChange(onParentChange, this);
            onParentChange.call(this, null);
            break;
          case 'children':
            this.targetItem = item._children;
            item.onChildrenChange(onChildrenChange, this);
            _ref1 = item.children;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              child = _ref1[_j];
              onChildInsert.call(this, child);
            }
            break;
          case 'nextSibling':
            this.targetItem = item._nextSibling;
            item.onNextSiblingChange(onNextSiblingChange, this);
            onNextSiblingChange.call(this, null);
            break;
          case 'previousSibling':
            this.targetItem = item._previousSibling;
            item.onPreviousSiblingChange(onPreviousSiblingChange, this);
            onPreviousSiblingChange.call(this, null);
            break;
          default:
            if (this.targetItem = target) {
              _ref2 = getTargetWatchProps[line][this.type];
              for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
                handler = _ref2[_k];
                this.targetItem[handler](update, this);
              }
            }
            update.call(this);
        }
        Object.preventExtensions(this);
      }

      Anchor.prototype.update = function() {
        var margin, r, targetItem;
        if (!this.item || this.updateLoops >= MAX_LOOPS) {
          return;
        }
        switch (this.target) {
          case 'parent':
            targetItem = this.item._parent;
            break;
          case 'children':
            targetItem = this.item._children;
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
          if (this.item._parent && targetItem !== this.item._children && this.item._parent !== targetItem && this.item._parent !== targetItem._parent) {
            log.error("You can anchor only to a parent or sibling. Item '" + (this.item.toString()) + ".anchors." + this.source + ": " + this.target + "'");
          }
          //</development>;
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
          log.error("Potential anchors loop detected. Recalculating on this anchor (" + this + ") has been disabled.");
          this.updateLoops++;
        } else if (this.updateLoops < MAX_LOOPS) {
          this.updateLoops--;
        }
      };

      Anchor.prototype.destroy = function() {
        var child, handler, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        switch (this.target) {
          case 'parent':
            this.item.onParentChange.disconnect(onParentChange, this);
            break;
          case 'children':
            this.item.onChildrenChange.disconnect(onChildrenChange, this);
            _ref = this.item.children;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              onChildPop.call(this, child, -1);
            }
            break;
          case 'nextSibling':
            this.item.onNextSiblingChange.disconnect(onNextSiblingChange, this);
            break;
          case 'previousSibling':
            this.item.onPreviousSiblingChange.disconnect(onPreviousSiblingChange, this);
        }
        _ref1 = getSourceWatchProps[this.source];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          handler = _ref1[_j];
          this.item[handler].disconnect(update, this);
        }
        if (this.targetItem) {
          _ref2 = getTargetWatchProps[this.line][this.type];
          for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
            handler = _ref2[_k];
            this.targetItem[handler].disconnect(update, this);
          }
        }
        this.item = this.targetItem = null;
        pool.push(this);
      };

      Anchor.prototype.toString = function() {
        return "" + (this.item.toString()) + ".anchors." + this.source + ": " + this.target + "." + this.line;
      };

      return Anchor;

    })();
    getBaseAnchors = {
      centerIn: ['horizontalCenter', 'verticalCenter'],
      fillWidth: ['fillWidthSize', 'left'],
      fillHeight: ['fillHeightSize', 'top'],
      fill: ['fillWidthSize', 'fillHeightSize', 'left', 'top']
    };
    getBaseAnchorsPerAnchorType = {
      __proto__: null
    };
    isMultiAnchor = function(source) {
      return !!getBaseAnchors[source];
    };
    MultiAnchor = (function() {
      var pool;

      pool = [];

      MultiAnchor.factory = function(item, source, def) {
        var elem;
        if (elem = pool.pop()) {
          MultiAnchor.call(elem, item, source, def);
          return elem;
        } else {
          return new MultiAnchor(item, source, def);
        }
      };

      function MultiAnchor(item, source, def) {
        var anchor, baseAnchors, line, _i, _len, _ref;
        assert.lengthOf(def, 1);
        this.anchors = [];
        def = [def[0], ''];
        this.pending = false;
        baseAnchors = (_ref = getBaseAnchorsPerAnchorType[def[0]]) != null ? _ref[source] : void 0;
        if (baseAnchors == null) {
          baseAnchors = getBaseAnchors[source];
        }
        for (_i = 0, _len = baseAnchors.length; _i < _len; _i++) {
          line = baseAnchors[_i];
          def[1] = line;
          anchor = Anchor.factory(item, line, def);
          this.anchors.push(anchor);
        }
        return;
      }

      MultiAnchor.prototype.update = function() {
        var anchor, _i, _len, _ref;
        _ref = this.anchors;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          anchor = _ref[_i];
          anchor.update();
        }
      };

      MultiAnchor.prototype.destroy = function() {
        var anchor, _i, _len, _ref;
        _ref = this.anchors;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          anchor = _ref[_i];
          anchor.destroy();
        }
        pool.push(this);
      };

      return MultiAnchor;

    })();
    createAnchor = function(item, source, def) {
      if (isMultiAnchor(source)) {
        return MultiAnchor.factory(item, source, def);
      } else {
        return Anchor.factory(item, source, def);
      }
    };
    return exports = {
      setItemAnchor: function(type, val) {
        var anchors, _base;
        if (val !== null) {
          assert.isArray(val);
        }
        anchors = (_base = this._impl).anchors != null ? _base.anchors : _base.anchors = {};
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


return module.exports;
})();modules['../renderer/impl/base/utils.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/utils.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./utils/grid":"../renderer/impl/base/utils/grid.coffee"});
var exports = module.exports;

(function() {
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
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
      grid: require('./utils/grid'),
      createDataCloner: function(extend, base) {
        return function() {
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
      radToDeg: (function() {
        var RAD;
        RAD = 180 / Math.PI;
        return function(val) {
          return val * RAD;
        };
      })(),
      degToRad: (function() {
        var DEG;
        DEG = Math.PI / 180;
        return function(val) {
          return val * DEG;
        };
      })()
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/utils/grid.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/utils/grid.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","typed-array":"../typed-array/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var ALIGNMENT_TO_POINT, ALL, COLUMN, MAX_LOOPS, ROW, TypedArray, columnsFills, columnsSizes, disableChild, enableChild, getArray, getCleanArray, log, onChildrenChange, onHeightChange, onWidthChange, pending, queue, queueIndex, queues, rowsFills, rowsSizes, unusedFills, update, updateItem, updateItems, updateSize, utils, visibleChildren;

  MAX_LOOPS = 100;

  utils = require('utils');

  log = require('log');

  TypedArray = require('typed-array');

  log = log.scope('Renderer');

  queueIndex = 0;

  queues = [[], []];

  queue = queues[queueIndex];

  pending = false;

  visibleChildren = new TypedArray.Uint8(64);

  columnsSizes = new TypedArray.Uint32(64);

  columnsFills = new TypedArray.Uint8(64);

  rowsSizes = new TypedArray.Uint32(64);

  rowsFills = new TypedArray.Uint8(64);

  unusedFills = new TypedArray.Uint8(64);

  getArray = function(arr, len) {
    if (arr.length < len) {
      return new arr.constructor(len * 1.4 | 0);
    } else {
      return arr;
    }
  };

  getCleanArray = function(arr, len) {
    var i, newArr, _i;
    newArr = getArray(arr, len);
    if (newArr === arr) {
      for (i = _i = 0; _i < len; i = _i += 1) {
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

  updateItem = function(item) {
    var alignH, alignV, alignment, anchors, autoHeight, autoWidth, bottomMargin, bottomPadding, cellX, cellY, child, childIndex, children, column, columnSpacing, columnsFillsSum, columnsLen, data, effectItem, freeHeightSpace, freeWidthSpace, gridHeight, gridType, gridWidth, height, i, includeBorderMargins, lastColumn, lastRow, layout, leftMargin, leftPadding, length, margin, maxColumnsLen, maxRowsLen, padding, perCell, plusX, plusY, rightMargin, rightPadding, row, rowSpacing, rowsFillsSum, rowsLen, topMargin, topPadding, update, width, _i, _j, _k, _l, _len, _len1, _len2, _m, _n, _o, _p, _q;
    if (!(effectItem = item._effectItem)) {
      return;
    }
    includeBorderMargins = item.includeBorderMargins;
    children = effectItem.children;
    data = item._impl;
    gridType = data.gridType;
    autoWidth = data.autoWidth, autoHeight = data.autoHeight;
    columnSpacing = rowSpacing = 0;
    if (layout = effectItem._layout) {
      autoWidth && (autoWidth = !layout._fillWidth);
      autoHeight && (autoHeight = !layout._fillHeight);
    }
    if (gridType === ALL) {
      columnsLen = item.columns;
      rowsLen = item.rows;
      columnSpacing = item.spacing.column;
      rowSpacing = item.spacing.row;
    } else if (gridType === COLUMN) {
      rowSpacing = item.spacing;
      columnsLen = 1;
      rowsLen = Infinity;
    } else if (gridType === ROW) {
      columnSpacing = item.spacing;
      columnsLen = Infinity;
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
    maxColumnsLen = columnsLen === Infinity ? children.length : columnsLen;
    columnsSizes = getCleanArray(columnsSizes, maxColumnsLen);
    columnsFills = getCleanArray(columnsFills, maxColumnsLen);
    maxRowsLen = rowsLen === Infinity ? Math.ceil(children.length / columnsLen) : rowsLen;
    rowsSizes = getCleanArray(rowsSizes, maxRowsLen);
    rowsFills = getCleanArray(rowsFills, maxRowsLen);
    visibleChildren = getArray(visibleChildren, children.length);
    i = lastColumn = 0;
    lastRow = -1;
    for (childIndex = _i = 0, _len = children.length; _i < _len; childIndex = ++_i) {
      child = children[childIndex];
      if (!child._visible || (child._layout && !child._layout._enabled)) {
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
    for (childIndex = _j = 0, _len1 = children.length; _j < _len1; childIndex = ++_j) {
      child = children[childIndex];
      if (!visibleChildren[childIndex]) {
        continue;
      }
      width = child._width;
      height = child._height;
      margin = child._margin;
      layout = child._layout;
      column = i % columnsLen;
      row = Math.floor(i / columnsLen) % rowsLen;
      if (layout) {
        if (layout._fillWidth) {
          width = 0;
          columnsFillsSum++;
          columnsFills[column] = 1;
        }
        if (layout._fillHeight) {
          height = 0;
          rowsFillsSum++;
          rowsFills[row] = 1;
        }
      }
      if (margin) {
        if (includeBorderMargins || column !== 0) {
          width += margin._left;
        }
        if (includeBorderMargins || column !== lastColumn) {
          width += margin._right;
        }
        if (includeBorderMargins || row !== 0) {
          height += margin._top;
        }
        if (includeBorderMargins || row !== lastRow) {
          height += margin._bottom;
        }
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
      for (i = _k = 0; _k <= lastColumn; i = _k += 1) {
        gridWidth += columnsSizes[i];
      }
    }
    gridHeight = 0;
    if (autoHeight || rowsFillsSum > 0 || alignV !== 0) {
      for (i = _l = 0; _l <= lastRow; i = _l += 1) {
        gridHeight += rowsSizes[i];
      }
    }
    if (!autoWidth) {
      freeWidthSpace = effectItem._width - columnSpacing * lastColumn - leftPadding - rightPadding - gridWidth;
      if (freeWidthSpace > 0 && columnsFillsSum > 0) {
        unusedFills = getCleanArray(unusedFills, lastColumn + 1);
        length = lastColumn + 1;
        perCell = (gridWidth + freeWidthSpace) / length;
        update = true;
        while (update) {
          update = false;
          for (i = _m = 0; _m <= lastColumn; i = _m += 1) {
            if (unusedFills[i] === 0 && (columnsFills[i] === 0 || columnsSizes[i] > perCell)) {
              length--;
              perCell -= (columnsSizes[i] - perCell) / length;
              unusedFills[i] = 1;
              update = true;
            }
          }
        }
        for (i = _n = 0; _n <= lastColumn; i = _n += 1) {
          if (unusedFills[i] === 0) {
            columnsSizes[i] = perCell;
          }
        }
        freeWidthSpace = 0;
      }
    }
    if (!autoHeight) {
      freeHeightSpace = effectItem._height - rowSpacing * lastRow - topPadding - bottomPadding - gridHeight;
      if (freeHeightSpace > 0 && rowsFillsSum > 0) {
        unusedFills = getCleanArray(unusedFills, lastRow + 1);
        length = lastRow + 1;
        perCell = (gridHeight + freeHeightSpace) / length;
        update = true;
        while (update) {
          update = false;
          for (i = _o = 0; _o <= lastRow; i = _o += 1) {
            if (unusedFills[i] === 0 && (rowsFills[i] === 0 || rowsSizes[i] > perCell)) {
              length--;
              perCell -= (rowsSizes[i] - perCell) / length;
              unusedFills[i] = 1;
              update = true;
            }
          }
        }
        for (i = _p = 0; _p <= lastRow; i = _p += 1) {
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
    for (childIndex = _q = 0, _len2 = children.length; _q < _len2; childIndex = ++_q) {
      child = children[childIndex];
      if (!visibleChildren[childIndex]) {
        continue;
      }
      margin = child._margin;
      layout = child._layout;
      anchors = child._anchors;
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
        if (includeBorderMargins || column !== 0) {
          leftMargin = margin._left;
        }
        if (includeBorderMargins || column !== lastColumn) {
          rightMargin = margin._right;
        }
      }
      topMargin = bottomMargin = 0;
      if (margin) {
        if (includeBorderMargins || row !== 0) {
          topMargin = margin._top;
        }
        if (includeBorderMargins || row !== lastRow) {
          bottomMargin = margin._bottom;
        }
      }
      if (layout) {
        if (layout._fillWidth) {
          width = columnsSizes[column] - leftMargin - rightMargin;
          child.width = width;
        }
        if (layout._fillHeight) {
          height = rowsSizes[row] - topMargin - bottomMargin;
          child.height = height;
        }
      }
      if (!(anchors != null ? anchors._autoX : void 0)) {
        child.x = cellX + plusX + leftMargin + leftPadding + columnsSizes[column] * alignH - (child._width + leftMargin + rightMargin) * alignH;
      }
      if (!(anchors != null ? anchors._autoY : void 0)) {
        child.y = cellY + plusY + topMargin + topPadding + rowsSizes[row] * alignV - (child._height + topMargin + bottomMargin) * alignV;
      }
      i++;
    }
    if (autoWidth) {
      effectItem.width = gridWidth + columnSpacing * lastColumn + leftPadding + rightPadding;
    }
    if (autoHeight) {
      effectItem.height = gridHeight + rowSpacing * lastRow + topPadding + bottomPadding;
    }
  };

  updateItems = function() {
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

  update = function() {
    var data, _ref;
    data = this._impl;
    if (data.pending || !((_ref = this._effectItem) != null ? _ref._visible : void 0)) {
      return;
    }
    data.pending = true;
    if (data.updatePending) {
      if (data.gridUpdateLoops > MAX_LOOPS) {
        return;
      }
      if (++data.gridUpdateLoops === MAX_LOOPS) {
        log.error("Potential Grid/Column/Row loop detected. Recalculating on this item (" + (this.toString()) + ") has been disabled.");
        return;
      }
    } else {
      data.gridUpdateLoops = 0;
    }
    queue.push(this);
    if (!pending) {
      setImmediate(updateItems);
      pending = true;
    }
  };

  updateSize = function() {
    if (!this._impl.updatePending) {
      update.call(this);
    }
  };

  onWidthChange = function(oldVal) {
    var layout;
    if (this._effectItem && !this._impl.updatePending && (!(layout = this._effectItem._layout) || !layout._fillWidth)) {
      this._impl.autoWidth = this._effectItem._width === 0 && oldVal !== -1;
    }
    return updateSize.call(this);
  };

  onHeightChange = function(oldVal) {
    var layout;
    if (this._effectItem && !this._impl.updatePending && (!(layout = this._effectItem._layout) || !layout._fillHeight)) {
      this._impl.autoHeight = this._effectItem._height === 0 && oldVal !== -1;
    }
    return updateSize.call(this);
  };

  enableChild = function(child) {
    child.onVisibleChange(update, this);
    child.onWidthChange(update, this);
    child.onHeightChange(update, this);
    child.onMarginChange(update, this);
    child.onAnchorsChange(update, this);
    return child.onLayoutChange(update, this);
  };

  disableChild = function(child) {
    child.onVisibleChange.disconnect(update, this);
    child.onWidthChange.disconnect(update, this);
    child.onHeightChange.disconnect(update, this);
    child.onMarginChange.disconnect(update, this);
    child.onAnchorsChange.disconnect(update, this);
    return child.onLayoutChange.disconnect(update, this);
  };

  onChildrenChange = function(added, removed) {
    if (added) {
      enableChild.call(this, added);
    }
    if (removed) {
      disableChild.call(this, removed);
    }
    return update.call(this);
  };

  COLUMN = exports.COLUMN = 1 << 0;

  ROW = exports.ROW = 1 << 1;

  ALL = exports.ALL = (1 << 2) - 1;

  exports.DATA = {
    pending: false,
    updatePending: false,
    gridType: 0,
    gridUpdateLoops: 0,
    autoWidth: true,
    autoHeight: true
  };

  exports.create = function(item, type) {
    item._impl.gridType = type;
    return item.onAlignmentChange(updateSize);
  };

  exports.update = update;

  exports.setEffectItem = function(item, oldItem) {
    var child, _i, _j, _len, _len1, _ref, _ref1;
    if (oldItem) {
      oldItem.onVisibleChange.disconnect(update, this);
      oldItem.onChildrenChange.disconnect(onChildrenChange, this);
      oldItem.onLayoutChange.disconnect(update, this);
      oldItem.onWidthChange.disconnect(onWidthChange, this);
      oldItem.onHeightChange.disconnect(onHeightChange, this);
      _ref = oldItem.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        disableChild.call(this, child);
      }
    }
    if (item) {
      if (this._impl.autoWidth = item.width === 0) {
        item.width = -1;
      }
      if (this._impl.autoHeight = item.height === 0) {
        item.height = -1;
      }
      item.onVisibleChange(update, this);
      item.onChildrenChange(onChildrenChange, this);
      item.onLayoutChange(update, this);
      item.onWidthChange(onWidthChange, this);
      item.onHeightChange(onHeightChange, this);
      _ref1 = item.children;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        child = _ref1[_j];
        enableChild.call(this, child);
      }
      update.call(this);
    }
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/index.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/index.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./level0/item":"../renderer/impl/base/level0/item.coffee","./level0/image":"../renderer/impl/base/level0/image.coffee","./level0/text":"../renderer/impl/base/level0/text.coffee","./level0/textInput":"../renderer/impl/base/level0/textInput.coffee","./level0/loader/font":"../renderer/impl/base/level0/loader/font.coffee","./level0/loader/resources":"../renderer/impl/base/level0/loader/resources.coffee","./level0/device":"../renderer/impl/base/level0/device.coffee","./level0/screen":"../renderer/impl/base/level0/screen.coffee","./level0/navigator":"../renderer/impl/base/level0/navigator.coffee","./level0/sensor/rotation":"../renderer/impl/base/level0/sensor/rotation.coffee","./level0/sound/ambient":"../renderer/impl/base/level0/sound/ambient.coffee","./level1/rectangle":"../renderer/impl/base/level1/rectangle.coffee","./level1/grid":"../renderer/impl/base/level1/grid.coffee","./level1/column":"../renderer/impl/base/level1/column.coffee","./level1/row":"../renderer/impl/base/level1/row.coffee","./level1/flow":"../renderer/impl/base/level1/flow.coffee","./level1/animation":"../renderer/impl/base/level1/animation.coffee","./level1/animation/property":"../renderer/impl/base/level1/animation/property.coffee","./level1/animation/number":"../renderer/impl/base/level1/animation/number.coffee","./level2/scrollable":"../renderer/impl/base/level2/scrollable.coffee","./level1/binding":"../renderer/impl/base/level1/binding.coffee","./level1/anchors":"../renderer/impl/base/level1/anchors.coffee","./utils":"../renderer/impl/base/utils.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  exports.Types = {
    Item: require('./level0/item'),
    Image: require('./level0/image'),
    Text: require('./level0/text'),
    TextInput: require('./level0/textInput'),
    FontLoader: require('./level0/loader/font'),
    ResourcesLoader: require('./level0/loader/resources'),
    Device: require('./level0/device'),
    Screen: require('./level0/screen'),
    Navigator: require('./level0/navigator'),
    RotationSensor: require('./level0/sensor/rotation'),
    AmbientSound: require('./level0/sound/ambient'),
    Rectangle: require('./level1/rectangle'),
    Grid: require('./level1/grid'),
    Column: require('./level1/column'),
    Row: require('./level1/row'),
    Flow: require('./level1/flow'),
    Animation: require('./level1/animation'),
    PropertyAnimation: require('./level1/animation/property'),
    NumberAnimation: require('./level1/animation/number'),
    Scrollable: require('./level2/scrollable')
  };

  exports.Extras = {
    Binding: require('./level1/binding'),
    Anchors: require('./level1/anchors')
  };

  exports.items = {};

  exports.utils = require('./utils')(exports);

  exports.window = null;

  exports.pixelRatio = 1;

  exports.setWindow = function(item) {};

}).call(this);


return module.exports;
})();modules['../renderer/utils/item.coffee'] = (function(){
var module = {exports: modules["../renderer/utils/item.coffee"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","expect":"node_modules/expect/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, emitSignal, expect, isArray, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  expect = require('expect');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  log = log.scope('Renderer');

  emitSignal = signal.Emitter.emitSignal;

  isArray = Array.isArray;

  module.exports = function(Renderer, Impl) {
    var CustomObject, DeepObject, FixedObject, MutableDeepObject, NOP, UtilsObject, exports, funcCache, getObjAsString, getObjFile, getPropHandlerName, getPropInternalName;
    NOP = function() {};
    getObjAsString = function(item) {
      var _ref;
      return "(" + item.constructor.__name__ + ")" + ((_ref = item._component) != null ? _ref.fileName : void 0) + ":" + item.id;
    };
    getObjFile = function(item) {
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
    UtilsObject = (function(_super) {
      var CHANGES_OMIT_ATTRIBUTES, createClass, createProperty, createSignal, initObject, setOpts;

      __extends(UtilsObject, _super);

      initObject = function(component, opts) {
        var obj, prop, val;
        for (prop in opts) {
          val = opts[prop];
          obj = this;
          if (prop === 'document.query') {
            obj = this.document;
            prop = 'query';
          }
          if (typeof val === 'function') {
            //<development>;
            if (typeof obj[prop] !== 'function') {
              log.error("Object '" + obj + "' has no function '" + prop + "'");
              continue;
            }
            //</development>;
            obj[prop](val);
          } else if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            continue;
          } else {
            //<development>;
            if (!(prop in obj)) {
              log.error("Object '" + obj + "' has no property '" + prop + "'");
              continue;
            }
            //</development>;
            obj[prop] = val;
          }
        }
        for (prop in opts) {
          val = opts[prop];
          obj = this;
          if (prop === 'document.query') {
            obj = this.document;
            prop = 'query';
          }
          if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            obj.createBinding(prop, val, component);
          }
        }
      };

      setOpts = function(component, opts) {
        var child, classElem, property, signalName, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        assert.instanceOf(component, Renderer.Component);
        if (typeof opts.id === 'string') {
          this.id = opts.id;
        }
        if (Array.isArray(opts.properties)) {
          _ref = opts.properties;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            property = _ref[_i];
            createProperty(this, property);
          }
        }
        if (Array.isArray(opts.signals)) {
          _ref1 = opts.signals;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            signalName = _ref1[_j];
            createSignal(this, signalName);
          }
        }
        if (Array.isArray(opts.children)) {
          _ref2 = opts.children;
          for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
            child = _ref2[_k];
            if (child instanceof Renderer.Item) {
              child.parent = this;
            } else if (child instanceof Renderer.Extension) {
              child.target = this;
            }
          }
        }
        classElem = createClass(component, opts);
        classElem.target = this;
      };

      CHANGES_OMIT_ATTRIBUTES = {
        __proto__: null,
        id: true,
        properties: true,
        signals: true,
        children: true
      };

      createClass = function(component, opts) {
        var changes, classElem, prop, val;
        classElem = new Renderer.Class(component);
        classElem.priority = -1;
        changes = classElem.changes;
        for (prop in opts) {
          val = opts[prop];
          if (typeof val === 'function') {
            changes.setFunction(prop, val);
          } else if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            changes.setBinding(prop, val);
          } else if (!CHANGES_OMIT_ATTRIBUTES[prop]) {
            changes.setAttribute(prop, val);
          }
        }
        return classElem;
      };

      UtilsObject.createProperty = createProperty = function(object, name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        if (name in object.$) {
          return;
        }
        exports.defineProperty({
          object: object.$,
          name: name,
          namespace: '$'
        });
      };

      createSignal = function(object, name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        signal.Emitter.createSignalOnObject(object.$, name);
      };

      UtilsObject.setOpts = function(object, component, opts) {
        if (opts.id != null) {
          object.id = opts.id;
        }
        if (object instanceof Renderer.Class || object instanceof FixedObject) {
          initObject.call(object, component, opts);
        } else {
          setOpts.call(object, component, opts);
        }
      };

      function UtilsObject(component, opts) {
        this.id = '';
        this._impl = null;
        this._bindings = null;
        this._classExtensions = null;
        this._classList = [];
        this._classQueue = [];
        this._extensions = [];
        this._component = component;
        UtilsObject.__super__.constructor.call(this);
        Object.preventExtensions(this);
        Impl.createObject(this, this.constructor.__name__);
        if (opts) {
          UtilsObject.setOpts(this, component, opts);
        }
      }

      UtilsObject.prototype.createBinding = function(prop, val, component, ctx) {
        var bindings;
        if (ctx == null) {
          ctx = this;
        }
        assert.isString(prop);
        if (val != null) {
          assert.isArray(val);
        }
        assert.instanceOf(component, Renderer.Component);
        //<development>;
        if (!(prop in this)) {
          log.warn("Binding on the '" + prop + "' property can't be created, because this object (" + (this.toString()) + ") doesn't have such property");
          return;
        }
        //</development>;
        if (!val && (!this._bindings || !this._bindings.hasOwnProperty(prop))) {
          return;
        }
        bindings = this._bindings != null ? this._bindings : this._bindings = {};
        if (bindings[prop] !== val) {
          bindings[prop] = val;
          Impl.setItemBinding.call(this, prop, val, component, ctx);
        }
      };

      UtilsObject.prototype.clone = function(component, opts) {
        var clone;
        clone = new this.constructor(component);
        if (this.id) {
          clone.id = this.id;
        }
        if (this._$) {
          clone._$ = Object.create(this._$);
          MutableDeepObject.call(clone._$, clone);
        }
        if (opts) {
          setOpts.call(clone, component, opts);
        }
        return clone;
      };

      UtilsObject.prototype.toString = function() {
        return getObjAsString(this);
      };

      return UtilsObject;

    })(signal.Emitter);
    FixedObject = (function(_super) {
      __extends(FixedObject, _super);

      function FixedObject() {
        return FixedObject.__super__.constructor.apply(this, arguments);
      }

      FixedObject.prototype.constrcutor = function(component, opts) {
        return FixedObject.__super__.constrcutor.call(this, component, opts);
      };

      return FixedObject;

    })(UtilsObject);
    MutableDeepObject = (function(_super) {
      __extends(MutableDeepObject, _super);

      function MutableDeepObject(ref) {
        assert.instanceOf(ref, UtilsObject);
        this._ref = ref;
        this._impl = {
          bindings: null
        };
        this._component = ref._component;
        this._bindings = null;
        this._classExtensions = null;
        this._classList = [];
        this._classQueue = [];
        this._extensions = [];
        MutableDeepObject.__super__.constructor.call(this);
      }

      MutableDeepObject.prototype.createBinding = UtilsObject.prototype.createBinding;

      MutableDeepObject.prototype.toString = function() {
        return getObjAsString(this._ref);
      };

      return MutableDeepObject;

    })(signal.Emitter);
    DeepObject = (function(_super) {
      __extends(DeepObject, _super);

      function DeepObject(ref) {
        DeepObject.__super__.constructor.call(this, ref);
        Object.preventExtensions(this);
      }

      return DeepObject;

    })(MutableDeepObject);
    CustomObject = (function(_super) {
      __extends(CustomObject, _super);

      function CustomObject(ref) {
        CustomObject.__super__.constructor.call(this, ref);
      }

      return CustomObject;

    })(MutableDeepObject);
    Impl.DeepObject = DeepObject;
    funcCache = Object.create(null);
    return exports = {
      Object: UtilsObject,
      FixedObject: FixedObject,
      DeepObject: DeepObject,
      MutableDeepObject: MutableDeepObject,
      CustomObject: CustomObject,
      getPropHandlerName: getPropHandlerName = (function() {
        var cache;
        cache = Object.create(null);
        return function(prop) {
          return cache[prop] || (cache[prop] = "on" + (utils.capitalize(prop)) + "Change");
        };
      })(),
      getPropInternalName: getPropInternalName = (function() {
        var cache;
        cache = Object.create(null);
        return function(prop) {
          return cache[prop] || (cache[prop] = "_" + prop);
        };
      })(),
      getInnerPropName: (function() {
        var cache;
        cache = Object.create(null);
        cache[''] = '';
        return function(val) {
          return cache[val] != null ? cache[val] : cache[val] = '_' + val;
        };
      })(),
      defineProperty: function(opts) {
        var basicGetter, basicSetter, customGetter, customSetter, developmentSetter, func, getter, implementation, internalName, name, namespace, namespaceSignalName, propGetter, propSetter, prototype, setter, signalName, uniquePropName, valueConstructor, _name, _name1, _name2;
        assert.isPlainObject(opts);
        name = opts.name, namespace = opts.namespace, valueConstructor = opts.valueConstructor, implementation = opts.implementation;
        //<development>;
        developmentSetter = opts.developmentSetter;
        //</development>;
        prototype = opts.object || opts.constructor.prototype;
        customGetter = opts.getter;
        customSetter = opts.setter;
        signalName = getPropHandlerName(name);
        if (opts.hasOwnProperty('constructor')) {
          signal.Emitter.createSignal(opts.constructor, signalName, opts.signalInitializer);
        } else {
          signal.Emitter.createSignalOnObject(prototype, signalName, opts.signalInitializer);
        }
        internalName = getPropInternalName(name);
        propGetter = basicGetter = funcCache[_name = "get-" + internalName] != null ? funcCache[_name] : funcCache[_name] = Function("return this." + internalName);
        if (valueConstructor) {
          propGetter = function() {
            return this[internalName] != null ? this[internalName] : this[internalName] = new valueConstructor(this);
          };
        }
        if (valueConstructor) {
          if (developmentSetter) {
            //<development>;
            propSetter = basicSetter = developmentSetter;
            //</development>;
          } else {
            propSetter = basicSetter = NOP;
          }
        } else if (namespace != null) {
          namespaceSignalName = "on" + (utils.capitalize(namespace)) + "Change";
          uniquePropName = namespace + utils.capitalize(name);
          func = funcCache[_name1 = "set-deep-" + namespace + "-" + internalName + "-" + (developmentSetter != null) + "-" + (implementation != null)] != null ? funcCache[_name1] : funcCache[_name1] = (function() {
            var funcStr;
            funcStr = "return function(val){\n";
            //<development>;
            if (developmentSetter != null) {
              funcStr += "debug.call(this, val);\n";
            }
            //</development>;
            funcStr += "var oldVal = this." + internalName + ";\n";
            funcStr += "if (oldVal === val) return;\n";
            if (implementation != null) {
              funcStr += "impl.call(this._ref, val);\n";
            }
            funcStr += "this." + internalName + " = val;\n";
            funcStr += "emitSignal(this, '" + signalName + "', oldVal);\n";
            funcStr += "emitSignal(this._ref, '" + namespaceSignalName + "', '" + name + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'emitSignal', 'debug', funcStr);
          })();
          propSetter = basicSetter = func(implementation, emitSignal, developmentSetter);
        } else {
          func = funcCache[_name2 = "set-" + internalName + "-" + (developmentSetter != null) + "-" + (implementation != null)] != null ? funcCache[_name2] : funcCache[_name2] = (function() {
            var funcStr;
            funcStr = "return function(val){\n";
            //<development>;
            if (developmentSetter != null) {
              funcStr += "debug.call(this, val);\n";
            }
            //</development>;
            funcStr += "var oldVal = this." + internalName + ";\n";
            funcStr += "if (oldVal === val) return;\n";
            if (implementation != null) {
              funcStr += "impl.call(this, val);\n";
            }
            funcStr += "this." + internalName + " = val;\n";
            funcStr += "emitSignal(this, '" + signalName + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'emitSignal', 'debug', funcStr);
          })();
          propSetter = basicSetter = func(implementation, emitSignal, developmentSetter);
        }
        getter = customGetter != null ? customGetter(propGetter) : propGetter;
        setter = customSetter != null ? customSetter(propSetter) : propSetter;
        prototype[internalName] = opts.defaultValue;
        utils.defineProperty(prototype, name, null, getter, setter);
        return prototype;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/namespace/screen.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/namespace/screen.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Screen, screen, _ref;
    Screen = (function(_super) {
      __extends(Screen, _super);

      function Screen() {
        this._touch = false;
        this._width = 1024;
        this._height = 800;
        this._orientation = 'Portrait';
        Screen.__super__.constructor.call(this);
      }

      utils.defineProperty(Screen.prototype, 'touch', null, function() {
        return this._touch;
      }, null);

      utils.defineProperty(Screen.prototype, 'width', null, function() {
        return this._width;
      }, null);

      utils.defineProperty(Screen.prototype, 'height', null, function() {
        return this._height;
      }, null);

      signal.Emitter.createSignal(Screen, 'onOrientationChange');

      utils.defineProperty(Screen.prototype, 'orientation', null, function() {
        return this._orientation;
      }, null);

      return Screen;

    })(itemUtils.Object);
    screen = new Screen;
    if ((_ref = Impl.initScreenNamespace) != null) {
      _ref.call(screen);
    }
    return screen;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/namespace/device.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/namespace/device.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Device, device, _ref;
    Device = (function(_super) {
      __extends(Device, _super);

      function Device() {
        this._platform = 'unix';
        this._desktop = true;
        this._phone = false;
        this._pixelRatio = 1;
        Device.__super__.constructor.call(this);
      }

      utils.defineProperty(Device.prototype, 'platform', null, function() {
        return this._platform;
      }, null);

      utils.defineProperty(Device.prototype, 'desktop', null, function() {
        return this._desktop;
      }, null);

      utils.defineProperty(Device.prototype, 'tablet', null, function() {
        return !this.desktop && !this.phone;
      }, null);

      utils.defineProperty(Device.prototype, 'phone', null, function() {
        return this._phone;
      }, null);

      utils.defineProperty(Device.prototype, 'mobile', null, function() {
        return this.tablet || this.phone;
      }, null);

      utils.defineProperty(Device.prototype, 'pixelRatio', null, function() {
        return this._pixelRatio;
      }, null);

      return Device;

    })(itemUtils.Object);
    device = new Device;
    if ((_ref = Impl.initDeviceNamespace) != null) {
      _ref.call(device);
    }
    return device;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/namespace/navigator.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/namespace/navigator.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Navigator, navigator, _ref;
    Navigator = (function(_super) {
      __extends(Navigator, _super);

      function Navigator() {
        this._impl = null;
        this._language = 'en';
        this._browser = true;
        this._online = true;
        Navigator.__super__.constructor.call(this);
      }

      utils.defineProperty(Navigator.prototype, 'language', null, function() {
        return this._language;
      }, null);

      utils.defineProperty(Navigator.prototype, 'browser', null, function() {
        return this._browser;
      }, null);

      utils.defineProperty(Navigator.prototype, 'native', null, function() {
        return !this._browser;
      }, null);

      itemUtils.defineProperty({
        constructor: Navigator,
        name: 'online',
        setter: function(_super) {
          return function(val) {};
        }
      });

      return Navigator;

    })(itemUtils.Object);
    navigator = new Navigator;
    if ((_ref = Impl.initNavigatorNamespace) != null) {
      _ref.call(navigator);
    }
    return navigator;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/namespace/sensor/rotation.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/namespace/sensor/rotation.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var RotationSensor, rotationSensor;
    RotationSensor = (function(_super) {
      __extends(RotationSensor, _super);

      function RotationSensor() {
        this._active = false;
        this.x = 0;
        this.y = 0;
        this.z = 0;
        RotationSensor.__super__.constructor.call(this);
      }

      utils.defineProperty(RotationSensor.prototype, 'active', null, function() {
        return this._active;
      }, function(val) {
        this._active = val;
        if (val) {
          Impl.enableRotationSensor.call(rotationSensor);
        } else {
          Impl.disableRotationSensor.call(rotationSensor);
        }
      });

      RotationSensor.prototype.x = 0;

      RotationSensor.prototype.y = 0;

      RotationSensor.prototype.z = 0;

      return RotationSensor;

    })(itemUtils.Object);
    rotationSensor = new RotationSensor;
    return rotationSensor;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extension.coffee'] = (function(){
var module = {exports: modules["../renderer/types/extension.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Extension;
    return Extension = (function(_super) {
      var signalListener;

      __extends(Extension, _super);

      Extension.__name__ = 'Extension';

      function Extension(component, opts) {
        if (this._impl == null) {
          this._impl = {
            bindings: null
          };
        }
        this._target = null;
        this._running = false;
        this._when = false;
        this._whenHandler = null;
        Extension.__super__.constructor.call(this, component, opts);
      }

      signalListener = function() {
        if (!this._when) {
          this._when = true;
          this.onWhenChange.emit(false);
          if (!this._running) {
            this.enable();
          }
        }
      };

      itemUtils.defineProperty({
        constructor: Extension,
        name: 'when',
        defaultValue: false,
        setter: function(_super) {
          return function(val) {
            if (this._whenHandler) {
              this._whenHandler.disconnect(signalListener, this);
              this._whenHandler = null;
            }
            if (typeof val === 'function' && (val.connect != null)) {
              val.connect(signalListener, this);
              this._whenHandler = val;
            } else {
              _super.call(this, !!val);
              if (val && !this._running) {
                this.enable();
              } else if (!val && this._running) {
                this.disable();
              }
            }
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Extension,
        name: 'target',
        defaultValue: null
      });

      utils.defineProperty(Extension.prototype, 'running', utils.CONFIGURABLE, function() {
        return this._running;
      }, null);

      signal.Emitter.createSignal(Extension, 'onRunningChange');

      Extension.prototype.enable = function() {
        this._running = true;
        return this.onRunningChange.emit(false);
      };

      Extension.prototype.disable = function() {
        this._running = false;
        return this.onRunningChange.emit(true);
      };

      return Extension;

    })(itemUtils.Object);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/class.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/class.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","list":"../list/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  List = require('list');

  log = log.scope('Rendering', 'Class');

  module.exports = function(Renderer, Impl, itemUtils) {
    var ATTRS_ALIAS, ATTRS_ALIAS_DEF, ChangesObject, Class, ClassChildDocument, ClassDocument, ClassesList, classListSortFunc, cloneClassWithNoDocument, disableClass, enableClass, getContainedAttributeOrAlias, getObject, getPropertyDefaultValue, ifClassListWillChange, loadObjects, normalizeClassesValue, runQueue, saveAndDisableClass, saveAndEnableClass, setAttribute, splitAttribute, unloadObjects, updateChildPriorities, updateClassList, updatePriorities, updateTargetClass;
    ChangesObject = (function() {
      function ChangesObject() {
        this._attributes = {};
        this._functions = [];
        this._bindings = {};
      }

      ChangesObject.prototype.setAttribute = function(prop, val) {
        this._attributes[prop] = val;
      };

      ChangesObject.prototype.setFunction = function(prop, val) {
        var boundFunc;
        boundFunc = function(arg1, arg2) {
          var arr;
          if (this._component) {
            arr = this._component.objectsOrderSignalArr;
            arr[arr.length - 2] = arg1;
            arr[arr.length - 1] = arg2;
            return val.apply(this._target, arr);
          } else {
            return val.call(this._target, arg1, arg2);
          }
        };
        this._functions.push(prop, boundFunc);
      };

      ChangesObject.prototype.setBinding = function(prop, val) {
        this._attributes[prop] = val;
        this._bindings[prop] = true;
      };

      return ChangesObject;

    })();
    Class = (function(_super) {
      var ChildrenObject;

      __extends(Class, _super);

      Class.__name__ = 'Class';

      function Class(component, opts) {
        assert.instanceOf(component, Renderer.Component);
        this._classUid = utils.uid();
        this._priority = 0;
        this._inheritsPriority = 0;
        this._nestingPriority = 0;
        this._name = '';
        this._changes = null;
        this._document = null;
        this._loadedObjects = null;
        this._children = null;
        Class.__super__.constructor.call(this, component, opts);
      }

      itemUtils.defineProperty({
        constructor: Class,
        name: 'name',
        developmentSetter: function(val) {
          assert.isString(val);
          return assert.notLengthOf(val, 0);
        },
        setter: function(_super) {
          return function(val) {
            var name, target, _ref;
            target = this.target, name = this.name;
            if (name === val) {
              return;
            }
            if (target) {
              if (target.classes.has(name)) {
                this.disable();
              }
              target._classExtensions[name] = null;
              target._classExtensions[val] = this;
            }
            _super.call(this, val);
            if (target) {
              if (val) {
                if (target._classExtensions == null) {
                  target._classExtensions = {};
                }
              }
              if ((_ref = target._classes) != null ? _ref.has(val) : void 0) {
                this.enable();
              }
            }
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Class,
        name: 'target',
        developmentSetter: function(val) {
          if (val != null) {
            return assert.instanceOf(val, itemUtils.Object);
          }
        },
        setter: function(_super) {
          return function(val) {
            var name, oldVal, _ref, _ref1, _ref2, _ref3;
            oldVal = this._target;
            name = this.name;
            if (oldVal === val) {
              return;
            }
            this.disable();
            if (oldVal) {
              utils.remove(oldVal._extensions, this);
              if (this._running && !((_ref = this._document) != null ? _ref._query : void 0)) {
                unloadObjects(this, this._component, oldVal);
              }
            }
            if (name) {
              if (oldVal) {
                oldVal._classExtensions[name] = null;
              }
              if (val) {
                if (val._classExtensions == null) {
                  val._classExtensions = {};
                }
                val._classExtensions[name] = this;
              }
            }
            _super.call(this, val);
            if (val) {
              val._extensions.push(this);
              if (((_ref1 = val._classes) != null ? _ref1.has(name) : void 0) || this._when || (this._priority !== -1 && this._component.ready && !this._name && !((_ref2 = this._bindings) != null ? _ref2.when : void 0) && !((_ref3 = this._document) != null ? _ref3._query : void 0))) {
                this.enable();
              }
            }
          };
        }
      });

      utils.defineProperty(Class.prototype, 'changes', null, function() {
        return this._changes || (this._changes = new ChangesObject);
      }, function(obj) {
        var changes, prop, val;
        assert.isObject(obj);
        changes = this.changes;
        for (prop in obj) {
          val = obj[prop];
          if (typeof val === 'function') {
            changes.setFunction(prop, val);
          } else if (Array.isArray(val) && val.length === 2 && typeof val[0] === 'function' && Array.isArray(val[1])) {
            changes.setBinding(prop, val);
          } else {
            changes.setAttribute(prop, val);
          }
        }
      });

      itemUtils.defineProperty({
        constructor: Class,
        name: 'priority',
        defaultValue: 0,
        developmentSetter: function(val) {
          return assert.isInteger(val);
        },
        setter: function(_super) {
          return function(val) {
            _super.call(this, val);
            updatePriorities(this);
          };
        }
      });

      Class.prototype.enable = function() {
        var classElem, hasDocQuery, _i, _len, _ref, _ref1;
        if (this._running || !this._target || (hasDocQuery = this._document && this._document._query)) {
          if (hasDocQuery) {
            _ref = this._document._classesInUse;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              classElem = _ref[_i];
              classElem.enable();
            }
          }
          return;
        }
        Class.__super__.enable.call(this);
        updateTargetClass(saveAndEnableClass, this._target, this);
        if (!((_ref1 = this._document) != null ? _ref1._query : void 0)) {
          loadObjects(this, this._component, this._target);
        }
      };

      Class.prototype.disable = function() {
        var classElem, _i, _len, _ref, _ref1;
        if (!this._running || !this._target) {
          if (this._document && this._document._query) {
            _ref = this._document._classesInUse;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              classElem = _ref[_i];
              classElem.disable();
            }
          }
          return;
        }
        Class.__super__.disable.call(this);
        if (!((_ref1 = this._document) != null ? _ref1._query : void 0)) {
          unloadObjects(this, this._target);
        }
        updateTargetClass(saveAndDisableClass, this._target, this);
      };

      utils.defineProperty(Class.prototype, 'children', null, function() {
        return this._children || (this._children = new ChildrenObject(this));
      }, function(val) {
        var child, children, length, _i, _len;
        children = this.children;
        length = children.length;
        while (length--) {
          children.pop(length);
        }
        if (val) {
          assert.isArray(val);
          for (_i = 0, _len = val.length; _i < _len; _i++) {
            child = val[_i];
            children.append(child);
          }
        }
      });

      ChildrenObject = (function() {
        function ChildrenObject(ref) {
          this._ref = ref;
          this.length = 0;
        }

        ChildrenObject.prototype.append = function(val) {
          assert.instanceOf(val, itemUtils.Object);
          if (!this._ref._component.isClone) {
            this._ref._component.disabledObjects[val.id] = true;
          }
          if (val instanceof Class) {
            updateChildPriorities(this._ref, val);
          }
          this[this.length++] = val;
          return val;
        };

        ChildrenObject.prototype.pop = function(i) {
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

      })();

      Class.prototype.clone = function(component) {
        var children, clone, query, _ref;
        clone = cloneClassWithNoDocument.call(this, component);
        if (query = (_ref = this._document) != null ? _ref._query : void 0) {
          clone.document.query = query;
        }
        if (children = this._children) {
          utils.merge(clone.children, children);
        }
        return clone;
      };

      return Class;

    })(Renderer.Extension);
    loadObjects = function(classElem, component, item, sourceClassElem, loadedObjects) {
      var child, clone, forceUpdateBindings, _i, _len, _ref, _ref1;
      if (sourceClassElem == null) {
        sourceClassElem = classElem;
      }
      if (loadedObjects == null) {
        loadedObjects = classElem._loadedObjects || (classElem._loadedObjects = []);
      }
      if (!loadedObjects) {
        assert.is(classElem._loadedObjects.length, 0);
      }
      forceUpdateBindings = false;
      if (classElem._children) {
        _ref = classElem._children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          clone = classElem._component.cloneRawObject(child);
          clone._component.onObjectChange = signal.create();
          clone._component.setObjectById(sourceClassElem, sourceClassElem.id);
          clone._component.initObjects();
          loadedObjects.push(clone);
          if (clone instanceof Renderer.Item) {
            if (clone.parent == null) {
              clone.parent = item;
            }
          } else {
            updateChildPriorities(classElem, clone);
            if (clone.target == null) {
              clone.target = item;
            }
          }
          if (utils.has(component.idsOrder, child.id)) {
            forceUpdateBindings = true;
            component.setObjectById(clone, child.id);
          }
        }
      }
      if ((_ref1 = classElem._document) != null ? _ref1._parent : void 0) {
        loadObjects(classElem._document._parent._ref, component, item, classElem, loadedObjects);
      }
    };
    unloadObjects = function(classElem, item) {
      var component, loadedObjects, object, _ref;
      if (loadedObjects = classElem._loadedObjects) {
        component = classElem._component;
        while (object = loadedObjects.pop()) {
          if (object instanceof Renderer.Item) {
            object.parent = null;
          } else {
            object.target = null;
          }
          component.cacheObject(object);
        }
      }
      if ((_ref = classElem._document) != null ? _ref._parent : void 0) {
        unloadObjects(classElem._document._parent._ref, item);
      }
    };
    updateChildPriorities = function(parent, child) {
      var _ref;
      child._inheritsPriority = parent._inheritsPriority + parent._priority;
      child._nestingPriority = parent._nestingPriority + 1 + (((_ref = child._document) != null ? _ref._priority : void 0) || 0);
      updatePriorities(child);
    };
    updatePriorities = function(classElem) {
      var child, children, document, loadedObjects, target, _i, _inheritsPriority, _j, _k, _l, _len, _len1, _len2, _len3, _nestingPriority, _ref, _ref1;
      if (classElem._running && ifClassListWillChange(classElem)) {
        target = classElem._target;
        updateTargetClass(disableClass, target, classElem);
        updateClassList(target);
        updateTargetClass(enableClass, target, classElem);
      }
      if (children = classElem._children) {
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
          if (child instanceof Class) {
            updateChildPriorities(classElem, child);
          }
        }
      }
      if (loadedObjects = classElem._loadedObjects) {
        for (_j = 0, _len1 = loadedObjects.length; _j < _len1; _j++) {
          child = loadedObjects[_j];
          if (child instanceof Class) {
            updateChildPriorities(classElem, child);
          }
        }
      }
      if (document = classElem._document) {
        _inheritsPriority = classElem._inheritsPriority, _nestingPriority = classElem._nestingPriority;
        _ref = document._classesInUse;
        for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
          child = _ref[_k];
          child._inheritsPriority = _inheritsPriority;
          child._nestingPriority = _nestingPriority;
          updatePriorities(child);
        }
        _ref1 = document._classesPool;
        for (_l = 0, _len3 = _ref1.length; _l < _len3; _l++) {
          child = _ref1[_l];
          child._inheritsPriority = _inheritsPriority;
          child._nestingPriority = _nestingPriority;
        }
      }
    };
    ifClassListWillChange = function(classElem) {
      var classList, index, target;
      target = classElem._target;
      classList = target._classList;
      index = classList.indexOf(classElem);
      if (index > 0 && classListSortFunc(classElem, classList[index - 1]) < 0) {
        return true;
      }
      if (classList.length !== index + 1 && classListSortFunc(classElem, classList[index + 1]) > 0) {
        return true;
      }
      return false;
    };
    classListSortFunc = function(a, b) {
      return (b._priority + b._inheritsPriority) - (a._priority + a._inheritsPriority) || b._nestingPriority - a._nestingPriority;
    };
    updateClassList = function(item) {
      return item._classList.sort(classListSortFunc);
    };
    cloneClassWithNoDocument = function(component) {
      var clone, prop, val, _ref;
      clone = new Class(component);
      clone.id = this.id;
      clone._classUid = this._classUid;
      clone._name = this._name;
      clone._priority = this._priority;
      clone._inheritsPriority = this._inheritsPriority;
      clone._nestingPriority = this._nestingPriority;
      clone._changes = this._changes;
      if (this._bindings) {
        _ref = this._bindings;
        for (prop in _ref) {
          val = _ref[prop];
          clone.createBinding(prop, val, component);
        }
      }
      return clone;
    };
    splitAttribute = (function() {
      var cache;
      cache = Object.create(null);
      return function(attr) {
        return cache[attr] != null ? cache[attr] : cache[attr] = attr.split('.');
      };
    })();
    getObject = function(item, path) {
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
    };
    setAttribute = function(item, attr, val) {
      var object, path;
      path = splitAttribute(attr);
      if (object = getObject(item, path)) {
        object[path[path.length - 1]] = val;
      }
    };
    saveAndEnableClass = function(item, classElem) {
      item._classList.unshift(classElem);
      if (ifClassListWillChange(classElem)) {
        updateClassList(item);
      }
      return enableClass(item, classElem);
    };
    saveAndDisableClass = function(item, classElem) {
      disableClass(item, classElem);
      return utils.remove(item._classList, classElem);
    };
    ATTRS_ALIAS_DEF = [['x', 'anchors.left', 'anchors.right', 'anchors.horizontalCenter', 'anchors.centerIn', 'anchors.fill', 'anchors.fillWidth'], ['y', 'anchors.top', 'anchors.bottom', 'anchors.verticalCenter', 'anchors.centerIn', 'anchors.fill', 'anchors.fillHeight'], ['width', 'anchors.fill', 'anchors.fillWidth', 'layout.fillWidth'], ['height', 'anchors.fill', 'anchors.fillHeight', 'layout.fillHeight'], ['margin.horizontal', 'margin.left'], ['margin.horizontal', 'margin.right'], ['margin.vertical', 'margin.top'], ['margin.vertical', 'margin.bottom'], ['padding.horizontal', 'padding.left'], ['padding.horizontal', 'padding.right'], ['padding.vertical', 'padding.top'], ['padding.vertical', 'padding.bottom']];
    ATTRS_ALIAS = Object.create(null);
    ATTRS_ALIAS['margin'] = ['margin.left', 'margin.right', 'margin.horizontal', 'margin.top', 'margin.bottom', 'margin.vertical'];
    ATTRS_ALIAS['padding'] = ['padding.left', 'padding.right', 'padding.horizontal', 'padding.top', 'padding.bottom', 'padding.vertical'];
    ATTRS_ALIAS['alignment'] = ['alignment.horizontal', 'alignment.vertical'];
    (function() {
      var alias, aliases, arr, prop, _i, _j, _k, _len, _len1, _len2;
      for (_i = 0, _len = ATTRS_ALIAS_DEF.length; _i < _len; _i++) {
        aliases = ATTRS_ALIAS_DEF[_i];
        for (_j = 0, _len1 = aliases.length; _j < _len1; _j++) {
          prop = aliases[_j];
          arr = ATTRS_ALIAS[prop] != null ? ATTRS_ALIAS[prop] : ATTRS_ALIAS[prop] = [];
          for (_k = 0, _len2 = aliases.length; _k < _len2; _k++) {
            alias = aliases[_k];
            if (alias !== prop) {
              arr.push(alias);
            }
          }
        }
      }
    })();
    getContainedAttributeOrAlias = function(classElem, attr) {
      var alias, aliases, attrs, _i, _len;
      attrs = classElem.changes._attributes;
      if (attr in attrs) {
        return attr;
      } else if (aliases = ATTRS_ALIAS[attr]) {
        for (_i = 0, _len = aliases.length; _i < _len; _i++) {
          alias = aliases[_i];
          if (alias in attrs) {
            return alias;
          }
        }
      } else {
        return '';
      }
    };
    getPropertyDefaultValue = function(obj, prop) {
      var innerProp, proto;
      proto = Object.getPrototypeOf(obj);
      innerProp = itemUtils.getInnerPropName(prop);
      if (innerProp in proto) {
        return proto[innerProp];
      } else {
        return proto[prop];
      }
    };
    enableClass = function(item, classElem) {
      var alias, attr, attributes, bindings, changes, classList, classListIndex, classListLength, defaultIsBinding, defaultValue, functions, i, lastPath, object, path, val, writeAttr, _i, _j, _k, _len, _name, _ref, _ref1, _ref2;
      assert.instanceOf(item, itemUtils.Object);
      assert.instanceOf(classElem, Class);
      classList = item._classList;
      classListIndex = classList.indexOf(classElem);
      classListLength = classList.length;
      if (classListIndex === -1) {
        return;
      }
      changes = classElem.changes;
      attributes = changes._attributes;
      bindings = changes._bindings;
      functions = changes._functions;
      for (i = _i = 0, _len = functions.length; _i < _len; i = _i += 2) {
        attr = functions[i];
        path = splitAttribute(attr);
        object = getObject(item, path);
        //<development>;
        if (!object || typeof (object != null ? object[path[path.length - 1]] : void 0) !== 'function') {
          log.error("Handler '" + attr + "' doesn't exist in '" + (item.toString()) + "', from '" + (classElem.toString()) + "'");
        }
        //</development>;
        if (object != null) {
          if (typeof object[_name = path[path.length - 1]] === "function") {
            object[_name](functions[i + 1], classElem);
          }
        }
      }
      for (attr in attributes) {
        val = attributes[attr];
        path = null;
        writeAttr = true;
        alias = '';
        for (i = _j = _ref = classListIndex - 1; _j >= 0; i = _j += -1) {
          if (getContainedAttributeOrAlias(classList[i], attr)) {
            writeAttr = false;
            break;
          }
        }
        if (writeAttr) {
          for (i = _k = _ref1 = classListIndex + 1; _k < classListLength; i = _k += 1) {
            if ((alias = getContainedAttributeOrAlias(classList[i], attr)) && alias !== attr) {
              path = splitAttribute(alias);
              object = getObject(item, path);
              lastPath = path[path.length - 1];
              if (!object) {
                continue;
              }
              defaultValue = getPropertyDefaultValue(object, lastPath);
              defaultIsBinding = !!classList[i].changes._bindings[alias];
              if (defaultIsBinding) {
                object.createBinding(lastPath, null, classElem._component, item);
              }
              object[lastPath] = defaultValue;
              break;
            }
          }
          if (attr !== alias || !path) {
            path = splitAttribute(attr);
            lastPath = path[path.length - 1];
            object = getObject(item, path);
          }
          if (object instanceof itemUtils.CustomObject && !(lastPath in object)) {
            itemUtils.Object.createProperty(object._ref, lastPath);
          } else {
            //<development>;
            if (!object || !(lastPath in object)) {
              log.error("Attribute '" + attr + "' doesn't exist in '" + (item.toString()) + "', from '" + (classElem.toString()) + "'");
              continue;
            }
            //</development>;
            if (!object) {
              continue;
            }
          }
          if (bindings[attr]) {
            object.createBinding(lastPath, val, classElem._component, item);
          } else {
            if ((_ref2 = object._bindings) != null ? _ref2[lastPath] : void 0) {
              object.createBinding(lastPath, null, classElem._component, item);
            }
            if (val instanceof Renderer.Component.Link) {
              object[lastPath] = val.getItem(classElem._component);
            } else {
              object[lastPath] = val;
            }
          }
        }
      }
    };
    disableClass = function(item, classElem) {
      var alias, attr, attributes, bindings, changes, classList, classListIndex, classListLength, defaultIsBinding, defaultValue, functions, i, lastPath, object, path, restoreDefault, val, _i, _j, _k, _len, _ref, _ref1, _ref2;
      assert.instanceOf(item, itemUtils.Object);
      assert.instanceOf(classElem, Class);
      classList = item._classList;
      classListIndex = classList.indexOf(classElem);
      classListLength = classList.length;
      if (classListIndex === -1) {
        return;
      }
      changes = classElem.changes;
      attributes = changes._attributes;
      bindings = changes._bindings;
      functions = changes._functions;
      for (i = _i = 0, _len = functions.length; _i < _len; i = _i += 2) {
        attr = functions[i];
        path = splitAttribute(attr);
        object = getObject(item, path);
        if (object != null) {
          if ((_ref = object[path[path.length - 1]]) != null) {
            _ref.disconnect(functions[i + 1], classElem);
          }
        }
      }
      for (attr in attributes) {
        val = attributes[attr];
        path = null;
        restoreDefault = true;
        alias = '';
        for (i = _j = _ref1 = classListIndex - 1; _j >= 0; i = _j += -1) {
          if (!classList[i]) {
            continue;
          }
          if (getContainedAttributeOrAlias(classList[i], attr)) {
            restoreDefault = false;
            break;
          }
        }
        if (restoreDefault) {
          defaultValue = void 0;
          defaultIsBinding = false;
          for (i = _k = _ref2 = classListIndex + 1; _k < classListLength; i = _k += 1) {
            if (alias = getContainedAttributeOrAlias(classList[i], attr)) {
              defaultValue = classList[i].changes._attributes[alias];
              defaultIsBinding = !!classList[i].changes._bindings[alias];
              break;
            }
          }
          alias || (alias = attr);
          if (!!bindings[attr]) {
            path = splitAttribute(attr);
            object = getObject(item, path);
            lastPath = path[path.length - 1];
            if (!object) {
              continue;
            }
            object.createBinding(lastPath, null, classElem._component, item);
          }
          if (attr !== alias || !path) {
            path = splitAttribute(alias);
            object = getObject(item, path);
            lastPath = path[path.length - 1];
            if (!object) {
              continue;
            }
          }
          //<development>;
          if (!(lastPath in object)) {
            continue;
          }
          //</development>;
          if (defaultIsBinding) {
            object.createBinding(lastPath, defaultValue, classElem._component, item);
          } else {
            if (defaultValue === void 0) {
              defaultValue = getPropertyDefaultValue(object, lastPath);
            }
            object[lastPath] = defaultValue;
          }
        }
      }
    };
    runQueue = function(target) {
      var classElem, classQueue, func;
      classQueue = target._classQueue;
      func = classQueue[0], target = classQueue[1], classElem = classQueue[2];
      func(target, classElem);
      classQueue.shift();
      classQueue.shift();
      classQueue.shift();
      if (classQueue.length > 0) {
        runQueue(target);
      }
    };
    updateTargetClass = function(func, target, classElem) {
      var classQueue;
      classQueue = target._classQueue;
      classQueue.push(func, target, classElem);
      if (classQueue.length === 3) {
        runQueue(target);
      }
    };
    ClassChildDocument = (function() {
      function ClassChildDocument(parent) {
        this._ref = parent._ref;
        this._parent = parent;
        this._multiplicity = 0;
        Object.preventExtensions(this);
      }

      return ClassChildDocument;

    })();
    ClassDocument = (function(_super) {
      var connectNodeStyle, disconnectNodeStyle, getChildClass, onNodeAdd, onNodeRemove, onNodeStyleChange, onTargetChange;

      __extends(ClassDocument, _super);

      ClassDocument.__name__ = 'ClassDocument';

      itemUtils.defineProperty({
        constructor: Class,
        name: 'document',
        valueConstructor: ClassDocument
      });

      onTargetChange = function(oldVal) {
        var val;
        if (oldVal) {
          oldVal.document.onNodeChange.disconnect(this.reloadQuery, this);
        }
        if (val = this._ref._target) {
          val.document.onNodeChange(this.reloadQuery, this);
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
        ref.onTargetChange(onTargetChange, this);
        onTargetChange.call(this, ref._target);
      }

      itemUtils.defineProperty({
        constructor: ClassDocument,
        name: 'query',
        defaultValue: '',
        namespace: 'document',
        parentConstructor: ClassDocument,
        developmentSetter: function(val) {
          return assert.isString(val);
        },
        setter: function(_super) {
          return function(val) {
            var Document, cmdLen, oldPriority;
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
              Document = require('document');
              cmdLen = Document.Element.Tag.query.getSelectorCommandsLength(val);
              oldPriority = this._priority;
              this._priority = cmdLen;
              this._ref._nestingPriority += cmdLen - oldPriority;
              updatePriorities(this._ref);
            }
            if (!val) {
              loadObjects(this, this._component, this._target);
            }
          };
        }
      });

      getChildClass = function(style, parentClass) {
        var classElem, _i, _len, _ref, _ref1;
        _ref = style._extensions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          classElem = _ref[_i];
          if (classElem instanceof Class) {
            if (((_ref1 = classElem._document) != null ? _ref1._parent : void 0) === parentClass) {
              return classElem;
            }
          }
        }
      };

      connectNodeStyle = function(style) {
        var classElem, newComp, uid, _i, _len, _ref, _ref1;
        uid = this._ref._classUid;
        _ref = style._extensions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          classElem = _ref[_i];
          if (classElem instanceof Class) {
            if (classElem !== this._ref && classElem._classUid === uid && classElem._document instanceof ClassChildDocument) {
              classElem._document._multiplicity++;
              return;
            }
          }
        }
        if (!(classElem = this._classesPool.pop())) {
          newComp = this._ref._component.cloneComponentObject();
          classElem = cloneClassWithNoDocument.call(this._ref, newComp);
          classElem._document = new ClassChildDocument(this);
        }
        this._classesInUse.push(classElem);
        classElem.target = style;
        if (!((_ref1 = classElem._bindings) != null ? _ref1.when : void 0)) {
          classElem.enable();
        }
      };

      disconnectNodeStyle = function(style) {
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

      onNodeStyleChange = function(oldVal, val) {
        if (oldVal) {
          disconnectNodeStyle.call(this, oldVal);
        }
        if (val) {
          connectNodeStyle.call(this, val);
        }
      };

      onNodeAdd = function(node) {
        node.onStyleChange(onNodeStyleChange, this);
        onNodeStyleChange.call(this, null, node.style);
      };

      onNodeRemove = function(node) {
        var style;
        node.onStyleChange.disconnect(onNodeStyleChange, this);
        if (style = node._style) {
          disconnectNodeStyle.call(this, style);
        }
      };

      ClassDocument.prototype.reloadQuery = function() {
        var classElem, node, query, target, watcher, _ref;
        if ((_ref = this._nodeWatcher) != null) {
          _ref.disconnect();
        }
        this._nodeWatcher = null;
        while (classElem = this._classesInUse.pop()) {
          classElem.target = null;
          this._classesPool.push(classElem);
        }
        if ((query = this._query) && (target = this._ref.target) && (node = target.document.node)) {
          watcher = this._nodeWatcher = node.watch(query);
          watcher.onAdd(onNodeAdd, this);
          watcher.onRemove(onNodeRemove, this);
        }
      };

      return ClassDocument;

    })(itemUtils.DeepObject);
    normalizeClassesValue = function(val) {
      if (typeof val === 'string') {
        if (val.indexOf(',') !== -1) {
          val = val.split(',');
        } else {
          val = val.split(' ');
        }
      } else if (val instanceof List) {
        val = val.items();
      }
      return val;
    };
    ClassesList = (function(_super) {
      __extends(ClassesList, _super);

      function ClassesList() {
        ClassesList.__super__.constructor.call(this);
      }

      utils.defineProperty(ClassesList.prototype, 'append', null, (function(_super) {
        return function() {
          return _super;
        };
      })(ClassesList.prototype.append), function(val) {
        var name, _i, _len;
        val = normalizeClassesValue(val);
        if (Array.isArray(val)) {
          for (_i = 0, _len = val.length; _i < _len; _i++) {
            name = val[_i];
            if (name = name.trim()) {
              this.append(name);
            }
          }
        }
      });

      utils.defineProperty(ClassesList.prototype, 'remove', null, (function(_super) {
        return function() {
          return _super;
        };
      })(ClassesList.prototype.remove), function(val) {
        var name, _i, _len;
        val = normalizeClassesValue(val);
        if (Array.isArray(val)) {
          for (_i = 0, _len = val.length; _i < _len; _i++) {
            name = val[_i];
            if (name = name.trim()) {
              this.remove(name);
            }
          }
        }
      });

      return ClassesList;

    })(List);
    Renderer.onReady(function() {
      return itemUtils.defineProperty({
        constructor: Renderer.Item,
        name: 'classes',
        defaultValue: null,
        getter: (function() {
          var onChange, onInsert, onPop;
          onChange = function(oldVal, index) {
            var val;
            val = this._classes.get(index);
            onPop.call(this, oldVal, index);
            onInsert.call(this, val, index);
            this.onClassesChange.emit(val, oldVal);
          };
          onInsert = function(val, index) {
            var _ref;
            if ((_ref = this._classExtensions[val]) != null) {
              _ref.enable();
            }
            this.onClassesChange.emit(val);
          };
          onPop = function(oldVal, index) {
            var _ref;
            if (!this._classes.has(oldVal)) {
              if ((_ref = this._classExtensions[oldVal]) != null) {
                _ref.disable();
              }
            }
            this.onClassesChange.emit(null, oldVal);
          };
          return function(_super) {
            return function() {
              var list;
              if (!this._classes) {
                if (this._classExtensions == null) {
                  this._classExtensions = {};
                }
                list = this._classes = new ClassesList;
                list.onChange(onChange, this);
                list.onInsert(onInsert, this);
                list.onPop(onPop, this);
              }
              return _super.call(this);
            };
          };
        })(),
        setter: function(_super) {
          return function(val) {
            var classes, name, _i, _len;
            val = normalizeClassesValue(val);
            classes = this.classes;
            classes.clear();
            if (Array.isArray(val)) {
              for (_i = 0, _len = val.length; _i < _len; _i++) {
                name = val[_i];
                if (name = name.trim()) {
                  classes.append(name);
                }
              }
            }
          };
        }
      });
    });
    return Class;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/animation.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/animation.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Animation;
    return Animation = (function(_super) {
      __extends(Animation, _super);

      Animation.__name__ = 'Animation';

      function Animation(component, opts) {
        this._loop = false;
        this._updatePending = false;
        this._paused = false;
        Animation.__super__.constructor.call(this, component, opts);
      }

      signal.Emitter.createSignal(Animation, 'onStart');

      signal.Emitter.createSignal(Animation, 'onStop');

      itemUtils.defineProperty({
        constructor: Animation,
        name: 'running',
        setter: function(_super) {
          return function(val) {
            var oldVal;
            this._when = val;
            oldVal = this._running;
            if (oldVal === val) {
              return;
            }
            assert.isBoolean(val);
            _super.call(this, val);
            if (val) {
              Impl.startAnimation.call(this);
              this.onStart.emit();
              if (this._paused) {
                Impl.pauseAnimation.call(this);
              }
            } else {
              if (this._paused) {
                this.paused = false;
              }
              Impl.stopAnimation.call(this);
              this.onStop.emit();
            }
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Animation,
        name: 'paused',
        setter: function(_super) {
          return function(val) {
            var oldVal;
            oldVal = this._paused;
            if (oldVal === val) {
              return;
            }
            assert.isBoolean(val);
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
        name: 'loop',
        implementation: Impl.setAnimationLoop,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      utils.defineProperty(Animation.prototype, 'updatePending', null, function() {
        return this._updatePending;
      }, null);

      Animation.prototype.start = function() {
        this.running = true;
        return this;
      };

      Animation.prototype.stop = function() {
        this.running = false;
        return this;
      };

      Animation.prototype.pause = function() {
        if (this.running) {
          this.paused = true;
        }
        return this;
      };

      Animation.prototype.resume = function() {
        this.paused = false;
        return this;
      };

      Animation.prototype.enable = function() {
        this.running = true;
        return Animation.__super__.enable.call(this);
      };

      Animation.prototype.disable = function() {
        this.running = false;
        return Animation.__super__.disable.call(this);
      };

      return Animation;

    })(Renderer.Extension);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/animation/types/property.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/animation/types/property.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  log = log.scope('Renderer', 'PropertyAnimation');

  module.exports = function(Renderer, Impl, itemUtils) {
    var PropertyAnimation;
    return PropertyAnimation = (function(_super) {
      var Easing, getter, setter;

      __extends(PropertyAnimation, _super);

      PropertyAnimation.__name__ = 'PropertyAnimation';

      function PropertyAnimation(component, opts) {
        this._target = null;
        this._property = '';
        this._autoFrom = true;
        this._duration = 250;
        this._startDelay = 0;
        this._loopDelay = 0;
        this._updateData = false;
        this._updateProperty = false;
        this._easing = null;
        PropertyAnimation.__super__.constructor.call(this, component, opts);
      }

      getter = utils.lookupGetter(PropertyAnimation.prototype, 'running');

      setter = utils.lookupSetter(PropertyAnimation.prototype, 'running');

      utils.defineProperty(PropertyAnimation.prototype, 'running', null, getter, (function(_super) {
        return function(val) {
          if (val && this._autoFrom && this._target) {
            this.from = this._target[this._property];
            this._autoFrom = true;
          }
          _super.call(this, val);
        };
      })(setter));

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'target',
        defaultValue: null,
        implementation: Impl.setPropertyAnimationTarget,
        setter: function(_super) {
          return function(val) {
            var oldVal;
            oldVal = this._target;
            if (oldVal) {
              utils.remove(oldVal._extensions, this);
            }
            if (val) {
              val._extensions.push(this);
            }
            _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'property',
        defaultValue: '',
        implementation: Impl.setPropertyAnimationProperty,
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'duration',
        defaultValue: 250,
        implementation: Impl.setPropertyAnimationDuration,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        },
        setter: function(_super) {
          return function(val) {
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
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'loopDelay',
        defaultValue: 0,
        implementation: Impl.setPropertyAnimationLoopDelay,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'delay',
        defaultValue: 0,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        },
        getter: function(_super) {
          return function(val) {
            if (this._startDelay === this._loopDelay) {
              return this._startDelay;
            } else {
              throw new Error("startDelay and loopDelay are different");
            }
          };
        },
        setter: function(_super) {
          return function(val) {
            this.startDelay = val;
            this.loopDelay = val;
            _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'updateData',
        defaultValue: false,
        implementation: Impl.setPropertyAnimationUpdateData,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        },
        setter: function(_super) {
          return function(val) {
            if (!val) {
              this.updateProperty = false;
            }
            _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'updateProperty',
        defaultValue: false,
        implementation: Impl.setPropertyAnimationUpdateProperty,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        },
        setter: function(_super) {
          return function(val) {
            this.updateData = true;
            _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: PropertyAnimation,
        name: 'from',
        implementation: Impl.setPropertyAnimationFrom,
        setter: function(_super) {
          return function(val) {
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

      utils.defineProperty(PropertyAnimation.prototype, 'progress', null, function() {
        return Impl.getPropertyAnimationProgress.call(this);
      }, null);

      utils.defineProperty(PropertyAnimation.prototype, 'easing', null, function() {
        return this._easing || (this._easing = new Easing(this));
      }, function(val) {
        if (typeof val === 'string') {
          return this.easing.type = val;
        } else if (utils.isObject(val)) {
          return utils.merge(this.easing, val);
        } else if (!val) {
          return this.easing.type = 'Linear';
        }
      });

      Easing = (function(_super1) {
        var EASINGS, EASING_ALIASES, easing, _i, _len;

        __extends(Easing, _super1);

        function Easing(ref) {
          this._type = 'Linear';
          Easing.__super__.constructor.call(this, ref);
        }

        EASINGS = ['Linear', 'InQuad', 'OutQuad', 'InOutQuad', 'InCubic', 'OutCubic', 'InOutCubic', 'InQuart', 'OutQuart', 'InOutQuart', 'InQuint', 'OutQuint', 'InOutQuint', 'InSine', 'OutSine', 'InOutSine', 'InExpo', 'OutExpo', 'InOutExpo', 'InCirc', 'OutCirc', 'InOutCirc', 'InElastic', 'OutElastic', 'InOutElastic', 'InBack', 'OutBack', 'InOutBack', 'InBounce', 'OutBounce', 'InOutBounce'];

        EASING_ALIASES = Object.create(null);

        for (_i = 0, _len = EASINGS.length; _i < _len; _i++) {
          easing = EASINGS[_i];
          EASING_ALIASES[easing] = easing;
          EASING_ALIASES[easing.toLowerCase()] = easing;
        }

        itemUtils.defineProperty({
          constructor: Easing,
          name: 'type',
          defaultValue: 'Linear',
          namespace: 'easing',
          parentConstructor: PropertyAnimation,
          implementation: Impl.setPropertyAnimationEasingType,
          developmentSetter: function(val) {
            if (val) {
              return assert.isString(val);
            }
          },
          setter: function(_super) {
            return function(val) {
              var type;
              if (!val) {
                val = 'Linear';
              }
              type = EASING_ALIASES[val];
              type || (type = EASING_ALIASES[val.toLowerCase()]);
              if (!type) {
                log.warn("Easing type not recognized; '" + val + "' given");
                type = 'Linear';
              }
              _super.call(this, type);
            };
          }
        });

        return Easing;

      })(itemUtils.DeepObject);

      return PropertyAnimation;

    })(Renderer.Animation);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/animation/types/property/types/number.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/animation/types/property/types/number.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var NumberAnimation;
    return NumberAnimation = (function(_super) {
      __extends(NumberAnimation, _super);

      NumberAnimation.__name__ = 'NumberAnimation';

      function NumberAnimation(component, opts) {
        this._from = 0;
        this._to = 0;
        NumberAnimation.__super__.constructor.call(this, component, opts);
      }

      return NumberAnimation;

    })(Renderer.PropertyAnimation);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/transition.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/transition.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  log = require('log');

  log = log.scope('Renderer', 'Transition');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Transition;
    return Transition = (function(_super) {
      var NOP_BINDING, listener, onDurationChange, onTargetReady;

      __extends(Transition, _super);

      Transition.__name__ = 'Transition';

      function Transition(component, opts) {
        this._animation = null;
        this._property = '';
        this._duration = 0;
        this._to = 0;
        this._durationUpdatePending = false;
        Transition.__super__.constructor.call(this, component, opts);
      }

      listener = function(oldVal) {
        var animation, progress, to;
        animation = this.animation;
        to = this._target[this.property];
        if (!animation || !this.running || animation.updatePending || !utils.isFloat(oldVal) || !utils.isFloat(to)) {
          return;
        }
        this._to = to;
        progress = animation.progress;
        animation.stop();
        this._durationUpdatePending = true;
        animation.duration = this._duration;
        this._durationUpdatePending = false;
        animation.from = oldVal;
        animation.to = this._to;
        if (progress > 0) {
          this._durationUpdatePending = true;
          animation.duration = this._duration * progress;
          this._durationUpdatePending = false;
        }
        if (animation.target == null) {
          animation.target = this.target;
        }
        animation.start();
      };

      onTargetReady = function() {
        return this._running = true;
      };

      itemUtils.defineProperty({
        constructor: Transition,
        name: 'target',
        defaultValue: null,
        setter: function(_super) {
          return function(val) {
            var animation, handlerName, item, oldVal, property, _ref;
            oldVal = this.target;
            if (oldVal === val) {
              return;
            }
            animation = this.animation, property = this.property;
            if (animation) {
              animation.target = val;
              animation.stop();
            }
            _super.call(this, val);
            if (oldVal) {
              utils.remove(oldVal._extensions, this);
            }
            this._running = false;
            if (val instanceof itemUtils.Object) {
              item = val;
            } else if (val instanceof itemUtils.MutableDeepObject) {
              item = val._ref;
            } else {
              setImmediate(onTargetReady.bind(this));
            }
            if (item) {
              item._extensions.push(this);
              this._running = true;
            }
            if (property) {
              handlerName = itemUtils.getPropHandlerName(property);
              if (oldVal) {
                if ((_ref = oldVal[handlerName]) != null) {
                  _ref.disconnect(listener, this);
                }
              }
              if (val) {
                if (handlerName in val) {
                  val[handlerName](listener, this);
                } else {
                  log.error("'" + property + "' property signal not found");
                }
              }
            }
          };
        }
      });

      onDurationChange = function() {
        if (!this._durationUpdatePending) {
          this._duration = this._animation._duration;
        }
      };

      NOP_BINDING = [
        (function() {
          return false;
        })
      ];

      itemUtils.defineProperty({
        constructor: Transition,
        name: 'animation',
        defaultValue: null,
        developmentSetter: function(val) {
          if (val != null) {
            return assert.instanceOf(val, Renderer.Animation);
          }
        },
        setter: function(_super) {
          return function(val) {
            var oldVal;
            oldVal = this.animation;
            if (oldVal === val) {
              return;
            }
            _super.call(this, val);
            if (oldVal) {
              oldVal.onDurationChange.disconnect(onDurationChange, this);
              oldVal.target = null;
              oldVal.stop();
            }
            if (val) {
              val.onDurationChange(onDurationChange, this);
              this._duration = val.duration;
              val.target = null;
              val.property = this.property;
            }
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Transition,
        name: 'property',
        defaultValue: '',
        setter: function(_super) {
          return function(val) {
            var animation, chain, chains, handlerName, i, n, oldVal, target, _i, _len;
            oldVal = this.property;
            if (oldVal === val) {
              return;
            }
            animation = this.animation, target = this.target;
            if (target && val.indexOf('.') !== -1) {
              chains = val.split('.');
              n = chains.length;
              for (i = _i = 0, _len = chains.length; _i < _len; i = ++_i) {
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
                handlerName = "on" + (utils.capitalize(oldVal)) + "Change";
                target[handlerName].disconnect(listener, this);
              }
              if (val) {
                handlerName = "on" + (utils.capitalize(val)) + "Change";
                target[handlerName](listener, this);
              }
            }
          };
        }
      });

      return Transition;

    })(Renderer.Extension);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/component.coffee'] = (function(){
var module = {exports: modules["../renderer/types/basics/component.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils;

  utils = require('utils');

  signal = require('signal');

  assert = require('neft-assert');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Component;
    return Component = (function() {
      var Link, cloneItem, cloneObject, endComponentCloning, initSignalArr;

      Component.getCloneFunction = function(func, name) {
        if (typeof func === 'function') {
          return func;
        } else if (func && typeof func._main === 'function') {
          return func._main;
        } else {
          throw new Error("'" + name + "' is not an item definition");
        }
      };

      function Component(original, opts) {
        if (!(original instanceof Component)) {
          opts = original;
          original = null;
        }
        if (original != null) {
          assert.instanceOf(original, Component);
          while (original.parent) {
            original = original.parent;
          }
        }
        this.id = (original != null ? original.id : void 0) || utils.uid();
        this.item = null;
        this.itemId = (original != null ? original.itemId : void 0) || '';
        this.fileName = (opts != null ? opts.fileName : void 0) || (original != null ? original.fileName : void 0) || 'unknown';
        this.objects = {};
        this.idsOrder = (original != null ? original.idsOrder : void 0) || null;
        this.objectsOrder = [];
        this.objectsOrderSignalArr = null;
        this.isClone = !!original;
        this.isDeepClone = false;
        this.ready = false;
        this.mirror = false;
        this.belongsToComponent = null;
        this.objectsInitQueue = [];
        this.cache = Object.create(null);
        this.parent = original;
        this.disabledObjects = (original != null ? original.disabledObjects : void 0) || Object.create(null);
        this.clone = utils.bindFunctionContext(this.clone, this);
        this.createItem = utils.bindFunctionContext(this.createItem, this);
        this.createItem.getComponent = this.clone;
        this.onObjectChange = null;
        Object.preventExtensions(this);
      }

      initSignalArr = function() {
        this.objectsOrderSignalArr = utils.clone(this.objectsOrder);
        return this.objectsOrderSignalArr.push(null, null);
      };

      Component.prototype.initAsEmptyDefinition = function() {
        initSignalArr.call(this);
        Object.freeze(this);
        this.initObjects();
      };

      Component.prototype.init = function() {
        var i, n, objectsInitQueue;
        assert.notOk(this.ready);
        assert.ok(this.isClone);
        if (this.onObjectChange == null) {
          this.onObjectChange = signal.create();
        }
        initSignalArr.call(this);
        this.ready = true;
        objectsInitQueue = this.objectsInitQueue;
        i = 0;
        n = objectsInitQueue.length;
        while (i < n) {
          objectsInitQueue[i].apply(objectsInitQueue[i + 1], objectsInitQueue[i + 2]);
          i += 3;
        }
        this.objectsInitQueue = null;
        return Object.freeze(this);
      };

      Component.prototype.initObjects = function() {
        var extension, id, item, _i, _len, _ref, _ref1, _ref2, _ref3;
        _ref = this.objects;
        for (id in _ref) {
          item = _ref[id];
          if (this.objects.hasOwnProperty(id)) {
            _ref1 = item._extensions;
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              extension = _ref1[_i];
              if (!extension.name && !((_ref2 = extension._bindings) != null ? _ref2.when : void 0)) {
                extension.enable();
              }
            }
          }
        }
        _ref3 = this.objects;
        for (id in _ref3) {
          item = _ref3[id];
          if (this.objects.hasOwnProperty(id) && item instanceof Renderer.Item && id !== this.itemId) {
            item.onReady.emit();
          }
        }
      };

      endComponentCloning = function(comp, components, createdComponents) {
        var id, newObj, obj, _ref;
        _ref = comp.parent.objects;
        for (id in _ref) {
          obj = _ref[id];
          if (!comp.objects[id] && id !== comp.itemId && !comp.disabledObjects[id]) {
            newObj = cloneObject(obj, components, createdComponents, comp);
          }
        }
        comp.init();
      };

      cloneObject = function(item, components, createdComponents, parentComponent) {
        var belongsToComponent, child, clone, cloneChild, cloneExt, component, ext, firstChildren, itemCompId, needsNewComp, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3;
        needsNewComp = false;
        itemCompId = item._component.id;
        if (!(component = components[itemCompId])) {
          needsNewComp = true;
          component = components[itemCompId] = new Component(item._component);
          if (belongsToComponent = item._component.belongsToComponent) {
            component.belongsToComponent = components[belongsToComponent.id];
          }
          component.mirror = parentComponent.mirror;
          createdComponents.push(component);
        }
        clone = item.clone(component);
        if (item._component.item === item) {
          component.item = clone;
        }
        if (clone.id) {
          if (item._component.item === item) {
            if (belongsToComponent = item._component.belongsToComponent) {
              components[belongsToComponent.id].setObject(clone, clone.id);
            }
            component.setObject(clone, component.itemId);
          } else {
            component.setObject(clone, clone.id);
          }
        }
        _ref = item._extensions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          ext = _ref[_i];
          cloneExt = (_ref1 = components[ext._component.id]) != null ? _ref1.objects[ext.id] : void 0;
          if (cloneExt == null) {
            cloneExt = cloneObject(ext, components, createdComponents, parentComponent);
          }
          cloneExt.target = clone;
        }
        if (item instanceof Renderer.Item) {
          if (clone.children.length) {
            firstChildren = Array.prototype.slice.call(clone.children);
            clone.children.clear();
          }
          _ref2 = item.children;
          for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
            child = _ref2[_j];
            cloneChild = (_ref3 = components[child._component.id]) != null ? _ref3.objects[child.id] : void 0;
            if (cloneChild == null) {
              cloneChild = cloneItem(child, components, createdComponents, component);
            }
            cloneChild.parent = clone;
          }
          if (firstChildren) {
            for (_k = 0, _len2 = firstChildren.length; _k < _len2; _k++) {
              child = firstChildren[_k];
              child.parent = clone;
            }
          }
        }
        return clone;
      };

      cloneItem = function(item, components, createdComponents, parentComponent) {
        var clone, itemCompId, needsNewComp;
        itemCompId = item._component.id;
        needsNewComp = !components[itemCompId];
        clone = cloneObject(item, components, createdComponents, parentComponent);
        if (needsNewComp) {
          endComponentCloning(components[itemCompId], components, createdComponents);
          components[itemCompId] = null;
        }
        return clone;
      };

      Component.prototype.clone = function(parentComponent, itemOpts) {
        var comp, component, components, createdComponents, item, _i, _j, _k, _len, _len1, _len2;
        if (!(parentComponent instanceof Component)) {
          itemOpts = parentComponent;
          parentComponent = null;
        }
        component = new Component(this);
        component.mirror = !parentComponent;
        component.belongsToComponent = parentComponent;
        components = {};
        components[component.id] = component;
        if (parentComponent) {
          components[parentComponent.id] = parentComponent;
        }
        createdComponents = [component];
        item = cloneItem(this.item, components, createdComponents, component);
        for (_i = 0, _len = createdComponents.length; _i < _len; _i++) {
          comp = createdComponents[_i];
          if (!comp.item) {
            comp.item = item;
            if (!comp.objects[comp.itemId]) {
              comp.setObject(item, comp.itemId);
            }
          }
        }
        //<development>;
        Object.freeze(createdComponents);
        //</development>;
        if (itemOpts) {
          itemUtils.Object.setOpts(component.item, parentComponent, itemOpts);
        }
        for (_j = 0, _len1 = createdComponents.length; _j < _len1; _j++) {
          comp = createdComponents[_j];
          if (!comp.ready) {
            endComponentCloning(comp, components, createdComponents);
          }
        }
        if (component.mirror) {
          for (_k = 0, _len2 = createdComponents.length; _k < _len2; _k++) {
            comp = createdComponents[_k];
            assert.ok(comp.ready);
            comp.initObjects();
          }
        }
        item.onReady.emit();
        return component;
      };

      Component.prototype.setObject = function(object, id) {
        var index;
        assert.isString(id);
        assert.notLengthOf(id, 0);
        assert.ok(this.parent.objects[id]);
        assert.notOk(this.objects.hasOwnProperty(id));
        this.objects[id] = object;
        index = this.idsOrder.indexOf(id);
        if (index !== -1) {
          this.objectsOrder[index] = object;
        }
      };

      Component.prototype.createItem = function(arg1, arg2) {
        var component;
        component = this.clone(arg1, arg2);
        return component.item;
      };

      Component.prototype.cloneRawObject = function(item, opts) {
        var cache, clone, component, components, i, id, val, _base, _i, _len, _ref, _ref1;
        if (opts == null) {
          opts = 0;
        }
        assert.instanceOf(item, itemUtils.Object);
        assert.isString(item.id);
        assert.notLengthOf(item.id, 0);
        assert.ok(item.id !== this.itemId);
        assert.ok(this.objects[item.id] || ((_ref = this.parent) != null ? _ref.objects[item.id] : void 0));
        id = item.id;
        if ((cache = this.cache[id]) && cache.length > 0) {
          clone = this.cache[id].pop();
        } else {
          if (id === this.item.id) {
            clone = this.createItem();
          } else {
            component = new Component(this);
            component.objects = Object.create(this.objects);
            component.item = this.item;
            component.objectsOrderSignalArr = new Array(this.objectsOrder.length + 2);
            component.onObjectChange = this.onObjectChange;
            component.isDeepClone = true;
            component.ready = true;
            component.mirror = true;
            components = {};
            components[component.id] = component;
            clone = cloneItem(item, components, component);
            _ref1 = this.objectsOrder;
            for (i = _i = 0, _len = _ref1.length; _i < _len; i = ++_i) {
              val = _ref1[i];
              component.objectsOrder[i] = (_base = component.objectsOrderSignalArr)[i] || (_base[i] = val);
            }
          }
        }
        return clone;
      };

      Component.prototype.cloneObject = function(item, opts) {
        var clone;
        clone = this.cloneRawObject(item, opts);
        clone._component.initObjects();
        return clone;
      };

      Component.prototype.cloneComponentObject = function() {
        var comp;
        comp = new Component(this);
        comp.objects = Object.create(this.objects);
        comp.item = this.item;
        comp.objectsOrder = Object.create(this.objectsOrder);
        comp.objectsOrderSignalArr = Object.create(this.objectsOrderSignalArr);
        comp.onObjectChange = this.onObjectChange;
        comp.isDeepClone = true;
        comp.ready = true;
        comp.mirror = true;
        return comp;
      };

      Component.prototype.setObjectById = function(object, id) {
        var index, oldVal;
        assert.instanceOf(object, itemUtils.Object);
        assert.isString(id);
        assert.ok(this.objects[id]);
        if ((oldVal = this.objects[id]) === object) {
          return;
        }
        this.objects[id] = object;
        index = this.idsOrder.indexOf(id);
        if (index !== -1) {
          this.objectsOrder[index] = this.objectsOrderSignalArr[index] = object;
          this.onObjectChange.emit(id, oldVal);
        }
        return object;
      };

      Component.prototype.cacheObject = function(item) {
        var extension, id, objects, _base, _i, _len, _name, _ref, _ref1;
        assert.instanceOf(item, itemUtils.Object);
        assert.isString(item.id);
        assert.notLengthOf(item.id, 0);
        assert.ok(this.objects[item.id] || ((_ref = this.parent) != null ? _ref.objects[item.id] : void 0));
        assert.ok(item._component.isDeepClone);
        if ((_base = this.cache)[_name = item.id] == null) {
          _base[_name] = [];
        }
        this.cache[item.id].push(item);
        objects = item._component.objects;
        for (id in objects) {
          item = objects[id];
          if (objects.hasOwnProperty(id)) {
            _ref1 = item._extensions;
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              extension = _ref1[_i];
              extension.disable();
            }
          }
        }
      };

      Component.Link = Link = (function() {
        function Link(id) {
          this.id = id;
          Object.preventExtensions(this);
        }

        Link.prototype.getItem = function(component) {
          var obj;
          obj = component.objects[this.id];
          return obj;
        };

        return Link;

      })();

      return Component;

    })();
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","list":"../list/index.coffee.md","./item/spacing":"../renderer/types/basics/item/spacing.coffee.md","./item/alignment":"../renderer/types/basics/item/alignment.coffee.md","./item/anchors":"../renderer/types/basics/item/anchors.coffee.md","./item/layout":"../renderer/types/basics/item/layout.coffee.md","./item/margin":"../renderer/types/basics/item/margin.coffee.md","./item/pointer":"../renderer/types/basics/item/pointer.coffee.md","./item/keys":"../renderer/types/basics/item/keys.coffee.md","./item/document":"../renderer/types/basics/item/document.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, emitSignal, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  utils = require('utils');

  signal = require('signal');

  List = require('list');

  isArray = Array.isArray;

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('Renderer.Item');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Item;
    return Item = (function(_super) {
      var ChildrenObject, createDefaultBackground, defaultBackgroundClass, indexOf, pop, push, setFakeParent, shift, splice, _ref;

      __extends(Item, _super);

      Item.__name__ = 'Item';

      Item.__path__ = 'Renderer.Item';

      function Item(component, opts) {
        assert.instanceOf(this, Item, 'ctor ...');
        this._$ = null;
        this._parent = null;
        this._children = null;
        this._previousSibling = null;
        this._nextSibling = null;
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
        this._linkUri = '';
        this._anchors = null;
        this._layout = null;
        this._document = null;
        this._keys = null;
        this._pointer = null;
        this._margin = null;
        this._classes = null;
        this._background = null;
        this._defaultBackground = null;
        Item.__super__.constructor.call(this, component, opts);
      }

      itemUtils.defineProperty({
        constructor: Item,
        name: '$',
        valueConstructor: itemUtils.CustomObject
      });

      signal.Emitter.createSignal(Item, 'onReady');

      signal.Emitter.createSignal(Item, 'onUpdate', (function() {
        var frame, items, now;
        now = Date.now();
        items = [];
        frame = function() {
          var item, ms, oldNow, _i, _len;
          oldNow = now;
          now = Date.now();
          ms = now - oldNow;
          for (_i = 0, _len = items.length; _i < _len; _i++) {
            item = items[_i];
            emitSignal(item, 'onUpdate', ms);
          }
          return requestAnimationFrame(frame);
        };
        if (typeof requestAnimationFrame === "function") {
          requestAnimationFrame(frame);
        }
        return function(item) {
          return items.push(item);
        };
      })());

      utils.defineProperty(Item.prototype, 'children', null, function() {
        return this._children || (this._children = new ChildrenObject(this));
      }, function(val) {
        var item, _i, _len;
        assert.isArray(val, '::children setter ...');
        this.clear();
        for (_i = 0, _len = val.length; _i < _len; _i++) {
          item = val[_i];
          val.parent = this;
        }
      });

      signal.Emitter.createSignal(Item, 'onChildrenChange');

      ChildrenObject = (function(_super1) {
        __extends(ChildrenObject, _super1);

        function ChildrenObject(ref) {
          this._layout = null;
          this._target = null;
          this.length = 0;
          ChildrenObject.__super__.constructor.call(this, ref);
        }

        itemUtils.defineProperty({
          constructor: ChildrenObject,
          name: 'layout',
          defaultValue: null,
          developmentSetter: function(val) {
            if (val != null) {
              return assert.instanceOf(val, Item);
            }
          },
          setter: function(_super) {
            return function(val) {
              var ref, _ref;
              if ((_ref = this._layout) != null ? _ref.effectItem : void 0) {
                this._layout.parent = null;
                this._layout.effectItem = this._layout;
              }
              _super.call(this, val);
              if ('_effectItem' in this._ref) {
                this._ref.effectItem = val ? null : this._ref;
              }
              if (val != null) {
                ref = this._ref;
                setFakeParent(val, ref, 0);
                if (val.effectItem) {
                  val.effectItem = ref;
                }
              }
            };
          }
        });

        itemUtils.defineProperty({
          constructor: ChildrenObject,
          name: 'target',
          defaultValue: null,
          developmentSetter: function(val) {
            if (val != null) {
              return assert.instanceOf(val, Item);
            }
          }
        });

        ChildrenObject.prototype.index = function(val) {
          return Array.prototype.indexOf.call(this, val);
        };

        ChildrenObject.prototype.indexOf = ChildrenObject.prototype.index;

        ChildrenObject.prototype.has = function(val) {
          return this.index(val) !== -1;
        };

        ChildrenObject.prototype.clear = function() {
          var child;
          while (child = this[0]) {
            child.parent = null;
          }
        };

        return ChildrenObject;

      })(itemUtils.MutableDeepObject);

      _ref = Array.prototype, indexOf = _ref.indexOf, splice = _ref.splice, push = _ref.push, shift = _ref.shift, pop = _ref.pop;

      setFakeParent = function(child, parent, index) {
        var oldParent;
        if (index == null) {
          index = -1;
        }
        oldParent = child._parent;
        child.parent = null;
        child._parent = parent;
        Impl.setItemParent.call(child, parent);
        if (index >= 0) {
          Impl.setItemIndex.call(child, index);
        }
        emitSignal(child, 'onParentChange', oldParent);
      };

      itemUtils.defineProperty({
        constructor: Item,
        name: 'parent',
        defaultValue: null,
        setter: function(_super) {
          return function(val) {
            var index, length, old, oldChildren, oldNextSibling, oldPreviousSibling, pointer, previousSibling, valChildren;
            if (val == null) {
              val = null;
            }
            old = this._parent;
            oldChildren = old != null ? old.children : void 0;
            valChildren = val != null ? val.children : void 0;
            if (valChildren != null ? valChildren._target : void 0) {
              val = valChildren._target;
              valChildren = val.children;
            }
            if (old === val) {
              return;
            }
            if (this._effectItem && this._effectItem !== this) {
              this._parent = val;
              Impl.setItemParent.call(this, val);
              emitSignal(this, 'onParentChange', old);
              return;
            }
            assert.isNot(this, val);
            if (pointer = this._pointer) {
              pointer.hover = pointer.pressed = false;
            }
            oldPreviousSibling = this._previousSibling;
            oldNextSibling = this._nextSibling;
            if (old !== null) {
              if (oldNextSibling === null) {
                index = oldChildren.length - 1;
                assert.ok(oldChildren[index] === this);
                pop.call(oldChildren);
              } else if (oldPreviousSibling === null) {
                index = 0;
                assert.ok(oldChildren[index] === this);
                shift.call(oldChildren);
              } else {
                index = indexOf.call(oldChildren, this);
                assert.ok(index !== -1);
                splice.call(oldChildren, index, 1);
              }
            }
            if (val !== null) {
              assert.instanceOf(val, Item, '::parent setter ...');
              length = push.call(valChildren, this);
            }
            if (oldPreviousSibling !== null) {
              oldPreviousSibling._nextSibling = oldNextSibling;
            }
            if (oldNextSibling !== null) {
              oldNextSibling._previousSibling = oldPreviousSibling;
            }
            if (val !== null) {
              previousSibling = valChildren[valChildren.length - 2] || null;
              this._previousSibling = previousSibling;
              if (previousSibling != null) {
                previousSibling._nextSibling = this;
              }
            } else {
              this._previousSibling = null;
            }
            if (oldNextSibling !== null) {
              this._nextSibling = null;
            }
            this._parent = val;
            Impl.setItemParent.call(this, val);
            if (old !== null) {
              emitSignal(old, 'onChildrenChange', null, this);
            }
            if (val !== null) {
              emitSignal(val, 'onChildrenChange', this);
            }
            emitSignal(this, 'onParentChange', old);
            if (oldPreviousSibling !== null) {
              emitSignal(oldPreviousSibling, 'onNextSiblingChange', this);
            }
            if (oldNextSibling !== null) {
              emitSignal(oldNextSibling, 'onPreviousSiblingChange', this);
            }
            if (val !== null || oldPreviousSibling !== null) {
              if (previousSibling != null) {
                emitSignal(previousSibling, 'onNextSiblingChange', null);
              }
              emitSignal(this, 'onPreviousSiblingChange', oldPreviousSibling);
            }
            if (oldNextSibling !== null) {
              emitSignal(this, 'onNextSiblingChange', oldNextSibling);
            }
          };
        }
      });

      utils.defineProperty(Item.prototype, 'previousSibling', null, function() {
        return this._previousSibling;
      }, function(val) {
        if (val == null) {
          val = null;
        }
        assert.isNot(this, val);
        if (val === this._previousSibling) {
          return;
        }
        if (val) {
          assert.instanceOf(val, Item);
          if (this._parent !== val._parent) {
            this.parent = val.parent;
          }
          this.index = val.index + 1;
        } else {
          this.index = 0;
        }
        assert.is(this._previousSibling, val);
      });

      signal.Emitter.createSignal(Item, 'onPreviousSiblingChange');

      utils.defineProperty(Item.prototype, 'nextSibling', null, function() {
        return this._nextSibling;
      }, function(val) {
        if (val == null) {
          val = null;
        }
        assert.isNot(this, val);
        if (val === this._nextSibling) {
          return;
        }
        if (val) {
          assert.instanceOf(val, Item);
          if (this._parent !== val._parent) {
            this.parent = val.parent;
          }
          this.index = val.index;
        } else if (this._parent) {
          this.index = this._parent.children.length;
        }
        assert.is(this._nextSibling, val);
      });

      signal.Emitter.createSignal(Item, 'onNextSiblingChange');

      utils.defineProperty(Item.prototype, 'index', null, function() {
        var _ref1;
        return ((_ref1 = this._parent) != null ? _ref1.children.index(this) : void 0) || 0;
      }, function(val) {
        var children, index, nextSibling, nextSiblingOldPreviousSibling, oldNextSibling, oldPreviousSibling, parent, previousSibling, previousSiblingOldNextSibling;
        assert.isInteger(val);
        assert.operator(val, '>=', 0);
        parent = this._parent;
        if (!parent) {
          return;
        }
        index = this.index;
        children = parent._children;
        if (val > children.length) {
          val = children.length;
        }
        if (index === val || index === val - 1) {
          return;
        }
        oldPreviousSibling = this._previousSibling;
        oldNextSibling = this._nextSibling;
        Impl.setItemIndex.call(this, val);
        if (oldPreviousSibling != null) {
          oldPreviousSibling._nextSibling = oldNextSibling;
        }
        if (oldNextSibling != null) {
          oldNextSibling._previousSibling = oldPreviousSibling;
        }
        Array.prototype.splice.call(children, index, 1);
        if (val > index) {
          val--;
        }
        Array.prototype.splice.call(children, val, 0, this);
        previousSibling = children[val - 1] || null;
        previousSiblingOldNextSibling = previousSibling != null ? previousSibling._nextSibling : void 0;
        nextSibling = children[val + 1] || null;
        nextSiblingOldPreviousSibling = nextSibling != null ? nextSibling._previousSibling : void 0;
        this._previousSibling = previousSibling;
        this._nextSibling = nextSibling;
        if (previousSibling != null) {
          previousSibling._nextSibling = this;
        }
        if (nextSibling != null) {
          nextSibling._previousSibling = this;
        }
        //<development>;
        index = this.index;
        assert.is(index, val);
        assert.is(children[index], this);
        assert.is(children[index - 1] || null, this._previousSibling);
        assert.is(children[index + 1] || null, this._nextSibling);
        if (this._previousSibling) {
          assert.is(this._previousSibling._nextSibling, this);
        } else {
          assert.is(index, 0);
        }
        if (this._nextSibling) {
          assert.is(this._nextSibling._previousSibling, this);
        } else {
          assert.is(index, children.length - 1);
        }
        if (oldPreviousSibling) {
          assert.is(oldPreviousSibling._nextSibling, oldNextSibling);
        }
        if (oldNextSibling) {
          assert.is(oldNextSibling._previousSibling, oldPreviousSibling);
        }
        //</development>;
        emitSignal(parent, 'onChildrenChange');
        if (oldPreviousSibling) {
          emitSignal(oldPreviousSibling, 'onNextSiblingChange', this);
        }
        if (oldNextSibling) {
          emitSignal(oldNextSibling, 'onPreviousSiblingChange', this);
        }
        emitSignal(this, 'onPreviousSiblingChange', oldPreviousSibling);
        if (previousSibling) {
          emitSignal(previousSibling, 'onNextSiblingChange', previousSiblingOldNextSibling);
        }
        emitSignal(this, 'onNextSiblingChange', oldNextSibling);
        if (nextSibling) {
          emitSignal(nextSibling, 'onPreviousSiblingChange', nextSiblingOldPreviousSibling);
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'visible',
        defaultValue: true,
        implementation: Impl.setItemVisible,
        developmentSetter: function(val) {
          return assert.isBoolean(val, '::visible setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'clip',
        defaultValue: false,
        implementation: Impl.setItemClip,
        developmentSetter: function(val) {
          return assert.isBoolean(val, '::clip setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'width',
        defaultValue: 0,
        implementation: Impl.setItemWidth,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::width setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'height',
        defaultValue: 0,
        implementation: Impl.setItemHeight,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::height setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'x',
        defaultValue: 0,
        implementation: Impl.setItemX,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::x setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'y',
        defaultValue: 0,
        implementation: Impl.setItemY,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::y setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'z',
        defaultValue: 0,
        implementation: Impl.setItemZ,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::z setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'scale',
        defaultValue: 1,
        implementation: Impl.setItemScale,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::scale setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'rotation',
        defaultValue: 0,
        implementation: Impl.setItemRotation,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::rotation setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'opacity',
        defaultValue: 1,
        implementation: Impl.setItemOpacity,
        developmentSetter: function(val) {
          return assert.isFloat(val, '::opacity setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: Item,
        name: 'linkUri',
        defaultValue: '',
        implementation: Impl.setItemLinkUri,
        developmentSetter: function(val) {
          return assert.isString(val, '::linkUri setter ...');
        }
      });

      defaultBackgroundClass = (function() {
        var ext;
        ext = new Renderer.Class(new Renderer.Component);
        ext.priority = -1;
        ext.changes.setAttribute('anchors.fill', ['parent']);
        return ext;
      })();

      createDefaultBackground = function(parent) {
        var ext, rect;
        rect = new Renderer.Rectangle(parent._component);
        ext = defaultBackgroundClass.clone(parent._component);
        ext.target = rect;
        ext.enable();
        return rect;
      };

      itemUtils.defineProperty({
        constructor: Item,
        name: 'background',
        defaultValue: null,
        developmentSetter: function(val) {
          if (val != null) {
            return assert.instanceOf(val, Item);
          }
        },
        getter: function(_super) {
          return function() {
            if (!this._background) {
              this._defaultBackground || (this._defaultBackground = createDefaultBackground(this));
              this.background = this._defaultBackground;
            }
            return _super.call(this);
          };
        },
        setter: function(_super) {
          return function(val) {
            var oldParent, oldVal;
            val || (val = this._defaultBackground);
            oldVal = this._background;
            if (val === oldVal) {
              return;
            }
            if (oldVal && oldVal._parent === this) {
              oldVal._parent = null;
              emitSignal(oldVal, 'onParentChange', this);
            }
            if (val) {
              oldParent = val._parent;
              if (val._previousSibling || val._nextSibling) {
                val.parent = null;
              }
              val._parent = this;
              emitSignal(val, 'onParentChange', oldParent);
            }
            Impl.setItemBackground.call(this, val);
            return _super.call(this, val);
          };
        }
      });

      Item.prototype.overlap = function(item) {
        assert.instanceOf(item, Item);
        return Impl.doItemOverlap.call(this, item);
      };

      Item.Spacing = require('./item/spacing')(Renderer, Impl, itemUtils, Item);

      Item.Alignment = require('./item/alignment')(Renderer, Impl, itemUtils, Item);

      Item.Anchors = require('./item/anchors')(Renderer, Impl, itemUtils, Item);

      Item.Layout = require('./item/layout')(Renderer, Impl, itemUtils, Item);

      Item.Margin = require('./item/margin')(Renderer, Impl, itemUtils, Item);

      Item.Pointer = require('./item/pointer')(Renderer, Impl, itemUtils, Item);

      Item.Keys = require('./item/keys')(Renderer, Impl, itemUtils, Item);

      Item.Document = require('./item/document')(Renderer, Impl, itemUtils, Item);

      Item.Anchors(Item);

      Item.Layout(Item);

      Item.Pointer(Item);

      Item.Margin(Item);

      Item.Keys(Item);

      Item.Document(Item);

      Item;

      return Item;

    })(itemUtils.Object);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/spacing.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/spacing.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    return function(ctor) {
      var Spacing;
      return Spacing = (function(_super) {
        __extends(Spacing, _super);

        Spacing.__name__ = 'Spacing';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'spacing',
          valueConstructor: Spacing,
          setter: function(_super) {
            return function(val) {
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
          this._column = 0;
          this._row = 0;
          Spacing.__super__.constructor.call(this, ref);
        }

        itemUtils.defineProperty({
          constructor: Spacing,
          name: 'column',
          defaultValue: 0,
          namespace: 'spacing',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "ColumnSpacing"],
          developmentSetter: function(val) {
            return assert.isFloat(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Spacing,
          name: 'row',
          defaultValue: 0,
          namespace: 'spacing',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "RowSpacing"],
          developmentSetter: function(val) {
            return assert.isFloat(val);
          }
        });

        Spacing.prototype.valueOf = function() {
          if (this.column === this.row) {
            return this.column;
          } else {
            throw new Error("column and row spacing are different");
          }
        };

        Spacing.prototype.toJSON = function() {
          return {
            column: this.column,
            row: this.row
          };
        };

        return Spacing;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/alignment.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/alignment.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    return function(ctor) {
      var Alignment;
      return Alignment = (function(_super) {
        __extends(Alignment, _super);

        Alignment.__name__ = 'Alignment';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'alignment',
          defaultValue: null,
          valueConstructor: Alignment,
          setter: function(_super) {
            return function(val) {
              var alignment;
              alignment = this.alignment;
              if (utils.isObject(val)) {
                if (val.horizontal != null) {
                  alignment.horizontal = val.horizontal;
                }
                if (val.vertical != null) {
                  alignment.vertical = val.vertical;
                }
              } else {
                alignment.horizontal = alignment.vertical = val;
              }
              _super.call(this, val);
            };
          }
        });

        function Alignment(ref) {
          this._horizontal = 'left';
          this._vertical = 'top';
          Alignment.__super__.constructor.call(this, ref);
        }

        itemUtils.defineProperty({
          constructor: Alignment,
          name: 'horizontal',
          defaultValue: 'left',
          namespace: 'alignment',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "AlignmentHorizontal"],
          developmentSetter: function(val) {
            return assert.isString(val);
          },
          setter: function(_super) {
            return function(val) {
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
          implementation: Impl["set" + ctor.__name__ + "AlignmentVertical"],
          developmentSetter: function(val) {
            return assert.isString(val);
          },
          setter: function(_super) {
            return function(val) {
              if (val == null) {
                val = 'top';
              }
              return _super.call(this, val);
            };
          }
        });

        Alignment.prototype.toJSON = function() {
          return {
            horizontal: this.horizontal,
            vertical: this.vertical
          };
        };

        return Alignment;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/anchors.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/anchors.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var FREE_H_LINE_REQ, FREE_V_LINE_REQ, H_LINE, H_LINES, H_LINE_REQ, LINE_REQ, ONLY_TARGET_ALLOW, V_LINE, V_LINES, V_LINE_REQ, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  log = require('log');

  assert = require('assert');

  signal = require('signal');

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

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor) {
      var Anchors;
      return Anchors = (function(_super) {
        var createAnchorProp, implMethod, stringValuesCache;

        __extends(Anchors, _super);

        Anchors.__name__ = 'Anchors';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'anchors',
          valueConstructor: Anchors,
          developmentSetter: function(val) {
            return assert.isObject(val);
          },
          setter: function(_super) {
            return function(val) {
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
          this._autoX = false;
          this._autoY = false;
          Anchors.__super__.constructor.call(this, ref);
        }

        implMethod = Impl["set" + ctor.__name__ + "Anchor"];

        stringValuesCache = Object.create(null);

        createAnchorProp = function(type, opts, getter) {
          var setter;
          if (opts == null) {
            opts = 0;
          }
          setter = function(_super) {
            return function(val) {
              var allowedLines, arr, line, target;
              if (val == null) {
                val = null;
              }
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
                    log.error(("`anchors." + type + "` expects only a target to be defined; ") + ("`'" + val + "'` given;\npointing to the line is not required ") + "(e.g `anchors.centerIn = parent`)");
                  }
                }
                if (opts & LINE_REQ) {
                  if (!(H_LINES[line] || V_LINES[line])) {
                    log.error(("`anchors." + type + "` expects an anchor line to be defined; ") + ("`'" + val + "'` given;\nuse one of the `" + (Object.keys(allowedLines)) + "`"));
                  }
                }
                if (opts & H_LINE_REQ) {
                  if (!H_LINES[line]) {
                    log.error(("`anchors." + type + "` can't be anchored to the vertical edge; ") + ("`'" + val + "'` given;\nuse one of the `" + (Object.keys(H_LINES)) + "`"));
                  }
                }
                if (opts & V_LINE_REQ) {
                  if (!V_LINES[line]) {
                    log.error(("`anchors." + type + "` can't be anchored to the horizontal edge; ") + ("`'" + val + "'` given;\nuse one of the `" + (Object.keys(V_LINES)) + "`"));
                  }
                }
                //</development>;
                if (val[0] === 'this') {
                  val[0] = this;
                }
              }
              if (opts & FREE_V_LINE_REQ) {
                this._autoX = !!val;
              }
              if (opts & FREE_H_LINE_REQ) {
                this._autoY = !!val;
              }
              return _super.call(this, val);
            };
          };
          return itemUtils.defineProperty({
            constructor: Anchors,
            name: type,
            defaultValue: null,
            implementation: function(val) {
              return implMethod.call(this, type, val);
            },
            namespace: 'anchors',
            parentConstructor: ctor,
            setter: setter,
            getter: function() {
              return getter;
            }
          });
        };

        createAnchorProp('left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function() {
          var _ref;
          if (this._ref) {
            return this._ref.x - (((_ref = this._ref._margin) != null ? _ref._left : void 0) || 0);
          }
        });

        createAnchorProp('right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function() {
          var _ref;
          if (this._ref) {
            return this._ref._x + this._ref._width + (((_ref = this._ref._margin) != null ? _ref._right : void 0) || 0);
          }
        });

        createAnchorProp('horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, function() {
          if (this._ref) {
            return this._ref._x + this._ref._width / 2;
          }
        });

        createAnchorProp('top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function() {
          var _ref;
          if (this._ref) {
            return this._ref._y - (((_ref = this._ref._margin) != null ? _ref._top : void 0) || 0);
          }
        });

        createAnchorProp('bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function() {
          var _ref;
          if (this._ref) {
            return this._ref._y + this._ref._height + (((_ref = this._ref._margin) != null ? _ref._bottom : void 0) || 0);
          }
        });

        createAnchorProp('verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, function() {
          if (this._ref) {
            return this._ref._y + this._ref._height / 2;
          }
        });

        createAnchorProp('centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ, function() {
          if (this._ref) {
            return [this.horizontalCenter, this.verticalCenter];
          }
        });

        createAnchorProp('fill', ONLY_TARGET_ALLOW, function() {
          if (this._ref) {
            return [this._ref._x, this._ref._y, this._ref._width, this._ref._height];
          }
        });

        createAnchorProp('fillWidth', ONLY_TARGET_ALLOW, function() {
          if (this._ref) {
            return [this._ref._x, this._ref._width];
          }
        });

        createAnchorProp('fillHeight', ONLY_TARGET_ALLOW, function() {
          if (this._ref) {
            return [this._ref._y, this._ref._height];
          }
        });

        return Anchors;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/layout.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/layout.coffee.md"]};
var require = getModule.bind(null, {"expect":"node_modules/expect/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, expect, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  expect = require('expect');

  utils = require('utils');

  signal = require('signal');

  assert = require('neft-assert');

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor, opts) {
      var Layout;
      return Layout = (function(_super) {
        var propertyName;

        __extends(Layout, _super);

        Layout.__name__ = 'Layout';

        propertyName = (opts != null ? opts.propertyName : void 0) || 'layout';

        itemUtils.defineProperty({
          constructor: ctor,
          name: propertyName,
          valueConstructor: Layout
        });

        function Layout(ref) {
          this._enabled = true;
          this._fillWidth = false;
          this._fillHeight = false;
          Layout.__super__.constructor.call(this, ref);
        }

        itemUtils.defineProperty({
          constructor: Layout,
          name: 'enabled',
          defaultValue: true,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          namespace: propertyName,
          parentConstructor: ctor
        });

        itemUtils.defineProperty({
          constructor: Layout,
          name: 'fillWidth',
          defaultValue: false,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          namespace: propertyName,
          parentConstructor: ctor
        });

        itemUtils.defineProperty({
          constructor: Layout,
          name: 'fillHeight',
          defaultValue: false,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          namespace: propertyName,
          parentConstructor: ctor
        });

        return Layout;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/margin.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/margin.coffee.md"]};
var require = getModule.bind(null, {"expect":"node_modules/expect/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, expect, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  expect = require('expect');

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor, opts) {
      var Margin;
      return Margin = (function(_super) {
        var createMarginProp, propertyName;

        __extends(Margin, _super);

        Margin.__name__ = 'Margin';

        propertyName = (opts != null ? opts.propertyName : void 0) || 'margin';

        itemUtils.defineProperty({
          constructor: ctor,
          name: propertyName,
          valueConstructor: Margin,
          setter: function(_super) {
            return function(val) {
              var arr, elem, i, margin, _i, _len;
              if (val == null) {
                val = 0;
              }
              margin = this[propertyName];
              if (typeof val === 'string') {
                arr = val.split(' ');
                for (i = _i = 0, _len = arr.length; _i < _len; i = ++_i) {
                  elem = arr[i];
                  arr[i] = parseFloat(elem);
                }
                switch (arr.length) {
                  case 3:
                    margin.top = arr[0];
                    margin.right = arr[1];
                    margin.bottom = arr[2];
                    margin.left = arr[1];
                    break;
                  case 2:
                    margin.top = arr[0];
                    margin.right = arr[1];
                    margin.bottom = arr[0];
                    margin.left = arr[1];
                    break;
                  case 1:
                    margin.left = margin.top = margin.right = margin.bottom = arr[0];
                    break;
                  default:
                    margin.top = arr[0];
                    margin.right = arr[1];
                    margin.bottom = arr[2];
                    margin.left = arr[3];
                }
              } else if (Array.isArray(val)) {
                if (val.length > 0) {
                  margin.top = val[0];
                }
                if (val.length > 1) {
                  margin.right = val[1];
                }
                if (val.length > 2) {
                  margin.bottom = val[2];
                }
                if (val.length > 3) {
                  margin.left = val[3];
                }
              } else if (utils.isObject(val)) {
                if (val.left != null) {
                  margin.left = val.left;
                }
                if (val.top != null) {
                  margin.top = val.top;
                }
                if (val.right != null) {
                  margin.right = val.right;
                }
                if (val.bottom != null) {
                  margin.bottom = val.bottom;
                }
              } else {
                margin.left = margin.top = margin.right = margin.bottom = val;
              }
              _super.call(this, val);
            };
          }
        });

        function Margin(ref) {
          this._left = 0;
          this._top = 0;
          this._right = 0;
          this._bottom = 0;
          Margin.__super__.constructor.call(this, ref);
        }

        createMarginProp = function(type, extraProp) {
          var developmentSetter, extraPropSignal;
          developmentSetter = function(val) {
            return assert(typeof val === 'number' && isFinite(val), "margin." + type + " expects a finite number; `" + val + "` given");
          };
          extraPropSignal = "on" + (utils.capitalize(extraProp)) + "Change";
          return itemUtils.defineProperty({
            constructor: Margin,
            name: type,
            defaultValue: 0,
            setter: function(_super) {
              return function(val) {
                var extraOldVal;
                extraOldVal = this[extraProp];
                _super.call(this, val);
                return this[extraPropSignal].emit(extraOldVal);
              };
            },
            namespace: propertyName,
            parentConstructor: ctor,
            developmentSetter: developmentSetter
          });
        };

        createMarginProp('left', 'horizontal');

        createMarginProp('top', 'vertical');

        createMarginProp('right', 'horizontal');

        createMarginProp('bottom', 'vertical');

        signal.Emitter.createSignal(Margin, 'onHorizontalChange');

        utils.defineProperty(Margin.prototype, 'horizontal', null, function() {
          return this._left + this._right;
        }, function(val) {
          return this.left = this.right = val / 2;
        });

        signal.Emitter.createSignal(Margin, 'onVerticalChange');

        utils.defineProperty(Margin.prototype, 'vertical', null, function() {
          return this._top + this._bottom;
        }, function(val) {
          return this.top = this.bottom = val / 2;
        });

        Margin.prototype.valueOf = function() {
          if (this.left === this.top && this.top === this.right && this.right === this.bottom) {
            return this.left;
          } else {
            throw new Error("margin values are different");
          }
        };

        Margin.prototype.toJSON = function() {
          return {
            left: this.left,
            top: this.top,
            right: this.right,
            bottom: this.bottom
          };
        };

        return Margin;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/pointer.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/pointer.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var NOP, assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  NOP = function() {};

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor) {
      var Pointer;
      return Pointer = (function(_super) {
        var initializeHover, intitializePressed, onLazySignalInitialized, signalName, _i, _len, _ref;

        __extends(Pointer, _super);

        Pointer.__name__ = 'Pointer';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'pointer',
          valueConstructor: Pointer
        });

        function Pointer(ref) {
          this._enabled = true;
          this._draggable = false;
          this._dragging = false;
          this._x = 0;
          this._y = 0;
          this._pressed = false;
          this._hover = false;
          this._pressedInitialized = false;
          this._hoverInitialized = false;
          Pointer.__super__.constructor.call(this, ref);
        }

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'enabled',
          defaultValue: true,
          namespace: 'pointer',
          parentConstructor: ctor,
          implementation: Impl.setItemPointerEnabled,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'draggable',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          implementation: Impl.setItemPointerDraggable,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'dragging',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          implementation: Impl.setItemPointerDragging,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        onLazySignalInitialized = function(pointer, name) {
          Impl.attachItemSignal.call(pointer, 'pointer', name);
          if (name === 'onPress' || name === 'onRelease') {
            intitializePressed(pointer);
          }
          if (name === 'onEnter' || name === 'onExit') {
            initializeHover(pointer);
          }
        };

        Pointer.SIGNALS = ['onClick', 'onPress', 'onRelease', 'onEnter', 'onExit', 'onWheel', 'onMove', 'onDragStart', 'onDragEnd', 'onDragEnter', 'onDragExit', 'onDrop'];

        _ref = Pointer.SIGNALS;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          signalName = _ref[_i];
          signal.Emitter.createSignal(Pointer, signalName, onLazySignalInitialized);
        }

        intitializePressed = (function() {
          var onPress, onRelease;
          onPress = function() {
            return this.pressed = true;
          };
          onRelease = function() {
            return this.pressed = false;
          };
          return function(pointer) {
            if (!pointer._pressedInitialized) {
              pointer._pressedInitialized = true;
              pointer.onPress(onPress);
              pointer.onRelease(onRelease);
            }
          };
        })();

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'pressed',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          signalInitializer: intitializePressed,
          getter: function(_super) {
            return function() {
              intitializePressed(this);
              return _super.call(this);
            };
          }
        });

        initializeHover = (function() {
          var onEnter, onExit;
          onEnter = function() {
            return this.hover = true;
          };
          onExit = function() {
            return this.hover = false;
          };
          return function(pointer) {
            if (!pointer._hoverInitialized) {
              pointer._hoverInitialized = true;
              pointer.onEnter(onEnter);
              pointer.onExit(onExit);
            }
          };
        })();

        itemUtils.defineProperty({
          constructor: Pointer,
          name: 'hover',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          signalInitializer: initializeHover,
          getter: function(_super) {
            return function() {
              initializeHover(this);
              return _super.call(this);
            };
          }
        });

        return Pointer;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/keys.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/keys.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor) {
      var Keys;
      return Keys = (function(_super) {
        var focusedKeys, onLazySignalInitialized, signalName, _i, _len, _ref;

        __extends(Keys, _super);

        Keys.__name__ = 'Keys';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'keys',
          valueConstructor: Keys
        });

        function Keys(ref) {
          this._focus = false;
          Keys.__super__.constructor.call(this, ref);
        }

        onLazySignalInitialized = function(keys, name) {
          return Impl.attachItemSignal.call(keys, 'keys', name);
        };

        Keys.SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput'];

        _ref = Keys.SIGNALS;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          signalName = _ref[_i];
          signal.Emitter.createSignal(Keys, signalName, onLazySignalInitialized);
        }

        focusedKeys = null;

        itemUtils.defineProperty({
          constructor: Keys,
          name: 'focus',
          defaultValue: false,
          namespace: 'keys',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "KeysFocus"],
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          setter: function(_super) {
            return function(val) {
              var oldVal;
              if (this._focus !== val) {
                if (val && focusedKeys !== this) {
                  if (focusedKeys) {
                    oldVal = focusedKeys;
                    focusedKeys = null;
                    oldVal._focus = false;
                    oldVal.onFocusChange.emit(true);
                    oldVal._ref.onKeysChange.emit(oldVal);
                  }
                  focusedKeys = this;
                }
                _super.call(this, val);
                if (!val && focusedKeys === this) {
                  focusedKeys = null;
                  if (focusedKeys !== Renderer.window.keys) {
                    Renderer.window.keys.focus = true;
                  }
                }
              }
            };
          }
        });

        return Keys;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/document.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/document.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('neft-assert');

  log = require('log');

  log = log.scope('Renderer', 'Document');

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    var exports;
    return exports = function(ctor) {
      var ItemDocument;
      return ItemDocument = (function(_super) {
        var DocumentHideEvent, DocumentShowEvent, disableProperties, enableProperties, onNodeAttrsChange, onPropertyChange, setProperty;

        __extends(ItemDocument, _super);

        ItemDocument.__name__ = 'Document';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'document',
          valueConstructor: ItemDocument
        });

        setProperty = function(props, attr, val, oldVal) {
          if (typeof props[attr] === 'function' && props[attr].connect) {
            if (typeof val === 'function') {
              props[attr](val);
            }
            if (typeof oldVal === 'function') {
              props[attr].disconnect(oldVal);
            }
          } else {
            this._updatingProperty = attr;
            props[attr] = val;
          }
        };

        onPropertyChange = function(prop, oldVal) {
          var node;
          if (this._updatingProperty === prop || !(node = this._node) || !node.attrs.has(prop)) {
            return;
          }
          if (oldVal === void 0) {
            setProperty.call(this, this._ref._$, prop, node._attrs[prop], oldVal);
          } else {
            node.attrs.set(prop, this._ref._$[prop]);
          }
        };

        onNodeAttrsChange = function(attr, oldVal) {
          var props;
          if (!(props = this._ref._$)) {
            return;
          }
          setProperty.call(this, props, attr, this._node._attrs[attr], oldVal);
        };

        enableProperties = function() {
          var attr, props, val, _ref;
          if (!(props = this._ref._$)) {
            return;
          }
          _ref = this._node._attrs;
          for (attr in _ref) {
            val = _ref[attr];
            if (attr in props) {
              this._propertiesCleanQueue.push(attr, props[attr], val);
              setProperty.call(this, props, attr, val, null);
            }
          }
        };

        disableProperties = function() {
          var attr, i, propertiesCleanQueue, props, _i, _len;
          if (!(propertiesCleanQueue = this._propertiesCleanQueue).length) {
            return;
          }
          props = this._ref._$;
          for (i = _i = 0, _len = propertiesCleanQueue.length; _i < _len; i = _i += 3) {
            attr = propertiesCleanQueue[i];
            setProperty.call(this, props, attr, propertiesCleanQueue[i + 1], propertiesCleanQueue[i + 2]);
          }
          utils.clear(propertiesCleanQueue);
        };

        function ItemDocument(ref) {
          this._node = null;
          this._visible = false;
          this._query = '';
          this._updatingProperty = '';
          this._propertiesCleanQueue = [];
          ref.on$Change(onPropertyChange, this);
          ItemDocument.__super__.constructor.call(this, ref);
        }

        utils.defineProperty(ItemDocument.prototype, 'query', null, function() {
          return this._query;
        }, function(val) {
          if (this._query === '') {
            this._query = val;
          }
        });

        itemUtils.defineProperty({
          constructor: ItemDocument,
          name: 'node',
          defaultValue: null,
          namespace: 'document',
          parentConstructor: ctor,
          developmentSetter: function(val) {
            if (val != null) {
              return assert.instanceOf(val, require('document').Element.Tag);
            }
          },
          setter: function(_super) {
            return function(val) {
              if (this._node) {
                this._node.onAttrsChange.disconnect(onNodeAttrsChange, this);
                disableProperties.call(this);
              }
              _super.call(this, val);
              if (val) {
                val.onAttrsChange(onNodeAttrsChange, this);
                return enableProperties.call(this);
              }
            };
          }
        });

        itemUtils.defineProperty({
          constructor: ItemDocument,
          name: 'visible',
          defaultValue: false,
          namespace: 'document',
          parentConstructor: ctor,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        signal.Emitter.createSignal(ItemDocument, 'onShow');

        signal.Emitter.createSignal(ItemDocument, 'onHide');

        exports.ShowEvent = DocumentShowEvent = (function() {
          function DocumentShowEvent() {
            this.delay = 0;
            Object.preventExtensions(this);
          }

          return DocumentShowEvent;

        })();

        exports.HideEvent = DocumentHideEvent = (function() {
          function DocumentHideEvent() {
            this.delay = 0;
            this.nextShowDelay = 0;
            Object.preventExtensions(this);
          }

          return DocumentHideEvent;

        })();

        return ItemDocument;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/types/image.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/types/image.coffee.md"]};
var require = getModule.bind(null, {"expect":"node_modules/expect/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, expect, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  expect = require('expect');

  assert = require('assert');

  signal = require('signal');

  log = require('log');

  utils = require('utils');

  log = log.scope('Renderer', 'Image');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Image;
    return Image = (function(_super) {
      var FILL_MODE_OPTIONS, getter, pixelRatio, setter, updateSizes;

      __extends(Image, _super);

      Image.__name__ = 'Image';

      Image.__path__ = 'Renderer.Image';

      function Image(component, opts) {
        this._source = '';
        this._loaded = false;
        this._autoWidth = true;
        this._autoHeight = true;
        this._sourceWidth = 0;
        this._sourceHeight = 0;
        this._fillMode = 'Stretch';
        Image.__super__.constructor.call(this, component, opts);
      }

      signal.create(Image, 'onPixelRatioChange');

      pixelRatio = 1;

      utils.defineProperty(Image, 'pixelRatio', utils.CONFIGURABLE, function() {
        return pixelRatio;
      }, function(val) {
        var oldVal;
        assert.isFloat(val);
        if (val === pixelRatio) {
          return;
        }
        oldVal = pixelRatio;
        pixelRatio = val;
        Impl.setStaticImagePixelRatio.call(this, val);
        return this.onPixelRatioChange.emit(oldVal);
      });

      updateSizes = function() {
        var autoHeight, autoWidth;
        if (this._autoHeight === this._autoWidth) {
          return;
        }
        if (this._autoHeight) {
          autoWidth = this._autoWidth;
          this._autoWidth = false;
          this.height = this._width / this.sourceWidth * this.sourceHeight || 0;
          this._autoWidth = autoWidth;
          this._autoHeight = true;
        }
        if (this._autoWidth) {
          autoHeight = this._autoHeight;
          this._autoHeight = false;
          this.width = this._height / this.sourceHeight * this.sourceWidth || 0;
          this._autoHeight = autoHeight;
          this._autoWidth = true;
        }
      };

      getter = utils.lookupGetter(Image.prototype, 'width');

      setter = utils.lookupSetter(Image.prototype, 'width');

      utils.defineProperty(Image.prototype, 'width', null, getter, (function(_super) {
        return function(val) {
          if (this._width !== val) {
            this._autoWidth = false;
            _super.call(this, val);
            updateSizes.call(this);
          }
        };
      })(setter));

      getter = utils.lookupGetter(Image.prototype, 'height');

      setter = utils.lookupSetter(Image.prototype, 'height');

      utils.defineProperty(Image.prototype, 'height', null, getter, (function(_super) {
        return function(val) {
          if (this._height !== val) {
            this._autoHeight = false;
            _super.call(this, val);
            updateSizes.call(this);
          }
        };
      })(setter));

      itemUtils.defineProperty({
        constructor: Image,
        name: 'source',
        defaultValue: '',
        developmentSetter: function(val) {
          return expect(val).toBe.string();
        },
        setter: (function() {
          var defaultSize, loadCallback;
          defaultSize = {
            width: 0,
            height: 0
          };
          loadCallback = function(err, opts) {
            if (err == null) {
              err = null;
            }
            if (err) {
              log.warn("Can't load '" + this.source + "' image at " + (this.toString()));
            } else {
              this.sourceWidth = opts.width;
              this.sourceHeight = opts.height;
              if (this._autoWidth) {
                this.width = opts.width;
                this._autoWidth = true;
              }
              if (this._autoHeight) {
                this.height = opts.height;
                this._autoHeight = true;
              }
              updateSizes.call(this);
            }
            this._loaded = true;
            this.onLoadedChange.emit(false);
            if (err) {
              return this.onError.emit(err);
            } else {
              return this.onLoad.emit();
            }
          };
          return function(_super) {
            return function(val) {
              _super.call(this, val);
              if (this._loaded) {
                this._loaded = false;
                this.onLoadedChange.emit(true);
              }
              if (val) {
                Impl.setImageSource.call(this, val, loadCallback);
              } else {
                Impl.setImageSource.call(this, null, null);
                loadCallback.call(this, null, defaultSize);
              }
            };
          };
        })()
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'sourceWidth',
        defaultValue: 0,
        implementation: Impl.setImageSourceWidth,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'sourceHeight',
        defaultValue: 0,
        implementation: Impl.setImageSourceHeight,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'offsetX',
        defaultValue: 0,
        implementation: Impl.setImageOffsetX,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'offsetY',
        defaultValue: 0,
        implementation: Impl.setImageOffsetY,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      FILL_MODE_OPTIONS = ['Stretch', 'Tile'];

      itemUtils.defineProperty({
        constructor: Image,
        name: 'fillMode',
        defaultValue: 'Stretch',
        implementation: Impl.setImageFillMode,
        developmentSetter: function(val) {
          if (val == null) {
            val = 'Stretch';
          }
          assert.isString(val);
          return assert.ok(utils.has(FILL_MODE_OPTIONS, val), "Accepted fillMode values: '" + FILL_MODE_OPTIONS + "'");
        }
      });

      utils.defineProperty(Image.prototype, 'loaded', null, function() {
        return this._loaded;
      }, null);

      signal.Emitter.createSignal(Image, 'onLoadedChange');

      signal.Emitter.createSignal(Image, 'onLoad');

      signal.Emitter.createSignal(Image, 'onError');

      return Image;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/types/text.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/types/text.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","./text/font":"../renderer/types/basics/item/types/text/font.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  log = log.scope('Renderer', 'Text');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Text;
    Text = (function(_super) {
      var SUPPORTED_HTML_TAGS;

      __extends(Text, _super);

      Text.__name__ = 'Text';

      Text.__path__ = 'Renderer.Text';

      SUPPORTED_HTML_TAGS = Text.SUPPORTED_HTML_TAGS = {
        __proto__: null,
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

      function Text(component, opts) {
        this._text = '';
        this._color = 'black';
        this._linkColor = 'blue';
        this._lineHeight = 1;
        this._font = null;
        this._alignment = null;
        Text.__super__.constructor.call(this, component, opts);
      }

      itemUtils.defineProperty({
        constructor: Text,
        name: 'text',
        defaultValue: '',
        implementation: Impl.setText,
        setter: function(_super) {
          return function(val) {
            return _super.call(this, val + '');
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Text,
        name: 'color',
        defaultValue: 'black',
        implementation: Impl.setTextColor,
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Text,
        name: 'linkColor',
        defaultValue: 'blue',
        implementation: Impl.setTextLinkColor,
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Text,
        name: 'lineHeight',
        defaultValue: 1,
        implementation: Impl.setTextLineHeight,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      Renderer.Item.Alignment(Text);

      Text.Font = require('./text/font')(Renderer, Impl, itemUtils);

      Text.Font(Text);

      return Text;

    })(Renderer.Item);
    return Text;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/types/text/font.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/types/text/font.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    return function(ctor) {
      var Font;
      return Font = (function(_super) {
        var checkingFamily;

        __extends(Font, _super);

        Font.__name__ = 'Font';

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'font',
          defaultValue: null,
          valueConstructor: Font,
          developmentSetter: function(val) {
            if (val != null) {
              return assert.isObject(val);
            }
          },
          setter: function(_super) {
            return function(val) {
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
          this._family = 'sans-serif';
          this._pixelSize = 14;
          this._weight = 0.4;
          this._wordSpacing = 0;
          this._letterSpacing = 0;
          this._italic = false;
          Font.__super__.constructor.call(this, ref);
        }

        //<development>;

        checkingFamily = {};

        //</development>;

        itemUtils.defineProperty({
          constructor: Font,
          name: 'family',
          defaultValue: 'sans-serif',
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontFamily"],
          developmentSetter: function(val) {
            assert.isString(val);
            if (!checkingFamily[val]) {
              checkingFamily[val] = true;
              return setTimeout((function(_this) {
                return function() {
                  if (!Renderer.FontLoader.fonts[val]) {
                    return log.warn("Font `" + _this.family + "` is not defined; use `FontLoader` to load a font");
                  }
                };
              })(this));
            }
          },
          setter: function(_super) {
            return function(val) {
              if (typeof val === 'string') {
                return _super.call(this, val.toLowerCase());
              } else {
                return _super.call(this, val);
              }
            };
          }
        });

        itemUtils.defineProperty({
          constructor: Font,
          name: 'pixelSize',
          defaultValue: 14,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontPixelSize"],
          developmentSetter: function(val) {
            return assert.isFloat(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Font,
          name: 'weight',
          defaultValue: 0.4,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontWeight"],
          developmentSetter: function(val) {
            assert.isFloat(val);
            assert.operator(val, '>=', 0);
            return assert.operator(val, '<=', 1);
          }
        });

        itemUtils.defineProperty({
          constructor: Font,
          name: 'wordSpacing',
          defaultValue: 0,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontWordSpacing"],
          developmentSetter: function(val) {
            return assert.isFloat(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Font,
          name: 'letterSpacing',
          defaultValue: 0,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontLetterSpacing"],
          developmentSetter: function(val) {
            return assert.isFloat(val);
          }
        });

        itemUtils.defineProperty({
          constructor: Font,
          name: 'italic',
          defaultValue: false,
          namespace: 'font',
          parentConstructor: ctor,
          implementation: Impl["set" + ctor.__name__ + "FontItalic"],
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        Font.prototype.toJSON = function() {
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

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/types/textInput.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/types/textInput.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  log = log.scope('Renderer', 'TextInput');

  module.exports = function(Renderer, Impl, itemUtils) {
    var TextInput;
    TextInput = (function(_super) {
      __extends(TextInput, _super);

      TextInput.__name__ = 'TextInput';

      TextInput.__path__ = 'Renderer.TextInput';

      function TextInput(component, opts) {
        this._text = '';
        this._color = 'black';
        this._lineHeight = 1;
        this._multiLine = false;
        this._echoMode = 'normal';
        this._alignment = null;
        this._font = null;
        TextInput.__super__.constructor.call(this, component, opts);
        this._width = 100;
        this._height = 50;
      }

      itemUtils.defineProperty({
        constructor: TextInput,
        name: 'text',
        defaultValue: '',
        implementation: Impl.setTextInputText,
        setter: function(_super) {
          return function(val) {
            return _super.call(this, val + '');
          };
        }
      });

      itemUtils.defineProperty({
        constructor: TextInput,
        name: 'color',
        defaultValue: 'black',
        implementation: Impl.setTextInputColor,
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: TextInput,
        name: 'lineHeight',
        defaultValue: 1,
        implementation: Impl.setTextInputLineHeight,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: TextInput,
        name: 'multiLine',
        defaultValue: false,
        implementation: Impl.setTextInputMultiLine,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      itemUtils.defineProperty({
        constructor: TextInput,
        name: 'echoMode',
        defaultValue: 'normal',
        implementation: Impl.setTextInputEchoMode,
        developmentSetter: function(val) {
          assert.isString(val);
          return assert.ok(val === '' || val === 'normal' || val === 'password');
        },
        setter: function(_super) {
          return function(val) {
            val || (val = 'normal');
            val = val.toLowerCase();
            return _super.call(this, val);
          };
        }
      });

      Renderer.Item.Alignment(TextInput);

      Renderer.Text.Font(TextInput);

      return TextInput;

    })(Renderer.Item);
    return TextInput;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/shapes/rectangle.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/shapes/rectangle.coffee.md"]};
var require = getModule.bind(null, {"expect":"node_modules/expect/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, expect, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  expect = require('expect');

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Border, Rectangle;
    Rectangle = (function(_super) {
      __extends(Rectangle, _super);

      Rectangle.__name__ = 'Rectangle';

      Rectangle.__path__ = 'Renderer.Rectangle';

      function Rectangle(component, opts) {
        this._color = 'transparent';
        this._radius = 0;
        this._border = null;
        Rectangle.__super__.constructor.call(this, component, opts);
      }

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'color',
        defaultValue: 'transparent',
        implementation: Impl.setRectangleColor,
        developmentSetter: function(val) {
          return expect(val).toBe.string();
        }
      });

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'radius',
        defaultValue: 0,
        implementation: Impl.setRectangleRadius,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      return Rectangle;

    })(Renderer.Item);
    Border = (function(_super) {
      __extends(Border, _super);

      Border.__name__ = 'Border';

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'border',
        valueConstructor: Border,
        developmentSetter: function(val) {
          return assert.isObject(val);
        },
        setter: function(_super) {
          return function(val) {
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
        this._color = 'transparent';
        Border.__super__.constructor.call(this, ref);
      }

      itemUtils.defineProperty({
        constructor: Border,
        name: 'width',
        defaultValue: 0,
        namespace: 'border',
        parentConstructor: Rectangle,
        implementation: Impl.setRectangleBorderWidth,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Border,
        name: 'color',
        defaultValue: 'transparent',
        namespace: 'border',
        parentConstructor: Rectangle,
        implementation: Impl.setRectangleBorderColor,
        developmentSetter: function(val) {
          return expect(val).toBe.string();
        }
      });

      Border.prototype.toJSON = function() {
        return {
          width: this.width,
          color: this.color
        };
      };

      return Border;

    })(itemUtils.DeepObject);
    return Rectangle;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/layout/grid.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/layout/grid.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Grid;
    return Grid = (function(_super) {
      __extends(Grid, _super);

      Grid.__name__ = 'Grid';

      Grid.__path__ = 'Renderer.Grid';

      function Grid(component, opts) {
        this._padding = null;
        this._columns = 2;
        this._rows = Infinity;
        this._spacing = null;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
        Grid.__super__.constructor.call(this, component, opts);
        this.effectItem = this;
      }

      utils.defineProperty(Grid.prototype, 'effectItem', null, function() {
        return this._effectItem;
      }, function(val) {
        var oldVal;
        if (val != null) {
          assert.instanceOf(val, Renderer.Item);
        }
        oldVal = this._effectItem;
        this._effectItem = val;
        return Impl.setGridEffectItem.call(this, val, oldVal);
      });

      Renderer.Item.Margin(Grid, {
        propertyName: 'padding'
      });

      itemUtils.defineProperty({
        constructor: Grid,
        name: 'columns',
        defaultValue: 2,
        implementation: Impl.setGridColumns,
        developmentSetter: function(val) {
          return assert.operator(val, '>=', 0);
        },
        setter: function(_super) {
          return function(val) {
            if (val <= 0) {
              val = 1;
            }
            return _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Grid,
        name: 'rows',
        defaultValue: Infinity,
        implementation: Impl.setGridRows,
        developmentSetter: function(val) {
          return assert.operator(val, '>=', 0);
        },
        setter: function(_super) {
          return function(val) {
            if (val <= 0) {
              val = 1;
            }
            return _super.call(this, val);
          };
        }
      });

      Renderer.Item.Spacing(Grid);

      Renderer.Item.Alignment(Grid);

      itemUtils.defineProperty({
        constructor: Grid,
        name: 'includeBorderMargins',
        defaultValue: false,
        implementation: Impl.setGridIncludeBorderMargins,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      return Grid;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/layout/column.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/layout/column.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Column;
    return Column = (function(_super) {
      __extends(Column, _super);

      Column.__name__ = 'Column';

      Column.__path__ = 'Renderer.Column';

      function Column(component, opts) {
        this._padding = null;
        this._spacing = 0;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
        Column.__super__.constructor.call(this, component, opts);
        this.effectItem = this;
      }

      utils.defineProperty(Column.prototype, 'effectItem', null, function() {
        return this._effectItem;
      }, function(val) {
        var oldVal;
        if (val != null) {
          assert.instanceOf(val, Renderer.Item);
        }
        oldVal = this._effectItem;
        this._effectItem = val;
        return Impl.setColumnEffectItem.call(this, val, oldVal);
      });

      Renderer.Item.Margin(Column, {
        propertyName: 'padding'
      });

      itemUtils.defineProperty({
        constructor: Column,
        name: 'spacing',
        defaultValue: 0,
        implementation: Impl.setColumnSpacing,
        setter: function(_super) {
          return function(val) {
            if (utils.isObject(val)) {
              val = 0;
            }
            assert.isFloat(val);
            return _super.call(this, val);
          };
        }
      });

      Renderer.Item.Alignment(Column);

      itemUtils.defineProperty({
        constructor: Column,
        name: 'includeBorderMargins',
        defaultValue: false,
        implementation: Impl.setColumnIncludeBorderMargins,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      return Column;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/layout/row.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/layout/row.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Row;
    return Row = (function(_super) {
      __extends(Row, _super);

      Row.__name__ = 'Row';

      Row.__path__ = 'Renderer.Row';

      function Row(component, opts) {
        this._padding = null;
        this._spacing = 0;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
        Row.__super__.constructor.call(this, component, opts);
        this.effectItem = this;
      }

      utils.defineProperty(Row.prototype, 'effectItem', null, function() {
        return this._effectItem;
      }, function(val) {
        var oldVal;
        if (val != null) {
          assert.instanceOf(val, Renderer.Item);
        }
        oldVal = this._effectItem;
        this._effectItem = val;
        return Impl.setRowEffectItem.call(this, val, oldVal);
      });

      Renderer.Item.Margin(Row, {
        propertyName: 'padding'
      });

      itemUtils.defineProperty({
        constructor: Row,
        name: 'spacing',
        defaultValue: 0,
        implementation: Impl.setRowSpacing,
        setter: function(_super) {
          return function(val) {
            if (utils.isObject(val)) {
              val = 0;
            }
            assert.isFloat(val);
            return _super.call(this, val);
          };
        }
      });

      Renderer.Item.Alignment(Row);

      itemUtils.defineProperty({
        constructor: Row,
        name: 'includeBorderMargins',
        defaultValue: false,
        implementation: Impl.setRowIncludeBorderMargins,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      return Row;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/layout/flow.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/layout/flow.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Flow;
    return Flow = (function(_super) {
      __extends(Flow, _super);

      Flow.__name__ = 'Flow';

      Flow.__path__ = 'Renderer.Flow';

      function Flow(component, opts) {
        this._padding = null;
        this._spacing = null;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._collapseMargins = false;
        this._effectItem = null;
        Flow.__super__.constructor.call(this, component, opts);
        this.effectItem = this;
      }

      utils.defineProperty(Flow.prototype, 'effectItem', null, function() {
        return this._effectItem;
      }, function(val) {
        var oldVal;
        if (val != null) {
          assert.instanceOf(val, Renderer.Item);
        }
        oldVal = this._effectItem;
        this._effectItem = val;
        return Impl.setFlowEffectItem.call(this, val, oldVal);
      });

      Renderer.Item.Margin(Flow, {
        propertyName: 'padding'
      });

      Renderer.Item.Spacing(Flow);

      Renderer.Item.Alignment(Flow);

      itemUtils.defineProperty({
        constructor: Flow,
        name: 'includeBorderMargins',
        defaultValue: false,
        implementation: Impl.setFlowIncludeBorderMargins,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Flow,
        name: 'collapseMargins',
        defaultValue: false,
        implementation: Impl.setFlowCollapseMargins,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      return Flow;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/layout/scrollable.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/layout/scrollable.coffee.md"]};
var require = getModule.bind(null, {"expect":"node_modules/expect/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var expect, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  expect = require('expect');

  utils = require('utils');

  signal = require('signal');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Scrollable;
    return Scrollable = (function(_super) {
      __extends(Scrollable, _super);

      Scrollable.__name__ = 'Scrollable';

      Scrollable.__path__ = 'Renderer.Scrollable';

      function Scrollable(component, opts) {
        this._contentItem = null;
        this._contentX = 0;
        this._contentY = 0;
        this._snap = false;
        this._snapItem = null;
        Scrollable.__super__.constructor.call(this, component, opts);
        this.clip = true;
      }

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'contentItem',
        defaultValue: null,
        implementation: Impl.setScrollableContentItem,
        setter: function(_super) {
          return function(val) {
            var _ref;
            if ((_ref = this._contentItem) != null) {
              _ref._parent = null;
            }
            if (val != null) {
              expect(val).toBe.any(Renderer.Item);
              val._parent = this;
            }
            return _super.call(this, val);
          };
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'contentX',
        defaultValue: 0,
        implementation: Impl.setScrollableContentX,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'contentY',
        defaultValue: 0,
        implementation: Impl.setScrollableContentY,
        developmentSetter: function(val) {
          return expect(val).toBe.float();
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'snap',
        defaultValue: false,
        implementation: Impl.setScrollableSnap,
        developmentSetter: function(val) {
          return expect(val).toBe.boolean();
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'snapItem',
        defaultValue: null,
        implementation: Impl.setScrollableSnapItem,
        developmentSetter: function(val) {
          if (val == null) {
            val = null;
          }
          if (val != null) {
            return expect(val).toBe.any(Renderer.Item);
          }
        }
      });

      return Scrollable;

    })(Renderer.Item);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/sound/ambient.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/sound/ambient.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","list":"../list/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, SignalsEmitter, assert, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  utils = require('utils');

  signal = require('signal');

  List = require('list');

  isArray = Array.isArray;

  SignalsEmitter = signal.Emitter;

  assert = assert.scope('Renderer.AmbientSound');

  module.exports = function(Renderer, Impl, itemUtils) {
    var AmbientSound;
    return AmbientSound = (function(_super) {
      var setRunningOnReady;

      __extends(AmbientSound, _super);

      AmbientSound.__name__ = 'AmbientSound';

      AmbientSound.__path__ = 'Renderer.AmbientSound';

      function AmbientSound(component, opts) {
        this._impl = null;
        this._when = false;
        this._running = false;
        this._source = '';
        this._loop = false;
        AmbientSound.__super__.constructor.call(this, component, opts);
        Impl.createObject(this, this.constructor.__name__);
      }

      signal.Emitter.createSignal(AmbientSound, 'onStart');

      signal.Emitter.createSignal(AmbientSound, 'onStop');

      setRunningOnReady = function() {
        return this.running = this._when;
      };

      itemUtils.defineProperty({
        constructor: AmbientSound,
        name: 'running',
        setter: function(_super) {
          return function(val) {
            var oldVal;
            this._when = val;
            if (!this._isReady) {
              this.onReady(setRunningOnReady);
              return;
            }
            oldVal = this._running;
            if (oldVal === val) {
              return;
            }
            assert.isBoolean(val);
            _super.call(this, val);
            if (val) {
              Impl.startAmbientSound.call(this);
              this.onStart.emit();
            } else {
              Impl.stopAmbientSound.call(this);
              this.onStop.emit();
            }
          };
        }
      });

      itemUtils.defineProperty({
        constructor: AmbientSound,
        name: 'source',
        implementation: Impl.setAmbientSoundSource,
        developmentSetter: function(val) {
          return assert.isString(val, '::source setter ...');
        }
      });

      itemUtils.defineProperty({
        constructor: AmbientSound,
        name: 'loop',
        implementation: Impl.setAmbientSoundLoop,
        developmentSetter: function(val) {
          return assert.isBoolean(val, '::loop setter ...');
        }
      });

      AmbientSound.prototype.start = function() {
        this.running = true;
        return this;
      };

      AmbientSound.prototype.stop = function() {
        this.running = false;
        return this;
      };

      return AmbientSound;

    })(itemUtils.Object);
  };

}).call(this);


return module.exports;
})();modules['../resources/resource.coffee.md'] = (function(){
var module = {exports: modules["../resources/resource.coffee.md"]};
var require = getModule.bind(null, {"log":"../log/index.coffee.md","utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  log = require('log');

  utils = require('utils');

  assert = require('neft-assert');

  log = log.scope('Resources', 'Resource');

  module.exports = function(Resources) {
    var Resource;
    return Resource = (function() {
      Resource.__name__ = 'Resource';

      Resource.__path__ = 'Resources.Resource';

      Resource.FILE_NAME = /^(.*?)(?:@([0-9p]+)x)?(?:\.([a-zA-Z0-9]+))?(?:\#([a-zA-Z0-9]+))?$/;

      Resource.fromJSON = function(json) {
        var prop, res, val;
        if (typeof json === 'string') {
          json = JSON.parse(json);
        }
        assert.isObject(json);
        res = new Resources[json.__name__];
        for (prop in json) {
          val = json[prop];
          if (prop === '__name__') {
            continue;
          }
          res[prop] = val;
        }
        return res;
      };

      Resource.parseFileName = function(name) {
        var match;
        if (name && (match = Resource.FILE_NAME.exec(name))) {
          return {
            file: match[1],
            resolution: match[2] != null ? parseFloat(match[2].replace('p', '.')) : void 0,
            format: match[3],
            property: match[4]
          };
        }
      };

      function Resource() {
        assert.instanceOf(this, Resource);
        this.file = '';
        this.color = '';
        this.width = 0;
        this.height = 0;
        this.formats = null;
        this.resolutions = null;
        this.paths = null;
      }

      Resource.prototype.resolve = function(uri, req) {
        var diff, file, format, formats, name, property, r, rResolution, resolution, thisDiff, val, _i, _j, _len, _len1, _ref, _ref1;
        if (uri == null) {
          uri = '';
        }
        if (req === void 0 && utils.isPlainObject(uri)) {
          req = uri;
          uri = '';
        }
        if (uri === '') {
          file = this.file;
        } else {
          name = Resource.parseFileName(uri);
          file = name.file;
          resolution = name.resolution;
          if (name.format) {
            formats = [name.format];
          }
          property = name.property;
        }
        assert.isString(uri);
        if (req != null) {
          assert.isPlainObject(req);
        }
        if (resolution == null) {
          resolution = (req != null ? req.resolution : void 0) || 1;
        }
        if (formats == null) {
          formats = (req != null ? req.formats : void 0) || this.formats;
        }
        property || (property = (req != null ? req.property : void 0) || 'file');
        if (property !== 'file') {
          return this[property];
        }
        if (utils.isPlainObject(req)) {
          if (req.width > req.height) {
            req.resolution *= req.width / this.width;
          } else if (req.width < req.height) {
            req.resolution *= req.height / this.height;
          }
        }
        diff = Infinity;
        rResolution = 0;
        _ref = this.resolutions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          val = _ref[_i];
          thisDiff = Math.abs(resolution - val);
          if (thisDiff < diff || (thisDiff === diff && val > rResolution)) {
            diff = thisDiff;
            rResolution = val;
          }
        }
        for (_j = 0, _len1 = formats.length; _j < _len1; _j++) {
          format = formats[_j];
          if (r = (_ref1 = this.paths[format]) != null ? _ref1[rResolution] : void 0) {
            return r;
          }
        }
      };

      Resource.prototype.toJSON = function() {
        return utils.merge({
          __name__: this.constructor.__name__
        }, this);
      };

      return Resource;

    })();
  };

}).call(this);


return module.exports;
})();modules['../resources/index.coffee.md'] = (function(){
var module = {exports: modules["../resources/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","./resource":"../resources/resource.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Resources, assert, log, utils;

  utils = require('utils');

  log = require('log');

  assert = require('neft-assert');

  log = log.scope('Resources');

  module.exports = Resources = (function() {
    Resources.__name__ = 'Resources';

    Resources.Resources = Resources;

    Resources.Resource = require('./resource')(Resources);

    Resources.URI = /^(?:rsc|resource|resources)?:\/?\/?(.*?)(?:@([0-9p]+)x)?(?:\.[a-zA-Z]+)?(?:\#[a-zA-Z0-9]+)?$/;

    Resources.fromJSON = function(json) {
      var prop, resources, val;
      if (typeof json === 'string') {
        json = JSON.parse(json);
      }
      assert.isObject(json);
      resources = new Resources;
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

    Resources.testUri = function(uri) {
      assert.isString(uri);
      return Resources.URI.test(uri);
    };

    function Resources() {}

    Resources.prototype.getResource = function(uri) {
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
            r = r.getResource(rest);
          }
          return r;
        }
        chunk = chunk.slice(0, chunk.lastIndexOf('/'));
      }
    };

    Resources.prototype.resolve = function(uri, req) {
      var key, name, path, rsc, val;
      rsc = this.getResource(uri);
      if (rsc instanceof Resources.Resource) {
        name = Resources.Resource.parseFileName(uri);
        name.file = '';
        if (req != null) {
          for (key in req) {
            val = req[key];
            if (!name[key]) {
              name[key] = val;
            }
          }
        }
        path = rsc.resolve('', name);
      }
      return path && this.resolve(path) || path;
    };

    Resources.prototype.toJSON = function() {
      return utils.merge({
        __name__: this.constructor.__name__
      }, this);
    };

    return Resources;

  })();

}).call(this);


return module.exports;
})();modules['../renderer/types/loader/resources.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/loader/resources.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","resources":"../resources/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Resources, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  log = require('log');

  signal = require('signal');

  Resources = require('resources');

  log = log.scope('Renderer', 'ResourcesLoader');

  module.exports = function(Renderer, Impl, itemUtils) {
    var ResourcesLoader;
    return ResourcesLoader = (function(_super) {
      var getResources;

      __extends(ResourcesLoader, _super);

      ResourcesLoader.__name__ = 'ResourcesLoader';

      ResourcesLoader.__path__ = 'Renderer.ResourcesLoader';

      getResources = function(resources, target) {
        var key, val;
        if (target == null) {
          target = [];
        }
        for (key in resources) {
          val = resources[key];
          if (resources.hasOwnProperty(key)) {
            if (val instanceof Resources.Resource) {
              target.push(val);
            } else {
              getResources(val, target);
            }
          }
        }
        return target;
      };

      function ResourcesLoader(component, opts) {
        this._resources = Renderer.resources;
        this._progress = 0;
        ResourcesLoader.__super__.constructor.call(this, component, opts);
        setImmediate((function(_this) {
          return function() {
            if (_this._resources) {
              _this.progress = 0;
              return Impl.loadResources.call(_this, getResources(_this._resources));
            }
          };
        })(this));
      }

      utils.defineProperty(ResourcesLoader.prototype, 'resources', null, function() {
        return this._resources;
      }, function(val) {
        if (typeof val === 'string') {
          val = Renderer.resources.getResource(val);
        }
        assert.instanceOf(val, Resources);
        return this._resources = val;
      });

      itemUtils.defineProperty({
        constructor: ResourcesLoader,
        name: 'progress',
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      return ResourcesLoader;

    })(itemUtils.FixedObject);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/loader/font.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/loader/font.coffee.md"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  log = require('log');

  signal = require('signal');

  log = log.scope('Renderer', 'FontLoader');

  module.exports = function(Renderer, Impl, itemUtils) {
    var FontLoader;
    return FontLoader = (function(_super) {
      var SOURCE_FILE, loadFont;

      __extends(FontLoader, _super);

      FontLoader.__name__ = 'FontLoader';

      FontLoader.__path__ = 'Renderer.FontLoader';

      SOURCE_FILE = /(\w+)\.(\w+)$/;

      loadFont = function(self) {
        var path;
        if (!self.name) {
          path = SOURCE_FILE.exec(self.source);
          if (path) {
            self.name = path[1];
          }
        }
        Impl.loadFont(self.source, self.name);
      };

      FontLoader.fonts = {};

      function FontLoader(component, opts) {
        this._name = '';
        this._source = '';
        FontLoader.__super__.constructor.call(this, component, opts);
      }

      utils.defineProperty(FontLoader.prototype, 'name', null, function() {
        return this._name;
      }, function(val) {
        assert.isString(val);
        return this._name = val.toLowerCase();
      });

      utils.defineProperty(FontLoader.prototype, 'source', null, function() {
        return this._source;
      }, function(val) {
        assert.isString(val);
        assert.notLengthOf(val, 0);
        this._source = val;
        setImmediate((function(_this) {
          return function() {
            loadFont(_this);
            return FontLoader.fonts[_this.name] = _this;
          };
        })(this));
      });

      return FontLoader;

    })(itemUtils.FixedObject);
  };

}).call(this);


return module.exports;
})();modules['../renderer/index.coffee.md'] = (function(){
var module = {exports: modules["../renderer/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","./impl":"../renderer/impl.coffee","./utils/item":"../renderer/utils/item.coffee","./types/namespace/screen":"../renderer/types/namespace/screen.coffee.md","./types/namespace/device":"../renderer/types/namespace/device.coffee.md","./types/namespace/navigator":"../renderer/types/namespace/navigator.coffee.md","./types/namespace/sensor/rotation":"../renderer/types/namespace/sensor/rotation.coffee.md","./types/extension":"../renderer/types/extension.coffee","./types/extensions/class":"../renderer/types/extensions/class.coffee.md","./types/extensions/animation":"../renderer/types/extensions/animation.coffee.md","./types/extensions/animation/types/property":"../renderer/types/extensions/animation/types/property.coffee.md","./types/extensions/animation/types/property/types/number":"../renderer/types/extensions/animation/types/property/types/number.coffee.md","./types/extensions/transition":"../renderer/types/extensions/transition.coffee.md","./types/basics/component":"../renderer/types/basics/component.coffee","./types/basics/item":"../renderer/types/basics/item.coffee.md","./types/basics/item/types/image":"../renderer/types/basics/item/types/image.coffee.md","./types/basics/item/types/text":"../renderer/types/basics/item/types/text.coffee.md","./types/basics/item/types/textInput":"../renderer/types/basics/item/types/textInput.coffee.md","./types/shapes/rectangle":"../renderer/types/shapes/rectangle.coffee.md","./types/layout/grid":"../renderer/types/layout/grid.coffee.md","./types/layout/column":"../renderer/types/layout/column.coffee.md","./types/layout/row":"../renderer/types/layout/row.coffee.md","./types/layout/flow":"../renderer/types/layout/flow.coffee.md","./types/layout/scrollable":"../renderer/types/layout/scrollable.coffee.md","./types/sound/ambient":"../renderer/types/sound/ambient.coffee.md","./types/loader/resources":"../renderer/types/loader/resources.coffee.md","./types/loader/font":"../renderer/types/loader/font.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Impl, itemUtils, signal, utils;

  utils = require('utils');

  signal = require('signal');

  signal.create(exports, 'onReady');

  Impl = require('./impl')(exports);

  itemUtils = exports.itemUtils = require('./utils/item')(exports, Impl);

  exports.Screen = require('./types/namespace/screen')(exports, Impl, itemUtils);

  exports.Device = require('./types/namespace/device')(exports, Impl, itemUtils);

  exports.Navigator = require('./types/namespace/navigator')(exports, Impl, itemUtils);

  exports.RotationSensor = require('./types/namespace/sensor/rotation')(exports, Impl, itemUtils);

  exports.Extension = require('./types/extension')(exports, Impl, itemUtils);

  exports.Class = require('./types/extensions/class')(exports, Impl, itemUtils);

  exports.Animation = require('./types/extensions/animation')(exports, Impl, itemUtils);

  exports.PropertyAnimation = require('./types/extensions/animation/types/property')(exports, Impl, itemUtils);

  exports.NumberAnimation = require('./types/extensions/animation/types/property/types/number')(exports, Impl, itemUtils);

  exports.Transition = require('./types/extensions/transition')(exports, Impl, itemUtils);

  exports.Component = require('./types/basics/component')(exports, Impl, itemUtils);

  exports.Item = require('./types/basics/item')(exports, Impl, itemUtils);

  exports.Image = require('./types/basics/item/types/image')(exports, Impl, itemUtils);

  exports.Text = require('./types/basics/item/types/text')(exports, Impl, itemUtils);

  exports.TextInput = require('./types/basics/item/types/textInput')(exports, Impl, itemUtils);

  exports.Rectangle = require('./types/shapes/rectangle')(exports, Impl, itemUtils);

  exports.Grid = require('./types/layout/grid')(exports, Impl, itemUtils);

  exports.Column = require('./types/layout/column')(exports, Impl, itemUtils);

  exports.Row = require('./types/layout/row')(exports, Impl, itemUtils);

  exports.Flow = require('./types/layout/flow')(exports, Impl, itemUtils);

  exports.Scrollable = require('./types/layout/scrollable')(exports, Impl, itemUtils);

  exports.AmbientSound = require('./types/sound/ambient')(exports, Impl, itemUtils);

  exports.ResourcesLoader = require('./types/loader/resources')(exports, Impl, itemUtils);

  exports.FontLoader = require('./types/loader/font')(exports, Impl, itemUtils);

  utils.defineProperty(exports, 'window', utils.CONFIGURABLE, null, function(val) {
    utils.defineProperty(exports, 'window', utils.ENUMERABLE, val);
    return Impl.setWindow(val);
  });

  utils.defineProperty(exports, 'documentGlobalNode', utils.CONFIGURABLE, null, function(val) {
    return utils.defineProperty(exports, 'documentGlobalNode', utils.ENUMERABLE, val);
  });

  utils.defineProperty(exports, 'serverUrl', utils.WRITABLE, '');

  utils.defineProperty(exports, 'resources', utils.WRITABLE, null);

  exports.onReady.emit();

  Object.preventExtensions(exports);

}).call(this);


return module.exports;
})();modules['../document/element/element/tag.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element/tag.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md","./tag/stringify":"../document/element/element/tag/stringify.coffee","typed-array":"../typed-array/index.coffee","renderer":"../renderer/index.coffee.md","./tag/attrs":"../document/element/element/tag/attrs.coffee.md","./tag/query":"../document/element/element/tag/query.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var CSS_ID_RE, Renderer, TypedArray, assert, emitSignal, isDefined, signal, stringify, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  stringify = require('./tag/stringify');

  TypedArray = require('typed-array');

  Renderer = require('renderer');

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('View.Element.Tag');

  isDefined = function(elem) {
    return elem != null;
  };

  CSS_ID_RE = /\#([^\s]+)/;

  module.exports = function(Element) {
    var Tag;
    return Tag = (function(_super) {
      var opts, query;

      __extends(Tag, _super);

      Tag.INTERNAL_TAGS = ['neft:attr', 'neft:fragment', 'neft:function', 'neft:rule', 'neft:target', 'neft:use', 'neft:require', 'neft:blank', 'neft:log'];

      Tag.Attrs = require('./tag/attrs')(Tag);

      Tag.extensions = Object.create(null);

      Tag.__name__ = 'Tag';

      Tag.__path__ = 'File.Element.Tag';

      function Tag() {
        this.children = [];
        this.name = 'neft:blank';
        this._style = null;
        this._documentStyle = null;
        this._visible = true;
        this._attrs = {};
        this._watchers = null;
        this._inWatchers = null;
        Tag.__super__.constructor.call(this);
      }

      signal.Emitter.createSignal(Tag, 'onChildrenChange');

      opts = utils.CONFIGURABLE;

      utils.defineProperty(Tag.prototype, 'style', opts, function() {
        return this._style;
      }, function(val) {
        var old;
        if (val != null) {
          assert.instanceOf(val, Renderer.Item);
        }
        old = this._style;
        if (old === val) {
          return false;
        }
        this._style = val;
        emitSignal(this, 'onStyleChange', old, val);
        return true;
      });

      signal.Emitter.createSignal(Tag, 'onStyleChange');

      opts = utils.CONFIGURABLE;

      utils.defineProperty(Tag.prototype, 'visible', opts, function() {
        return this._visible;
      }, function(val) {
        var old;
        assert.isBoolean(val);
        old = this._visible;
        if (old === val) {
          return false;
        }
        this._visible = val;
        emitSignal(this, 'onVisibleChange', old);
        return true;
      });

      signal.Emitter.createSignal(Tag, 'onVisibleChange');

      utils.defineProperty(Tag.prototype, 'attrs', null, function() {
        Tag.Attrs.tag = this;
        return Tag.Attrs;
      }, null);

      signal.Emitter.createSignal(Tag, 'onAttrsChange');

      Tag.prototype.clone = function() {
        var clone;
        clone = Tag.__super__.clone.call(this);
        clone.name = this.name;
        clone._visible = this._visible;
        clone._attrs = utils.cloneDeep(this._attrs);
        return clone;
      };

      Tag.prototype.cloneDeep = function() {
        var child, clone, clonedChild, prevClonedChild, _i, _len, _ref;
        clone = this.clone();
        prevClonedChild = null;
        _ref = this.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          clonedChild = child.cloneDeep();
          clone.children.push(clonedChild);
          clonedChild._parent = clone;
          if (clonedChild._previousSibling = prevClonedChild) {
            prevClonedChild._nextSibling = clonedChild;
          }
          prevClonedChild = clonedChild;
        }
        return clone;
      };

      Tag.prototype.getCopiedElement = (function() {
        var arr;
        arr = new TypedArray.Uint16(256);
        return function(lookForElement, copiedParent) {
          var elem, i, index, parent;
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
      })();

      Tag.query = query = require('./tag/query')(Tag);

      Tag.prototype.queryAll = query.queryAll;

      Tag.prototype.query = query.query;

      Tag.prototype.queryAllParents = query.queryAllParents;

      Tag.prototype.queryParents = query.queryParents;

      Tag.prototype.watch = query.watch;

      Tag.prototype.stringify = function() {
        return stringify.getOuterHTML(this);
      };

      Tag.prototype.stringifyChildren = function() {
        return stringify.getInnerHTML(this);
      };

      Tag.prototype.replace = function(oldElement, newElement) {
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

      return Tag;

    })(Element);
  };

}).call(this);


return module.exports;
})();modules['../document/element/element/tag/attrs.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element/tag/attrs.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, emitSignal, isArray, log, signal, utils;

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  assert = require('neft-assert');

  assert = assert.scope('View.Element.Tag.Attrs');

  log = log.scope('View.Element.Tag.Attrs');

  isArray = Array.isArray;

  emitSignal = signal.Emitter.emitSignal;

  module.exports = function(Tag) {
    var exports;
    return exports = {
      tag: null,
      item: function(index, target) {
        var i, key, val, _ref;
        if (target == null) {
          target = [];
        }
        assert.isArray(target);
        target[0] = target[1] = void 0;
        i = 0;
        _ref = exports.tag._attrs;
        for (key in _ref) {
          val = _ref[key];
          if (i === index) {
            target[0] = key;
            target[1] = val;
            break;
          }
          i++;
        }
        return target;
      },
      has: function(name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        return exports.tag._attrs.hasOwnProperty(name);
      },
      get: function(name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        return exports.tag._attrs[name];
      },
      set: function(name, value) {
        var old, tag;
        assert.isString(name);
        assert.notLengthOf(name, 0);
        tag = exports.tag;
        old = tag._attrs[name];
        if (old === value) {
          return false;
        }
        tag._attrs[name] = value;
        emitSignal(tag, 'onAttrsChange', name, old);
        Tag.query.checkWatchersDeeply(tag);
        return true;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/element/element/tag/query.coffee'] = (function(){
var module = {exports: modules["../document/element/element/tag/query.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var ATTR_CLASS_SEARCH, ATTR_SEARCH, ATTR_VALUE_SEARCH, CONTAINS, DEEP, ENDS_WITH, OPTS_ADD_ANCHOR, OPTS_QUERY_BY_PARENTS, OPTS_REVERSED, STARTS_WITH, TRIM_ATTR_VALUE, TYPE, Watcher, anyChild, anyDescendant, anyParent, assert, byAttr, byAttrContainsValue, byAttrEndsWithValue, byAttrStartsWithValue, byAttrValue, byName, byTag, directParent, emitSignal, getQueries, i, queriesCache, signal, test, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('neft-assert');

  emitSignal = signal.Emitter.emitSignal;

  test = function(node, funcs, index, targetFunc, targetCtx, single) {
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

  anyDescendant = function(node, funcs, index, targetFunc, targetCtx, single) {
    var child, children, _i, _len;
    if (children = node.children) {
      for (_i = 0, _len = children.length; _i < _len; _i++) {
        child = children[_i];
        if (child.name !== 'neft:blank' && test(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
        if (child.children) {
          if (anyDescendant(child, funcs, index, targetFunc, targetCtx, single)) {
            if (single) {
              return true;
            }
          }
        }
      }
    }
    return false;
  };

  anyDescendant.isIterator = true;

  anyDescendant.toString = function() {
    return 'anyDescendant';
  };

  directParent = function(node, funcs, index, targetFunc, targetCtx, single) {
    var parent;
    if (parent = node._parent) {
      if (test(parent, funcs, index, targetFunc, targetCtx, single)) {
        return true;
      }
      if (parent.name === 'neft:blank') {
        return directParent(parent, funcs, index, targetFunc, targetCtx, single);
      }
    }
    return false;
  };

  directParent.isIterator = true;

  directParent.toString = function() {
    return 'directParent';
  };

  anyChild = function(node, funcs, index, targetFunc, targetCtx, single) {
    var child, children, _i, _len;
    if (children = node.children) {
      for (_i = 0, _len = children.length; _i < _len; _i++) {
        child = children[_i];
        if (child.name === 'neft:blank') {
          if (anyChild(child, funcs, index, targetFunc, targetCtx, single)) {
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
    }
    return false;
  };

  anyChild.isIterator = true;

  anyChild.toString = function() {
    return 'anyChild';
  };

  anyParent = function(node, funcs, index, targetFunc, targetCtx, single) {
    var parent;
    if (parent = node._parent) {
      if (test(parent, funcs, index, targetFunc, targetCtx, single)) {
        return true;
      } else {
        return anyParent(parent, funcs, index, targetFunc, targetCtx, single);
      }
    }
    return false;
  };

  anyParent.isIterator = true;

  anyParent.toString = function() {
    return 'anyParent';
  };

  byName = function(node, data1) {
    return node.name === data1;
  };

  byName.isIterator = false;

  byName.toString = function() {
    return 'byName';
  };

  byTag = function(node, data1) {
    return node === data1;
  };

  byTag.isIterator = false;

  byTag.toString = function() {
    return 'byTag';
  };

  byAttr = function(node, data1) {
    var _ref;
    return ((_ref = node._attrs) != null ? _ref[data1] : void 0) != null;
  };

  byAttr.isIterator = false;

  byAttr.toString = function() {
    return 'byAttr';
  };

  byAttrValue = function(node, data1, data2) {
    var attrs, val;
    if (attrs = node._attrs) {
      val = attrs[data1];
      if (typeof val === typeof data2) {
        return val === data2;
      } else {
        return val + '' === data2 + '';
      }
    } else {
      return false;
    }
  };

  byAttrValue.isIterator = false;

  byAttrValue.toString = function() {
    return 'byAttrValue';
  };

  byAttrStartsWithValue = function(node, data1, data2) {
    var _ref, _ref1;
    return ((_ref = node._attrs) != null ? (_ref1 = _ref[data1]) != null ? typeof _ref1.indexOf === "function" ? _ref1.indexOf(data2) : void 0 : void 0 : void 0) === 0;
  };

  byAttrStartsWithValue.isIterator = false;

  byAttrStartsWithValue.toString = function() {
    return 'byAttrStartsWithValue';
  };

  byAttrEndsWithValue = function(node, data1, data2) {
    var val, _ref;
    val = (_ref = node._attrs) != null ? _ref[data1] : void 0;
    if (typeof val === 'string') {
      return val.indexOf(data2, val.length - data2.length) !== -1;
    } else {
      return false;
    }
  };

  byAttrEndsWithValue.isIterator = false;

  byAttrEndsWithValue.toString = function() {
    return 'byAttrEndsWithValue';
  };

  byAttrContainsValue = function(node, data1, data2) {
    var _ref, _ref1;
    return ((_ref = node._attrs) != null ? (_ref1 = _ref[data1]) != null ? typeof _ref1.indexOf === "function" ? _ref1.indexOf(data2) : void 0 : void 0 : void 0) > -1;
  };

  byAttrContainsValue.isIterator = false;

  byAttrContainsValue.toString = function() {
    return 'byAttrContainsValue';
  };

  TYPE = /^[a-zA-Z0-9|\-:_]+/;

  DEEP = /^([ ]*)>([ ]*)|^([ ]+)/;

  ATTR_SEARCH = /^\[([^\]]+?)\]/;

  ATTR_VALUE_SEARCH = /^\[([^=]+?)=([^\]]+?)\]/;

  ATTR_CLASS_SEARCH = /^\.([a-zA-Z0-9|\-_]+)/;

  STARTS_WITH = /\^$/;

  ENDS_WITH = /\$$/;

  CONTAINS = /\*$/;

  TRIM_ATTR_VALUE = /(?:'|")?([^'"]*)/;

  i = 0;

  OPTS_QUERY_BY_PARENTS = 1 << (i++);

  OPTS_REVERSED = 1 << (i++);

  OPTS_ADD_ANCHOR = 1 << (i++);

  queriesCache = [];

  getQueries = function(selector, opts) {
    var arrFunc, closeTagFunc, deep, distantTagFunc, exec, firstFunc, func, funcs, name, queries, r, reversed, reversedArrFunc, sel, val, _, _i, _len, _ref;
    if (opts == null) {
      opts = 0;
    }
    reversed = !!(opts & OPTS_REVERSED);
    if (r = (_ref = queriesCache[opts]) != null ? _ref[selector] : void 0) {
      return r;
    }
    distantTagFunc = reversed ? anyParent : anyDescendant;
    closeTagFunc = reversed ? directParent : anyChild;
    arrFunc = reversed ? 'unshift' : 'push';
    reversedArrFunc = reversed ? 'push' : 'unshift';
    funcs = [];
    queries = [funcs];
    sel = selector.trim();
    while (sel.length) {
      if (sel[0] === '*') {
        sel = sel.slice(1);
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
        val = TRIM_ATTR_VALUE.exec(val)[1];
        if (STARTS_WITH.test(name)) {
          func = byAttrStartsWithValue;
        } else if (ENDS_WITH.test(name)) {
          func = byAttrEndsWithValue;
        } else if (CONTAINS.test(name)) {
          func = byAttrContainsValue;
        } else {
          func = byAttrValue;
        }
        if (func !== byAttrValue) {
          name = name.slice(0, -1);
        }
        funcs[arrFunc](func, name, val);
      } else if (exec = ATTR_SEARCH.exec(sel)) {
        sel = sel.slice(exec[0].length);
        funcs[arrFunc](byAttr, exec[1], null);
      } else if (exec = ATTR_CLASS_SEARCH.exec(sel)) {
        sel = sel.slice(exec[0].length);
        funcs[arrFunc](byAttrContainsValue, 'class', exec[1]);
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
    for (_i = 0, _len = queries.length; _i < _len; _i++) {
      funcs = queries[_i];
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
    if (queriesCache[opts] == null) {
      queriesCache[opts] = {};
    }
    queriesCache[opts][selector] = queries;
    return queries;
  };

  Watcher = (function(_super) {
    var NOP, pool;

    __extends(Watcher, _super);

    NOP = function() {};

    pool = [];

    Watcher.create = function(node, queries) {
      var watcher;
      if (pool.length) {
        watcher = pool.pop();
        watcher.node = node;
        watcher.queries = queries;
      } else {
        watcher = new Watcher(node, queries);
      }
      if (node._watchers == null) {
        node._watchers = [];
      }
      node._watchers.push(watcher);
      return watcher;
    };

    function Watcher(node, queries) {
      this.node = node;
      this.queries = queries;
      Watcher.__super__.constructor.call(this);
      this.nodes = [];
      Object.preventExtensions(this);
    }

    signal.Emitter.createSignal(Watcher, 'onAdd');

    signal.Emitter.createSignal(Watcher, 'onRemove');

    Watcher.prototype.test = function(tag) {
      var funcs, _i, _len, _ref;
      _ref = this.queries;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        funcs = _ref[_i];
        funcs[funcs.length - 2] = this.node;
        if (test(tag, funcs, 0, NOP, null, true)) {
          return true;
        }
      }
      return false;
    };

    Watcher.prototype.disconnect = function() {
      var index, node, _i, _len, _ref;
      assert.ok(utils.has(this.node._watchers, this));
      _ref = this.nodes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        utils.removeFromUnorderedArray(node._inWatchers, this);
        emitSignal(this, 'onRemove', node);
      }
      utils.clear(this.nodes);
      this.onAdd.disconnectAll();
      this.onRemove.disconnectAll();
      index = this.node._watchers.indexOf(this);
      this.node._watchers[index] = null;
      this.node = this.queries = null;
      pool.push(this);
    };

    return Watcher;

  })(signal.Emitter);

  module.exports = function(Tag) {
    var checkWatchersDeeply, query, queryAll;
    return {
      getSelectorCommandsLength: function(selector) {
        var queries, query, sum, _i, _len;
        sum = 0;
        queries = getQueries(selector, 0);
        for (_i = 0, _len = queries.length; _i < _len; _i++) {
          query = queries[_i];
          sum += query.length;
        }
        return sum;
      },
      queryAll: queryAll = function(selector, target, targetCtx, opts) {
        var func, funcs, queries, _i, _len;
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
        for (_i = 0, _len = queries.length; _i < _len; _i++) {
          funcs = queries[_i];
          funcs[0](this, funcs, 3, func, targetCtx, false);
        }
        if (Array.isArray(target)) {
          return target;
        }
      },
      queryAllParents: function(selector, target, targetCtx) {
        return queryAll.call(this, selector, target, targetCtx, OPTS_REVERSED | OPTS_QUERY_BY_PARENTS);
      },
      query: query = (function() {
        var result, resultFunc;
        result = null;
        resultFunc = function(arg) {
          return result = arg;
        };
        return function(selector, opts) {
          var funcs, queries, _i, _len;
          if (opts == null) {
            opts = 0;
          }
          assert.isString(selector);
          assert.notLengthOf(selector, 0);
          queries = getQueries(selector, opts);
          for (_i = 0, _len = queries.length; _i < _len; _i++) {
            funcs = queries[_i];
            if (funcs[0](this, funcs, 3, resultFunc, null, true)) {
              return result;
            }
          }
          return null;
        };
      })(),
      queryParents: function(selector) {
        return query.call(this, selector, OPTS_REVERSED | OPTS_QUERY_BY_PARENTS);
      },
      watch: function(selector) {
        var queries, watcher;
        assert.isString(selector);
        assert.notLengthOf(selector, 0);
        queries = getQueries(selector, OPTS_REVERSED | OPTS_ADD_ANCHOR);
        watcher = Watcher.create(this, queries);
        checkWatchersDeeply(this);
        return watcher;
      },
      checkWatchersDeeply: checkWatchersDeeply = (function() {
        var isChildOf, pending, queue, queueIndex, queues, updateNodeRecursively, updateNodes;
        queueIndex = 0;
        queues = [[], []];
        queue = queues[queueIndex];
        pending = false;
        updateNodeRecursively = function(node) {
          var child, inWatchers, n, tmp, watcher, watchers, _i, _len, _ref;
          if (inWatchers = node._inWatchers) {
            i = n = inWatchers.length;
            while (i-- > 0) {
              if (!inWatchers[i].test(node)) {
                watcher = inWatchers[i];
                inWatchers[i] = inWatchers[n - 1];
                inWatchers.pop();
                utils.removeFromUnorderedArray(watcher.nodes, node);
                emitSignal(watcher, 'onRemove', node);
                n--;
              }
            }
          }
          tmp = node;
          while (tmp) {
            if (watchers = tmp._watchers) {
              i = 0;
              n = watchers.length;
              while (i < n) {
                watcher = watchers[i];
                if (watcher === null) {
                  watchers.splice(i, 1);
                  i--;
                  n--;
                } else if ((!node._inWatchers || !utils.has(node._inWatchers, watcher)) && watcher.test(node)) {
                  if (node._inWatchers == null) {
                    node._inWatchers = [];
                  }
                  node._inWatchers.push(watcher);
                  watcher.nodes.push(node);
                  emitSignal(watcher, 'onAdd', node);
                }
                i++;
              }
            }
            tmp = tmp._parent;
          }
          if (node.children) {
            _ref = node.children;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              if (child instanceof Tag) {
                checkWatchersDeeply(child);
              }
            }
          }
        };
        updateNodes = function() {
          var currentQueue, node;
          pending = false;
          currentQueue = queue;
          queue = queues[++queueIndex % queues.length];
          while (currentQueue.length) {
            node = currentQueue.pop();
            updateNodeRecursively(node);
          }
        };
        isChildOf = function(child, parent) {
          var tmp;
          tmp = child;
          while (tmp = tmp._parent) {
            if (tmp === parent) {
              return true;
            }
          }
          return false;
        };
        if (utils.isNode) {
          return updateNodeRecursively;
        } else {
          return function(node) {
            var n, waitingNode, _i, _len;
            if (utils.has(queue, node)) {
              return;
            }
            for (_i = 0, _len = queue.length; _i < _len; _i++) {
              waitingNode = queue[_i];
              if (isChildOf(node, waitingNode)) {
                return;
              }
            }
            i = 0;
            n = queue.length;
            while (i < n) {
              if (isChildOf(queue[i], node)) {
                utils.removeFromUnorderedArray(queue, i);
                n--;
              } else {
                i++;
              }
            }
            queue.push(node);
            if (!pending) {
              setImmediate(updateNodes);
              pending = true;
            }
          };
        }
      })()
    };
  };

}).call(this);


return module.exports;
})();modules['../document/element/element/text.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element/text.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, emitSignal, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('View.Element.Text');

  module.exports = function(Element) {
    var Text;
    return Text = (function(_super) {
      var opts;

      __extends(Text, _super);

      Text.__name__ = 'Text';

      Text.__path__ = 'File.Element.Text';

      function Text() {
        this._text = '';
        Text.__super__.constructor.call(this);
      }

      Text.prototype.clone = function() {
        var clone;
        clone = Text.__super__.clone.call(this);
        clone._text = this._text;
        return clone;
      };

      signal.Emitter.createSignal(Text, 'onTextChange');

      opts = utils.CONFIGURABLE;

      utils.defineProperty(Text.prototype, 'text', opts, function() {
        return this._text;
      }, function(value) {
        var old;
        assert.isString(value);
        old = this._text;
        if (old === value) {
          return false;
        }
        this._text = value;
        emitSignal(this, 'onTextChange', old);
        return true;
      });

      return Text;

    })(Element);
  };

}).call(this);


return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/entities/maps/decode.json'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/entities/maps/decode.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {"0":65533,"128":8364,"130":8218,"131":402,"132":8222,"133":8230,"134":8224,"135":8225,"136":710,"137":8240,"138":352,"139":8249,"140":338,"142":381,"145":8216,"146":8217,"147":8220,"148":8221,"149":8226,"150":8211,"151":8212,"152":732,"153":8482,"154":353,"155":8250,"156":339,"158":382,"159":376};

return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/entities/lib/decode_codepoint.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/entities/lib/decode_codepoint.js"]};
var require = getModule.bind(null, {"../maps/decode.json":"../document/node_modules/htmlparser2/node_modules/entities/maps/decode.json"});
var exports = module.exports;

var decodeMap = require("../maps/decode.json");

module.exports = decodeCodePoint;

// modified version of https://github.com/mathiasbynens/he/blob/master/src/he.js#L94-L119
function decodeCodePoint(codePoint){

	if((codePoint >= 0xD800 && codePoint <= 0xDFFF) || codePoint > 0x10FFFF){
		return "\uFFFD";
	}

	if(codePoint in decodeMap){
		codePoint = decodeMap[codePoint];
	}

	var output = "";

	if(codePoint > 0xFFFF){
		codePoint -= 0x10000;
		output += String.fromCharCode(codePoint >>> 10 & 0x3FF | 0xD800);
		codePoint = 0xDC00 | codePoint & 0x3FF;
	}

	output += String.fromCharCode(codePoint);
	return output;
}


return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/entities/maps/entities.json'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/entities/maps/entities.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {"Aacute":"\u00C1","aacute":"\u00E1","Abreve":"\u0102","abreve":"\u0103","ac":"\u223E","acd":"\u223F","acE":"\u223E\u0333","Acirc":"\u00C2","acirc":"\u00E2","acute":"\u00B4","Acy":"\u0410","acy":"\u0430","AElig":"\u00C6","aelig":"\u00E6","af":"\u2061","Afr":"\uD835\uDD04","afr":"\uD835\uDD1E","Agrave":"\u00C0","agrave":"\u00E0","alefsym":"\u2135","aleph":"\u2135","Alpha":"\u0391","alpha":"\u03B1","Amacr":"\u0100","amacr":"\u0101","amalg":"\u2A3F","amp":"&","AMP":"&","andand":"\u2A55","And":"\u2A53","and":"\u2227","andd":"\u2A5C","andslope":"\u2A58","andv":"\u2A5A","ang":"\u2220","ange":"\u29A4","angle":"\u2220","angmsdaa":"\u29A8","angmsdab":"\u29A9","angmsdac":"\u29AA","angmsdad":"\u29AB","angmsdae":"\u29AC","angmsdaf":"\u29AD","angmsdag":"\u29AE","angmsdah":"\u29AF","angmsd":"\u2221","angrt":"\u221F","angrtvb":"\u22BE","angrtvbd":"\u299D","angsph":"\u2222","angst":"\u00C5","angzarr":"\u237C","Aogon":"\u0104","aogon":"\u0105","Aopf":"\uD835\uDD38","aopf":"\uD835\uDD52","apacir":"\u2A6F","ap":"\u2248","apE":"\u2A70","ape":"\u224A","apid":"\u224B","apos":"'","ApplyFunction":"\u2061","approx":"\u2248","approxeq":"\u224A","Aring":"\u00C5","aring":"\u00E5","Ascr":"\uD835\uDC9C","ascr":"\uD835\uDCB6","Assign":"\u2254","ast":"*","asymp":"\u2248","asympeq":"\u224D","Atilde":"\u00C3","atilde":"\u00E3","Auml":"\u00C4","auml":"\u00E4","awconint":"\u2233","awint":"\u2A11","backcong":"\u224C","backepsilon":"\u03F6","backprime":"\u2035","backsim":"\u223D","backsimeq":"\u22CD","Backslash":"\u2216","Barv":"\u2AE7","barvee":"\u22BD","barwed":"\u2305","Barwed":"\u2306","barwedge":"\u2305","bbrk":"\u23B5","bbrktbrk":"\u23B6","bcong":"\u224C","Bcy":"\u0411","bcy":"\u0431","bdquo":"\u201E","becaus":"\u2235","because":"\u2235","Because":"\u2235","bemptyv":"\u29B0","bepsi":"\u03F6","bernou":"\u212C","Bernoullis":"\u212C","Beta":"\u0392","beta":"\u03B2","beth":"\u2136","between":"\u226C","Bfr":"\uD835\uDD05","bfr":"\uD835\uDD1F","bigcap":"\u22C2","bigcirc":"\u25EF","bigcup":"\u22C3","bigodot":"\u2A00","bigoplus":"\u2A01","bigotimes":"\u2A02","bigsqcup":"\u2A06","bigstar":"\u2605","bigtriangledown":"\u25BD","bigtriangleup":"\u25B3","biguplus":"\u2A04","bigvee":"\u22C1","bigwedge":"\u22C0","bkarow":"\u290D","blacklozenge":"\u29EB","blacksquare":"\u25AA","blacktriangle":"\u25B4","blacktriangledown":"\u25BE","blacktriangleleft":"\u25C2","blacktriangleright":"\u25B8","blank":"\u2423","blk12":"\u2592","blk14":"\u2591","blk34":"\u2593","block":"\u2588","bne":"=\u20E5","bnequiv":"\u2261\u20E5","bNot":"\u2AED","bnot":"\u2310","Bopf":"\uD835\uDD39","bopf":"\uD835\uDD53","bot":"\u22A5","bottom":"\u22A5","bowtie":"\u22C8","boxbox":"\u29C9","boxdl":"\u2510","boxdL":"\u2555","boxDl":"\u2556","boxDL":"\u2557","boxdr":"\u250C","boxdR":"\u2552","boxDr":"\u2553","boxDR":"\u2554","boxh":"\u2500","boxH":"\u2550","boxhd":"\u252C","boxHd":"\u2564","boxhD":"\u2565","boxHD":"\u2566","boxhu":"\u2534","boxHu":"\u2567","boxhU":"\u2568","boxHU":"\u2569","boxminus":"\u229F","boxplus":"\u229E","boxtimes":"\u22A0","boxul":"\u2518","boxuL":"\u255B","boxUl":"\u255C","boxUL":"\u255D","boxur":"\u2514","boxuR":"\u2558","boxUr":"\u2559","boxUR":"\u255A","boxv":"\u2502","boxV":"\u2551","boxvh":"\u253C","boxvH":"\u256A","boxVh":"\u256B","boxVH":"\u256C","boxvl":"\u2524","boxvL":"\u2561","boxVl":"\u2562","boxVL":"\u2563","boxvr":"\u251C","boxvR":"\u255E","boxVr":"\u255F","boxVR":"\u2560","bprime":"\u2035","breve":"\u02D8","Breve":"\u02D8","brvbar":"\u00A6","bscr":"\uD835\uDCB7","Bscr":"\u212C","bsemi":"\u204F","bsim":"\u223D","bsime":"\u22CD","bsolb":"\u29C5","bsol":"\\","bsolhsub":"\u27C8","bull":"\u2022","bullet":"\u2022","bump":"\u224E","bumpE":"\u2AAE","bumpe":"\u224F","Bumpeq":"\u224E","bumpeq":"\u224F","Cacute":"\u0106","cacute":"\u0107","capand":"\u2A44","capbrcup":"\u2A49","capcap":"\u2A4B","cap":"\u2229","Cap":"\u22D2","capcup":"\u2A47","capdot":"\u2A40","CapitalDifferentialD":"\u2145","caps":"\u2229\uFE00","caret":"\u2041","caron":"\u02C7","Cayleys":"\u212D","ccaps":"\u2A4D","Ccaron":"\u010C","ccaron":"\u010D","Ccedil":"\u00C7","ccedil":"\u00E7","Ccirc":"\u0108","ccirc":"\u0109","Cconint":"\u2230","ccups":"\u2A4C","ccupssm":"\u2A50","Cdot":"\u010A","cdot":"\u010B","cedil":"\u00B8","Cedilla":"\u00B8","cemptyv":"\u29B2","cent":"\u00A2","centerdot":"\u00B7","CenterDot":"\u00B7","cfr":"\uD835\uDD20","Cfr":"\u212D","CHcy":"\u0427","chcy":"\u0447","check":"\u2713","checkmark":"\u2713","Chi":"\u03A7","chi":"\u03C7","circ":"\u02C6","circeq":"\u2257","circlearrowleft":"\u21BA","circlearrowright":"\u21BB","circledast":"\u229B","circledcirc":"\u229A","circleddash":"\u229D","CircleDot":"\u2299","circledR":"\u00AE","circledS":"\u24C8","CircleMinus":"\u2296","CirclePlus":"\u2295","CircleTimes":"\u2297","cir":"\u25CB","cirE":"\u29C3","cire":"\u2257","cirfnint":"\u2A10","cirmid":"\u2AEF","cirscir":"\u29C2","ClockwiseContourIntegral":"\u2232","CloseCurlyDoubleQuote":"\u201D","CloseCurlyQuote":"\u2019","clubs":"\u2663","clubsuit":"\u2663","colon":":","Colon":"\u2237","Colone":"\u2A74","colone":"\u2254","coloneq":"\u2254","comma":",","commat":"@","comp":"\u2201","compfn":"\u2218","complement":"\u2201","complexes":"\u2102","cong":"\u2245","congdot":"\u2A6D","Congruent":"\u2261","conint":"\u222E","Conint":"\u222F","ContourIntegral":"\u222E","copf":"\uD835\uDD54","Copf":"\u2102","coprod":"\u2210","Coproduct":"\u2210","copy":"\u00A9","COPY":"\u00A9","copysr":"\u2117","CounterClockwiseContourIntegral":"\u2233","crarr":"\u21B5","cross":"\u2717","Cross":"\u2A2F","Cscr":"\uD835\uDC9E","cscr":"\uD835\uDCB8","csub":"\u2ACF","csube":"\u2AD1","csup":"\u2AD0","csupe":"\u2AD2","ctdot":"\u22EF","cudarrl":"\u2938","cudarrr":"\u2935","cuepr":"\u22DE","cuesc":"\u22DF","cularr":"\u21B6","cularrp":"\u293D","cupbrcap":"\u2A48","cupcap":"\u2A46","CupCap":"\u224D","cup":"\u222A","Cup":"\u22D3","cupcup":"\u2A4A","cupdot":"\u228D","cupor":"\u2A45","cups":"\u222A\uFE00","curarr":"\u21B7","curarrm":"\u293C","curlyeqprec":"\u22DE","curlyeqsucc":"\u22DF","curlyvee":"\u22CE","curlywedge":"\u22CF","curren":"\u00A4","curvearrowleft":"\u21B6","curvearrowright":"\u21B7","cuvee":"\u22CE","cuwed":"\u22CF","cwconint":"\u2232","cwint":"\u2231","cylcty":"\u232D","dagger":"\u2020","Dagger":"\u2021","daleth":"\u2138","darr":"\u2193","Darr":"\u21A1","dArr":"\u21D3","dash":"\u2010","Dashv":"\u2AE4","dashv":"\u22A3","dbkarow":"\u290F","dblac":"\u02DD","Dcaron":"\u010E","dcaron":"\u010F","Dcy":"\u0414","dcy":"\u0434","ddagger":"\u2021","ddarr":"\u21CA","DD":"\u2145","dd":"\u2146","DDotrahd":"\u2911","ddotseq":"\u2A77","deg":"\u00B0","Del":"\u2207","Delta":"\u0394","delta":"\u03B4","demptyv":"\u29B1","dfisht":"\u297F","Dfr":"\uD835\uDD07","dfr":"\uD835\uDD21","dHar":"\u2965","dharl":"\u21C3","dharr":"\u21C2","DiacriticalAcute":"\u00B4","DiacriticalDot":"\u02D9","DiacriticalDoubleAcute":"\u02DD","DiacriticalGrave":"`","DiacriticalTilde":"\u02DC","diam":"\u22C4","diamond":"\u22C4","Diamond":"\u22C4","diamondsuit":"\u2666","diams":"\u2666","die":"\u00A8","DifferentialD":"\u2146","digamma":"\u03DD","disin":"\u22F2","div":"\u00F7","divide":"\u00F7","divideontimes":"\u22C7","divonx":"\u22C7","DJcy":"\u0402","djcy":"\u0452","dlcorn":"\u231E","dlcrop":"\u230D","dollar":"$","Dopf":"\uD835\uDD3B","dopf":"\uD835\uDD55","Dot":"\u00A8","dot":"\u02D9","DotDot":"\u20DC","doteq":"\u2250","doteqdot":"\u2251","DotEqual":"\u2250","dotminus":"\u2238","dotplus":"\u2214","dotsquare":"\u22A1","doublebarwedge":"\u2306","DoubleContourIntegral":"\u222F","DoubleDot":"\u00A8","DoubleDownArrow":"\u21D3","DoubleLeftArrow":"\u21D0","DoubleLeftRightArrow":"\u21D4","DoubleLeftTee":"\u2AE4","DoubleLongLeftArrow":"\u27F8","DoubleLongLeftRightArrow":"\u27FA","DoubleLongRightArrow":"\u27F9","DoubleRightArrow":"\u21D2","DoubleRightTee":"\u22A8","DoubleUpArrow":"\u21D1","DoubleUpDownArrow":"\u21D5","DoubleVerticalBar":"\u2225","DownArrowBar":"\u2913","downarrow":"\u2193","DownArrow":"\u2193","Downarrow":"\u21D3","DownArrowUpArrow":"\u21F5","DownBreve":"\u0311","downdownarrows":"\u21CA","downharpoonleft":"\u21C3","downharpoonright":"\u21C2","DownLeftRightVector":"\u2950","DownLeftTeeVector":"\u295E","DownLeftVectorBar":"\u2956","DownLeftVector":"\u21BD","DownRightTeeVector":"\u295F","DownRightVectorBar":"\u2957","DownRightVector":"\u21C1","DownTeeArrow":"\u21A7","DownTee":"\u22A4","drbkarow":"\u2910","drcorn":"\u231F","drcrop":"\u230C","Dscr":"\uD835\uDC9F","dscr":"\uD835\uDCB9","DScy":"\u0405","dscy":"\u0455","dsol":"\u29F6","Dstrok":"\u0110","dstrok":"\u0111","dtdot":"\u22F1","dtri":"\u25BF","dtrif":"\u25BE","duarr":"\u21F5","duhar":"\u296F","dwangle":"\u29A6","DZcy":"\u040F","dzcy":"\u045F","dzigrarr":"\u27FF","Eacute":"\u00C9","eacute":"\u00E9","easter":"\u2A6E","Ecaron":"\u011A","ecaron":"\u011B","Ecirc":"\u00CA","ecirc":"\u00EA","ecir":"\u2256","ecolon":"\u2255","Ecy":"\u042D","ecy":"\u044D","eDDot":"\u2A77","Edot":"\u0116","edot":"\u0117","eDot":"\u2251","ee":"\u2147","efDot":"\u2252","Efr":"\uD835\uDD08","efr":"\uD835\uDD22","eg":"\u2A9A","Egrave":"\u00C8","egrave":"\u00E8","egs":"\u2A96","egsdot":"\u2A98","el":"\u2A99","Element":"\u2208","elinters":"\u23E7","ell":"\u2113","els":"\u2A95","elsdot":"\u2A97","Emacr":"\u0112","emacr":"\u0113","empty":"\u2205","emptyset":"\u2205","EmptySmallSquare":"\u25FB","emptyv":"\u2205","EmptyVerySmallSquare":"\u25AB","emsp13":"\u2004","emsp14":"\u2005","emsp":"\u2003","ENG":"\u014A","eng":"\u014B","ensp":"\u2002","Eogon":"\u0118","eogon":"\u0119","Eopf":"\uD835\uDD3C","eopf":"\uD835\uDD56","epar":"\u22D5","eparsl":"\u29E3","eplus":"\u2A71","epsi":"\u03B5","Epsilon":"\u0395","epsilon":"\u03B5","epsiv":"\u03F5","eqcirc":"\u2256","eqcolon":"\u2255","eqsim":"\u2242","eqslantgtr":"\u2A96","eqslantless":"\u2A95","Equal":"\u2A75","equals":"=","EqualTilde":"\u2242","equest":"\u225F","Equilibrium":"\u21CC","equiv":"\u2261","equivDD":"\u2A78","eqvparsl":"\u29E5","erarr":"\u2971","erDot":"\u2253","escr":"\u212F","Escr":"\u2130","esdot":"\u2250","Esim":"\u2A73","esim":"\u2242","Eta":"\u0397","eta":"\u03B7","ETH":"\u00D0","eth":"\u00F0","Euml":"\u00CB","euml":"\u00EB","euro":"\u20AC","excl":"!","exist":"\u2203","Exists":"\u2203","expectation":"\u2130","exponentiale":"\u2147","ExponentialE":"\u2147","fallingdotseq":"\u2252","Fcy":"\u0424","fcy":"\u0444","female":"\u2640","ffilig":"\uFB03","fflig":"\uFB00","ffllig":"\uFB04","Ffr":"\uD835\uDD09","ffr":"\uD835\uDD23","filig":"\uFB01","FilledSmallSquare":"\u25FC","FilledVerySmallSquare":"\u25AA","fjlig":"fj","flat":"\u266D","fllig":"\uFB02","fltns":"\u25B1","fnof":"\u0192","Fopf":"\uD835\uDD3D","fopf":"\uD835\uDD57","forall":"\u2200","ForAll":"\u2200","fork":"\u22D4","forkv":"\u2AD9","Fouriertrf":"\u2131","fpartint":"\u2A0D","frac12":"\u00BD","frac13":"\u2153","frac14":"\u00BC","frac15":"\u2155","frac16":"\u2159","frac18":"\u215B","frac23":"\u2154","frac25":"\u2156","frac34":"\u00BE","frac35":"\u2157","frac38":"\u215C","frac45":"\u2158","frac56":"\u215A","frac58":"\u215D","frac78":"\u215E","frasl":"\u2044","frown":"\u2322","fscr":"\uD835\uDCBB","Fscr":"\u2131","gacute":"\u01F5","Gamma":"\u0393","gamma":"\u03B3","Gammad":"\u03DC","gammad":"\u03DD","gap":"\u2A86","Gbreve":"\u011E","gbreve":"\u011F","Gcedil":"\u0122","Gcirc":"\u011C","gcirc":"\u011D","Gcy":"\u0413","gcy":"\u0433","Gdot":"\u0120","gdot":"\u0121","ge":"\u2265","gE":"\u2267","gEl":"\u2A8C","gel":"\u22DB","geq":"\u2265","geqq":"\u2267","geqslant":"\u2A7E","gescc":"\u2AA9","ges":"\u2A7E","gesdot":"\u2A80","gesdoto":"\u2A82","gesdotol":"\u2A84","gesl":"\u22DB\uFE00","gesles":"\u2A94","Gfr":"\uD835\uDD0A","gfr":"\uD835\uDD24","gg":"\u226B","Gg":"\u22D9","ggg":"\u22D9","gimel":"\u2137","GJcy":"\u0403","gjcy":"\u0453","gla":"\u2AA5","gl":"\u2277","glE":"\u2A92","glj":"\u2AA4","gnap":"\u2A8A","gnapprox":"\u2A8A","gne":"\u2A88","gnE":"\u2269","gneq":"\u2A88","gneqq":"\u2269","gnsim":"\u22E7","Gopf":"\uD835\uDD3E","gopf":"\uD835\uDD58","grave":"`","GreaterEqual":"\u2265","GreaterEqualLess":"\u22DB","GreaterFullEqual":"\u2267","GreaterGreater":"\u2AA2","GreaterLess":"\u2277","GreaterSlantEqual":"\u2A7E","GreaterTilde":"\u2273","Gscr":"\uD835\uDCA2","gscr":"\u210A","gsim":"\u2273","gsime":"\u2A8E","gsiml":"\u2A90","gtcc":"\u2AA7","gtcir":"\u2A7A","gt":">","GT":">","Gt":"\u226B","gtdot":"\u22D7","gtlPar":"\u2995","gtquest":"\u2A7C","gtrapprox":"\u2A86","gtrarr":"\u2978","gtrdot":"\u22D7","gtreqless":"\u22DB","gtreqqless":"\u2A8C","gtrless":"\u2277","gtrsim":"\u2273","gvertneqq":"\u2269\uFE00","gvnE":"\u2269\uFE00","Hacek":"\u02C7","hairsp":"\u200A","half":"\u00BD","hamilt":"\u210B","HARDcy":"\u042A","hardcy":"\u044A","harrcir":"\u2948","harr":"\u2194","hArr":"\u21D4","harrw":"\u21AD","Hat":"^","hbar":"\u210F","Hcirc":"\u0124","hcirc":"\u0125","hearts":"\u2665","heartsuit":"\u2665","hellip":"\u2026","hercon":"\u22B9","hfr":"\uD835\uDD25","Hfr":"\u210C","HilbertSpace":"\u210B","hksearow":"\u2925","hkswarow":"\u2926","hoarr":"\u21FF","homtht":"\u223B","hookleftarrow":"\u21A9","hookrightarrow":"\u21AA","hopf":"\uD835\uDD59","Hopf":"\u210D","horbar":"\u2015","HorizontalLine":"\u2500","hscr":"\uD835\uDCBD","Hscr":"\u210B","hslash":"\u210F","Hstrok":"\u0126","hstrok":"\u0127","HumpDownHump":"\u224E","HumpEqual":"\u224F","hybull":"\u2043","hyphen":"\u2010","Iacute":"\u00CD","iacute":"\u00ED","ic":"\u2063","Icirc":"\u00CE","icirc":"\u00EE","Icy":"\u0418","icy":"\u0438","Idot":"\u0130","IEcy":"\u0415","iecy":"\u0435","iexcl":"\u00A1","iff":"\u21D4","ifr":"\uD835\uDD26","Ifr":"\u2111","Igrave":"\u00CC","igrave":"\u00EC","ii":"\u2148","iiiint":"\u2A0C","iiint":"\u222D","iinfin":"\u29DC","iiota":"\u2129","IJlig":"\u0132","ijlig":"\u0133","Imacr":"\u012A","imacr":"\u012B","image":"\u2111","ImaginaryI":"\u2148","imagline":"\u2110","imagpart":"\u2111","imath":"\u0131","Im":"\u2111","imof":"\u22B7","imped":"\u01B5","Implies":"\u21D2","incare":"\u2105","in":"\u2208","infin":"\u221E","infintie":"\u29DD","inodot":"\u0131","intcal":"\u22BA","int":"\u222B","Int":"\u222C","integers":"\u2124","Integral":"\u222B","intercal":"\u22BA","Intersection":"\u22C2","intlarhk":"\u2A17","intprod":"\u2A3C","InvisibleComma":"\u2063","InvisibleTimes":"\u2062","IOcy":"\u0401","iocy":"\u0451","Iogon":"\u012E","iogon":"\u012F","Iopf":"\uD835\uDD40","iopf":"\uD835\uDD5A","Iota":"\u0399","iota":"\u03B9","iprod":"\u2A3C","iquest":"\u00BF","iscr":"\uD835\uDCBE","Iscr":"\u2110","isin":"\u2208","isindot":"\u22F5","isinE":"\u22F9","isins":"\u22F4","isinsv":"\u22F3","isinv":"\u2208","it":"\u2062","Itilde":"\u0128","itilde":"\u0129","Iukcy":"\u0406","iukcy":"\u0456","Iuml":"\u00CF","iuml":"\u00EF","Jcirc":"\u0134","jcirc":"\u0135","Jcy":"\u0419","jcy":"\u0439","Jfr":"\uD835\uDD0D","jfr":"\uD835\uDD27","jmath":"\u0237","Jopf":"\uD835\uDD41","jopf":"\uD835\uDD5B","Jscr":"\uD835\uDCA5","jscr":"\uD835\uDCBF","Jsercy":"\u0408","jsercy":"\u0458","Jukcy":"\u0404","jukcy":"\u0454","Kappa":"\u039A","kappa":"\u03BA","kappav":"\u03F0","Kcedil":"\u0136","kcedil":"\u0137","Kcy":"\u041A","kcy":"\u043A","Kfr":"\uD835\uDD0E","kfr":"\uD835\uDD28","kgreen":"\u0138","KHcy":"\u0425","khcy":"\u0445","KJcy":"\u040C","kjcy":"\u045C","Kopf":"\uD835\uDD42","kopf":"\uD835\uDD5C","Kscr":"\uD835\uDCA6","kscr":"\uD835\uDCC0","lAarr":"\u21DA","Lacute":"\u0139","lacute":"\u013A","laemptyv":"\u29B4","lagran":"\u2112","Lambda":"\u039B","lambda":"\u03BB","lang":"\u27E8","Lang":"\u27EA","langd":"\u2991","langle":"\u27E8","lap":"\u2A85","Laplacetrf":"\u2112","laquo":"\u00AB","larrb":"\u21E4","larrbfs":"\u291F","larr":"\u2190","Larr":"\u219E","lArr":"\u21D0","larrfs":"\u291D","larrhk":"\u21A9","larrlp":"\u21AB","larrpl":"\u2939","larrsim":"\u2973","larrtl":"\u21A2","latail":"\u2919","lAtail":"\u291B","lat":"\u2AAB","late":"\u2AAD","lates":"\u2AAD\uFE00","lbarr":"\u290C","lBarr":"\u290E","lbbrk":"\u2772","lbrace":"{","lbrack":"[","lbrke":"\u298B","lbrksld":"\u298F","lbrkslu":"\u298D","Lcaron":"\u013D","lcaron":"\u013E","Lcedil":"\u013B","lcedil":"\u013C","lceil":"\u2308","lcub":"{","Lcy":"\u041B","lcy":"\u043B","ldca":"\u2936","ldquo":"\u201C","ldquor":"\u201E","ldrdhar":"\u2967","ldrushar":"\u294B","ldsh":"\u21B2","le":"\u2264","lE":"\u2266","LeftAngleBracket":"\u27E8","LeftArrowBar":"\u21E4","leftarrow":"\u2190","LeftArrow":"\u2190","Leftarrow":"\u21D0","LeftArrowRightArrow":"\u21C6","leftarrowtail":"\u21A2","LeftCeiling":"\u2308","LeftDoubleBracket":"\u27E6","LeftDownTeeVector":"\u2961","LeftDownVectorBar":"\u2959","LeftDownVector":"\u21C3","LeftFloor":"\u230A","leftharpoondown":"\u21BD","leftharpoonup":"\u21BC","leftleftarrows":"\u21C7","leftrightarrow":"\u2194","LeftRightArrow":"\u2194","Leftrightarrow":"\u21D4","leftrightarrows":"\u21C6","leftrightharpoons":"\u21CB","leftrightsquigarrow":"\u21AD","LeftRightVector":"\u294E","LeftTeeArrow":"\u21A4","LeftTee":"\u22A3","LeftTeeVector":"\u295A","leftthreetimes":"\u22CB","LeftTriangleBar":"\u29CF","LeftTriangle":"\u22B2","LeftTriangleEqual":"\u22B4","LeftUpDownVector":"\u2951","LeftUpTeeVector":"\u2960","LeftUpVectorBar":"\u2958","LeftUpVector":"\u21BF","LeftVectorBar":"\u2952","LeftVector":"\u21BC","lEg":"\u2A8B","leg":"\u22DA","leq":"\u2264","leqq":"\u2266","leqslant":"\u2A7D","lescc":"\u2AA8","les":"\u2A7D","lesdot":"\u2A7F","lesdoto":"\u2A81","lesdotor":"\u2A83","lesg":"\u22DA\uFE00","lesges":"\u2A93","lessapprox":"\u2A85","lessdot":"\u22D6","lesseqgtr":"\u22DA","lesseqqgtr":"\u2A8B","LessEqualGreater":"\u22DA","LessFullEqual":"\u2266","LessGreater":"\u2276","lessgtr":"\u2276","LessLess":"\u2AA1","lesssim":"\u2272","LessSlantEqual":"\u2A7D","LessTilde":"\u2272","lfisht":"\u297C","lfloor":"\u230A","Lfr":"\uD835\uDD0F","lfr":"\uD835\uDD29","lg":"\u2276","lgE":"\u2A91","lHar":"\u2962","lhard":"\u21BD","lharu":"\u21BC","lharul":"\u296A","lhblk":"\u2584","LJcy":"\u0409","ljcy":"\u0459","llarr":"\u21C7","ll":"\u226A","Ll":"\u22D8","llcorner":"\u231E","Lleftarrow":"\u21DA","llhard":"\u296B","lltri":"\u25FA","Lmidot":"\u013F","lmidot":"\u0140","lmoustache":"\u23B0","lmoust":"\u23B0","lnap":"\u2A89","lnapprox":"\u2A89","lne":"\u2A87","lnE":"\u2268","lneq":"\u2A87","lneqq":"\u2268","lnsim":"\u22E6","loang":"\u27EC","loarr":"\u21FD","lobrk":"\u27E6","longleftarrow":"\u27F5","LongLeftArrow":"\u27F5","Longleftarrow":"\u27F8","longleftrightarrow":"\u27F7","LongLeftRightArrow":"\u27F7","Longleftrightarrow":"\u27FA","longmapsto":"\u27FC","longrightarrow":"\u27F6","LongRightArrow":"\u27F6","Longrightarrow":"\u27F9","looparrowleft":"\u21AB","looparrowright":"\u21AC","lopar":"\u2985","Lopf":"\uD835\uDD43","lopf":"\uD835\uDD5D","loplus":"\u2A2D","lotimes":"\u2A34","lowast":"\u2217","lowbar":"_","LowerLeftArrow":"\u2199","LowerRightArrow":"\u2198","loz":"\u25CA","lozenge":"\u25CA","lozf":"\u29EB","lpar":"(","lparlt":"\u2993","lrarr":"\u21C6","lrcorner":"\u231F","lrhar":"\u21CB","lrhard":"\u296D","lrm":"\u200E","lrtri":"\u22BF","lsaquo":"\u2039","lscr":"\uD835\uDCC1","Lscr":"\u2112","lsh":"\u21B0","Lsh":"\u21B0","lsim":"\u2272","lsime":"\u2A8D","lsimg":"\u2A8F","lsqb":"[","lsquo":"\u2018","lsquor":"\u201A","Lstrok":"\u0141","lstrok":"\u0142","ltcc":"\u2AA6","ltcir":"\u2A79","lt":"<","LT":"<","Lt":"\u226A","ltdot":"\u22D6","lthree":"\u22CB","ltimes":"\u22C9","ltlarr":"\u2976","ltquest":"\u2A7B","ltri":"\u25C3","ltrie":"\u22B4","ltrif":"\u25C2","ltrPar":"\u2996","lurdshar":"\u294A","luruhar":"\u2966","lvertneqq":"\u2268\uFE00","lvnE":"\u2268\uFE00","macr":"\u00AF","male":"\u2642","malt":"\u2720","maltese":"\u2720","Map":"\u2905","map":"\u21A6","mapsto":"\u21A6","mapstodown":"\u21A7","mapstoleft":"\u21A4","mapstoup":"\u21A5","marker":"\u25AE","mcomma":"\u2A29","Mcy":"\u041C","mcy":"\u043C","mdash":"\u2014","mDDot":"\u223A","measuredangle":"\u2221","MediumSpace":"\u205F","Mellintrf":"\u2133","Mfr":"\uD835\uDD10","mfr":"\uD835\uDD2A","mho":"\u2127","micro":"\u00B5","midast":"*","midcir":"\u2AF0","mid":"\u2223","middot":"\u00B7","minusb":"\u229F","minus":"\u2212","minusd":"\u2238","minusdu":"\u2A2A","MinusPlus":"\u2213","mlcp":"\u2ADB","mldr":"\u2026","mnplus":"\u2213","models":"\u22A7","Mopf":"\uD835\uDD44","mopf":"\uD835\uDD5E","mp":"\u2213","mscr":"\uD835\uDCC2","Mscr":"\u2133","mstpos":"\u223E","Mu":"\u039C","mu":"\u03BC","multimap":"\u22B8","mumap":"\u22B8","nabla":"\u2207","Nacute":"\u0143","nacute":"\u0144","nang":"\u2220\u20D2","nap":"\u2249","napE":"\u2A70\u0338","napid":"\u224B\u0338","napos":"\u0149","napprox":"\u2249","natural":"\u266E","naturals":"\u2115","natur":"\u266E","nbsp":"\u00A0","nbump":"\u224E\u0338","nbumpe":"\u224F\u0338","ncap":"\u2A43","Ncaron":"\u0147","ncaron":"\u0148","Ncedil":"\u0145","ncedil":"\u0146","ncong":"\u2247","ncongdot":"\u2A6D\u0338","ncup":"\u2A42","Ncy":"\u041D","ncy":"\u043D","ndash":"\u2013","nearhk":"\u2924","nearr":"\u2197","neArr":"\u21D7","nearrow":"\u2197","ne":"\u2260","nedot":"\u2250\u0338","NegativeMediumSpace":"\u200B","NegativeThickSpace":"\u200B","NegativeThinSpace":"\u200B","NegativeVeryThinSpace":"\u200B","nequiv":"\u2262","nesear":"\u2928","nesim":"\u2242\u0338","NestedGreaterGreater":"\u226B","NestedLessLess":"\u226A","NewLine":"\n","nexist":"\u2204","nexists":"\u2204","Nfr":"\uD835\uDD11","nfr":"\uD835\uDD2B","ngE":"\u2267\u0338","nge":"\u2271","ngeq":"\u2271","ngeqq":"\u2267\u0338","ngeqslant":"\u2A7E\u0338","nges":"\u2A7E\u0338","nGg":"\u22D9\u0338","ngsim":"\u2275","nGt":"\u226B\u20D2","ngt":"\u226F","ngtr":"\u226F","nGtv":"\u226B\u0338","nharr":"\u21AE","nhArr":"\u21CE","nhpar":"\u2AF2","ni":"\u220B","nis":"\u22FC","nisd":"\u22FA","niv":"\u220B","NJcy":"\u040A","njcy":"\u045A","nlarr":"\u219A","nlArr":"\u21CD","nldr":"\u2025","nlE":"\u2266\u0338","nle":"\u2270","nleftarrow":"\u219A","nLeftarrow":"\u21CD","nleftrightarrow":"\u21AE","nLeftrightarrow":"\u21CE","nleq":"\u2270","nleqq":"\u2266\u0338","nleqslant":"\u2A7D\u0338","nles":"\u2A7D\u0338","nless":"\u226E","nLl":"\u22D8\u0338","nlsim":"\u2274","nLt":"\u226A\u20D2","nlt":"\u226E","nltri":"\u22EA","nltrie":"\u22EC","nLtv":"\u226A\u0338","nmid":"\u2224","NoBreak":"\u2060","NonBreakingSpace":"\u00A0","nopf":"\uD835\uDD5F","Nopf":"\u2115","Not":"\u2AEC","not":"\u00AC","NotCongruent":"\u2262","NotCupCap":"\u226D","NotDoubleVerticalBar":"\u2226","NotElement":"\u2209","NotEqual":"\u2260","NotEqualTilde":"\u2242\u0338","NotExists":"\u2204","NotGreater":"\u226F","NotGreaterEqual":"\u2271","NotGreaterFullEqual":"\u2267\u0338","NotGreaterGreater":"\u226B\u0338","NotGreaterLess":"\u2279","NotGreaterSlantEqual":"\u2A7E\u0338","NotGreaterTilde":"\u2275","NotHumpDownHump":"\u224E\u0338","NotHumpEqual":"\u224F\u0338","notin":"\u2209","notindot":"\u22F5\u0338","notinE":"\u22F9\u0338","notinva":"\u2209","notinvb":"\u22F7","notinvc":"\u22F6","NotLeftTriangleBar":"\u29CF\u0338","NotLeftTriangle":"\u22EA","NotLeftTriangleEqual":"\u22EC","NotLess":"\u226E","NotLessEqual":"\u2270","NotLessGreater":"\u2278","NotLessLess":"\u226A\u0338","NotLessSlantEqual":"\u2A7D\u0338","NotLessTilde":"\u2274","NotNestedGreaterGreater":"\u2AA2\u0338","NotNestedLessLess":"\u2AA1\u0338","notni":"\u220C","notniva":"\u220C","notnivb":"\u22FE","notnivc":"\u22FD","NotPrecedes":"\u2280","NotPrecedesEqual":"\u2AAF\u0338","NotPrecedesSlantEqual":"\u22E0","NotReverseElement":"\u220C","NotRightTriangleBar":"\u29D0\u0338","NotRightTriangle":"\u22EB","NotRightTriangleEqual":"\u22ED","NotSquareSubset":"\u228F\u0338","NotSquareSubsetEqual":"\u22E2","NotSquareSuperset":"\u2290\u0338","NotSquareSupersetEqual":"\u22E3","NotSubset":"\u2282\u20D2","NotSubsetEqual":"\u2288","NotSucceeds":"\u2281","NotSucceedsEqual":"\u2AB0\u0338","NotSucceedsSlantEqual":"\u22E1","NotSucceedsTilde":"\u227F\u0338","NotSuperset":"\u2283\u20D2","NotSupersetEqual":"\u2289","NotTilde":"\u2241","NotTildeEqual":"\u2244","NotTildeFullEqual":"\u2247","NotTildeTilde":"\u2249","NotVerticalBar":"\u2224","nparallel":"\u2226","npar":"\u2226","nparsl":"\u2AFD\u20E5","npart":"\u2202\u0338","npolint":"\u2A14","npr":"\u2280","nprcue":"\u22E0","nprec":"\u2280","npreceq":"\u2AAF\u0338","npre":"\u2AAF\u0338","nrarrc":"\u2933\u0338","nrarr":"\u219B","nrArr":"\u21CF","nrarrw":"\u219D\u0338","nrightarrow":"\u219B","nRightarrow":"\u21CF","nrtri":"\u22EB","nrtrie":"\u22ED","nsc":"\u2281","nsccue":"\u22E1","nsce":"\u2AB0\u0338","Nscr":"\uD835\uDCA9","nscr":"\uD835\uDCC3","nshortmid":"\u2224","nshortparallel":"\u2226","nsim":"\u2241","nsime":"\u2244","nsimeq":"\u2244","nsmid":"\u2224","nspar":"\u2226","nsqsube":"\u22E2","nsqsupe":"\u22E3","nsub":"\u2284","nsubE":"\u2AC5\u0338","nsube":"\u2288","nsubset":"\u2282\u20D2","nsubseteq":"\u2288","nsubseteqq":"\u2AC5\u0338","nsucc":"\u2281","nsucceq":"\u2AB0\u0338","nsup":"\u2285","nsupE":"\u2AC6\u0338","nsupe":"\u2289","nsupset":"\u2283\u20D2","nsupseteq":"\u2289","nsupseteqq":"\u2AC6\u0338","ntgl":"\u2279","Ntilde":"\u00D1","ntilde":"\u00F1","ntlg":"\u2278","ntriangleleft":"\u22EA","ntrianglelefteq":"\u22EC","ntriangleright":"\u22EB","ntrianglerighteq":"\u22ED","Nu":"\u039D","nu":"\u03BD","num":"#","numero":"\u2116","numsp":"\u2007","nvap":"\u224D\u20D2","nvdash":"\u22AC","nvDash":"\u22AD","nVdash":"\u22AE","nVDash":"\u22AF","nvge":"\u2265\u20D2","nvgt":">\u20D2","nvHarr":"\u2904","nvinfin":"\u29DE","nvlArr":"\u2902","nvle":"\u2264\u20D2","nvlt":"<\u20D2","nvltrie":"\u22B4\u20D2","nvrArr":"\u2903","nvrtrie":"\u22B5\u20D2","nvsim":"\u223C\u20D2","nwarhk":"\u2923","nwarr":"\u2196","nwArr":"\u21D6","nwarrow":"\u2196","nwnear":"\u2927","Oacute":"\u00D3","oacute":"\u00F3","oast":"\u229B","Ocirc":"\u00D4","ocirc":"\u00F4","ocir":"\u229A","Ocy":"\u041E","ocy":"\u043E","odash":"\u229D","Odblac":"\u0150","odblac":"\u0151","odiv":"\u2A38","odot":"\u2299","odsold":"\u29BC","OElig":"\u0152","oelig":"\u0153","ofcir":"\u29BF","Ofr":"\uD835\uDD12","ofr":"\uD835\uDD2C","ogon":"\u02DB","Ograve":"\u00D2","ograve":"\u00F2","ogt":"\u29C1","ohbar":"\u29B5","ohm":"\u03A9","oint":"\u222E","olarr":"\u21BA","olcir":"\u29BE","olcross":"\u29BB","oline":"\u203E","olt":"\u29C0","Omacr":"\u014C","omacr":"\u014D","Omega":"\u03A9","omega":"\u03C9","Omicron":"\u039F","omicron":"\u03BF","omid":"\u29B6","ominus":"\u2296","Oopf":"\uD835\uDD46","oopf":"\uD835\uDD60","opar":"\u29B7","OpenCurlyDoubleQuote":"\u201C","OpenCurlyQuote":"\u2018","operp":"\u29B9","oplus":"\u2295","orarr":"\u21BB","Or":"\u2A54","or":"\u2228","ord":"\u2A5D","order":"\u2134","orderof":"\u2134","ordf":"\u00AA","ordm":"\u00BA","origof":"\u22B6","oror":"\u2A56","orslope":"\u2A57","orv":"\u2A5B","oS":"\u24C8","Oscr":"\uD835\uDCAA","oscr":"\u2134","Oslash":"\u00D8","oslash":"\u00F8","osol":"\u2298","Otilde":"\u00D5","otilde":"\u00F5","otimesas":"\u2A36","Otimes":"\u2A37","otimes":"\u2297","Ouml":"\u00D6","ouml":"\u00F6","ovbar":"\u233D","OverBar":"\u203E","OverBrace":"\u23DE","OverBracket":"\u23B4","OverParenthesis":"\u23DC","para":"\u00B6","parallel":"\u2225","par":"\u2225","parsim":"\u2AF3","parsl":"\u2AFD","part":"\u2202","PartialD":"\u2202","Pcy":"\u041F","pcy":"\u043F","percnt":"%","period":".","permil":"\u2030","perp":"\u22A5","pertenk":"\u2031","Pfr":"\uD835\uDD13","pfr":"\uD835\uDD2D","Phi":"\u03A6","phi":"\u03C6","phiv":"\u03D5","phmmat":"\u2133","phone":"\u260E","Pi":"\u03A0","pi":"\u03C0","pitchfork":"\u22D4","piv":"\u03D6","planck":"\u210F","planckh":"\u210E","plankv":"\u210F","plusacir":"\u2A23","plusb":"\u229E","pluscir":"\u2A22","plus":"+","plusdo":"\u2214","plusdu":"\u2A25","pluse":"\u2A72","PlusMinus":"\u00B1","plusmn":"\u00B1","plussim":"\u2A26","plustwo":"\u2A27","pm":"\u00B1","Poincareplane":"\u210C","pointint":"\u2A15","popf":"\uD835\uDD61","Popf":"\u2119","pound":"\u00A3","prap":"\u2AB7","Pr":"\u2ABB","pr":"\u227A","prcue":"\u227C","precapprox":"\u2AB7","prec":"\u227A","preccurlyeq":"\u227C","Precedes":"\u227A","PrecedesEqual":"\u2AAF","PrecedesSlantEqual":"\u227C","PrecedesTilde":"\u227E","preceq":"\u2AAF","precnapprox":"\u2AB9","precneqq":"\u2AB5","precnsim":"\u22E8","pre":"\u2AAF","prE":"\u2AB3","precsim":"\u227E","prime":"\u2032","Prime":"\u2033","primes":"\u2119","prnap":"\u2AB9","prnE":"\u2AB5","prnsim":"\u22E8","prod":"\u220F","Product":"\u220F","profalar":"\u232E","profline":"\u2312","profsurf":"\u2313","prop":"\u221D","Proportional":"\u221D","Proportion":"\u2237","propto":"\u221D","prsim":"\u227E","prurel":"\u22B0","Pscr":"\uD835\uDCAB","pscr":"\uD835\uDCC5","Psi":"\u03A8","psi":"\u03C8","puncsp":"\u2008","Qfr":"\uD835\uDD14","qfr":"\uD835\uDD2E","qint":"\u2A0C","qopf":"\uD835\uDD62","Qopf":"\u211A","qprime":"\u2057","Qscr":"\uD835\uDCAC","qscr":"\uD835\uDCC6","quaternions":"\u210D","quatint":"\u2A16","quest":"?","questeq":"\u225F","quot":"\"","QUOT":"\"","rAarr":"\u21DB","race":"\u223D\u0331","Racute":"\u0154","racute":"\u0155","radic":"\u221A","raemptyv":"\u29B3","rang":"\u27E9","Rang":"\u27EB","rangd":"\u2992","range":"\u29A5","rangle":"\u27E9","raquo":"\u00BB","rarrap":"\u2975","rarrb":"\u21E5","rarrbfs":"\u2920","rarrc":"\u2933","rarr":"\u2192","Rarr":"\u21A0","rArr":"\u21D2","rarrfs":"\u291E","rarrhk":"\u21AA","rarrlp":"\u21AC","rarrpl":"\u2945","rarrsim":"\u2974","Rarrtl":"\u2916","rarrtl":"\u21A3","rarrw":"\u219D","ratail":"\u291A","rAtail":"\u291C","ratio":"\u2236","rationals":"\u211A","rbarr":"\u290D","rBarr":"\u290F","RBarr":"\u2910","rbbrk":"\u2773","rbrace":"}","rbrack":"]","rbrke":"\u298C","rbrksld":"\u298E","rbrkslu":"\u2990","Rcaron":"\u0158","rcaron":"\u0159","Rcedil":"\u0156","rcedil":"\u0157","rceil":"\u2309","rcub":"}","Rcy":"\u0420","rcy":"\u0440","rdca":"\u2937","rdldhar":"\u2969","rdquo":"\u201D","rdquor":"\u201D","rdsh":"\u21B3","real":"\u211C","realine":"\u211B","realpart":"\u211C","reals":"\u211D","Re":"\u211C","rect":"\u25AD","reg":"\u00AE","REG":"\u00AE","ReverseElement":"\u220B","ReverseEquilibrium":"\u21CB","ReverseUpEquilibrium":"\u296F","rfisht":"\u297D","rfloor":"\u230B","rfr":"\uD835\uDD2F","Rfr":"\u211C","rHar":"\u2964","rhard":"\u21C1","rharu":"\u21C0","rharul":"\u296C","Rho":"\u03A1","rho":"\u03C1","rhov":"\u03F1","RightAngleBracket":"\u27E9","RightArrowBar":"\u21E5","rightarrow":"\u2192","RightArrow":"\u2192","Rightarrow":"\u21D2","RightArrowLeftArrow":"\u21C4","rightarrowtail":"\u21A3","RightCeiling":"\u2309","RightDoubleBracket":"\u27E7","RightDownTeeVector":"\u295D","RightDownVectorBar":"\u2955","RightDownVector":"\u21C2","RightFloor":"\u230B","rightharpoondown":"\u21C1","rightharpoonup":"\u21C0","rightleftarrows":"\u21C4","rightleftharpoons":"\u21CC","rightrightarrows":"\u21C9","rightsquigarrow":"\u219D","RightTeeArrow":"\u21A6","RightTee":"\u22A2","RightTeeVector":"\u295B","rightthreetimes":"\u22CC","RightTriangleBar":"\u29D0","RightTriangle":"\u22B3","RightTriangleEqual":"\u22B5","RightUpDownVector":"\u294F","RightUpTeeVector":"\u295C","RightUpVectorBar":"\u2954","RightUpVector":"\u21BE","RightVectorBar":"\u2953","RightVector":"\u21C0","ring":"\u02DA","risingdotseq":"\u2253","rlarr":"\u21C4","rlhar":"\u21CC","rlm":"\u200F","rmoustache":"\u23B1","rmoust":"\u23B1","rnmid":"\u2AEE","roang":"\u27ED","roarr":"\u21FE","robrk":"\u27E7","ropar":"\u2986","ropf":"\uD835\uDD63","Ropf":"\u211D","roplus":"\u2A2E","rotimes":"\u2A35","RoundImplies":"\u2970","rpar":")","rpargt":"\u2994","rppolint":"\u2A12","rrarr":"\u21C9","Rrightarrow":"\u21DB","rsaquo":"\u203A","rscr":"\uD835\uDCC7","Rscr":"\u211B","rsh":"\u21B1","Rsh":"\u21B1","rsqb":"]","rsquo":"\u2019","rsquor":"\u2019","rthree":"\u22CC","rtimes":"\u22CA","rtri":"\u25B9","rtrie":"\u22B5","rtrif":"\u25B8","rtriltri":"\u29CE","RuleDelayed":"\u29F4","ruluhar":"\u2968","rx":"\u211E","Sacute":"\u015A","sacute":"\u015B","sbquo":"\u201A","scap":"\u2AB8","Scaron":"\u0160","scaron":"\u0161","Sc":"\u2ABC","sc":"\u227B","sccue":"\u227D","sce":"\u2AB0","scE":"\u2AB4","Scedil":"\u015E","scedil":"\u015F","Scirc":"\u015C","scirc":"\u015D","scnap":"\u2ABA","scnE":"\u2AB6","scnsim":"\u22E9","scpolint":"\u2A13","scsim":"\u227F","Scy":"\u0421","scy":"\u0441","sdotb":"\u22A1","sdot":"\u22C5","sdote":"\u2A66","searhk":"\u2925","searr":"\u2198","seArr":"\u21D8","searrow":"\u2198","sect":"\u00A7","semi":";","seswar":"\u2929","setminus":"\u2216","setmn":"\u2216","sext":"\u2736","Sfr":"\uD835\uDD16","sfr":"\uD835\uDD30","sfrown":"\u2322","sharp":"\u266F","SHCHcy":"\u0429","shchcy":"\u0449","SHcy":"\u0428","shcy":"\u0448","ShortDownArrow":"\u2193","ShortLeftArrow":"\u2190","shortmid":"\u2223","shortparallel":"\u2225","ShortRightArrow":"\u2192","ShortUpArrow":"\u2191","shy":"\u00AD","Sigma":"\u03A3","sigma":"\u03C3","sigmaf":"\u03C2","sigmav":"\u03C2","sim":"\u223C","simdot":"\u2A6A","sime":"\u2243","simeq":"\u2243","simg":"\u2A9E","simgE":"\u2AA0","siml":"\u2A9D","simlE":"\u2A9F","simne":"\u2246","simplus":"\u2A24","simrarr":"\u2972","slarr":"\u2190","SmallCircle":"\u2218","smallsetminus":"\u2216","smashp":"\u2A33","smeparsl":"\u29E4","smid":"\u2223","smile":"\u2323","smt":"\u2AAA","smte":"\u2AAC","smtes":"\u2AAC\uFE00","SOFTcy":"\u042C","softcy":"\u044C","solbar":"\u233F","solb":"\u29C4","sol":"/","Sopf":"\uD835\uDD4A","sopf":"\uD835\uDD64","spades":"\u2660","spadesuit":"\u2660","spar":"\u2225","sqcap":"\u2293","sqcaps":"\u2293\uFE00","sqcup":"\u2294","sqcups":"\u2294\uFE00","Sqrt":"\u221A","sqsub":"\u228F","sqsube":"\u2291","sqsubset":"\u228F","sqsubseteq":"\u2291","sqsup":"\u2290","sqsupe":"\u2292","sqsupset":"\u2290","sqsupseteq":"\u2292","square":"\u25A1","Square":"\u25A1","SquareIntersection":"\u2293","SquareSubset":"\u228F","SquareSubsetEqual":"\u2291","SquareSuperset":"\u2290","SquareSupersetEqual":"\u2292","SquareUnion":"\u2294","squarf":"\u25AA","squ":"\u25A1","squf":"\u25AA","srarr":"\u2192","Sscr":"\uD835\uDCAE","sscr":"\uD835\uDCC8","ssetmn":"\u2216","ssmile":"\u2323","sstarf":"\u22C6","Star":"\u22C6","star":"\u2606","starf":"\u2605","straightepsilon":"\u03F5","straightphi":"\u03D5","strns":"\u00AF","sub":"\u2282","Sub":"\u22D0","subdot":"\u2ABD","subE":"\u2AC5","sube":"\u2286","subedot":"\u2AC3","submult":"\u2AC1","subnE":"\u2ACB","subne":"\u228A","subplus":"\u2ABF","subrarr":"\u2979","subset":"\u2282","Subset":"\u22D0","subseteq":"\u2286","subseteqq":"\u2AC5","SubsetEqual":"\u2286","subsetneq":"\u228A","subsetneqq":"\u2ACB","subsim":"\u2AC7","subsub":"\u2AD5","subsup":"\u2AD3","succapprox":"\u2AB8","succ":"\u227B","succcurlyeq":"\u227D","Succeeds":"\u227B","SucceedsEqual":"\u2AB0","SucceedsSlantEqual":"\u227D","SucceedsTilde":"\u227F","succeq":"\u2AB0","succnapprox":"\u2ABA","succneqq":"\u2AB6","succnsim":"\u22E9","succsim":"\u227F","SuchThat":"\u220B","sum":"\u2211","Sum":"\u2211","sung":"\u266A","sup1":"\u00B9","sup2":"\u00B2","sup3":"\u00B3","sup":"\u2283","Sup":"\u22D1","supdot":"\u2ABE","supdsub":"\u2AD8","supE":"\u2AC6","supe":"\u2287","supedot":"\u2AC4","Superset":"\u2283","SupersetEqual":"\u2287","suphsol":"\u27C9","suphsub":"\u2AD7","suplarr":"\u297B","supmult":"\u2AC2","supnE":"\u2ACC","supne":"\u228B","supplus":"\u2AC0","supset":"\u2283","Supset":"\u22D1","supseteq":"\u2287","supseteqq":"\u2AC6","supsetneq":"\u228B","supsetneqq":"\u2ACC","supsim":"\u2AC8","supsub":"\u2AD4","supsup":"\u2AD6","swarhk":"\u2926","swarr":"\u2199","swArr":"\u21D9","swarrow":"\u2199","swnwar":"\u292A","szlig":"\u00DF","Tab":"\t","target":"\u2316","Tau":"\u03A4","tau":"\u03C4","tbrk":"\u23B4","Tcaron":"\u0164","tcaron":"\u0165","Tcedil":"\u0162","tcedil":"\u0163","Tcy":"\u0422","tcy":"\u0442","tdot":"\u20DB","telrec":"\u2315","Tfr":"\uD835\uDD17","tfr":"\uD835\uDD31","there4":"\u2234","therefore":"\u2234","Therefore":"\u2234","Theta":"\u0398","theta":"\u03B8","thetasym":"\u03D1","thetav":"\u03D1","thickapprox":"\u2248","thicksim":"\u223C","ThickSpace":"\u205F\u200A","ThinSpace":"\u2009","thinsp":"\u2009","thkap":"\u2248","thksim":"\u223C","THORN":"\u00DE","thorn":"\u00FE","tilde":"\u02DC","Tilde":"\u223C","TildeEqual":"\u2243","TildeFullEqual":"\u2245","TildeTilde":"\u2248","timesbar":"\u2A31","timesb":"\u22A0","times":"\u00D7","timesd":"\u2A30","tint":"\u222D","toea":"\u2928","topbot":"\u2336","topcir":"\u2AF1","top":"\u22A4","Topf":"\uD835\uDD4B","topf":"\uD835\uDD65","topfork":"\u2ADA","tosa":"\u2929","tprime":"\u2034","trade":"\u2122","TRADE":"\u2122","triangle":"\u25B5","triangledown":"\u25BF","triangleleft":"\u25C3","trianglelefteq":"\u22B4","triangleq":"\u225C","triangleright":"\u25B9","trianglerighteq":"\u22B5","tridot":"\u25EC","trie":"\u225C","triminus":"\u2A3A","TripleDot":"\u20DB","triplus":"\u2A39","trisb":"\u29CD","tritime":"\u2A3B","trpezium":"\u23E2","Tscr":"\uD835\uDCAF","tscr":"\uD835\uDCC9","TScy":"\u0426","tscy":"\u0446","TSHcy":"\u040B","tshcy":"\u045B","Tstrok":"\u0166","tstrok":"\u0167","twixt":"\u226C","twoheadleftarrow":"\u219E","twoheadrightarrow":"\u21A0","Uacute":"\u00DA","uacute":"\u00FA","uarr":"\u2191","Uarr":"\u219F","uArr":"\u21D1","Uarrocir":"\u2949","Ubrcy":"\u040E","ubrcy":"\u045E","Ubreve":"\u016C","ubreve":"\u016D","Ucirc":"\u00DB","ucirc":"\u00FB","Ucy":"\u0423","ucy":"\u0443","udarr":"\u21C5","Udblac":"\u0170","udblac":"\u0171","udhar":"\u296E","ufisht":"\u297E","Ufr":"\uD835\uDD18","ufr":"\uD835\uDD32","Ugrave":"\u00D9","ugrave":"\u00F9","uHar":"\u2963","uharl":"\u21BF","uharr":"\u21BE","uhblk":"\u2580","ulcorn":"\u231C","ulcorner":"\u231C","ulcrop":"\u230F","ultri":"\u25F8","Umacr":"\u016A","umacr":"\u016B","uml":"\u00A8","UnderBar":"_","UnderBrace":"\u23DF","UnderBracket":"\u23B5","UnderParenthesis":"\u23DD","Union":"\u22C3","UnionPlus":"\u228E","Uogon":"\u0172","uogon":"\u0173","Uopf":"\uD835\uDD4C","uopf":"\uD835\uDD66","UpArrowBar":"\u2912","uparrow":"\u2191","UpArrow":"\u2191","Uparrow":"\u21D1","UpArrowDownArrow":"\u21C5","updownarrow":"\u2195","UpDownArrow":"\u2195","Updownarrow":"\u21D5","UpEquilibrium":"\u296E","upharpoonleft":"\u21BF","upharpoonright":"\u21BE","uplus":"\u228E","UpperLeftArrow":"\u2196","UpperRightArrow":"\u2197","upsi":"\u03C5","Upsi":"\u03D2","upsih":"\u03D2","Upsilon":"\u03A5","upsilon":"\u03C5","UpTeeArrow":"\u21A5","UpTee":"\u22A5","upuparrows":"\u21C8","urcorn":"\u231D","urcorner":"\u231D","urcrop":"\u230E","Uring":"\u016E","uring":"\u016F","urtri":"\u25F9","Uscr":"\uD835\uDCB0","uscr":"\uD835\uDCCA","utdot":"\u22F0","Utilde":"\u0168","utilde":"\u0169","utri":"\u25B5","utrif":"\u25B4","uuarr":"\u21C8","Uuml":"\u00DC","uuml":"\u00FC","uwangle":"\u29A7","vangrt":"\u299C","varepsilon":"\u03F5","varkappa":"\u03F0","varnothing":"\u2205","varphi":"\u03D5","varpi":"\u03D6","varpropto":"\u221D","varr":"\u2195","vArr":"\u21D5","varrho":"\u03F1","varsigma":"\u03C2","varsubsetneq":"\u228A\uFE00","varsubsetneqq":"\u2ACB\uFE00","varsupsetneq":"\u228B\uFE00","varsupsetneqq":"\u2ACC\uFE00","vartheta":"\u03D1","vartriangleleft":"\u22B2","vartriangleright":"\u22B3","vBar":"\u2AE8","Vbar":"\u2AEB","vBarv":"\u2AE9","Vcy":"\u0412","vcy":"\u0432","vdash":"\u22A2","vDash":"\u22A8","Vdash":"\u22A9","VDash":"\u22AB","Vdashl":"\u2AE6","veebar":"\u22BB","vee":"\u2228","Vee":"\u22C1","veeeq":"\u225A","vellip":"\u22EE","verbar":"|","Verbar":"\u2016","vert":"|","Vert":"\u2016","VerticalBar":"\u2223","VerticalLine":"|","VerticalSeparator":"\u2758","VerticalTilde":"\u2240","VeryThinSpace":"\u200A","Vfr":"\uD835\uDD19","vfr":"\uD835\uDD33","vltri":"\u22B2","vnsub":"\u2282\u20D2","vnsup":"\u2283\u20D2","Vopf":"\uD835\uDD4D","vopf":"\uD835\uDD67","vprop":"\u221D","vrtri":"\u22B3","Vscr":"\uD835\uDCB1","vscr":"\uD835\uDCCB","vsubnE":"\u2ACB\uFE00","vsubne":"\u228A\uFE00","vsupnE":"\u2ACC\uFE00","vsupne":"\u228B\uFE00","Vvdash":"\u22AA","vzigzag":"\u299A","Wcirc":"\u0174","wcirc":"\u0175","wedbar":"\u2A5F","wedge":"\u2227","Wedge":"\u22C0","wedgeq":"\u2259","weierp":"\u2118","Wfr":"\uD835\uDD1A","wfr":"\uD835\uDD34","Wopf":"\uD835\uDD4E","wopf":"\uD835\uDD68","wp":"\u2118","wr":"\u2240","wreath":"\u2240","Wscr":"\uD835\uDCB2","wscr":"\uD835\uDCCC","xcap":"\u22C2","xcirc":"\u25EF","xcup":"\u22C3","xdtri":"\u25BD","Xfr":"\uD835\uDD1B","xfr":"\uD835\uDD35","xharr":"\u27F7","xhArr":"\u27FA","Xi":"\u039E","xi":"\u03BE","xlarr":"\u27F5","xlArr":"\u27F8","xmap":"\u27FC","xnis":"\u22FB","xodot":"\u2A00","Xopf":"\uD835\uDD4F","xopf":"\uD835\uDD69","xoplus":"\u2A01","xotime":"\u2A02","xrarr":"\u27F6","xrArr":"\u27F9","Xscr":"\uD835\uDCB3","xscr":"\uD835\uDCCD","xsqcup":"\u2A06","xuplus":"\u2A04","xutri":"\u25B3","xvee":"\u22C1","xwedge":"\u22C0","Yacute":"\u00DD","yacute":"\u00FD","YAcy":"\u042F","yacy":"\u044F","Ycirc":"\u0176","ycirc":"\u0177","Ycy":"\u042B","ycy":"\u044B","yen":"\u00A5","Yfr":"\uD835\uDD1C","yfr":"\uD835\uDD36","YIcy":"\u0407","yicy":"\u0457","Yopf":"\uD835\uDD50","yopf":"\uD835\uDD6A","Yscr":"\uD835\uDCB4","yscr":"\uD835\uDCCE","YUcy":"\u042E","yucy":"\u044E","yuml":"\u00FF","Yuml":"\u0178","Zacute":"\u0179","zacute":"\u017A","Zcaron":"\u017D","zcaron":"\u017E","Zcy":"\u0417","zcy":"\u0437","Zdot":"\u017B","zdot":"\u017C","zeetrf":"\u2128","ZeroWidthSpace":"\u200B","Zeta":"\u0396","zeta":"\u03B6","zfr":"\uD835\uDD37","Zfr":"\u2128","ZHcy":"\u0416","zhcy":"\u0436","zigrarr":"\u21DD","zopf":"\uD835\uDD6B","Zopf":"\u2124","Zscr":"\uD835\uDCB5","zscr":"\uD835\uDCCF","zwj":"\u200D","zwnj":"\u200C"};

return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/entities/maps/legacy.json'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/entities/maps/legacy.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {"Aacute":"\u00C1","aacute":"\u00E1","Acirc":"\u00C2","acirc":"\u00E2","acute":"\u00B4","AElig":"\u00C6","aelig":"\u00E6","Agrave":"\u00C0","agrave":"\u00E0","amp":"&","AMP":"&","Aring":"\u00C5","aring":"\u00E5","Atilde":"\u00C3","atilde":"\u00E3","Auml":"\u00C4","auml":"\u00E4","brvbar":"\u00A6","Ccedil":"\u00C7","ccedil":"\u00E7","cedil":"\u00B8","cent":"\u00A2","copy":"\u00A9","COPY":"\u00A9","curren":"\u00A4","deg":"\u00B0","divide":"\u00F7","Eacute":"\u00C9","eacute":"\u00E9","Ecirc":"\u00CA","ecirc":"\u00EA","Egrave":"\u00C8","egrave":"\u00E8","ETH":"\u00D0","eth":"\u00F0","Euml":"\u00CB","euml":"\u00EB","frac12":"\u00BD","frac14":"\u00BC","frac34":"\u00BE","gt":">","GT":">","Iacute":"\u00CD","iacute":"\u00ED","Icirc":"\u00CE","icirc":"\u00EE","iexcl":"\u00A1","Igrave":"\u00CC","igrave":"\u00EC","iquest":"\u00BF","Iuml":"\u00CF","iuml":"\u00EF","laquo":"\u00AB","lt":"<","LT":"<","macr":"\u00AF","micro":"\u00B5","middot":"\u00B7","nbsp":"\u00A0","not":"\u00AC","Ntilde":"\u00D1","ntilde":"\u00F1","Oacute":"\u00D3","oacute":"\u00F3","Ocirc":"\u00D4","ocirc":"\u00F4","Ograve":"\u00D2","ograve":"\u00F2","ordf":"\u00AA","ordm":"\u00BA","Oslash":"\u00D8","oslash":"\u00F8","Otilde":"\u00D5","otilde":"\u00F5","Ouml":"\u00D6","ouml":"\u00F6","para":"\u00B6","plusmn":"\u00B1","pound":"\u00A3","quot":"\"","QUOT":"\"","raquo":"\u00BB","reg":"\u00AE","REG":"\u00AE","sect":"\u00A7","shy":"\u00AD","sup1":"\u00B9","sup2":"\u00B2","sup3":"\u00B3","szlig":"\u00DF","THORN":"\u00DE","thorn":"\u00FE","times":"\u00D7","Uacute":"\u00DA","uacute":"\u00FA","Ucirc":"\u00DB","ucirc":"\u00FB","Ugrave":"\u00D9","ugrave":"\u00F9","uml":"\u00A8","Uuml":"\u00DC","uuml":"\u00FC","Yacute":"\u00DD","yacute":"\u00FD","yen":"\u00A5","yuml":"\u00FF"};

return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/entities/maps/xml.json'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/entities/maps/xml.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {"amp":"&","apos":"'","gt":">","lt":"<","quot":"\""}
;

return module.exports;
})();modules['../document/node_modules/htmlparser2/lib/Tokenizer.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/lib/Tokenizer.js"]};
var require = getModule.bind(null, {"entities/lib/decode_codepoint.js":"../document/node_modules/htmlparser2/node_modules/entities/lib/decode_codepoint.js","entities/maps/entities.json":"../document/node_modules/htmlparser2/node_modules/entities/maps/entities.json","entities/maps/legacy.json":"../document/node_modules/htmlparser2/node_modules/entities/maps/legacy.json","entities/maps/xml.json":"../document/node_modules/htmlparser2/node_modules/entities/maps/xml.json"});
var exports = module.exports;

module.exports = Tokenizer;

var decodeCodePoint = require("entities/lib/decode_codepoint.js"),
    entityMap = require("entities/maps/entities.json"),
    legacyMap = require("entities/maps/legacy.json"),
    xmlMap    = require("entities/maps/xml.json"),

    i = 0,

    TEXT                      = i++,
    BEFORE_TAG_NAME           = i++, //after <
    IN_TAG_NAME               = i++,
    IN_SELF_CLOSING_TAG       = i++,
    BEFORE_CLOSING_TAG_NAME   = i++,
    IN_CLOSING_TAG_NAME       = i++,
    AFTER_CLOSING_TAG_NAME    = i++,

    //attributes
    BEFORE_ATTRIBUTE_NAME     = i++,
    IN_ATTRIBUTE_NAME         = i++,
    AFTER_ATTRIBUTE_NAME      = i++,
    BEFORE_ATTRIBUTE_VALUE    = i++,
    IN_ATTRIBUTE_VALUE_DQ     = i++, // "
    IN_ATTRIBUTE_VALUE_SQ     = i++, // '
    IN_ATTRIBUTE_VALUE_NQ     = i++,

    //declarations
    BEFORE_DECLARATION        = i++, // !
    IN_DECLARATION            = i++,

    //processing instructions
    IN_PROCESSING_INSTRUCTION = i++, // ?

    //comments
    BEFORE_COMMENT            = i++,
    IN_COMMENT                = i++,
    AFTER_COMMENT_1           = i++,
    AFTER_COMMENT_2           = i++,

    //cdata
    BEFORE_CDATA_1            = i++, // [
    BEFORE_CDATA_2            = i++, // C
    BEFORE_CDATA_3            = i++, // D
    BEFORE_CDATA_4            = i++, // A
    BEFORE_CDATA_5            = i++, // T
    BEFORE_CDATA_6            = i++, // A
    IN_CDATA                  = i++, // [
    AFTER_CDATA_1             = i++, // ]
    AFTER_CDATA_2             = i++, // ]

    //special tags
    BEFORE_SPECIAL            = i++, //S
    BEFORE_SPECIAL_END        = i++,   //S

    BEFORE_SCRIPT_1           = i++, //C
    BEFORE_SCRIPT_2           = i++, //R
    BEFORE_SCRIPT_3           = i++, //I
    BEFORE_SCRIPT_4           = i++, //P
    BEFORE_SCRIPT_5           = i++, //T
    AFTER_SCRIPT_1            = i++, //C
    AFTER_SCRIPT_2            = i++, //R
    AFTER_SCRIPT_3            = i++, //I
    AFTER_SCRIPT_4            = i++, //P
    AFTER_SCRIPT_5            = i++, //T

    BEFORE_STYLE_1            = i++, //T
    BEFORE_STYLE_2            = i++, //Y
    BEFORE_STYLE_3            = i++, //L
    BEFORE_STYLE_4            = i++, //E
    AFTER_STYLE_1             = i++, //T
    AFTER_STYLE_2             = i++, //Y
    AFTER_STYLE_3             = i++, //L
    AFTER_STYLE_4             = i++, //E

    BEFORE_ENTITY             = i++, //&
    BEFORE_NUMERIC_ENTITY     = i++, //#
    IN_NAMED_ENTITY           = i++,
    IN_NUMERIC_ENTITY         = i++,
    IN_HEX_ENTITY             = i++, //X

    j = 0,

    SPECIAL_NONE              = j++,
    SPECIAL_SCRIPT            = j++,
    SPECIAL_STYLE             = j++;

function whitespace(c){
	return c === " " || c === "\n" || c === "\t" || c === "\f" || c === "\r";
}

function characterState(char, SUCCESS){
	return function(c){
		if(c === char) this._state = SUCCESS;
	};
}

function ifElseState(upper, SUCCESS, FAILURE){
	var lower = upper.toLowerCase();

	if(upper === lower){
		return function(c){
			if(c === lower){
				this._state = SUCCESS;
			} else {
				this._state = FAILURE;
				this._index--;
			}
		};
	} else {
		return function(c){
			if(c === lower || c === upper){
				this._state = SUCCESS;
			} else {
				this._state = FAILURE;
				this._index--;
			}
		};
	}
}

function consumeSpecialNameChar(upper, NEXT_STATE){
	var lower = upper.toLowerCase();

	return function(c){
		if(c === lower || c === upper){
			this._state = NEXT_STATE;
		} else {
			this._state = IN_TAG_NAME;
			this._index--; //consume the token again
		}
	};
}

function Tokenizer(options, cbs){
	this._state = TEXT;
	this._buffer = "";
	this._sectionStart = 0;
	this._index = 0;
	this._bufferOffset = 0; //chars removed from _buffer
	this._baseState = TEXT;
	this._special = SPECIAL_NONE;
	this._cbs = cbs;
	this._running = true;
	this._ended = false;
	this._xmlMode = !!(options && options.xmlMode);
	this._decodeEntities = !!(options && options.decodeEntities);
}

Tokenizer.prototype._stateText = function(c){
	if(c === "<"){
		if(this._index > this._sectionStart){
			this._cbs.ontext(this._getSection());
		}
		this._state = BEFORE_TAG_NAME;
		this._sectionStart = this._index;
	} else if(this._decodeEntities && this._special === SPECIAL_NONE && c === "&"){
		if(this._index > this._sectionStart){
			this._cbs.ontext(this._getSection());
		}
		this._baseState = TEXT;
		this._state = BEFORE_ENTITY;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateBeforeTagName = function(c){
	if(c === "/"){
		this._state = BEFORE_CLOSING_TAG_NAME;
	} else if(c === ">" || this._special !== SPECIAL_NONE || whitespace(c)) {
		this._state = TEXT;
	} else if(c === "!"){
		this._state = BEFORE_DECLARATION;
		this._sectionStart = this._index + 1;
	} else if(c === "?"){
		this._state = IN_PROCESSING_INSTRUCTION;
		this._sectionStart = this._index + 1;
	} else if(c === "<"){
		this._cbs.ontext(this._getSection());
		this._sectionStart = this._index;
	} else {
		this._state = (!this._xmlMode && (c === "s" || c === "S")) ?
						BEFORE_SPECIAL : IN_TAG_NAME;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateInTagName = function(c){
	if(c === "/" || c === ">" || whitespace(c)){
		this._emitToken("onopentagname");
		this._state = BEFORE_ATTRIBUTE_NAME;
		this._index--;
	}
};

Tokenizer.prototype._stateBeforeCloseingTagName = function(c){
	if(whitespace(c));
	else if(c === ">"){
		this._state = TEXT;
	} else if(this._special !== SPECIAL_NONE){
		if(c === "s" || c === "S"){
			this._state = BEFORE_SPECIAL_END;
		} else {
			this._state = TEXT;
			this._index--;
		}
	} else {
		this._state = IN_CLOSING_TAG_NAME;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateInCloseingTagName = function(c){
	if(c === ">" || whitespace(c)){
		this._emitToken("onclosetag");
		this._state = AFTER_CLOSING_TAG_NAME;
		this._index--;
	}
};

Tokenizer.prototype._stateAfterCloseingTagName = function(c){
	//skip everything until ">"
	if(c === ">"){
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	}
};

Tokenizer.prototype._stateBeforeAttributeName = function(c){
	if(c === ">"){
		this._cbs.onopentagend();
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	} else if(c === "/"){
		this._state = IN_SELF_CLOSING_TAG;
	} else if(!whitespace(c)){
		this._state = IN_ATTRIBUTE_NAME;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateInSelfClosingTag = function(c){
	if(c === ">"){
		this._cbs.onselfclosingtag();
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	} else if(!whitespace(c)){
		this._state = BEFORE_ATTRIBUTE_NAME;
		this._index--;
	}
};

Tokenizer.prototype._stateInAttributeName = function(c){
	if(c === "=" || c === "/" || c === ">" || whitespace(c)){
		this._cbs.onattribname(this._getSection());
		this._sectionStart = -1;
		this._state = AFTER_ATTRIBUTE_NAME;
		this._index--;
	}
};

Tokenizer.prototype._stateAfterAttributeName = function(c){
	if(c === "="){
		this._state = BEFORE_ATTRIBUTE_VALUE;
	} else if(c === "/" || c === ">"){
		this._cbs.onattribend();
		this._state = BEFORE_ATTRIBUTE_NAME;
		this._index--;
	} else if(!whitespace(c)){
		this._cbs.onattribend();
		this._state = IN_ATTRIBUTE_NAME;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateBeforeAttributeValue = function(c){
	if(c === "\""){
		this._state = IN_ATTRIBUTE_VALUE_DQ;
		this._sectionStart = this._index + 1;
	} else if(c === "'"){
		this._state = IN_ATTRIBUTE_VALUE_SQ;
		this._sectionStart = this._index + 1;
	} else if(!whitespace(c)){
		this._state = IN_ATTRIBUTE_VALUE_NQ;
		this._sectionStart = this._index;
		this._index--; //reconsume token
	}
};

Tokenizer.prototype._stateInAttributeValueDoubleQuotes = function(c){
	if(c === "\""){
		this._emitToken("onattribdata");
		this._cbs.onattribend();
		this._state = BEFORE_ATTRIBUTE_NAME;
	} else if(this._decodeEntities && c === "&"){
		this._emitToken("onattribdata");
		this._baseState = this._state;
		this._state = BEFORE_ENTITY;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateInAttributeValueSingleQuotes = function(c){
	if(c === "'"){
		this._emitToken("onattribdata");
		this._cbs.onattribend();
		this._state = BEFORE_ATTRIBUTE_NAME;
	} else if(this._decodeEntities && c === "&"){
		this._emitToken("onattribdata");
		this._baseState = this._state;
		this._state = BEFORE_ENTITY;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateInAttributeValueNoQuotes = function(c){
	if(whitespace(c) || c === ">"){
		this._emitToken("onattribdata");
		this._cbs.onattribend();
		this._state = BEFORE_ATTRIBUTE_NAME;
		this._index--;
	} else if(this._decodeEntities && c === "&"){
		this._emitToken("onattribdata");
		this._baseState = this._state;
		this._state = BEFORE_ENTITY;
		this._sectionStart = this._index;
	}
};

Tokenizer.prototype._stateBeforeDeclaration = function(c){
	this._state = c === "[" ? BEFORE_CDATA_1 :
					c === "-" ? BEFORE_COMMENT :
						IN_DECLARATION;
};

Tokenizer.prototype._stateInDeclaration = function(c){
	if(c === ">"){
		this._cbs.ondeclaration(this._getSection());
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	}
};

Tokenizer.prototype._stateInProcessingInstruction = function(c){
	if(c === ">"){
		this._cbs.onprocessinginstruction(this._getSection());
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	}
};

Tokenizer.prototype._stateBeforeComment = function(c){
	if(c === "-"){
		this._state = IN_COMMENT;
		this._sectionStart = this._index + 1;
	} else {
		this._state = IN_DECLARATION;
	}
};

Tokenizer.prototype._stateInComment = function(c){
	if(c === "-") this._state = AFTER_COMMENT_1;
};

Tokenizer.prototype._stateAfterComment1 = function(c){
	if(c === "-"){
		this._state = AFTER_COMMENT_2;
	} else {
		this._state = IN_COMMENT;
	}
};

Tokenizer.prototype._stateAfterComment2 = function(c){
	if(c === ">"){
		//remove 2 trailing chars
		this._cbs.oncomment(this._buffer.substring(this._sectionStart, this._index - 2));
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	} else if(c !== "-"){
		this._state = IN_COMMENT;
	}
	// else: stay in AFTER_COMMENT_2 (`--->`)
};

Tokenizer.prototype._stateBeforeCdata1 = ifElseState("C", BEFORE_CDATA_2, IN_DECLARATION);
Tokenizer.prototype._stateBeforeCdata2 = ifElseState("D", BEFORE_CDATA_3, IN_DECLARATION);
Tokenizer.prototype._stateBeforeCdata3 = ifElseState("A", BEFORE_CDATA_4, IN_DECLARATION);
Tokenizer.prototype._stateBeforeCdata4 = ifElseState("T", BEFORE_CDATA_5, IN_DECLARATION);
Tokenizer.prototype._stateBeforeCdata5 = ifElseState("A", BEFORE_CDATA_6, IN_DECLARATION);

Tokenizer.prototype._stateBeforeCdata6 = function(c){
	if(c === "["){
		this._state = IN_CDATA;
		this._sectionStart = this._index + 1;
	} else {
		this._state = IN_DECLARATION;
		this._index--;
	}
};

Tokenizer.prototype._stateInCdata = function(c){
	if(c === "]") this._state = AFTER_CDATA_1;
};

Tokenizer.prototype._stateAfterCdata1 = characterState("]", AFTER_CDATA_2);

Tokenizer.prototype._stateAfterCdata2 = function(c){
	if(c === ">"){
		//remove 2 trailing chars
		this._cbs.oncdata(this._buffer.substring(this._sectionStart, this._index - 2));
		this._state = TEXT;
		this._sectionStart = this._index + 1;
	} else if(c !== "]") {
		this._state = IN_CDATA;
	}
	//else: stay in AFTER_CDATA_2 (`]]]>`)
};

Tokenizer.prototype._stateBeforeSpecial = function(c){
	if(c === "c" || c === "C"){
		this._state = BEFORE_SCRIPT_1;
	} else if(c === "t" || c === "T"){
		this._state = BEFORE_STYLE_1;
	} else {
		this._state = IN_TAG_NAME;
		this._index--; //consume the token again
	}
};

Tokenizer.prototype._stateBeforeSpecialEnd = function(c){
	if(this._special === SPECIAL_SCRIPT && (c === "c" || c === "C")){
		this._state = AFTER_SCRIPT_1;
	} else if(this._special === SPECIAL_STYLE && (c === "t" || c === "T")){
		this._state = AFTER_STYLE_1;
	}
	else this._state = TEXT;
};

Tokenizer.prototype._stateBeforeScript1 = consumeSpecialNameChar("R", BEFORE_SCRIPT_2);
Tokenizer.prototype._stateBeforeScript2 = consumeSpecialNameChar("I", BEFORE_SCRIPT_3);
Tokenizer.prototype._stateBeforeScript3 = consumeSpecialNameChar("P", BEFORE_SCRIPT_4);
Tokenizer.prototype._stateBeforeScript4 = consumeSpecialNameChar("T", BEFORE_SCRIPT_5);

Tokenizer.prototype._stateBeforeScript5 = function(c){
	if(c === "/" || c === ">" || whitespace(c)){
		this._special = SPECIAL_SCRIPT;
	}
	this._state = IN_TAG_NAME;
	this._index--; //consume the token again
};

Tokenizer.prototype._stateAfterScript1 = ifElseState("R", AFTER_SCRIPT_2, TEXT);
Tokenizer.prototype._stateAfterScript2 = ifElseState("I", AFTER_SCRIPT_3, TEXT);
Tokenizer.prototype._stateAfterScript3 = ifElseState("P", AFTER_SCRIPT_4, TEXT);
Tokenizer.prototype._stateAfterScript4 = ifElseState("T", AFTER_SCRIPT_5, TEXT);

Tokenizer.prototype._stateAfterScript5 = function(c){
	if(c === ">" || whitespace(c)){
		this._special = SPECIAL_NONE;
		this._state = IN_CLOSING_TAG_NAME;
		this._sectionStart = this._index - 6;
		this._index--; //reconsume the token
	}
	else this._state = TEXT;
};

Tokenizer.prototype._stateBeforeStyle1 = consumeSpecialNameChar("Y", BEFORE_STYLE_2);
Tokenizer.prototype._stateBeforeStyle2 = consumeSpecialNameChar("L", BEFORE_STYLE_3);
Tokenizer.prototype._stateBeforeStyle3 = consumeSpecialNameChar("E", BEFORE_STYLE_4);

Tokenizer.prototype._stateBeforeStyle4 = function(c){
	if(c === "/" || c === ">" || whitespace(c)){
		this._special = SPECIAL_STYLE;
	}
	this._state = IN_TAG_NAME;
	this._index--; //consume the token again
};

Tokenizer.prototype._stateAfterStyle1 = ifElseState("Y", AFTER_STYLE_2, TEXT);
Tokenizer.prototype._stateAfterStyle2 = ifElseState("L", AFTER_STYLE_3, TEXT);
Tokenizer.prototype._stateAfterStyle3 = ifElseState("E", AFTER_STYLE_4, TEXT);

Tokenizer.prototype._stateAfterStyle4 = function(c){
	if(c === ">" || whitespace(c)){
		this._special = SPECIAL_NONE;
		this._state = IN_CLOSING_TAG_NAME;
		this._sectionStart = this._index - 5;
		this._index--; //reconsume the token
	}
	else this._state = TEXT;
};

Tokenizer.prototype._stateBeforeEntity = ifElseState("#", BEFORE_NUMERIC_ENTITY, IN_NAMED_ENTITY);
Tokenizer.prototype._stateBeforeNumericEntity = ifElseState("X", IN_HEX_ENTITY, IN_NUMERIC_ENTITY);

//for entities terminated with a semicolon
Tokenizer.prototype._parseNamedEntityStrict = function(){
	//offset = 1
	if(this._sectionStart + 1 < this._index){
		var entity = this._buffer.substring(this._sectionStart + 1, this._index),
		    map = this._xmlMode ? xmlMap : entityMap;

		if(map.hasOwnProperty(entity)){
			this._emitPartial(map[entity]);
			this._sectionStart = this._index + 1;
		}
	}
};


//parses legacy entities (without trailing semicolon)
Tokenizer.prototype._parseLegacyEntity = function(){
	var start = this._sectionStart + 1,
	    limit = this._index - start;

	if(limit > 6) limit = 6; //the max length of legacy entities is 6

	while(limit >= 2){ //the min length of legacy entities is 2
		var entity = this._buffer.substr(start, limit);

		if(legacyMap.hasOwnProperty(entity)){
			this._emitPartial(legacyMap[entity]);
			this._sectionStart += limit + 1;
			return;
		} else {
			limit--;
		}
	}
};

Tokenizer.prototype._stateInNamedEntity = function(c){
	if(c === ";"){
		this._parseNamedEntityStrict();
		if(this._sectionStart + 1 < this._index && !this._xmlMode){
			this._parseLegacyEntity();
		}
		this._state = this._baseState;
	} else if((c < "a" || c > "z") && (c < "A" || c > "Z") && (c < "0" || c > "9")){
		if(this._xmlMode);
		else if(this._sectionStart + 1 === this._index);
		else if(this._baseState !== TEXT){
			if(c !== "="){
				this._parseNamedEntityStrict();
			}
		} else {
			this._parseLegacyEntity();
		}

		this._state = this._baseState;
		this._index--;
	}
};

Tokenizer.prototype._decodeNumericEntity = function(offset, base){
	var sectionStart = this._sectionStart + offset;

	if(sectionStart !== this._index){
		//parse entity
		var entity = this._buffer.substring(sectionStart, this._index);
		var parsed = parseInt(entity, base);

		this._emitPartial(decodeCodePoint(parsed));
		this._sectionStart = this._index;
	} else {
		this._sectionStart--;
	}

	this._state = this._baseState;
};

Tokenizer.prototype._stateInNumericEntity = function(c){
	if(c === ";"){
		this._decodeNumericEntity(2, 10);
		this._sectionStart++;
	} else if(c < "0" || c > "9"){
		if(!this._xmlMode){
			this._decodeNumericEntity(2, 10);
		} else {
			this._state = this._baseState;
		}
		this._index--;
	}
};

Tokenizer.prototype._stateInHexEntity = function(c){
	if(c === ";"){
		this._decodeNumericEntity(3, 16);
		this._sectionStart++;
	} else if((c < "a" || c > "f") && (c < "A" || c > "F") && (c < "0" || c > "9")){
		if(!this._xmlMode){
			this._decodeNumericEntity(3, 16);
		} else {
			this._state = this._baseState;
		}
		this._index--;
	}
};

Tokenizer.prototype._cleanup = function (){
	if(this._sectionStart < 0){
		this._buffer = "";
		this._index = 0;
		this._bufferOffset += this._index;
	} else if(this._running){
		if(this._state === TEXT){
			if(this._sectionStart !== this._index){
				this._cbs.ontext(this._buffer.substr(this._sectionStart));
			}
			this._buffer = "";
			this._index = 0;
			this._bufferOffset += this._index;
		} else if(this._sectionStart === this._index){
			//the section just started
			this._buffer = "";
			this._index = 0;
			this._bufferOffset += this._index;
		} else {
			//remove everything unnecessary
			this._buffer = this._buffer.substr(this._sectionStart);
			this._index -= this._sectionStart;
			this._bufferOffset += this._sectionStart;
		}

		this._sectionStart = 0;
	}
};

//TODO make events conditional
Tokenizer.prototype.write = function(chunk){
	if(this._ended) this._cbs.onerror(Error(".write() after done!"));

	this._buffer += chunk;
	this._parse();
};

Tokenizer.prototype._parse = function(){
	while(this._index < this._buffer.length && this._running){
		var c = this._buffer.charAt(this._index);
		if(this._state === TEXT) {
			this._stateText(c);
		} else if(this._state === BEFORE_TAG_NAME){
			this._stateBeforeTagName(c);
		} else if(this._state === IN_TAG_NAME) {
			this._stateInTagName(c);
		} else if(this._state === BEFORE_CLOSING_TAG_NAME){
			this._stateBeforeCloseingTagName(c);
		} else if(this._state === IN_CLOSING_TAG_NAME){
			this._stateInCloseingTagName(c);
		} else if(this._state === AFTER_CLOSING_TAG_NAME){
			this._stateAfterCloseingTagName(c);
		} else if(this._state === IN_SELF_CLOSING_TAG){
			this._stateInSelfClosingTag(c);
		}

		/*
		*	attributes
		*/
		else if(this._state === BEFORE_ATTRIBUTE_NAME){
			this._stateBeforeAttributeName(c);
		} else if(this._state === IN_ATTRIBUTE_NAME){
			this._stateInAttributeName(c);
		} else if(this._state === AFTER_ATTRIBUTE_NAME){
			this._stateAfterAttributeName(c);
		} else if(this._state === BEFORE_ATTRIBUTE_VALUE){
			this._stateBeforeAttributeValue(c);
		} else if(this._state === IN_ATTRIBUTE_VALUE_DQ){
			this._stateInAttributeValueDoubleQuotes(c);
		} else if(this._state === IN_ATTRIBUTE_VALUE_SQ){
			this._stateInAttributeValueSingleQuotes(c);
		} else if(this._state === IN_ATTRIBUTE_VALUE_NQ){
			this._stateInAttributeValueNoQuotes(c);
		}

		/*
		*	declarations
		*/
		else if(this._state === BEFORE_DECLARATION){
			this._stateBeforeDeclaration(c);
		} else if(this._state === IN_DECLARATION){
			this._stateInDeclaration(c);
		}

		/*
		*	processing instructions
		*/
		else if(this._state === IN_PROCESSING_INSTRUCTION){
			this._stateInProcessingInstruction(c);
		}

		/*
		*	comments
		*/
		else if(this._state === BEFORE_COMMENT){
			this._stateBeforeComment(c);
		} else if(this._state === IN_COMMENT){
			this._stateInComment(c);
		} else if(this._state === AFTER_COMMENT_1){
			this._stateAfterComment1(c);
		} else if(this._state === AFTER_COMMENT_2){
			this._stateAfterComment2(c);
		}

		/*
		*	cdata
		*/
		else if(this._state === BEFORE_CDATA_1){
			this._stateBeforeCdata1(c);
		} else if(this._state === BEFORE_CDATA_2){
			this._stateBeforeCdata2(c);
		} else if(this._state === BEFORE_CDATA_3){
			this._stateBeforeCdata3(c);
		} else if(this._state === BEFORE_CDATA_4){
			this._stateBeforeCdata4(c);
		} else if(this._state === BEFORE_CDATA_5){
			this._stateBeforeCdata5(c);
		} else if(this._state === BEFORE_CDATA_6){
			this._stateBeforeCdata6(c);
		} else if(this._state === IN_CDATA){
			this._stateInCdata(c);
		} else if(this._state === AFTER_CDATA_1){
			this._stateAfterCdata1(c);
		} else if(this._state === AFTER_CDATA_2){
			this._stateAfterCdata2(c);
		}

		/*
		* special tags
		*/
		else if(this._state === BEFORE_SPECIAL){
			this._stateBeforeSpecial(c);
		} else if(this._state === BEFORE_SPECIAL_END){
			this._stateBeforeSpecialEnd(c);
		}

		/*
		* script
		*/
		else if(this._state === BEFORE_SCRIPT_1){
			this._stateBeforeScript1(c);
		} else if(this._state === BEFORE_SCRIPT_2){
			this._stateBeforeScript2(c);
		} else if(this._state === BEFORE_SCRIPT_3){
			this._stateBeforeScript3(c);
		} else if(this._state === BEFORE_SCRIPT_4){
			this._stateBeforeScript4(c);
		} else if(this._state === BEFORE_SCRIPT_5){
			this._stateBeforeScript5(c);
		}

		else if(this._state === AFTER_SCRIPT_1){
			this._stateAfterScript1(c);
		} else if(this._state === AFTER_SCRIPT_2){
			this._stateAfterScript2(c);
		} else if(this._state === AFTER_SCRIPT_3){
			this._stateAfterScript3(c);
		} else if(this._state === AFTER_SCRIPT_4){
			this._stateAfterScript4(c);
		} else if(this._state === AFTER_SCRIPT_5){
			this._stateAfterScript5(c);
		}

		/*
		* style
		*/
		else if(this._state === BEFORE_STYLE_1){
			this._stateBeforeStyle1(c);
		} else if(this._state === BEFORE_STYLE_2){
			this._stateBeforeStyle2(c);
		} else if(this._state === BEFORE_STYLE_3){
			this._stateBeforeStyle3(c);
		} else if(this._state === BEFORE_STYLE_4){
			this._stateBeforeStyle4(c);
		}

		else if(this._state === AFTER_STYLE_1){
			this._stateAfterStyle1(c);
		} else if(this._state === AFTER_STYLE_2){
			this._stateAfterStyle2(c);
		} else if(this._state === AFTER_STYLE_3){
			this._stateAfterStyle3(c);
		} else if(this._state === AFTER_STYLE_4){
			this._stateAfterStyle4(c);
		}

		/*
		* entities
		*/
		else if(this._state === BEFORE_ENTITY){
			this._stateBeforeEntity(c);
		} else if(this._state === BEFORE_NUMERIC_ENTITY){
			this._stateBeforeNumericEntity(c);
		} else if(this._state === IN_NAMED_ENTITY){
			this._stateInNamedEntity(c);
		} else if(this._state === IN_NUMERIC_ENTITY){
			this._stateInNumericEntity(c);
		} else if(this._state === IN_HEX_ENTITY){
			this._stateInHexEntity(c);
		}

		else {
			this._cbs.onerror(Error("unknown _state"), this._state);
		}

		this._index++;
	}

	this._cleanup();
};

Tokenizer.prototype.pause = function(){
	this._running = false;
};
Tokenizer.prototype.resume = function(){
	this._running = true;

	if(this._index < this._buffer.length){
		this._parse();
	}
	if(this._ended){
		this._finish();
	}
};

Tokenizer.prototype.end = function(chunk){
	if(this._ended) this._cbs.onerror(Error(".end() after done!"));
	if(chunk) this.write(chunk);

	this._ended = true;

	if(this._running) this._finish();
};

Tokenizer.prototype._finish = function(){
	//if there is remaining data, emit it in a reasonable way
	if(this._sectionStart < this._index){
		this._handleTrailingData();
	}

	this._cbs.onend();
};

Tokenizer.prototype._handleTrailingData = function(){
	var data = this._buffer.substr(this._sectionStart);

	if(this._state === IN_CDATA || this._state === AFTER_CDATA_1 || this._state === AFTER_CDATA_2){
		this._cbs.oncdata(data);
	} else if(this._state === IN_COMMENT || this._state === AFTER_COMMENT_1 || this._state === AFTER_COMMENT_2){
		this._cbs.oncomment(data);
	} else if(this._state === IN_NAMED_ENTITY && !this._xmlMode){
		this._parseLegacyEntity();
		if(this._sectionStart < this._index){
			this._state = this._baseState;
			this._handleTrailingData();
		}
	} else if(this._state === IN_NUMERIC_ENTITY && !this._xmlMode){
		this._decodeNumericEntity(2, 10);
		if(this._sectionStart < this._index){
			this._state = this._baseState;
			this._handleTrailingData();
		}
	} else if(this._state === IN_HEX_ENTITY && !this._xmlMode){
		this._decodeNumericEntity(3, 16);
		if(this._sectionStart < this._index){
			this._state = this._baseState;
			this._handleTrailingData();
		}
	} else if(
		this._state !== IN_TAG_NAME &&
		this._state !== BEFORE_ATTRIBUTE_NAME &&
		this._state !== BEFORE_ATTRIBUTE_VALUE &&
		this._state !== AFTER_ATTRIBUTE_NAME &&
		this._state !== IN_ATTRIBUTE_NAME &&
		this._state !== IN_ATTRIBUTE_VALUE_SQ &&
		this._state !== IN_ATTRIBUTE_VALUE_DQ &&
		this._state !== IN_ATTRIBUTE_VALUE_NQ &&
		this._state !== IN_CLOSING_TAG_NAME
	){
		this._cbs.ontext(data);
	}
	//else, ignore remaining data
	//TODO add a way to remove current tag
};

Tokenizer.prototype.reset = function(){
	Tokenizer.call(this, {xmlMode: this._xmlMode, decodeEntities: this._decodeEntities}, this._cbs);
};

Tokenizer.prototype.getAbsoluteIndex = function(){
	return this._bufferOffset + this._index;
};

Tokenizer.prototype._getSection = function(){
	return this._buffer.substring(this._sectionStart, this._index);
};

Tokenizer.prototype._emitToken = function(name){
	this._cbs[name](this._getSection());
	this._sectionStart = -1;
};

Tokenizer.prototype._emitPartial = function(value){
	if(this._baseState !== TEXT){
		this._cbs.onattribdata(value); //TODO implement the new event
	} else {
		this._cbs.ontext(value);
	}
};


return module.exports;
})();modules['../document/node_modules/htmlparser2/lib/Parser.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/lib/Parser.js"]};
var require = getModule.bind(null, {"./Tokenizer.js":"../document/node_modules/htmlparser2/lib/Tokenizer.js"});
var exports = module.exports;

var Tokenizer = require("./Tokenizer.js");

/*
	Options:

	xmlMode: Special behavior for script/style tags (true by default)
	lowerCaseAttributeNames: call .toLowerCase for each attribute name (true if xmlMode is `false`)
	lowerCaseTags: call .toLowerCase for each tag name (true if xmlMode is `false`)
*/

/*
	Callbacks:

	oncdataend,
	oncdatastart,
	onclosetag,
	oncomment,
	oncommentend,
	onerror,
	onopentag,
	onprocessinginstruction,
	onreset,
	ontext
*/

var formTags = {
	input: true,
	option: true,
	optgroup: true,
	select: true,
	button: true,
	datalist: true,
	textarea: true
};

var openImpliesClose = {
	tr      : { tr:true, th:true, td:true },
	th      : { th:true },
	td      : { thead:true, td:true },
	body    : { head:true, link:true, script:true },
	li      : { li:true },
	p       : { p:true },
	h1      : { p:true },
	h2      : { p:true },
	h3      : { p:true },
	h4      : { p:true },
	h5      : { p:true },
	h6      : { p:true },
	select  : formTags,
	input   : formTags,
	output  : formTags,
	button  : formTags,
	datalist: formTags,
	textarea: formTags,
	option  : { option:true },
	optgroup: { optgroup:true }
};

var voidElements = {
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
	wbr: true,

	//common self closing svg elements
	path: true,
	circle: true,
	ellipse: true,
	line: true,
	rect: true,
	use: true,
	stop: true,
	polyline: true,
	polygone: true
};

var re_nameEnd = /\s|\//;

function Parser(cbs, options){
	this._options = options || {};
	this._cbs = cbs || {};

	this._tagname = "";
	this._attribname = "";
	this._attribvalue = "";
	this._attribs = null;
	this._stack = [];

	this.startIndex = 0;
	this.endIndex = null;

	this._lowerCaseTagNames = "lowerCaseTags" in this._options ?
									!!this._options.lowerCaseTags :
									!this._options.xmlMode;
	this._lowerCaseAttributeNames = "lowerCaseAttributeNames" in this._options ?
									!!this._options.lowerCaseAttributeNames :
									!this._options.xmlMode;

	this._tokenizer = new Tokenizer(this._options, this);

	if(this._cbs.onparserinit) this._cbs.onparserinit(this);
}

require("util").inherits(Parser, require("events").EventEmitter);

Parser.prototype._updatePosition = function(initialOffset){
	if(this.endIndex === null){
		if(this._tokenizer._sectionStart <= initialOffset){
			this.startIndex = 0;
		} else {
			this.startIndex = this._tokenizer._sectionStart - initialOffset;
		}
	}
	else this.startIndex = this.endIndex + 1;
	this.endIndex = this._tokenizer.getAbsoluteIndex();
};

//Tokenizer event handlers
Parser.prototype.ontext = function(data){
	this._updatePosition(1);
	this.endIndex--;

	if(this._cbs.ontext) this._cbs.ontext(data);
};

Parser.prototype.onopentagname = function(name){
	if(this._lowerCaseTagNames){
		name = name.toLowerCase();
	}

	this._tagname = name;

	if(!this._options.xmlMode && name in openImpliesClose) {
		for(
			var el;
			(el = this._stack[this._stack.length - 1]) in openImpliesClose[name];
			this.onclosetag(el)
		);
	}

	if(this._options.xmlMode || !(name in voidElements)){
		this._stack.push(name);
	}

	if(this._cbs.onopentagname) this._cbs.onopentagname(name);
	if(this._cbs.onopentag) this._attribs = {};
};

Parser.prototype.onopentagend = function(){
	this._updatePosition(1);

	if(this._attribs){
		if(this._cbs.onopentag) this._cbs.onopentag(this._tagname, this._attribs);
		this._attribs = null;
	}

	if(!this._options.xmlMode && this._cbs.onclosetag && this._tagname in voidElements){
		this._cbs.onclosetag(this._tagname);
	}

	this._tagname = "";
};

Parser.prototype.onclosetag = function(name){
	this._updatePosition(1);

	if(this._lowerCaseTagNames){
		name = name.toLowerCase();
	}

	if(this._stack.length && (!(name in voidElements) || this._options.xmlMode)){
		var pos = this._stack.lastIndexOf(name);
		if(pos !== -1){
			if(this._cbs.onclosetag){
				pos = this._stack.length - pos;
				while(pos--) this._cbs.onclosetag(this._stack.pop());
			}
			else this._stack.length = pos;
		} else if(name === "p" && !this._options.xmlMode){
			this.onopentagname(name);
			this._closeCurrentTag();
		}
	} else if(!this._options.xmlMode && (name === "br" || name === "p")){
		this.onopentagname(name);
		this._closeCurrentTag();
	}
};

Parser.prototype.onselfclosingtag = function(){
	if(this._options.xmlMode || this._options.recognizeSelfClosing){
		this._closeCurrentTag();
	} else {
		this.onopentagend();
	}
};

Parser.prototype._closeCurrentTag = function(){
	var name = this._tagname;

	this.onopentagend();

	//self-closing tags will be on the top of the stack
	//(cheaper check than in onclosetag)
	if(this._stack[this._stack.length - 1] === name){
		if(this._cbs.onclosetag){
			this._cbs.onclosetag(name);
		}
		this._stack.pop();
	}
};

Parser.prototype.onattribname = function(name){
	if(this._lowerCaseAttributeNames){
		name = name.toLowerCase();
	}
	this._attribname = name;
};

Parser.prototype.onattribdata = function(value){
	this._attribvalue += value;
};

Parser.prototype.onattribend = function(){
	if(this._cbs.onattribute) this._cbs.onattribute(this._attribname, this._attribvalue);
	if(
		this._attribs &&
		!Object.prototype.hasOwnProperty.call(this._attribs, this._attribname)
	){
		this._attribs[this._attribname] = this._attribvalue;
	}
	this._attribname = "";
	this._attribvalue = "";
};

Parser.prototype._getInstructionName = function(value){
	var idx = value.search(re_nameEnd),
	    name = idx < 0 ? value : value.substr(0, idx);

	if(this._lowerCaseTagNames){
		name = name.toLowerCase();
	}

	return name;
};

Parser.prototype.ondeclaration = function(value){
	if(this._cbs.onprocessinginstruction){
		var name = this._getInstructionName(value);
		this._cbs.onprocessinginstruction("!" + name, "!" + value);
	}
};

Parser.prototype.onprocessinginstruction = function(value){
	if(this._cbs.onprocessinginstruction){
		var name = this._getInstructionName(value);
		this._cbs.onprocessinginstruction("?" + name, "?" + value);
	}
};

Parser.prototype.oncomment = function(value){
	this._updatePosition(4);

	if(this._cbs.oncomment) this._cbs.oncomment(value);
	if(this._cbs.oncommentend) this._cbs.oncommentend();
};

Parser.prototype.oncdata = function(value){
	this._updatePosition(1);

	if(this._options.xmlMode || this._options.recognizeCDATA){
		if(this._cbs.oncdatastart) this._cbs.oncdatastart();
		if(this._cbs.ontext) this._cbs.ontext(value);
		if(this._cbs.oncdataend) this._cbs.oncdataend();
	} else {
		this.oncomment("[CDATA[" + value + "]]");
	}
};

Parser.prototype.onerror = function(err){
	if(this._cbs.onerror) this._cbs.onerror(err);
};

Parser.prototype.onend = function(){
	if(this._cbs.onclosetag){
		for(
			var i = this._stack.length;
			i > 0;
			this._cbs.onclosetag(this._stack[--i])
		);
	}
	if(this._cbs.onend) this._cbs.onend();
};


//Resets the parser to a blank state, ready to parse a new HTML document
Parser.prototype.reset = function(){
	if(this._cbs.onreset) this._cbs.onreset();
	this._tokenizer.reset();

	this._tagname = "";
	this._attribname = "";
	this._attribs = null;
	this._stack = [];

	if(this._cbs.onparserinit) this._cbs.onparserinit(this);
};

//Parses a complete HTML document and pushes it to the handler
Parser.prototype.parseComplete = function(data){
	this.reset();
	this.end(data);
};

Parser.prototype.write = function(chunk){
	this._tokenizer.write(chunk);
};

Parser.prototype.end = function(chunk){
	this._tokenizer.end(chunk);
};

Parser.prototype.pause = function(){
	this._tokenizer.pause();
};

Parser.prototype.resume = function(){
	this._tokenizer.resume();
};

//alias for backwards compat
Parser.prototype.parseChunk = Parser.prototype.write;
Parser.prototype.done = Parser.prototype.end;

module.exports = Parser;


return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/domelementtype/index.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/domelementtype/index.js"]};
var require = getModule.bind(null, {});
var exports = module.exports;

//Types of elements found in the DOM
module.exports = {
	Text: "text", //Text
	Directive: "directive", //<? ... ?>
	Comment: "comment", //<!-- ... -->
	Script: "script", //<script> tags
	Style: "style", //<style> tags
	Tag: "tag", //Any tag
	CDATA: "cdata", //<![CDATA[ ... ]]>

	isTag: function(elem){
		return elem.type === "tag" || elem.type === "script" || elem.type === "style";
	}
};

return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/domhandler/lib/node.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/domhandler/lib/node.js"]};
var require = getModule.bind(null, {});
var exports = module.exports;

// This object will be used as the prototype for Nodes when creating a
// DOM-Level-1-compliant structure.
var NodePrototype = module.exports = {
	get firstChild() {
		var children = this.children;
		return children && children[0] || null;
	},
	get lastChild() {
		var children = this.children;
		return children && children[children.length - 1] || null;
	},
	get nodeType() {
		return nodeTypes[this.type] || nodeTypes.element;
	}
};

var domLvl1 = {
	tagName: "name",
	childNodes: "children",
	parentNode: "parent",
	previousSibling: "prev",
	nextSibling: "next",
	nodeValue: "data"
};

var nodeTypes = {
	element: 1,
	text: 3,
	cdata: 4,
	comment: 8
};

Object.keys(domLvl1).forEach(function(key) {
	var shorthand = domLvl1[key];
	Object.defineProperty(NodePrototype, key, {
		get: function() {
			return this[shorthand] || null;
		},
		set: function(val) {
			this[shorthand] = val;
			return val;
		}
	});
});


return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/domhandler/lib/element.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/domhandler/lib/element.js"]};
var require = getModule.bind(null, {"./node":"../document/node_modules/htmlparser2/node_modules/domhandler/lib/node.js"});
var exports = module.exports;

// DOM-Level-1-compliant structure
var NodePrototype = require('./node');
var ElementPrototype = module.exports = Object.create(NodePrototype);

var domLvl1 = {
	tagName: "name"
};

Object.keys(domLvl1).forEach(function(key) {
	var shorthand = domLvl1[key];
	Object.defineProperty(ElementPrototype, key, {
		get: function() {
			return this[shorthand] || null;
		},
		set: function(val) {
			this[shorthand] = val;
			return val;
		}
	});
});


return module.exports;
})();modules['../document/node_modules/htmlparser2/node_modules/domhandler/index.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/node_modules/domhandler/index.js"]};
var require = getModule.bind(null, {"domelementtype":"../document/node_modules/htmlparser2/node_modules/domelementtype/index.js","./lib/node":"../document/node_modules/htmlparser2/node_modules/domhandler/lib/node.js","./lib/element":"../document/node_modules/htmlparser2/node_modules/domhandler/lib/element.js"});
var exports = module.exports;

var ElementType = require("domelementtype");

var re_whitespace = /\s+/g;
var NodePrototype = require("./lib/node");
var ElementPrototype = require("./lib/element");

function DomHandler(callback, options, elementCB){
	if(typeof callback === "object"){
		elementCB = options;
		options = callback;
		callback = null;
	} else if(typeof options === "function"){
		elementCB = options;
		options = defaultOpts;
	}
	this._callback = callback;
	this._options = options || defaultOpts;
	this._elementCB = elementCB;
	this.dom = [];
	this._done = false;
	this._tagStack = [];
	this._parser = this._parser || null;
}

//default options
var defaultOpts = {
	normalizeWhitespace: false, //Replace all whitespace with single spaces
	withStartIndices: false, //Add startIndex properties to nodes
};

DomHandler.prototype.onparserinit = function(parser){
	this._parser = parser;
};

//Resets the handler back to starting state
DomHandler.prototype.onreset = function(){
	DomHandler.call(this, this._callback, this._options, this._elementCB);
};

//Signals the handler that parsing is done
DomHandler.prototype.onend = function(){
	if(this._done) return;
	this._done = true;
	this._parser = null;
	this._handleCallback(null);
};

DomHandler.prototype._handleCallback =
DomHandler.prototype.onerror = function(error){
	if(typeof this._callback === "function"){
		this._callback(error, this.dom);
	} else {
		if(error) throw error;
	}
};

DomHandler.prototype.onclosetag = function(){
	//if(this._tagStack.pop().name !== name) this._handleCallback(Error("Tagname didn't match!"));
	var elem = this._tagStack.pop();
	if(this._elementCB) this._elementCB(elem);
};

DomHandler.prototype._addDomElement = function(element){
	var parent = this._tagStack[this._tagStack.length - 1];
	var siblings = parent ? parent.children : this.dom;
	var previousSibling = siblings[siblings.length - 1];

	element.next = null;

	if(this._options.withStartIndices){
		element.startIndex = this._parser.startIndex;
	}

	if (this._options.withDomLvl1) {
		element.__proto__ = element.type === "tag" ? ElementPrototype : NodePrototype;
	}

	if(previousSibling){
		element.prev = previousSibling;
		previousSibling.next = element;
	} else {
		element.prev = null;
	}

	siblings.push(element);
	element.parent = parent || null;
};

DomHandler.prototype.onopentag = function(name, attribs){
	var element = {
		type: name === "script" ? ElementType.Script : name === "style" ? ElementType.Style : ElementType.Tag,
		name: name,
		attribs: attribs,
		children: []
	};

	this._addDomElement(element);

	this._tagStack.push(element);
};

DomHandler.prototype.ontext = function(data){
	//the ignoreWhitespace is officially dropped, but for now,
	//it's an alias for normalizeWhitespace
	var normalize = this._options.normalizeWhitespace || this._options.ignoreWhitespace;

	var lastTag;

	if(!this._tagStack.length && this.dom.length && (lastTag = this.dom[this.dom.length-1]).type === ElementType.Text){
		if(normalize){
			lastTag.data = (lastTag.data + data).replace(re_whitespace, " ");
		} else {
			lastTag.data += data;
		}
	} else {
		if(
			this._tagStack.length &&
			(lastTag = this._tagStack[this._tagStack.length - 1]) &&
			(lastTag = lastTag.children[lastTag.children.length - 1]) &&
			lastTag.type === ElementType.Text
		){
			if(normalize){
				lastTag.data = (lastTag.data + data).replace(re_whitespace, " ");
			} else {
				lastTag.data += data;
			}
		} else {
			if(normalize){
				data = data.replace(re_whitespace, " ");
			}

			this._addDomElement({
				data: data,
				type: ElementType.Text
			});
		}
	}
};

DomHandler.prototype.oncomment = function(data){
	var lastTag = this._tagStack[this._tagStack.length - 1];

	if(lastTag && lastTag.type === ElementType.Comment){
		lastTag.data += data;
		return;
	}

	var element = {
		data: data,
		type: ElementType.Comment
	};

	this._addDomElement(element);
	this._tagStack.push(element);
};

DomHandler.prototype.oncdatastart = function(){
	var element = {
		children: [{
			data: "",
			type: ElementType.Text
		}],
		type: ElementType.CDATA
	};

	this._addDomElement(element);
	this._tagStack.push(element);
};

DomHandler.prototype.oncommentend = DomHandler.prototype.oncdataend = function(){
	this._tagStack.pop();
};

DomHandler.prototype.onprocessinginstruction = function(name, data){
	this._addDomElement({
		name: name,
		data: data,
		type: ElementType.Directive
	});
};

module.exports = DomHandler;


return module.exports;
})();modules['../document/node_modules/htmlparser2/lib/index.js'] = (function(){
var module = {exports: modules["../document/node_modules/htmlparser2/lib/index.js"]};
var require = getModule.bind(null, {"./Parser.js":"../document/node_modules/htmlparser2/lib/Parser.js","domhandler":"../document/node_modules/htmlparser2/node_modules/domhandler/index.js","./Tokenizer.js":"../document/node_modules/htmlparser2/lib/Tokenizer.js","domelementtype":"../document/node_modules/htmlparser2/node_modules/domelementtype/index.js"});
var exports = module.exports;

var Parser = require("./Parser.js"),
    DomHandler = require("domhandler");

function defineProp(name, value){
	delete module.exports[name];
	module.exports[name] = value;
	return value;
}

module.exports = {
	Parser: Parser,
	Tokenizer: require("./Tokenizer.js"),
	ElementType: require("domelementtype"),
	DomHandler: DomHandler,
	get FeedHandler(){
		return defineProp("FeedHandler", require("./FeedHandler.js"));
	},
	get Stream(){
		return defineProp("Stream", require("./Stream.js"));
	},
	get WritableStream(){
		return defineProp("WritableStream", require("./WritableStream.js"));
	},
	get ProxyHandler(){
		return defineProp("ProxyHandler", require("./ProxyHandler.js"));
	},
	get DomUtils(){
		return defineProp("DomUtils", require("domutils"));
	},
	get CollectingHandler(){
		return defineProp("CollectingHandler", require("./CollectingHandler.js"));
	},
	// For legacy support
	DefaultHandler: DomHandler,
	get RssHandler(){
		return defineProp("RssHandler", this.FeedHandler);
	},
	//helper methods
	parseDOM: function(data, options){
		var handler = new DomHandler(options);
		new Parser(handler, options).end(data);
		return handler.dom;
	},
	parseFeed: function(feed, options){
		var handler = new module.exports.FeedHandler(options);
		new Parser(handler, options).end(feed);
		return handler.dom;
	},
	createDomStream: function(cb, options, elementCb){
		var handler = new DomHandler(cb, options, elementCb);
		return new Parser(handler, options);
	},
	// List of all events that the parser emits
	EVENTS: { /* Format: eventname: number of arguments */
		attribute: 2,
		cdatastart: 0,
		cdataend: 0,
		text: 1,
		processinginstruction: 2,
		comment: 1,
		commentend: 0,
		closetag: 1,
		opentag: 2,
		opentagname: 1,
		error: 1,
		end: 0
	}
};


return module.exports;
})();modules['../document/element/element/parser.coffee'] = (function(){
var module = {exports: modules["../document/element/element/parser.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","htmlparser2":"../document/node_modules/htmlparser2/lib/index.js","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  var DEFAULT_ATTR_VALUE, attrsKeyGen, attrsValueGen, htmlparser, log, utils;

  utils = require('utils');

  htmlparser = require('htmlparser2');

  log = require('log');

  log = log.scope('Document');

  DEFAULT_ATTR_VALUE = utils.uid(100);

  attrsKeyGen = function(i, elem) {
    return elem;
  };

  attrsValueGen = function(i, elem) {
    return i;
  };

  module.exports = function(Element) {
    var Parser, extensions, internalTagsObject;
    extensions = Element.Tag.extensions;
    internalTagsObject = utils.arrayToObject(Element.Tag.INTERNAL_TAGS, (function(_, key) {
      return key;
    }), (function() {
      return true;
    }), Object.create(null));
    Parser = (function() {
      function Parser(callback) {
        this._callback = callback;
        this._done = false;
        this._tagStack = [];
        this.node = new Element.Tag;
      }

      Parser.prototype.onreset = function() {
        return Parser.call(this, this._callback);
      };

      Parser.prototype.onend = function() {
        if (this._done) {
          return;
        }
        this._done = true;
        return this._callback(null, this.node);
      };

      Parser.prototype.onerror = function(err) {
        this._done = true;
        return this._callback(err, this.node);
      };

      Parser.prototype.onclosetag = function(name) {
        var elem;
        return elem = this._tagStack.pop();
      };

      Parser.prototype._addDomElement = function(element) {
        var lastTag, length;
        lastTag = utils.last(this._tagStack) || this.node;
        length = lastTag.children.push(element);
        element._parent = lastTag;
        if (element._previousSibling = lastTag.children[length - 2] || null) {
          element._previousSibling._nextSibling = element;
        }
      };

      Parser.prototype.onopentag = function(name, attribs) {
        //<development>;
        var element;
        if (/^neft:/.test(name) && !internalTagsObject[name]) {
          log.warn("Unknown internal tag name '" + name + "'");
        }
        //</development>;
        element = new (extensions[name] || Element.Tag);
        element.name = name;
        element._attrs = attribs;
        this._addDomElement(element);
        return this._tagStack.push(element);
      };

      Parser.prototype.ontext = function(data) {
        var element;
        if (!data.replace(/[\t\n]/gm, '')) {
          return;
        }
        element = new Element.Text;
        element._text = data;
        return this._addDomElement(element);
      };

      Parser.prototype.oncomment = function() {};

      Parser.prototype.oncdatastart = function() {};

      Parser.prototype.oncommentend = function() {};

      Parser.prototype.oncdataend = function() {};

      Parser.prototype.onprocessinginstruction = function(name, data) {
        var element;
        element = new Element.Text;
        element._text = "<" + data + ">";
        return this._addDomElement(element);
      };

      return Parser;

    })();
    return {
      parse: function(html) {
        var handler, parser, r;
        r = null;
        handler = new Parser((function(_this) {
          return function(err, node) {
            if (err) {
              throw err;
            }
            return r = node;
          };
        })(this));
        parser = new htmlparser.Parser(handler, {
          xmlMode: false,
          recognizeSelfClosing: true,
          lowerCaseAttributeNames: false,
          lowerCaseTags: false
        });
        parser.onattribname = (function(_super) {
          return function(name) {
            _super.call(this, name);
            return this._attribvalue = DEFAULT_ATTR_VALUE;
          };
        })(parser.onattribname);
        parser.onattribdata = (function(_super) {
          return function(val) {
            if (this._attribvalue === DEFAULT_ATTR_VALUE) {
              this._attribvalue = '';
            }
            return _super.call(this, val);
          };
        })(parser.onattribdata);
        parser.onattribend = (function(_super) {
          return function() {
            if (this._attribvalue === DEFAULT_ATTR_VALUE) {
              this._attribvalue = 'true';
            }
            return _super.call(this);
          };
        })(parser.onattribend);
        parser.write(html);
        parser.end();
        return r;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/element/element.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md","./element/tag":"../document/element/element/tag.coffee.md","./element/text":"../document/element/element/text.coffee.md","./element/parser":"../document/element/element/parser.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Element, assert, emitSignal, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  isArray = Array.isArray;

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('View.Element');

  Element = (function(_super) {
    var Tag, opts;

    __extends(Element, _super);

    Element.__name__ = 'Element';

    Element.__path__ = 'File.Element';

    Element.fromHTML = function(html) {
      assert.isString(html);
      if (!utils.isNode) {
        throw "Creating Views from HTML files is allowed only on a server";
      }
      return Element.parser.parse(html);
    };

    function Element() {
      this._parent = null;
      this._nextSibling = null;
      this._previousSibling = null;
      Element.__super__.constructor.call(this);
      Object.preventExtensions(this);
    }

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'index', opts, function() {
      var _ref;
      return ((_ref = this.parent) != null ? _ref.children.indexOf(this) : void 0) || 0;
    }, function(val) {
      var children, index, parent, _ref, _ref1, _ref2, _ref3;
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
      if ((_ref = this._previousSibling) != null) {
        _ref._nextSibling = this._nextSibling;
      }
      if ((_ref1 = this._nextSibling) != null) {
        _ref1._previousSibling = this._previousSibling;
      }
      children.splice(index, 1);
      if (val > index) {
        val--;
      }
      children.splice(val, 0, this);
      this._previousSibling = children[val - 1] || null;
      this._nextSibling = children[val + 1] || null;
      if ((_ref2 = this._previousSibling) != null) {
        _ref2._nextSibling = this;
      }
      if ((_ref3 = this._nextSibling) != null) {
        _ref3._previousSibling = this;
      }
      assert.is(this.index, val);
      assert.is(children[val], this);
      assert.is(this._previousSibling, children[val - 1] || null);
      assert.is(this._nextSibling, children[val + 1] || null);
      return true;
    });

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'nextSibling', opts, function() {
      return this._nextSibling;
    }, null);

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'previousSibling', opts, function() {
      return this._previousSibling;
    }, null);

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'parent', opts, function() {
      return this._parent;
    }, function(val) {
      var index, newChildren, old, oldChildren, parent, _ref, _ref1;
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
        emitSignal(this._parent, 'onChildrenChange', null, this);
        if ((_ref = this._previousSibling) != null) {
          _ref._nextSibling = this._nextSibling;
        }
        if ((_ref1 = this._nextSibling) != null) {
          _ref1._previousSibling = this._previousSibling;
        }
        this._previousSibling = null;
        this._nextSibling = null;
      }
      this._parent = parent = val;
      if (parent) {
        assert.notOk(utils.has(this._parent.children, this));
        newChildren = this._parent.children;
        index = newChildren.push(this) - 1;
        emitSignal(parent, 'onChildrenChange', this);
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
      emitSignal(this, 'onParentChange', old);
      Tag.query.checkWatchersDeeply(this);
      return true;
    });

    signal.Emitter.createSignal(Element, 'onParentChange');

    Element.prototype.clone = function() {
      return new this.constructor;
    };

    Element.prototype.cloneDeep = function() {
      return this.clone();
    };

    Element.Tag = Tag = require('./element/tag')(Element);

    Element.Text = require('./element/text')(Element);

    if (utils.isNode) {
      Element.parser = require('./element/parser')(Element);
    }

    return Element;

  })(signal.Emitter);

  module.exports = Element;

}).call(this);


return module.exports;
})();modules['../document/element/index.coffee'] = (function(){
var module = {exports: modules["../document/element/index.coffee"]};
var require = getModule.bind(null, {"./element":"../document/element/element.coffee.md"});
var exports = module.exports;

(function() {
  module.exports = require('./element');

}).call(this);


return module.exports;
})();modules['../document/attrChange.coffee'] = (function(){
var module = {exports: modules["../document/attrChange.coffee"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  assert = require('neft-assert');

  utils = require('utils');

  log = require('log');

  assert = assert.scope('View.AttrChange');

  log = log.scope('View', 'AttrChange');

  module.exports = function(File) {
    var AttrChange;
    return AttrChange = (function() {
      var onAttrsChange, onVisibleChange;

      AttrChange.__name__ = 'AttrChange';

      AttrChange.__path__ = 'File.AttrChange';

      function AttrChange(opts) {
        assert.isPlainObject(opts);
        assert.instanceOf(opts.self, File);
        assert.instanceOf(opts.node, File.Element);
        assert.instanceOf(opts.target, File.Element);
        assert.isString(opts.name);
        assert.notLengthOf(opts.name, 0);
        utils.fill(this, opts);
        this._defaultValue = this.target.attrs.get(this.name);
      }

      AttrChange.prototype.self = null;

      AttrChange.prototype.node = null;

      AttrChange.prototype.target = null;

      AttrChange.prototype.name = '';

      AttrChange.prototype.update = function() {
        var val;
        val = this.node.visible ? this.node.attrs.get('value') : this._defaultValue;
        this.target.attrs.set(this.name, val);
      };

      onVisibleChange = function() {
        return this.update();
      };

      onAttrsChange = function(name, oldValue) {
        if (name === 'name') {
          throw new Error("Dynamic neft:attr name is not implemented");
        } else if (name === 'value') {
          this.update();
        }
      };

      AttrChange.prototype.clone = function(original, self) {
        var clone;
        clone = Object.create(this);
        clone.clone = void 0;
        clone.self = self;
        clone.node = original.node.getCopiedElement(this.node, self.node);
        clone.target = original.node.getCopiedElement(this.target, self.node);
        clone.update();
        clone.node.onVisibleChange(onVisibleChange, clone);
        clone.node.onAttrsChange(onAttrsChange, clone);
        return clone;
      };

      return AttrChange;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/fragment.coffee'] = (function(){
var module = {exports: modules["../document/fragment.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use script';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  signal = require('signal');

  assert = assert.scope('View.Fragment');

  module.exports = function(File) {
    var Fragment;
    return Fragment = (function(_super) {
      __extends(Fragment, _super);

      Fragment.__name__ = 'Fragment';

      Fragment.__path__ = 'File.Fragment';

      signal.create(Fragment, 'onCreate');

      function Fragment(self, name, node) {
        var _ref;
        this.name = name;
        assert.instanceOf(self, File);
        assert.isString(name);
        assert.notLengthOf(name, 0);
        Fragment.onCreate.emit(this, self);
        this.fragments = utils.clone(self.fragments);
        if ((_ref = this.fragments) != null) {
          delete _ref[this.name];
        }
        this.id = "" + self.path + ":" + name;
        this._node = node;
      }

      Fragment.prototype.id = '';

      Fragment.prototype.name = '';

      if (utils.isNode) {
        Fragment.prototype.parse = function() {
          File.call(this, this.id, this._node);
          return delete this._node;
        };
      }

      return Fragment;

    })(File);
  };

}).call(this);


return module.exports;
})();modules['../document/use.coffee'] = (function(){
var module = {exports: modules["../document/use.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  utils = require('utils');

  assert = require('neft-assert');

  log = require('log');

  assert = assert.scope('View.Use');

  log = log.scope('View', 'Use');

  module.exports = function(File) {
    var Use;
    return Use = (function() {
      var attrsChangeListener, logUsesWithNoFragments, usesWithNotFoundFragments, visibilityChangeListener;

      Use.__name__ = 'Use';

      Use.__path__ = 'File.Use';

      function Use(self, node) {
        var bodyNode, elem;
        this.self = self;
        this.node = node;
        assert.instanceOf(self, File);
        assert.instanceOf(node, File.Element);
        if (node.children.length) {
          bodyNode = this.bodyNode = new File.Element.Tag;
          while (elem = node.children[0]) {
            elem.parent = bodyNode;
          }
          bodyNode.parent = node;
        }
      }

      Use.prototype.name = '';

      Use.prototype.self = null;

      Use.prototype.node = null;

      Use.prototype.bodyNode = null;

      Use.prototype.usedFragment = null;

      Use.prototype.isRendered = false;

      //<development>;

      usesWithNotFoundFragments = [];

      logUsesWithNoFragments = function() {
        var useElem;
        while (useElem = usesWithNotFoundFragments.pop()) {
          if (!useElem.usedFragment) {
            log.warn("neft:fragment '" + useElem.name + "' can't be find in file '" + useElem.self.path + "'");
          }
        }
      };

      //</development>;

      Use.prototype.render = function(file) {
        var fragment, usedFragment;
        if (file != null) {
          assert.instanceOf(file, File);
        }
        if (!this.node.visible) {
          return;
        }
        if (this.isRendered) {
          this.revert();
        }
        fragment = this.self.fragments[this.name];
        if (!file && !fragment) {
          //<development>;
          if (usesWithNotFoundFragments.push(this) === 1) {
            setTimeout(logUsesWithNoFragments);
          }
          //</development>;
          return;
        }
        usedFragment = file || File.factory(fragment);
        if (!file) {
          usedFragment.storage = this.self.storage;
        }
        if (!usedFragment.isRendered) {
          usedFragment = usedFragment.render(this);
        }
        usedFragment.node.parent = this.node;
        this.usedFragment = usedFragment;
        usedFragment.parentUse = this;
        usedFragment.onReplaceByUse.emit(this);
        return this.isRendered = true;
      };

      Use.prototype.revert = function() {
        if (!this.isRendered) {
          return;
        }
        if (this.usedFragment) {
          this.usedFragment.revert().destroy();
          this.usedFragment.node.parent = null;
          this.usedFragment.parentUse = null;
          this.usedFragment = null;
        }
        return this.isRendered = false;
      };

      visibilityChangeListener = function() {
        if (this.self.isRendered && !this.isRendered) {
          return this.render();
        }
      };

      attrsChangeListener = function(name) {
        if (name === 'neft:fragment') {
          this.name = this.node.attrs.get('neft:fragment');
          if (this.isRendered) {
            this.revert();
            this.render();
          }
        }
      };

      Use.prototype.clone = function(original, self) {
        var clone;
        clone = Object.create(this);
        clone.clone = void 0;
        clone.self = self;
        clone.node = original.node.getCopiedElement(this.node, self.node);
        clone.bodyNode = clone.node.children[0];
        clone.usedFragment = null;
        clone.isRendered = false;
        clone.node.onVisibleChange(visibilityChangeListener, clone);
        if (clone.name === '') {
          clone.name = clone.node.attrs.get('neft:fragment');
          clone.node.onAttrsChange(attrsChangeListener, clone);
        }
        return clone;
      };

      return Use;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/input.coffee'] = (function(){
var module = {exports: modules["../document/input.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","dict":"../dict/index.coffee.md","list":"../list/index.coffee.md","db":"../db/index.coffee.md","./input/text.coffee":"../document/input/text.coffee","./input/attr.coffee":"../document/input/attr.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, List, assert, log, utils;

  utils = require('utils');

  assert = require('neft-assert');

  log = require('log');

  Dict = require('dict');

  List = require('list');

  assert = assert.scope('View.Input');

  log = log.scope('View', 'Input');

  module.exports = function(File) {
    var Input;
    return Input = (function() {
      var CONSTANT_VARS, Element, GLOBAL, PROPS_RE, PROP_RE, RE, VAR_RE, cache, getNamedSignal, onChange, pending, queue, queueIndex, queues, revertTraces, updateItems;

      Element = File.Element;

      Input.__name__ = 'Input';

      Input.__path__ = 'File.Input';

      RE = Input.RE = new RegExp('([^$]*)\\${([^}]*)}([^$]*)', 'gm');

      VAR_RE = Input.VAR_RE = /(^|\s|\[|:|\()([a-zA-Z_$][\w:_]*)+(?!:)/g;

      PROP_RE = Input.PROP_RE = /(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+/;

      PROPS_RE = Input.PROPS_RE = /[a-zA-Z_$][a-zA-Z0-9_$]*(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+\s*/g;

      CONSTANT_VARS = Input.CONSTANT_VARS = ['undefined', 'false', 'true', 'null', 'this', 'JSON'];

      cache = {};

      GLOBAL = {
        Math: Math,
        Array: Array,
        Object: Object,
        Number: Number,
        RegExp: RegExp,
        String: String,
        db: require('db'),
        utils: require('utils')
      };

      Input.getVal = (function() {
        var getElement, getFromElement, getFromObject, getFunction;
        getFromElement = function(elem, prop) {
          if (elem instanceof Element) {
            return elem._attrs[prop];
          }
        };
        getFromObject = function(obj, prop) {
          var v;
          if (obj instanceof Dict) {
            v = obj.get(prop);
          }
          if (v === void 0 && obj) {
            v = obj[prop];
          }
          return v;
        };
        getElement = function(obj, prop) {
          var elem, _ref, _ref1, _ref2;
          while (obj) {
            if (elem = (_ref = obj.ids) != null ? _ref[prop] : void 0) {
              return elem;
            }
            obj = ((_ref1 = obj.parentUse) != null ? _ref1.self : void 0) || obj.self || ((_ref2 = obj.source) != null ? _ref2.self : void 0);
          }
        };
        getFunction = function(obj, prop) {
          var elem, _ref, _ref1, _ref2;
          while (obj) {
            if (elem = (_ref = obj.funcs) != null ? _ref[prop] : void 0) {
              return elem;
            }
            obj = ((_ref1 = obj.parentUse) != null ? _ref1.self : void 0) || obj.self || ((_ref2 = obj.source) != null ? _ref2.self : void 0);
          }
        };
        return function(file, prop) {
          var destFile, source, v;
          if (file.source instanceof File.Iterator) {
            destFile = file.source.self;
          } else {
            destFile = file;
          }
          if (v === void 0 && (source = destFile.source)) {
            v = getFromElement(source.node, prop);
          }
          if (v === void 0 && file.source instanceof File.Iterator) {
            v = getFromElement(file.source.node, prop);
          }
          if (v === void 0) {
            v = getFromElement(destFile.node, prop);
          }
          if (v === void 0 && source) {
            v = getFromObject(source.storage, prop);
          }
          if (v === void 0) {
            v = getFromObject(file.storage, prop);
          }
          if (v === void 0) {
            v = getElement(file, prop);
          }
          if (v === void 0) {
            v = getFunction(file, prop);
          }
          if (v === void 0) {
            v = GLOBAL[prop];
          }
          return v;
        };
      })();

      Input.get = function(input, prop) {
        if (prop === 'this') {
          return input.node;
        } else {
          return Input.getVal(input.self, prop);
        }
      };

      Input.getStoragesArray = (function(arr) {
        return function(file) {
          var _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6;
          assert.instanceOf(file, File);
          arr[0] = file.node;
          arr[1] = (_ref = file.source) != null ? _ref.node : void 0;
          arr[2] = (_ref1 = file.source) != null ? _ref1.storage : void 0;
          arr[3] = file.storage;
          arr[4] = (_ref2 = file.source) != null ? (_ref3 = _ref2.self) != null ? _ref3.node : void 0 : void 0;
          arr[5] = (_ref4 = file.source) != null ? (_ref5 = _ref4.self) != null ? (_ref6 = _ref5.source) != null ? _ref6.node : void 0 : void 0 : void 0;
          return arr;
        };
      })([]);

      Input.test = function(str) {
        RE.lastIndex = 0;
        return RE.test(str);
      };

      Input.parse = function(text) {
        var charStr, chunks, err, func, i, innerBlocks, isBlock, isString, match, n, prop, str;
        text = text.replace(/[\t\n]/gm, '');
        func = "";
        chunks = [];
        str = '';
        isString = isBlock = false;
        innerBlocks = 0;
        i = 0;
        n = text.length;
        while (i < n) {
          charStr = text[i];
          if (charStr === '$' && text[i + 1] === '{') {
            isBlock = true;
            chunks.push(str);
            str = '';
            i++;
          } else if (charStr === '{') {
            innerBlocks++;
            str += charStr;
          } else if (charStr === '}') {
            if (innerBlocks > 0) {
              innerBlocks--;
              str += charStr;
            } else if (isBlock) {
              chunks.push(str);
              str = '';
            } else {
              log.error("Interpolated string parse error: '" + text + "'");
              return;
            }
          } else {
            str += charStr;
          }
          i++;
        }
        chunks.push(str);
        while (chunks.length > 1) {
          match = [chunks.shift(), chunks.shift()];
          prop = match[1];
          if (prop) {
            prop = prop.replace(PROPS_RE, function(str, _, index, allStr) {
              var postfix, prefix;
              postfix = allStr.substr(index + str.length, 2);
              prefix = '';
              str = str.replace(PROP_RE, function(props) {
                var ends, r, _i, _len;
                props = props.split('.');
                props.shift();
                if (postfix[0] === '(' || (postfix[0] === '=' && postfix !== '==')) {
                  prefix += "__input.trace(";
                  ends = ').' + props[props.length - 1];
                  props.pop();
                } else {
                  ends = '';
                }
                r = '';
                for (_i = 0, _len = props.length; _i < _len; _i++) {
                  prop = props[_i];
                  prefix += "__input.traceObj(";
                  r += ", '" + prop + "')";
                }
                return r + ends;
              });
              return "" + prefix + str;
            });
            prop = prop.replace(VAR_RE, function(matched, prefix, elem) {
              if (elem.indexOf('__') === 0) {
                return matched;
              }
              if (prefix.trim() || !utils.has(CONSTANT_VARS, elem)) {
                str = "__get(__input, '" + (utils.addSlashes(elem)) + "')";
              } else {
                str = elem;
              }
              return "" + prefix + str;
            });
          }
          if (prop == null) {
            prop = '';
          }
          if (match[0]) {
            func += "'" + (utils.addSlashes(match[0])) + "' + ";
          }
          if (prop) {
            func += "" + prop + " + ";
          }
        }
        if (chunks.length && chunks[0]) {
          func += "'" + (utils.addSlashes(chunks[0])) + "' + ";
        }
        func = 'return ' + func.slice(0, -3);
        try {
          new Function(func);
        } catch (_error) {
          err = _error;
          log.error("Can't parse string literal:\n" + text + "\n" + err.message + "\n" + func);
        }
        return func;
      };

      Input.createFunction = function(funcBody) {
        assert.isString(funcBody);
        assert.notLengthOf(funcBody, 0);
        return new Function('__input', '__get', funcBody);
      };

      Input.fromAssembled = function(input) {
        var _name;
        return input.func = cache[_name = input.funcBody] != null ? cache[_name] : cache[_name] = Input.createFunction(input.funcBody);
      };

      function Input(node, func) {
        this.node = node;
        this.func = func;
        assert.instanceOf(node, File.Element);
        assert.isFunction(func);
        this.self = null;
        this.funcBody = '';
        this.traces = [];
        this.text = '';
        this.updatePending = false;
        this.traceChanges = true;
        Object.preventExtensions(this);
      }

      queueIndex = 0;

      queues = [[], []];

      queue = queues[queueIndex];

      pending = false;

      updateItems = function() {
        var currentQueue, input;
        pending = false;
        currentQueue = queue;
        queue = queues[++queueIndex % queues.length];
        while (input = currentQueue.pop()) {
          input.update();
        }
      };

      if (utils.isServer) {
        onChange = function() {
          return this.update();
        };
      } else {
        onChange = function() {
          if (this.updatePending) {
            return;
          }
          queue.push(this);
          this.updatePending = true;
          if (!pending) {
            setImmediate(updateItems);
            pending = true;
          }
        };
      }

      revertTraces = function() {
        var i, obj, signal, traces, _i, _len;
        traces = this.traces;
        for (i = _i = 0, _len = traces.length; _i < _len; i = _i += 2) {
          obj = traces[i];
          signal = traces[i + 1];
          obj[signal].disconnect(onChange, this);
        }
        utils.clear(traces);
      };

      getNamedSignal = (function() {
        cache = Object.create(null);
        return function(name) {
          return cache[name] || (cache[name] = "on" + (utils.capitalize(name)) + "Change");
        };
      })();

      Input.prototype.trace = function(obj) {
        if (obj && this.traceChanges) {
          if (obj instanceof Dict) {
            obj.onChange(onChange, this);
            this.traces.push(obj, 'onChange');
          } else if (obj instanceof List) {
            obj.onChange(onChange, this);
            this.traces.push(obj, 'onChange');
            obj.onInsert(onChange, this);
            this.traces.push(obj, 'onInsert');
            obj.onPop(onChange, this);
            this.traces.push(obj, 'onPop');
          }
        }
        return obj;
      };

      Input.prototype.traceObj = function(obj, prop) {
        var signal, val;
        this.trace(obj);
        if (obj) {
          if (obj instanceof Dict) {
            val = obj.get(prop);
          } else if (obj instanceof List) {
            if (typeof prop === 'number') {
              val = obj.get(prop);
            }
          } else {
            signal = getNamedSignal(prop);
            if (typeof obj[signal] === 'function') {
              obj[signal](onChange, this);
              this.traces.push(obj, signal);
            }
          }
          if (val === void 0) {
            val = obj[prop];
          }
        }
        return val;
      };

      Input.prototype.render = function() {
        var storage, _i, _len, _ref;
        _ref = Input.getStoragesArray(this.self);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          storage = _ref[_i];
          if (storage instanceof Element) {
            storage.onAttrsChange(onChange, this);
          } else if (storage instanceof Dict) {
            this.trace(storage);
          }
        }
        return this.update();
      };

      Input.prototype.revert = function() {
        var storage, _i, _len, _ref;
        _ref = Input.getStoragesArray(this.self);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          storage = _ref[_i];
          if (storage instanceof Element) {
            storage.onAttrsChange.disconnect(onChange, this);
          }
        }
        revertTraces.call(this);
      };

      Input.prototype.update = function() {
        this.updatePending = false;
      };

      Input.prototype.toString = (function() {
        var callFunc;
        callFunc = function() {
          revertTraces.call(this);
          return this.func.call(this.node, this, Input.get);
        };
        return function() {
          var err;
          try {
            return callFunc.call(this);
          } catch (_error) {
            err = _error;
            return log.warn("Interpolated string error in '" + this.text + "';\n" + (err.stack || err));
          }
        };
      })();

      Input.prototype.clone = function(original, self) {
        var clone, node;
        node = original.node.getCopiedElement(this.node, self.node);
        clone = new this.constructor(node, this.func);
        clone.self = self;
        clone.text = this.text;
        return clone;
      };

      Input.Text = require('./input/text.coffee')(File, Input);

      Input.Attr = require('./input/attr.coffee')(File, Input);

      return Input;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/input/text.coffee'] = (function(){
var module = {exports: modules["../document/input/text.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  module.exports = function(File, Input) {
    var InputText;
    return InputText = (function(_super) {
      __extends(InputText, _super);

      InputText.__name__ = 'InputText';

      InputText.__path__ = 'File.Input.Text';

      function InputText(node, func) {
        this.lastValue = NaN;
        InputText.__super__.constructor.call(this, node, func);
      }

      InputText.prototype.update = function() {
        var str;
        InputText.__super__.update.call(this);
        str = this.toString();
        if (str == null) {
          str = '';
        } else if (typeof str !== 'string') {
          str += '';
        }
        if (str !== this.lastValue) {
          this.lastValue = str;
          this.node.text = str;
        }
      };

      return InputText;

    })(Input);
  };

}).call(this);


return module.exports;
})();modules['../document/input/attr.coffee'] = (function(){
var module = {exports: modules["../document/input/attr.coffee"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('neft-assert');

  utils = require('utils');

  module.exports = function(File, Input) {
    var InputAttr;
    return InputAttr = (function(_super) {
      var createHandlerFunc, isHandler;

      __extends(InputAttr, _super);

      InputAttr.__name__ = 'InputAttr';

      InputAttr.__path__ = 'File.Input.Attr';

      function InputAttr(node, func) {
        this.attrName = '';
        this.handlerFunc = null;
        this.lastValue = NaN;
        InputAttr.__super__.constructor.call(this, node, func);
      }

      isHandler = function(name) {
        return /^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test(name);
      };

      InputAttr.prototype.update = function() {
        var str;
        InputAttr.__super__.update.call(this);
        str = this.handlerFunc || this.toString();
        if (str !== this.lastValue) {
          this.lastValue = str;
          this.node.attrs.set(this.attrName, str);
        }
      };

      createHandlerFunc = function(input) {
        return function(arg1, arg2) {
          var r;
          r = input.toString();
          if (typeof r === 'function') {
            r.call(this, arg1, arg2);
          }
        };
      };

      InputAttr.prototype.clone = function(original, self) {
        var clone;
        clone = InputAttr.__super__.clone.call(this, original, self);
        clone.attrName = this.attrName;
        if (isHandler(this.attrName)) {
          clone.traceChanges = false;
          clone.handlerFunc = createHandlerFunc(clone);
        }
        return clone;
      };

      return InputAttr;

    })(Input);
  };

}).call(this);


return module.exports;
})();modules['../document/condition.coffee'] = (function(){
var module = {exports: modules["../document/condition.coffee"]};
var require = getModule.bind(null, {"log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var log;

  log = require('log');

  log = log.scope('View', 'Condition');

  module.exports = function(File) {
    var Condition;
    return Condition = (function() {
      var onAttrsChange;

      Condition.__name__ = 'Condition';

      Condition.__path__ = 'File.Condition';

      function Condition(node, elseNode) {
        this.node = node;
        this.elseNode = elseNode != null ? elseNode : null;
        Object.preventExtensions(this);
      }

      Condition.prototype.update = function() {
        var visible, _ref;
        visible = this.node.visible = !!this.node.attrs.get('neft:if');
        if ((_ref = this.elseNode) != null) {
          _ref.visible = !visible;
        }
      };

      onAttrsChange = function(name) {
        if (name === 'neft:if') {
          this.update();
        }
      };

      Condition.prototype.clone = function(original, self) {
        var clone, elseNode, node;
        node = original.node.getCopiedElement(this.node, self.node);
        if (this.elseNode) {
          elseNode = original.node.getCopiedElement(this.elseNode, self.node);
        }
        clone = new this.constructor(node, elseNode);
        node.onAttrsChange(onAttrsChange, clone);
        return clone;
      };

      return Condition;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/iterator.coffee'] = (function(){
var module = {exports: modules["../document/iterator.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","list":"../list/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, isArray, log, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('neft-assert');

  List = require('list');

  log = require('log');

  isArray = Array.isArray;

  assert = assert.scope('View.Iterator');

  log = log.scope('View', 'Iterator');

  module.exports = function(File) {
    var Iterator;
    return Iterator = (function(_super) {
      var attrsChangeListener, visibilityChangeListener;

      __extends(Iterator, _super);

      Iterator.__name__ = 'Iterator';

      Iterator.__path__ = 'File.Iterator';

      Iterator.HTML_ATTR = "" + File.HTML_NS + ":each";

      function Iterator(self, node) {
        var fragment, prefix;
        this.self = self;
        assert.instanceOf(self, File);
        assert.instanceOf(node, File.Element);
        prefix = self.name ? "" + self.name + "-" : '';
        this.name = "" + prefix + "each[" + (utils.uid()) + "]";
        Iterator.__super__.constructor.call(this, self, node);
        fragment = new File.Fragment(self, this.name, this.bodyNode);
        fragment.parse();
        this.fragment = fragment.id;
        this.bodyNode.parent = void 0;
        this.text = '';
      }

      Iterator.prototype.fragment = '';

      Iterator.prototype.storage = null;

      Iterator.prototype.usedFragments = null;

      Iterator.prototype.data = null;

      Iterator.prototype.text = '';

      Iterator.prototype.render = function() {
        var array, each, i, _, _i, _len;
        if (!this.node.visible) {
          return;
        }
        each = this.node.attrs.get(Iterator.HTML_ATTR);
        if (each === this.data) {
          return;
        }
        if (!isArray(each) && !(each instanceof List)) {
          return;
        }
        this.data = array = each;
        if (each instanceof List) {
          each.onChange(this.updateItem, this);
          each.onInsert(this.insertItem, this);
          each.onPop(this.popItem, this);
          array = each.items();
        }
        for (i = _i = 0, _len = array.length; _i < _len; i = ++_i) {
          _ = array[i];
          this.insertItem(i);
        }
        return null;
      };

      Iterator.prototype.revert = function() {
        var data;
        data = this.data;
        if (data) {
          this.clearData();
          if (data instanceof List) {
            data.onChange.disconnect(this.updateItem, this);
            data.onInsert.disconnect(this.insertItem, this);
            data.onPop.disconnect(this.popItem, this);
          }
        }
        return this.data = null;
      };

      Iterator.prototype.update = function() {
        this.revert();
        return this.render();
      };

      Iterator.prototype.clearData = function() {
        var length;
        assert.isObject(this.data);
        while (length = this.usedFragments.length) {
          this.popItem(length - 1);
        }
        return this;
      };

      Iterator.prototype.updateItem = function(elem, i) {
        if (i == null) {
          i = elem;
        }
        assert.isObject(this.data);
        assert.isInteger(i);
        this.popItem(i);
        this.insertItem(i);
        return this;
      };

      Iterator.prototype.insertItem = function(elem, i) {
        var data, each, item, newChild, storage, usedFragment;
        if (i == null) {
          i = elem;
        }
        assert.isObject(this.data);
        assert.isInteger(i);
        data = this.data;
        usedFragment = File.factory(this.fragment);
        this.usedFragments.splice(i, 0, usedFragment);
        if (data instanceof List) {
          each = data.items();
          item = data.get(i);
        } else {
          each = data;
          item = data[i];
        }
        newChild = usedFragment.node;
        newChild.parent = this.node;
        newChild.index = i;
        storage = usedFragment.storage = Object.create(this.self.storage || null);
        storage.each = each;
        storage.i = i;
        storage.item = item;
        usedFragment.render(this);
        usedFragment.onReplaceByUse.emit(this);
        return this;
      };

      Iterator.prototype.popItem = function(elem, i) {
        var usedFragment;
        if (i == null) {
          i = elem;
        }
        assert.isObject(this.data);
        assert.isInteger(i);
        this.node.children[i].parent = void 0;
        usedFragment = this.usedFragments[i];
        usedFragment.revert().destroy();
        this.usedFragments.splice(i, 1);
        return this;
      };

      attrsChangeListener = function(name) {
        if (this.self.isRendered && name === Iterator.HTML_ATTR) {
          return this.update();
        }
      };

      visibilityChangeListener = function(oldVal) {
        if (this.self.isRendered && oldVal === false && !this.node.data) {
          return this.update();
        }
      };

      Iterator.prototype.clone = function(original, self) {
        var clone;
        clone = Iterator.__super__.clone.apply(this, arguments);
        clone.storage = utils.cloneDeep(this.storage);
        clone.array = null;
        clone.usedFragments = [];
        clone.text = this.text;
        clone.node.onAttrsChange(attrsChangeListener, clone);
        clone.node.onVisibleChange(visibilityChangeListener, clone);
        return clone;
      };

      return Iterator;

    })(File.Use);
  };

}).call(this);


return module.exports;
})();modules['../document/log.coffee'] = (function(){
var module = {exports: modules["../document/log.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(File) {
    var Log;
    return Log = (function() {
      var listenOnTextChange;

      Log.__name__ = 'Log';

      Log.__path__ = 'File.Log';

      function Log(node) {
        this.node = node;
        this.self = null;
        Object.preventExtensions(this);
      }

      Log.prototype.render = function() {
        var key, log, val, _ref;
        if (utils.isEmpty(this.node._attrs)) {
          console.log(this.node.stringifyChildren());
        } else {
          log = [this.node.stringifyChildren()];
          _ref = this.node._attrs;
          for (key in _ref) {
            val = _ref[key];
            log.push("" + key + "=", val);
          }
          console.log.apply(console, log);
        }
      };

      Log.prototype.log = function() {
        if (this.self.isRendered) {
          return this.render();
        }
      };

      listenOnTextChange = function(node, log) {
        var child, _i, _len, _ref;
        if (node instanceof File.Element.Text) {
          node.onTextChange(log.log, log);
        } else {
          _ref = node.children;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            listenOnTextChange(child, log);
          }
        }
      };

      Log.prototype.clone = function(original, self) {
        var clone, node;
        node = original.node.getCopiedElement(this.node, self.node);
        clone = new this.constructor(node);
        clone.self = self;
        node.onAttrsChange(this.log, clone);
        listenOnTextChange(node, clone);
        return clone;
      };

      return Log;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/func.coffee.md'] = (function(){
var module = {exports: modules["../document/func.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","expect":"node_modules/expect/index.coffee.md","renderer":"../renderer/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Renderer, expect, utils;

  utils = require('utils');

  expect = require('expect');

  Renderer = require('renderer');

  module.exports = function(File) {
    var Fragment, FuncGlobalFuncs, FuncGlobalGetters, Input, exports, funcGlobalProps, funcGlobalPropsLength, functionsCache, globalContext;
    Input = File.Input, Fragment = File.Fragment;
    FuncGlobalFuncs = {
      require: require,
      get: function(prop) {
        return Input.getVal(this, prop);
      }
    };
    FuncGlobalGetters = {
      "arguments": function(_, args) {
        return args;
      },
      view: function() {
        return this;
      },
      item: function(ctx) {
        if (ctx && ctx._ref) {
          ctx = ctx._ref;
        }
        if (ctx instanceof Renderer.Item) {
          return ctx;
        }
      }
    };
    funcGlobalProps = Object.keys(FuncGlobalFuncs);
    Array.prototype.push.apply(funcGlobalProps, Object.keys(FuncGlobalGetters));
    funcGlobalPropsLength = funcGlobalProps.length;
    globalContext = {};
    functionsCache = Object.create(null);
    return exports = {
      bindFuncIntoGlobal: function(opts, file) {
        var args, customArgsLength, func, globalFunc, i, prop, _i, _len;
        expect(file).toBe.any(File);
        if (!(func = functionsCache[opts.uid])) {
          args = funcGlobalProps.concat(opts["arguments"]);
          func = functionsCache[opts.uid] = new Function(args, opts.body);
        }
        args = new Array(funcGlobalPropsLength + opts["arguments"].length);
        customArgsLength = opts["arguments"].length;
        for (i = _i = 0, _len = funcGlobalProps.length; _i < _len; i = ++_i) {
          prop = funcGlobalProps[i];
          if (globalFunc = FuncGlobalFuncs[prop]) {
            args[i] = globalFunc.bind(file);
          } else {
            args[i] = null;
          }
        }
        return function() {
          var globalGetter, _j, _k, _len1;
          for (i = _j = 0, _len1 = funcGlobalProps.length; _j < _len1; i = ++_j) {
            prop = funcGlobalProps[i];
            if (globalGetter = FuncGlobalGetters[prop]) {
              args[i] = globalGetter.call(file, this, arguments);
            }
          }
          for (i = _k = 0; _k < customArgsLength; i = _k += 1) {
            args[funcGlobalPropsLength + i] = arguments[i];
          }
          return func.apply(globalContext, args);
        };
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/attrsToSet.coffee'] = (function(){
var module = {exports: modules["../document/attrsToSet.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var log, utils;

  utils = require('utils');

  log = require('log');

  module.exports = function(File) {
    var AttrsToSet;
    return AttrsToSet = (function() {
      var attrsKeyGen, attrsValueGen;

      AttrsToSet.__name__ = 'AttrsToSet';

      AttrsToSet.__path__ = 'File.AttrsToSet';

      attrsKeyGen = function(_, value) {
        return value;
      };

      attrsValueGen = function() {
        return true;
      };

      function AttrsToSet(node, attrs) {
        this.node = node;
        this.attrs = attrs;
        Object.preventExtensions(this);
      }

      AttrsToSet.prototype.setAttribute = function(attr, oldValue) {
        var val;
        if (!this.attrs[attr]) {
          return;
        }
        val = this.node._attrs[attr];
        if (typeof this.node[attr] === 'function' && this.node[attr].connect) {
          if (typeof oldValue === 'function') {
            this.node[attr].disconnect(oldValue);
          }
          if (typeof val === 'function') {
            this.node[attr](val);
          }
        } else {
          this.node[attr] = val;
        }
      };

      AttrsToSet.prototype.clone = function(original, self) {
        var attr, clone, node;
        node = original.node.getCopiedElement(this.node, self.node);
        clone = new AttrsToSet(node, this.attrs);
        for (attr in this.attrs) {
          if (node._attrs[attr] != null) {
            clone.setAttribute(attr, null);
          }
        }
        node.onAttrsChange(this.setAttribute, clone);
        return clone;
      };

      return AttrsToSet;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/file/clear.coffee'] = (function(){
var module = {exports: modules["../document/file/clear.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var LINE_BREAKERS_RE, PHRASING_ELEMENTS, PHRASING_ELEMENTS_OBJECT, WHITE_SPACES_RE, WHITE_SPACE_RE, isRemove, removeEmptyTexts, utils;

  utils = require('utils');

  WHITE_SPACE_RE = /^\s*$/;

  WHITE_SPACES_RE = /^(\r?\n|\r)+\s+/gm;

  LINE_BREAKERS_RE = /\r?\n|\r/g;

  PHRASING_ELEMENTS = ["a", "em", "strong", "small", "mark", "abbr", "dfn", "i", "b", "s", "u", "code", "var", "samp", "kbd", "sup", "sub", "q", "cite", "span", "bdo", "bdi", "br", "wbr", "ins", "del", "img", "embed", "object", "iframe", "map", "area", "script", "noscript", "ruby", "video", "audio", "input", "textarea", "select", "button", "label", "output", "datalist", "keygen", "progress", "command", "canvas", "time", "meter", "neft:function"];

  PHRASING_ELEMENTS_OBJECT = utils.arrayToObject(PHRASING_ELEMENTS, (function(_, key) {
    return key;
  }), (function() {
    return true;
  }), Object.create(null));

  isRemove = function(node) {
    if ('text' in node) {
      if (WHITE_SPACE_RE.test(node.text)) {
        return true;
      }
      if (!PHRASING_ELEMENTS_OBJECT[node.parent.name]) {
        node.text = node.text.replace(WHITE_SPACES_RE, '');
      }
    }
    return false;
  };

  removeEmptyTexts = function(node) {
    var elem, i, j, length, nodes, _i, _j, _len, _ref;
    nodes = node.children;
    if (!nodes) {
      return;
    }
    length = nodes.length;
    j = 0;
    for (i = _i = 0; _i <= length; i = _i += 1) {
      elem = nodes[j];
      if (!elem) {
        break;
      }
      if (isRemove(elem)) {
        elem.parent = void 0;
        j--;
      }
      j++;
    }
    _ref = node.children;
    for (i = _j = 0, _len = _ref.length; _j < _len; i = ++_j) {
      elem = _ref[i];
      if (elem.name !== 'script') {
        removeEmptyTexts(elem);
      }
    }
    return null;
  };

  module.exports = function(File) {
    return removeEmptyTexts;
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/rules.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/rules.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","./fragments/links":"../document/file/parse/fragments/links.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var commands, enterCommand, getNodeLength, isMainFileRule, log, utils;

  utils = require('utils');

  log = require('log');

  log = log.scope('Document', 'neft:rule');

  commands = {
    'attrs': function(command, node) {
      var name, val, _ref;
      _ref = command._attrs;
      for (name in _ref) {
        val = _ref[name];
        if (!node.attrs.has(name)) {
          node.attrs.set(name, val);
        }
      }
    }
  };

  enterCommand = function(command, node) {
    if (!commands[command.name]) {
      log.error("Rule '" + command.name + "' not found");
      return;
    }
    commands[command.name](command, node);
  };

  getNodeLength = function(node) {
    var i;
    i = 0;
    while (node = node.parent) {
      i++;
    }
    return i;
  };

  isMainFileRule = function(node) {
    while (node = node.parent) {
      if (node.name !== 'neft:blank' && node.name !== 'neft:rule') {
        return false;
      }
    }
    return true;
  };

  module.exports = function(File) {
    var parseLinks;
    parseLinks = require('./fragments/links')(File);
    return function(file) {
      var child, children, command, externalRule, i, link, linkView, links, localRule, localRules, n, node, nodes, query, rule, rules, subquery, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _len5, _len6, _m, _n, _o, _ref, _ref1;
      rules = [];
      utils.defineProperty(file, '_rules', null, rules);
      localRules = file.node.queryAll('neft:rule');
      localRules.sort(function(a, b) {
        return getNodeLength(b) - getNodeLength(a);
      });
      for (_i = 0, _len = localRules.length; _i < _len; _i++) {
        rule = localRules[_i];
        query = rule.attrs.get('query');
        if (!query) {
          log.error("neft:rule no 'query' attribute found");
          continue;
        }
        children = rule.children;
        i = 0;
        n = children.length;
        while (i < n) {
          child = children[i];
          if (child.name === 'neft:rule') {
            subquery = child.attrs.get('query');
            if (/^[A-Za-z]/.test(subquery)) {
              subquery = query + ' ' + subquery;
            } else {
              subquery = query + subquery;
            }
            child.attrs.set('query', subquery);
            child.parent = rule.parent;
            n--;
          } else {
            i++;
          }
        }
      }
      for (_j = 0, _len1 = localRules.length; _j < _len1; _j++) {
        localRule = localRules[_j];
        rules.push({
          node: localRule,
          parent: localRule.parent
        });
        localRule.parent = null;
      }
      links = parseLinks(file);
      for (_k = 0, _len2 = links.length; _k < _len2; _k++) {
        link = links[_k];
        linkView = File.factory(link.path);
        _ref = linkView._rules;
        for (_l = 0, _len3 = _ref.length; _l < _len3; _l++) {
          externalRule = _ref[_l];
          if (isMainFileRule(externalRule)) {
            rules.push({
              node: externalRule.node,
              parent: file.node
            });
          }
        }
      }
      for (_m = 0, _len4 = rules.length; _m < _len4; _m++) {
        rule = rules[_m];
        if (!(query = rule.node.attrs.get('query'))) {
          continue;
        }
        nodes = rule.parent.queryAll(query);
        for (_n = 0, _len5 = nodes.length; _n < _len5; _n++) {
          node = nodes[_n];
          _ref1 = rule.node.children;
          for (_o = 0, _len6 = _ref1.length; _o < _len6; _o++) {
            command = _ref1[_o];
            enterCommand(command, node);
          }
        }
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/fragments/links.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/fragments/links.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var pathUtils;

  pathUtils = require('path');

  module.exports = function(File) {
    return function(file) {
      var children, href, i, links, n, namespace, node, path, _ref;
      links = [];
      children = file.node.children;
      i = -1;
      n = children.length;
      while (++i < n) {
        node = children[i];
        if (node.name !== ("" + File.HTML_NS + ":require")) {
          continue;
        }
        href = node.attrs.get('href');
        if (!href) {
          continue;
        }
        namespace = node.attrs.get('as');
        path = href;
        if (path[0] !== '/') {
          path = pathUtils.join('/', file.pathbase, path);
        }
        path = ((_ref = /^(?:\/|\\)(.+)\.html$/.exec(path)) != null ? _ref[1] : void 0) || path;
        links.push({
          path: path,
          namespace: namespace
        });
      }
      return links;
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/fragments.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/fragments.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./fragments/links":"../document/file/parse/fragments/links.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(File) {
    var parseLinks;
    parseLinks = require('./fragments/links')(File);
    return function(file) {
      var createdFragment, createdFragments, forEachNodeRec, fragment, fragmentId, fragmentName, fragments, link, linkView, links, name, namespace, _i, _j, _k, _len, _len1, _len2, _ref;
      fragments = file.fragments != null ? file.fragments : file.fragments = {};
      createdFragments = [];
      links = parseLinks(file);
      for (_i = 0, _len = links.length; _i < _len; _i++) {
        link = links[_i];
        namespace = link.namespace ? "" + link.namespace + ":" : '';
        linkView = File.factory(link.path);
        _ref = linkView.fragments;
        for (name in _ref) {
          fragment = _ref[name];
          fragments[namespace + name] = fragment;
        }
      }
      forEachNodeRec = function(node) {
        var child, children, i, n, _results;
        if (!(children = node.children)) {
          return;
        }
        i = -1;
        n = children.length;
        _results = [];
        while (++i < n) {
          child = children[i];
          if (child.name !== 'neft:fragment') {
            forEachNodeRec(child);
            continue;
          }
          if (!(name = child.attrs.get('neft:name'))) {
            continue;
          }
          child.name = 'neft:blank';
          child.parent = null;
          i--;
          n--;
          fragment = new File.Fragment(file, name, child);
          fragments[name] = fragment.id;
          _results.push(createdFragments.push(fragment));
        }
        return _results;
      };
      forEachNodeRec(file.node);
      for (_j = 0, _len1 = createdFragments.length; _j < _len1; _j++) {
        createdFragment = createdFragments[_j];
        for (fragmentName in fragments) {
          fragmentId = fragments[fragmentName];
          if (createdFragment.fragments.hasOwnProperty(fragmentName)) {
            continue;
          }
          createdFragment.fragments[fragmentName] = fragmentId;
        }
      }
      for (_k = 0, _len2 = createdFragments.length; _k < _len2; _k++) {
        createdFragment = createdFragments[_k];
        createdFragment.parse();
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/attrs.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/attrs.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","dict":"../dict/index.coffee.md","list":"../list/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, List, VALUE_TO_EVAL_RE, attr, coffee, evalFunc, forNode, utils;

  utils = require('utils');

  Dict = require('dict');

  List = require('list');

  if (utils.isNode) {
    coffee = require('coffee-script');
  }

  attr = [null, null];

  VALUE_TO_EVAL_RE = /^(\[|\{|Dict\(|List\()/;

  evalFunc = new Function('val', 'try { return eval(\'(\'+val+\')\'); } catch(err){}');

  forNode = function(elem) {
    var i, jsVal, name, val, _ref;
    i = 0;
    while (true) {
      if (!elem.attrs) {
        break;
      }
      elem.attrs.item(i, attr);
      name = attr[0], val = attr[1];
      if (!name) {
        break;
      }
      jsVal = evalFunc(val);
      if (jsVal !== void 0) {
        elem.attrs.set(name, jsVal);
      }
      i++;
    }
    return (_ref = elem.children) != null ? _ref.forEach(forNode) : void 0;
  };

  module.exports = function(File) {
    return function(file) {
      return forNode(file.node);
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/attrChanges.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/attrChanges.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    var AttrChange;
    AttrChange = File.AttrChange;
    return function(file) {
      var attrChanges, name, node, nodes, target, value, _i, _len;
      attrChanges = [];
      nodes = file.node.queryAll("" + File.HTML_NS + ":attr");
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        target = node.parent;
        name = node.attrs.get('name');
        value = node.attrs.get('value');
        if (!target.attrs.has(name)) {
          target.attrs.set(name, '');
        }
        attrChanges.push(new AttrChange({
          self: file,
          node: node,
          target: target,
          name: name
        }));
      }
      if (attrChanges.length) {
        file.attrChanges = attrChanges;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/iterators.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/iterators.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file) {
      var forNode, iterators;
      iterators = [];
      forNode = function(elem) {
        var attrVal, iterator, _ref, _ref1;
        if (!(attrVal = (_ref = elem.attrs) != null ? _ref.get("" + File.HTML_NS + ":each") : void 0)) {
          return (_ref1 = elem.children) != null ? _ref1.forEach(forNode) : void 0;
        }
        iterator = new File.Iterator(file, elem);
        iterators.push(iterator);
        //<development>;
        iterator.text = attrVal;
        return //</development>;
      };
      forNode(file.node);
      if (iterators.length) {
        return file.iterators = iterators;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/target.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/target.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file) {
      var _ref;
      file.targetNode = file.node.query("neft:target");
      return (_ref = file.targetNode) != null ? _ref.name = 'neft:blank' : void 0;
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/uses.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/uses.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(File) {
    return function(file) {
      var forNode, uses;
      uses = [];
      forNode = function(node) {
        if (!(node instanceof File.Element.Tag)) {
          return;
        }
        node.children.forEach(forNode);
        if (node.name === "neft:use") {
          node.name = 'neft:blank';
          return uses.push(new File.Use(file, node));
        }
      };
      forNode(file.node);
      if (!utils.isEmpty(uses)) {
        return file.uses = uses;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/storage.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/storage.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var attr;

  attr = [null, null];

  module.exports = function(File) {
    var Input, InputRE;
    Input = File.Input;
    InputRE = Input.RE;
    return function(file) {
      var forNode, inputs, node;
      node = file.node;
      inputs = file.inputs = [];
      forNode = function(elem) {
        var func, funcBody, i, input, text, _ref;
        text = elem.text;
        if (text !== void 0) {
          InputRE.lastIndex = 0;
          if (text && InputRE.test(text)) {
            if (funcBody = Input.parse(text)) {
              func = Input.createFunction(funcBody);
              input = new Input.Text(elem, func);
              //<development>;
              input.text = text;
              //</development>;
              input.funcBody = funcBody;
              elem.text = '';
              inputs.push(input);
            }
          }
        }
        i = 0;
        while (true) {
          if (!elem.attrs) {
            break;
          }
          elem.attrs.item(i, attr);
          if (!attr[0]) {
            break;
          }
          if (Input.test(attr[1])) {
            if (funcBody = Input.parse(attr[1])) {
              func = Input.createFunction(funcBody);
              input = new Input.Attr(elem, func);
              //<development>;
              input.text = attr[1];
              //</development>;
              input.funcBody = funcBody;
              input.attrName = attr[0];
              elem.attrs.set(attr[0], null);
              inputs.push(input);
            }
          }
          i++;
        }
        return (_ref = elem.children) != null ? _ref.forEach(forNode) : void 0;
      };
      return forNode(node);
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/conditions.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/conditions.coffee.md"]};
var require = getModule.bind(null, {"log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var log;

  log = require('log');

  log = log.scope('View', 'Condition');

  module.exports = function(File) {
    var Condition;
    Condition = File.Condition;
    return function(file) {
      var conditions, forEachNodeRec;
      conditions = [];
      forEachNodeRec = function(node) {
        var child, condition, elseNode, _i, _len, _ref, _ref1, _ref2;
        _ref = node.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          if (!(child instanceof File.Element.Tag)) {
            continue;
          }
          forEachNodeRec(child);
          if (child.attrs.has('neft:if')) {
            elseNode = null;
            if ((_ref1 = child.nextSibling) != null ? (_ref2 = _ref1.attrs) != null ? _ref2.has('neft:else') : void 0 : void 0) {
              elseNode = child.nextSibling;
            }
            condition = new File.Condition(child, elseNode);
            conditions.push(condition);
          }
        }
      };
      forEachNodeRec(file.node);
      if (conditions.length) {
        return file.conditions = conditions;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/ids.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/ids.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var log, utils;

  utils = require('utils');

  log = require('log');

  log = log.scope('Document');

  module.exports = function(File) {
    return function(file) {
      var forEachNodeRec, ids;
      ids = {};
      forEachNodeRec = function(node) {
        var child, id, _i, _len, _ref;
        _ref = node.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          if (!child.children) {
            continue;
          }
          forEachNodeRec(child);
          if (!(id = child.attrs.get('id'))) {
            continue;
          }
          if (ids.hasOwnProperty(id)) {
            log.warn("Id must be unique; '" + id + "' duplicated");
            continue;
          }
          ids[id] = child;
        }
      };
      forEachNodeRec(file.node);
      if (!utils.isEmpty(ids)) {
        return file.ids = ids;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/logs.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/logs.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file) {
      var node, _i, _len, _ref;
      file.logs = [];
      _ref = file.node.queryAll('neft:log');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        file.logs.push(new File.Log(node));
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/funcs.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/funcs.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./fragments/links":"../document/file/parse/fragments/links.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var coffee, parseLinks, parseLinksFile, utils;

  coffee = require('coffee-script');

  utils = require('utils');

  parseLinksFile = require('./fragments/links');

  parseLinks = null;

  module.exports = function(File) {
    if (parseLinks == null) {
      parseLinks = parseLinksFile(File);
    }
    return function(file) {
      var Style, arg, args, argsAttr, body, externalFunc, externalFuncName, funcs, i, link, linkView, linkViewProto, links, name, node, nodes, _i, _j, _k, _len, _len1, _len2;
      Style = File.Style;
      funcs = file.funcs != null ? file.funcs : file.funcs = {};
      nodes = file.node.queryAll("neft:function");
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        name = node.attrs.get('name') || node.attrs.get('neft:name');
        if (!name) {
          throw new Error('Function name is requried');
        }
        body = node.stringifyChildren();
        if (argsAttr = node.attrs.get('arguments')) {
          args = argsAttr.split(',');
          for (i = _j = 0, _len1 = args.length; _j < _len1; i = ++_j) {
            arg = args[i];
            args[i] = arg.trim();
          }
        } else {
          args = [];
        }
        funcs[name] = {
          uid: utils.uid(),
          body: body,
          "arguments": args
        };
        node.parent = null;
      }
      links = parseLinks(file);
      for (_k = 0, _len2 = links.length; _k < _len2; _k++) {
        link = links[_k];
        linkView = File.factory(link.path);
        linkViewProto = Object.getPrototypeOf(linkView);
        for (externalFuncName in linkView.funcs) {
          if (externalFunc = linkViewProto.funcs[externalFuncName]) {
            if (funcs[externalFuncName] == null) {
              funcs[externalFuncName] = externalFunc;
            }
          }
        }
      }
      if (utils.isEmpty(funcs)) {
        file.funcs = null;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/parse/attrSetting.coffee.md'] = (function(){
var module = {exports: modules["../document/file/parse/attrSetting.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    var AttrsToSet;
    AttrsToSet = File.AttrsToSet;
    return function(file) {
      var attrsToSet, forEachNodeRec;
      attrsToSet = [];
      forEachNodeRec = function(node) {
        var child, nodeProps, prop, _i, _len, _ref;
        _ref = node.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          if (!(child instanceof File.Element.Tag)) {
            continue;
          }
          forEachNodeRec(child);
          nodeProps = null;
          for (prop in child._attrs) {
            if (prop === 'name' || prop === 'children' || prop === 'attrs' || prop === 'style') {
              continue;
            }
            if (!(prop in child)) {
              continue;
            }
            if (nodeProps == null) {
              nodeProps = {};
            }
            nodeProps[prop] = true;
          }
          if (nodeProps) {
            attrsToSet.push(new AttrsToSet(child, nodeProps));
          }
        }
      };
      forEachNodeRec(file.node);
      if (attrsToSet.length) {
        file.attrsToSet = attrsToSet;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/render/parse/target.coffee'] = (function(){
var module = {exports: modules["../document/file/render/parse/target.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file, source) {
      var newChild, oldChild;
      if (file.targetNode && source) {
        oldChild = file.targetNode;
        newChild = source.bodyNode;
        if (newChild != null) {
          newChild.parent = oldChild;
        }
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/render/revert/listeners.coffee'] = (function(){
var module = {exports: modules["../document/file/render/revert/listeners.coffee"]};
var require = getModule.bind(null, {"emitter":"../emitter/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Emitter;

  Emitter = ['emitter'].map(require)[0];

  module.exports = function(File) {
    return function(file) {
      var listener, listeners, node, signalName;
      listeners = file._tmp.listeners;
      while (listeners.length) {
        listener = listeners.pop();
        signalName = listeners.pop();
        node = listeners.pop();
        node[signalName].disconnect(listener);
      }
      return null;
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file/render/revert/target.coffee'] = (function(){
var module = {exports: modules["../document/file/render/revert/target.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file, source) {
      var newChild, oldChild;
      if (file.targetNode && source) {
        oldChild = file.targetNode;
        newChild = source.bodyNode;
        if (newChild != null) {
          newChild.parent = null;
        }
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../document/file.coffee.md'] = (function(){
var module = {exports: modules["../document/file.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","emitter":"../emitter/index.coffee.md","signal":"../signal/index.coffee.md","dict":"../dict/index.coffee.md","list":"../list/index.coffee.md","./element/index":"../document/element/index.coffee","./attrChange":"../document/attrChange.coffee","./fragment":"../document/fragment.coffee","./use":"../document/use.coffee","./input":"../document/input.coffee","./condition":"../document/condition.coffee","./iterator":"../document/iterator.coffee","./log":"../document/log.coffee","./func":"../document/func.coffee.md","./attrsToSet":"../document/attrsToSet.coffee","./file/clear":"../document/file/clear.coffee","./file/parse/rules":"../document/file/parse/rules.coffee.md","./file/parse/fragments":"../document/file/parse/fragments.coffee.md","./file/parse/attrs":"../document/file/parse/attrs.coffee.md","./file/parse/attrChanges":"../document/file/parse/attrChanges.coffee.md","./file/parse/iterators":"../document/file/parse/iterators.coffee.md","./file/parse/target":"../document/file/parse/target.coffee.md","./file/parse/uses":"../document/file/parse/uses.coffee.md","./file/parse/storage":"../document/file/parse/storage.coffee.md","./file/parse/conditions":"../document/file/parse/conditions.coffee.md","./file/parse/ids":"../document/file/parse/ids.coffee.md","./file/parse/logs":"../document/file/parse/logs.coffee.md","./file/parse/funcs":"../document/file/parse/funcs.coffee.md","./file/parse/attrSetting":"../document/file/parse/attrSetting.coffee.md","./file/render/parse/target":"../document/file/render/parse/target.coffee","./file/render/revert/listeners":"../document/file/render/revert/listeners.coffee","./file/render/revert/target":"../document/file/render/revert/target.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, Emitter, File, List, assert, log, signal, utils;

  utils = require('utils');

  assert = require('neft-assert');

  log = require('log');

  Emitter = require('emitter');

  signal = require('signal');

  Dict = require('dict');

  List = require('list');

  assert = assert.scope('View');

  log = log.scope('View');

  module.exports = File = (function() {
    var files, getFromPool, getTmp, pool, _class;

    function File() {
      return _class.apply(this, arguments);
    }

    files = File._files = {};

    pool = Object.create(null);

    getFromPool = function(path) {
      var arr, file, i, n;
      arr = pool[path];
      if (arr != null ? arr.length : void 0) {
        i = n = arr.length;
        while (file = arr[--i]) {
          if (file.readyToUse) {
            arr[i] = arr[n - 1];
            arr.pop();
            return file;
          }
        }
      }
    };

    getTmp = function() {
      var tmp;
      return tmp = {
        listeners: []
      };
    };

    File.__name__ = 'File';

    File.__path__ = 'File';

    File.CREATE = 'create';

    File.ERROR = 'error';

    File.HTML_NS = 'neft';

    utils.merge(File, Emitter.prototype);

    Emitter.call(File);

    signal.create(File, 'onBeforeParse');

    signal.create(File, 'onParse');

    signal.create(File, 'onBeforeRender');

    signal.create(File, 'onRender');

    signal.create(File, 'onBeforeRevert');

    signal.create(File, 'onRevert');

    File.Element = require('./element/index');

    File.AttrChange = require('./attrChange')(File);

    File.Fragment = require('./fragment')(File);

    File.Use = require('./use')(File);

    File.Input = require('./input')(File);

    File.Condition = require('./condition')(File);

    File.Iterator = require('./iterator')(File);

    File.Log = require('./log')(File);

    File.Func = require('./func')(File);

    File.AttrsToSet = require('./attrsToSet')(File);

    File.fromHTML = (function() {
      var clear;
      clear = require('./file/clear')(File);
      return function(path, html) {
        var file, node;
        assert.isString(path);
        assert.notLengthOf(path, 0);
        assert.notOk(files[path] != null);
        if (!(html instanceof File.Element)) {
          assert.isString(html);
        }
        if (html === '') {
          html = '<html></html>';
        }
        if (html instanceof File.Element) {
          node = html;
        } else {
          node = File.Element.fromHTML(html);
        }
        clear(node);
        file = new File(path, node);
        return file;
      };
    })();

    File.fromJSON = (function(ctorsCache) {
      return function(path, json) {
        var ctor, ctors, i, ns, _ref;
        assert.isString(path);
        assert.notLengthOf(path, 0);
        assert.notOk(files[path] != null);
        if (typeof json === 'string') {
          json = utils.tryFunction(JSON.parse, null, [json], json);
        }
        assert.isPlainObject(json);
        ns = {
          File: File,
          Dict: Dict,
          List: List
        };
        _ref = ctors = json.constructors;
        for (i in _ref) {
          ctor = _ref[i];
          if (ctorsCache[ctor] == null) {
            ctorsCache[ctor] = utils.get(ns, ctor);
          }
          ctors[i] = ctorsCache[ctor];
        }
        json = utils.assemble(json);
        files[path] = json;
        return json;
      };
    })({});

    File.factory = function(path) {
      var file, r;
      if (!files.hasOwnProperty(path)) {
        File.trigger(File.ERROR, path);
      }
      assert.isString(path);
      assert.ok(files[path] != null);
      if (r = getFromPool(path)) {
        return r;
      }
      file = files[path].clone();
      File.trigger(File.CREATE, file);
      return file;
    };

    _class = (function() {
      var attrChanges, attrSetting, attrs, conditions, fragments, funcs, ids, iterators, logs, rules, storage, target, uses;
      if (utils.isNode) {
        rules = require('./file/parse/rules')(File);
        fragments = require('./file/parse/fragments')(File);
        attrs = require('./file/parse/attrs')(File);
        attrChanges = require('./file/parse/attrChanges')(File);
        iterators = require('./file/parse/iterators')(File);
        target = require('./file/parse/target')(File);
        uses = require('./file/parse/uses')(File);
        storage = require('./file/parse/storage')(File);
        conditions = require('./file/parse/conditions')(File);
        ids = require('./file/parse/ids')(File);
        logs = require('./file/parse/logs')(File);
        funcs = require('./file/parse/funcs')(File);
        attrSetting = require('./file/parse/attrSetting')(File);
      }
      return function(path, node) {
        this.path = path;
        this.node = node;
        assert.isString(path);
        assert.notLengthOf(path, 0);
        assert.instanceOf(node, File.Element);
        assert.notOk(files[path] != null);
        this.pathbase = path.substring(0, path.lastIndexOf('/') + 1);
        this.isRendered = false;
        this.readyToUse = true;
        this.init();
        utils.defineProperty(this, '_tmp', utils.WRITABLE, getTmp());
        File.onBeforeParse.emit(this);
        rules(this);
        fragments(this);
        attrs(this);
        iterators(this);
        attrChanges(this);
        target(this);
        uses(this);
        storage(this);
        conditions(this);
        ids(this);
        funcs(this);
        attrSetting(this);
        //<development>;
        logs(this);
        //</development>;
        File.onParse.emit(this);
        files[this.path] = this;
        return this;
      };
    })();

    File.prototype.uid = '';

    File.prototype.isRendered = false;

    File.prototype.node = null;

    File.prototype.targetNode = null;

    File.prototype.path = '';

    File.prototype.pathbase = '';

    File.prototype.parent = null;

    File.prototype.attrChanges = null;

    File.prototype.fragments = null;

    File.prototype.uses = null;

    File.prototype.inputs = null;

    File.prototype.conditions = null;

    File.prototype.iterators = null;

    File.prototype.storage = null;

    File.prototype.target = null;

    File.prototype.ids = null;

    File.prototype.logs = null;

    File.prototype.funcs = null;

    File.prototype.attrsToSet = null;

    File.prototype.init = function() {};

    File.prototype.render = function(storage, source) {
      if (this.clone) {
        return this.clone().render(storage, source);
      } else {
        return this._render(storage, source);
      }
    };

    File.prototype._render = (function() {
      var renderTarget;
      renderTarget = require('./file/render/parse/target')(File);
      return function(storage, source) {
        var i, input, iterator, use, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2, _ref3;
        assert.notOk(this.isRendered);
        assert.ok(this.readyToUse);
        if (storage instanceof File.Use) {
          source = storage;
          storage = null;
        }
        if (storage != null) {
          this.storage = storage;
        }
        this.source = source;
        File.onBeforeRender.emit(this);
        if (this.inputs) {
          _ref = this.inputs;
          for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
            input = _ref[i];
            input.render();
          }
        }
        if (this.uses) {
          _ref1 = this.uses;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            use = _ref1[_j];
            use.render();
          }
        }
        if (this.iterators) {
          _ref2 = this.iterators;
          for (i = _k = 0, _len2 = _ref2.length; _k < _len2; i = ++_k) {
            iterator = _ref2[i];
            iterator.render();
          }
        }
        renderTarget(this, source);
        //<development>;
        _ref3 = this.logs;
        for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
          log = _ref3[_l];
          log.render();
        }
        //</development>;
        this.isRendered = true;
        File.onRender.emit(this);
        return this;
      };
    })();

    File.prototype.revert = (function() {
      var listeners, target;
      listeners = require('./file/render/revert/listeners')(File);
      target = require('./file/render/revert/target')(File);
      return function() {
        var i, input, iterator, use, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        assert.ok(this.isRendered);
        this.isRendered = false;
        File.onBeforeRevert.emit(this);
        if (this.inputs) {
          _ref = this.inputs;
          for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
            input = _ref[i];
            input.revert();
          }
        }
        if (this.uses) {
          _ref1 = this.uses;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            use = _ref1[_j];
            use.revert();
          }
        }
        if (this.iterators) {
          _ref2 = this.iterators;
          for (i = _k = 0, _len2 = _ref2.length; _k < _len2; i = ++_k) {
            iterator = _ref2[i];
            iterator.revert();
          }
        }
        target(this, this.source);
        this.storage = null;
        this.source = null;
        listeners(this);
        File.onRevert.emit(this);
        return this;
      };
    })();

    File.prototype.use = function(useName, view) {
      var elem, use, _i, _len, _ref;
      if (this.uses) {
        _ref = this.uses;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          use = _ref[_i];
          if (use.name === useName) {
            elem = use;
            break;
          }
        }
      }
      if (elem) {
        elem.render(view);
      } else {
        log.warn("`" + this.path + "` view doesn't have any `" + useName + "` neft:use");
      }
      return this;
    };

    File.prototype.clone = function() {
      var r;
      if (r = getFromPool(this.path)) {
        return r;
      } else {
        return this._clone();
      }
    };

    File.prototype._clone = function() {
      var attrChange, attrsToSet, clone, condition, func, i, id, input, iterator, name, node, use, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _len5, _len6, _m, _n, _o, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8;
      clone = Object.create(this);
      clone.clone = void 0;
      clone._tmp = getTmp();
      clone.uid = utils.uid();
      clone.isRendered = false;
      clone.readyToUse = true;
      clone.node = this.node.cloneDeep();
      clone.targetNode && (clone.targetNode = this.node.getCopiedElement(this.targetNode, clone.node));
      clone.parent = null;
      clone.storage = null;
      clone.source = null;
      signal.create(clone, 'onReplaceByUse');
      if (this.attrChanges) {
        clone.attrChanges = [];
        _ref = this.attrChanges;
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          attrChange = _ref[i];
          clone.attrChanges[i] = attrChange.clone(this, clone);
        }
      }
      if (this.inputs) {
        clone.inputs = [];
        _ref1 = this.inputs;
        for (i = _j = 0, _len1 = _ref1.length; _j < _len1; i = ++_j) {
          input = _ref1[i];
          clone.inputs[i] = input.clone(this, clone);
        }
      }
      if (this.conditions) {
        clone.conditions = [];
        _ref2 = this.conditions;
        for (i = _k = 0, _len2 = _ref2.length; _k < _len2; i = ++_k) {
          condition = _ref2[i];
          clone.conditions[i] = condition.clone(this, clone);
        }
      }
      if (this.iterators) {
        clone.iterators = [];
        _ref3 = this.iterators;
        for (i = _l = 0, _len3 = _ref3.length; _l < _len3; i = ++_l) {
          iterator = _ref3[i];
          clone.iterators[i] = iterator.clone(this, clone);
        }
      }
      if (this.uses) {
        clone.uses = [];
        _ref4 = this.uses;
        for (i = _m = 0, _len4 = _ref4.length; _m < _len4; i = ++_m) {
          use = _ref4[i];
          clone.uses[i] = use.clone(this, clone);
        }
      }
      if (this.ids) {
        clone.ids = {};
        _ref5 = this.ids;
        for (id in _ref5) {
          node = _ref5[id];
          clone.ids[id] = this.node.getCopiedElement(node, clone.node);
        }
      }
      if (this.funcs) {
        clone.funcs = {};
        _ref6 = this.funcs;
        for (name in _ref6) {
          func = _ref6[name];
          clone.funcs[name] = File.Func.bindFuncIntoGlobal(func, clone);
        }
      }
      if (this.attrsToSet) {
        clone.attrsToSet = [];
        _ref7 = this.attrsToSet;
        for (_n = 0, _len5 = _ref7.length; _n < _len5; _n++) {
          attrsToSet = _ref7[_n];
          clone.attrsToSet.push(attrsToSet.clone(this, clone));
        }
      }
      //<development>;
      clone.logs = [];
      _ref8 = this.logs;
      for (_o = 0, _len6 = _ref8.length; _o < _len6; _o++) {
        log = _ref8[_o];
        clone.logs.push(log.clone(this, clone));
      }
      //</development>;
      return clone;
    };

    File.prototype.destroy = function() {
      var pathPool, _name;
      if (this.isRendered) {
        this.revert();
      }
      pathPool = pool[_name = this.path] != null ? pool[_name] : pool[_name] = [];
      assert.notOk(utils.has(pathPool, this));
      pathPool.push(this);
    };

    File.prototype.toSimplifiedObject = function() {
      return utils.simplify(this, {
        properties: false,
        protos: false,
        constructors: true
      });
    };

    File.prototype.toJSON = function() {
      var ctor, ctors, i, json, _ref;
      json = this.toSimplifiedObject();
      _ref = ctors = json.constructors;
      for (i in _ref) {
        ctor = _ref[i];
        ctors[i] = ctor.__path__;
      }
      return json;
    };

    return File;

  })();

}).call(this);


return module.exports;
})();modules['../document/index.coffee.md'] = (function(){
var module = {exports: modules["../document/index.coffee.md"]};
var require = getModule.bind(null, {"./file":"../document/file.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = require('./file');

}).call(this);


return module.exports;
})();modules['../networking/impl/node/response.coffee'] = (function(){
var module = {exports: modules["../networking/impl/node/response.coffee"]};
var require = getModule.bind(null, {"log":"../log/index.coffee.md","utils":"../utils/index.coffee.md","document":"../document/index.coffee.md","expect":"node_modules/expect/index.coffee.md","form-data":"../networking/node_modules/form-data/lib/form_data.js"});
var exports = module.exports;

(function() {
  'use strict';
  var Document, FormData, GZIP_ENCODING_HEADERS, HEADERS, METHOD_HEADERS, expect, log, parsers, path, prepareData, sendData, setHeaders, utils, zlib;

  zlib = require('zlib');

  log = require('log');

  utils = require('utils');

  path = require('path');

  Document = require('document');

  expect = require('expect');

  FormData = require('form-data');

  log = log.scope('Networking');

  HEADERS = {
    'Host': function(obj) {
      var host;
      host = /^(?:[a-z]+):\/\/(.+?)(?:\/)?$/.exec(obj.networking.url);
      if (host) {
        return host[1];
      } else {
        return obj.networking.url;
      }
    },
    'Cache-Control': 'no-cache',
    'Content-Language': function(obj) {
      return obj.networking.language;
    },
    'X-Frame-Options': 'deny'
  };

  METHOD_HEADERS = {
    OPTIONS: {
      'Access-Control-Allow-Origin': function(obj) {
        return obj.networking.url;
      },
      'Allow': 'GET, POST, PUT, DELETE'
    }
  };

  GZIP_ENCODING_HEADERS = {
    'Content-Encoding': 'gzip'
  };


  /*
  Set headers in the server response
   */

  setHeaders = function(res, headers, ctx) {
    var name, value;
    for (name in headers) {
      value = headers[name];
      if (res.getHeader(name) == null) {
        if (typeof value === 'function') {
          value = value(ctx);
        }
        res.setHeader(name, value);
      }
    }
  };


  /*
  Parse passed data into expected type
   */

  parsers = {
    'text': function(data) {
      return data + '';
    },
    'json': function(data) {
      if (data instanceof Error) {
        data = utils.errorToObject(data);
      }
      try {
        return JSON.stringify(data);
      } catch (_error) {
        return data;
      }
    },
    'html': function(data) {
      if (data instanceof Document) {
        return data.node.stringify();
      } else {
        return data;
      }
    },
    'binary': function(data) {
      var formData, key, val;
      formData = new FormData;
      for (key in data) {
        val = data[key];
        formData.append(key, val);
      }
      return formData;
    }
  };

  prepareData = function(type, res, data) {
    var mimeType, parsedData;
    switch (type) {
      case 'text':
        mimeType = 'text/plain; charset=utf-8';
        break;
      case 'json':
        mimeType = 'application/json; charset=utf-8';
        break;
      case 'html':
        mimeType = 'text/html; charset=utf-8';
    }
    parsedData = parsers[type](data);
    if ((mimeType != null) && (res.getHeader('Content-Type') == null)) {
      res.setHeader('Content-Type', "" + mimeType + "; charset=utf-8");
    }
    return parsedData;
  };


  /*
  Send data in server response
   */

  sendData = (function() {
    var senders;
    senders = {
      'text': (function() {
        var send;
        send = function(res, data) {
          var len;
          if (typeof data === 'string') {
            len = Buffer.byteLength(data);
          } else {
            len = data && data.length;
          }
          if (isFinite(len)) {
            res.setHeader('Content-Length', len);
          }
          return res.end(data);
        };
        return function(req, res, data, callback) {
          var acceptEncodingHeader, useGzip;
          acceptEncodingHeader = req != null ? req.headers['Accept-Encoding'] : void 0;
          useGzip = acceptEncodingHeader && utils.has(acceptEncodingHeader, 'gzip');
          if (!useGzip) {
            send(res, data);
            return callback();
          }
          return zlib.gzip(data, function(err, gzipData) {
            if (err) {
              send(res, data);
            } else {
              setHeaders(res, GZIP_ENCODING_HEADERS);
              send(res, gzipData);
            }
            return callback();
          });
        };
      })(),
      'binary': function(req, res, data, callback) {
        setHeaders(res, data.getHeaders());
        return data.getLength(function(err, length) {
          if (err) {
            return callback(err);
          }
          res.setHeader('Content-Length', length);
          return data.pipe(res);
        });
      }
    };
    return function(type, req, res, data, callback) {
      var sender;
      sender = senders[type] || senders.text;
      return sender(req, res, data, callback);
    };
  })();

  module.exports = function(Networking, pending) {
    var exports;
    return exports = {
      _prepareData: prepareData,
      _sendData: sendData,
      setHeader: function(res, name, val) {
        var obj;
        if ((name != null) && (val != null)) {
          obj = pending[res.request.uid];
          return obj.serverRes.setHeader(name, val);
        }
      },
      send: function(res, data, callback) {
        var cookies, headers, obj, serverReq, serverRes, type;
        obj = pending[res.request.uid];
        if (!obj) {
          return;
        }
        delete pending[res.request.uid];
        serverReq = obj.serverReq, serverRes = obj.serverRes;
        setHeaders(serverRes, HEADERS, obj);
        if (headers = METHOD_HEADERS[serverReq.method]) {
          setHeaders(serverRes, headers);
        }
        serverRes.statusCode = res.status;
        if (cookies = utils.tryFunction(JSON.stringify, null, [res.cookies], null)) {
          serverRes.setHeader('X-Cookies', cookies);
        }
        type = res.request.type;
        data = prepareData(type, serverRes, data);
        return sendData(type, serverReq, serverRes, data, function(err) {
          return callback(err);
        });
      },
      redirect: function(res, status, uri, callback) {
        return exports.send(res, null, callback);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../networking/uri.coffee.md'] = (function(){
var module = {exports: modules["../networking/uri.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","dict":"../dict/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, assert, utils;

  utils = require('utils');

  assert = require('assert');

  Dict = require('dict');

  assert = assert.scope('Networking.Uri');

  module.exports = function(Networking) {
    var Uri;
    return Uri = (function() {
      Uri.URI_TRIM_RE = /^\/?(.*?)\/?$/;

      Uri.NAMES_RE = /{([a-zA-Z0-9_$]+)\*?}/g;

      function Uri(uri) {
        var exec, names, re;
        assert.isString(uri, 'ctor uri argument ...');
        this.params = {};
        uri = Uri.URI_TRIM_RE.exec(uri)[1];
        utils.defineProperty(this, '_uri', null, "/" + uri);
        names = [];
        while ((exec = Uri.NAMES_RE.exec(uri)) != null) {
          names.push(exec[1]);
          this.params[exec[1]] = null;
        }
        utils.defineProperty(this, '_names', null, names);
        re = uri;
        re = re.replace(/(\?)/g, '\\$1');
        re = re.replace(/{?([a-zA-Z0-9_$]+)?\*}?/g, function() {
          return "(.*?)";
        });
        re = re.replace(Uri.NAMES_RE, function() {
          return "([^/]+?)";
        });
        re = new RegExp("^\/?" + re + "\/?$");
        utils.defineProperty(this, '_re', null, re);
        Object.freeze(this);
        Object.preventExtensions(this.params);
      }

      Uri.prototype.params = null;

      Uri.prototype.test = function(uri) {
        return this._re.test(uri);
      };

      Uri.prototype.match = function(uri) {
        var exec, i, name, val, _i, _len, _ref;
        assert.ok(this.test(uri));
        exec = this._re.exec(uri);
        _ref = this._names;
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          name = _ref[i];
          val = exec[i + 1];
          if (val === void 0) {
            val = null;
          }
          this.params[name] = decodeURI(val);
        }
        return this.params;
      };

      Uri.prototype.toString = function(params) {
        var i;
        if (params != null) {
          assert.isObject(params, 'toString() params argument ...');
        } else {
          return this._uri;
        }
        if (params instanceof Dict) {
          params = params._data;
        }
        i = 0;
        return this._uri.replace(Uri.NAMES_RE, (function(_this) {
          return function() {
            return encodeURI(params[_this._names[i++]]);
          };
        })(this));
      };

      return Uri;

    })();
  };

}).call(this);


return module.exports;
})();modules['../networking/handler.coffee.md'] = (function(){
var module = {exports: modules["../networking/handler.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","schema":"../schema/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Schema, assert, log, parse, stringify, utils;

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  Schema = require('schema');

  parse = JSON.parse, stringify = JSON.stringify;

  assert = assert.scope('Networking.Handler');

  log = log.scope('Networking', 'Handler');

  module.exports = function(Networking) {
    var Handler;
    return Handler = (function() {
      function Handler(opts) {
        assert.isPlainObject(opts, 'ctor options argument ...');
        assert.ok(utils.has(Networking.Request.METHODS, opts.method), 'ctor options.method argument ...');
        assert.instanceOf(opts.uri, Networking.Uri, 'ctor options.uri argument ...');
        if (opts.schema != null) {
          assert.instanceOf(opts.schema, Schema, 'ctor options.schema argument ...');
        }
        assert.isFunction(opts.callback, 'ctor options.callback argument ...');
        this.method = opts.method, this.uri = opts.uri, this.schema = opts.schema, this.callback = opts.callback;
      }

      Handler.prototype.method = '';

      Handler.prototype.uri = null;

      Handler.prototype.schema = null;

      Handler.prototype.callback = null;

      Handler.prototype.exec = function(req, res, next) {
        var callbackNext, err, key, params, schemaOpts, _ref;
        assert.instanceOf(req, Networking.Request, '::exec request argument ...');
        assert.instanceOf(res, Networking.Response, '::exec response argument ...');
        assert.isFunction(next, '::exec next argument ...');
        if (this.method !== req.method) {
          return next();
        }
        if (!this.uri.test(req.uri)) {
          return next();
        }
        params = req.params = this.uri.match(req.uri);
        if (this.schema) {
          _ref = this.schema.schema;
          for (key in _ref) {
            schemaOpts = _ref[key];
            if (params.hasOwnProperty(key) && schemaOpts.type && schemaOpts.type !== 'string') {
              params[key] = utils.tryFunction(parse, null, [params[key]], params[key]);
            }
          }
          err = utils.catchError(this.schema.validate, this.schema, [params]);
          if (err instanceof Error) {
            return next(err);
          }
        }
        callbackNext = (function(_this) {
          return function(err) {
            var errMsg;
            req.handler = null;
            if ((err != null) && err !== true) {
              errMsg = err;
              if (errMsg.stack != null) {
                if (utils.isQml) {
                  errMsg = "" + err.message + "\n" + err.stack;
                } else {
                  errMsg = err.stack;
                }
              } else if (utils.isObject(errMsg)) {
                errMsg = utils.tryFunction(JSON.stringify, null, [errMsg], errMsg);
              }
            }
            if (errMsg) {
              log.error("Error in '" + _this.uri + "': " + errMsg);
              if (err instanceof RangeError || err instanceof TypeError || err instanceof SyntaxError || err instanceof ReferenceError) {
                errMsg = "Internal Error; message has been removed";
              }
              return next(errMsg);
            } else {
              return next();
            }
          };
        })(this);
        req.handler = this;
        utils.tryFunction(this.callback, this, [req, res, callbackNext], callbackNext);
        return null;
      };

      Handler.prototype.toString = function() {
        return "" + this.method + " " + this.uri;
      };

      return Handler;

    })();
  };

}).call(this);


return module.exports;
})();modules['../networking/request.coffee.md'] = (function(){
var module = {exports: modules["../networking/request.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  assert = assert.scope('Networking.Request');

  module.exports = function(Networking, Impl) {
    var Request;
    return Request = (function(_super) {
      __extends(Request, _super);

      Request.METHODS = [(Request.GET = 'get'), (Request.POST = 'post'), (Request.PUT = 'put'), (Request.DELETE = 'delete'), (Request.OPTIONS = 'options')];

      Request.TYPES = [(Request.TEXT_TYPE = 'text'), (Request.JSON_TYPE = 'json'), (Request.HTML_TYPE = 'html'), (Request.BINARY_TYPE = 'binary')];

      function Request(opts) {
        var uid, _ref;
        assert.isPlainObject(opts, 'ctor options argument ...');
        if (opts.uid != null) {
          assert.isString(opts.uid);
        }
        if (opts.method != null) {
          assert.ok(utils.has(Request.METHODS, opts.method));
        }
        assert.isString(opts.uri, 'ctor options.uri argument ...');
        Request.__super__.constructor.call(this);
        if (((_ref = opts.uri) != null ? _ref.toString : void 0) != null) {
          opts.uri = opts.uri.toString();
        }
        if (opts.type != null) {
          assert.ok(utils.has(Request.TYPES, opts.type), 'ctor options.type argument ...');
          this.type = opts.type;
        }
        utils.defineProperty(this, 'type', utils.ENUMERABLE, this.type);
        this.data = opts.data, this.uri = opts.uri;
        if (opts.method != null) {
          this.method = opts.method;
        }
        this.headers = opts.headers || {};
        this.cookies = opts.cookies || {};
        uid = opts.uid || utils.uid();
        utils.defineProperty(this, 'uid', null, uid);
        this.pending = true;
        this.params = null;
        if (opts.onLoadEnd) {
          this.onLoadEnd(opts.onLoadEnd);
        }
      }

      signal.Emitter.createSignal(Request, 'onLoadEnd');

      Request.prototype.uid = '';

      Request.prototype.pending = false;

      Request.prototype.method = Request.GET;

      Request.prototype.uri = '';

      Request.prototype.type = Request.JSON_TYPE;

      Request.prototype.data = null;

      Request.prototype.handler = null;

      Request.prototype.response = null;

      Request.prototype.params = null;

      Request.prototype.headers = null;

      Request.prototype.cookies = null;

      Request.prototype.toString = function() {
        return "" + this.method + " " + this.uri + " as " + this.type;
      };

      Request.prototype.destroy = function() {
        var res;
        assert(this.pending);
        this.pending = false;
        res = this.response;
        if (res.isSucceed()) {
          this.onLoadEnd.emit(null, res.data);
        } else {
          this.onLoadEnd.emit(res.data || res.status || "Unknown error");
        }
      };

      return Request;

    })(signal.Emitter);
  };

}).call(this);


return module.exports;
})();modules['../networking/response.coffee.md'] = (function(){
var module = {exports: modules["../networking/response.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","./response/error.coffee.md":"../networking/response/error.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  signal = require('signal');

  assert = assert.scope('Networking.Response');

  log = log.scope('Networking', 'Response');

  module.exports = function(Networking, Impl) {
    var Response;
    return Response = (function(_super) {
      __extends(Response, _super);

      Response.STATUSES = [(Response.OK = 200), (Response.CREATED = 201), (Response.ACCEPTED = 202), (Response.NO_CONTENT = 204), (Response.MOVED = 301), (Response.FOUND = 302), (Response.NOT_MODIFIED = 304), (Response.TEMPORARY_REDIRECT = 307), (Response.BAD_REQUEST = 400), (Response.UNAUTHORIZED = 401), (Response.PAYMENT_REQUIRED = 402), (Response.FORBIDDEN = 403), (Response.NOT_FOUND = 404), (Response.METHOD_NOT_ALLOWED = 405), (Response.NOT_ACCEPTABLE = 406), (Response.CONFLICT = 409), (Response.PRECONDITION_FAILED = 412), (Response.UNSUPPORTED_MEDIA_TYPE = 415), (Response.INTERNAL_SERVER_ERROR = 500), (Response.NOT_IMPLEMENTED = 501), (Response.SERVICE_UNAVAILABLE = 503)];

      Response.Error = require('./response/error.coffee.md')(Networking, Response);

      function Response(opts) {
        assert.isPlainObject(opts, 'ctor options argument ...');
        assert.instanceOf(opts.request, Networking.Request, 'ctor options.request argument ...');
        Response.__super__.constructor.call(this);
        if (opts.status != null) {
          assert.ok(utils.has(Response.STATUSES, opts.status), 'ctor options.status argument ...');
          this.status = opts.status;
        }
        if (opts.data != null) {
          this.data = opts.data;
        }
        if (opts.encoding != null) {
          this.encoding = opts.encoding;
        }
        this.headers = opts.headers || {};
        this.cookies = opts.cookies || {};
        utils.defineProperty(this, 'request', null, opts.request);
        this.pending = true;
        if (opts.onSend) {
          this.onSend(opts.onSend);
        }
        if (opts.status != null) {
          this.send();
        }
      }

      signal.Emitter.createSignal(Response, 'onSend');

      Response.prototype.pending = false;

      Response.prototype.request = null;

      Response.prototype.status = Response.OK;

      Response.prototype.data = null;

      Response.prototype.headers = null;

      Response.prototype.cookies = null;

      Response.prototype.encoding = 'utf-8';

      Response.prototype.setHeader = function(name, val) {
        assert.ok(this.request.pending);
        assert.isString(name, '::setHeader name argument ...');
        assert.notLengthOf(name, 0, '::setHeader name argument ...');
        assert.isString(val, '::setHeader value argument ...');
        assert.notLengthOf(val, 0, '::setHeader value argument ...');
        Impl.setHeader(this, name, val);
        return this;
      };

      Response.prototype.send = function(status, data) {
        assert.ok(this.request.pending);
        if ((data == null) && typeof status !== 'number') {
          data = status;
          status = this.status;
        }
        if (status != null) {
          assert.ok(utils.has(Response.STATUSES, status));
          this.status = status;
        }
        if (data !== void 0) {
          this.data = data;
        }
        this.request.destroy();
        data = this.data;
        Impl.send(this, data, (function(_this) {
          return function() {
            _this.pending = false;
            return _this.onSend.emit();
          };
        })(this));
      };

      Response.prototype.redirect = function(status, uri) {
        if (uri === void 0) {
          uri = status;
          status = Response.FOUND;
        }
        assert.ok(this.request.pending);
        assert.ok(utils.has(Response.STATUSES, status));
        assert.isString(uri);
        log("" + status + " redirect to '" + uri + "'");
        this.status = status;
        this.setHeader('Location', uri);
        this.request.destroy();
        return Impl.redirect(this, status, uri, (function(_this) {
          return function() {
            _this.pending = false;
            return _this.onSend.emit();
          };
        })(this));
      };

      Response.prototype.raise = function(error) {
        if (error instanceof Response.Error || isFinite(error != null ? error.status : void 0)) {
          return this.send(error.status, error);
        } else {
          return this.send(Response.INTERNAL_SERVER_ERROR, error);
        }
      };

      Response.prototype.isSucceed = function() {
        var _ref;
        return (300 > (_ref = this.status) && _ref >= 200);
      };

      return Response;

    })(signal.Emitter);
  };

}).call(this);


return module.exports;
})();modules['../networking/response/error.coffee.md'] = (function(){
var module = {exports: modules["../networking/response/error.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var RequestResolve, assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  assert = assert.scope('Networking.Response.Error');

  module.exports = function(Networking, Response) {
    var ResponseError;
    return ResponseError = (function(_super) {
      __extends(ResponseError, _super);

      ResponseError.RequestResolve = RequestResolve(Networking, Response, ResponseError);

      function ResponseError(status, message) {
        if (message == null) {
          message = '';
        }
        if (!(this instanceof ResponseError)) {
          return new ResponseError(status, message);
        }
        if (typeof status === 'string') {
          message = status;
          status = this.status;
        } else if (status === void 0) {
          status = this.status;
          message = this.message;
        }
        assert.ok(utils.has(Response.STATUSES, status));
        assert.isString(message);
        this.status = status;
        this.message = message;
      }

      ResponseError.prototype.status = Response.INTERNAL_SERVER_ERROR;

      ResponseError.prototype.name = 'ResponseError';

      ResponseError.prototype.message = '';

      return ResponseError;

    })(Error);
  };

  RequestResolve = function(Networking, Response, ResponseError) {
    return RequestResolve = (function(_super) {
      __extends(RequestResolve, _super);

      function RequestResolve(req) {
        assert.instanceOf(req, Networking.Request, 'ctor request argument ...');
        return RequestResolve.__super__.constructor.call(this, "No handler can be found");
      }

      RequestResolve.prototype.status = Response.BAD_REQUEST;

      RequestResolve.prototype.name = 'RequestResolveResponseError';

      return RequestResolve;

    })(ResponseError);
  };

}).call(this);


return module.exports;
})();modules['../networking/index.coffee.md'] = (function(){
var module = {exports: modules["../networking/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","list":"../list/index.coffee.md","./impl":"../networking/impl.coffee","./uri.coffee.md":"../networking/uri.coffee.md","./handler.coffee.md":"../networking/handler.coffee.md","./request.coffee.md":"../networking/request.coffee.md","./response.coffee.md":"../networking/response.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, Networking, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('neft-assert');

  log = require('log');

  List = require('list');

  assert = assert.scope('Networking');

  log = log.scope('Networking');

  module.exports = Networking = (function(_super) {
    var EXTERNAL_URL_RE, Impl;

    __extends(Networking, _super);

    Impl = require('./impl')(Networking);

    Networking.Uri = require('./uri.coffee.md')(Networking);

    Networking.Handler = require('./handler.coffee.md')(Networking);

    Networking.Request = require('./request.coffee.md')(Networking, Impl.Request);

    Networking.Response = require('./response.coffee.md')(Networking, Impl.Response);

    Networking.TYPES = [(Networking.HTTP = 'http')];

    function Networking(opts) {
      var url;
      assert.isPlainObject(opts, 'ctor options argument ....');
      assert.isString(opts.type, 'ctor options.type argument ...');
      assert.ok(utils.has(Networking.TYPES, opts.type));
      assert.isString(opts.protocol, 'ctor options.protocol argument ...');
      assert.notLengthOf(opts.protocol, 0, 'ctor options.protocol argument ...');
      assert.isInteger(opts.port, 'ctor options.port argument ...');
      assert.isString(opts.host, 'ctor options.host argument ...');
      assert.isString(opts.language, 'ctor options.language argument ...');
      assert.notLengthOf(opts.language, 0, 'ctor options.language argument ...');
      utils.defineProperty(this, '_handlers', utils.CONFIGURABLE, {});
      this.type = opts.type, this.protocol = opts.protocol, this.port = opts.port, this.host = opts.host, this.language = opts.language;
      this.pendingRequests = new List;
      if (opts.url != null) {
        assert.isString(opts.url);
        assert.notLengthOf(opts.url, 0);
        url = opts.url;
        if (url[url.length - 1] === '/') {
          url = url.slice(0, -1);
        }
      } else {
        url = "" + this.protocol + "://" + this.host + ":" + this.port;
      }
      utils.defineProperty(this, 'url', utils.ENUMERABLE, url);
      setImmediate((function(_this) {
        return function() {
          return Impl.init(_this);
        };
      })(this));
      log.info("Start as `" + this.host + ":" + this.port + "`");
      Networking.__super__.constructor.call(this);
      Object.freeze(this);
    }

    Networking.prototype.type = Networking.HTTP;

    signal.Emitter.createSignal(Networking, 'onRequest');

    Networking.prototype.protocol = '';

    Networking.prototype.port = 0;

    Networking.prototype.host = '';

    Networking.prototype.url = '';

    Networking.prototype.language = '';

    Networking.prototype.createHandler = function(opts) {
      var handler, stack, uri, _base, _name;
      assert.instanceOf(this, Networking);
      assert.isPlainObject(opts, '::createHandler options argument ...');
      uri = opts.uri;
      if (!(uri instanceof Networking.Uri)) {
        uri = new Networking.Uri(uri);
      }
      handler = new Networking.Handler({
        method: opts.method,
        uri: uri,
        schema: opts.schema,
        callback: opts.callback
      });
      stack = (_base = this._handlers)[_name = opts.method] != null ? _base[_name] : _base[_name] = [];
      stack.push(handler);
      return handler;
    };

    Networking.prototype.createRequest = function(opts) {
      var logtime, req, res, resOpts;
      assert.instanceOf(this, Networking);
      assert.isPlainObject(opts, '::createRequest options argument ...');
      opts.uri || (opts.uri = '');
      if (opts.uri.toString != null) {
        opts.uri = opts.uri.toString();
      }
      if (!EXTERNAL_URL_RE.test(opts.uri)) {
        if (opts.uri[0] !== '/') {
          opts.uri = "/" + opts.uri;
        }
        opts.uri = "" + this.url + opts.uri;
      }
      req = new Networking.Request(opts);
      logtime = log.time(utils.capitalize("" + req));
      req.onLoadEnd((function(_this) {
        return function() {
          _this.pendingRequests.remove(req);
          return log.end(logtime);
        };
      })(this));
      resOpts = utils.isObject(opts.response) ? opts.response : {};
      resOpts.request = req;
      res = new Networking.Response(resOpts);
      req.response = res;
      this.pendingRequests.append(req);
      this.onRequest.emit(req, res);
      Impl.sendRequest(req, res, function(opts) {
        utils.merge(res, opts);
        res.pending = false;
        return req.destroy();
      });
      return req;
    };

    Networking.prototype.get = function(uri, onLoadEnd) {
      return this.createRequest({
        method: 'get',
        uri: uri,
        onLoadEnd: onLoadEnd
      });
    };

    Networking.prototype.post = function(uri, data, onLoadEnd) {
      if (typeof data === 'function' && !onLoadEnd) {
        onLoadEnd = data;
        data = null;
      }
      return this.createRequest({
        method: 'post',
        uri: uri,
        data: data,
        onLoadEnd: onLoadEnd
      });
    };

    Networking.prototype.put = function(uri, data, onLoadEnd) {
      if (typeof data === 'function' && !onLoadEnd) {
        onLoadEnd = data;
        data = null;
      }
      return this.createRequest({
        method: 'put',
        uri: uri,
        data: data,
        onLoadEnd: onLoadEnd
      });
    };

    Networking.prototype["delete"] = function(uri, onLoadEnd) {
      var data;
      if (typeof data === 'function' && !onLoadEnd) {
        onLoadEnd = data;
        data = null;
      }
      return this.createRequest({
        method: 'delete',
        uri: uri,
        data: data,
        onLoadEnd: onLoadEnd
      });
    };

    EXTERNAL_URL_RE = /^[a-zA-Z]+:\/\//;

    Networking.prototype.createLocalRequest = function(opts) {
      var err, handlers, noHandlersError, onError, req, res, resOpts;
      assert.instanceOf(this, Networking);
      assert.isPlainObject(opts, '::createLocalRequest options argument ...');
      req = new Networking.Request(opts);
      req.onLoadEnd((function(_this) {
        return function() {
          return _this.pendingRequests.remove(req);
        };
      })(this));
      resOpts = utils.isObject(opts.response) ? opts.response : {};
      resOpts.request = req;
      res = new Networking.Response(resOpts);
      req.response = res;
      this.pendingRequests.append(req);
      this.onRequest.emit(req, res);
      log("Resolve local `" + req + "` request");
      onError = function(err) {
        if (!req.pending) {
          return;
        }
        if (err && (typeof err === 'object' || typeof err === 'string' || typeof err === 'number')) {
          return res.raise(err);
        } else {
          return res.raise(Networking.Response.Error.RequestResolve(req));
        }
      };
      noHandlersError = function() {
        log.warn("No handler found for request `" + req + "`");
        return onError();
      };
      handlers = this._handlers[req.method];
      if (handlers) {
        err = null;
        utils.async.forEach(handlers, function(handler, i, handlers, next) {
          return handler.exec(req, res, function(_err) {
            if (_err != null) {
              err = _err;
            }
            return next();
          });
        }, function() {
          if (err) {
            return onError(err);
          } else {
            return noHandlersError();
          }
        });
      } else {
        noHandlersError();
      }
      return req;
    };

    return Networking;

  })(signal.Emitter);

}).call(this);


return module.exports;
})();modules['route.coffee.md'] = (function(){
var module = {exports: modules["route.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","log":"../log/index.coffee.md","schema":"../schema/index.coffee.md","networking":"../networking/index.coffee.md","document":"../document/index.coffee.md","dict":"../dict/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, Document, Networking, Schema, assert, log, utils;

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  Schema = require('schema');

  Networking = require('networking');

  Document = require('document');

  Dict = require('dict');

  log = log.scope('App', 'Route');

  module.exports = function(app) {
    var Route;
    return Route = (function() {
      var callNextIfNeeded, createToHTMLFromObject, destroyRoute, factoryRoute, finishRequest, getRouteName, handleRequest, lastClientHTMLRoute, onResponseSent, pendingRoutes, prepareRouteData, renderViewFromConfig, resolveAsyncGetDataFuncCallback, resolveSyncGetDataFunc, routesCache, templates, usedTemplates;

      if (utils.isNode) {
        usedTemplates = [];
      } else {
        templates = Object.create(null);
      }

      lastClientHTMLRoute = null;

      function Route(method, uri, opts) {
        var key, spaceIndex, val;
        if (utils.isObject(method)) {
          opts = method;
        } else if (utils.isObject(uri)) {
          opts = uri;
        } else if (!utils.isObject(opts)) {
          opts = {};
        }
        if (typeof method === 'string' && typeof uri !== 'string') {
          opts.uri = method;
        } else if (typeof method === 'string' && typeof uri === 'string') {
          if (opts.method == null) {
            opts.method = method;
          }
          if (opts.uri == null) {
            opts.uri = uri;
          }
        }
        if (typeof uri === 'function') {
          if (opts.getData == null) {
            opts.getData = uri;
          }
        }
        assert.isObject(opts);
        opts = utils.clone(opts);
        if (typeof opts.uri === 'string') {
          spaceIndex = opts.uri.indexOf(' ');
          if (spaceIndex !== -1) {
            if (opts.method == null) {
              opts.method = opts.uri.slice(0, spaceIndex);
            }
            opts.uri = opts.uri.slice(spaceIndex + 1);
          }
          opts.uri = new Networking.Uri(opts.uri);
        }
        assert.instanceOf(opts.uri, Networking.Uri);
        if (opts.method == null) {
          opts.method = 'get';
        }
        assert.isString(opts.method);
        opts.method = opts.method.toLowerCase();
        assert.ok(utils.has(Networking.Request.METHODS, opts.method), "Networking doesn't provide a `" + opts.method + "` method");
        if (opts.schema != null) {
          if (utils.isPlainObject(opts.schema)) {
            opts.schema = new Schema(opts.schema);
          }
          assert.instanceOf(opts.schema, Schema);
        }
        if (opts.redirect != null) {
          if (typeof opts.redirect === 'string') {
            opts.redirect = new Networking.Uri(opts.redirect);
          } else {
            assert.isFunction(opts.redirect);
          }
        }
        if (utils.isObject(opts.toHTML)) {
          opts.toHTML = createToHTMLFromObject(opts.toHTML);
        }
        for (key in opts) {
          val = opts[key];
          this[key] = val;
        }
        this.__id__ = utils.uid();
        this.app = app;
        this.name || (this.name = getRouteName(this));
        app.networking.createHandler({
          method: this.method,
          uri: this.uri,
          schema: this.schema,
          callback: utils.bindFunctionContext(handleRequest, this)
        });
      }

      getRouteName = function(route) {
        var uri;
        assert.instanceOf(route, Route);
        uri = route.uri._uri;
        uri = uri.replace(Networking.Uri.NAMES_RE, '');
        uri = uri.replace(/\*/g, '');
        while (uri.indexOf('//') !== -1) {
          uri = uri.replace(/\/\//g, '/');
        }
        uri = uri.replace(/^\//, '');
        uri = uri.replace(/\/$/, '');
        return uri;
      };

      routesCache = Object.create(null);

      pendingRoutes = Object.create(null);

      factoryRoute = (function() {
        var createInstance;
        createInstance = function(route) {
          var r;
          r = Object.create(route);
          r.__hash__ = utils.uid();
          if (typeof r.factory === "function") {
            r.factory();
          }
          return r;
        };
        return function(route) {
          var id, r;
          assert.instanceOf(route, Route);
          id = route.__id__;
          if (routesCache[id] == null) {
            routesCache[id] = [];
          }
          r = routesCache[id].pop() || createInstance(route);
          r = Object.create(r);
          r.request = r.response = null;
          r.route = r;
          r._dataPrepared = false;
          r._destroyViewOnEnd = false;
          return r;
        };
      })();

      destroyRoute = function(route) {
        assert.instanceOf(route, Route);
        if (lastClientHTMLRoute === route) {
          lastClientHTMLRoute = null;
        }
        route.response.onSend.disconnect(onResponseSent, route);
        pendingRoutes[route.__hash__] = false;
        if (typeof route.destroy === "function") {
          route.destroy();
        }
        if (route._dataPrepared) {
          switch (route.request.type) {
            case 'text':
              if (typeof route.destroyText === "function") {
                route.destroyText();
              }
              break;
            case 'json':
              if (typeof route.destroyJSON === "function") {
                route.destroyJSON();
              }
              break;
            case 'html':
              if (typeof route.destroyHTML === "function") {
                route.destroyHTML();
              }
          }
        }
        if (route._destroyViewOnEnd) {
          route.response.data.destroy();
        }
        return routesCache[route.__id__].push(Object.getPrototypeOf(route));
      };

      resolveSyncGetDataFunc = function(route) {
        var data, err;
        assert.instanceOf(route, Route);
        try {
          data = route.getData();
          if (data != null) {
            return route.data = data;
          }
        } catch (_error) {
          err = _error;
          if (route.response.status === 200) {
            route.response.status = 500;
          }
          return route.error = err;
        }
      };

      resolveAsyncGetDataFuncCallback = function(route, err, data) {
        assert.instanceOf(route, Route);
        if (err != null) {
          if (route.response.status === 200) {
            route.response.status = 500;
          }
          if (route._dataPrepared && route.error === err) {
            return false;
          }
          console.error(err);
          route.error = err;
        } else {
          if (route._dataPrepared && route.data === data) {
            return false;
          }
          route.data = data;
        }
        return true;
      };

      prepareRouteData = function(route) {
        var data, respData, response;
        assert.instanceOf(route, Route);
        response = route.response;
        respData = response.data;
        switch (route.request.type) {
          case 'text':
            data = route.toText();
            break;
          case 'json':
            data = route.toJSON();
            break;
          case 'html':
            data = route.toHTML();
            if (respData instanceof Document && route._destroyViewOnEnd) {
              respData.destroy();
              response.data = null;
            }
            if (!(data instanceof Document) && response.data === respData) {
              data = renderViewFromConfig.call(route, data);
            }
        }
        route._dataPrepared = true;
        if (data != null) {
          return response.data = data;
        } else if (response.data === respData) {
          return response.data = '';
        }
      };

      onResponseSent = function() {
        if (utils.isNode || this.request.type !== 'html') {
          destroyRoute(this);
          if (utils.isNode && utils.has(usedTemplates, this.response.data)) {
            this.response.data.destroy();
            utils.remove(usedTemplates, this.response.data);
          }
        }
      };

      finishRequest = function(route) {
        assert.instanceOf(route, Route);
        if (route.response.pending) {
          route.response.send();
        }
      };

      callNextIfNeeded = function(route, next) {
        if (!pendingRoutes[route.__hash__]) {
          if (route.response.pending) {
            next();
          }
          return true;
        }
        return false;
      };

      handleRequest = function(req, res, next) {
        var fakeAsync, getData, hash, redirect, route;
        assert.instanceOf(req, Networking.Request);
        assert.instanceOf(res, Networking.Response);
        assert.isFunction(next);
        route = factoryRoute(this);
        hash = route.__hash__;
        assert.notOk(pendingRoutes[hash]);
        if (utils.isClient) {
          if (lastClientHTMLRoute) {
            destroyRoute(lastClientHTMLRoute);
          }
          lastClientHTMLRoute = route;
        }
        route.request = req;
        route.response = res;
        pendingRoutes[hash] = true;
        res.onSend(onResponseSent, route);
        if (typeof route.init === "function") {
          route.init();
        }
        if (!pendingRoutes[hash]) {
          return next();
        }
        redirect = route.redirect;
        if (typeof redirect === 'function') {
          redirect = route.redirect();
          if (!pendingRoutes[hash]) {
            return next();
          }
        }
        if (typeof redirect === 'string') {
          redirect = new Networking.Uri(redirect);
        }
        if (redirect instanceof Networking.Uri) {
          res.redirect(redirect.toString(req.params));
          return;
        }
        getData = route.getData;
        fakeAsync = false;
        if (typeof getData === 'function') {
          if (getData.length === 1) {
            route.getData(function(err, data) {
              fakeAsync = true;
              if (callNextIfNeeded(route, next)) {
                return;
              }
              if (!resolveAsyncGetDataFuncCallback(route, err, data)) {
                return;
              }
              prepareRouteData(route);
              if (callNextIfNeeded(route, next)) {
                return;
              }
              return finishRequest(route);
            });
          } else {
            resolveSyncGetDataFunc(route);
            if (callNextIfNeeded(route, next)) {
              return;
            }
            prepareRouteData(route);
            if (callNextIfNeeded(route, next)) {
              return;
            }
            finishRequest(route);
          }
        } else {
          prepareRouteData(route);
          if (callNextIfNeeded(route, next)) {
            return;
          }
          finishRequest(route);
        }
        if (!fakeAsync && callNextIfNeeded(route, next)) {

        }
      };

      Route.prototype.next = function() {
        assert.ok(pendingRoutes[this.__hash__]);
        return destroyRoute(this);
      };

      Route.prototype.toJSON = function() {
        var _base, _ref;
        if (this.response.status < 400) {
          return ((_ref = this.data) != null ? typeof _ref.toJSON === "function" ? _ref.toJSON() : void 0 : void 0) || this.data;
        } else {
          return (typeof (_base = this.error).toJSON === "function" ? _base.toJSON() : void 0) || this.error;
        }
      };

      Route.prototype.toText = function() {
        if (this.response.status < 400) {
          return this.data + '';
        } else {
          return this.error + '';
        }
      };

      renderViewFromConfig = function(opts) {
        var logtime, r, tmpl, tmplName, tmplView, useName, view, viewName;
        viewName = (opts != null ? opts.view : void 0) || this.name || 'index';
        tmplName = (opts != null ? opts.template : void 0) || 'template';
        useName = (opts != null ? opts.use : void 0) || 'body';
        logtime = log.time('Render');
        if (view = app.views[viewName]) {
          r = view.render(this);
        }
        if (viewName !== tmplName && (tmpl = app.views[tmplName])) {
          tmplView = Route.prototype.getTemplateView.call(this, tmplName);
          if (r != null) {
            r = tmplView.use(useName, r);
          } else {
            r = tmplView;
          }
          if (tmplView.storage.routes.has(useName)) {
            tmplView.storage.routes.pop(useName);
          }
          tmplView.storage.routes.set(useName, this);
          this._destroyViewOnEnd = false;
        } else {
          this._destroyViewOnEnd = true;
        }
        log.end(logtime);
        return r;
      };

      createToHTMLFromObject = function(opts) {
        return function() {
          return renderViewFromConfig.call(this, opts);
        };
      };

      Route.prototype.toHTML = createToHTMLFromObject({
        view: '',
        template: '',
        use: ''
      });

      Route.prototype.getTemplateView = (function() {
        if (utils.isNode) {
          return function(name) {
            var tmpl;
            tmpl = app.views[name].render({
              app: app,
              routes: new Dict
            });
            usedTemplates.push(tmpl);
            return tmpl;
          };
        } else {
          return function(name) {
            return templates[name] != null ? templates[name] : templates[name] = app.views[name].render({
              app: app,
              routes: new Dict
            });
          };
        }
      })();

      return Route;

    })();
  };

}).call(this);


return module.exports;
})();modules['bootstrap/route.node.coffee.md'] = (function(){
var module = {exports: modules["bootstrap/route.node.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","dict":"../dict/index.coffee.md","document":"../document/index.coffee.md","networking":"../networking/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, Document, Networking, VIEW_HTML, fs, log, pathUtils, utils;

  utils = require('utils');

  log = require('log');

  fs = require('fs');

  pathUtils = require('path');

  Dict = require('dict');

  Document = require('document');

  Networking = require('networking');

  log = log.scope('App', 'Bootstrap');

  VIEW_HTML = "<!doctype html>\n<html>\n<head>\n	<meta charset=\"utf-8\">\n	<title>${title}</title>\n	<script type=\"text/javascript\" src=\"${neftFilePath}\"></script>\n	<script type=\"text/javascript\" src=\"${appFilePath}\"></script>\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n	<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">\n</head>\n<body>\n	<noscript>\n		<meta http-equiv=\"refresh\" content=\"0; url=${appTextModeUrl}\"></meta>\n	</noscript>\n</body>\n</html>";

  module.exports = function(app) {
    var APP_JS_URI, JS_BUNDLE_FILE_PATH, JS_NEFT_FILE_PATH, JS_NEFT_GAME_FILE_PATH, NEFT_JS_URI, TEXT_MODE_URI_PREFIX, TYPE_COOKIE_NAME, VIEW_FILE, VIEW_NAME, appFile, getType, neftFile, neftGameFile, reservedUris, reservedUrisRe, view;
    APP_JS_URI = '/app.js';
    NEFT_JS_URI = '/neft.js';
    JS_NEFT_FILE_PATH = './neft-browser-release.js';
    JS_NEFT_GAME_FILE_PATH = './neft-browser-game-release.js';
    JS_BUNDLE_FILE_PATH = './build/app-browser-release.js';
    VIEW_NAME = '_app_bootstrap';
    VIEW_FILE = 'view.html';
    TEXT_MODE_URI_PREFIX = '/neft-type=text';
    TYPE_COOKIE_NAME = 'neft-type';
    //<development>;
    JS_NEFT_FILE_PATH = './neft-browser-develop.js';
    JS_NEFT_GAME_FILE_PATH = './neft-browser-game-develop.js';
    JS_BUNDLE_FILE_PATH = './build/app-browser-develop.js';
    //</development>;
    view = Document.fromHTML(VIEW_NAME, VIEW_HTML);
    reservedUris = ['app.js', 'favicon.ico', 'static'];
    reservedUrisRe = (function(_this) {
      return function() {
        var re, uri, _i, _len;
        re = '';
        for (_i = 0, _len = reservedUris.length; _i < _len; _i++) {
          uri = reservedUris[_i];
          re += "" + (utils.addSlashes(uri)) + "|";
        }
        re = re.slice(0, -1);
        return new RegExp("^(?:" + re + ")");
      };
    })(this)();
    getType = function(req) {
      var cookie;
      cookie = req.headers.cookie;
      if (cookie && cookie.indexOf('neft-type') !== -1) {
        return /neft\-type=([a-z]+)/.exec(cookie)[1];
      } else {
        return app.config.type;
      }
    };
    //;
    new app.Route({
      uri: APP_JS_URI,
      getData: function(callback) {
        //<development>;
        fs.readFile(JS_BUNDLE_FILE_PATH, 'utf-8', callback);
        //</development>;
        //;
      }
    });
    //;
    new app.Route({
      uri: NEFT_JS_URI,
      getData: function(callback) {
        var isGameType;
        isGameType = getType(this.request) === 'game';
        //<development>;
        if (isGameType) {
          fs.readFile(JS_NEFT_GAME_FILE_PATH, 'utf-8', callback);
        } else {
          fs.readFile(JS_NEFT_FILE_PATH, 'utf-8', callback);
        }
        //</development>;
        //;
      }
    });
    new app.Route({
      uri: 'favicon.ico',
      redirect: 'static/favicon.ico'
    });
    new app.Route({
      uri: 'neft-type={type}/{rest*}',
      getData: function(callback) {
        var req, res;
        req = this.request;
        res = this.response;
        res.setHeader('Set-Cookie', "" + TYPE_COOKIE_NAME + "=" + req.params.type + "; path=/;");
        return res.redirect("" + app.networking.url + "/" + req.params.rest);
      }
    });
    return new app.Route({
      uri: '*',
      getData: function(callback) {
        var req, userAgent;
        req = this.request;
        if (getType(req) === 'text') {
          return this.next();
        }
        userAgent = req.headers['user-agent'] || '';
        if (req.type !== Networking.Request.HTML_TYPE || reservedUrisRe.test(req.uri) || utils.has(userAgent, 'bot') || utils.has(userAgent, 'Baiduspider') || utils.has(userAgent, 'facebook') || utils.has(userAgent, 'Links')) {
          return this.next();
        }
        return callback(null);
      },
      destroyHTML: function() {
        return this.response.data.destroy();
      },
      toHTML: function() {
        return view.render({
          title: app.config.title,
          appTextModeUrl: TEXT_MODE_URI_PREFIX + this.request.uri,
          neftFilePath: app.networking.url + NEFT_JS_URI,
          appFilePath: app.networking.url + APP_JS_URI
        });
      }
    });
  };

}).call(this);


return module.exports;
})();modules['package.json'] = (function(){
var module = {exports: modules["package.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {
	"private": true,
	"name": "app",
	"version": "0.7.1",
	"config": {
		"title": "Neft.io Application",
		"protocol": "http",
		"port": 3000,
		"host": "0.0.0.0",
		"language": "en",
		"type": "app",
		"resources": "static/"
	},
	"dependencies": {
		"utils": "git+ssh://git@github.com:Kildyt/utils.git",
		"schema": "git+ssh://git@bitbucket.org:Kildyt/schema.git",
		"expect": "git+ssh://git@github.com:Kildyt/expect.git",
		"emitter": "git+ssh://git@bitbucket.org:Kildyt/emitter.git",
		"log": "git+ssh://git@bitbucket.org:Kildyt/log.git",
		"db": "git+ssh://git@github.com:Kildyt/Db.git",
		"db-implementation": "git+ssh://git@bitbucket.org:Kildyt/db-implementation.git",
		"db-addons": "git+ssh://git@bitbucket.org:Kildyt/db-addons.git",
		"db-schema": "git+ssh://git@bitbucket.org:Kildyt/db-schema.git",
		"networking": "git+ssh://git@bitbucket.org:Kildyt/networking.git",
		"view": "git+ssh://git@bitbucket.org:Kildyt/view.git",
		"styles": "git+ssh://git@bitbucket.org:Kildyt/styles.git",
		"view-styles": "git+ssh://git@bitbucket.org:Kildyt/view-styles.git"
	}
}
;

return module.exports;
})();modules['../styles/file/parse/styles.coffee.md'] = (function(){
var module = {exports: modules["../styles/file/parse/styles.coffee.md"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(File) {
    return function(file) {
      var Style, forNode, getStyleAttrs, styles;
      Style = File.Style;
      styles = [];
      getStyleAttrs = function(node) {
        var attr, attrs;
        attrs = null;
        for (attr in node._attrs) {
          if (attr === 'class' || attr.slice(0, 6) === 'style:') {
            if (attrs == null) {
              attrs = {};
            }
            attrs[attr] = true;
          }
        }
        return attrs;
      };
      forNode = function(node, parentStyle) {
        var attr, child, id, style, _i, _len, _ref;
        if (attr = node.attrs.get('neft:style')) {
          id = attr;
          style = new Style;
          style.file = file;
          style.node = node;
          style.parent = parentStyle;
          style.attrs = getStyleAttrs(node);
          if (parentStyle) {
            parentStyle.children.push(style);
            style.index = parentStyle.children.length - 1;
          } else {
            styles.push(style);
          }
          parentStyle = style;
        }
        _ref = node.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          if (child instanceof File.Element.Tag) {
            forNode(child, parentStyle);
          }
        }
      };
      forNode(file.node, null, null);
      if (styles.length) {
        file.styles = styles;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../styles/file/styles.coffee'] = (function(){
var module = {exports: modules["../styles/file/styles.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./parse/styles":"../styles/file/parse/styles.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var styleParseStyles, utils;

  utils = require('utils');

  if (utils.isNode) {
    styleParseStyles = require('./parse/styles');
  }

  module.exports = function(File) {
    var renderStyles, revertStyles;
    if (utils.isNode) {
      File.onParse((function() {
        var styles;
        styles = styleParseStyles(File);
        return function(file) {
          return styles(file);
        };
      })());
    }
    File.prototype.styles = null;
    renderStyles = function(arr) {
      var style, _i, _j, _len, _len1;
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        style = arr[_i];
        style.render();
      }
      for (_j = 0, _len1 = arr.length; _j < _len1; _j++) {
        style = arr[_j];
        renderStyles(style.children);
      }
    };
    File.onBeforeRender(function(file) {
      var styles;
      if (styles = file.styles) {
        renderStyles(styles);
      }
    });
    revertStyles = function(arr) {
      var style, _i, _j, _len, _len1;
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        style = arr[_i];
        style.revert();
      }
      for (_j = 0, _len1 = arr.length; _j < _len1; _j++) {
        style = arr[_j];
        revertStyles(style.children);
      }
    };
    File.onBeforeRevert(function(file) {
      var styles;
      if (styles = file.styles) {
        revertStyles(styles);
      }
    });
    return File.prototype._clone = (function(_super) {
      return function() {
        var clone, cloned, i, style, _i, _len, _ref;
        clone = _super.call(this);
        if (this.styles) {
          clone.styles = [];
          _ref = this.styles;
          for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
            style = _ref[i];
            cloned = clone.styles[i] = style.clone(this, clone);
          }
        }
        return clone;
      };
    })(File.prototype._clone);
  };

}).call(this);


return module.exports;
})();modules['../styles/style.coffee'] = (function(){
var module = {exports: modules["../styles/style.coffee"]};
var require = getModule.bind(null, {"neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","renderer":"../renderer/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Renderer, assert, log, signal, utils;

  assert = require('assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  Renderer = require('renderer');

  log = log.scope('Styles');

  module.exports = function(File, data) {
    var Style;
    return Style = (function() {
      var Tag, attrsChangeListener, emptyComponent, findItemIndex, findItemWithParent, getter, globalHideDelay, globalShowDelay, hideEvent, listenTextRec, opts, reloadItemsRecursively, setter, showEvent, styles, stylesToRender, stylesToRevert, textChangeListener, updateWhenPossible, windowStyle;

      windowStyle = data.windowStyle, styles = data.styles;

      Style.__name__ = 'Style';

      Style.__path__ = 'File.Style';

      emptyComponent = new Renderer.Component;

      listenTextRec = function(style, node) {
        var child, _i, _len, _ref;
        if (node == null) {
          node = style.node;
        }
        assert.instanceOf(style, Style);
        assert.instanceOf(node, File.Element);
        style.textWatchingNodes.push(node);
        if ('onTextChange' in node) {
          node.onTextChange(textChangeListener, style);
        }
        if ('onChildrenChange' in node) {
          node.onChildrenChange(textChangeListener, style);
        }
        if ('onVisibleChange' in node) {
          node.onVisibleChange(textChangeListener, style);
        }
        if (node.children) {
          _ref = node.children;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            listenTextRec(style, child);
          }
        }
      };

      textChangeListener = function() {
        if (this.file.isRendered) {
          return this.updateText();
        }
      };

      attrsChangeListener = function(name, oldValue) {
        var _ref, _ref1;
        if (name === 'neft:style') {
          this.reloadItem();
          if (this.file.isRendered) {
            this.render();
            this.findItemParent();
            this.findItemIndex();
          }
        } else if (name === 'href' && this.isLink()) {
          if ((_ref = this.item) != null) {
            _ref.linkUri = this.getLinkUri();
          }
        }
        if ((_ref1 = this.attrs) != null ? _ref1[name] : void 0) {
          this.setAttr(name, this.node._attrs[name], oldValue);
        }
      };

      reloadItemsRecursively = function(style) {
        var child, _i, _len, _ref;
        style.reloadItem();
        _ref = style.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          reloadItemsRecursively(child);
        }
      };

      function Style() {
        this.file = null;
        this.node = null;
        this.attrs = null;
        this.parent = null;
        this.isScope = false;
        this.isAutoParent = false;
        this.item = null;
        this.scope = null;
        this.children = [];
        this.textWatchingNodes = [];
        this.isTextSet = false;
        this.baseText = '';
        this.isLinkUriSet = false;
        this.baseLinkUri = '';
        this.parentSet = false;
        this.lastItemParent = null;
        this.waiting = false;
        this.index = -1;
        this.attrsQueue = [];
        this.attrsClass = null;
        Object.preventExtensions(this);
      }

      showEvent = new Renderer.Item.Document.ShowEvent;

      hideEvent = new Renderer.Item.Document.HideEvent;

      globalShowDelay = globalHideDelay = 0;

      stylesToRender = [];

      stylesToRevert = [];

      updateWhenPossible = (function() {
        var lastDate, pending, sync;
        pending = false;
        lastDate = 0;
        sync = function() {
          var animationsPending, diff, extension, logtime, now, style, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref;
          now = Date.now();
          diff = now - lastDate;
          lastDate = now;
          animationsPending = false;
          for (_i = 0, _len = stylesToRevert.length; _i < _len; _i++) {
            style = stylesToRevert[_i];
            _ref = style.item._extensions;
            for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
              extension = _ref[_j];
              if (extension instanceof Renderer.PropertyAnimation && extension.running && !extension.loop) {
                animationsPending = true;
                break;
              }
            }
            if (animationsPending) {
              break;
            }
          }
          globalShowDelay -= diff;
          if (globalHideDelay > 0 && !animationsPending) {
            globalHideDelay -= diff;
          }
          if (!animationsPending) {
            if (globalHideDelay <= 0) {
              globalHideDelay = 0;
              if (stylesToRevert.length > 0) {
                logtime = log.time('Revert');
                for (_k = 0, _len2 = stylesToRevert.length; _k < _len2; _k++) {
                  style = stylesToRevert[_k];
                  style.waiting = false;
                  style.revertItem();
                  style.file.readyToUse = true;
                  assert.notOk(style.file.isRendered);
                }
                utils.clear(stylesToRevert);
                log.end(logtime);
              }
            }
            if (globalShowDelay + globalHideDelay <= 0) {
              globalShowDelay = 0;
              if (stylesToRender.length > 0) {
                logtime = log.time('Render');
                for (_l = 0, _len3 = stylesToRender.length; _l < _len3; _l++) {
                  style = stylesToRender[_l];
                  style.waiting = false;
                  style.renderItem();
                  style.file.readyToUse = true;
                }
                for (_m = 0, _len4 = stylesToRender.length; _m < _len4; _m++) {
                  style = stylesToRender[_m];
                  style.findItemIndex();
                }
                utils.clear(stylesToRender);
                log.end(logtime);
              }
            }
          }
          if (stylesToRender.length || stylesToRevert.length) {
            requestAnimationFrame(sync);
          } else {
            pending = false;
          }
        };
        return function(style) {
          if (!pending) {
            lastDate = Date.now();
            requestAnimationFrame(sync);
            pending = true;
          }
          style.waiting = true;
        };
      })();

      Style.prototype.render = function() {
        if (this.waiting || !this.item) {
          return;
        }
        if (this.isScope) {
          this.item.document.onShow.emit(showEvent);
          globalShowDelay += showEvent.delay;
          showEvent.delay = 0;
        }
        this.item.document.visible = false;
        this.file.readyToUse = false;
        stylesToRender.push(this);
        updateWhenPossible(this);
      };

      Style.prototype.renderItem = function() {
        var attr, attrsQueue, i, _i, _len, _ref;
        if (!this.item || !this.file.isRendered) {
          return;
        }
        this.item.visible = true;
        if (this.lastItemParent) {
          this.item.parent = this.lastItemParent;
        }
        this.findItemParent();
        this.item.document.node = this.node;
        this.baseText = ((_ref = this.getTextObject()) != null ? _ref.text : void 0) || '';
        this.updateText();
        this.updateVisibility();
        if (this.attrs) {
          if ((attrsQueue = this.attrsQueue).length) {
            for (i = _i = 0, _len = attrsQueue.length; _i < _len; i = _i += 3) {
              attr = attrsQueue[i];
              this.setAttr(attr, attrsQueue[i + 1], attrsQueue[i + 2]);
            }
            utils.clear(attrsQueue);
          }
          this.attrsClass.enable();
        }
        this.item.document.visible = true;
      };

      Style.prototype.revert = function() {
        var tmpNode;
        if (this.waiting || !this.item) {
          return;
        }
        if (this.isAutoParent && this.isScope) {
          this.item.document.onHide.emit(hideEvent);
          globalHideDelay += hideEvent.delay;
          globalShowDelay += hideEvent.nextShowDelay;
          hideEvent.delay = 0;
          hideEvent.nextShowDelay = 0;
        }
        this.item.document.visible = false;
        this.file.readyToUse = false;
        stylesToRevert.push(this);
        updateWhenPossible(this);
        tmpNode = this.node;
        while ((tmpNode = tmpNode._parent) && !tmpNode.style) {
          if (tmpNode.name === 'neft:blank') {
            tmpNode._documentStyle = null;
          }
        }
      };

      Style.prototype.revertItem = function() {
        var itemDocumentNode, tmpNode;
        if (!this.item) {
          return;
        }
        this.item.visible = false;
        if (this.isAutoParent) {
          this.lastItemParent = null;
          if (!this.parentSet) {
            this.lastItemParent = this.item.parent;
          }
          this.item.parent = null;
          this.parentSet = false;
        }
        itemDocumentNode = this.item.document.node;
        this.item.document.node = null;
        this.item.document.visible = true;
        tmpNode = this.node;
        while (tmpNode = tmpNode._parent) {
          if (tmpNode._documentStyle === this) {
            tmpNode._documentStyle = null;
          } else {
            break;
          }
        }
        if (this.isLinkUriSet) {
          this.item.linkUri = this.baseLinkUri;
          this.isLinkUriSet = false;
          this.baseLinkUri = '';
        }
        if (this.isTextSet) {
          this.getTextObject().text = this.baseText;
          this.isTextSet = false;
          this.baseText = '';
        }
      };

      Style.prototype.getTextObject = function() {
        var item;
        item = this.item;
        if (!item) {
          return;
        }
        if (item._$ && 'text' in item._$) {
          return item._$;
        } else if ('text' in item) {
          return item;
        }
      };

      Style.prototype.updateText = function() {
        var anchor, hasStyledChild, href, node, obj, text;
        if (this.waiting) {
          return;
        }
        node = this.node;
        hasStyledChild = this.children.length || node.query('[neft:style]');
        if (!hasStyledChild && (anchor = node.query('> a'))) {
          node = anchor;
          href = node.attrs.get('href');
          if (typeof href === 'string') {
            if (!this.isLinkUriSet) {
              this.isLinkUriSet = true;
              this.baseLinkUri = this.item.linkUri;
            }
            this.item.linkUri = href;
          }
        }
        obj = this.getTextObject();
        if (obj && !hasStyledChild) {
          text = node.stringifyChildren();
          if (text.length > 0 || this.isTextSet) {
            this.isTextSet = true;
            obj.text = text;
          }
        }
      };

      Style.prototype.updateVisibility = function() {
        var tmpNode, visible;
        if (this.waiting || !this.item) {
          return;
        }
        visible = true;
        tmpNode = this.node;
        while (true) {
          visible = tmpNode.visible;
          tmpNode = tmpNode.parent;
          if (!visible || !tmpNode || tmpNode.attrs.has('neft:style')) {
            break;
          }
        }
        this.item.visible = visible;
      };

      Style.prototype.setAttr = (function() {
        var PREFIX_LENGTH, getInternalProperty, getPropertyPath, getSplitAttr;
        PREFIX_LENGTH = 'style:'.length;
        getSplitAttr = (function() {
          var cache;
          cache = Object.create(null);
          return function(prop) {
            return cache[prop] || (cache[prop] = prop.slice(PREFIX_LENGTH).split(':'));
          };
        })();
        getPropertyPath = (function() {
          var cache;
          cache = Object.create(null);
          return function(prop) {
            return cache[prop] || (cache[prop] = prop.slice(PREFIX_LENGTH).replace(/:/g, '.'));
          };
        })();
        getInternalProperty = (function() {
          var cache;
          cache = Object.create(null);
          return function(prop) {
            return cache[prop] || (cache[prop] = "_" + prop);
          };
        })();
        return function(attr, val, oldVal) {
          var i, internalProp, obj, prop, props, _i, _ref;
          assert.instanceOf(this, Style);
          if (this.waiting || !this.item) {
            this.attrsQueue.push(attr, val, oldVal);
            return;
          }
          if (attr === 'class') {
            this.syncClassAttr(val, oldVal);
            return true;
          }
          props = getSplitAttr(attr);
          obj = this.item;
          for (i = _i = 0, _ref = props.length - 1; _i < _ref; i = _i += 1) {
            if (!(obj = obj[props[i]])) {
              return false;
            }
          }
          prop = utils.last(props);
          if (!(prop in obj)) {
            log.warn("Attribute '" + attr + "' doesn't exist in item '" + this.item + "'");
            return false;
          }
          internalProp = getInternalProperty(prop);
          if (obj[internalProp] === void 0 && typeof obj[prop] === 'function' && obj[prop].connect) {
            if (typeof oldVal === 'function') {
              obj[prop].disconnect(oldVal);
            }
            if (typeof val === 'function') {
              obj[prop](val);
            }
          } else if (this.node._attrs[attr] === val && val !== oldVal) {
            this.attrsClass.changes.setAttribute(getPropertyPath(attr), val);
            obj[prop] = val;
          }
          return true;
        };
      })();

      Style.prototype.syncClassAttr = function(val, oldVal) {
        var classes, i, index, item, name, newClasses, oldClasses, prevIndex, _i, _j, _len, _len1;
        item = this.item;
        classes = item.classes;
        newClasses = val && val.split(' ');
        if (oldVal && typeof oldVal === 'string') {
          oldClasses = oldVal.split(' ');
          for (_i = 0, _len = oldClasses.length; _i < _len; _i++) {
            name = oldClasses[_i];
            if (!newClasses || !utils.has(newClasses, name)) {
              classes.remove(name);
            }
          }
        }
        if (val && typeof val === 'string') {
          newClasses = val.split(' ');
          prevIndex = -1;
          for (i = _j = 0, _len1 = newClasses.length; _j < _len1; i = ++_j) {
            name = newClasses[i];
            index = classes.index(name);
            if (prevIndex === -1 && index === -1) {
              index = classes.length;
              classes.append(name);
            } else if (index !== prevIndex + 1) {
              if (index !== -1) {
                classes.pop(index);
                if (prevIndex > index) {
                  prevIndex--;
                }
              }
              index = prevIndex + 1;
              classes.insert(index, name);
            }
            prevIndex = index;
          }
        }
      };

      Style.prototype.isLink = function() {
        var _ref;
        return this.node.name === 'a' && ((_ref = this.node.attrs.get('href')) != null ? _ref[0] : void 0) !== '#';
      };

      Style.prototype.getLinkUri = function() {
        var uri;
        uri = this.node.attrs.get('href') + '';
        //<development>;
        if (!/^([a-z]+:|\/|\$\{)/.test(uri)) {
          log.warn("Relative link found `" + uri + "`");
        }
        //</development>;
        return uri;
      };

      Style.prototype.reloadItem = function() {
        var elem, file, id, match, parent, parentId, scope, style, subid, wasAutoParent, _, _ref, _ref1;
        if (this.waiting) {
          return;
        }
        if (!utils.isClient) {
          return;
        }
        if (this.item && this.isAutoParent) {
          this.item.parent = null;
        }
        if (this.item) {
          while (elem = this.textWatchingNodes.pop()) {
            if ('onTextChange' in elem) {
              elem.onTextChange.disconnect(textChangeListener, this);
            }
            if ('onChildrenChange' in elem) {
              elem.onChildrenChange.disconnect(textChangeListener, this);
            }
            if ('onVisibleChange' in elem) {
              elem.onVisibleChange.disconnect(textChangeListener, this);
            }
          }
          if (this.attrs) {
            this.attrsClass.disable();
            this.attrsClass.target = null;
          }
        }
        wasAutoParent = this.isAutoParent;
        id = this.node.attrs.get('neft:style');
        assert.isString(id);
        this.isScope = /^(styles|renderer)\:/.test(id);
        this.item = null;
        this.scope = null;
        this.isAutoParent = false;
        if (id instanceof Renderer.Item) {
          this.item = id;
        } else if (this.isScope) {
          this.isAutoParent = true;
          if (/^renderer\:/.test(id)) {
            id = id.slice('renderer:'.length);
            id = utils.capitalize(id);
            this.scope = {
              mainItem: new Renderer[id],
              ids: {}
            };
          } else if (/^styles\:/.test(id)) {
            match = /^styles:(.+?)(?:\:(.+?))?(?:\:(.+?))?$/.exec(id);
            _ = match[0], file = match[1], style = match[2], subid = match[3];
            if (style == null) {
              style = '_main';
            }
            if (subid) {
              parentId = "styles:" + file + ":" + style;
              parent = this.parent;
              while (true) {
                scope = (parent != null ? parent.scope : void 0) || windowStyle;
                if ((scope === windowStyle && file === 'view') || (parent && parent.node.attrs.get('neft:style') === parentId)) {
                  this.item = scope != null ? scope.objects[subid] : void 0;
                }
                if (this.item || ((!parent || !(parent = parent.parent)) && scope === windowStyle)) {
                  break;
                }
              }
              if (!this.item) {
                if (!File.Input.test(id)) {
                  log.warn("Can't find `" + id + "` style item");
                }
                return;
              }
              this.isAutoParent = !this.item.parent;
            } else {
              this.scope = (_ref = styles[file]) != null ? (_ref1 = _ref[style]) != null ? _ref1.getComponent() : void 0 : void 0;
              if (this.scope) {
                this.item = this.scope.item;
              } else {
                if (!File.Input.test(id)) {
                  log.warn("Style file `" + id + "` can't be find");
                }
                return;
              }
            }
          }
        }
        this.node._documentStyle = this;
        this.node.style = this.item;
        if (this.item) {
          this.item.visible = false;
          if (this.isLink()) {
            this.item.linkUri = this.getLinkUri();
          }
          if (this.attrs) {
            this.attrsClass.target = this.item;
          }
        }
        if (this.getTextObject()) {
          listenTextRec(this);
        }
      };

      findItemWithParent = function(item, parent) {
        var tmp, tmpParent;
        tmp = item;
        while (tmp && (tmpParent = tmp._parent)) {
          if (tmpParent === parent) {
            return tmp;
          }
          tmp = tmpParent;
        }
      };

      findItemIndex = function(node, item, parent) {
        var tmpIndexNode, tmpSiblingItem, tmpSiblingNode, tmpSiblingTargetItem, _ref, _ref1;
        tmpIndexNode = node;
        parent = parent.children._target || parent;
        tmpSiblingNode = tmpIndexNode;
        while (tmpIndexNode) {
          while (tmpSiblingNode) {
            if (tmpSiblingNode !== node) {
              if (((_ref = tmpSiblingNode._documentStyle) != null ? _ref.parentSet : void 0) && (tmpSiblingItem = tmpSiblingNode._documentStyle.item)) {
                if (tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)) {
                  if (item !== tmpSiblingTargetItem) {
                    if (item.previousSibling !== tmpSiblingTargetItem) {
                      item.previousSibling = tmpSiblingTargetItem;
                    }
                  }
                  return;
                }
              } else if (tmpSiblingNode.name === 'neft:blank') {
                tmpIndexNode = tmpSiblingNode;
                tmpSiblingNode = utils.last(tmpIndexNode.children);
                continue;
              }
            }
            tmpSiblingNode = tmpSiblingNode._previousSibling;
          }
          if (tmpIndexNode !== node && tmpIndexNode.style) {
            return;
          }
          tmpIndexNode = tmpIndexNode._parent;
          tmpSiblingNode = tmpIndexNode._previousSibling;
          if (((_ref1 = tmpIndexNode._documentStyle) != null ? _ref1.item : void 0) === parent) {
            return;
          }
        }
      };

      Style.prototype.findItemParent = function() {
        var item, node, style, tmpNode;
        if (this.waiting) {
          return;
        }
        if (this.isAutoParent && this.item && !this.item.parent) {
          node = this.node;
          tmpNode = node._parent;
          while (tmpNode) {
            if (style = tmpNode._documentStyle) {
              item = style.item;
              if (style.node !== tmpNode) {
                item = item._parent;
              }
              if (item) {
                this.parentSet = true;
                this.item.parent = item;
                break;
              }
            } else if (tmpNode.name !== 'neft:blank') {
              tmpNode._documentStyle = this;
            }
            tmpNode = tmpNode._parent;
          }
          if (!item) {
            this.item.parent = null;
          }
        }
      };

      Style.prototype.findItemIndex = function() {
        if (this.parentSet) {
          findItemIndex.call(this, this.node, this.item, this.item.parent);
          return true;
        } else {
          return false;
        }
      };

      Style.prototype.clone = function(originalFile, file) {
        var attr, attrVal, child, clone, _i, _len, _ref;
        clone = new Style;
        clone.file = file;
        clone.node = originalFile.node.getCopiedElement(this.node, file.node);
        clone.attrs = this.attrs;
        clone.index = this.index;
        if (this.attrs) {
          clone.attrsClass = new Renderer.Class(emptyComponent);
          clone.attrsClass.priority = 9999;
        }
        _ref = this.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          child = child.clone(originalFile, file);
          child.parent = clone;
          clone.children.push(child);
        }
        if (!this.parent) {
          reloadItemsRecursively(clone);
        }
        if (!utils.isClient) {
          return clone;
        }
        clone.node.onAttrsChange(attrsChangeListener, clone);
        if (this.attrs) {
          for (attr in this.attrs) {
            attrVal = clone.node._attrs[attr];
            if (attrVal != null) {
              clone.setAttr(attr, attrVal, null);
            }
          }
        }
        return clone;
      };

      Tag = File.Element.Tag;

      opts = utils.CONFIGURABLE;

      getter = utils.lookupGetter(Tag.prototype, 'visible');

      setter = utils.lookupSetter(Tag.prototype, 'visible');

      utils.defineProperty(Tag.prototype, 'visible', opts, getter, (function(_super) {
        var updateVisibility;
        updateVisibility = function(node) {
          var child, _i, _len, _ref;
          if (node._style) {
            node._documentStyle.updateVisibility();
          } else if (node instanceof Tag) {
            _ref = node.children;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              updateVisibility(child);
            }
          }
        };
        return function(val) {
          if (_super.call(this, val)) {
            updateVisibility(this);
            true;
          }
          return false;
        };
      })(setter));

      Style;

      return Style;

    })();
  };

}).call(this);


return module.exports;
})();modules['../styles/index.coffee.md'] = (function(){
var module = {exports: modules["../styles/index.coffee.md"]};
var require = getModule.bind(null, {"document":"../document/index.coffee.md","./file/styles":"../styles/file/styles.coffee","./style":"../styles/style.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Document, stylesStyle, stylesStyles;

  Document = require('document');

  stylesStyles = require('./file/styles');

  stylesStyle = require('./style');

  module.exports = function(data) {
    stylesStyles(Document);
    return Document.Style = stylesStyle(Document, data);
  };

}).call(this);


return module.exports;
})();modules['index.coffee.md'] = (function(){
var module = {exports: modules["index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","db":"../db/index.coffee.md","neft-assert":"../neft-assert/index.coffee.md","assert":"../neft-assert/index.coffee.md","schema":"../schema/index.coffee.md","networking":"../networking/index.coffee.md","document":"../document/index.coffee.md","renderer":"../renderer/index.coffee.md","resources":"../resources/index.coffee.md","dict":"../dict/index.coffee.md","./route":"route.coffee.md","./bootstrap/route.node":"bootstrap/route.node.coffee.md","./package.json":"package.json","emitter":"../emitter/index.coffee.md","expect":"node_modules/expect/index.coffee.md","list":"../list/index.coffee.md","styles":"../styles/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var AppRoute, Dict, Document, MODULES, Networking, Renderer, Resources, Schema, assert, bootstrapRoute, db, exports, log, name, pkg, setImmediate, signal, utils, _i, _len;

  utils = require('utils');

  log = require('log');

  signal = require('signal');

  db = require('db');

  assert = require('neft-assert');

  Schema = require('schema');

  Networking = require('networking');

  Document = require('document');

  Renderer = require('renderer');

  Resources = require('resources');

  Dict = require('dict');

  AppRoute = require('./route');

  setImmediate = global.setImmediate;

  if (utils.isBrowser) {
    setImmediate = require('emitter/node_modules/immediate');
  }

  if (utils.isNode) {
    bootstrapRoute = require('./bootstrap/route.node');
  }

  pkg = require('./package.json');

  exports = module.exports = function(opts, extraOpts) {
    var COOKIES_KEY, app, config, ext, init, onCookiesReady, style, stylesInitObject, windowStyle, windowStyleItem, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
    if (opts == null) {
      opts = {};
    }
    if (extraOpts == null) {
      extraOpts = {};
    }
    if (utils.isBrowser) {
      global.setImmediate = setImmediate;
    }
    (require('log')).ok("Welcome! Neft.io v" + pkg.version + "; Feedback appreciated");
    //<development>;
    log.warn("Use this bundle only in development; type --release when it's ready");
    //</development>;
    config = pkg.config;
    config = utils.merge(utils.clone(config), opts.config);
    if (extraOpts != null) {
      utils.merge(config, extraOpts);
    }
    app = new Dict;
    app.config = config;
    app.networking = new Networking({
      type: Networking.HTTP,
      protocol: config.protocol,
      port: parseInt(config.port, 10),
      host: config.host,
      url: config.url,
      language: config.language
    });
    app.models = {};
    app.routes = {};
    app.styles = {};
    app.views = {};
    app.resources = opts.resources ? Resources.fromJSON(opts.resources) : new Resources;
    signal.create(app, 'onReady');
    if (config.type == null) {
      config.type = 'app';
    }
    assert.ok(utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game, but '" + config.type + "' got.");
    app.Route = AppRoute(app);
    COOKIES_KEY = '__neft_cookies';
    app.cookies = null;
    onCookiesReady = function(dict) {
      app.cookies = dict;
      if (utils.isClient) {
        return dict.set('sessionId', utils.uid(16));
      }
    };
    db.get(COOKIES_KEY, db.OBSERVABLE, function(err, dict) {
      var cookies;
      if (dict) {
        return onCookiesReady(dict);
      } else {
        if (utils.isClient) {
          cookies = {
            clientId: utils.uid(16)
          };
        } else {
          cookies = {};
        }
        return db.set(COOKIES_KEY, cookies, function(err) {
          return db.get(COOKIES_KEY, db.OBSERVABLE, function(err, dict) {
            return onCookiesReady(dict);
          });
        });
      }
    });
    app.networking.onRequest(function(req, res) {
      if (utils.isClient) {
        utils.merge(req.cookies, app.cookies._data);
      } else {
        utils.merge(res.cookies, app.cookies._data);
      }
      req.onLoadEnd.listeners.unshift(function() {
        var key, val, _ref;
        if (utils.isClient) {
          _ref = res.cookies;
          for (key in _ref) {
            val = _ref[key];
            if (!utils.isEqual(app.cookies.get(key), val)) {
              app.cookies.set(key, val);
            }
          }
        }
      }, null);
    });
    Renderer.resources = app.resources;
    Renderer.serverUrl = app.networking.url;
    if (opts.styles != null) {
      _ref = opts.styles;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        style = _ref[_i];
        if (style.name === 'view') {
          windowStyle = style.file._main.getComponent();
          break;
        }
      }
    }
    windowStyleItem = (windowStyle != null ? windowStyle.item : void 0) || new Renderer.Item;
    Renderer.window = windowStyleItem;
    if (opts.styles != null) {
      stylesInitObject = {
        app: app,
        view: windowStyleItem
      };
      _ref1 = opts.styles;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        style = _ref1[_j];
        if (!(style.name != null)) {
          continue;
        }
        style.file._init(stylesInitObject);
        app.styles[style.name] = style.file;
      }
    }
    require('styles')({
      windowStyle: windowStyle,
      styles: app.styles
    });
    if (utils.isNode) {
      bootstrapRoute(app);
    }
    init = function(files, target) {
      var file, fileObj, _k, _len2;
      for (_k = 0, _len2 = files.length; _k < _len2; _k++) {
        file = files[_k];
        if (!(file.name != null)) {
          continue;
        }
        if (typeof file.file !== 'function') {
          continue;
        }
        fileObj = file.file(app);
        if (target[file.name] != null) {
          if (utils.isPlainObject(target[file.name]) && utils.isPlainObject(fileObj)) {
            fileObj = utils.merge(Object.create(target[file.name]), fileObj);
          }
        }
        target[file.name] = fileObj;
      }
    };
    setImmediate(function() {
      var method, obj, path, r, route, view, _k, _len2, _ref2, _ref3;
      _ref2 = opts.views;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        view = _ref2[_k];
        if (view.name != null) {
          app.views[view.name] = Document.fromJSON(view.name, view.file);
        }
      }
      init(opts.models, app.models);
      init(opts.routes, app.routes);
      _ref3 = app.routes;
      for (path in _ref3) {
        obj = _ref3[path];
        r = {};
        if (utils.isObject(obj) && !(obj instanceof app.Route)) {
          for (method in obj) {
            opts = obj[method];
            if (utils.isObject(opts)) {
              route = new app.Route(method, opts);
              r[route.name] = route;
            } else {
              r[method] = opts;
            }
          }
        }
        app.routes[path] = r;
      }
      return app.onReady.emit();
    });
    if (utils.isObject(opts.extensions)) {
      _ref2 = opts.extensions;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        ext = _ref2[_k];
        ext({
          app: app
        });
      }
    }
    return app;
  };

  MODULES = ['utils', 'signal', 'dict', 'emitter', 'expect', 'list', 'log', 'Resources', 'Renderer', 'Networking', 'Schema', 'Document', 'Styles', 'assert', 'db'];

  for (_i = 0, _len = MODULES.length; _i < _len; _i++) {
    name = MODULES[_i];
    exports[name] = exports[name.toLowerCase()] = require(name.toLowerCase());
  }

  exports['neft-assert'] = exports.assert;

}).call(this);


return module.exports;
})();

var result = modules["index.coffee.md"];

if(typeof module !== 'undefined'){
	return module.exports = result;
} else {
	return result;
}
})();;

if (typeof module !== 'undefined') module.exports = Neft;