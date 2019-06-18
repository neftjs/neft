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
