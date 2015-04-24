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

(function(){
	'use strict';
var grammar;

grammar = '{\n' + '	var RESERVED_ATTRIBUTES = {id: true};\n' + '	var ids = {};\n' + '\n' + '	function forEachType(arr, type, callback){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			if (arr[i].type === type) callback(arr[i], i, arr);\n' + '		}\n' + '	}\n' + '\n' + '	function flattenArray(arr){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			if (!Array.isArray(arr[i]))\n' + '				continue;\n' + '\n' + '			var child = arr[i];\n' + '\n' + '			child.unshift(i, 1);\n' + '			arr.splice.apply(arr, child);\n' + '\n' + '			i--;\n' + '			n += child.length - 3;\n' + '		}\n' + '\n' + '		return arr;\n' + '	}\n' + '\n' + '	function extractArray(arr, step){\n' + '		for (var i = 0, n = arr.length; i < n; i++){\n' + '			arr[i] = arr[i][step];\n' + '		}\n' + '\n' + '		return arr;\n' + '	}\n' + '\n' + '	function uid(){\n' + '		return Math.random().toString(16).slice(2);\n' + '	}\n' + '}\n' + '\n' + 'Start\n' + '	= (Code / Type)*\n' + '\n' + '/* HELPERS */\n' + '\n' + 'SourceCharacter\n' + '	= .\n' + '\n' + 'Letter\n' + '	= [a-zA-Z_$]\n' + '\n' + 'Word\n' + '	= $[a-zA-Z0-9_$]+\n' + '\n' + 'Variable\n' + '	= $(Letter Word?)\n' + '\n' + 'Reference\n' + '	= $(Variable ("." Variable)+)\n' + '\n' + 'LineTerminator\n' + '	= [\\n\\r\\u2028\\u2029]\n' + '\n' + 'LineTerminatorSequence "end of line"\n' + '	= "\\n"\n' + '	/ "\\r\\n"\n' + '	/ "\\r"\n' + '	/ "\\u2028"\n' + '	/ "\\u2029"\n' + '\n' + 'Zs = [\\u0020\\u00A0\\u1680\\u2000-\\u200A\\u202F\\u205F\\u3000]\n' + 'WhiteSpace "whitespace"\n' + '	= "\\t"\n' + '	/ "\\v"\n' + '	/ "\\f"\n' + '	/ " "\n' + '	/ "\\u00A0"\n' + '	/ "\\uFEFF"\n' + '	/ Zs\n' + '\n' + 'HexDigit\n' + '	= [0-9a-f]i\n' + '\n' + 'DecimalDigit\n' + '	= [0-9]\n' + '\n' + 'SingleEscapeCharacter\n' + '	= "\'"\n' + '	/ \'"\'\n' + '	/ "\\\\"\n' + '	/ "b"  { return "\\b";   }\n' + '	/ "f"  { return "\\f";   }\n' + '	/ "n"  { return "\\n";   }\n' + '	/ "r"  { return "\\r";   }\n' + '	/ "t"  { return "\\t";   }\n' + '	/ "v"  { return "\\x0B"; }   // IE does not recognize "\\v".\n' + '\n' + 'NonEscapeCharacter\n' + '  = !(EscapeCharacter / LineTerminator) SourceCharacter { return text(); }\n' + '\n' + 'EscapeCharacter\n' + '	= SingleEscapeCharacter\n' + '	/ DecimalDigit\n' + '	/ "x"\n' + '	/ "u"\n' + '\n' + 'Comment "comment"\n' + '	= MultiLineComment\n' + '	/ SingleLineComment\n' + '\n' + 'MultiLineComment\n' + '	= WhiteSpace* "/*" (!"*/" SourceCharacter)* "*/"\n' + '\n' + 'SingleLineComment\n' + '	= WhiteSpace* "//" (!LineTerminator SourceCharacter)*\n' + '\n' + 'StringLiteral "string"\n' + '	= \'"\' chars:$DoubleStringCharacter* \'"\' {\n' + '		return chars;\n' + '	}\n' + '	/ "\'" chars:$SingleStringCharacter* "\'" {\n' + '		return chars;\n' + '	}\n' + '\n' + 'DoubleStringCharacter\n' + '	= !(\'"\' / "\\\\" / LineTerminator) SourceCharacter { return text(); }\n' + '	/ "\\\\" sequence:EscapeSequence { return sequence; }\n' + '	/ LineContinuation\n' + '\n' + 'SingleStringCharacter\n' + '	= !("\'" / "\\\\" / LineTerminator) SourceCharacter { return text(); }\n' + '	/ "\\\\" sequence:EscapeSequence { return sequence; }\n' + '	/ LineContinuation\n' + '\n' + 'LineContinuation\n' + '  = "\\\\" LineTerminatorSequence { return ""; }\n' + '\n' + 'EscapeSequence\n' + '	= CharacterEscapeSequence\n' + '	/ "0" !DecimalDigit { return "\\0"; }\n' + '	/ HexEscapeSequence\n' + '	/ UnicodeEscapeSequence\n' + '\n' + 'CharacterEscapeSequence\n' + '	= SingleEscapeCharacter\n' + '	/ NonEscapeCharacter\n' + '\n' + 'HexEscapeSequence\n' + '	= "x" digits:$(HexDigit HexDigit) {\n' + '		return String.fromCharCode(parseInt(digits, 16));\n' + '	}\n' + '\n' + 'UnicodeEscapeSequence\n' + '	= "u" digits:$(HexDigit HexDigit HexDigit HexDigit) {\n' + '		return String.fromCharCode(parseInt(digits, 16));\n' + '	}\n' + '\n' + '__\n' + '	= (WhiteSpace / LineTerminatorSequence / Comment)*\n' + '\n' + '/* ATTRIBUTE */\n' + '\n' + 'AttributeName "attribute name"\n' + '	= name:(Reference / Variable) {\n' + '		if (RESERVED_ATTRIBUTES[name]){\n' + '			error(name+" syntax error");\n' + '		}\n' + '		return name;\n' + '	}\n' + '\n' + 'AttributeEnds\n' + '	= ";"\n' + '	/ LineTerminator\n' + '	/ Comment\n' + '\n' + 'AttributeBody\n' + '	= Type\n' + '	/ "{" d:(__ d:Attribute __ { return d })* "}" AttributeEnds { return d }\n' + '	/ "[" d:Type* "]" AttributeEnds { return d }\n' + '	/ d:$StringLiteral AttributeEnds { return d }\n' + '	/ value:(!AttributeEnds d:($StringLiteral/SourceCharacter) {return d})+ AttributeEnds {\n' + '		return value.join(\'\').trim()\n' + '	}\n' + '\n' + 'AttributeDeclaration\n' + '	= name:AttributeName ":" WhiteSpace* {return name}\n' + '\n' + 'Attribute "attribute"\n' + '	= name:AttributeDeclaration value:AttributeBody {\n' + '		return { type: \'attribute\', name: name, value: value };\n' + '	}\n' + '\n' + '/* PROPERTY */\n' + '\n' + 'PropertyToken\n' + '	= "property"\n' + '\n' + 'Property "custom property"\n' + '	= PropertyToken WhiteSpace attribute:(Attribute / (d:AttributeName AttributeEnds {return d})) {\n' + '		var name = attribute.name || attribute;\n' + '		if (name.indexOf(\'$.\') !== 0) { error(\'Properties can be created only in the \\\'$\\\' object. Use \\\'property $.\'+name+\'\\\' instead\'); }\n' + '		var obj = { type: \'property\', name: name.slice(2) };\n' + '		return typeof attribute === \'string\' ? obj : [obj, attribute];\n' + '	}\n' + '\n' + '/* SIGNAL */\n' + '\n' + 'SignalToken\n' + '	= "signal"\n' + '\n' + 'Signal "signal"\n' + '	= SignalToken WhiteSpace name:(Reference / Variable) AttributeEnds {\n' + '		if (name.indexOf(\'$.\') !== 0) { error(\'Signals can be created only in the \\\'$\\\' object. Use \\\'signal $.\'+name+\'\\\' instead\'); }\n' + '		return { type: \'signal\', name: name.slice(2) };\n' + '	}\n' + '\n' + '/* ID */\n' + '\n' + 'IdToken\n' + '	= "id"\n' + '\n' + 'Id "id declaration"\n' + '	= IdToken ":" WhiteSpace* value:Variable AttributeEnds {\n' + '		if (ids[value]){\n' + '			error("this id has been already defined");\n' + '		}\n' + '		ids[value] = true;\n' + '		return { type: \'id\', value: value };\n' + '	}\n' + '\n' + '/* FUNCTION */\n' + '\n' + 'FunctionBody\n' + '	= FunctionBodyCode (FunctionBodyCode FunctionBodyFunc)* FunctionBodyCode\n' + '\n' + 'FunctionBodyCode\n' + '	= FunctionBodyAny (StringLiteral FunctionBodyAny)* FunctionBodyAny\n' + '\n' + 'FunctionBodyAny\n' + '	= [a-zA-Z0-9_\\-+=!@#$%^&*()~\\[\\]\\\\|<>,.?/ \\t\\n;:]*\n' + '\n' + 'FunctionBodyFunc\n' + '	= "{" FunctionBody "}"\n' + '\n' + 'FunctionParams\n' + '	= "(" first:Variable? rest:(WhiteSpace* "," WhiteSpace* d:Variable { return d })* ")" {\n' + '		return flattenArray([first, rest])\n' + '	}\n' + '\n' + 'FunctionName\n' + '	= (Variable ".")* "on" Variable\n' + '\n' + 'Function "function"\n' + '	= name:$FunctionName ":" WhiteSpace* "function" WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionBody "}" AttributeEnds {\n' + '		return { type: \'function\', name: name, params: params, body: body };\n' + '	}\n' + '\n' + '/* DECLARATION */\n' + '\n' + 'Declaration\n' + '	= __ d:(Function / Id / Attribute / Property / Signal / Type) {\n' + '		return d\n' + '	}\n' + '\n' + 'Declarations\n' + '	= d:(Declaration / Code)* { return flattenArray(d) }\n' + '\n' + '/* TYPE */\n' + '\n' + 'TypeNameRest\n' + '	= "." ("/"? Variable)+\n' + '	/ "[\'" (("." / "/")? Variable)+ "\']"\n' + '	/ "[\\"" (("." / "/")? Variable)+ "\\"]"\n' + '\n' + 'TypeName "type name"\n' + '	= d:$(Variable TypeNameRest?) {\n' + '		if (d.indexOf(\'/\') !== -1 && d.indexOf(\'[\') === -1){\n' + '			return d.replace(/\\.([a-zA-Z0-9_/]+)$/, "[\'$1") + "\']";\n' + '		}\n' + '		return d;\n' + '	}\n' + '\n' + 'TypeBody\n' + '	= __ d:Declarations __ { return d }\n' + '\n' + 'Type\n' + '	= __ name:TypeName WhiteSpace* "{" body:TypeBody "}" __ {\n' + '		var id;\n' + '		forEachType(body, "id", function(elem){\n' + '			if (id){\n' + '				error("item can has only one id");\n' + '			}\n' + '			id = elem.value;\n' + '		});\n' + '\n' + '		if (!id){\n' + '			id = \'a\' + uid();\n' + '		}\n' + '\n' + '		var obj = { type: \'object\', name: name, id: id, body: body };\n' + '\n' + '		for (var i = 0; i < body.length; i++){\n' + '			body[i].parent = obj;\n' + '		}\n' + '\n' + '		return obj;\n' + '	}\n' + '\n' + '/* CODE */\n' + '\n' + 'CodeBody\n' + '	= CodeBodyCode (CodeBodyCode CodeBodyFunc)* CodeBodyCode\n' + '\n' + 'CodeBodyCode\n' + '	= CodeBodyAny (StringLiteral CodeBodyAny)* CodeBodyAny\n' + '\n' + 'CodeBodyAny\n' + '	= CodeBodyAnyChar*\n' + '\n' + 'CodeBodyAnyChar\n' + '	= (!(name:TypeName WhiteSpace* "{")) [a-zA-Z0-9_\\-+=!@#$%^&*()~\\[\\]\\\\|<>,.?/ \\t\\n;:]\n' + '\n' + 'CodeBodyFunc\n' + '	= "{" CodeBody "}"\n' + '\n' + 'Code\n' + '	= d:$(d:$CodeBody &{return d.trim() ? d : undefined;}) {\n' + '		return { type: \'code\', body: d }\n' + '	}\n' + '';

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

}());

