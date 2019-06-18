var PARSER_FLAGS, PARSER_OPTS, bindingParser, isPublicId, logger, shouldBeUpdatedOnCreate;

logger = require('@neft/core').logger;

bindingParser = require('@neft/compiler-binding');

PARSER_FLAGS = bindingParser.CHANGE_THIS_TO_SELF;

PARSER_OPTS = {
  shouldPrefixByThis: function(key) {
    return (key !== 'this' && key !== 'global' && key !== 'Neft' && key !== 'typeof' && key !== 'true' && key !== 'false' && key !== 'null' && key !== 'undefined' && key !== 'self') && !(key in global);
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
