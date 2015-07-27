(function(){
'use strict';

// list of modules with empty objects
var modules = {"parser.coffee":{},"index.coffee":{}};

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
modules['parser.coffee'] = (function(){
var module = {exports: modules["parser.coffee"]};
var require = getModule.bind(null, {});
var exports = module.exports;

(function() {
  'use strict';
  var grammar;

  grammar = '{\n' + '	var RESERVED_ATTRIBUTES = {id: true};\n' + '	var ids = {};\n' + '\n' + '	function forEachType(arr, type, callback){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			if (arr[i].type === type) callback(arr[i], i, arr);\n' + '		}\n' + '	}\n' + '\n' + '	function flattenArray(arr){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			if (!Array.isArray(arr[i]))\n' + '				continue;\n' + '\n' + '			var child = arr[i];\n' + '\n' + '			child.unshift(i, 1);\n' + '			arr.splice.apply(arr, child);\n' + '\n' + '			i--;\n' + '			n += child.length - 3;\n' + '		}\n' + '\n' + '		return arr;\n' + '	}\n' + '\n' + '	function extractArray(arr, step){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			arr[i] = arr[i][step];\n' + '		}\n' + '\n' + '		return arr;\n' + '	}\n' + '\n' + '	function uid(){\n' + '		return Math.random().toString(16).slice(2);\n' + '	}\n' + '\n' + '	function setParentRec(arr, val){\n' + '		for (var i = 0; i < arr.length; i++){\n' + '			var elem = arr[i];\n' + '			if (elem.type && !elem.parent){\n' + '				elem.parent = val;\n' + '				if (elem.body){\n' + '					setParentRec(elem.body, val);\n' + '				} else if (Array.isArray(elem.value)){\n' + '					setParentRec(elem.value, val);\n' + '				}\n' + '			}\n' + '		}\n' + '	}\n' + '}\n' + '\n' + 'Start\n' + '	= (Code / MainType)*\n' + '\n' + '/* HELPERS */\n' + '\n' + 'SourceCharacter\n' + '	= .\n' + '\n' + 'Letter\n' + '	= [a-zA-Z_$]\n' + '\n' + 'Word\n' + '	= $[a-zA-Z0-9_$]+\n' + '\n' + 'Variable\n' + '	= $(Letter Word?)\n' + '\n' + 'Reference\n' + '	= $(Variable ("." Variable)+)\n' + '\n' + 'LineTerminator\n' + '	= [\\n\\r\\u2028\\u2029]\n' + '\n' + 'LineTerminatorSequence "end of line"\n' + '	= "\\n"\n' + '	/ "\\r\\n"\n' + '	/ "\\r"\n' + '	/ "\\u2028"\n' + '	/ "\\u2029"\n' + '\n' + 'Zs = [\\u0020\\u00A0\\u1680\\u2000-\\u200A\\u202F\\u205F\\u3000]\n' + 'WhiteSpace "whitespace"\n' + '	= "\\t"\n' + '	/ "\\v"\n' + '	/ "\\f"\n' + '	/ " "\n' + '	/ "\\u00A0"\n' + '	/ "\\uFEFF"\n' + '	/ Zs\n' + '\n' + 'HexDigit\n' + '	= [0-9a-f]i\n' + '\n' + 'DecimalDigit\n' + '	= [0-9]\n' + '\n' + 'SingleEscapeCharacter\n' + '	= "\'"\n' + '	/ \'"\'\n' + '	/ "\\\\"\n' + '	/ "b"  { return "\\b";   }\n' + '	/ "f"  { return "\\f";   }\n' + '	/ "n"  { return "\\n";   }\n' + '	/ "r"  { return "\\r";   }\n' + '	/ "t"  { return "\\t";   }\n' + '	/ "v"  { return "\\x0B"; }   // IE does not recognize "\\v".\n' + '\n' + 'NonEscapeCharacter\n' + '  = !(EscapeCharacter / LineTerminator) SourceCharacter { return text(); }\n' + '\n' + 'EscapeCharacter\n' + '	= SingleEscapeCharacter\n' + '	/ DecimalDigit\n' + '	/ "x"\n' + '	/ "u"\n' + '\n' + 'Comment "comment"\n' + '	= MultiLineComment\n' + '	/ SingleLineComment\n' + '\n' + 'MultiLineComment\n' + '	= WhiteSpace* "/*" (!"*/" SourceCharacter)* "*/"\n' + '\n' + 'SingleLineComment\n' + '	= WhiteSpace* "//" (!LineTerminator SourceCharacter)*\n' + '\n' + 'StringLiteral "string"\n' + '	= \'"\' chars:$DoubleStringCharacter* \'"\' {\n' + '		return chars;\n' + '	}\n' + '	/ "\'" chars:$SingleStringCharacter* "\'" {\n' + '		return chars;\n' + '	}\n' + '\n' + 'DoubleStringCharacter\n' + '	= !(\'"\' / "\\\\" / LineTerminator) SourceCharacter { return text(); }\n' + '	/ "\\\\" sequence:EscapeSequence { return sequence; }\n' + '	/ LineContinuation\n' + '\n' + 'SingleStringCharacter\n' + '	= !("\'" / "\\\\" / LineTerminator) SourceCharacter { return text(); }\n' + '	/ "\\\\" sequence:EscapeSequence { return sequence; }\n' + '	/ LineContinuation\n' + '\n' + 'LineContinuation\n' + '  = "\\\\" LineTerminatorSequence { return ""; }\n' + '\n' + 'EscapeSequence\n' + '	= CharacterEscapeSequence\n' + '	/ "0" !DecimalDigit { return "\\0"; }\n' + '	/ HexEscapeSequence\n' + '	/ UnicodeEscapeSequence\n' + '\n' + 'CharacterEscapeSequence\n' + '	= SingleEscapeCharacter\n' + '	/ NonEscapeCharacter\n' + '\n' + 'HexEscapeSequence\n' + '	= "x" digits:$(HexDigit HexDigit) {\n' + '		return String.fromCharCode(parseInt(digits, 16));\n' + '	}\n' + '\n' + 'UnicodeEscapeSequence\n' + '	= "u" digits:$(HexDigit HexDigit HexDigit HexDigit) {\n' + '		return String.fromCharCode(parseInt(digits, 16));\n' + '	}\n' + '\n' + '__\n' + '	= (WhiteSpace / LineTerminatorSequence / Comment)*\n' + '\n' + '/* ATTRIBUTE */\n' + '\n' + 'AttributeName "attribute name"\n' + '	= name:(Reference / Variable) {\n' + '		if (RESERVED_ATTRIBUTES[name]){\n' + '			error(name+" syntax error");\n' + '		}\n' + '		return name;\n' + '	}\n' + '\n' + 'AttributeEnds\n' + '	= ";"\n' + '	/ LineTerminator\n' + '	/ Comment\n' + '\n' + 'AttributeBody\n' + '	= Type\n' + '	/ "{" d:(__ d:Declaration __ { return d })* "}" AttributeEnds { return d }\n' + '	/ "[" d:Type* "]" AttributeEnds { return d }\n' + '	/ d:$StringLiteral AttributeEnds { return d }\n' + '	/ value:(!AttributeEnds d:($StringLiteral/SourceCharacter) {return d})+ AttributeEnds {\n' + '		return value.join(\'\').trim()\n' + '	}\n' + '\n' + 'AttributeDeclaration\n' + '	= name:AttributeName ":" WhiteSpace* {return name}\n' + '\n' + 'Attribute "attribute"\n' + '	= name:AttributeDeclaration value:AttributeBody {\n' + '		return { type: \'attribute\', name: name, value: value };\n' + '	}\n' + '\n' + '/* PROPERTY */\n' + '\n' + 'PropertyToken\n' + '	= "property"\n' + '\n' + 'Property "custom property"\n' + '	= PropertyToken WhiteSpace attribute:(Attribute / (d:AttributeName AttributeEnds {return d})) {\n' + '		var name = attribute.name || attribute;\n' + '		if (name.indexOf(\'$.\') !== 0) { error(\'Properties can be created only in the \\\'$\\\' object. Use \\\'property $.\'+name+\'\\\' instead\'); }\n' + '		var obj = { type: \'property\', name: name.slice(2) };\n' + '		return typeof attribute === \'string\' ? obj : [obj, attribute];\n' + '	}\n' + '\n' + '/* SIGNAL */\n' + '\n' + 'SignalToken\n' + '	= "signal"\n' + '\n' + 'Signal "signal"\n' + '	= SignalToken WhiteSpace name:(Reference / Variable) AttributeEnds {\n' + '		if (name.indexOf(\'$.\') !== 0) { error(\'Signals can be created only in the \\\'$\\\' object. Use \\\'signal $.\'+name+\'\\\' instead\'); }\n' + '		return { type: \'signal\', name: name.slice(2) };\n' + '	}\n' + '\n' + '/* ID */\n' + '\n' + 'IdToken\n' + '	= "id"\n' + '\n' + 'Id "id declaration"\n' + '	= IdToken ":" WhiteSpace* value:Variable AttributeEnds {\n' + '		if (ids[value]){\n' + '			error("this id has been already defined");\n' + '		}\n' + '		ids[value] = true;\n' + '		return { type: \'id\', value: value };\n' + '	}\n' + '\n' + '/* FUNCTION */\n' + '\n' + 'FunctionBody\n' + '	= FunctionBodyCode (FunctionBodyCode FunctionBodyFunc)* FunctionBodyCode\n' + '\n' + 'FunctionBodyCode\n' + '	= FunctionBodyAny (StringLiteral FunctionBodyAny)* FunctionBodyAny\n' + '\n' + 'FunctionBodyAny\n' + '	= [a-zA-Z0-9_\\-+=!@#$%^&*()~\\[\\]\\\\|<>,.?/ \\t\\n;:]*\n' + '\n' + 'FunctionBodyFunc\n' + '	= "{" FunctionBody "}"\n' + '\n' + 'FunctionParams\n' + '	= "(" first:Variable? rest:(WhiteSpace* "," WhiteSpace* d:Variable { return d })* ")" {\n' + '		return flattenArray([first, rest])\n' + '	}\n' + '\n' + 'FunctionName\n' + '	= (Variable ".")* "on" Variable\n' + '\n' + 'Function "function"\n' + '	= name:$FunctionName ":" WhiteSpace* "function" WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionBody "}" AttributeEnds {\n' + '		return { type: \'function\', name: name, params: params, body: body };\n' + '	}\n' + '\n' + '/* DECLARATION */\n' + '\n' + 'Declaration\n' + '	= __ d:(Function / Id / Attribute / Property / Signal / Type) {\n' + '		return d\n' + '	}\n' + '\n' + 'Declarations\n' + '	= d:(Declaration / Code)* { return flattenArray(d) }\n' + '\n' + '/* TYPE */\n' + '\n' + 'TypeNameRest\n' + '	= "." ("/"? Variable)+\n' + '	/ "[\'" (("." / "/")? Variable)+ "\']"\n' + '	/ "[\\"" (("." / "/")? Variable)+ "\\"]"\n' + '\n' + 'TypeName "type name"\n' + '	= d:$(Variable TypeNameRest?) {\n' + '		if (d.indexOf(\'/\') !== -1 && d.indexOf(\'[\') === -1){\n' + '			return d.replace(/\\.([a-zA-Z0-9_/]+)$/, "[\'$1") + "\']";\n' + '		}\n' + '		return d;\n' + '	}\n' + '\n' + 'TypeBody\n' + '	= __ d:Declarations __ { return d }\n' + '\n' + 'Type\n' + '	= __ name:TypeName WhiteSpace* "{" body:TypeBody "}" __ {\n' + '		var obj = { type: \'object\', name: name, id: \'\', body: body };\n' + '\n' + '		forEachType(body, "id", function(elem){\n' + '			if (obj.id){\n' + '				error("item can has only one id");\n' + '			}\n' + '			obj.id = elem.value;\n' + '		});\n' + '\n' + '		setParentRec(body, obj);\n' + '\n' + '		return obj;\n' + '	}\n' + '\n' + 'MainType\n' + '	= d:Type {\n' + '		ids = {};\n' + '		return d;\n' + '	}\n' + '\n' + '/* CODE */\n' + '\n' + 'CodeBody\n' + '	= CodeBodyCode (CodeBodyCode CodeBodyFunc)* CodeBodyCode\n' + '\n' + 'CodeBodyCode\n' + '	= CodeBodyAny (StringLiteral CodeBodyAny)* CodeBodyAny\n' + '\n' + 'CodeBodyAny\n' + '	= CodeBodyAnyChar*\n' + '\n' + 'CodeBodyAnyChar\n' + '	= (!(name:TypeName WhiteSpace* "{")) [a-zA-Z0-9_\\-+=!@#$%^&*()~\\[\\]\\\\|<>,.?/ \\t\\n;:]\n' + '\n' + 'CodeBodyFunc\n' + '	= "{" CodeBody "}"\n' + '\n' + 'Code\n' + '	= d:$(d:$CodeBody &{return d.trim() ? d : undefined;}) {\n' + '		return { type: \'code\', body: d }\n' + '	}\n' + '';

  module.exports = function(file) {
    var PEG, err, fs, line, lines, msg, parser, pathUtils;
    fs = require('fs');
    pathUtils = require('path');
    PEG = require('pegjs');
    parser = PEG.buildParser(grammar, {
      optimize: 'speed'
    });
    try {
      return parser.parse(file);
    } catch (_error) {
      err = _error;
      lines = file.split('\n');
      line = err.line - 1;
      msg = '';
      if (err.line > 1) {
        msg += lines[line - 1] + "\n";
      }
      if (line !== lines.length) {
        msg += "\u001b[31m" + lines[line] + "\u001b[39m \n";
      }
      if (line < lines.length) {
        msg += lines[line + 1] + "\n";
      }
      msg += "\nLine " + err.line + ", column " + err.column + ": " + err.message + "\n";
      throw Error(msg);
    }
  };

}).call(this);


return module.exports;
})();modules['index.coffee'] = (function(){
var module = {exports: modules["index.coffee"]};
var require = getModule.bind(null, {"./parser":"parser.coffee"});
var exports = module.exports;

(function() {
  'use strict';
  var ATTRIBUTE, CODE, FUNCTION, ID, MODIFIERS_NAMES, OBJECT, PROPERTY, Renderer, SIGNAL, anchorAttributeToString, assert, bindingAttributeToString, concatArrayElements, extensions, getByType, getByTypeDeep, getByTypeRec, getEachProp, getElemByName, getIds, getItem, getObject, ids, idsKeys, isAnchor, isBinding, itemsKeys, parser, queries, repeatString, stringify, uid, utils;

  Renderer = require('renderer');

  parser = require('./parser');

  utils = require('utils');

  assert = console.assert;

  OBJECT = 'object';

  ID = 'id';

  PROPERTY = 'property';

  ATTRIBUTE = 'attribute';

  SIGNAL = 'signal';

  FUNCTION = 'function';

  CODE = 'code';

  ids = idsKeys = itemsKeys = extensions = queries = null;

  uid = function() {
    return 'c' + Math.random().toString(16).slice(2);
  };

  repeatString = function(str, amount) {
    var i, r, _i, _ref;
    r = str;
    for (i = _i = 0, _ref = amount - 1; _i < _ref; i = _i += 1) {
      r += str;
    }
    return r;
  };

  concatArrayElements = function(arrA, arrB) {
    var elem, i, _i, _len;
    assert(arrA.length === arrB.length);
    for (i = _i = 0, _len = arrA.length; _i < _len; i = ++_i) {
      elem = arrA[i];
      arrA[i] += arrB[i];
    }
    return arrA;
  };

  isAnchor = function(obj) {
    assert(obj.type === ATTRIBUTE, "isAnchor: type must be an attribute");
    return obj.name === 'anchors' || obj.name.indexOf('anchors.') === 0;
  };

  isBinding = function(obj) {
    assert(obj.type === ATTRIBUTE, "isBinding: type must be an attribute");
    try {
      eval("(function(console,module,require){return (" + obj.value + ");}).call(null,{},{},function(){})");
      return false;
    } catch (_error) {}
    return true;
  };

  getByType = function(arr, type) {
    var elem, r, _i, _len;
    r = [];
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      elem = arr[_i];
      if (elem.type === type) {
        r.push(elem);
      }
    }
    return r;
  };

  getByTypeRec = function(arr, type, r) {
    var elem, _i, _len;
    if (r == null) {
      r = [];
    }
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      elem = arr[_i];
      if (elem.type === type) {
        r.push(elem);
      }
      if (elem.body) {
        getByTypeRec(elem.body, type, r);
      }
    }
    return r;
  };

  getByTypeDeep = function(elem, type, callback) {
    var child, _i, _len, _ref, _ref1;
    if (elem.type === type) {
      callback(elem);
    }
    _ref = elem.body;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      if (child.type === type) {
        callback(child);
      }
      switch (child.type) {
        case 'object':
          getByTypeDeep(child, type, callback);
          break;
        case 'attribute':
          if (((_ref1 = child.value) != null ? _ref1.type : void 0) === 'object') {
            getByTypeDeep(child.value, type, callback);
          }
      }
    }
  };

  getEachProp = function(arr, prop) {
    var elem, r, _i, _len;
    r = [];
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      elem = arr[_i];
      r.push(elem[prop]);
    }
    return r;
  };

  getElemByName = function(arr, type, name) {
    var elem, _i, _len;
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      elem = arr[_i];
      if (elem.type === type && elem.name === name) {
        return elem;
      }
    }
  };

  MODIFIERS_NAMES = {
    __proto__: null,
    Class: true,
    Transition: true,
    Animation: true,
    PropertyAnimation: true,
    NumberAnimation: true,
    Source: true,
    FontLoader: true,
    ResourcesLoader: true,
    AmbientSound: true
  };

  getItem = function(obj) {
    while (obj) {
      if (obj.type === 'object' && !MODIFIERS_NAMES[obj.name]) {
        return obj;
      }
      obj = obj.parent;
    }
  };

  getObject = function(obj) {
    while (obj) {
      if (obj.type === 'object') {
        return obj;
      }
      obj = obj.parent;
    }
  };

  anchorAttributeToString = function(obj) {
    var anchor;
    assert(obj.type === ATTRIBUTE, "anchorAttributeToString: type must be an attribute");
    if (typeof obj.value === 'object') {
      return "{}";
    }
    anchor = obj.value.split('.');
    if (anchor[0] === 'this') {
      anchor.shift();
      anchor[0] = "this." + anchor[0];
    }
    anchor[0] = (function() {
      switch (anchor[0]) {
        case 'this.parent':
        case 'parent':
          return "'parent'";
        case 'this.children':
        case 'children':
          return "'children'";
        case 'this.nextSibling':
        case 'nextSibling':
          return "'nextSibling'";
        case 'this.previousSibling':
        case 'previousSibling':
          return "'previousSibling'";
        default:
          return "'" + anchor[0] + "'";
      }
    })();
    if (anchor.length > 1) {
      anchor[1] = "'" + anchor[1] + "'";
    }
    return "[" + anchor + "]";
  };

  bindingAttributeToString = function(obj) {
    var args, binding, char, elem, func, hash, i, id, isString, lastBinding, n, text, val, _i, _j, _k, _l, _len, _len1, _len2, _len3;
    binding = [''];
    val = obj.value;
    val += ' ';
    lastBinding = null;
    isString = false;
    for (i = _i = 0, _len = val.length; _i < _len; i = ++_i) {
      char = val[i];
      if (char === '.' && lastBinding) {
        lastBinding.push('');
        continue;
      }
      if (lastBinding && (isString || /[a-zA-Z_0-9$]/.test(char))) {
        lastBinding[lastBinding.length - 1] += char;
      } else if (/[a-zA-Z_$]/.test(char)) {
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
      if (/'|"/.test(char) && val[i - 1] !== '\\') {
        isString = !isString;
      }
    }
    for (i = _j = 0, _len1 = binding.length; _j < _len1; i = ++_j) {
      elem = binding[i];
      if (!(typeof elem !== 'string')) {
        continue;
      }
      id = elem[0];
      if (id === 'parent' || id === 'nextSibling' || id === 'previousSibling' || id === 'target') {
        elem.unshift("this");
      } else if (id === 'this') {
        elem[0] = "this";
      } else if ((id === 'app' || id === 'view' || ids.hasOwnProperty(id) || id in Renderer) && (i === 0 || binding[i - 1][binding[i - 1].length - 1] !== '.')) {
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
    for (i = _k = 0, _len2 = binding.length; _k < _len2; i = ++_k) {
      elem = binding[i];
      if (typeof elem === 'string') {
        hash += elem;
      } else if (elem.length > 1) {
        if ((binding[i - 1] != null) && text) {
          text += ", ";
        }
        text += repeatString('[', elem.length - 1);
        text += "'" + elem[0] + "'";
        if (elem[0] === "this") {
          hash += "this";
        } else {
          hash += "" + elem[0];
        }
        elem.shift();
        for (i = _l = 0, _len3 = elem.length; _l < _len3; i = ++_l) {
          id = elem[i];
          text += ", '" + id + "']";
          hash += "." + id;
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
    text = text.trim();
    args = idsKeys + '';
    func = "function(" + args + "){return " + hash + "}";
    return "[" + func + ", [" + text + "]]";
  };

  stringify = {
    object: function(elem) {
      var args, attrToValue, body, child, children, func, i, json, postfix, r, rendererCtor, value, visibleId, _i, _j, _len, _len1, _ref;
      json = {};
      children = [];
      postfix = '';
      attrToValue = function(body) {
        var child, id, query, r, tmp, value, valueCode, _i, _j, _len, _len1, _ref;
        value = body.value;
        if (body.name === 'document.query') {
          if (isBinding(body)) {
            throw new Error('document.query must be a string');
          }
          if (value) {
            query = '';
            tmp = body;
            while (tmp = tmp.parent) {
              _ref = tmp.body;
              for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                child = _ref[_i];
                if (child.name === 'document.query') {
                  query = child.value.replace(/'/g, '') + ' ' + query;
                  break;
                }
              }
            }
            query = query.trim();
            id = '';
            if (body.parent.parent) {
              id = ':' + body.parent.id;
            }
            queries[query] = id;
          }
        } else if (Array.isArray(value)) {
          r = {};
          for (_j = 0, _len1 = value.length; _j < _len1; _j++) {
            child = value[_j];
            r[child.name] = "`" + (attrToValue(child)) + "`";
          }
          r = JSON.stringify(r);
          postfix += ", \"" + body.name + "\": " + r;
          return false;
        } else if ((value != null ? value.type : void 0) === 'object') {
          valueCode = stringify.object(value);
          postfix += ", \"" + body.name + "\": ((" + valueCode + "), new Renderer.Component.Link('" + value.id + "'))";
          return false;
        } else if (isAnchor(body)) {
          value = anchorAttributeToString(body);
        } else if (isBinding(body)) {
          value = bindingAttributeToString(body);
        }
        return value;
      };
      _ref = elem.body;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        body = _ref[_i];
        switch (body.type) {
          case 'id':
            json.id = body.value;
            break;
          case 'object':
            children.push(stringify.object(body));
            break;
          case 'attribute':
            value = attrToValue(body);
            if (value !== false) {
              json[body.name] = "`" + value + "`";
            }
            break;
          case 'function':
            args = idsKeys + '';
            if (body.params + '') {
              args += ",";
            }
            args += body.params + '';
            func = "`function(" + args + "){" + body.body + "}`";
            json[body.name] = func;
            break;
          case 'property':
            if (json.properties == null) {
              json.properties = [];
            }
            json.properties.push(body.name);
            break;
          case 'signal':
            if (json.signals == null) {
              json.signals = [];
            }
            json.signals.push(body.name);
            break;
          default:
            throw "Unexpected object body type '" + body.type + "'";
        }
      }
      if (!json.id) {
        json.id = elem.id = "i" + (utils.uid());
      }
      itemsKeys.push(json.id);
      visibleId = json.id;
      if (utils.has(idsKeys, json.id)) {
        visibleId = json.id;
      }
      json = JSON.stringify(json, null, 4);
      if (children.length) {
        postfix += ", children: [";
        for (i = _j = 0, _len1 = children.length; _j < _len1; i = ++_j) {
          child = children[i];
          if (i > 0) {
            postfix += ", ";
          }
          postfix += child;
        }
        postfix += "]";
      }
      if (postfix) {
        if (json.length === 2) {
          postfix = postfix.slice(2);
        }
        json = json.slice(0, -1);
        json += postfix;
        json += "}";
      }
      json = json.replace(/"`(.*?)`"/g, function(_, val) {
        return JSON.parse("\"" + val + "\"");
      });
      rendererCtor = Renderer[elem.name.split('.')[0]];
      if (rendererCtor != null) {
        r = "new " + elem.name + "(_c, " + json + ")\n";
      } else {
        r = "" + elem.name + "(_c, " + json + ")\n";
      }
      if (visibleId) {
        r = "" + visibleId + " = " + r;
      }
      return r;
    }
  };

  getIds = function(elem, ids) {
    var elems;
    if (ids == null) {
      ids = {};
    }
    elems = getByTypeDeep(elem, 'id', function(attr) {
      return ids[attr.value] = attr.parent;
    });
    return ids;
  };

  module.exports = function(file, filename) {
    var allQueries, bootstrap, code, codes, elem, elemCode, elems, firstId, i, id, objects, objectsIds, query, val, _i, _j, _len, _len1;
    elems = parser(file);
    codes = {};
    bootstrap = '';
    firstId = null;
    allQueries = {};
    for (i = _i = 0, _len = elems.length; _i < _len; i = ++_i) {
      elem = elems[i];
      queries = {};
      id = elem.id;
      ids = getIds(elem);
      idsKeys = Object.keys(ids).filter(function(id) {
        return !!id;
      });
      itemsKeys = [];
      code = "var _c = new Renderer.Component\n";
      if (elem.type === 'code') {
        bootstrap += elem.body;
        continue;
      }
      if (typeof stringify[elem.type] !== 'function') {
        console.error("Unexpected block type '" + elem.type + "'");
        continue;
      }
      elemCode = stringify[elem.type](elem);
      objectsIds = idsKeys.slice();
      for (_j = 0, _len1 = itemsKeys.length; _j < _len1; _j++) {
        id = itemsKeys[_j];
        if (!utils.has(objectsIds, id)) {
          objectsIds.push(id);
        }
      }
      if (objectsIds.length) {
        code += "var " + objectsIds + "\n";
      }
      objects = utils.arrayToObject(objectsIds, function(i, elem) {
        return elem;
      }, function(i, elem) {
        return "`" + elem + "`";
      });
      code += '_c.item = ';
      code += elemCode;
      code += "_c.idsOrder = " + (JSON.stringify(idsKeys)) + "\n";
      code += "_c.objectsOrder = " + (JSON.stringify(idsKeys).replace(/\"/g, '')) + "\n";
      code += "_c.objects = " + (JSON.stringify(objects).replace(/\"`|`\"/g, '')) + "\n";
      code += 'return _c.createItem\n';
      uid = 'n' + utils.uid();
      id || (id = uid);
      if (codes[id] != null) {
        id = uid;
      }
      codes[id] = code;
      if (firstId == null) {
        firstId = id;
      }
      for (query in queries) {
        val = queries[query];
        val = id + val;
        if (allQueries[query] != null) {
          throw new Error("document.query '" + query + "' is duplicated");
        }
        allQueries[query] = val;
      }
    }
    if (!codes._main && firstId) {
      codes._main = {
        link: firstId
      };
    }
    return {
      bootstrap: bootstrap,
      codes: codes,
      queries: allQueries
    };
  };

}).call(this);


return module.exports;
})();

var result = modules["index.coffee"];

if(typeof module !== 'undefined'){
	return module.exports = result;
} else {
	return result;
}
})();