return module.exports;
})();modules['index.coffee'] = (function(){
var module = {exports: modules["index.coffee"]};
var require = getModule.bind(null, {"./parser":"parser.coffee"});
var exports = module.exports;

(function(){
	'use strict';
var ATTRIBUTE, BINDING, CODE, FUNCTION, ID, OBJECT, PROPERTY, Renderer, SIGNAL, anchorAttributeToString, assert, bindingAttributeToString, concatArrayElements, getByType, getEachProp, getElemByName, getObject, getObjectNextSibling, getObjectParent, getObjectPreviousSibling, ids, isAnchor, isBinding, parser, repeatString, stringAttribute, stringAttributes, stringFunctions, stringObject, stringObjectChildren, stringObjectFull, stringObjectHead, stringViewObjectFull, utils;

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

ids = null;

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

BINDING = /([a-zA-Z_$][a-zA-Z0-9_$]*)\.([a-zA-Z0-9_$]+)/;

isBinding = function(obj) {
  assert(obj.type === ATTRIBUTE, "isBinding: type must be an attribute");
  try {
    eval("(function(global,console,process,root,module,require){return (" + obj.value + ");}).call(null)");
    return false;
  } catch (_error) {}
  if (!BINDING.test(obj.value)) {
    return false;
  }
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

getObject = function(obj) {
  while (obj) {
    if (obj.type === 'object') {
      return obj;
    }
    obj = obj.parent;
  }
};

getObjectParent = function(obj) {
  var parent;
  obj = getObject(obj);
  if (!(parent = obj.parent)) {
    throw "Binding to the static 'parent' can't be used if an item doesn't have a parent. Use 'this.parent' if this reference must be dynamic";
  }
  return parent.id;
};

getObjectNextSibling = function(obj) {
  var index, sibling, _ref;
  obj = getObject(obj);
  index = (_ref = obj.parent) != null ? _ref.body.indexOf(obj) : void 0;
  if (!(sibling = obj.parent.body[index + 1])) {
    throw "Binding to the static 'nextSibling' can't be used if an item doesn't have a next sibling. Use 'this.nextSibling' if this reference must be dynamic";
  }
  return sibling.id;
};

getObjectPreviousSibling = function(obj) {
  var index, sibling, _ref;
  obj = getObject(obj);
  index = (_ref = obj.parent) != null ? _ref.body.indexOf(obj) : void 0;
  if (!(sibling = obj.parent.body[index - 1])) {
    throw "Binding to the static 'previousSibling' can't be used if an item doesn't have a previous sibling. Use 'this.previousSibling' if this reference must be dynamic";
  }
  return sibling.id;
};

anchorAttributeToString = function(obj) {
  var anchor, dotIndex;
  assert(obj.type === ATTRIBUTE, "anchorAttributeToString: type must be an attribute");
  if (typeof obj.value === 'object') {
    return "{}";
  }
  dotIndex = obj.value.lastIndexOf('.');
  if (dotIndex === -1) {
    anchor = [obj.value];
  } else {
    anchor = [obj.value.slice(0, dotIndex), obj.value.slice(dotIndex + 1)];
  }
  anchor[0] = (function() {
    switch (anchor[0]) {
      case 'this.parent':
        return "'parent'";
      case 'this.nextSibling':
        return "'nextSibling'";
      case 'this.previousSibling':
        return "'previousSibling'";
      case 'parent':
        return getObjectParent(obj);
      case 'nextSibling':
        return getObjectNextSibling(obj);
      case 'previousSibling':
        return getObjectPreviousSibling(obj);
      default:
        return anchor[0];
    }
  })();
  if (anchor.length > 1) {
    anchor[1] = "'" + anchor[1] + "'";
  }
  return "[" + anchor + "]";
};

bindingAttributeToString = function(obj) {
  var args, binding, char, elem, hash, i, id, isString, lastBinding, n, text, val, _i, _j, _k, _l, _len, _len1, _len2, _len3;
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
    if (id === 'parent' || id === 'target') {
      elem[0] = getObjectParent(obj);
    } else if (id === 'nextSibling') {
      elem[0] = getObjectNextSibling(obj);
    } else if (id === 'previousSibling') {
      elem[0] = getObjectPreviousSibling(obj);
    } else if (id === 'this') {
      elem[0] = getObject(obj).id;
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
  args = [];
  for (i = _k = 0, _len2 = binding.length; _k < _len2; i = ++_k) {
    elem = binding[i];
    if (binding[i - 1] != null) {
      text += ", ";
    }
    if (typeof elem === 'string') {
      elem = elem.replace(/\$/g, '$$$');
      elem = elem.replace(/'/g, '\\\'');
      text += "'" + elem + "'";
      hash += elem;
    } else if (elem.length > 1) {
      text += repeatString('[', elem.length - 1);
      text += "" + elem[0];
      hash += "$" + args.length;
      args.push(elem[0]);
      elem.shift();
      for (i = _l = 0, _len3 = elem.length; _l < _len3; i = ++_l) {
        id = elem[i];
        text += ", '" + id + "']";
        hash += "." + id;
      }
    } else {
      text += "" + elem[0];
      hash += "$" + args.length;
      args.push(elem[0]);
    }
  }
  return "['" + hash + "', [" + text + "], [" + args + "]]";
};

stringObjectHead = function(obj) {
  var decl, isLocal, properties, property, r, rendererClass, signal, signals, _i, _j, _len, _len1;
  assert(obj.type === OBJECT, "stringObject: type must be an object");
  if (getByType(obj.body, ID).length > 0) {
    ids[obj.id] = true;
  }
  rendererClass = Renderer[obj.name.split('.')[0]];
  isLocal = rendererClass != null;
  decl = isLocal ? "new " + obj.name : "" + obj.name;
  r = "var " + obj.id + " = ids." + obj.id + " = " + decl + "();\n";
  r += "" + obj.id + "._id = '" + obj.id + "';\n";
  r += "" + obj.id + "._isReady = false;\n";
  properties = getEachProp(getByType(obj.body, PROPERTY), 'name');
  for (_i = 0, _len = properties.length; _i < _len; _i++) {
    property = properties[_i];
    r += "" + obj.id + ".createProperty('" + (utils.addSlashes(property)) + "')\n";
  }
  signals = getEachProp(getByType(obj.body, SIGNAL), 'name');
  for (_j = 0, _len1 = signals.length; _j < _len1; _j++) {
    signal = signals[_j];
    r += "" + obj.id + ".createSignal('" + (utils.addSlashes(signal)) + "')\n";
  }
  return r;
};

stringObjectChildren = function(obj) {
  var child, r, rendererClass, _i, _len, _ref;
  assert(obj.type === OBJECT, "stringObject: type must be an object");
  r = "";
  _ref = getByType(obj.body, OBJECT);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    child = _ref[_i];
    r += stringObject(child);
    rendererClass = Renderer[child.name.split('.')[0]];
    if ((rendererClass != null ? rendererClass.prototype : void 0) instanceof Renderer.Extension) {
      r += "" + child.id + ".target = " + obj.id + ";\n";
    } else {
      r += "if (" + child.id + " instanceof Item) " + child.id + ".parent = " + obj.id + ";\n";
    }
  }
  return r;
};

stringObject = function(obj) {
  var r;
  r = stringObjectHead(obj);
  return r += stringObjectChildren(obj);
};

stringAttribute = function(obj, parents) {
  var binding, childParents, elem, extraParentsRef, object, parent, parentsRef, propName, r, rArr, rPost, rPre, ref, value, _, _i, _j, _len, _len1, _ref, _ref1;
  assert(obj.type === ATTRIBUTE, "stringAttribute: type must be an attribute");
  assert(parents[0].type === OBJECT, "stringAttribute: first parent must be an object");
  object = parents[0];
  value = obj.value;
  parentsRef = "" + object.id + ".";
  _ref = parents.slice(1);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    parent = _ref[_i];
    parentsRef += "" + parent.name + ".";
  }
  parentsRef = parentsRef.slice(0, -1);
  ref = "" + parentsRef + "." + obj.name;
  r = "" + ref + " = ";
  rPre = '';
  rPost = '';
  childParents = null;
  if (Array.isArray(value)) {
    rArr = "[";
    for (_j = 0, _len1 = value.length; _j < _len1; _j++) {
      elem = value[_j];
      switch (elem.type) {
        case OBJECT:
          rArr += "" + elem.id + ", ";
          rPre += stringObjectFull(elem);
          break;
        case ATTRIBUTE:
          if (!childParents) {
            childParents = parents.slice();
            childParents.push(obj);
          }
          rPost += stringAttribute(elem, childParents);
          break;
        default:
          throw "Not implemented attribute type";
      }
    }
    rArr = rArr.slice(0, -2);
    if (rArr.length > 0) {
      r += "" + rArr + "]";
    } else {
      if (parents.length > 1 || obj.name.indexOf('$.') === 0) {
        r += "{}";
      } else {
        return rPre + rPost;
      }
    }
  } else if (isAnchor(obj)) {
    r += anchorAttributeToString(obj);
  } else {
    _ref1 = /^(?:(.+)\.)?(.+)$/.exec(obj.name), _ = _ref1[0], extraParentsRef = _ref1[1], propName = _ref1[2];
    if (extraParentsRef) {
      extraParentsRef = "." + extraParentsRef;
    } else {
      extraParentsRef = '';
    }
    if (isBinding(obj)) {
      binding = bindingAttributeToString(obj);
      r = "" + parentsRef + extraParentsRef + ".createBinding('" + propName + "', " + binding + ")";
    } else {
      if (/^Styles\[/.test(object.name)) {
        rPre = "" + parentsRef + extraParentsRef + ".createBinding('" + propName + "', null);\n";
      }
      if (value.type === OBJECT) {
        r += value.id;
        rPre += stringObjectFull(value);
      } else {
        r += value;
      }
    }
  }
  r += ";\n";
  return rPre + r + rPost;
};

stringAttributes = function(obj) {
  var attribute, child, r, _i, _j, _len, _len1, _ref, _ref1;
  assert(obj.type === OBJECT, "stringAttributes: type must be an object");
  r = '';
  _ref = getByType(obj.body, OBJECT);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    child = _ref[_i];
    r += stringAttributes(child);
  }
  _ref1 = getByType(obj.body, ATTRIBUTE);
  for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
    attribute = _ref1[_j];
    r += stringAttribute(attribute, [obj]);
  }
  return r;
};

stringFunctions = function(obj) {
  var attribute, attributes, child, func, r, _i, _j, _len, _len1, _ref;
  assert(obj.type === OBJECT, "stringFunctions: type must be an object");
  r = '';
  attributes = getByType(obj.body, FUNCTION);
  for (_i = 0, _len = attributes.length; _i < _len; _i++) {
    attribute = attributes[_i];
    func = Function(attribute.params || [], attribute.body);
    r += "" + obj.id + "." + attribute.name + "(" + func + ", " + obj.id + ");\n";
  }
  _ref = getByType(obj.body, OBJECT);
  for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
    child = _ref[_j];
    r += stringFunctions(child);
  }
  return r;
};

stringObjectFull = function(obj) {
  var code;
  if (obj.type === CODE) {
    return obj.body;
  }
  assert(obj.type === OBJECT, "stringObjectFull: type must be an object");
  code = stringObject(obj);
  code += stringAttributes(obj);
  code += stringFunctions(obj);
  return code;
};

stringViewObjectFull = function(obj) {
  var code;
  if (obj.type === CODE) {
    return obj.body;
  }
  assert(obj.type === OBJECT, "stringObjectFull: type must be an object");
  code = stringObjectHead(obj);
  code += "setImmediate(function(){\n";
  code += stringObjectChildren(obj);
  code += stringAttributes(obj);
  code += stringFunctions(obj);
  code += "});\n";
  return code;
};

module.exports = function(file, filename) {
  var code, elem, elems, idsKeys, _i, _j, _len, _len1;
  elems = parser(file);
  ids = {};
  code = 'var ids = {};\n';
  for (_i = 0, _len = elems.length; _i < _len; _i++) {
    elem = elems[_i];
    if (filename === 'view') {
      code += stringViewObjectFull(elem);
    } else {
      code += stringObjectFull(elem);
    }
  }
  idsKeys = Object.keys(ids);
  if (filename === 'view') {
    code += "setImmediate(function(){\n";
  }
  code += "for (var _id in ids){\n";
  code += "	ids[_id]._isReady = true; ids[_id].ready(); ids[_id].onReady.disconnectAll();\n";
  code += "}\n";
  if (filename === 'view') {
    code += "});\n";
  }
  code += "var mainItem;\n";
  for (_j = 0, _len1 = elems.length; _j < _len1; _j++) {
    elem = elems[_j];
    if (elem.type === OBJECT) {
      code += "if (" + elem.id + " instanceof Item) mainItem = " + elem.id + ";\n";
    }
  }
  return code;
};

}());

return module.exports;
})();

var result = modules["index.coffee"];

if(typeof module !== 'undefined'){
	return module.exports = result;
} else {
	return result;
}
})();