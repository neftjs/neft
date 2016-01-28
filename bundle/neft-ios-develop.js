window.setImmediate = (function() {
  var callAll, queue, running, update;
  running = false;
  queue = [];
  callAll = function() {
    var args, func, i, j, length, ref;
    running = false;
    length = queue.length;
    for (i = j = 0, ref = length; j < ref; i = j += 2) {
      func = queue.shift();
      args = queue.shift();
      func.apply(null, args);
    }
  };
  update = (function() {
    var Mutation, calls, element, observer;
    if (!(Mutation = window.MutationObserver || window.WebKitMutationObserver)) {
      return;
    }
    calls = 0;
    observer = new Mutation(callAll);
    element = document.createTextNode('');
    observer.observe(element, {
      characterData: true
    });
    return function() {
      var ref;
      return element.data = (ref = ++calls % 2) != null ? ref : {
        "a": "b"
      };
    };
  })();
  return function(func) {
    var argc, args, i, j, ref;
    argc = arguments.length;
    if (argc > 1) {
      args = new Array(argc - 1);
      for (i = j = 1, ref = argc; j < ref; i = j += 1) {
        args[i - 1] = arguments[i];
      }
    }
    queue.push(func, args);
    if (!running) {
      update();
      running = true;
    }
  };
})();

window.Neft = (function(){
'use strict';

// list of modules with empty objects
var modules = {"../utils/namespace.coffee.md":{},"../utils/stringifying.coffee.md":{},"../utils/async.coffee.md":{},"../utils/index.coffee.md":{},"../assert/index.coffee.md":{},"../log/impls/browser/index.coffee":{},"../log/index.coffee.md":{},"../signal/emitter.coffee":{},"../signal/index.coffee.md":{},"../list/index.coffee.md":{},"../dict/index.coffee.md":{},"../db/implementations/memory.coffee":{},"../db/implementation.coffee":{},"../db/index.coffee.md":{},"../schema/validators/array.coffee.md":{},"../schema/validators/object.coffee.md":{},"../schema/validators/optional.coffee.md":{},"../schema/validators/max.coffee.md":{},"../schema/validators/min.coffee.md":{},"../schema/validators/options.coffee.md":{},"../schema/validators/regexp.coffee.md":{},"../schema/validators/type.coffee.md":{},"../schema/index.coffee.md":{},"../networking/impl/ios/index.coffee":{},"../networking/impl.coffee":{},"../networking/impl/ios/request.coffee":{},"../document/element/element/text.coffee.md":{},"../document/element/element/tag/stringify.coffee":{},"../typed-array/index.coffee.md":{},"../document/element/element/tag.coffee.md":{},"../document/element/element/tag/query.coffee":{},"../document/element/element.coffee.md":{},"../document/element/index.coffee":{},"../document/attrChange.coffee":{},"../document/use.coffee":{},"../document/input.coffee":{},"../document/input/text.coffee":{},"../document/input/attr.coffee":{},"../document/condition.coffee":{},"../document/iterator.coffee":{},"../document/log.coffee":{},"../renderer/impl.coffee":{},"../renderer/impl/base/level0/item.coffee":{},"../renderer/impl/base/level0/image.coffee":{},"../renderer/impl/base/level0/text.coffee":{},"../renderer/impl/base/level0/textInput.coffee":{},"../renderer/impl/base/level0/loader/font.coffee":{},"../renderer/impl/base/level0/loader/resources.coffee":{},"../renderer/impl/base/level0/device.coffee":{},"../renderer/impl/base/level0/screen.coffee":{},"../renderer/impl/base/level0/navigator.coffee":{},"../renderer/impl/base/level0/sensor/rotation.coffee":{},"../renderer/impl/base/level0/sound/ambient.coffee":{},"../renderer/impl/base/level1/rectangle.coffee":{},"../renderer/impl/base/level1/grid.coffee":{},"../renderer/impl/base/level1/column.coffee":{},"../renderer/impl/base/level1/row.coffee":{},"../renderer/impl/base/level1/flow.coffee":{},"../renderer/impl/base/level1/animation.coffee":{},"../renderer/impl/base/level1/animation/property.coffee":{},"../renderer/impl/base/level1/animation/number.coffee":{},"../renderer/impl/base/level2/scrollable.coffee":{},"../renderer/impl/base/level1/binding.coffee":{},"../renderer/impl/base/level1/anchors.coffee":{},"../renderer/impl/base/utils.coffee":{},"../renderer/impl/base/utils/grid.coffee":{},"../renderer/impl/base/index.coffee":{},"../renderer/impl/native/index.coffee":{},"../native/actions.coffee":{},"../native/impl/ios/bridge.coffee":{},"../native/bridge.coffee":{},"../renderer/impl/native/ios.coffee":{},"../renderer/impl/native/level2/scrollable.coffee":{},"../renderer/impl/native/level0/item.coffee":{},"../renderer/impl/native/level0/image.coffee":{},"../renderer/impl/native/level0/text.coffee":{},"../renderer/impl/native/level0/textInput.coffee":{},"../renderer/impl/native/level0/loader/font.coffee":{},"../renderer/impl/native/level0/loader/resources.coffee":{},"../renderer/impl/native/level0/device.coffee":{},"../renderer/impl/native/level0/screen.coffee":{},"../renderer/impl/native/level0/navigator.coffee":{},"../renderer/impl/native/level0/sensor/rotation.coffee":{},"../renderer/impl/native/level0/sound/ambient.coffee":{},"../renderer/impl/native/level1/rectangle.coffee":{},"../renderer/impl/base/level0/item/pointer.coffee":{},"../renderer/impl/base/utils/color.coffee":{},"../renderer/utils/item.coffee":{},"../renderer/types/namespace/screen.coffee.md":{},"../renderer/types/namespace/device.coffee.md":{},"../renderer/types/namespace/navigator.coffee.md":{},"../renderer/types/namespace/sensor/rotation.coffee.md":{},"../renderer/types/extension.coffee":{},"../renderer/types/extensions/class.coffee.md":{},"../renderer/types/extensions/animation.coffee.md":{},"../renderer/types/extensions/animation/types/property.coffee.md":{},"../renderer/types/extensions/animation/types/property/types/number.coffee.md":{},"../renderer/types/extensions/transition.coffee.md":{},"../renderer/types/basics/component.coffee":{},"../renderer/types/basics/item.coffee.md":{},"../renderer/types/basics/item/spacing.coffee.md":{},"../renderer/types/basics/item/alignment.coffee.md":{},"../renderer/types/basics/item/anchors.coffee.md":{},"../renderer/types/basics/item/layout.coffee.md":{},"../renderer/types/basics/item/margin.coffee.md":{},"../renderer/types/basics/item/pointer.coffee.md":{},"../renderer/types/basics/item/keys.coffee.md":{},"../renderer/types/basics/item/document.coffee.md":{},"../renderer/types/basics/item/types/image.coffee.md":{},"../renderer/types/basics/item/types/text.coffee.md":{},"../renderer/types/basics/item/types/text/font.coffee.md":{},"../renderer/types/basics/item/types/textInput.coffee.md":{},"../renderer/types/shapes/rectangle.coffee.md":{},"../renderer/types/layout/grid.coffee.md":{},"../renderer/types/layout/column.coffee.md":{},"../renderer/types/layout/row.coffee.md":{},"../renderer/types/layout/flow.coffee.md":{},"../renderer/types/layout/scrollable.coffee.md":{},"../renderer/types/sound/ambient.coffee.md":{},"../resources/resource.coffee.md":{},"../resources/index.coffee.md":{},"../renderer/types/loader/resources.coffee.md":{},"../renderer/types/loader/font.coffee.md":{},"../renderer/index.coffee.md":{},"../document/func.coffee.md":{},"../document/attrsToSet.coffee":{},"../document/file/render/parse/target.coffee":{},"../document/file/render/revert/target.coffee":{},"../document/file.coffee.md":{},"../document/index.coffee.md":{},"../networking/impl/ios/response.coffee":{},"../networking/uri.coffee.md":{},"../networking/handler.coffee.md":{},"../networking/request.coffee.md":{},"../networking/response.coffee.md":{},"../networking/response/error.coffee.md":{},"../networking/index.coffee.md":{},"route.coffee.md":{},"package.json":{},"../native/index.coffee.md":{},"../styles/file/styles.coffee":{},"../styles/style.coffee":{},"../styles/index.coffee":{},"index.coffee.md":{}};

// used as `require`
function getModule(paths, name){
	var path = paths[name];
	return (path in modules ? modules[path] :
	       (typeof Neft !== "undefined" && Neft[name]) ||
	       (typeof require === 'function' && require(name)) ||
	       (function(){throw new Error("Cannot find module '"+name+"'");}()));
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

  assert = console.assert.bind(console);

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
          return onEnd.call(thisArg);
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
          return onEnd.call(thisArg);
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

  exports.isNode = exports.isServer = exports.isClient = exports.isBrowser = exports.isQt = exports.isAndroid = exports.isIOS = false;

  switch (true) {
    case (typeof Qt !== "undefined" && Qt !== null ? Qt.include : void 0) != null:
      exports.isClient = exports.isQt = true;
      break;
    case typeof android !== "undefined" && android !== null:
      exports.isClient = exports.isAndroid = true;
      break;
    case (typeof _neft !== "undefined" && _neft !== null ? _neft.platform : void 0) === 'ios':
      exports.isClient = exports.isIOS = true;
      break;
    case (typeof window !== "undefined" && window !== null ? window.document : void 0) != null:
      exports.isClient = exports.isBrowser = true;
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
    if (arguments.length > 2) {
      throw new Error("utils.merge expects only two arguments; use utils.mergeAll instead");
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

  exports.mergeAll = function(source) {
    var i, key, obj, value, _i, _ref1;
    null;
    //<development>;
    if (isPrimitive(source)) {
      throw new Error("utils.merge source cannot be primitive");
    }
    //</development>;
    for (i = _i = 1, _ref1 = arguments.length; _i < _ref1; i = _i += 1) {
      if ((obj = arguments[i]) != null) {
        //<development>;
        if (isPrimitive(obj)) {
          throw new Error("utils.mergeAll object cannot be primitive");
        }
        if (source === obj) {
          throw new Error("utils.mergeAll source and object are the same");
        }
        //</development>;
        for (key in obj) {
          value = obj[key];
          if (obj.hasOwnProperty(key)) {
            source[key] = value;
          }
        }
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
    var key, proto, result, _i, _len, _ref1;
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

  exports.tryFunction = function(func, context, args, onFail) {
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
      if (typeof onFail === 'function') {
        return onFail(err);
      } else {
        return onFail;
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

  exports.bindFunctionContext = function(func, ctx) {
    null;
    //<development>;
    if (typeof func !== 'function') {
      throw new Error("utils.bindFunctionContext function must be a function");
    }
    //</development>;
    switch (func.length) {
      case 0:
        return function() {
          return func.call(ctx);
        };
      case 1:
        return function(a1) {
          return func.call(ctx, a1);
        };
      case 2:
        return function(a1, a2) {
          return func.call(ctx, a1, a2);
        };
      case 3:
        return function(a1, a2, a3) {
          return func.call(ctx, a1, a2, a3);
        };
      case 4:
        return function(a1, a2, a3, a4) {
          return func.call(ctx, a1, a2, a3, a4);
        };
      case 5:
        return function(a1, a2, a3, a4, a5) {
          return func.call(ctx, a1, a2, a3, a4, a5);
        };
      case 6:
        return function(a1, a2, a3, a4, a5, a6) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6);
        };
      case 7:
        return function(a1, a2, a3, a4, a5, a6, a7) {
          return func.call(ctx, a1, a2, a3, a4, a5, a6, a7);
        };
      default:
        return function() {
          return func.apply(ctx, arguments);
        };
    }
  };

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
    forArrays = function(a, b, compareFunc, maxDeep) {
      var aValue, bValue, isTrue, _i, _j, _k, _l, _len, _len1, _len2, _len3;
      if (getPrototypeOf(a) !== getPrototypeOf(b)) {
        return false;
      }
      if (a.length !== b.length) {
        return false;
      }
      if (maxDeep <= 0) {
        return true;
      }
      for (_i = 0, _len = a.length; _i < _len; _i++) {
        aValue = a[_i];
        isTrue = false;
        for (_j = 0, _len1 = b.length; _j < _len1; _j++) {
          bValue = b[_j];
          if (bValue && typeof bValue === 'object') {
            if (isEqual(aValue, bValue, compareFunc, maxDeep - 1)) {
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
            if (isEqual(bValue, aValue, compareFunc, maxDeep - 1)) {
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
    forObjects = function(a, b, compareFunc, maxDeep) {
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
        if (!(a.hasOwnProperty(key))) {
          continue;
        }
        if (value && typeof value === 'object') {
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
    return function(a, b, compareFunc, maxDeep) {
      if (compareFunc == null) {
        compareFunc = defaultComparison;
      }
      if (maxDeep == null) {
        maxDeep = Infinity;
      }
      if (typeof compareFunc === 'number') {
        maxDeep = compareFunc;
        compareFunc = defaultComparison;
      }
      //<development>;
      if (typeof compareFunc !== 'function') {
        throw new Error("utils.isEqual compareFunction must be a function");
      }
      if (typeof maxDeep !== 'number') {
        throw new Error("utils.isEqual maxDeep must be a number");
      }
      //</development>;
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
  })();

}).call(this);


return module.exports;
})();modules['../assert/index.coffee.md'] = (function(){
var module = {exports: modules["../assert/index.coffee.md"]};
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
      if (utils.isAndroid) {
        console.error(this.stack || this.message);
      } else if (utils.isQt) {
        console.trace();
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

  assert.isEqual = function(val1, val2, msg, opts) {
    if (typeof msg === 'object') {
      opts = msg;
      msg = void 0;
    }
    if (!utils.isEqual(val1, val2, opts != null ? opts.maxDeep : void 0)) {
      return this.fail(val1, val2, msg, 'equal', assert.isEqual);
    }
  };

  assert.isNotEqual = function(val1, val2, msg, opts) {
    if (typeof msg === 'object') {
      opts = msg;
      msg = void 0;
    }
    if (utils.isEqual(val1, val2, opts != null ? opts.maxDeep : void 0)) {
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
})();modules['../log/impls/browser/index.coffee'] = (function(){
var module = {exports: modules["../log/impls/browser/index.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var logFunc, performance,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  performance = (function() {
    var _ref;
    if ((_ref = window.performance) != null ? _ref.now : void 0) {
      return window.performance;
    } else {
      return Date;
    }
  })();

  logFunc = window['cons' + 'ole']['lo' + 'g'];

  module.exports = (function() {
    if (/chrome|safari/i.test(navigator.userAgent) || (typeof webkit !== "undefined" && webkit !== null)) {
      return function(Log) {
        var LogBrowser;
        return LogBrowser = (function(_super) {
          __extends(LogBrowser, _super);

          function LogBrowser() {
            return LogBrowser.__super__.constructor.apply(this, arguments);
          }

          LogBrowser.MARKERS = (function() {
            var marker, tmp;
            tmp = ['', ''];
            marker = function(color, style, msg) {
              if (style == null) {
                style = 'normal';
              }
              tmp[0] = "%c" + msg;
              tmp[1] = "color: " + color + "; font-weight: " + style;
              return tmp;
            };
            return {
              white: marker.bind(null, 'black', null),
              green: marker.bind(null, 'green', null),
              gray: marker.bind(null, 'gray', null),
              blue: marker.bind(null, 'blue', null),
              yellow: marker.bind(null, 'orange', null),
              red: marker.bind(null, 'red', null),
              bold: marker.bind(null, 'black', 'bold')
            };
          })();

          LogBrowser.time = performance.now.bind(performance);

          LogBrowser.timeDiff = function(since) {
            return LogBrowser.time() - since;
          };

          LogBrowser.prototype._write = function(marker) {
            return logFunc.apply(window['cons' + 'ole'], marker);
          };

          return LogBrowser;

        })(Log);
      };
    } else {
      return {};
    }
  })();

}).call(this);


return module.exports;
})();modules['../log/index.coffee.md'] = (function(){
var module = {exports: modules["../log/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./impls/browser/index.coffee":"../log/impls/browser/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Log, LogImpl, assert, bind, fromArgs, impl, isArray, unshift, utils,
    __slice = [].slice;

  utils = require('utils');

  assert = require('assert');

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
      case utils.isIOS:
        return require('./impls/browser/index.coffee');
    }
  })();

  LogImpl = typeof impl === 'function' ? impl(Log) : Log;

  module.exports = new LogImpl;

}).call(this);


return module.exports;
})();modules['../signal/emitter.coffee'] = (function(){
var module = {exports: modules["../signal/emitter.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

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
        if (obj && (listeners = obj._signals[name])) {
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./emitter":"../signal/emitter.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var STOP_PROPAGATION, SignalPrototype, assert, callSignal, createSignalFunction, utils;

  utils = require('utils');

  assert = require('assert');

  STOP_PROPAGATION = exports.STOP_PROPAGATION = 1 << 30;

  exports.create = function(obj, name) {
    var signal;
    signal = createSignalFunction(obj);
    if (name === void 0) {
      return signal;
    }
    assert.isNotPrimitive(obj, 'signal object cannot be primitive');
    assert.isString(name, 'signal name must be a string');
    assert.notLengthOf(name, 0, 'signal name cannot be an empty string');
    assert(!obj.hasOwnProperty(name), "signal object has already defined the '" + name + "' property");
    return obj[name] = signal;
  };

  exports.isEmpty = function(signal) {
    var func, _i, _len, _ref;
    _ref = signal.listeners;
    for (_i = 0, _len = _ref.length; _i < _len; _i += 2) {
      func = _ref[_i];
      if (func !== null) {
        return false;
      }
    }
    return true;
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
        if (result <= 0 && func.call(ctx || obj, arg1, arg2) === STOP_PROPAGATION) {
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
      assert.isFunction(this, "emit must be called on a signal function");
      assert.isArray(this.listeners, "emit must be called on a signal function");
      assert.operator(arguments.length, '<', 3, 'signal accepts maximally two parameters; use object instead');
      return callSignal(this.obj, this.listeners, arg1, arg2);
    },
    connect: function(listener, ctx) {
      var i, listeners, n;
      if (ctx == null) {
        ctx = null;
      }
      assert.isFunction(this, "connect must be called on a signal function");
      assert.isFunction(listener, "listener is not a function");
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
      assert.isFunction(this, "disconnect must be called on a signal function");
      assert.isFunction(listener, "listener is not a function");
      listeners = this.listeners;
      index = 0;
      while (true) {
        index = listeners.indexOf(listener, index);
        if (index === -1 || listeners[index + 1] === ctx) {
          break;
        }
        index += 2;
      }
      assert.isNot(index, -1, "listener doesn't exist in this signal");
      assert.is(listeners[index], listener);
      assert.is(listeners[index + 1], ctx);
      listeners[index] = null;
      listeners[index + 1] = null;
    },
    disconnectAll: function() {
      var i, listeners, _, _i, _len;
      assert.isFunction(this, "disconnectAll must be called on a signal function");
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

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
      throw "Can't get elements from a list as properties; " + "use `List::get()` method instead";
    }, function() {
      throw "Can't set elements into a list with properties; " + "use `List::set()` method instead";
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

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
  var utils;

  utils = require('utils');

  module.exports = (function() {
    var impl;
    if (utils.isBrowser) {
      impl = require('./implementations/browser');
    }
    impl || (impl = require('./implementations/memory'));
    return impl;
  })();

}).call(this);


return module.exports;
})();modules['../db/index.coffee.md'] = (function(){
var module = {exports: modules["../db/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","list":"../list/index.coffee.md","dict":"../dict/index.coffee.md","./implementation":"../db/implementation.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var BITMASK, DbDict, DbList, Dict, List, NOP, assert, createPassProperty, impl, utils, watchers, watchersCount,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  assert = require('assert');

  utils = require('utils');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('assert');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('assert');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  assert = require('assert');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert(expected instanceof RegExp, "regexp validator option for the " + row + " property must be a regular expression");
      if (!expected.test(value)) {
        throw new Schema.Error(row, 'regexp', "" + row + " doesn't pass the regular expression");
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/validators/type.coffee.md'] = (function(){
var module = {exports: modules["../schema/validators/type.coffee.md"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('assert');

  module.exports = function(Schema) {
    return function(row, value, expected) {
      assert.isString(expected, "type validator option for " + row + " property must be a string");
      if (typeof value !== expected) {
        throw new Schema.Error(row, 'type', "" + row + " must be a " + expected);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../schema/index.coffee.md'] = (function(){
var module = {exports: modules["../schema/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./validators/array":"../schema/validators/array.coffee.md","./validators/object":"../schema/validators/object.coffee.md","./validators/optional":"../schema/validators/optional.coffee.md","./validators/max":"../schema/validators/max.coffee.md","./validators/min":"../schema/validators/min.coffee.md","./validators/options":"../schema/validators/options.coffee.md","./validators/regexp":"../schema/validators/regexp.coffee.md","./validators/type":"../schema/validators/type.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Schema, SchemaError, assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

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
})();modules['../networking/impl/ios/index.coffee'] = (function(){
var module = {exports: modules["../networking/impl/ios/index.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./request.coffee":"../networking/impl/ios/request.coffee","./response.coffee":"../networking/impl/ios/response.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(Networking) {
    var impl;
    impl = {};
    return {
      Request: require('./request.coffee')(Networking),
      Response: require('./response.coffee')(Networking, impl),
      init: function(networking) {
        setImmediate(function() {
          return networking.createLocalRequest({
            method: Networking.Request.GET,
            type: Networking.Request.HTML_TYPE,
            uri: '/'
          });
        });
      },

      /*
      	Send a XHR request and call `callback` on response.
       */
      sendRequest: function(req, res, callback) {
        var Request, cookies, data, name, uri, val, xhr, _ref;
        Request = Networking.Request;
        xhr = new XMLHttpRequest;
        uri = req.uri.toString();
        if (utils.has(uri, '?')) {
          uri = "" + uri + "&now=" + (Date.now());
        } else {
          uri = "" + uri + "?now=" + (Date.now());
        }
        xhr.open(req.method, uri, true);
        _ref = req.headers;
        for (name in _ref) {
          val = _ref[name];
          xhr.setRequestHeader(name, val);
        }
        xhr.setRequestHeader('X-Expected-Type', req.type);
        if (cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)) {
          xhr.setRequestHeader('X-Cookies', cookies);
        }
        xhr.onload = function() {
          var response;
          response = xhr.response;
          if (req.type === Request.JSON_TYPE && typeof response === 'string') {
            response = utils.tryFunction(JSON.parse, null, [response], response);
          }
          if (cookies = xhr.getResponseHeader('X-Cookies')) {
            cookies = utils.tryFunction(JSON.parse, null, [cookies], null);
          }
          return callback({
            status: xhr.status,
            data: response,
            cookies: cookies
          });
        };
        xhr.onerror = function() {
          return callback({
            status: xhr.status,
            data: xhr.response
          });
        };
        if (utils.isObject(req.data)) {
          data = utils.tryFunction(JSON.stringify, null, [req.data], req.data);
        } else {
          data = req.data;
        }
        return xhr.send(data);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../networking/impl.coffee'] = (function(){
var module = {exports: modules["../networking/impl.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./impl/ios/index":"../networking/impl/ios/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var PlatformImpl, assert, utils;

  utils = require('utils');

  assert = require('assert');

  PlatformImpl = (function() {
    switch (true) {
      case utils.isNode:
        return require('./impl/node/index');
      case utils.isBrowser:
        return require('./impl/browser/index');
      case utils.isIOS:
        return require('./impl/ios/index');
      case utils.isQt:
        return require('./impl/qt/index');
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
})();modules['../networking/impl/ios/request.coffee'] = (function(){
var module = {exports: modules["../networking/impl/ios/request.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(Networking) {};

}).call(this);


return module.exports;
})();modules['../document/element/element/text.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element/text.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, emitSignal, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('View.Element.Text');

  module.exports = function(Element) {
    var Text;
    return Text = (function(_super) {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_TEXT, i, opts;

      __extends(Text, _super);

      Text.__name__ = 'Text';

      Text.__path__ = 'File.Element.Text';

      JSON_CTOR_ID = Text.JSON_CTOR_ID = Element.JSON_CTORS.push(Text) - 1;

      i = Element.JSON_ARGS_LENGTH;

      JSON_TEXT = i++;

      JSON_ARGS_LENGTH = Text.JSON_ARGS_LENGTH = i;

      Text._fromJSON = function(arr, obj) {
        if (obj == null) {
          obj = new Text;
        }
        Element._fromJSON(arr, obj);
        obj.text = arr[JSON_TEXT];
        return obj;
      };

      function Text() {
        Element.call(this);
        this._text = '';
        //<development>;
        if (this.constructor === Text) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      Text.prototype.clone = function() {
        var clone;
        clone = new Text;
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
        Element.Tag.query.checkWatchersDeeply(this);
        return true;
      });

      Text.prototype.toJSON = function(arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        Text.__super__.toJSON.call(this, arr);
        arr[JSON_TEXT] = this.text;
        return arr;
      };

      return Text;

    })(Element);
  };

}).call(this);


return module.exports;
})();modules['../document/element/element/tag/stringify.coffee'] = (function(){
var module = {exports: modules["../document/element/element/tag/stringify.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var SINGLE_TAG, getInnerHTML, getOuterHTML, isPublic;

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
    return !/^(?:neft:|style:)/.test(name);
  };

  getInnerHTML = function(elem, replacements) {
    var child, r, _i, _len, _ref;
    if (elem.children) {
      r = "";
      _ref = elem.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        r += getOuterHTML(child, replacements);
      }
      return r;
    } else {
      return "";
    }
  };

  getOuterHTML = function(elem, replacements) {
    var attrName, attrValue, name, replacer, ret, _ref;
    if (elem._visible === false) {
      return "";
    }
    if (elem._text !== void 0) {
      return elem._text;
    }
    if (replacements && (replacer = replacements[elem.name])) {
      elem = replacer(elem) || elem;
    }
    name = elem.name;
    if (!name || !isPublic(name)) {
      return getInnerHTML(elem, replacements);
    }
    ret = "<" + name;
    _ref = elem._attrs;
    for (attrName in _ref) {
      attrValue = _ref[attrName];
      if ((attrValue == null) || !isPublic(attrName)) {
        continue;
      }
      ret += " " + attrName + "=\"" + attrValue + "\"";
    }
    if (SINGLE_TAG[name]) {
      return ret + ">";
    } else {
      return ret + ">" + getInnerHTML(elem, replacements) + "</" + name + ">";
    }
  };

  module.exports = {
    getInnerHTML: getInnerHTML,
    getOuterHTML: getOuterHTML
  };

}).call(this);


return module.exports;
})();modules['../typed-array/index.coffee.md'] = (function(){
var module = {exports: modules["../typed-array/index.coffee.md"]};
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
})();modules['../document/element/element/tag.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element/tag.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md","./tag/stringify":"../document/element/element/tag/stringify.coffee","typed-array":"../typed-array/index.coffee.md","./tag/query":"../document/element/element/tag/query.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var CSS_ID_RE, TypedArray, assert, emitSignal, isDefined, signal, stringify, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  stringify = require('./tag/stringify');

  TypedArray = require('typed-array');

  emitSignal = signal.Emitter.emitSignal;

  assert = assert.scope('View.Element.Tag');

  isDefined = function(elem) {
    return elem != null;
  };

  CSS_ID_RE = /\#([^\s]+)/;

  module.exports = function(Element) {
    var Tag;
    return Tag = (function(_super) {
      var JSON_ARGS_LENGTH, JSON_ATTRS, JSON_CHILDREN, JSON_CTOR_ID, JSON_NAME, i, query;

      __extends(Tag, _super);

      Tag.INTERNAL_TAGS = ['neft:attr', 'neft:fragment', 'neft:function', 'neft:rule', 'neft:target', 'neft:use', 'neft:require', 'neft:blank', 'neft:log'];

      Tag.DEFAULT_STRINGIFY_REPLACEMENTS = Object.create(null);

      Tag.extensions = Object.create(null);

      Tag.__name__ = 'Tag';

      Tag.__path__ = 'File.Element.Tag';

      JSON_CTOR_ID = Tag.JSON_CTOR_ID = Element.JSON_CTORS.push(Tag) - 1;

      i = Element.JSON_ARGS_LENGTH;

      JSON_NAME = i++;

      JSON_CHILDREN = i++;

      JSON_ATTRS = i++;

      JSON_ARGS_LENGTH = Tag.JSON_ARGS_LENGTH = i;

      Tag._fromJSON = function(arr, obj) {
        var child, _i, _len, _ref;
        if (obj == null) {
          obj = new Tag;
        }
        Element._fromJSON(arr, obj);
        obj.name = arr[JSON_NAME];
        obj._attrs = arr[JSON_ATTRS];
        _ref = arr[JSON_CHILDREN];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          Element.fromJSON(child).parent = obj;
        }
        return obj;
      };

      function Tag() {
        Element.call(this);
        this.name = 'neft:blank';
        this.children = [];
        this._attrs = {};
        //<development>;
        if (this.constructor === Tag) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      signal.Emitter.createSignal(Tag, 'onChildrenChange');

      signal.Emitter.createSignal(Tag, 'onAttrsChange');

      Tag.prototype.getAttrByIndex = function(index, target) {
        var key, val, _ref;
        if (target == null) {
          target = [];
        }
        assert.isArray(target);
        target[0] = target[1] = void 0;
        i = 0;
        _ref = this._attrs;
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
      };

      Tag.prototype.hasAttr = function(name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        return this._attrs.hasOwnProperty(name);
      };

      Tag.prototype.getAttr = function(name) {
        assert.isString(name);
        assert.notLengthOf(name, 0);
        return this._attrs[name];
      };

      Tag.prototype.setAttr = function(name, value) {
        var old;
        assert.isString(name);
        assert.notLengthOf(name, 0);
        old = this._attrs[name];
        if (old === value) {
          return false;
        }
        this._attrs[name] = value;
        emitSignal(this, 'onAttrsChange', name, old);
        query.checkWatchersDeeply(this);
        return true;
      };

      Tag.prototype.clone = function() {
        var clone;
        clone = new Tag;
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
      })();

      Tag.prototype.getChildByAccessPath = function(arr) {
        var elem, _i;
        assert.isArray(arr);
        elem = this;
        for (_i = arr.length - 1; _i >= 0; _i += -1) {
          i = arr[_i];
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

      Tag.prototype.stringify = function(replacements) {
        if (replacements == null) {
          replacements = Tag.DEFAULT_STRINGIFY_REPLACEMENTS;
        }
        return stringify.getOuterHTML(this, replacements);
      };

      Tag.prototype.stringifyChildren = function(replacements) {
        if (replacements == null) {
          replacements = Tag.DEFAULT_STRINGIFY_REPLACEMENTS;
        }
        return stringify.getInnerHTML(this, replacements);
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

      Tag.prototype.toJSON = function(arr) {
        var child, children, _i, _len, _ref;
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        Tag.__super__.toJSON.call(this, arr);
        arr[JSON_NAME] = this.name;
        children = arr[JSON_CHILDREN] = [];
        arr[JSON_ATTRS] = this._attrs;
        _ref = this.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          children.push(child.toJSON());
        }
        return arr;
      };

      return Tag;

    })(Element);
  };

}).call(this);


return module.exports;
})();modules['../document/element/element/tag/query.coffee'] = (function(){
var module = {exports: modules["../document/element/element/tag/query.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var ATTR_CLASS_SEARCH, ATTR_SEARCH, ATTR_VALUE_SEARCH, CONTAINS, DEEP, ENDS_WITH, OPTS_ADD_ANCHOR, OPTS_QUERY_BY_PARENTS, OPTS_REVERSED, STARTS_WITH, TRIM_ATTR_VALUE, TYPE, Tag, Text, Watcher, anyChild, anyDescendant, anyParent, assert, byAttr, byAttrContainsValue, byAttrEndsWithValue, byAttrStartsWithValue, byAttrValue, byInstance, byName, byTag, directParent, emitSignal, getQueries, i, queriesCache, signal, test, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  emitSignal = signal.Emitter.emitSignal;

  Tag = Text = null;

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
    var child, _i, _len, _ref;
    _ref = node.children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      if (!(child instanceof Tag) || child.name !== 'neft:blank') {
        if (test(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
          }
        }
      }
      if (child instanceof Tag) {
        if (anyDescendant(child, funcs, index, targetFunc, targetCtx, single)) {
          if (single) {
            return true;
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
    var child, _i, _len, _ref;
    _ref = node.children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      if (child instanceof Tag && child.name === 'neft:blank') {
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
    if (node instanceof Tag) {
      return node.name === data1;
    } else if (data1 === '#text' && node instanceof Text) {
      return true;
    }
  };

  byName.isIterator = false;

  byName.toString = function() {
    return 'byName';
  };

  byInstance = function(node, data1) {
    return node instanceof data1;
  };

  byInstance.isIterator = false;

  byInstance.toString = function() {
    return 'byInstance';
  };

  byTag = function(node, data1) {
    return node === data1;
  };

  byTag.isIterator = false;

  byTag.toString = function() {
    return 'byTag';
  };

  byAttr = function(node, data1) {
    if (node instanceof Tag) {
      return node._attrs[data1] !== void 0;
    } else {
      return false;
    }
  };

  byAttr.isIterator = false;

  byAttr.toString = function() {
    return 'byAttr';
  };

  byAttrValue = function(node, data1, data2) {
    if (node instanceof Tag) {
      return node._attrs[data1] == data2;
    } else {
      return false;
    }
  };

  byAttrValue.isIterator = false;

  byAttrValue.toString = function() {
    return 'byAttrValue';
  };

  byAttrStartsWithValue = function(node, data1, data2) {
    var attr;
    if (node instanceof Tag) {
      attr = node._attrs[data1];
      if (typeof attr === 'string') {
        return attr.indexOf(data2) === 0;
      }
    }
    return false;
  };

  byAttrStartsWithValue.isIterator = false;

  byAttrStartsWithValue.toString = function() {
    return 'byAttrStartsWithValue';
  };

  byAttrEndsWithValue = function(node, data1, data2) {
    var attr;
    if (node instanceof Tag) {
      attr = node._attrs[data1];
      if (typeof attr === 'string') {
        return attr.indexOf(data2, attr.length - data2.length) > -1;
      }
    }
    return false;
  };

  byAttrEndsWithValue.isIterator = false;

  byAttrEndsWithValue.toString = function() {
    return 'byAttrEndsWithValue';
  };

  byAttrContainsValue = function(node, data1, data2) {
    var attr;
    if (node instanceof Tag) {
      attr = node._attrs[data1];
      if (typeof attr === 'string') {
        return attr.indexOf(data2) > -1;
      }
    }
    return false;
  };

  byAttrContainsValue.isIterator = false;

  byAttrContainsValue.toString = function() {
    return 'byAttrContainsValue';
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

    Watcher.watchers = [];

    Watcher.create = function(node, queries) {
      var watcher;
      if (pool.length) {
        watcher = pool.pop();
        watcher.node = node;
        watcher.queries = queries;
        watcher.forceUpdate = true;
      } else {
        watcher = new Watcher(node, queries);
        Watcher.watchers.push(watcher);
      }
      return watcher;
    };

    function Watcher(node, queries) {
      this.node = node;
      this.queries = queries;
      Watcher.__super__.constructor.call(this);
      this.uid = utils.uid();
      this.nodes = [];
      this.forceUpdate = true;
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
      var node, nodes, uid;
      assert.ok(this.node);
      uid = this.uid, nodes = this.nodes;
      while (node = nodes.pop()) {
        node._inWatchers[uid] = false;
        emitSignal(this, 'onRemove', node);
      }
      this.onAdd.disconnectAll();
      this.onRemove.disconnectAll();
      this.node = this.queries = null;
      pool.push(this);
    };

    return Watcher;

  })(signal.Emitter);

  module.exports = function(Element, _Tag) {
    var checkWatchersDeeply, query, queryAll;
    Tag = _Tag;
    Text = Element.Text;
    return {
      getSelectorCommandsLength: module.exports.getSelectorCommandsLength,
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
        var CHECK_WATCHERS_ALL, CHECK_WATCHERS_CHILDREN, CHECK_WATCHERS_THIS, checkRec, clearRec, isChildOf, pending, updateWatcher, updateWatchers;
        pending = false;
        i = 0;
        CHECK_WATCHERS_THIS = 1 << i++;
        CHECK_WATCHERS_CHILDREN = 1 << i++;
        CHECK_WATCHERS_ALL = (1 << i++) - 1;
        checkRec = function(watcher, watcherUid, node, update) {
          var child, inWatchers, _i, _len, _ref;
          if (!(update & CHECK_WATCHERS_THIS)) {
            update |= node._checkWatchers;
          }
          if (update & CHECK_WATCHERS_THIS) {
            inWatchers = node._inWatchers;
            if ((!inWatchers || !inWatchers[watcherUid]) && watcher.test(node)) {
              if (!inWatchers) {
                node._inWatchers = {};
              }
              node._inWatchers[watcherUid] = true;
              watcher.nodes.push(node);
              emitSignal(watcher, 'onAdd', node);
            } else if (inWatchers && inWatchers[watcherUid] && !watcher.test(node)) {
              node._inWatchers[watcherUid] = false;
              utils.removeFromUnorderedArray(watcher.nodes, node);
              emitSignal(watcher, 'onRemove', node);
            }
          }
          if (update & CHECK_WATCHERS_CHILDREN && node instanceof Tag) {
            _ref = node.children;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              if (update & CHECK_WATCHERS_THIS || child._checkWatchers) {
                checkRec(watcher, watcherUid, child, update);
              }
            }
          }
        };
        clearRec = function(node) {
          var child, _i, _len, _ref;
          node._checkWatchers = 0;
          if (node instanceof Tag) {
            _ref = node.children;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              child = _ref[_i];
              if (child._checkWatchers > 0) {
                clearRec(child);
              }
            }
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
        updateWatcher = function(watcher) {
          var n, node, nodes, watcherNode;
          nodes = watcher.nodes;
          watcherNode = watcher.node;
          i = n = nodes.length;
          while (i-- > 0) {
            node = nodes[i];
            if (node !== watcherNode && !isChildOf(node, watcherNode)) {
              node._inWatchers[watcher.uid] = false;
              nodes[i] = nodes[n - 1];
              nodes.pop();
              emitSignal(watcher, 'onRemove', node);
              n--;
            }
          }
          if (watcher.forceUpdate) {
            checkRec(watcher, watcher.uid, watcher.node, CHECK_WATCHERS_ALL);
            watcher.forceUpdate = false;
          } else {
            checkRec(watcher, watcher.uid, watcher.node, 0);
          }
        };
        updateWatchers = function() {
          var watcher, watchers, _i, _j, _len, _len1;
          pending = false;
          watchers = Watcher.watchers;
          for (_i = 0, _len = watchers.length; _i < _len; _i++) {
            watcher = watchers[_i];
            if (watcher.node) {
              updateWatcher(watcher);
            }
          }
          for (_j = 0, _len1 = watchers.length; _j < _len1; _j++) {
            watcher = watchers[_j];
            if (watcher.node) {
              clearRec(watcher.node);
            }
          }
        };
        return function(node) {
          var tmp;
          tmp = node;
          node._checkWatchers |= CHECK_WATCHERS_THIS;
          while (tmp = tmp._parent) {
            if (tmp._checkWatchers & CHECK_WATCHERS_CHILDREN) {
              break;
            }
            tmp._checkWatchers |= CHECK_WATCHERS_CHILDREN;
          }
          if (!pending) {
            setImmediate(updateWatchers);
            pending = true;
          }
        };
      })()
    };
  };

  module.exports.getSelectorCommandsLength = function(selector, beginQuery, endQuery) {
    var queries, query, sum, _i, _len;
    if (beginQuery == null) {
      beginQuery = 0;
    }
    if (endQuery == null) {
      endQuery = Infinity;
    }
    sum = 0;
    queries = getQueries(selector, 0);
    for (i = _i = 0, _len = queries.length; _i < _len; i = ++_i) {
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

}).call(this);


return module.exports;
})();modules['../document/element/element.coffee.md'] = (function(){
var module = {exports: modules["../document/element/element.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md","./element/text":"../document/element/element/text.coffee.md","./element/tag":"../document/element/element/tag.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Element, Emitter, assert, emitSignal, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  signal = require('signal');

  isArray = Array.isArray;

  Emitter = signal.Emitter;

  emitSignal = Emitter.emitSignal;

  assert = assert.scope('View.Element');

  Element = (function(_super) {
    var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_VISIBLE, Tag, i, opts;

    __extends(Element, _super);

    Element.__name__ = 'Element';

    Element.__path__ = 'File.Element';

    Element.JSON_CTORS = [];

    JSON_CTOR_ID = Element.JSON_CTOR_ID = Element.JSON_CTORS.push(Element) - 1;

    i = 1;

    JSON_VISIBLE = i++;

    JSON_ARGS_LENGTH = Element.JSON_ARGS_LENGTH = i;

    Element.fromHTML = function(html) {
      assert.isString(html);
      if (!utils.isNode) {
        throw "Creating Views from HTML files is allowed only on a server";
      }
      return Element.parser.parse(html);
    };

    Element.fromJSON = function(json) {
      if (typeof json === 'string') {
        json = JSON.parse(json);
      }
      assert.isArray(json);
      return Element.JSON_CTORS[json[0]]._fromJSON(json);
    };

    Element._fromJSON = function(arr, obj) {
      if (obj == null) {
        obj = new Element;
      }
      obj.visible = arr[JSON_VISIBLE] === 1;
      return obj;
    };

    Element.Text = require('./element/text')(Element);

    Element.Tag = Tag = require('./element/tag')(Element);

    function Element() {
      Emitter.call(this);
      this._parent = null;
      this._nextSibling = null;
      this._previousSibling = null;
      this._style = null;
      this._documentStyle = null;
      this._visible = true;
      this._inWatchers = null;
      this._checkWatchers = 0;
      //<development>;
      if (this.constructor === Element) {
        Object.preventExtensions(this);
      }
      //</development>;
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

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'style', opts, function() {
      return this._style;
    }, function(val) {
      var old;
      old = this._style;
      if (old === val) {
        return false;
      }
      this._style = val;
      emitSignal(this, 'onStyleChange', old, val);
      return true;
    });

    signal.Emitter.createSignal(Element, 'onStyleChange');

    opts = utils.CONFIGURABLE;

    utils.defineProperty(Element.prototype, 'visible', opts, function() {
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

    signal.Emitter.createSignal(Element, 'onVisibleChange');

    Element.prototype.queryAllParents = Tag.query.queryAllParents;

    Element.prototype.queryParents = Tag.query.queryParents;

    Element.prototype.getAccessPath = function(toParent) {
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

    Element.prototype.clone = function() {
      return new Element;
    };

    Element.prototype.cloneDeep = function() {
      return this.clone();
    };

    Element.prototype.toJSON = function(arr) {
      if (!arr) {
        arr = new Array(JSON_ARGS_LENGTH);
        arr[0] = JSON_CTOR_ID;
      }
      arr[JSON_VISIBLE] = this.visible ? 1 : 0;
      return arr;
    };

    if (utils.isNode) {
      Element.parser = require('./element/parser')(Element);
    }

    return Element;

  })(Emitter);

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  assert = require('assert');

  utils = require('utils');

  log = require('log');

  assert = assert.scope('View.AttrChange');

  log = log.scope('View', 'AttrChange');

  module.exports = function(File) {
    var AttrChange;
    return AttrChange = (function() {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_NAME, JSON_NODE, JSON_TARGET, i, onAttrsChange, onVisibleChange;

      AttrChange.__name__ = 'AttrChange';

      AttrChange.__path__ = 'File.AttrChange';

      JSON_CTOR_ID = AttrChange.JSON_CTOR_ID = File.JSON_CTORS.push(AttrChange) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_TARGET = i++;

      JSON_NAME = i++;

      JSON_ARGS_LENGTH = AttrChange.JSON_ARGS_LENGTH = i;

      AttrChange._fromJSON = function(file, arr, obj) {
        var node, target;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          target = file.node.getChildByAccessPath(arr[JSON_TARGET]);
          obj = new AttrChange(file, node, target, arr[JSON_NAME]);
        }
        return obj;
      };

      function AttrChange(file, node, target, name) {
        this.file = file;
        this.node = node;
        this.target = target;
        this.name = name;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        assert.instanceOf(target, File.Element);
        assert.isString(name);
        assert.notLengthOf(name, 0);
        this._defaultValue = target.getAttr(name);
        this.update();
        node.onVisibleChange(onVisibleChange, this);
        node.onAttrsChange(onAttrsChange, this);
        //<development>;
        if (this.constructor === AttrChange) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      AttrChange.prototype.update = function() {
        var val;
        val = this.node.visible ? this.node.getAttr('value') : this._defaultValue;
        this.target.setAttr(this.name, val);
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

      AttrChange.prototype.clone = function(original, file) {
        var node, target;
        node = original.node.getCopiedElement(this.node, file.node);
        target = original.node.getCopiedElement(this.target, file.node);
        return new AttrChange(file, node, target, this.name);
      };

      AttrChange.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        arr[JSON_TARGET] = this.target.getAccessPath(this.file.node);
        arr[JSON_NAME] = this.name;
        return arr;
      };

      return AttrChange;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/use.coffee'] = (function(){
var module = {exports: modules["../document/use.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  assert = assert.scope('View.Use');

  log = log.scope('View', 'Use');

  module.exports = function(File) {
    var Use;
    return Use = (function() {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_NODE, attrsChangeListener, i, logUsesWithNoFragments, queue, queuePending, runQueue, usesWithNotFoundFragments, visibilityChangeListener;

      Use.__name__ = 'Use';

      Use.__path__ = 'File.Use';

      JSON_CTOR_ID = Use.JSON_CTOR_ID = File.JSON_CTORS.push(Use) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_ARGS_LENGTH = Use.JSON_ARGS_LENGTH = i;

      Use._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new Use(file, node);
        }
        return obj;
      };

      visibilityChangeListener = function() {
        if (this.file.isRendered && !this.isRendered) {
          return this.render();
        }
      };

      attrsChangeListener = function(name) {
        if (name === 'neft:fragment') {
          this.name = this.node.getAttr('neft:fragment');
          if (this.isRendered) {
            this.revert();
            this.render();
          }
        }
      };

      queue = [];

      queuePending = false;

      runQueue = function() {
        var file, style;
        style = queue.shift();
        file = queue.shift();
        if (style.isRendered) {
          style.renderFragment(file);
        }
        if (queue.length) {
          requestAnimationFrame(runQueue);
        } else {
          queuePending = false;
        }
      };

      function Use(file, node) {
        this.file = file;
        this.node = node;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        this.name = node.getAttr('neft:fragment');
        this.usedFragment = null;
        this.isRendered = false;
        node.onVisibleChange(visibilityChangeListener, this);
        node.onAttrsChange(attrsChangeListener, this);
        //<development>;
        if (this.constructor === Use) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      //<development>;

      usesWithNotFoundFragments = [];

      logUsesWithNoFragments = function() {
        var useElem;
        while (useElem = usesWithNotFoundFragments.pop()) {
          if (!useElem.usedFragment) {
            log.warn("neft:fragment '" + useElem.name + "' can't be find in file '" + useElem.file.path + "'");
          }
        }
      };

      //</development>;

      Use.prototype.render = function(file) {
        var useAsync;
        if (file != null) {
          assert.instanceOf(file, File);
        }
        if (!this.node.visible) {
          return;
        }
        if (this.isRendered) {
          this.revert();
        }
        this.isRendered = true;
        useAsync = utils.isClient;
        useAsync && (useAsync = this.node.hasAttr('neft:async'));
        useAsync && (useAsync = this.node.getAttr('neft:async') !== false);
        if (useAsync) {
          queue.push(this, file);
          if (!queuePending) {
            requestAnimationFrame(runQueue);
            queuePending = true;
          }
        } else {
          this.renderFragment(file);
        }
      };

      Use.prototype.renderFragment = function(file) {
        var fragment, usedFragment, _ref;
        fragment = this.file.fragments[this.name];
        if (!file && !fragment) {
          //<development>;
          //</development>;
          return;
        }
        usedFragment = file || File.factory(fragment);
        if (!file) {
          usedFragment.storage = this.file.storage;
        }
        if (file) {
          if ((_ref = file.parentUse) != null) {
            _ref.detachUsedFragment();
          }
        }
        if (!usedFragment.isRendered) {
          usedFragment = usedFragment.render(this);
        }
        usedFragment.node.parent = this.node;
        this.usedFragment = usedFragment;
        usedFragment.parentUse = this;
        usedFragment.onReplaceByUse.emit(this);
      };

      Use.prototype.revert = function() {
        if (!this.isRendered) {
          return;
        }
        if (this.usedFragment) {
          this.usedFragment.revert().destroy();
        }
        this.isRendered = false;
      };

      Use.prototype.detachUsedFragment = function() {
        assert.isDefined(this.usedFragment);
        this.usedFragment.node.parent = null;
        this.usedFragment.parentUse = null;
        this.usedFragment = null;
      };

      Use.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new Use(file, node);
      };

      Use.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        return arr;
      };

      return Use;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/input.coffee'] = (function(){
var module = {exports: modules["../document/input.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","dict":"../dict/index.coffee.md","list":"../list/index.coffee.md","db":"../db/index.coffee.md","./input/text.coffee":"../document/input/text.coffee","./input/attr.coffee":"../document/input/attr.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, List, assert, log, utils;

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  Dict = require('dict');

  List = require('list');

  assert = assert.scope('View.Input');

  log = log.scope('View', 'Input');

  module.exports = function(File) {
    var Input;
    return Input = (function() {
      var CONSTANT_VARS, Element, GLOBAL, JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_FUNC_BODY, JSON_NODE, JSON_TEXT, PROPS_RE, PROP_RE, RE, VAR_RE, cache, getNamedSignal, i, onChange, pending, queue, queueIndex, queues, revertTraces, updateItems;

      Element = File.Element;

      Input.__name__ = 'Input';

      Input.__path__ = 'File.Input';

      JSON_CTOR_ID = Input.JSON_CTOR_ID = File.JSON_CTORS.push(Input) - 1;

      i = 1;

      JSON_NODE = Input.JSON_NODE = i++;

      JSON_TEXT = Input.JSON_TEXT = i++;

      JSON_FUNC_BODY = Input.JSON_FUNC_BODY = i++;

      JSON_ARGS_LENGTH = Input.JSON_ARGS_LENGTH = i;

      Input._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new Input(file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY]);
        }
        return obj;
      };

      RE = Input.RE = new RegExp('([^$]*)\\${([^}]*)}([^$]*)', 'gm');

      VAR_RE = Input.VAR_RE = /(^|\s|\[|:|\()([a-zA-Z_$][\w:_]*)+(?!:)/g;

      PROP_RE = Input.PROP_RE = /(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+/;

      PROPS_RE = Input.PROPS_RE = /[a-zA-Z_$][a-zA-Z0-9_$]*(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+\s*/g;

      CONSTANT_VARS = Input.CONSTANT_VARS = ['undefined', 'false', 'true', 'null', 'this', 'JSON'];

      cache = Object.create(null);

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
            obj = ((_ref1 = obj.parentUse) != null ? _ref1.file : void 0) || obj.file || ((_ref2 = obj.source) != null ? _ref2.file : void 0);
          }
        };
        getFunction = function(obj, prop) {
          var elem, _ref, _ref1, _ref2;
          while (obj) {
            if (elem = (_ref = obj.funcs) != null ? _ref[prop] : void 0) {
              return elem;
            }
            obj = ((_ref1 = obj.parentUse) != null ? _ref1.file : void 0) || obj.file || ((_ref2 = obj.source) != null ? _ref2.file : void 0);
          }
        };
        return function(file, prop) {
          var destFile, source, v;
          if (file.source instanceof File.Iterator) {
            destFile = file.source.file;
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
          return Input.getVal(input.file, prop);
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
          arr[4] = (_ref2 = file.source) != null ? (_ref3 = _ref2.file) != null ? _ref3.node : void 0 : void 0;
          arr[5] = (_ref4 = file.source) != null ? (_ref5 = _ref4.file) != null ? (_ref6 = _ref5.source) != null ? _ref6.node : void 0 : void 0 : void 0;
          return arr;
        };
      })([]);

      Input.test = function(str) {
        RE.lastIndex = 0;
        return RE.test(str);
      };

      Input.parse = function(text) {
        var charStr, chunks, err, func, innerBlocks, isBlock, isString, match, n, prop, str;
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

      function Input(file, node, text, funcBody) {
        var _name;
        this.file = file;
        this.node = node;
        this.text = text;
        this.funcBody = funcBody;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        assert.isString(text);
        assert.isString(funcBody);
        this.traces = [];
        this.updatePending = false;
        this.traceChanges = true;
        this.func = cache[_name = this.funcBody] != null ? cache[_name] : cache[_name] = Input.createFunction(this.funcBody);
        //<development>;
        if (this.constructor === Input) {
          Object.preventExtensions(this);
        }
        //</development>;
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
        var obj, signal, traces, _i, _len;
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
        _ref = Input.getStoragesArray(this.file);
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
        _ref = Input.getStoragesArray(this.file);
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

      Input.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new Input(file, node, this.text, this.funcBody);
      };

      Input.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        arr[JSON_TEXT] = this.text;
        arr[JSON_FUNC_BODY] = this.funcBody;
        return arr;
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
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_FUNC_BODY, JSON_NODE, JSON_TEXT;

      __extends(InputText, _super);

      InputText.__name__ = 'InputText';

      InputText.__path__ = 'File.Input.Text';

      JSON_CTOR_ID = InputText.JSON_CTOR_ID = File.JSON_CTORS.push(InputText) - 1;

      JSON_NODE = Input.JSON_NODE, JSON_TEXT = Input.JSON_TEXT, JSON_FUNC_BODY = Input.JSON_FUNC_BODY;

      JSON_ARGS_LENGTH = Input.JSON_ARGS_LENGTH;

      InputText._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new InputText(file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY]);
        }
        return obj;
      };

      function InputText(file, node, text, funcBody) {
        Input.call(this, file, node, text, funcBody);
        this.lastValue = NaN;
        //<development>;
        if (this.constructor === InputText) {
          Object.preventExtensions(this);
        }
        //</development>;
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

      InputText.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new InputText(file, node, this.text, this.funcBody);
      };

      InputText.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        InputText.__super__.toJSON.call(this, key, arr);
        return arr;
      };

      return InputText;

    })(Input);
  };

}).call(this);


return module.exports;
})();modules['../document/input/attr.coffee'] = (function(){
var module = {exports: modules["../document/input/attr.coffee"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(File, Input) {
    var InputAttr;
    return InputAttr = (function(_super) {
      var JSON_ARGS_LENGTH, JSON_ATTR_NAME, JSON_CTOR_ID, JSON_FUNC_BODY, JSON_NODE, JSON_TEXT, createHandlerFunc, i, isHandler;

      __extends(InputAttr, _super);

      InputAttr.__name__ = 'InputAttr';

      InputAttr.__path__ = 'File.Input.Attr';

      JSON_CTOR_ID = InputAttr.JSON_CTOR_ID = File.JSON_CTORS.push(InputAttr) - 1;

      i = Input.JSON_ARGS_LENGTH;

      JSON_NODE = Input.JSON_NODE, JSON_TEXT = Input.JSON_TEXT, JSON_FUNC_BODY = Input.JSON_FUNC_BODY;

      JSON_ATTR_NAME = i++;

      JSON_ARGS_LENGTH = InputAttr.JSON_ARGS_LENGTH = i;

      InputAttr._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new InputAttr(file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY], arr[JSON_ATTR_NAME]);
        }
        return obj;
      };

      isHandler = function(name) {
        return /^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test(name);
      };

      function InputAttr(file, node, text, funcBody, attrName) {
        this.attrName = attrName;
        assert.isString(attrName);
        assert.notLengthOf(attrName, 0);
        Input.call(this, file, node, text, funcBody);
        this.lastValue = NaN;
        if (isHandler(attrName)) {
          this.traceChanges = false;
          this.handlerFunc = createHandlerFunc(this);
        } else {
          this.handlerFunc = null;
        }
        //<development>;
        if (this.constructor === InputAttr) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      InputAttr.prototype.update = function() {
        var str;
        InputAttr.__super__.update.call(this);
        str = this.handlerFunc || this.toString();
        if (str !== this.lastValue) {
          this.lastValue = str;
          this.node.setAttr(this.attrName, str);
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

      InputAttr.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new InputAttr(file, node, this.text, this.funcBody, this.attrName);
      };

      InputAttr.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        InputAttr.__super__.toJSON.call(this, key, arr);
        arr[JSON_ATTR_NAME] = this.attrName;
        return arr;
      };

      return InputAttr;

    })(Input);
  };

}).call(this);


return module.exports;
})();modules['../document/condition.coffee'] = (function(){
var module = {exports: modules["../document/condition.coffee"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert;

  assert = require('assert');

  module.exports = function(File) {
    var Condition;
    return Condition = (function() {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_ELSE_NODE, JSON_NODE, i, onAttrsChange;

      Condition.__name__ = 'Condition';

      Condition.__path__ = 'File.Condition';

      JSON_CTOR_ID = Condition.JSON_CTOR_ID = File.JSON_CTORS.push(Condition) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_ELSE_NODE = i++;

      JSON_ARGS_LENGTH = Condition.JSON_ARGS_LENGTH = i;

      Condition._fromJSON = function(file, arr, obj) {
        var elseNode, node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          if (arr[JSON_ELSE_NODE]) {
            elseNode = file.node.getChildByAccessPath(arr[JSON_ELSE_NODE]);
          }
          obj = new Condition(file, node, elseNode);
        }
        return obj;
      };

      onAttrsChange = function(name) {
        if (name === 'neft:if') {
          this.update();
        }
      };

      function Condition(file, node, elseNode) {
        this.file = file;
        this.node = node;
        this.elseNode = elseNode != null ? elseNode : null;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        if (elseNode != null) {
          assert.instanceOf(elseNode, File.Element);
        }
        node.onAttrsChange(onAttrsChange, this);
        //<development>;
        if (this.constructor === Condition) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      Condition.prototype.update = function() {
        var visible, _ref;
        visible = this.node.visible = !!this.node.getAttr('neft:if');
        if ((_ref = this.elseNode) != null) {
          _ref.visible = !visible;
        }
      };

      Condition.prototype.render = function() {
        return this.update();
      };

      Condition.prototype.clone = function(original, file) {
        var elseNode, node;
        node = original.node.getCopiedElement(this.node, file.node);
        if (this.elseNode) {
          elseNode = original.node.getCopiedElement(this.elseNode, file.node);
        }
        return new Condition(file, node, elseNode);
      };

      Condition.prototype.toJSON = function(key, arr) {
        var _ref;
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        arr[JSON_ELSE_NODE] = (_ref = this.elseNode) != null ? _ref.getAccessPath(this.file.node) : void 0;
        return arr;
      };

      return Condition;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/iterator.coffee'] = (function(){
var module = {exports: modules["../document/iterator.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","list":"../list/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, isArray, log, utils;

  utils = require('utils');

  assert = require('assert');

  List = require('list');

  log = require('log');

  isArray = Array.isArray;

  assert = assert.scope('View.Iterator');

  log = log.scope('View', 'Iterator');

  module.exports = function(File) {
    var Iterator;
    return Iterator = (function() {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_NAME, JSON_NODE, JSON_TEXT, attrsChangeListener, i, visibilityChangeListener;

      Iterator.__name__ = 'Iterator';

      Iterator.__path__ = 'File.Iterator';

      Iterator.HTML_ATTR = "" + File.HTML_NS + ":each";

      JSON_CTOR_ID = Iterator.JSON_CTOR_ID = File.JSON_CTORS.push(Iterator) - 1;

      i = 1;

      JSON_NAME = i++;

      JSON_NODE = i++;

      JSON_TEXT = i++;

      JSON_ARGS_LENGTH = Iterator.JSON_ARGS_LENGTH = i;

      Iterator._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new Iterator(file, node, arr[JSON_NAME]);
        }
        obj.text = arr[JSON_TEXT];
        return obj;
      };

      attrsChangeListener = function(name) {
        if (this.file.isRendered && name === 'neft:each') {
          return this.update();
        }
      };

      visibilityChangeListener = function(oldVal) {
        if (this.file.isRendered && oldVal === false && !this.node.data) {
          return this.update();
        }
      };

      function Iterator(file, node, name) {
        this.file = file;
        this.node = node;
        this.name = name;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        assert.isString(name);
        assert.notLengthOf(name, 0);
        this.usedFragments = [];
        this.text = '';
        this.data = null;
        this.isRendered = false;
        node.onAttrsChange(attrsChangeListener, this);
        node.onVisibleChange(visibilityChangeListener, this);
        //<development>;
        if (this.constructor === Iterator) {
          Object.preventExtensions(this);
        }
        //</development>;
      }

      Iterator.prototype.render = function() {
        var array, each, _, _i, _len;
        if (!this.node.visible) {
          return;
        }
        each = this.node.getAttr(Iterator.HTML_ATTR);
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
        this.isRendered = true;
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
        this.data = null;
        return this.isRendered = false;
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
        usedFragment = File.factory(this.name);
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
        storage = Object.create(this.file.storage || null);
        storage.each = each;
        storage.i = i;
        storage.item = item;
        usedFragment.render(storage, this);
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

      Iterator.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new Iterator(file, node, this.name);
      };

      Iterator.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NAME] = this.name;
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        arr[JSON_TEXT] = this.text;
        return arr;
      };

      return Iterator;

    })();
  };

}).call(this);


return module.exports;
})();modules['../document/log.coffee'] = (function(){
var module = {exports: modules["../document/log.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

  module.exports = function(File) {
    var Log;
    return Log = (function() {
      var JSON_ARGS_LENGTH, JSON_CTOR_ID, JSON_NODE, i, listenOnTextChange;

      Log.__name__ = 'Log';

      Log.__path__ = 'File.Log';

      JSON_CTOR_ID = Log.JSON_CTOR_ID = File.JSON_CTORS.push(Log) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_ARGS_LENGTH = Log.JSON_ARGS_LENGTH = i;

      Log._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new Log(file, node);
        }
        return obj;
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

      function Log(file, node) {
        this.file = file;
        this.node = node;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        node.onAttrsChange(this.log, this);
        listenOnTextChange(node, this);
        //<development>;
        if (this.constructor === Log) {
          Object.preventExtensions(this);
        }
        //</development>;
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
            log.push(key, '=', val);
          }
          console.log.apply(console, log);
        }
      };

      Log.prototype.log = function() {
        if (this.file.isRendered) {
          return this.render();
        }
      };

      Log.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new Log(file, node);
      };

      Log.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        return arr;
      };

      return Log;

    })();
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl.coffee'] = (function(){
var module = {exports: modules["../renderer/impl.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","./impl/base":"../renderer/impl/base/index.coffee","./impl/native":"../renderer/impl/native/index.coffee"});
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
      if (utils.isQt) {
        if (r == null) {
          r = require('./impl/qt')(impl);
        }
      }
      if (utils.isAndroid || utils.isIOS) {
        if (r == null) {
          r = require('./impl/native')(impl);
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
      var obj, _ref1;
      obj = object;
      while (type && (impl.Types[type] == null)) {
        obj = Object.getPrototypeOf(obj);
        type = obj.constructor.__name__;
      }
      object._impl = ((_ref1 = impl.Types[type]) != null ? typeof _ref1.createData === "function" ? _ref1.createData() : void 0 : void 0) || {
        bindings: null
      };
      return Object.preventExtensions(object._impl);
    };
    impl.initializeObject = function(object, type) {
      var _ref1, _ref2;
      return (_ref1 = impl.Types[type]) != null ? (_ref2 = _ref1.create) != null ? _ref2.call(object, object._impl) : void 0 : void 0;
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","./item/pointer":"../renderer/impl/base/level0/item/pointer.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
    var DATA, NOP, pointer;
    pointer = impl.pointer = require('./item/pointer')(impl);
    NOP = function() {};
    DATA = {
      bindings: null,
      anchors: null,
      capturePointer: 0,
      childrenCapturesPointer: 0
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function(data) {},
      setItemParent: function(val) {
        return pointer.setItemParent.call(this, val);
      },
      insertItemBefore: function(val) {
        var child, children, i, item, parent, tmp, valIndex, _i, _j, _len, _ref;
        impl.setItemParent.call(this, null);
        this._parent = null;
        parent = val.parent;
        children = parent.children;
        tmp = [];
        valIndex = val.index;
        for (i = _i = valIndex, _ref = children.length; _i < _ref; i = _i += 1) {
          child = children[i];
          if (child !== this) {
            impl.setItemParent.call(child, null);
            child._parent = null;
            tmp.push(child);
          }
        }
        impl.setItemParent.call(this, parent);
        this._parent = parent;
        for (_j = 0, _len = tmp.length; _j < _len; _j++) {
          item = tmp[_j];
          impl.setItemParent.call(item, parent);
          item._parent = parent;
        }
      },
      setItemBackground: function(val) {},
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
      attachItemSignal: function(name, signal) {
        if (name === 'pointer') {
          return pointer.attachItemSignal.call(this, signal);
        }
      },
      setItemPointerEnabled: function(val) {
        return pointer.setItemPointerEnabled.call(this, val);
      },
      setItemPointerDraggable: function(val) {
        return pointer.setItemPointerDraggable.call(this, val);
      },
      setItemPointerDragActive: function(val) {
        return pointer.setItemPointerDragActive.call(this, val);
      },
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
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        return impl.Types.Item.create.call(this, data);
      },
      setText: function(val) {},
      setTextWrap: function(val) {},
      updateTextContentSize: function() {},
      setTextColor: function(val) {},
      setTextLinkColor: function(val) {},
      setTextLineHeight: function(val) {},
      setTextFontFamily: function(val) {},
      setTextFontPixelSize: function(val) {},
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
      setTextInputFontWordSpacing: function(val) {},
      setTextInputFontLetterSpacing: function(val) {},
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
      loadFont: function(name, source, sources) {}
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
      initDeviceNamespace: function() {},
      showDeviceKeyboard: function() {},
      hideDeviceKeyboard: function() {}
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
    var DATA, NOP, getRectangleSource, items, round, updateImage, updateImageIfNeeded;
    items = impl.items;
    round = Math.round;
    NOP = function() {};
    getRectangleSource = function(item) {
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
    updateImage = function() {
      impl.setImageSource.call(this, getRectangleSource(this), NOP);
    };
    updateImageIfNeeded = function() {
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
      create: function(data) {
        impl.Types.Image.create.call(this, data);
        this.onWidthChange(updateImageIfNeeded);
        return this.onHeightChange(updateImageIfNeeded);
      },
      setRectangleColor: function(val) {
        this._impl.color = val;
        return updateImage.call(this);
      },
      setRectangleRadius: updateImage,
      setRectangleBorderColor: function(val) {
        this._impl.borderColor = val;
        return updateImage.call(this);
      },
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","typed-array":"../typed-array/index.coffee.md"});
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
    var alignH, alignV, anchors, autoHeight, autoWidth, bottom, bottomMargin, bottomPadding, cell, child, childLayoutMargin, children, collapseMargins, columnSpacing, currentRow, currentRowBottomMargin, currentRowY, currentYShift, data, effectItem, flowHeight, flowWidth, freeHeightSpace, height, i, includeBorderMargins, lastColumnRightMargin, lastRowBottomMargin, layout, leftMargin, leftPadding, length, margin, maxFlowWidth, maxLen, multiplierX, multiplierY, padding, perCell, plusY, right, rightMargin, rightPadding, row, rowSpacing, rowsFillsSum, topMargin, topPadding, update, visibleChildrenIndex, width, x, y, yShift, _i, _j, _k, _l, _len, _len1, _len2, _ref, _ref1, _ref2;
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
    var DATA, DELTA_VALIDATION_PENDING, Types, createContinuous, getDeltaX, getDeltaY, getItemGlobalScale, getLimitedX, getLimitedY, lastActionTimestamp, onHeightChange, onImplReady, onWidthChange, pointerUsed, pointerWindowMoveListeners, scroll, usePointer, useWheel, wheelUsed;
    Types = impl.Types;
    if (impl._scrollableUsePointer == null) {
      impl._scrollableUsePointer = true;
    }
    if (impl._scrollableUseWheel == null) {
      impl._scrollableUseWheel = true;
    }

    /*
    	Scroll container by given x and y deltas
     */
    scroll = (function() {
      return function(item, x, y) {
        var deltaX, deltaY;
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
        x = getLimitedX(item, x);
        y = getLimitedY(item, y);
        if (item._contentX !== x || item._contentY !== y) {
          item.contentX = x;
          item.contentY = y;
          return true;
        }
        return false;
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
        if (!scroll(item, e.movementX + dx, e.movementY + dy)) {
          return e.stopPropagation = false;
        }
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
          if (!scroll(item, x, y)) {
            e.stopPropagation = false;
          }
          return;
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
        if (scroll(item, x, y)) {
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
        if (!used) {
          return e.stopPropagation = false;
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
      _getLimitedX: getLimitedX,
      _getLimitedY: getLimitedY,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        impl.Types.Item.create.call(this, data);
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
          if (this.children.length > 0) {
            impl.insertItemBefore.call(val, this.children[0]);
          } else {
            impl.setItemParent.call(val, this);
          }
          this._impl.contentItem = val;
          val.onWidthChange(onWidthChange, this);
          val.onHeightChange(onHeightChange, this);
        }
      },
      setScrollableContentX: function(val) {
        var item;
        if (item = this._impl.contentItem) {
          impl.setItemX.call(item, -val);
        }
      },
      setScrollableContentY: function(val) {
        var item;
        if (item = this._impl.contentItem) {
          impl.setItemY.call(item, -val);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
        if (isArray(item)) {
          this.itemId = '';
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

      Connection.prototype.getValue = function() {
        if (this.item) {
          return this.item[this.prop];
        } else {
          return null;
        }
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
          return binding.component.objects[item] || impl.Renderer[item] || null;
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, isArray, log;

  assert = require('assert');

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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","typed-array":"../typed-array/index.coffee.md"});
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
})();modules['../renderer/impl/native/index.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/index.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./ios":"../renderer/impl/native/ios.coffee","./level0/item":"../renderer/impl/native/level0/item.coffee","./level0/image":"../renderer/impl/native/level0/image.coffee","./level0/text":"../renderer/impl/native/level0/text.coffee","./level0/textInput":"../renderer/impl/native/level0/textInput.coffee","./level0/loader/font":"../renderer/impl/native/level0/loader/font.coffee","./level0/loader/resources":"../renderer/impl/native/level0/loader/resources.coffee","./level0/device":"../renderer/impl/native/level0/device.coffee","./level0/screen":"../renderer/impl/native/level0/screen.coffee","./level0/navigator":"../renderer/impl/native/level0/navigator.coffee","./level0/sensor/rotation":"../renderer/impl/native/level0/sensor/rotation.coffee","./level0/sound/ambient":"../renderer/impl/native/level0/sound/ambient.coffee","./level1/rectangle":"../renderer/impl/native/level1/rectangle.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

  module.exports = function(impl) {
    var bridge, exports, platform;
    platform = (function() {
      switch (true) {
        case utils.isAndroid:
          return require('./android')(impl);
        case utils.isIOS:
          return require('./ios')(impl);
      }
    })();
    exports = {
      Types: utils.merge({
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
        Rectangle: require('./level1/rectangle')
      }, platform.Types),
      bridge: bridge = platform.bridge,
      setWindow: function(item) {
        bridge.pushAction(bridge.outActions.SET_WINDOW);
        bridge.pushItem(item);
      }
    };
    return exports;
  };

}).call(this);


return module.exports;
})();modules['../native/actions.coffee'] = (function(){
var module = {exports: modules["../native/actions.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  exports["in"] = (function(i) {
    return {
      EVENT: i++,
      SCREEN_SIZE: i++,
      SCREEN_ORIENTATION: i++,
      NAVIGATOR_LANGUAGE: i++,
      NAVIGATOR_ONLINE: i++,
      DEVICE_PIXEL_RATIO: i++,
      DEVICE_IS_PHONE: i++,
      POINTER_PRESS: i++,
      POINTER_RELEASE: i++,
      POINTER_MOVE: i++,
      DEVICE_KEYBOARD_SHOW: i++,
      DEVICE_KEYBOARD_HIDE: i++,
      KEY_PRESS: i++,
      KEY_HOLD: i++,
      KEY_INPUT: i++,
      KEY_RELEASE: i++,
      IMAGE_SIZE: i++,
      TEXT_SIZE: i++,
      FONT_LOAD: i++,
      SCROLLABLE_CONTENT_X: i++,
      SCROLLABLE_CONTENT_Y: i++,
      TEXT_INPUT_TEXT: i++
    };
  })(0);

  exports.out = (function(i) {
    return {
      CALL_FUNCTION: i++,
      DEVICE_SHOW_KEYBOARD: i++,
      DEVICE_HIDE_KEYBOARD: i++,
      SET_WINDOW: i++,
      CREATE_ITEM: i++,
      SET_ITEM_PARENT: i++,
      INSERT_ITEM_BEFORE: i++,
      SET_ITEM_VISIBLE: i++,
      SET_ITEM_CLIP: i++,
      SET_ITEM_WIDTH: i++,
      SET_ITEM_HEIGHT: i++,
      SET_ITEM_X: i++,
      SET_ITEM_Y: i++,
      SET_ITEM_Z: i++,
      SET_ITEM_SCALE: i++,
      SET_ITEM_ROTATION: i++,
      SET_ITEM_OPACITY: i++,
      SET_ITEM_BACKGROUND: i++,
      SET_ITEM_KEYS_FOCUS: i++,
      CREATE_IMAGE: i++,
      SET_IMAGE_SOURCE: i++,
      SET_IMAGE_SOURCE_WIDTH: i++,
      SET_IMAGE_SOURCE_HEIGHT: i++,
      SET_IMAGE_FILL_MODE: i++,
      SET_IMAGE_OFFSET_X: i++,
      SET_IMAGE_OFFSET_Y: i++,
      CREATE_TEXT: i++,
      SET_TEXT: i++,
      SET_TEXT_WRAP: i++,
      UPDATE_TEXT_CONTENT_SIZE: i++,
      SET_TEXT_COLOR: i++,
      SET_TEXT_LINE_HEIGHT: i++,
      SET_TEXT_FONT_FAMILY: i++,
      SET_TEXT_FONT_PIXEL_SIZE: i++,
      SET_TEXT_FONT_WORD_SPACING: i++,
      SET_TEXT_FONT_LETTER_SPACING: i++,
      SET_TEXT_ALIGNMENT_HORIZONTAL: i++,
      SET_TEXT_ALIGNMENT_VERTICAL: i++,
      CREATE_TEXT_INPUT: i++,
      SET_TEXT_INPUT_TEXT: i++,
      SET_TEXT_INPUT_COLOR: i++,
      SET_TEXT_INPUT_LINE_HEIGHT: i++,
      SET_TEXT_INPUT_MULTI_LINE: i++,
      SET_TEXT_INPUT_ECHO_MODE: i++,
      SET_TEXT_INPUT_FONT_FAMILY: i++,
      SET_TEXT_FONT_INPUT_PIXEL_SIZE: i++,
      SET_TEXT_FONT_INPUT_WORD_SPACING: i++,
      SET_TEXT_FONT_INPUT_LETTER_SPACING: i++,
      SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL: i++,
      SET_TEXT_INPUT_ALIGNMENT_VERTICAL: i++,
      LOAD_FONT: i++,
      CREATE_RECTANGLE: i++,
      SET_RECTANGLE_COLOR: i++,
      SET_RECTANGLE_RADIUS: i++,
      SET_RECTANGLE_BORDER_COLOR: i++,
      SET_RECTANGLE_BORDER_WIDTH: i++,
      CREATE_SCROLLABLE: i++,
      SET_SCROLLABLE_CONTENT_ITEM: i++,
      SET_SCROLLABLE_CONTENT_X: i++,
      SET_SCROLLABLE_CONTENT_Y: i++,
      ACTIVATE_SCROLLABLE: i++
    };
  })(0);

}).call(this);


return module.exports;
})();modules['../native/impl/ios/bridge.coffee'] = (function(){
var module = {exports: modules["../native/impl/ios/bridge.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(bridge) {
    var actions, booleans, floats, integers, outDataObject, strings;
    actions = [];
    booleans = [];
    integers = [];
    floats = [];
    strings = [];
    outDataObject = {
      actions: actions,
      booleans: booleans,
      integers: integers,
      floats: floats,
      strings: strings
    };
    _neft["native"] = {
      onData: bridge.onData
    };
    return {
      sendData: function() {
        if (actions.length <= 0) {
          return;
        }
        webkit.messageHandlers.transferData.postMessage(outDataObject);
        utils.clear(actions);
        utils.clear(booleans);
        utils.clear(integers);
        utils.clear(floats);
        utils.clear(strings);
      },
      pushAction: function(val) {
        actions.push(val);
      },
      pushBoolean: function(val) {
        booleans.push(val);
      },
      pushInteger: function(val) {
        integers.push(val);
      },
      pushFloat: function(val) {
        floats.push(val);
      },
      pushString: function(val) {
        strings.push(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../native/bridge.coffee'] = (function(){
var module = {exports: modules["../native/bridge.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./impl/ios/bridge":"../native/impl/ios/bridge.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, impl, listeners, log, reader, utils;

  utils = require('utils');

  log = require('log');

  assert = require('assert');

  listeners = Object.create(null);

  reader = {
    booleans: null,
    booleansIndex: 0,
    integers: null,
    integersIndex: 0,
    floats: null,
    floatsIndex: 0,
    strings: null,
    stringsIndex: 0,
    getBoolean: function() {
      return this.booleans[this.booleansIndex++];
    },
    getInteger: function() {
      return this.integers[this.integersIndex++];
    },
    getFloat: function() {
      return this.floats[this.floatsIndex++];
    },
    getString: function() {
      return this.strings[this.stringsIndex++];
    }
  };

  Object.preventExtensions(reader);

  exports.onData = function(actions, booleans, integers, floats, strings) {
    var action, func, _i, _len;
    reader.booleans = booleans;
    reader.booleansIndex = 0;
    reader.integers = integers;
    reader.integersIndex = 0;
    reader.floats = floats;
    reader.floatsIndex = 0;
    reader.strings = strings;
    reader.stringsIndex = 0;
    for (_i = 0, _len = actions.length; _i < _len; _i++) {
      action = actions[_i];
      func = listeners[action];
      assert.isFunction(func, "unknown native action got '" + action + "'");
      func(reader);
    }
    exports.sendData();
  };

  exports.addActionListener = function(action, listener) {
    assert.isInteger(action);
    assert.isFunction(listener);
    assert.isNotDefined(listeners[action], "action '" + action + "' already has a listener");
    listeners[action] = listener;
  };

  exports.sendData = function() {};

  exports.pushAction = function(val) {};

  exports.pushBoolean = function(val) {};

  exports.pushInteger = function(val) {};

  exports.pushFloat = function(val) {};

  exports.pushString = function(val) {};

  impl = (function() {
    switch (true) {
      case utils.isAndroid:
        return require('./impl/android/bridge');
      case utils.isIOS:
        return require('./impl/ios/bridge');
    }
  })();

  if (impl != null) {
    utils.merge(exports, impl(exports));
  }

  //<development>;

  exports.pushAction = (function(_super) {
    return function(val) {
      assert.isInteger(val, "integer expected, but '" + val + "' given");
      _super(val);
    };
  })(exports.pushAction);

  exports.pushBoolean = (function(_super) {
    return function(val) {
      assert.isBoolean(val, "boolean expected, but '" + val + "' given");
      _super(val);
    };
  })(exports.pushBoolean);

  exports.pushInteger = (function(_super) {
    return function(val) {
      assert.isInteger(val, "integer expected, but '" + val + "' given");
      _super(val);
    };
  })(exports.pushInteger);

  exports.pushFloat = (function(_super) {
    return function(val) {
      assert.isFloat(val, "float expected, but '" + val + "' given");
      _super(val);
    };
  })(exports.pushFloat);

  exports.pushString = (function(_super) {
    return function(val) {
      assert.isString(val, "string expected, but '" + val + "' given");
      _super(val);
    };
  })(exports.pushString);

  //</development>;

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/ios.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/ios.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","native/actions":"../native/actions.coffee","native/bridge":"../native/bridge.coffee","./level2/scrollable":"../renderer/impl/native/level2/scrollable.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, nativeActions, nativeBridge, utils;

  utils = require('utils');

  assert = require('assert');

  nativeActions = require('native/actions');

  nativeBridge = require('native/bridge');

  _neft.renderer = {};

  module.exports = function(impl) {
    return {
      Types: {
        Scrollable: require('./level2/scrollable')
      },
      bridge: (function() {
        var itemsById, lastId, vsync;
        itemsById = new Array(20000);
        lastId = 0;
        vsync = function() {
          requestAnimationFrame(vsync);
          nativeBridge.sendData();
        };
        requestAnimationFrame(vsync);
        return {
          inActions: nativeActions["in"],
          outActions: nativeActions.out,
          listen: nativeBridge.addActionListener,
          getId: function(item) {
            assert.instanceOf(item, impl.Renderer.Item);
            itemsById[lastId] = item;
            return lastId++;
          },
          getItemFromReader: function(reader) {
            return itemsById[reader.integers[reader.integersIndex++]];
          },
          pushAction: nativeBridge.pushAction,
          pushItem: function(val) {
            if (val !== null) {
              assert.instanceOf(val, impl.Renderer.Item);
            }
            nativeBridge.pushInteger(val !== null ? val._impl.id : -1);
          },
          pushBoolean: nativeBridge.pushBoolean,
          pushInteger: nativeBridge.pushInteger,
          pushFloat: nativeBridge.pushFloat,
          pushString: nativeBridge.pushString
        };
      })()
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level2/scrollable.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level2/scrollable.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var signal, utils;

  utils = require('utils');

  signal = require('signal');

  module.exports = function(impl) {
    var DATA, bridge, onPointerPress, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    bridge.listen(bridge.inActions.SCROLLABLE_CONTENT_X, function(reader) {
      var item;
      item = bridge.getItemFromReader(reader);
      item.contentX = reader.getFloat();
    });
    bridge.listen(bridge.inActions.SCROLLABLE_CONTENT_Y, function(reader) {
      var item;
      item = bridge.getItemFromReader(reader);
      item.contentY = reader.getFloat();
    });
    onPointerPress = function() {
      pushAction(outActions.ACTIVATE_SCROLLABLE);
      pushItem(this);
    };
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_SCROLLABLE);
          data.id = bridge.getId(this);
        }
        impl.Types.Item.create.call(this, data);
        this.pointer.onPress(onPointerPress, this);
      },
      setScrollableContentItem: function(val) {
        pushAction(outActions.SET_SCROLLABLE_CONTENT_ITEM);
        pushItem(this);
        pushItem(val);
      },
      setScrollableContentX: function(val) {
        pushAction(outActions.SET_SCROLLABLE_CONTENT_X);
        pushItem(this);
        pushFloat(val);
      },
      setScrollableContentY: function(val) {
        pushAction(outActions.SET_SCROLLABLE_CONTENT_Y);
        pushItem(this);
        pushFloat(val);
      },
      setScrollableSnap: function(val) {},
      setScrollableSnapItem: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/item.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/item.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

  module.exports = function(impl) {
    var DATA, NOP, bridge, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    NOP = function() {};
    DATA = utils.merge({
      id: 0,
      bindings: null,
      anchors: null
    }, impl.pointer.DATA);
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner(DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_ITEM);
          data.id = bridge.getId(this);
        }
      },
      setItemParent: function(val) {
        pushAction(outActions.SET_ITEM_PARENT);
        pushItem(this);
        pushItem(val);
        impl.pointer.setItemParent.call(this, val);
      },
      insertItemBefore: function(val) {
        pushAction(outActions.INSERT_ITEM_BEFORE);
        pushItem(this);
        pushItem(val);
        if (val && val._parent !== this._parent) {
          impl.pointer.setItemParent.call(this, val._parent);
        }
      },
      setItemBackground: function(val) {
        pushAction(outActions.SET_ITEM_BACKGROUND);
        pushItem(this);
        pushItem(val);
      },
      setItemVisible: function(val) {
        pushAction(outActions.SET_ITEM_VISIBLE);
        pushItem(this);
        pushBoolean(val);
      },
      setItemClip: function(val) {
        pushAction(outActions.SET_ITEM_CLIP);
        pushItem(this);
        pushBoolean(val);
      },
      setItemWidth: function(val) {
        pushAction(outActions.SET_ITEM_WIDTH);
        pushItem(this);
        pushFloat(val);
      },
      setItemHeight: function(val) {
        pushAction(outActions.SET_ITEM_HEIGHT);
        pushItem(this);
        pushFloat(val);
      },
      setItemX: function(val) {
        pushAction(outActions.SET_ITEM_X);
        pushItem(this);
        pushFloat(val);
      },
      setItemY: function(val) {
        pushAction(outActions.SET_ITEM_Y);
        pushItem(this);
        pushFloat(val);
      },
      setItemZ: function(val) {
        pushAction(outActions.SET_ITEM_Z);
        pushItem(this);
        pushInteger(val);
      },
      setItemScale: function(val) {
        pushAction(outActions.SET_ITEM_SCALE);
        pushItem(this);
        pushFloat(val);
      },
      setItemRotation: function(val) {
        pushAction(outActions.SET_ITEM_ROTATION);
        pushItem(this);
        pushFloat(val);
      },
      setItemOpacity: function(val) {
        pushAction(outActions.SET_ITEM_OPACITY);
        pushItem(this);
        pushInteger(val * 255 | 0);
      },
      setItemKeysFocus: function(val) {
        pushAction(outActions.SET_ITEM_KEYS_FOCUS);
        pushItem(this);
        pushBoolean(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/image.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/image.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
    var DATA, bridge, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    DATA = {
      imageLoadCallback: null
    };
    bridge.listen(bridge.inActions.IMAGE_SIZE, function(reader) {
      var height, image, source, success, width, _ref;
      image = bridge.getItemFromReader(reader);
      source = reader.getString();
      success = reader.getBoolean();
      width = reader.getFloat();
      height = reader.getFloat();
      if ((_ref = image._impl.imageLoadCallback) != null) {
        _ref.call(image, !success, {
          source: source,
          width: width,
          height: height
        });
      }
    });
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_IMAGE);
          data.id = bridge.getId(this);
        }
        impl.Types.Item.create.call(this, data);
      },
      setStaticImagePixelRatio: function(val) {},
      setImageSource: function(val, callback) {
        this._impl.imageLoadCallback = callback;
        pushAction(outActions.SET_IMAGE_SOURCE);
        pushItem(this);
        pushString(val || "");
      },
      setImageSourceWidth: function(val) {
        pushAction(outActions.SET_IMAGE_SOURCE_WIDTH);
        pushItem(this);
        pushFloat(val);
      },
      setImageSourceHeight: function(val) {
        pushAction(outActions.SET_IMAGE_SOURCE_HEIGHT);
        pushItem(this);
        pushFloat(val);
      },
      setImageFillMode: function(val) {
        pushAction(outActions.SET_IMAGE_FILL_MODE);
        pushItem(this);
        pushString(val);
      },
      setImageOffsetX: function(val) {
        pushAction(outActions.SET_IMAGE_OFFSET_X);
        pushItem(this);
        pushFloat(val);
      },
      setImageOffsetY: function(val) {
        pushAction(outActions.SET_IMAGE_OFFSET_Y);
        pushItem(this);
        pushFloat(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/text.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/text.coffee"]};
var require = getModule.bind(null, {"../../base/utils/color":"../renderer/impl/base/utils/color.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA, bridge, colorUtils, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString, updateTextContentSize;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    colorUtils = require('../../base/utils/color');
    bridge.listen(bridge.inActions.TEXT_SIZE, function(reader) {
      var height, text, width;
      text = bridge.getItemFromReader(reader);
      width = reader.getFloat();
      height = reader.getFloat();
      text.contentWidth = width;
      text.contentHeight = height;
    });
    updateTextContentSize = (function() {
      var pending, queue, update, updateAll;
      pending = false;
      queue = [];
      update = function(item) {
        pushAction(outActions.UPDATE_TEXT_CONTENT_SIZE);
        pushItem(item);
      };
      updateAll = function(item) {
        while (item = queue.pop()) {
          item._impl.sizeUpdatePending = false;
          update(item);
        }
        pending = false;
      };
      return function(item) {
        if (item._impl.sizeUpdatePending) {
          return;
        }
        item._impl.sizeUpdatePending = true;
        queue.push(item);
        if (!pending) {
          setImmediate(updateAll);
          pending = true;
        }
      };
    })();
    DATA = {
      sizeUpdatePending: false
    };
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_TEXT);
          data.id = bridge.getId(this);
        }
        return impl.Types.Item.create.call(this, data);
      },
      setText: function(val) {
        val = val.replace(/<[bB][rR]\s?\/?>/g, "\n");
        val = val.replace(/<([^>]+)>/g, "");
        pushAction(outActions.SET_TEXT);
        pushItem(this);
        pushString(val);
        updateTextContentSize(this);
      },
      setTextWrap: function(val) {
        pushAction(outActions.SET_TEXT_WRAP);
        pushItem(this);
        pushBoolean(val);
        updateTextContentSize(this);
      },
      updateTextContentSize: function() {
        updateTextContentSize(this);
      },
      setTextColor: function(val) {
        pushAction(outActions.SET_TEXT_COLOR);
        pushItem(this);
        pushInteger(colorUtils.toRGBAHex(val, 'black'));
      },
      setTextLinkColor: function(val) {},
      setTextLineHeight: function(val) {
        pushAction(outActions.SET_TEXT_LINE_HEIGHT);
        pushItem(this);
        pushFloat(val);
        updateTextContentSize(this);
      },
      setTextFontFamily: function(val) {
        pushAction(outActions.SET_TEXT_FONT_FAMILY);
        pushItem(this);
        pushString(val);
        updateTextContentSize(this);
      },
      setTextFontPixelSize: function(val) {
        pushAction(outActions.SET_TEXT_FONT_PIXEL_SIZE);
        pushItem(this);
        pushFloat(val);
        updateTextContentSize(this);
      },
      setTextFontWordSpacing: function(val) {
        pushAction(outActions.SET_TEXT_FONT_WORD_SPACING);
        pushItem(this);
        pushFloat(val);
        updateTextContentSize(this);
      },
      setTextFontLetterSpacing: function(val) {
        pushAction(outActions.SET_TEXT_FONT_LETTER_SPACING);
        pushItem(this);
        pushFloat(val);
        updateTextContentSize(this);
      },
      setTextAlignmentHorizontal: function(val) {
        pushAction(outActions.SET_TEXT_ALIGNMENT_HORIZONTAL);
        pushItem(this);
        pushString(val);
      },
      setTextAlignmentVertical: function(val) {
        pushAction(outActions.SET_TEXT_ALIGNMENT_VERTICAL);
        pushItem(this);
        pushString(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/textInput.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/textInput.coffee"]};
var require = getModule.bind(null, {"../../base/utils/color":"../renderer/impl/base/utils/color.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA, bridge, colorUtils, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    colorUtils = require('../../base/utils/color');
    bridge.listen(bridge.inActions.TEXT_INPUT_TEXT, function(reader) {
      var oldValue, text, textInput;
      textInput = bridge.getItemFromReader(reader);
      text = reader.getString();
      oldValue = textInput.text;
      textInput._text = text;
      textInput.onTextChange.emit(oldValue);
    });
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_TEXT_INPUT);
          data.id = bridge.getId(this);
        }
        return impl.Types.Item.create.call(this, data);
      },
      setTextInputText: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_TEXT);
        pushItem(this);
        pushString(val);
      },
      setTextInputColor: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_COLOR);
        pushItem(this);
        pushInteger(colorUtils.toRGBAHex(val, 'black'));
      },
      setTextInputLineHeight: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_LINE_HEIGHT);
        pushItem(this);
        pushFloat(val);
      },
      setTextInputMultiLine: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_MULTI_LINE);
        pushItem(this);
        pushBoolean(val);
      },
      setTextInputEchoMode: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_ECHO_MODE);
        pushItem(this);
        pushString(val);
      },
      setTextInputFontFamily: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_FONT_FAMILY);
        pushItem(this);
        pushString(val);
      },
      setTextInputFontPixelSize: function(val) {
        pushAction(outActions.SET_TEXT_FONT_INPUT_PIXEL_SIZE);
        pushItem(this);
        pushFloat(val);
      },
      setTextInputFontWordSpacing: function(val) {
        pushAction(outActions.SET_TEXT_FONT_INPUT_WORD_SPACING);
        pushItem(this);
        pushFloat(val);
      },
      setTextInputFontLetterSpacing: function(val) {
        pushAction(outActions.SET_TEXT_FONT_INPUT_LETTER_SPACING);
        pushItem(this);
        pushFloat(val);
      },
      setTextInputAlignmentHorizontal: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL);
        pushItem(this);
        pushString(val);
      },
      setTextInputAlignmentVertical: function(val) {
        pushAction(outActions.SET_TEXT_INPUT_ALIGNMENT_VERTICAL);
        pushItem(this);
        pushString(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/loader/font.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/loader/font.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var bridge, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    bridge.listen(bridge.inActions.FONT_LOAD, function(reader) {
      var source, success;
      source = reader.getString();
      success = reader.getBoolean();
    });
    return {
      loadFont: function(name, source, sources) {
        pushAction(outActions.LOAD_FONT);
        pushString(name);
        pushString(source);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/loader/resources.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/loader/resources.coffee"]};
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
})();modules['../renderer/impl/native/level0/device.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/device.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var utils;

  utils = require('utils');

  module.exports = function(impl) {
    var bridge, device, keyboard, outActions, pointer, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    device = pointer = keyboard = null;
    bridge.listen(bridge.inActions.DEVICE_PIXEL_RATIO, function(reader) {
      device._pixelRatio = reader.getFloat();
    });
    bridge.listen(bridge.inActions.DEVICE_IS_PHONE, function(reader) {
      device._phone = reader.getBoolean();
    });

    /*
    	Pointer
     */
    bridge.listen(bridge.inActions.POINTER_PRESS, function(reader) {
      pointer.x = reader.getFloat();
      pointer.y = reader.getFloat();
      device.onPointerPress.emit(pointer);
    });
    bridge.listen(bridge.inActions.POINTER_RELEASE, function(reader) {
      pointer.x = reader.getFloat();
      pointer.y = reader.getFloat();
      device.onPointerRelease.emit(pointer);
    });
    bridge.listen(bridge.inActions.POINTER_MOVE, function(reader) {
      pointer.x = reader.getFloat();
      pointer.y = reader.getFloat();
      device.onPointerMove.emit(pointer);
    });

    /*
    	Keyboard
     */
    bridge.listen(bridge.inActions.DEVICE_KEYBOARD_SHOW, function(reader) {
      keyboard.visible = true;
    });
    bridge.listen(bridge.inActions.DEVICE_KEYBOARD_HIDE, function(reader) {
      keyboard.visible = false;
    });
    bridge.listen(bridge.inActions.KEY_PRESS, function(reader) {
      keyboard.key = reader.getString();
      device.onKeyPress.emit(keyboard);
    });
    bridge.listen(bridge.inActions.KEY_HOLD, function(reader) {
      keyboard.key = reader.getString();
      device.onKeyHold.emit(keyboard);
    });
    bridge.listen(bridge.inActions.KEY_INPUT, function(reader) {
      keyboard.text = reader.getString();
      device.onKeyInput.emit(keyboard);
    });
    bridge.listen(bridge.inActions.KEY_RELEASE, function(reader) {
      keyboard.key = reader.getString();
      device.onKeyRelease.emit(keyboard);
    });
    return {
      initDeviceNamespace: function() {
        device = this;
        pointer = this.pointer;
        keyboard = this.keyboard;
        this._desktop = false;
        this._platform = (function() {
          switch (true) {
            case utils.isAndroid:
              return 'Android';
            case utils.isIOS:
              return 'iOS';
          }
        })();
      },
      showDeviceKeyboard: function() {
        pushAction(outActions.DEVICE_SHOW_KEYBOARD);
      },
      hideDeviceKeyboard: function() {
        pushAction(outActions.DEVICE_HIDE_KEYBOARD);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/screen.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/screen.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var bridge, callback, screen;
    bridge = impl.bridge;
    callback = screen = null;
    bridge.listen(bridge.inActions.SCREEN_SIZE, function(reader) {
      screen._width = reader.getFloat();
      screen._height = reader.getFloat();
      callback();
    });
    return {
      initScreenNamespace: function(_callback) {
        callback = _callback;
        screen = this;
        return this._touch = true;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/navigator.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/navigator.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var bridge, navigator;
    bridge = impl.bridge;
    navigator = null;
    bridge.listen(bridge.inActions.NAVIGATOR_LANGUAGE, function(reader) {
      navigator._language = reader.getString();
    });
    bridge.listen(bridge.inActions.NAVIGATOR_ONLINE, function(reader) {
      navigator.online = reader.getBoolean();
    });
    return {
      initNavigatorNamespace: function() {
        return navigator = this;
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/native/level0/sensor/rotation.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/sensor/rotation.coffee"]};
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
})();modules['../renderer/impl/native/level0/sound/ambient.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level0/sound/ambient.coffee"]};
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
})();modules['../renderer/impl/native/level1/rectangle.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/native/level1/rectangle.coffee"]};
var require = getModule.bind(null, {"../../base/utils/color":"../renderer/impl/base/utils/color.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  module.exports = function(impl) {
    var DATA, bridge, colorUtils, outActions, pushAction, pushBoolean, pushFloat, pushInteger, pushItem, pushString;
    bridge = impl.bridge;
    outActions = bridge.outActions, pushAction = bridge.pushAction, pushItem = bridge.pushItem, pushBoolean = bridge.pushBoolean, pushInteger = bridge.pushInteger, pushFloat = bridge.pushFloat, pushString = bridge.pushString;
    colorUtils = require('../../base/utils/color');
    DATA = {};
    return {
      DATA: DATA,
      createData: impl.utils.createDataCloner('Item', DATA),
      create: function(data) {
        if (data.id === 0) {
          pushAction(outActions.CREATE_RECTANGLE);
          data.id = bridge.getId(this);
        }
        impl.Types.Item.create.call(this, data);
      },
      setRectangleColor: function(val) {
        pushAction(outActions.SET_RECTANGLE_COLOR);
        pushItem(this);
        pushInteger(colorUtils.toRGBAHex(val));
      },
      setRectangleRadius: function(val) {
        pushAction(outActions.SET_RECTANGLE_RADIUS);
        pushItem(this);
        pushFloat(val);
      },
      setRectangleBorderColor: function(val) {
        pushAction(outActions.SET_RECTANGLE_BORDER_COLOR);
        pushItem(this);
        pushInteger(colorUtils.toRGBAHex(val));
      },
      setRectangleBorderWidth: function(val) {
        pushAction(outActions.SET_RECTANGLE_BORDER_WIDTH);
        pushItem(this);
        pushFloat(val);
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/level0/item/pointer.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/level0/item/pointer.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var cos, emitSignal, isPointInBox, signal, sin, utils;

  utils = require('utils');

  signal = require('signal');

  sin = Math.sin, cos = Math.cos;

  emitSignal = signal.Emitter.emitSignal;

  isPointInBox = function(ex, ey, x, y, w, h) {
    return ex >= x && ey >= y && ex < x + w && ey < y + h;
  };

  module.exports = function(impl) {
    var CLICK, ENTER, EVENTS, EXIT, MOVE, PRESS, PROPAGATE_UP, RELEASE, STOP_ASIDE_PROPAGATION, STOP_PROPAGATION, Scrollable, WHEEL, captureItems, hoverItems, i, itemsToMove, itemsToRelease, pressedItems;
    PROPAGATE_UP = 1 << 0;
    STOP_ASIDE_PROPAGATION = 1 << 1;
    STOP_PROPAGATION = 1 << 2;
    Scrollable = null;
    impl.Renderer.onReady(function() {
      return Scrollable = this.Scrollable, this;
    });
    captureItems = (function() {
      var checkItem;
      checkItem = function(type, item, ex, ey, onItem, parentX, parentY, parentScale) {
        var child, data, h, pointer, rcos, result, rey, rotation, rsin, scale, t1, t2, w, x, y, _i, _ref;
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
          _ref = item._children;
          for (_i = _ref.length - 1; _i >= 0; _i += -1) {
            child = _ref[_i];
            result |= checkItem(type, child, ex, ey, onItem, x, y, scale);
            if (result & STOP_PROPAGATION) {
              return result;
            }
            if (result & STOP_ASIDE_PROPAGATION) {
              break;
            }
          }
          if (item instanceof Scrollable && item._contentItem && !(result & STOP_ASIDE_PROPAGATION)) {
            result |= checkItem(type, item._contentItem, ex, ey, onItem, x - item.contentX * parentScale, y - item.contentY * parentScale, scale);
            if (result & STOP_PROPAGATION) {
              return result;
            }
          }
        }
        if (result & PROPAGATE_UP || isPointInBox(ex, ey, x, y, w, h)) {
          result |= onItem(item);
        }
        return result;
      };
      return function(type, item, ex, ey, onItem) {
        if (item) {
          return checkItem(type, item, ex, ey, onItem, 0, 0, 1);
        }
        return 0;
      };
    })();
    itemsToRelease = [];
    itemsToMove = [];
    pressedItems = [];
    hoverItems = [];
    impl.Renderer.onReady(function() {
      var Device, event, getEventStatus;
      Device = impl.Renderer.Device;
      event = impl.Renderer.Item.Pointer.event;
      getEventStatus = function() {
        if (event._checkSiblings) {
          return PROPAGATE_UP;
        } else {
          return PROPAGATE_UP | STOP_ASIDE_PROPAGATION;
        }
      };
      Device.onPointerPress((function() {
        var onItem;
        onItem = function(item) {
          var capturePointer;
          capturePointer = item._impl.capturePointer;
          if (capturePointer & CLICK) {
            pressedItems.push(item);
          }
          if (capturePointer & PRESS) {
            event._ensureRelease = event._ensureMove = true;
            emitSignal(item.pointer, 'onPress', event);
            if (event._ensureRelease) {
              itemsToRelease.push(item);
            }
            if (event._ensureMove) {
              itemsToMove.push(item);
            }
            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
            return getEventStatus();
          }
          return STOP_ASIDE_PROPAGATION;
        };
        return function(e) {
          event._stopPropagation = false;
          event._checkSiblings = false;
          captureItems(PRESS | CLICK, impl.window, e._x, e._y, onItem);
        };
      })());
      Device.onPointerRelease((function() {
        var onItem;
        onItem = function(item) {
          var capturePointer, data, index;
          data = item._impl;
          capturePointer = data.capturePointer;
          if (capturePointer & RELEASE) {
            emitSignal(item._pointer, 'onRelease', event);
          }
          if (capturePointer & PRESS) {
            index = itemsToRelease.indexOf(item);
            if (index >= 0) {
              itemsToRelease[index] = null;
            }
          }
          if (capturePointer & CLICK) {
            if (utils.has(pressedItems, item)) {
              emitSignal(item.pointer, 'onClick', event);
            }
          }
          if (capturePointer & (RELEASE | CLICK)) {
            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
            return getEventStatus();
          }
          return STOP_ASIDE_PROPAGATION;
        };
        return function(e) {
          var item, _i;
          event._stopPropagation = false;
          event._checkSiblings = false;
          captureItems(RELEASE | CLICK, impl.window, e._x, e._y, onItem);
          if (!event._stopPropagation) {
            for (_i = itemsToRelease.length - 1; _i >= 0; _i += -1) {
              item = itemsToRelease[_i];
              if (item) {
                emitSignal(item.pointer, 'onRelease', event);
                if (event._stopPropagation) {
                  break;
                }
              }
            }
          }
          utils.clear(itemsToRelease);
          utils.clear(itemsToMove);
          utils.clear(pressedItems);
        };
      })());
      Device.onPointerMove((function() {
        var flag, onItem;
        flag = 0;
        onItem = function(item) {
          var capturePointer, data;
          data = item._impl;
          capturePointer = data.capturePointer;
          if (capturePointer & (ENTER | EXIT | MOVE)) {
            data.pointerMoveFlag = flag;
          }
          if (capturePointer & (ENTER | EXIT) && !data.pointerHover) {
            data.pointerHover = true;
            hoverItems.push(item);
            emitSignal(item.pointer, 'onEnter', event);
          }
          if (capturePointer & MOVE) {
            emitSignal(item._pointer, 'onMove', event);
          }
          if (capturePointer & (ENTER | EXIT | MOVE)) {
            if (event._stopPropagation) {
              return STOP_PROPAGATION;
            }
            return getEventStatus();
          }
          return STOP_ASIDE_PROPAGATION;
        };
        return function(e) {
          var data, i, item, _i, _j, _k, _len, _len1;
          event._stopPropagation = false;
          event._checkSiblings = false;
          flag = (flag % 2) + 1;
          captureItems(ENTER | EXIT | MOVE, impl.window, e._x, e._y, onItem);
          for (_i = 0, _len = itemsToMove.length; _i < _len; _i++) {
            item = itemsToMove[_i];
            if (event._stopPropagation) {
              break;
            }
            data = item._impl;
            if (data.pointerMoveFlag !== flag) {
              emitSignal(item.pointer, 'onMove', event);
            }
          }
          for (i = _j = hoverItems.length - 1; _j >= 0; i = _j += -1) {
            item = hoverItems[i];
            data = item._impl;
            if (data.pointerHover && data.pointerMoveFlag !== flag) {
              data.pointerHover = false;
              data.pointerMoveFlag = 0;
              hoverItems.splice(i, 1);
              emitSignal(item.pointer, 'onExit', event);
            }
          }
          for (_k = 0, _len1 = itemsToMove.length; _k < _len1; _k++) {
            item = itemsToMove[_k];
            data = item._impl;
            if (data.pointerMoveFlag !== flag) {
              data.pointerMoveFlag = flag;
            }
          }
        };
      })());
      return Device.onPointerWheel((function() {
        var onItem;
        onItem = function(item) {
          var pointer;
          event._stopPropagation = true;
          if (item._impl.capturePointer & WHEEL) {
            if ((pointer = item._pointer) && !signal.isEmpty(pointer.onWheel)) {
              emitSignal(pointer, 'onWheel', event);
              if (event._stopPropagation) {
                return STOP_PROPAGATION;
              }
              return getEventStatus();
            }
          }
          return STOP_ASIDE_PROPAGATION;
        };
        return function(e) {
          event._checkSiblings = false;
          captureItems(WHEEL, impl.window, e._x, e._y, onItem);
        };
      })());
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
      setItemParent: function(val) {},
      attachItemSignal: function(signal) {
        var data, eventId, item;
        item = this._ref;
        data = item._impl;
        if (!(eventId = EVENTS[signal])) {
          return;
        }
        data.capturePointer |= eventId;
      },
      setItemPointerEnabled: function(val) {},
      setItemPointerDraggable: function(val) {},
      setItemPointerDragActive: function(val) {}
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/impl/base/utils/color.coffee'] = (function(){
var module = {exports: modules["../renderer/impl/base/utils/color.coffee"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  assert = require('assert');

  log = require('log');

  utils = require('utils');

  log = log.scope('Renderer');


  /*
  Parse 3-digit hex, 6-digit hex, rgb, rgba, hsl, hsla, or named color into RGBA hex.
   */

  exports.toRGBAHex = (function() {
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
    numberToHex = function(val) {
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
    alphaToHex = function(val) {
      return numberToHex(Math.round(parseFloat(val) * 255));
    };
    hslToRgb = (function() {
      var hueToRgb;
      hueToRgb = function(p, q, t) {
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
      return function(hStr, sStr, lStr) {
        var blue, green, h, l, p, q, red, s;
        p = q = h = s = l = 0.0;
        h = (parseFloat(hStr) % 360) / 360;
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
    })();
    return function(color, defaultColor) {
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
        g = parseInt(color[1], 16);
        b = parseInt(color[1], 16);
        r = r << 1 | r;
        g = g << 1 | g;
        b = b << 1 | b;
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
  })();

}).call(this);


return module.exports;
})();modules['../renderer/utils/item.coffee'] = (function(){
var module = {exports: modules["../renderer/utils/item.coffee"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Emitter, assert, emitSignal, isArray, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  log = log.scope('Renderer');

  Emitter = signal.Emitter;

  emitSignal = Emitter.emitSignal;

  isArray = Array.isArray;

  module.exports = function(Renderer, Impl) {
    var CustomObject, DeepObject, FixedObject, MutableDeepObject, NOP, UtilsObject, exports, getObjAsString, getObjFile, getPropHandlerName, getPropInternalName;
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
        classElem = Renderer.Class.New(component);
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

      UtilsObject.initialize = function(object, component, opts) {
        assert.instanceOf(component, Renderer.Component);
        Object.preventExtensions(object);
        object._component = component;
        Impl.initializeObject(object, object.constructor.__name__);
        if (opts) {
          return UtilsObject.setOpts(object, component, opts);
        }
      };

      function UtilsObject() {
        Emitter.call(this);
        this.id = '';
        this._impl = null;
        this._bindings = null;
        this._classExtensions = null;
        this._classList = [];
        this._classQueue = [];
        this._extensions = [];
        this._component = null;
        Impl.createObject(this, this.constructor.__name__);
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
        clone = this.constructor.New(component);
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

    })(Emitter);
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
        var basicGetter, basicSetter, customGetter, customSetter, developmentSetter, func, getter, implementation, implementationValue, internalName, name, namespace, namespaceSignalName, propGetter, propSetter, prototype, setter, signalName, uniquePropName, valueConstructor;
        assert.isPlainObject(opts);
        name = opts.name, namespace = opts.namespace, valueConstructor = opts.valueConstructor, implementation = opts.implementation, implementationValue = opts.implementationValue;
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
        propGetter = basicGetter = Function("return this." + internalName);
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
          func = (function() {
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
              if (implementationValue != null) {
                funcStr += "impl.call(this._ref, implValue(val));\n";
              } else {
                funcStr += "impl.call(this._ref, val);\n";
              }
            }
            funcStr += "this." + internalName + " = val;\n";
            funcStr += "emitSignal(this, '" + signalName + "', oldVal);\n";
            funcStr += "emitSignal(this._ref, '" + namespaceSignalName + "', '" + name + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'implValue', 'emitSignal', 'debug', funcStr);
          })();
          propSetter = basicSetter = func(implementation, implementationValue, emitSignal, developmentSetter);
        } else {
          func = (function() {
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
              if (implementationValue != null) {
                funcStr += "impl.call(this, implValue(val));\n";
              } else {
                funcStr += "impl.call(this, val);\n";
              }
            }
            funcStr += "this." + internalName + " = val;\n";
            funcStr += "emitSignal(this, '" + signalName + "', oldVal);\n";
            funcStr += "};";
            return func = new Function('impl', 'implValue', 'emitSignal', 'debug', funcStr);
          })();
          propSetter = basicSetter = func(implementation, implementationValue, emitSignal, developmentSetter);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Screen, screen;
    Screen = (function(_super) {
      __extends(Screen, _super);

      function Screen() {
        Screen.__super__.constructor.call(this);
        this._impl = {
          bindings: null
        };
        this._touch = false;
        this._width = 1024;
        this._height = 800;
        this._orientation = 'Portrait';
        Object.preventExtensions(this);
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

      itemUtils.defineProperty({
        constructor: Screen,
        name: 'orientation',
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      return Screen;

    })(signal.Emitter);
    screen = new Screen;
    Impl.initScreenNamespace.call(screen, function() {
      if (Renderer.window) {
        Renderer.window.width = screen.width;
        Renderer.window.height = screen.height;
      }
    });
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
    var Device, DeviceKeyboardEvent, DevicePointerEvent, device;
    Device = (function(_super) {
      __extends(Device, _super);

      function Device() {
        Device.__super__.constructor.call(this);
        this._platform = 'Unix';
        this._desktop = true;
        this._phone = false;
        this._pixelRatio = 1;
        this._pointer = new DevicePointerEvent;
        this._keyboard = new DeviceKeyboardEvent;
        Object.preventExtensions(this);
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

      utils.defineProperty(Device.prototype, 'pointer', null, function() {
        return this._pointer;
      }, null);

      signal.Emitter.createSignal(Device, 'onPointerPress');

      signal.Emitter.createSignal(Device, 'onPointerRelease');

      signal.Emitter.createSignal(Device, 'onPointerMove');

      signal.Emitter.createSignal(Device, 'onPointerWheel');

      utils.defineProperty(Device.prototype, 'keyboard', null, function() {
        return this._keyboard;
      }, null);

      signal.Emitter.createSignal(Device, 'onKeyPress');

      signal.Emitter.createSignal(Device, 'onKeyHold');

      signal.Emitter.createSignal(Device, 'onKeyRelease');

      signal.Emitter.createSignal(Device, 'onKeyInput');

      return Device;

    })(signal.Emitter);
    DevicePointerEvent = (function(_super) {
      __extends(DevicePointerEvent, _super);

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

    })(signal.Emitter);
    DeviceKeyboardEvent = (function(_super) {
      __extends(DeviceKeyboardEvent, _super);

      function DeviceKeyboardEvent() {
        DeviceKeyboardEvent.__super__.constructor.call(this);
        this._visible = false;
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
        name: 'key',
        defaultValue: ''
      });

      itemUtils.defineProperty({
        constructor: DeviceKeyboardEvent,
        name: 'text',
        defaultValue: ''
      });

      DeviceKeyboardEvent.prototype.show = function() {
        return Impl.showDeviceKeyboard.call(device);
      };

      DeviceKeyboardEvent.prototype.hide = function() {
        return Impl.hideDeviceKeyboard.call(device);
      };

      return DeviceKeyboardEvent;

    })(signal.Emitter);
    device = new Device;
    (function() {
      var updateMovement, x, y;
      x = y = 0;
      updateMovement = function(event) {
        event.movementX = event.x - x;
        event.movementY = event.y - y;
        x = event.x;
        y = event.y;
      };
      device.onPointerPress(updateMovement);
      device.onPointerRelease(updateMovement);
      return device.onPointerMove(updateMovement);
    })();
    Impl.initDeviceNamespace.call(device);
    return device;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/namespace/navigator.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/namespace/navigator.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Navigator, navigator, _ref;
    Navigator = (function(_super) {
      __extends(Navigator, _super);

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
        developmentSetter: function(val) {
          return assert.isBoolean(val);
        }
      });

      return Navigator;

    })(signal.Emitter);
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
    var RotationSensor, rotationSensor;
    RotationSensor = (function(_super) {
      __extends(RotationSensor, _super);

      function RotationSensor() {
        RotationSensor.__super__.constructor.call(this);
        this._active = false;
        this.x = 0;
        this.y = 0;
        this.z = 0;
        Object.preventExtensions(this);
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

      return RotationSensor;

    })(signal.Emitter);
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

      function Extension() {
        Extension.__super__.constructor.call(this);
        if (this._impl == null) {
          this._impl = {
            bindings: null
          };
        }
        this._target = null;
        this._running = false;
        this._when = false;
        this._whenHandler = null;
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","list":"../list/index.coffee.md","document/element/element/tag/query":"../document/element/element/tag/query.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var List, TagQuery, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  signal = require('signal');

  log = require('log');

  List = require('list');

  TagQuery = require('document/element/element/tag/query');

  log = log.scope('Rendering', 'Class');

  module.exports = function(Renderer, Impl, itemUtils) {
    var ATTRS_ALIAS, ATTRS_ALIAS_DEF, ChangesObject, Class, ClassChildDocument, ClassDocument, ClassesList, classListSortFunc, cloneClassChild, cloneClassWithNoDocument, disableClass, enableClass, getContainedAttributeOrAlias, getObject, getPropertyDefaultValue, ifClassListWillChange, loadObjects, normalizeClassesValue, runQueue, saveAndDisableClass, saveAndEnableClass, setAttribute, splitAttribute, unloadObjects, updateChildPriorities, updateClassList, updatePriorities, updateTargetClass;
    ChangesObject = (function() {
      function ChangesObject() {
        this._links = [];
        this._attributes = {};
        this._functions = [];
        this._bindings = {};
      }

      ChangesObject.prototype.setAttribute = function(prop, val) {
        this._attributes[prop] = val;
        if (val instanceof Renderer.Component.Link) {
          this._links.push(val);
        }
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

      Class.New = function(component, opts) {
        var item;
        item = new Class;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function Class() {
        Class.__super__.constructor.call(this);
        this._classUid = utils.uid();
        this._priority = 0;
        this._inheritsPriority = 0;
        this._nestingPriority = 0;
        this._name = '';
        this._changes = null;
        this._document = null;
        this._children = null;
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
        var classElem, docQuery, _i, _len, _ref, _ref1, _ref2;
        docQuery = (_ref = this._document) != null ? _ref._query : void 0;
        if (this._running || !this._target || docQuery) {
          if (docQuery) {
            _ref1 = this._document._classesInUse;
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              classElem = _ref1[_i];
              classElem.enable();
            }
          }
          return;
        }
        Class.__super__.enable.call(this);
        updateTargetClass(saveAndEnableClass, this._target, this);
        if (!((_ref2 = this._document) != null ? _ref2._query : void 0)) {
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
          assert.isNot(val, this._ref);
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
        var clone, query, _ref;
        clone = cloneClassWithNoDocument.call(this, component);
        if (query = (_ref = this._document) != null ? _ref._query : void 0) {
          clone.document.query = query;
        }
        return clone;
      };

      return Class;

    })(Renderer.Extension);
    loadObjects = function(classElem, component, item) {
      var child, children, _i, _len;
      if (children = classElem._children) {
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
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
    unloadObjects = function(classElem, item) {
      var child, children, _i, _len;
      if (children = classElem._children) {
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
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
    updateChildPriorities = function(parent, child) {
      var _ref;
      child._inheritsPriority = parent._inheritsPriority + parent._priority;
      child._nestingPriority = parent._nestingPriority + 1 + (((_ref = child._document) != null ? _ref._priority : void 0) || 0);
      updatePriorities(child);
    };
    updatePriorities = function(classElem) {
      var child, children, document, target, _i, _inheritsPriority, _j, _k, _len, _len1, _len2, _nestingPriority, _ref, _ref1;
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
      if (document = classElem._document) {
        _inheritsPriority = classElem._inheritsPriority, _nestingPriority = classElem._nestingPriority;
        _ref = document._classesInUse;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          child = _ref[_j];
          child._inheritsPriority = _inheritsPriority;
          child._nestingPriority = _nestingPriority;
          updatePriorities(child);
        }
        _ref1 = document._classesPool;
        for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
          child = _ref1[_k];
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
      if (index < classList.length - 1 && classListSortFunc(classElem, classList[index + 1]) > 0) {
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
    cloneClassChild = function(classElem, component, child) {
      var clone, cloneComp;
      clone = component.cloneRawObject(child);
      cloneComp = clone._component.belongsToComponent || clone._component;
      if (cloneComp.onObjectChange == null) {
        cloneComp.onObjectChange = signal.create();
      }
      if (component.isDeepClone) {
        if (classElem.id) {
          cloneComp.setObjectById(clone, classElem.id);
        }
        cloneComp.initObjects();
        if (utils.has(component.idsOrder, clone.id)) {
          component.setObjectById(clone, clone.id);
        }
      }
      return clone;
    };
    cloneClassWithNoDocument = function(component) {
      var changes, child, childClone, children, clone, i, link, linkClone, prop, val, _i, _j, _len, _len1, _ref, _ref1;
      clone = Class.New(component);
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
      if (children = this._children) {
        for (i = _i = 0, _len = children.length; _i < _len; i = ++_i) {
          child = children[i];
          childClone = cloneClassChild(clone, component, child);
          clone.children.append(childClone);
        }
      }
      if (component.isDeepClone) {
        if ((changes = this._changes)) {
          _ref1 = changes._links;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            link = _ref1[_j];
            linkClone = cloneClassChild(clone, component, link.getItem(this._component));
          }
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
              cmdLen = TagQuery.getSelectorCommandsLength(val, 0, 1);
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
        var style;
        node.onStyleChange(onNodeStyleChange, this);
        if (style = node._style) {
          connectNodeStyle.call(this, style);
        }
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
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

      function Animation() {
        Animation.__super__.constructor.call(this);
        this._loop = false;
        this._updatePending = false;
        this._paused = false;
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md"});
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

      function PropertyAnimation() {
        PropertyAnimation.__super__.constructor.call(this);
        this._target = null;
        this._property = '';
        this._autoFrom = true;
        this._duration = 250;
        this._startDelay = 0;
        this._loopDelay = 0;
        this._updateData = false;
        this._updateProperty = false;
        this._easing = null;
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

      NumberAnimation.New = function(component, opts) {
        var item;
        item = new NumberAnimation;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function NumberAnimation() {
        NumberAnimation.__super__.constructor.call(this);
        this._from = 0;
        this._to = 0;
      }

      return NumberAnimation;

    })(Renderer.PropertyAnimation);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/extensions/transition.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/extensions/transition.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
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

      Transition.New = function(component, opts) {
        var item;
        item = new Transition;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function Transition() {
        Transition.__super__.constructor.call(this);
        this._animation = null;
        this._property = '';
        this._duration = 0;
        this._to = 0;
        this._durationUpdatePending = false;
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, signal, utils;

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

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
        this.parent = original;
        this.disabledObjects = (original != null ? original.disabledObjects : void 0) || Object.create(null);
        this.clone = utils.bindFunctionContext(this.clone, this);
        this.createItem = utils.bindFunctionContext(this.createItem, this);
        this.createItem.getComponent = this.clone;
        this.onObjectChange = null;
        Object.preventExtensions(this);
      }

      initSignalArr = function() {
        var i, id, _base, _i, _len, _ref;
        _ref = this.idsOrder;
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          id = _ref[i];
          (_base = this.objectsOrder)[i] || (_base[i] = this.objects[id] || null);
        }
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
        var clone, component, components, createdComponents, i, id, val, _base, _i, _len, _ref, _ref1;
        if (opts == null) {
          opts = 0;
        }
        assert.instanceOf(item, itemUtils.Object);
        assert.isString(item.id);
        assert.notLengthOf(item.id, 0);
        assert.ok(item.id !== this.itemId);
        assert.ok(this.objects[item.id] || ((_ref = this.parent) != null ? _ref.objects[item.id] : void 0));
        id = item.id;
        if (id === this.itemId) {
          clone = this.createItem();
        } else {
          component = new Component(this);
          component.objects = Object.create(this.objects);
          component.item = this.item;
          component.objectsOrderSignalArr = new Array(this.objectsOrder.length + 2);
          component.isDeepClone = true;
          component.ready = true;
          component.mirror = true;
          components = {};
          components[component.id] = component;
          createdComponents = [component];
          clone = cloneItem(item, components, createdComponents, component);
          _ref1 = this.idsOrder;
          for (i = _i = 0, _len = _ref1.length; _i < _len; i = ++_i) {
            val = _ref1[i];
            component.objectsOrder[i] = (_base = component.objectsOrderSignalArr)[i] || (_base[i] = this.objectsOrder[i]);
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
        assert.is(comp.objectsOrder.length, comp.idsOrder.length);
        return comp;
      };

      Component.prototype.setObjectById = function(object, id) {
        var index, oldVal, _ref, _ref1;
        assert.instanceOf(object, itemUtils.Object);
        assert.isString(id);
        assert.ok(this.objects[id] || ((_ref = this.parent) != null ? _ref.objects[id] : void 0));
        if ((oldVal = this.objects[id]) === object) {
          return;
        }
        this.objects[id] = object;
        index = this.idsOrder.indexOf(id);
        if (index !== -1) {
          this.objectsOrder[index] = this.objectsOrderSignalArr[index] = object;
          if ((_ref1 = this.onObjectChange) != null) {
            _ref1.emit(id, oldVal);
          }
        }
        return object;
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","list":"../list/index.coffee.md","./item/spacing":"../renderer/types/basics/item/spacing.coffee.md","./item/alignment":"../renderer/types/basics/item/alignment.coffee.md","./item/anchors":"../renderer/types/basics/item/anchors.coffee.md","./item/layout":"../renderer/types/basics/item/layout.coffee.md","./item/margin":"../renderer/types/basics/item/margin.coffee.md","./item/pointer":"../renderer/types/basics/item/pointer.coffee.md","./item/keys":"../renderer/types/basics/item/keys.coffee.md","./item/document":"../renderer/types/basics/item/document.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, assert, emitSignal, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

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

      Item.New = function(component, opts) {
        var item;
        item = new Item;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function Item() {
        assert.instanceOf(this, Item, 'ctor ...');
        Item.__super__.constructor.call(this);
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
      }

      itemUtils.defineProperty({
        constructor: Item,
        name: '$',
        valueConstructor: itemUtils.CustomObject
      });

      signal.Emitter.createSignal(Item, 'onReady');

      signal.Emitter.createSignal(Item, 'onAnimationFrame', (function() {
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
            emitSignal(item, 'onAnimationFrame', ms);
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
        if (index == null) {
          index = -1;
        }
        child.parent = null;
        if (index >= 0 && parent.children.length < index) {
          Impl.insertItemBefore.call(child, parent.children[index]);
        } else {
          Impl.setItemParent.call(child, parent);
        }
        child._parent = parent;
        emitSignal(child, 'onParentChange', null);
      };

      itemUtils.defineProperty({
        constructor: Item,
        name: 'parent',
        defaultValue: null,
        setter: function(_super) {
          return function(val) {
            var containsItem, existsInOldChildren, index, length, old, oldChildren, oldNextSibling, oldPreviousSibling, pointer, previousSibling, tmpItem, valChildren;
            if (val == null) {
              val = null;
            }
            old = this._parent;
            oldChildren = old != null ? old.children : void 0;
            valChildren = val != null ? val.children : void 0;
            existsInOldChildren = true;
            if (valChildren != null ? valChildren._target : void 0) {
              containsItem = false;
              tmpItem = valChildren._target;
              while (tmpItem) {
                if (tmpItem === this) {
                  containsItem = true;
                  break;
                }
                tmpItem = tmpItem._parent;
              }
              if (!containsItem) {
                val = valChildren._target;
                valChildren = val.children;
              }
            }
            if (old === val) {
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
                if (index === -1) {
                  existsInOldChildren = false;
                } else {
                  splice.call(oldChildren, index, 1);
                }
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
            Impl.setItemParent.call(this, val);
            this._parent = val;
            if (old !== null && existsInOldChildren) {
              emitSignal(old, 'onChildrenChange', null, this);
            }
            if (val !== null) {
              emitSignal(val, 'onChildrenChange', this, null);
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
          this.nextSibling = val._nextSibling;
        } else {
          assert.isDefined(this._parent);
          this.nextSibling = this._parent.children[0];
        }
        assert.is(this._previousSibling, val);
      });

      signal.Emitter.createSignal(Item, 'onPreviousSiblingChange');

      utils.defineProperty(Item.prototype, 'nextSibling', null, function() {
        return this._nextSibling;
      }, function(val) {
        var index, newChildren, newIndex, newParent, nextSibling, nextSiblingOldPreviousSibling, oldChildren, oldIndex, oldNextSibling, oldParent, oldPreviousSibling, previousSibling, previousSiblingOldNextSibling;
        if (val == null) {
          val = null;
        }
        assert.isNot(this, val);
        if (val) {
          assert.instanceOf(val, Item);
          assert.isDefined(val._parent);
        } else {
          assert.isDefined(this._parent);
        }
        if (val === this._nextSibling) {
          return;
        }
        oldParent = this._parent;
        oldChildren = oldParent._children;
        oldPreviousSibling = this._previousSibling;
        oldNextSibling = this._nextSibling;
        if (val) {
          newParent = val._parent;
          newChildren = newParent._children;
          Impl.insertItemBefore.call(this, val);
        } else {
          newParent = oldParent;
          newChildren = oldChildren;
          Impl.setItemParent.call(this, null);
          this._parent = null;
          Impl.setItemParent.call(this, newParent);
        }
        this._parent = newParent;
        if (oldPreviousSibling != null) {
          oldPreviousSibling._nextSibling = oldNextSibling;
        }
        if (oldNextSibling != null) {
          oldNextSibling._previousSibling = oldPreviousSibling;
        }
        oldIndex = oldChildren.index(this);
        Array.prototype.splice.call(oldChildren, oldIndex, 1);
        if (val) {
          newIndex = newChildren.indexOf(val);
          Array.prototype.splice.call(newChildren, newIndex, 0, this);
        } else {
          newIndex = newChildren.length;
          Array.prototype.push.call(newChildren, this);
        }
        if (newIndex > 0) {
          previousSibling = newChildren[newIndex - 1];
          previousSiblingOldNextSibling = previousSibling._nextSibling;
          previousSibling._nextSibling = this;
        } else {
          previousSibling = previousSiblingOldNextSibling = null;
        }
        if (newChildren.length > newIndex + 1) {
          nextSibling = newChildren[newIndex + 1];
          nextSiblingOldPreviousSibling = nextSibling._previousSibling;
          nextSibling._previousSibling = this;
        } else {
          nextSibling = nextSiblingOldPreviousSibling = null;
        }
        this._previousSibling = previousSibling;
        this._nextSibling = nextSibling;
        //<development>;
        index = this.index;
        assert.is(this._nextSibling, val);
        assert.is(this._parent, newParent);
        assert.is(newChildren[index], this);
        assert.is(newChildren[index - 1] || null, this._previousSibling);
        assert.is(newChildren[index + 1] || null, this._nextSibling);
        if (val) {
          assert.is(this._parent, val._parent);
        }
        if (this._previousSibling) {
          assert.is(this._previousSibling._nextSibling, this);
        } else {
          assert.is(index, 0);
        }
        if (this._nextSibling) {
          assert.is(this._nextSibling._previousSibling, this);
        } else {
          assert.is(index, newChildren.length - 1);
        }
        if (oldPreviousSibling) {
          assert.is(oldPreviousSibling._nextSibling, oldNextSibling);
        }
        if (oldNextSibling) {
          assert.is(oldNextSibling._previousSibling, oldPreviousSibling);
        }
        //</development>;
        if (oldParent !== newParent) {
          emitSignal(oldChildren, 'onChildrenChange', null, this);
          emitSignal(newChildren, 'onChildrenChange', this, null);
          emitSignal(this, 'onParentChange', oldParent);
        } else {
          emitSignal(newChildren, 'onChildrenChange', null, null);
        }
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

      signal.Emitter.createSignal(Item, 'onNextSiblingChange');

      utils.defineProperty(Item.prototype, 'index', null, function() {
        var _ref1;
        return (_ref1 = this._parent) != null ? _ref1.children.index(this) : void 0;
      }, function(val) {
        var children, valItem;
        assert.isInteger(val);
        assert.isDefined(this._parent);
        assert.operator(val, '>=', 0);
        assert.operator(val, '<=', this._parent._children.length);
        children = this._parent._children;
        if (val >= children.length) {
          this.nextSibling = null;
        } else if ((valItem = children[val]) !== this) {
          this.nextSibling = valItem;
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
          return assert.isInteger(val, '::z setter ...');
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
        ext = Renderer.Class.New(new Renderer.Component);
        ext.priority = -1;
        ext.changes.setAttribute('anchors.fill', ['parent']);
        return ext;
      })();

      createDefaultBackground = function(parent) {
        var ext, rect;
        rect = Renderer.Rectangle.New(parent._component);
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

      Item.createSpacing = require('./item/spacing')(Renderer, Impl, itemUtils, Item);

      Item.createAlignment = require('./item/alignment')(Renderer, Impl, itemUtils, Item);

      Item.createAnchors = require('./item/anchors')(Renderer, Impl, itemUtils, Item);

      Item.createLayout = require('./item/layout')(Renderer, Impl, itemUtils, Item);

      Item.createMargin = require('./item/margin')(Renderer, Impl, itemUtils, Item);

      Item.createPointer = require('./item/pointer')(Renderer, Impl, itemUtils, Item);

      Item.createKeys = require('./item/keys')(Renderer, Impl, itemUtils, Item);

      Item.createDocument = require('./item/document')(Renderer, Impl, itemUtils, Item);

      Item.createAnchors(Item);

      Item.createLayout(Item);

      Item.Pointer = Item.createPointer(Item);

      Item.createMargin(Item);

      Item.Keys = Item.createKeys(Item);

      Item.Document = Item.createDocument(Item);

      Item;

      return Item;

    })(itemUtils.Object);
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/spacing.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/spacing.coffee.md"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
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
          defaultValue: 0,
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
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
          Anchors.__super__.constructor.call(this, ref);
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
          Object.preventExtensions(this);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
          Layout.__super__.constructor.call(this, ref);
          this._enabled = true;
          this._fillWidth = false;
          this._fillHeight = false;
          Object.preventExtensions(this);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
          defaultValue: 0,
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
          Margin.__super__.constructor.call(this, ref);
          this._left = 0;
          this._top = 0;
          this._right = 0;
          this._bottom = 0;
          Object.preventExtensions(this);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
        var PointerEvent, initializeHover, intitializePressed, onLazySignalInitialized, signalName, _i, _len, _ref;

        __extends(Pointer, _super);

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
          name: 'dragActive',
          defaultValue: false,
          namespace: 'pointer',
          parentConstructor: ctor,
          implementation: Impl.setItemPointerDragActive,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          }
        });

        onLazySignalInitialized = function(pointer, name) {
          Impl.attachItemSignal.call(pointer, 'pointer', name);
        };

        Pointer.SIGNALS = ['onClick', 'onPress', 'onRelease', 'onEnter', 'onExit', 'onWheel', 'onMove', 'onDragStart', 'onDragEnd', 'onDragEnter', 'onDragExit', 'onDrop'];

        _ref = Pointer.SIGNALS;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          signalName = _ref[_i];
          signal.Emitter.createSignal(Pointer, signalName, onLazySignalInitialized);
        }

        intitializePressed = (function() {
          var onPress, onRelease;
          onPress = function(event) {
            event.stopPropagation = false;
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

        Pointer.PointerEvent = PointerEvent = (function() {
          function PointerEvent() {
            this._stopPropagation = true;
            this._checkSiblings = false;
            this._ensureRelease = true;
            this._ensureMove = true;
            Object.preventExtensions(this);
          }

          PointerEvent.prototype = Object.create(Renderer.Device.pointer);

          PointerEvent.prototype.constructor = PointerEvent;

          utils.defineProperty(PointerEvent.prototype, 'stopPropagation', null, function() {
            return this._stopPropagation;
          }, function(val) {
            assert.isBoolean(val);
            return this._stopPropagation = val;
          });

          utils.defineProperty(PointerEvent.prototype, 'checkSiblings', null, function() {
            return this._checkSiblings;
          }, function(val) {
            assert.isBoolean(val);
            return this._checkSiblings = val;
          });

          utils.defineProperty(PointerEvent.prototype, 'ensureRelease', null, function() {
            return this._ensureRelease;
          }, function(val) {
            assert.isBoolean(val);
            return this._ensureRelease = val;
          });

          utils.defineProperty(PointerEvent.prototype, 'ensureMove', null, function() {
            return this._ensureMove;
          }, function(val) {
            assert.isBoolean(val);
            return this._ensureMove = val;
          });

          return PointerEvent;

        })();

        Pointer.event = new PointerEvent;

        return Pointer;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/keys.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/keys.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
        var Device, KeysEvent, focusChangeOnPointerPress, focusedKeys, keysEvent, signalName, _i, _len, _ref;

        __extends(Keys, _super);

        Keys.__name__ = 'Keys';

        Device = Renderer.Device;

        itemUtils.defineProperty({
          constructor: ctor,
          name: 'keys',
          valueConstructor: Keys
        });

        Keys.focusWindowOnPointerPress = true;

        function Keys(ref) {
          Keys.__super__.constructor.call(this, ref);
          this._focus = false;
          Object.preventExtensions(this);
        }

        Keys.SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput'];

        _ref = Keys.SIGNALS;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          signalName = _ref[_i];
          signal.Emitter.createSignal(Keys, signalName);
        }

        focusedKeys = null;

        focusChangeOnPointerPress = false;

        Renderer.onReady(function() {
          return Renderer.Device.onPointerPress(function() {
            return focusChangeOnPointerPress = false;
          });
        });

        Renderer.onWindowChange(function() {
          return this.window.pointer.onPress(function() {
            if (Keys.focusWindowOnPointerPress && !focusChangeOnPointerPress) {
              return this.keys.focus = true;
            }
          }, this.window);
        });

        itemUtils.defineProperty({
          constructor: Keys,
          name: 'focus',
          defaultValue: false,
          implementation: Impl.setItemKeysFocus,
          namespace: 'keys',
          parentConstructor: ctor,
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          setter: function(_super) {
            return function(val) {
              var oldVal;
              if (val) {
                focusChangeOnPointerPress = true;
              }
              if (this._focus !== val) {
                if (val && focusedKeys !== this) {
                  if (focusedKeys) {
                    oldVal = focusedKeys;
                    focusedKeys = null;
                    Impl.setItemKeysFocus.call(oldVal._ref, false);
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

        Device.onKeyPress(function(event) {
          return focusedKeys != null ? focusedKeys.onPress.emit(keysEvent) : void 0;
        });

        Device.onKeyHold(function(event) {
          return focusedKeys != null ? focusedKeys.onHold.emit(keysEvent) : void 0;
        });

        Device.onKeyRelease(function(event) {
          return focusedKeys != null ? focusedKeys.onRelease.emit(keysEvent) : void 0;
        });

        Device.onKeyInput(function(event) {
          return focusedKeys != null ? focusedKeys.onInput.emit(keysEvent) : void 0;
        });

        Keys.KeysEvent = KeysEvent = (function() {
          function KeysEvent() {
            Object.preventExtensions(this);
          }

          KeysEvent.prototype = Object.create(Device.keyboard);

          KeysEvent.prototype.constructor = KeysEvent;

          return KeysEvent;

        })();

        Keys.event = keysEvent = new KeysEvent;

        return Keys;

      })(itemUtils.DeepObject);
    };
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/document.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/document.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  log = require('log');

  log = log.scope('Renderer', 'Document');

  module.exports = function(Renderer, Impl, itemUtils, Item) {
    return function(ctor) {
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
          if (this._updatingProperty === prop || !(node = this._node) || !node.hasAttr(prop)) {
            return;
          }
          if (oldVal === void 0) {
            setProperty.call(this, this._ref._$, prop, node._attrs[prop], oldVal);
          } else {
            node.setAttr(prop, this._ref._$[prop]);
          }
        };

        onNodeAttrsChange = function(attr, oldVal) {
          var props;
          if (!(props = this._ref._$)) {
            return;
          }
          if (attr in props) {
            setProperty.call(this, props, attr, this._node._attrs[attr], oldVal);
          }
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
          ItemDocument.__super__.constructor.call(this, ref);
          this._node = null;
          this._visible = false;
          this._query = '';
          this._updatingProperty = '';
          this._propertiesCleanQueue = [];
          Object.preventExtensions(this);
          ref.on$Change(onPropertyChange, this);
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

        ItemDocument.ShowEvent = DocumentShowEvent = (function() {
          function DocumentShowEvent() {
            this.delay = 0;
            Object.preventExtensions(this);
          }

          return DocumentShowEvent;

        })();

        ItemDocument.HideEvent = DocumentHideEvent = (function() {
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  signal = require('signal');

  log = require('log');

  utils = require('utils');

  log = log.scope('Renderer', 'Image');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Image;
    return Image = (function(_super) {
      var FILL_MODE_OPTIONS, getter, itemHeightSetter, itemWidthSetter, pixelRatio, updateSize;

      __extends(Image, _super);

      Image.__name__ = 'Image';

      Image.__path__ = 'Renderer.Image';

      Image.New = function(component, opts) {
        var item;
        item = new Image;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function Image() {
        Image.__super__.constructor.call(this);
        this._source = '';
        this._loaded = false;
        this._sourceWidth = 0;
        this._sourceHeight = 0;
        this._fillMode = 'Stretch';
        this._autoWidth = true;
        this._autoHeight = true;
        this._width = -1;
        this._height = -1;
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

      updateSize = function() {
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

      utils.defineProperty(Image.prototype, 'width', null, getter, (function(_super) {
        return function(val) {
          this._autoWidth = val === -1;
          _super.call(this, val);
          updateSize.call(this);
        };
      })(itemWidthSetter));

      Image.prototype._height = -1;

      getter = utils.lookupGetter(Image.prototype, 'height');

      itemHeightSetter = utils.lookupSetter(Image.prototype, 'height');

      utils.defineProperty(Image.prototype, 'height', null, getter, (function(_super) {
        return function(val) {
          this._autoHeight = val === -1;
          _super.call(this, val);
          updateSize.call(this);
        };
      })(itemHeightSetter));

      itemUtils.defineProperty({
        constructor: Image,
        name: 'source',
        defaultValue: '',
        developmentSetter: function(val) {
          return assert.isString(val);
        },
        setter: (function() {
          var RESOURCE_REQUEST, defaultResult, loadCallback;
          RESOURCE_REQUEST = {
            resolution: 1
          };
          defaultResult = {
            source: '',
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
              assert.isString(opts.source);
              assert.isFloat(opts.width);
              assert.isFloat(opts.height);
              this.sourceWidth = opts.width;
              this.sourceHeight = opts.height;
              if (this._autoWidth) {
                itemWidthSetter.call(this, opts.width);
              }
              if (this._autoHeight) {
                itemHeightSetter.call(this, opts.height);
              }
              updateSize.call(this);
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
              var _ref;
              _super.call(this, val);
              if (this._loaded) {
                this._loaded = false;
                this.onLoadedChange.emit(true);
              }
              if (val) {
                RESOURCE_REQUEST.resolution = Renderer.Device.pixelRatio * Image.pixelRatio;
                val = ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
                Impl.setImageSource.call(this, val, loadCallback);
              } else {
                Impl.setImageSource.call(this, null, null);
                defaultResult.source = val;
                loadCallback.call(this, null, defaultResult);
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
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'sourceHeight',
        defaultValue: 0,
        implementation: Impl.setImageSourceHeight,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'offsetX',
        defaultValue: 0,
        implementation: Impl.setImageOffsetX,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Image,
        name: 'offsetY',
        defaultValue: 0,
        implementation: Impl.setImageOffsetY,
        developmentSetter: function(val) {
          return assert.isFloat(val);
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","./text/font":"../renderer/types/basics/item/types/text/font.coffee.md"});
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
      var getter, itemHeightSetter, itemWidthSetter;

      __extends(Text, _super);

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

      Text.New = function(component, opts) {
        var item, name;
        item = new Text;
        itemUtils.Object.initialize(item, component, opts);
        if (name = Renderer.FontLoader.getInternalFontName('sans-serif', 14, false)) {
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

      utils.defineProperty(Text.prototype, 'width', null, getter, (function(_super) {
        return function(val) {
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
      })(itemWidthSetter));

      Text.prototype._height = -1;

      getter = utils.lookupGetter(Text.prototype, 'height');

      itemHeightSetter = utils.lookupSetter(Text.prototype, 'height');

      utils.defineProperty(Text.prototype, 'height', null, getter, (function(_super) {
        return function(val) {
          if (this._autoHeight = val === -1) {
            _super.call(this, this._contentHeight);
            Impl.updateTextContentSize.call(this);
          } else {
            _super.call(this, val);
          }
        };
      })(itemHeightSetter));

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
        implementationValue: (function() {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function(val) {
            var _ref;
            return ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        })(),
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Text,
        name: 'linkColor',
        defaultValue: 'blue',
        implementation: Impl.setTextLinkColor,
        implementationValue: (function() {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function(val) {
            var _ref;
            return ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        })(),
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

      itemUtils.defineProperty({
        constructor: Text,
        name: 'contentWidth',
        defaultValue: 0,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        },
        setter: function(_super) {
          return function(val) {
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
        developmentSetter: function(val) {
          return assert.isFloat(val);
        },
        setter: function(_super) {
          return function(val) {
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

    })(Renderer.Item);
    return Text;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/basics/item/types/text/font.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/basics/item/types/text/font.coffee.md"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  log = require('log');

  log = log.scope('Renderer', 'Font');

  module.exports = function(Renderer, Impl, itemUtils) {
    return function(ctor) {
      var Font;
      return Font = (function(_super) {
        var checkingFamily, reloadFontFamily, setFontFamilyImpl;

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
          Font.__super__.constructor.call(this, ref);
          this._family = 'sans-serif';
          this._pixelSize = 14;
          this._weight = 0.4;
          this._wordSpacing = 0;
          this._letterSpacing = 0;
          this._italic = false;
          Object.preventExtensions(this);
        }

        setFontFamilyImpl = Impl["set" + ctor.__name__ + "FontFamily"];

        reloadFontFamily = function(font) {
          var name;
          name = Renderer.FontLoader.getInternalFontName(font._family, font._weight, font._italic);
          name || (name = 'sans-serif');
          return setFontFamilyImpl.call(font._ref, name);
        };

        //<development>;

        checkingFamily = {};

        //</development>;

        itemUtils.defineProperty({
          constructor: Font,
          name: 'family',
          defaultValue: 'sans-serif',
          namespace: 'font',
          parentConstructor: ctor,
          developmentSetter: function(val) {
            return assert.isString(val);
          },
          setter: function(_super) {
            return function(val) {
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
          developmentSetter: function(val) {
            assert.isFloat(val);
            assert.operator(val, '>=', 0);
            return assert.operator(val, '<=', 1);
          },
          setter: function(_super) {
            return function(val) {
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
          developmentSetter: function(val) {
            return assert.isBoolean(val);
          },
          setter: function(_super) {
            return function(val) {
              _super.call(this, val);
              return reloadFontFamily(this);
            };
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md"});
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

      TextInput.New = function(component, opts) {
        var item, name;
        item = new TextInput;
        itemUtils.Object.initialize(item, component, opts);
        if (name = Renderer.FontLoader.getInternalFontName('sans-serif', 14, false)) {
          Impl.setTextInputFontFamily.call(item, name);
        }
        item.pointer.onPress(function() {
          if (TextInput.keysFocusOnPointerPress) {
            return this.keys.focus = true;
          }
        }, item);
        return item;
      };

      TextInput.keysFocusOnPointerPress = true;

      function TextInput() {
        TextInput.__super__.constructor.call(this);
        this._text = '';
        this._color = 'black';
        this._lineHeight = 1;
        this._multiLine = false;
        this._echoMode = 'normal';
        this._alignment = null;
        this._font = null;
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
        implementationValue: (function() {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function(val) {
            var _ref;
            return ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        })(),
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

      Renderer.Item.createAlignment(TextInput);

      Renderer.Text.createFont(TextInput);

      return TextInput;

    })(Renderer.Item);
    return TextInput;
  };

}).call(this);


return module.exports;
})();modules['../renderer/types/shapes/rectangle.coffee.md'] = (function(){
var module = {exports: modules["../renderer/types/shapes/rectangle.coffee.md"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Border, Rectangle;
    Rectangle = (function(_super) {
      __extends(Rectangle, _super);

      Rectangle.__name__ = 'Rectangle';

      Rectangle.__path__ = 'Renderer.Rectangle';

      Rectangle.New = function(component, opts) {
        var item;
        item = new Rectangle;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function Rectangle() {
        Rectangle.__super__.constructor.call(this);
        this._color = 'transparent';
        this._radius = 0;
        this._border = null;
      }

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'color',
        defaultValue: 'transparent',
        implementation: Impl.setRectangleColor,
        implementationValue: (function() {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function(val) {
            var _ref;
            return ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        })(),
        developmentSetter: function(val) {
          return assert.isString(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Rectangle,
        name: 'radius',
        defaultValue: 0,
        implementation: Impl.setRectangleRadius,
        developmentSetter: function(val) {
          return assert.isFloat(val);
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
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Border,
        name: 'color',
        defaultValue: 'transparent',
        namespace: 'border',
        parentConstructor: Rectangle,
        implementation: Impl.setRectangleBorderColor,
        implementationValue: (function() {
          var RESOURCE_REQUEST;
          RESOURCE_REQUEST = {
            property: 'color'
          };
          return function(val) {
            var _ref;
            return ((_ref = Renderer.resources) != null ? _ref.resolve(val, RESOURCE_REQUEST) : void 0) || val;
          };
        })(),
        developmentSetter: function(val) {
          return assert.isString(val);
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
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

      Grid.New = function(component, opts) {
        var item;
        item = new Grid;
        itemUtils.Object.initialize(item, component, opts);
        item.effectItem = item;
        return item;
      };

      function Grid() {
        Grid.__super__.constructor.call(this);
        this._padding = null;
        this._columns = 2;
        this._rows = Infinity;
        this._spacing = null;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
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

      Renderer.Item.createMargin(Grid, {
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

      Renderer.Item.createSpacing(Grid);

      Renderer.Item.createAlignment(Grid);

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
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

      Column.New = function(component, opts) {
        var item;
        item = new Column;
        itemUtils.Object.initialize(item, component, opts);
        item.effectItem = item;
        return item;
      };

      function Column() {
        Column.__super__.constructor.call(this);
        this._padding = null;
        this._spacing = 0;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
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

      Renderer.Item.createMargin(Column, {
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

      Renderer.Item.createAlignment(Column);

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
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

      Row.New = function(component, opts) {
        var item;
        item = new Row;
        itemUtils.Object.initialize(item, component, opts);
        item.effectItem = item;
        return item;
      };

      function Row() {
        Row.__super__.constructor.call(this);
        this._padding = null;
        this._spacing = 0;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._effectItem = null;
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

      Renderer.Item.createMargin(Row, {
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

      Renderer.Item.createAlignment(Row);

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

  utils = require('utils');

  module.exports = function(Renderer, Impl, itemUtils) {
    var Flow;
    return Flow = (function(_super) {
      __extends(Flow, _super);

      Flow.__name__ = 'Flow';

      Flow.__path__ = 'Renderer.Flow';

      Flow.New = function(component, opts) {
        var item;
        item = new Flow;
        itemUtils.Object.initialize(item, component, opts);
        item.effectItem = item;
        return item;
      };

      function Flow() {
        Flow.__super__.constructor.call(this);
        this._padding = null;
        this._spacing = null;
        this._alignment = null;
        this._includeBorderMargins = false;
        this._collapseMargins = false;
        this._effectItem = null;
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

      Renderer.Item.createMargin(Flow, {
        propertyName: 'padding'
      });

      Renderer.Item.createSpacing(Flow);

      Renderer.Item.createAlignment(Flow);

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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, emitSignal, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  emitSignal = signal.Emitter.emitSignal;

  module.exports = function(Renderer, Impl, itemUtils) {
    var Scrollable;
    return Scrollable = (function(_super) {
      __extends(Scrollable, _super);

      Scrollable.__name__ = 'Scrollable';

      Scrollable.__path__ = 'Renderer.Scrollable';

      Scrollable.New = function(component, opts) {
        var item;
        item = new Scrollable;
        itemUtils.Object.initialize(item, component, opts);
        item.clip = true;
        return item;
      };

      function Scrollable() {
        Scrollable.__super__.constructor.call(this);
        this._contentItem = null;
        this._contentX = 0;
        this._contentY = 0;
        this._snap = false;
        this._snapItem = null;
      }

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'contentItem',
        defaultValue: null,
        implementation: Impl.setScrollableContentItem,
        setter: function(_super) {
          return function(val) {
            if (val != null) {
              assert.instanceOf(val, Renderer.Item);
              val.parent = null;
              val._parent = this;
              emitSignal(val, 'onParentChange', null);
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
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'contentY',
        defaultValue: 0,
        implementation: Impl.setScrollableContentY,
        developmentSetter: function(val) {
          return assert.isFloat(val);
        }
      });

      itemUtils.defineProperty({
        constructor: Scrollable,
        name: 'snap',
        defaultValue: false,
        implementation: Impl.setScrollableSnap,
        developmentSetter: function(val) {
          return assert.isBoolean(val);
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
            return assert.instanceOf(val, Renderer.Item);
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","list":"../list/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, SignalsEmitter, assert, isArray, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  assert = require('assert');

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

      AmbientSound.New = function(component, opts) {
        var item;
        item = new AmbientSound;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function AmbientSound() {
        AmbientSound.__super__.constructor.call(this);
        this._when = false;
        this._running = false;
        this._source = '';
        this._loop = false;
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
var require = getModule.bind(null, {"log":"../log/index.coffee.md","utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  log = require('log');

  utils = require('utils');

  assert = require('assert');

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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./resource":"../resources/resource.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Resources, assert, log, utils;

  utils = require('utils');

  log = require('log');

  assert = require('assert');

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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","resources":"../resources/index.coffee.md"});
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

      ResourcesLoader.New = function(component, opts) {
        var item;
        item = new ResourcesLoader;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function ResourcesLoader() {
        ResourcesLoader.__super__.constructor.call(this);
        this._resources = Renderer.resources;
        this._progress = 0;
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
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md"});
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
      var WEIGHTS, fontsByName, loadFont, loadFontIfReady;

      __extends(FontLoader, _super);

      FontLoader.__name__ = 'FontLoader';

      FontLoader.__path__ = 'Renderer.FontLoader';

      fontsByName = Object.create(null);

      WEIGHTS = [/hairline/i, /thin/i, /ultra.*light/i, /extra.*light/i, /light/i, /book/i, /normal|regular|roman|plain/i, /medium/i, /demi.*bold|semi.*bold/i, /bold/i, /extra.*bold|extra/i, /heavy/i, /black/i, /extra.*black/i, /ultra.*black|ultra/i];

      loadFont = (function() {
        var getFontWeight, isItalic;
        getFontWeight = function(source) {
          var i, re, _i, _len;
          for (i = _i = 0, _len = WEIGHTS.length; _i < _len; i = ++_i) {
            re = WEIGHTS[i];
            if (re.test(source)) {
              return i / (WEIGHTS.length - 1);
            }
          }
          log.warn("Can't find font weight in the got source; `" + source + "` got.");
          return 0.4;
        };
        isItalic = function(source) {
          return /italic|oblique/i.test(source);
        };
        return function(loader) {
          var i, italic, italicStr, name, obj, path, rsc, source, sources, weight, weightInt, _, _i, _len, _name, _ref, _ref1, _ref2;
          source = ((_ref = Renderer.resources) != null ? _ref.resolve(loader.source) : void 0) || loader.source;
          if (rsc = (_ref1 = Renderer.resources) != null ? _ref1.getResource(source) : void 0) {
            sources = [];
            _ref2 = rsc.paths;
            for (_ in _ref2) {
              path = _ref2[_];
              sources.push(path[1]);
            }
          } else {
            sources = [source];
          }
          weight = 0.4;
          italic = false;
          for (i = _i = 0, _len = sources.length; _i < _len; i = ++_i) {
            source = sources[i];
            if (weight !== (weight = getFontWeight(source)) && i > 0) {
              log.warn("'" + loader.source + "' sources have different weights");
            }
            if (italic !== (italic = isItalic(source)) && i > 0) {
              log.warn("'" + loader.source + "' sources have different 'italic' styles");
            }
          }
          weightInt = Math.round(weight * WEIGHTS.length);
          italicStr = italic ? 'italic' : 'normal';
          name = "neft-" + loader.name + "-" + weightInt + "-" + italicStr;
          obj = fontsByName[_name = loader.name] != null ? fontsByName[_name] : fontsByName[_name] = {};
          obj = obj[italic] != null ? obj[italic] : obj[italic] = new Array(WEIGHTS.length);
          obj[weightInt] = name;
          Impl.loadFont(name, source, sources);
        };
      })();

      loadFontIfReady = function(loader) {
        if (loader.name && loader.source) {
          return setImmediate(function() {
            return loadFont(loader);
          });
        }
      };

      FontLoader.getInternalFontName = function(name, weight, italic) {
        var closest, closestLeft, closestRight, i, obj, result, weightInt, _i, _j, _ref, _ref1, _ref2;
        result = '';
        if (obj = fontsByName[name]) {
          if (!obj[italic]) {
            log.warn("Font '" + name + "' italic style is not loaded");
          }
          if (obj = obj[italic] || obj[!italic]) {
            weightInt = Math.round(weight * WEIGHTS.length);
            if (!(result = obj[weightInt])) {
              closestLeft = -1;
              for (i = _i = _ref = weightInt - 1; _i >= 0; i = _i += -1) {
                if (obj[i]) {
                  closestLeft = i;
                  break;
                }
              }
              closestRight = -1;
              for (i = _j = _ref1 = weightInt + 1, _ref2 = WEIGHTS.length; _j < _ref2; i = _j += 1) {
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

      FontLoader.New = function(component, opts) {
        var item;
        item = new FontLoader;
        itemUtils.Object.initialize(item, component, opts);
        return item;
      };

      function FontLoader() {
        FontLoader.__super__.constructor.call(this);
        this._name = '';
        this._source = '';
      }

      utils.defineProperty(FontLoader.prototype, 'name', null, function() {
        return this._name;
      }, function(val) {
        assert.isString(val);
        assert.notLengthOf(val, 0);
        assert.lengthOf(this._source, 0);
        this._name = val;
        return loadFontIfReady(this);
      });

      utils.defineProperty(FontLoader.prototype, 'source', null, function() {
        return this._source;
      }, function(val) {
        assert.isString(val);
        assert.notLengthOf(val, 0);
        assert.lengthOf(this._source, 0);
        this._source = val;
        loadFontIfReady(this);
      });

      return FontLoader;

    })(itemUtils.FixedObject);
  };

}).call(this);


return module.exports;
})();modules['../renderer/index.coffee.md'] = (function(){
var module = {exports: modules["../renderer/index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","./impl":"../renderer/impl.coffee","./utils/item":"../renderer/utils/item.coffee","./types/namespace/screen":"../renderer/types/namespace/screen.coffee.md","./types/namespace/device":"../renderer/types/namespace/device.coffee.md","./types/namespace/navigator":"../renderer/types/namespace/navigator.coffee.md","./types/namespace/sensor/rotation":"../renderer/types/namespace/sensor/rotation.coffee.md","./types/extension":"../renderer/types/extension.coffee","./types/extensions/class":"../renderer/types/extensions/class.coffee.md","./types/extensions/animation":"../renderer/types/extensions/animation.coffee.md","./types/extensions/animation/types/property":"../renderer/types/extensions/animation/types/property.coffee.md","./types/extensions/animation/types/property/types/number":"../renderer/types/extensions/animation/types/property/types/number.coffee.md","./types/extensions/transition":"../renderer/types/extensions/transition.coffee.md","./types/basics/component":"../renderer/types/basics/component.coffee","./types/basics/item":"../renderer/types/basics/item.coffee.md","./types/basics/item/types/image":"../renderer/types/basics/item/types/image.coffee.md","./types/basics/item/types/text":"../renderer/types/basics/item/types/text.coffee.md","./types/basics/item/types/textInput":"../renderer/types/basics/item/types/textInput.coffee.md","./types/shapes/rectangle":"../renderer/types/shapes/rectangle.coffee.md","./types/layout/grid":"../renderer/types/layout/grid.coffee.md","./types/layout/column":"../renderer/types/layout/column.coffee.md","./types/layout/row":"../renderer/types/layout/row.coffee.md","./types/layout/flow":"../renderer/types/layout/flow.coffee.md","./types/layout/scrollable":"../renderer/types/layout/scrollable.coffee.md","./types/sound/ambient":"../renderer/types/sound/ambient.coffee.md","./types/loader/resources":"../renderer/types/loader/resources.coffee.md","./types/loader/font":"../renderer/types/loader/font.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Impl, assert, itemUtils, signal, utils;

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

  signal.create(exports, 'onReady');

  signal.create(exports, 'onWindowChange');

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
    assert.instanceOf(val, exports.Item);
    utils.defineProperty(exports, 'window', utils.ENUMERABLE, val);
    exports.onWindowChange.emit(null);
    return Impl.setWindow(val);
  });

  utils.defineProperty(exports, 'serverUrl', utils.WRITABLE, '');

  utils.defineProperty(exports, 'resources', utils.WRITABLE, null);

  exports.onReady.emit();

  Object.preventExtensions(exports);

}).call(this);


return module.exports;
})();modules['../document/func.coffee.md'] = (function(){
var module = {exports: modules["../document/func.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","renderer":"../renderer/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Renderer, assert, utils;

  utils = require('utils');

  assert = require('assert');

  Renderer = require('renderer');

  module.exports = function(File) {
    var FuncGlobalFuncs, FuncGlobalGetters, Input, exports, funcGlobalProps, funcGlobalPropsLength, functionsCache, globalContext;
    Input = File.Input;
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
        assert.instanceOf(file, File);
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, log, utils;

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  module.exports = function(File) {
    var AttrsToSet;
    return AttrsToSet = (function() {
      var JSON_ARGS_LENGTH, JSON_ATTRS, JSON_CTOR_ID, JSON_NODE, i;

      AttrsToSet.__name__ = 'AttrsToSet';

      AttrsToSet.__path__ = 'File.AttrsToSet';

      JSON_CTOR_ID = AttrsToSet.JSON_CTOR_ID = File.JSON_CTORS.push(AttrsToSet) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_ATTRS = i++;

      JSON_ARGS_LENGTH = AttrsToSet.JSON_ARGS_LENGTH = i;

      AttrsToSet._fromJSON = function(file, arr, obj) {
        var node;
        if (!obj) {
          node = file.node.getChildByAccessPath(arr[JSON_NODE]);
          obj = new AttrsToSet(file, node, arr[JSON_ATTRS]);
        }
        return obj;
      };

      function AttrsToSet(file, node, attrs) {
        var attr;
        this.file = file;
        this.node = node;
        this.attrs = attrs;
        assert.instanceOf(file, File);
        assert.instanceOf(node, File.Element);
        assert.isPlainObject(attrs);
        for (attr in this.attrs) {
          if (node._attrs[attr] != null) {
            clone.setAttribute(attr, null);
          }
        }
        node.onAttrsChange(this.setAttribute, clone);
        //<development>;
        if (this.constructor === AttrsToSet) {
          Object.preventExtensions(this);
        }
        //</development>;
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

      AttrsToSet.prototype.clone = function(original, file) {
        var node;
        node = original.node.getCopiedElement(this.node, file.node);
        return new AttrsToSet(file, node, this.attrs);
      };

      AttrsToSet.prototype.toJSON = function(key, arr) {
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
        arr[JSON_ATTRS] = this.attrs;
        return arr;
      };

      return AttrsToSet;

    })();
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","dict":"../dict/index.coffee.md","list":"../list/index.coffee.md","./element/index":"../document/element/index.coffee","./attrChange":"../document/attrChange.coffee","./use":"../document/use.coffee","./input":"../document/input.coffee","./condition":"../document/condition.coffee","./iterator":"../document/iterator.coffee","./log":"../document/log.coffee","./func":"../document/func.coffee.md","./attrsToSet":"../document/attrsToSet.coffee","./file/render/parse/target":"../document/file/render/parse/target.coffee","./file/render/revert/target":"../document/file/render/revert/target.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, Emitter, File, List, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  assert = require('assert');

  log = require('log');

  signal = require('signal');

  Dict = require('dict');

  List = require('list');

  assert = assert.scope('View');

  log = log.scope('View');

  Emitter = signal.Emitter;

  module.exports = File = (function(_super) {
    var JSON_ARGS_LENGTH, JSON_ATTRS_TO_SET, JSON_ATTR_CHANGES, JSON_CONDITIONS, JSON_CTOR_ID, JSON_FRAGMENTS, JSON_FUNCS, JSON_IDS, JSON_INPUTS, JSON_ITERATORS, JSON_LOGS, JSON_NODE, JSON_PATH, JSON_STYLES, JSON_TARGET_NODE, JSON_USES, files, getFromPool, i, pool;

    __extends(File, _super);

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

    File.__name__ = 'File';

    File.__path__ = 'File';

    File.JSON_CTORS = [];

    JSON_CTOR_ID = File.JSON_CTOR_ID = File.JSON_CTORS.push(File) - 1;

    i = 1;

    JSON_PATH = i++;

    JSON_NODE = i++;

    JSON_TARGET_NODE = i++;

    JSON_FRAGMENTS = i++;

    JSON_ATTR_CHANGES = i++;

    JSON_INPUTS = i++;

    JSON_CONDITIONS = i++;

    JSON_ITERATORS = i++;

    JSON_USES = i++;

    JSON_IDS = i++;

    JSON_FUNCS = i++;

    JSON_ATTRS_TO_SET = i++;

    JSON_LOGS = i++;

    JSON_STYLES = i++;

    JSON_ARGS_LENGTH = File.JSON_ARGS_LENGTH = i;

    File.HTML_NS = 'neft';

    signal.create(File, 'onCreate');

    signal.create(File, 'onError');

    signal.create(File, 'onBeforeParse');

    signal.create(File, 'onParse');

    signal.create(File, 'onBeforeRender');

    signal.create(File, 'onRender');

    signal.create(File, 'onBeforeRevert');

    signal.create(File, 'onRevert');

    File.Element = require('./element/index');

    File.AttrChange = require('./attrChange')(File);

    File.Use = require('./use')(File);

    File.Input = require('./input')(File);

    File.Condition = require('./condition')(File);

    File.Iterator = require('./iterator')(File);

    File.Log = require('./log')(File);

    File.Func = require('./func')(File);

    File.AttrsToSet = require('./attrsToSet')(File);

    File.fromHTML = (function() {
      var clear;
      if (!utils.isNode) {
        return function(path, html) {
          throw new Error("Document.fromHTML is available only on the server");
        };
      }
      clear = require('./file/clear')(File);
      return function(path, html) {
        var node;
        assert.isString(path);
        assert.notLengthOf(path, 0);
        assert.notOk(files[path] != null);
        assert.isString(html);
        if (html === '') {
          html = '<html></html>';
        }
        node = File.Element.fromHTML(html);
        clear(node);
        return File.fromElement(path, node);
      };
    })();

    File.fromElement = function(path, node) {
      var file;
      assert.isString(path);
      assert.notLengthOf(path, 0);
      assert.instanceOf(node, File.Element);
      assert.notOk(files[path] != null);
      return file = new File(path, node);
    };

    File.fromJSON = function(json) {
      var file;
      if (typeof json === 'string') {
        json = utils.tryFunction(JSON.parse, null, [json], json);
      }
      assert.isArray(json);
      if (file = files[json[JSON_PATH]]) {
        return file;
      }
      file = File.JSON_CTORS[json[0]]._fromJSON(json);
      assert.notOk(files[file.path] != null);
      files[file.path] = file;
      return file;
    };

    File._fromJSON = (function() {
      var parseArray, parseObject;
      parseObject = function(file, obj, target) {
        var key, val;
        for (key in obj) {
          val = obj[key];
          target[key] = File.JSON_CTORS[val[0]]._fromJSON(file, val);
        }
      };
      parseArray = function(file, arr, target) {
        var val, _i, _len;
        for (_i = 0, _len = arr.length; _i < _len; _i++) {
          val = arr[_i];
          target.push(File.JSON_CTORS[val[0]]._fromJSON(file, val));
        }
      };
      return function(arr, obj) {
        var id, node, path, _ref;
        if (!obj) {
          node = File.Element.fromJSON(arr[JSON_NODE]);
          obj = new File(arr[JSON_PATH], node);
        }
        if (arr[JSON_TARGET_NODE]) {
          obj.targetNode = node.getChildByAccessPath(arr[JSON_TARGET_NODE]);
        }
        utils.merge(obj.fragments, arr[JSON_FRAGMENTS]);
        parseArray(obj, arr[JSON_ATTR_CHANGES], obj.attrChanges);
        parseArray(obj, arr[JSON_INPUTS], obj.inputs);
        parseArray(obj, arr[JSON_CONDITIONS], obj.conditions);
        parseArray(obj, arr[JSON_ITERATORS], obj.iterators);
        parseArray(obj, arr[JSON_USES], obj.uses);
        _ref = arr[JSON_IDS];
        for (id in _ref) {
          path = _ref[id];
          obj.ids[id] = obj.node.getChildByAccessPath(path);
        }
        parseObject(obj, arr[JSON_FUNCS], obj.funcs);
        parseArray(obj, arr[JSON_ATTRS_TO_SET], obj.attrsToSet);
        //<development>;
        parseArray(obj, arr[JSON_LOGS], obj.logs);
        //</development>;
        parseArray(obj, arr[JSON_STYLES], obj.styles);
        return obj;
      };
    })();

    File.parse = (function() {
      var attrChanges, attrSetting, attrs, conditions, fragments, funcs, ids, iterators, logs, rules, storage, target, uses;
      if (!utils.isNode) {
        return function(file) {
          throw new Error("Document.parse() is available only on the server");
        };
      }
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
      return function(file) {
        assert.instanceOf(file, File);
        assert.notOk(files[file.path] != null);
        files[file.path] = file;
        File.onBeforeParse.emit(file);
        rules(file);
        fragments(file);
        attrs(file);
        iterators(file);
        attrChanges(file);
        target(file);
        uses(file);
        storage(file);
        conditions(file);
        ids(file);
        funcs(file);
        attrSetting(file);
        //<development>;
        logs(file);
        //</development>;
        return File.onParse.emit(file);
      };
    })();

    File.factory = function(path) {
      var file, r;
      if (!files.hasOwnProperty(path)) {
        File.onError.emit(path);
      }
      assert.isString(path);
      assert.ok(files[path] != null);
      if (r = getFromPool(path)) {
        return r;
      }
      file = files[path].clone();
      File.onCreate.emit(file);
      return file;
    };

    function File(path, node) {
      this.path = path;
      this.node = node;
      assert.isString(path);
      assert.notLengthOf(path, 0);
      assert.instanceOf(node, File.Element);
      File.__super__.constructor.call(this);
      this.isClone = false;
      this.uid = utils.uid();
      this.isRendered = false;
      this.readyToUse = true;
      this.targetNode = null;
      this.parent = null;
      this.storage = null;
      this.source = null;
      this.parentUse = null;
      this.fragments = {};
      this.attrChanges = [];
      this.inputs = [];
      this.conditions = [];
      this.iterators = [];
      this.uses = [];
      this.ids = {};
      this.funcs = {};
      this.attrsToSet = [];
      this.logs = [];
      this.styles = [];
      //<development>;
      if (this.constructor === File) {
        Object.preventExtensions(this);
      }
      //</development>;
    }

    File.prototype.render = function(storage, source) {
      if (!this.isClone) {
        return this.clone().render(storage, source);
      } else {
        return this._render(storage, source);
      }
    };

    File.prototype._render = (function() {
      var renderTarget;
      renderTarget = require('./file/render/parse/target')(File);
      return function(storage, source) {
        var condition, input, iterator, use, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref, _ref1, _ref2, _ref3, _ref4;
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
        _ref = this.inputs;
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          input = _ref[i];
          input.render();
        }
        _ref1 = this.uses;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          use = _ref1[_j];
          if (!use.isRendered) {
            use.render();
          }
        }
        _ref2 = this.iterators;
        for (i = _k = 0, _len2 = _ref2.length; _k < _len2; i = ++_k) {
          iterator = _ref2[i];
          iterator.render();
        }
        _ref3 = this.conditions;
        for (i = _l = 0, _len3 = _ref3.length; _l < _len3; i = ++_l) {
          condition = _ref3[i];
          condition.render();
        }
        renderTarget(this, source);
        //<development>;
        _ref4 = this.logs;
        for (_m = 0, _len4 = _ref4.length; _m < _len4; _m++) {
          log = _ref4[_m];
          log.render();
        }
        //</development>;
        this.isRendered = true;
        File.onRender.emit(this);
        return this;
      };
    })();

    File.prototype.revert = (function() {
      var target;
      target = require('./file/render/revert/target')(File);
      return function() {
        var input, iterator, use, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3;
        assert.ok(this.isRendered);
        this.isRendered = false;
        File.onBeforeRevert.emit(this);
        if ((_ref = this.parentUse) != null) {
          _ref.detachUsedFragment();
        }
        if (this.inputs) {
          _ref1 = this.inputs;
          for (i = _i = 0, _len = _ref1.length; _i < _len; i = ++_i) {
            input = _ref1[i];
            input.revert();
          }
        }
        if (this.uses) {
          _ref2 = this.uses;
          for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
            use = _ref2[_j];
            use.revert();
          }
        }
        if (this.iterators) {
          _ref3 = this.iterators;
          for (i = _k = 0, _len2 = _ref3.length; _k < _len2; i = ++_k) {
            iterator = _ref3[i];
            iterator.revert();
          }
        }
        target(this, this.source);
        this.storage = null;
        this.source = null;
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
        log.warn("'" + this.path + "' view doesn't have '" + useName + "' neft:use");
      }
      return this;
    };

    Emitter.createSignal(File, 'onReplaceByUse');

    File.prototype.clone = function() {
      var r;
      if (r = getFromPool(this.path)) {
        return r;
      } else {
        return this._clone();
      }
    };

    File.prototype._clone = function() {
      var attrChange, attrsToSet, clone, condition, func, id, input, iterator, name, node, targetNode, use, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _len5, _len6, _m, _n, _o, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8;
      clone = new File(this.path, this.node.cloneDeep());
      clone.isClone = true;
      clone.fragments = this.fragments;
      if (this.targetNode) {
        targetNode = this.node.getCopiedElement(this.targetNode, clone.node);
      }
      _ref = this.attrChanges;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        attrChange = _ref[_i];
        clone.attrChanges.push(attrChange.clone(this, clone));
      }
      _ref1 = this.inputs;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        input = _ref1[_j];
        clone.inputs.push(input.clone(this, clone));
      }
      _ref2 = this.conditions;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        condition = _ref2[_k];
        clone.conditions.push(condition.clone(this, clone));
      }
      _ref3 = this.iterators;
      for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
        iterator = _ref3[_l];
        clone.iterators.push(iterator.clone(this, clone));
      }
      _ref4 = this.uses;
      for (_m = 0, _len4 = _ref4.length; _m < _len4; _m++) {
        use = _ref4[_m];
        clone.uses.push(use.clone(this, clone));
      }
      _ref5 = this.ids;
      for (id in _ref5) {
        node = _ref5[id];
        clone.ids[id] = this.node.getCopiedElement(node, clone.node);
      }
      _ref6 = this.funcs;
      for (name in _ref6) {
        func = _ref6[name];
        clone.funcs[name] = File.Func.bindFuncIntoGlobal(func, clone);
      }
      _ref7 = this.attrsToSet;
      for (_n = 0, _len5 = _ref7.length; _n < _len5; _n++) {
        attrsToSet = _ref7[_n];
        clone.attrsToSet.push(attrsToSet.clone(this, clone));
      }
      _ref8 = this.logs;
      for (_o = 0, _len6 = _ref8.length; _o < _len6; _o++) {
        log = _ref8[_o];
        clone.logs.push(log.clone(this, clone));
      }
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

    File.prototype.toJSON = (function() {
      var callToJSON;
      callToJSON = function(elem) {
        return elem.toJSON();
      };
      return function(key, arr) {
        var id, ids, node, _ref;
        if (!arr) {
          arr = new Array(JSON_ARGS_LENGTH);
          arr[0] = JSON_CTOR_ID;
        }
        arr[JSON_PATH] = this.path;
        arr[JSON_NODE] = this.node.toJSON();
        if (this.targetNode) {
          arr[JSON_TARGET_NODE] = this.targetNode.getAccessPath(this.node);
        }
        arr[JSON_FRAGMENTS] = this.fragments;
        arr[JSON_ATTR_CHANGES] = this.attrChanges.map(callToJSON);
        arr[JSON_INPUTS] = this.inputs.map(callToJSON);
        arr[JSON_CONDITIONS] = this.conditions.map(callToJSON);
        arr[JSON_ITERATORS] = this.iterators.map(callToJSON);
        arr[JSON_USES] = this.uses.map(callToJSON);
        ids = arr[JSON_IDS] = {};
        _ref = this.ids;
        for (id in _ref) {
          node = _ref[id];
          ids[id] = node.getAccessPath(this.node);
        }
        arr[JSON_FUNCS] = this.funcs;
        arr[JSON_ATTRS_TO_SET] = this.attrsToSet;
        //<development>;
        arr[JSON_LOGS] = this.logs.map(callToJSON);
        //</development>;
        //;
        arr[JSON_STYLES] = this.styles.map(callToJSON);
        return arr;
      };
    })();

    return File;

  })(Emitter);

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
})();modules['../networking/impl/ios/response.coffee'] = (function(){
var module = {exports: modules["../networking/impl/ios/response.coffee"]};
var require = getModule.bind(null, {"log":"../log/index.coffee.md","utils":"../utils/index.coffee.md","document":"../document/index.coffee.md","renderer":"../renderer/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Document, Renderer, log, utils;

  log = require('log');

  utils = require('utils');

  Document = require('document');

  Renderer = require('renderer');

  log = log.scope('Networking');

  module.exports = function(Networking) {
    var showAsStyles;
    showAsStyles = function(data) {
      var hasItems, style, styles, _base, _i, _len;
      if (!(data instanceof Document)) {
        return false;
      }
      styles = data.styles;
      if (!(styles != null ? styles.length : void 0)) {
        log.warn("No `neft:style` found in main view");
        return false;
      }
      Renderer.window.document.node = data.node;
      hasItems = false;
      for (_i = 0, _len = styles.length; _i < _len; _i++) {
        style = styles[_i];
        if (style.item) {
          hasItems = true;
          if ((_base = style.item).parent == null) {
            _base.parent = Renderer.window;
          }
          if (style.isScope) {
            style.item.document.onShow.emit();
          }
        }
      }
      return hasItems;
    };
    return {
      send: function(res, data, callback) {
        showAsStyles(data);
        return callback();
      },
      setHeader: function() {},
      redirect: function(res, status, uri, callback) {
        networking.createLocalRequest({
          method: Networking.Request.GET,
          type: Networking.Request.HTML_TYPE,
          uri: uri
        });
        return callback();
      }
    };
  };

}).call(this);


return module.exports;
})();modules['../networking/uri.coffee.md'] = (function(){
var module = {exports: modules["../networking/uri.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","dict":"../dict/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var Dict, QUERY_ASSIGNMENT, QUERY_SEPARATOR, assert, isArray, parseQuery, utils;

  utils = require('utils');

  assert = require('assert');

  Dict = require('dict');

  isArray = Array.isArray;

  assert = assert.scope('Networking.Uri');

  QUERY_SEPARATOR = '&';

  QUERY_ASSIGNMENT = '=';

  parseQuery = function(query) {
    var arr, assignmentIndex, name, param, result, resultVal, val, _i, _len;
    result = {};
    arr = query.split(QUERY_SEPARATOR);
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      param = arr[_i];
      assignmentIndex = param.indexOf(QUERY_ASSIGNMENT);
      if (assignmentIndex !== -1) {
        name = param.slice(0, assignmentIndex);
        val = param.slice(assignmentIndex + 1);
      } else {
        name = param;
        val = '';
      }
      resultVal = result[name];
      if (resultVal === void 0) {
        result[name] = val;
      } else if (isArray(resultVal)) {
        resultVal.push(val);
      } else {
        result[name] = [resultVal, val];
      }
    }
    return result;
  };

  module.exports = function(Networking) {
    var Uri;
    return Uri = (function() {
      Uri.URI_TRIM_RE = /^\/?(.*?)\/?$/;

      Uri.NAMES_RE = /{([a-zA-Z0-9_$]+)\*?}/g;

      function Uri(uri) {
        var authIndex, exec, hashIndex, hostIndex, names, protocolIndex, queryString, re, searchIndex;
        assert.isString(uri, 'ctor uri argument ...');
        uri = uri.trim();
        utils.defineProperty(this, '_uri', null, uri);
        uri = Uri.URI_TRIM_RE.exec(uri)[1];
        if (Uri.NAMES_RE.test(uri) || uri.indexOf('*') !== -1) {
          Uri.NAMES_RE.lastIndex = 0;
          this.params = {};
          names = [];
          while ((exec = Uri.NAMES_RE.exec(uri)) != null) {
            names.push(exec[1]);
            this.params[exec[1]] = null;
          }
          Object.preventExtensions(this.params);
          re = uri;
          re = re.replace(/(\?)/g, '\\$1');
          re = re.replace(/{?([a-zA-Z0-9_$]+)?\*}?/g, "(.*?)");
          re = re.replace(Uri.NAMES_RE, "([^/]+)");
          re = new RegExp("^\/?" + re + "\/?$");
        } else {
          this.params = null;
          names = null;
          re = uri;
          re = re.replace(/(\?)/g, '\\$1');
          re = new RegExp("^\/?" + re + "\/?$");
        }
        utils.defineProperty(this, '_names', null, names);
        utils.defineProperty(this, '_re', null, re);
        hashIndex = uri.lastIndexOf('#');
        if (hashIndex !== -1) {
          this.hash = uri.slice(hashIndex + 1);
          uri = uri.slice(0, hashIndex);
        } else {
          this.hash = '';
        }
        searchIndex = uri.indexOf('?');
        if (searchIndex !== -1) {
          queryString = uri.slice(searchIndex + 1);
          uri = uri.slice(0, searchIndex);
          this.query = parseQuery(queryString);
        } else {
          this.query = {};
        }
        protocolIndex = uri.indexOf(':');
        if (protocolIndex !== -1 && uri.slice(0, protocolIndex).indexOf('/') === -1) {
          this.protocol = uri.slice(0, protocolIndex);
          uri = uri.slice(protocolIndex + 1);
          while (uri[0] === '/') {
            uri = uri.slice(1);
          }
        } else {
          this.protocol = '';
        }
        authIndex = uri.indexOf('@');
        if (authIndex !== -1 && uri.slice(0, authIndex).indexOf('/') === -1) {
          this.auth = uri.slice(0, authIndex);
          uri = uri.slice(authIndex + 1);
        } else {
          this.auth = '';
        }
        hostIndex = uri.indexOf('/');
        if (hostIndex !== -1 && uri.slice(0, hostIndex).indexOf('.') !== -1) {
          this.host = uri.slice(0, hostIndex);
          uri = uri.slice(hostIndex + 1);
        } else {
          this.host = '';
        }
        this.path = "/" + uri;
        Object.freeze(this);
      }

      Uri.prototype.test = function(uri) {
        return this._re.test(uri);
      };

      Uri.prototype.match = function(uri) {
        var exec, i, name, val, _i, _len, _ref;
        assert.ok(this.test(uri));
        if (this._names != null) {
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
        }
        return this.params;
      };

      Uri.prototype.toString = function(params) {
        var i;
        if ((params != null) && (this._re != null)) {
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","schema":"../schema/index.coffee.md"});
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
        if (!this.uri.test(req.uri.path)) {
          return next();
        }
        params = req.params = this.uri.match(req.uri.path);
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
                if (utils.isQt) {
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","signal":"../signal/index.coffee.md"});
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
        var uid;
        assert.isPlainObject(opts, 'ctor options argument ...');
        if (opts.uid != null) {
          assert.isString(opts.uid);
        }
        if (opts.method != null) {
          assert.ok(utils.has(Request.METHODS, opts.method));
        }
        if (!(opts.uri instanceof Networking.Uri)) {
          assert.isString(opts.uri, 'ctor options.uri argument ...');
        }
        Request.__super__.constructor.call(this);
        if (opts.type != null) {
          assert.ok(utils.has(Request.TYPES, opts.type), 'ctor options.type argument ...');
          this.type = opts.type;
        }
        utils.defineProperty(this, 'type', utils.ENUMERABLE, this.type);
        this.data = opts.data, this.headers = opts.headers, this.cookies = opts.cookies;
        if (opts.method != null) {
          this.method = opts.method;
        }
        this.headers || (this.headers = {});
        this.cookies || (this.cookies = {});
        if (typeof opts.uri === 'string') {
          this.uri = new Networking.Uri(opts.uri);
        } else {
          this.uri = opts.uri;
        }
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

      Request.prototype.uri = null;

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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","./response/error.coffee.md":"../networking/response/error.coffee.md"});
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","list":"../list/index.coffee.md","./impl":"../networking/impl.coffee","./uri.coffee.md":"../networking/uri.coffee.md","./handler.coffee.md":"../networking/handler.coffee.md","./request.coffee.md":"../networking/request.coffee.md","./response.coffee.md":"../networking/response.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var List, Networking, assert, log, signal, utils,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  utils = require('utils');

  signal = require('signal');

  assert = require('assert');

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
      opts.uri = opts.uri ? opts.uri + '' : '';
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
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","schema":"../schema/index.coffee.md","networking":"../networking/index.coffee.md","document":"../document/index.coffee.md","dict":"../dict/index.coffee.md"});
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
        if (viewName !== tmplName && (tmpl = app.views[tmplName])) {
          tmplView = Route.prototype.getTemplateView.call(this, tmplName);
          tmplView.use(useName, null);
        }
        if (view = app.views[viewName]) {
          r = view.render(this);
        }
        if (tmplView) {
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
})();modules['package.json'] = (function(){
var module = {exports: modules["package.json"]};
var require = getModule.bind(null, {});
var exports = module.exports;

module.exports = {
  "private": true,
  "name": "app",
  "version": "0.8.22",
  "description": "Neft.io main application",
  "license": "Apache 2.0",
  "homepage": "http://neft.io",
  "repository": {
    "type": "git",
    "url": "https://github.com/Neft-io/app.git"
  },
  "bugs": "https://github.com/Neft-io/app/issues",
  "config": {
    "title": "Neft.io Application",
    "protocol": "http",
    "port": 3000,
    "host": "localhost",
    "language": "en",
    "type": "app"
  }
}
;

return module.exports;
})();modules['../native/index.coffee.md'] = (function(){
var module = {exports: modules["../native/index.coffee.md"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","log":"../log/index.coffee.md","./actions":"../native/actions.coffee","./bridge":"../native/bridge.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var CALL_FUNCTION, CALL_FUNCTION_WITH_CALLBACK, EVENT_BOOLEAN_TYPE, EVENT_FLOAT_TYPE, EVENT_NULL_TYPE, EVENT_STRING_TYPE, actions, assert, bridge, i, listeners, log, pushPending, sendData, _ref;

  assert = require('assert');

  log = require('log');

  actions = require('./actions');

  bridge = require('./bridge');

  _ref = actions.out, CALL_FUNCTION = _ref.CALL_FUNCTION, CALL_FUNCTION_WITH_CALLBACK = _ref.CALL_FUNCTION_WITH_CALLBACK;

  i = 0;

  EVENT_NULL_TYPE = i++;

  EVENT_BOOLEAN_TYPE = i++;

  EVENT_FLOAT_TYPE = i++;

  EVENT_STRING_TYPE = i++;

  listeners = Object.create(null);

  bridge.addActionListener(actions["in"].EVENT, (function(args) {
    return function(reader) {
      var argsLen, arr, func, name, _i, _j, _len;
      name = reader.getString();
      argsLen = reader.getInteger();
      for (i = _i = 0; _i < argsLen; i = _i += 1) {
        switch (reader.getInteger()) {
          case EVENT_NULL_TYPE:
            args[i] = null;
            break;
          case EVENT_BOOLEAN_TYPE:
            args[i] = reader.getBoolean();
            break;
          case EVENT_FLOAT_TYPE:
            args[i] = reader.getFloat();
            break;
          case EVENT_STRING_TYPE:
            args[i] = reader.getString();
        }
      }
      if (arr = listeners[name]) {
        for (_j = 0, _len = arr.length; _j < _len; _j++) {
          func = arr[_j];
          func.apply(null, args);
        }
      } else {
        log.warn("No listeners added for the native event '" + name + "'");
      }
    };
  })([]));

  pushPending = false;

  sendData = function() {
    pushPending = false;
    bridge.sendData();
  };

  exports.callFunction = function(name, arg1, arg2, arg3) {
    var arg, argsLen, _i;
    assert.isString(name);
    assert.notLengthOf(name, 0);
    bridge.pushAction(CALL_FUNCTION);
    bridge.pushString(name);
    argsLen = arguments.length - 1;
    bridge.pushInteger(argsLen);
    for (i = _i = 0; 0 <= argsLen ? _i < argsLen : _i > argsLen; i = 0 <= argsLen ? ++_i : --_i) {
      arg = arguments[i + 1];
      switch (typeof arg) {
        case 'boolean':
          bridge.pushInteger(EVENT_BOOLEAN_TYPE);
          bridge.pushBoolean(arg);
          break;
        case 'number':
          assert.isFloat(arg, "NaN can't be passed to the native function");
          bridge.pushInteger(EVENT_FLOAT_TYPE);
          bridge.pushFloat(arg);
          break;
        case 'string':
          bridge.pushInteger(EVENT_STRING_TYPE);
          bridge.pushString(arg);
          break;
        default:
          if (arg != null) {
            log.warn("Native function can be called with a boolean, " + ("float or a string, but '" + arg + "' given"));
          }
          bridge.pushInteger(EVENT_NULL_TYPE);
      }
    }
    if (!pushPending) {
      pushPending = true;
      setImmediate(sendData);
    }
  };

  exports.on = function(name, listener) {
    var eventListeners;
    assert.isString(name);
    assert.notLengthOf(name, 0);
    assert.isFunction(listener);
    eventListeners = listeners[name] != null ? listeners[name] : listeners[name] = [];
    eventListeners.push(listener);
  };

}).call(this);


return module.exports;
})();modules['../styles/file/styles.coffee'] = (function(){
var module = {exports: modules["../styles/file/styles.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md"});
var exports = module.exports;

(function() {
  'use strict';
  var assert, utils;

  utils = require('utils');

  assert = require('assert');

  module.exports = function(File) {
    var renderStyles, revertStyles;
    renderStyles = (function() {
      var pending, queue, render, renderAll;
      pending = false;
      queue = [];
      render = function(arr) {
        var style, _i, _j, _len, _len1;
        for (_i = 0, _len = arr.length; _i < _len; _i++) {
          style = arr[_i];
          style.render();
        }
        for (_j = 0, _len1 = arr.length; _j < _len1; _j++) {
          style = arr[_j];
          render(style.children);
        }
      };
      renderAll = function() {
        var arr, length, _i, _len;
        pending = false;
        length = queue.length;
        for (_i = 0, _len = queue.length; _i < _len; _i++) {
          arr = queue[_i];
          render(arr);
        }
        assert.ok(queue.length === length);
        utils.clear(queue);
      };
      return function(arr) {
        queue.push(arr);
        if (!pending) {
          setImmediate(renderAll);
          pending = true;
        }
      };
    })();
    File.onBeforeRender(function(file) {
      renderStyles(file.styles);
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
      revertStyles(file.styles);
    });
    return File.prototype._clone = (function(_super) {
      return function() {
        var clone, i, style, _i, _len, _ref;
        clone = _super.call(this);
        _ref = this.styles;
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          style = _ref[i];
          clone.styles.push(style.clone(this, clone));
        }
        return clone;
      };
    })(File.prototype._clone);
  };

}).call(this);


return module.exports;
})();modules['../styles/style.coffee'] = (function(){
var module = {exports: modules["../styles/style.coffee"]};
var require = getModule.bind(null, {"/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","utils":"../utils/index.coffee.md","signal":"../signal/index.coffee.md","log":"../log/index.coffee.md","renderer":"../renderer/index.coffee.md"});
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
      var JSON_ARGS_LENGTH, JSON_ATTRS, JSON_CHILDREN, JSON_CTOR_ID, JSON_NODE, Tag, attrsChangeListener, emptyComponent, findItemIndex, findItemWithParent, getter, globalHideDelay, globalShowDelay, hideEvent, i, listenTextRec, opts, queries, setter, showEvent, styles, stylesToRender, stylesToRevert, textChangeListener, updateWhenPossible, windowStyle;

      windowStyle = data.windowStyle, styles = data.styles, queries = data.queries;

      Tag = File.Element.Tag;

      Style.__name__ = 'Style';

      Style.__path__ = 'File.Style';

      JSON_CTOR_ID = Style.JSON_CTOR_ID = File.JSON_CTORS.push(Style) - 1;

      i = 1;

      JSON_NODE = i++;

      JSON_ATTRS = i++;

      JSON_CHILDREN = i++;

      JSON_ARGS_LENGTH = Style.JSON_ARGS_LENGTH = i;

      Style.extendDocumentByStyles = (function() {
        var forNode, getStyleAttrs;
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
        forNode = function(file, node, parentStyle) {
          var attr, child, style, _i, _len, _ref;
          if (attr = node.getAttr('neft:style')) {
            style = new Style;
            style.file = file;
            style.node = node;
            style.parent = parentStyle;
            style.attrs = getStyleAttrs(node);
            if (parentStyle) {
              parentStyle.children.push(style);
            } else {
              file.styles.push(style);
            }
            parentStyle = style;
          }
          _ref = node.children;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            if (child instanceof File.Element.Tag) {
              forNode(file, child, parentStyle);
            }
          }
        };
        return function(file) {
          var elem, node, nodes, _i, _j, _len, _len1;
          assert.instanceOf(file, File);
          for (_i = 0, _len = queries.length; _i < _len; _i++) {
            elem = queries[_i];
            nodes = file.node.queryAll(elem.query);
            for (_j = 0, _len1 = nodes.length; _j < _len1; _j++) {
              node = nodes[_j];
              if (!node.hasAttr('neft:style')) {
                node.setAttr('neft:style', elem.style);
              }
            }
          }
          forNode(file, file.node, null);
          return file;
        };
      })();

      Style._fromJSON = function(file, arr, obj) {
        var child, cloneChild, _i, _len, _ref;
        if (!obj) {
          obj = new Style;
        }
        obj.file = file;
        obj.node = file.node.getChildByAccessPath(arr[JSON_NODE]);
        obj.attrs = arr[JSON_ATTRS];
        _ref = arr[JSON_CHILDREN];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          cloneChild = Style._fromJSON(file, child);
          cloneChild.parent = obj;
          obj.children.push(cloneChild);
        }
        return obj;
      };

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
        if (name === 'href' && this.isLink()) {
          if ((_ref = this.item) != null) {
            _ref.linkUri = this.getLinkUri();
          }
        }
        if ((_ref1 = this.attrs) != null ? _ref1[name] : void 0) {
          this.setAttr(name, this.node._attrs[name], oldValue);
        }
      };

      function Style() {
        this.file = null;
        this.node = null;
        this.attrs = null;
        this.parent = null;
        this.isScope = false;
        this.isAutoParent = true;
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
        this.attrsQueue = [];
        this.attrsClass = null;
        this.isRendered = false;
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
            setImmediate(sync);
            pending = true;
          }
          style.waiting = true;
        };
      })();

      Style.prototype.render = function() {
        if (this.waiting) {
          return;
        }
        assert.notOk(this.isRendered);
        if (this.isAutoParent && !this.getVisibility()) {
          return;
        }
        if (!this.item) {
          this.reloadItem();
        }
        if (!this.item) {
          return;
        }
        this.isRendered = true;
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
        var attr, attrsQueue, _i, _len, _ref;
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
        if (this.waiting || !this.isRendered) {
          return;
        }
        this.isRendered = false;
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
      };

      Style.prototype.revertItem = function() {
        var itemDocumentNode;
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
          href = node.getAttr('href');
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

      Style.prototype.getVisibility = function() {
        var tmpNode, visible;
        visible = true;
        tmpNode = this.node;
        while (true) {
          visible = tmpNode._visible;
          tmpNode = tmpNode._parent;
          if (!visible || !tmpNode || tmpNode._style) {
            break;
          }
        }
        return visible;
      };

      Style.prototype.updateVisibility = function() {
        var visible;
        if (this.waiting) {
          return;
        }
        visible = this.getVisibility();
        if (visible && !this.isRendered && this.file.isRendered) {
          this.render();
        }
        if (this.item) {
          this.item.visible = visible;
        }
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
          var internalProp, obj, prop, props, _i, _ref;
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
        var classes, index, item, name, newClasses, oldClasses, prevIndex, _i, _j, _len, _len1;
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
        return this.node.name === 'a' && (this.node.getAttr('href') != null) && ((_ref = this.node.getAttr('href')) != null ? _ref[0] : void 0) !== '#';
      };

      Style.prototype.getLinkUri = function() {
        var uri;
        uri = this.node.getAttr('href') + '';
        //<development>;
        if (!/^([a-z]+:|\/|\$\{)/.test(uri)) {
          log.warn("Relative link found `" + uri + "`");
        }
        //</development>;
        return uri;
      };

      Style.prototype.reloadItem = function() {
        var file, id, match, parent, parentId, style, subid, _, _ref, _ref1;
        if (this.waiting) {
          return;
        }
        if (!utils.isClient) {
          return;
        }
        assert.notOk(this.item);
        id = this.node.getAttr('neft:style');
        assert.isString(id);
        this.isScope = /^(styles|renderer)\:/.test(id);
        this.item = null;
        this.scope = null;
        this.isAutoParent = false;
        if (id instanceof Renderer.Item) {
          this.item = id;
        } else if (this.isScope) {
          this.isAutoParent = true;
          if (/^styles\:/.test(id)) {
            match = /^styles:(.+?)(?:\:(.+?))?(?:\:(.+?))?$/.exec(id);
            _ = match[0], file = match[1], style = match[2], subid = match[3];
            if (style == null) {
              style = '_main';
            }
            if (subid) {
              parentId = "styles:" + file + ":" + style;
              parent = this.parent;
              while (true) {
                if (parent && parent.node.getAttr('neft:style') === parentId) {
                  if (!parent.scope) {
                    return;
                  }
                  this.item = parent.scope.objects[subid];
                } else if (!(parent != null ? parent.scope : void 0) && file === 'view') {
                  this.item = windowStyle.objects[subid];
                }
                if (this.item || ((!parent || !(parent = parent.parent)) && scope === windowStyle)) {
                  break;
                }
              }
              if (!this.item) {
                log.warn("Can't find `" + id + "` style item");
                return;
              }
              this.isAutoParent = !this.item.parent;
            } else {
              this.scope = (_ref = styles[file]) != null ? (_ref1 = _ref[style]) != null ? _ref1.getComponent() : void 0 : void 0;
              if (this.scope) {
                this.item = this.scope.item;
              } else {
                log.warn("Style file `" + id + "` can't be find");
                return;
              }
            }
          }
        }
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
        var tmpIndexNode, tmpSiblingItem, tmpSiblingNode, tmpSiblingTargetItem, _ref, _ref1, _ref2;
        tmpIndexNode = node;
        parent = ((_ref = parent._children) != null ? _ref._target : void 0) || parent;
        tmpSiblingNode = tmpIndexNode;
        while (tmpIndexNode) {
          while (tmpSiblingNode) {
            if (tmpSiblingNode !== node && tmpSiblingNode instanceof Tag) {
              if (((_ref1 = tmpSiblingNode._documentStyle) != null ? _ref1.parentSet : void 0) && (tmpSiblingItem = tmpSiblingNode._documentStyle.item)) {
                if (tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)) {
                  if (item !== tmpSiblingTargetItem) {
                    if (item.previousSibling !== tmpSiblingTargetItem) {
                      item.previousSibling = tmpSiblingTargetItem;
                    }
                  }
                  return;
                }
              } else if (!tmpSiblingNode._documentStyle) {
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
          if (tmpIndexNode = tmpIndexNode._parent) {
            tmpSiblingNode = tmpIndexNode._previousSibling;
            if (((_ref2 = tmpIndexNode._documentStyle) != null ? _ref2.item : void 0) === parent) {
              return;
            }
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
        var attr, attrVal, child, clone, styleAttr, _i, _len, _ref;
        clone = new Style;
        clone.file = file;
        clone.node = originalFile.node.getCopiedElement(this.node, file.node);
        clone.attrs = this.attrs;
        clone.node._documentStyle = clone;
        styleAttr = clone.node._attrs['neft:style'];
        clone.isAutoParent = !/^styles:(.+?)\:(.+?)\:(.+?)$/.test(styleAttr);
        if (this.attrs) {
          clone.attrsClass = Renderer.Class.New(emptyComponent);
          clone.attrsClass.priority = 9999;
        }
        _ref = this.children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          child = child.clone(originalFile, file);
          child.parent = clone;
          clone.children.push(child);
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

      Style.prototype.toJSON = (function() {
        var callToJSON;
        callToJSON = function(elem) {
          return elem.toJSON();
        };
        return function(key, arr) {
          if (!arr) {
            arr = new Array(JSON_ARGS_LENGTH);
            arr[0] = JSON_CTOR_ID;
          }
          arr[JSON_NODE] = this.node.getAccessPath(this.file.node);
          arr[JSON_ATTRS] = this.attrs;
          arr[JSON_CHILDREN] = this.children.map(callToJSON);
          return arr;
        };
      })();

      Tag = File.Element.Tag;

      opts = utils.CONFIGURABLE;

      getter = utils.lookupGetter(Tag.prototype, 'visible');

      setter = utils.lookupSetter(Tag.prototype, 'visible');

      utils.defineProperty(Tag.prototype, 'visible', opts, getter, (function(_super) {
        var updateVisibility;
        updateVisibility = function(node) {
          var child, hasItem, style, _i, _len, _ref;
          if (style = node._documentStyle) {
            hasItem = !!style.item;
            style.updateVisibility();
            if (hasItem && style.isAutoParent) {
              return;
            }
          }
          if (node instanceof Tag) {
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
})();modules['../styles/index.coffee'] = (function(){
var module = {exports: modules["../styles/index.coffee"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","document":"../document/index.coffee.md","./file/styles":"../styles/file/styles.coffee","./style":"../styles/style.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var ATTR_RESOURCES, Document, Style, styles, utils;

  utils = require('utils');

  Document = require('document');

  styles = require('./file/styles');

  Style = require('./style');

  ATTR_RESOURCES = module.exports.ATTR_RESOURCES = {
    img: ['src']
  };

  module.exports = function(data) {
    var attr, attrs, replacements, resources, tagName, _i, _len, _super;
    styles(Document);
    Document.Style = Style(Document, data);
    resources = data.resources;
    replacements = Document.Element.Tag.DEFAULT_STRINGIFY_REPLACEMENTS;
    for (tagName in ATTR_RESOURCES) {
      attrs = ATTR_RESOURCES[tagName];
      for (_i = 0, _len = attrs.length; _i < _len; _i++) {
        attr = attrs[_i];
        _super = replacements[tagName] || utils.NOP;
        replacements[tagName] = (function(_super, attr) {
          return function(elem) {
            var attrVal, rsc;
            elem = _super(elem) || elem;
            attrVal = elem.getAttr(attr);
            if (attrVal && (rsc = resources.resolve(attrVal))) {
              elem.setAttr(attr, rsc);
            }
            return elem;
          };
        })(_super, attr);
      }
    }
  };

}).call(this);


return module.exports;
})();modules['index.coffee.md'] = (function(){
var module = {exports: modules["index.coffee.md"]};
var require = getModule.bind(null, {"utils":"../utils/index.coffee.md","log":"../log/index.coffee.md","signal":"../signal/index.coffee.md","db":"../db/index.coffee.md","/Users/krystian/Projects/Neft/app/node_modules/assert":"../assert/index.coffee.md","assert":"../assert/index.coffee.md","schema":"../schema/index.coffee.md","networking":"../networking/index.coffee.md","document":"../document/index.coffee.md","renderer":"../renderer/index.coffee.md","resources":"../resources/index.coffee.md","dict":"../dict/index.coffee.md","./route":"route.coffee.md","./package.json":"package.json","list":"../list/index.coffee.md","native":"../native/index.coffee.md","styles":"../styles/index.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var AppRoute, Dict, Document, MODULES, Networking, Renderer, Resources, Schema, assert, bootstrapRoute, db, exports, log, name, pkg, signal, utils, _i, _len;

  utils = require('utils');

  log = require('log');

  signal = require('signal');

  db = require('db');

  assert = require('assert');

  Schema = require('schema');

  Networking = require('networking');

  Document = require('document');

  Renderer = require('renderer');

  Resources = require('resources');

  Dict = require('dict');

  AppRoute = require('./route');

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
    assert.ok(utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game/text, but '" + config.type + "' got.");
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
          style.file._init({
            app: app,
            view: null
          });
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
        if (style.name !== 'view') {
          style.file._init(stylesInitObject);
        }
        app.styles[style.name] = style.file;
      }
    }
    require('styles')({
      windowStyle: windowStyle,
      styles: app.styles,
      queries: opts.styleQueries,
      resources: app.resources
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
          app.views[view.name] = Document.fromJSON(view.file);
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

  MODULES = ['utils', 'signal', 'dict', 'list', 'log', 'Resources', 'native', 'Renderer', 'Networking', 'Schema', 'Document', 'Styles', 'assert', 'db'];

  for (_i = 0, _len = MODULES.length; _i < _len; _i++) {
    name = MODULES[_i];
    exports[name] = exports[name.toLowerCase()] = require(name.toLowerCase());
  }

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
