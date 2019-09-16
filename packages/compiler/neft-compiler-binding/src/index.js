const acorn = require('acorn')
const walk = require('acorn-walk')
const astring = require('astring')

// comes from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects
const GLOBAL_KEYS = new Set([
  // Neft globals
  'global',

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
])

exports.isBinding = (code) => {
  try {
    // eslint-disable-next-line no-new-func
    const func = new Function('console', `'use strict'; return ${code}`)
    func.call(null)
    return false
  } catch (error) {
    // NOP
  }
  return true
}

const prefixByThis = node => ({
  type: 'MemberExpression',
  object: {
    type: 'ThisExpression',
  },
  property: node,
  computed: false,
})

const prefixById = (node, prefix) => ({
  type: 'MemberExpression',
  object: {
    type: 'Identifier',
    name: prefix,
  },
  property: node,
  computed: false,
})

const suffixByTarget = node => ({
  type: 'MemberExpression',
  object: node,
  property: {
    type: 'Identifier',
    name: 'target',
  },
  computed: false,
})

const changeNodes = (ast, types, getNewNode) => {
  const typeCallback = (leaf, ancestors) => {
    const parent = ancestors[ancestors.length - 2]
    switch (parent.type) {
      case 'CallExpression': {
        const argumentIndex = parent.arguments.indexOf(leaf)
        if (parent.callee === leaf) {
          parent.callee = getNewNode(leaf)
        } else if (argumentIndex >= 0) {
          parent.arguments[argumentIndex] = getNewNode(leaf)
        }
        break
      }
      case 'ExpressionStatement':
        if (parent.expression === leaf) {
          parent.expression = getNewNode(leaf)
        }
        break
      case 'MemberExpression':
        if (parent.object === leaf) {
          parent.object = getNewNode(leaf)
        }
        if (parent.computed && parent.property === leaf) {
          parent.property = getNewNode(leaf)
        }
        break
      case 'LogicalExpression':
        if (parent.left === leaf) {
          parent.left = getNewNode(leaf)
        } else if (parent.right === leaf) {
          parent.right = getNewNode(leaf)
        }
        break
      case 'UnaryExpression':
        if (parent.argument === leaf) {
          parent.argument = getNewNode(leaf)
        }
        break
      case 'ConditionalExpression':
        if (parent.test === leaf) {
          parent.test = getNewNode(leaf)
        } else if (parent.consequent === leaf) {
          parent.consequent = getNewNode(leaf)
        } else if (parent.alternate === leaf) {
          parent.alternate = getNewNode(leaf)
        }
        break
      case 'BinaryExpression':
        if (parent.left === leaf) {
          parent.left = getNewNode(leaf)
        } else if (parent.right === leaf) {
          parent.right = getNewNode(leaf)
        }
        break
      case 'TemplateLiteral': {
        const expressionIndex = parent.expressions.indexOf(leaf)
        if (expressionIndex >= 0) {
          parent.expressions[expressionIndex] = getNewNode(leaf)
        }
        break
      }
      case 'ArrayExpression': {
        const elementIndex = parent.elements.indexOf(leaf)
        if (elementIndex >= 0) {
          parent.elements[elementIndex] = getNewNode(leaf)
        }
        break
      }
      case 'AssignmentExpression':
        if (parent.left === leaf) {
          parent.left = getNewNode(leaf)
        }
        if (parent.right === leaf) {
          parent.right = getNewNode(leaf)
        }
        break
      case 'SpreadElement':
        if (parent.argument === leaf) {
          parent.argument = getNewNode(leaf)
        }
        break
      case 'Property':
        if (parent.value === leaf) {
          parent.shorthand = false
          parent.value = getNewNode(leaf)
        }
        break
      default:
        // NOP
    }
  }

  walk.ancestor(ast, types.reduce((target, type) => ({
    ...target,
    [type]: typeCallback,
  }), {}))
}

const changeThisExpressionsToSelfIdentifier = (ast) => {
  walk.simple(ast, {
    ThisExpression(node) {
      node.type = 'Identifier'
      node.name = 'self'
    },
  })
}

const getMemberExpressionsChain = (node, chain = []) => {
  const { object, property } = node

  // object
  if (object.type === 'MemberExpression') getMemberExpressionsChain(object, chain)
  else if (object.type === 'ThisExpression') chain.push('this')
  else if (object.name) chain.push(object.name)

  // property
  if (property.type === 'MemberExpression') getMemberExpressionsChain(property, chain)
  else if (property.name) chain.push(property.name)

  return chain
}

const expressionsChainToSubArrays = (chain) => {
  if (chain.length > 2) {
    return [expressionsChainToSubArrays(chain.slice(0, -1)), chain[chain.length - 1]]
  }
  return chain
}

const getRootMemberExpression = (ancestors) => {
  let root
  for (let i = ancestors.length - 2; i >= 0; i -= 1) {
    const parent = ancestors[i]
    if (parent.type !== 'MemberExpression') break
    if (parent.computed) break
    root = parent
  }
  return root
}

const isMemberInAssignmentExpression = (ancestors, member) => {
  for (let i = ancestors.length - 2; i >= 0; i -= 1) {
    const ancestor = ancestors[i]
    const parent = ancestors[i - 1]
    if (ancestor === member && parent) {
      return parent.type === 'AssignmentExpression' && parent.left === member
    }
  }
  return false
}

const ancestorsToConnection = (ancestors, {
  shouldUseIdInConnections,
  isHeadIdConnectionPublic,
} = {}) => {
  const node = ancestors[ancestors.length - 1]
  const root = getRootMemberExpression(ancestors)
  if (root && isMemberInAssignmentExpression(ancestors, root)) return ''
  const chain = root ? getMemberExpressionsChain(root) : [node.name]
  const head = chain[0]
  if (typeof shouldUseIdInConnections !== 'function' || shouldUseIdInConnections(head)) {
    if (typeof isHeadIdConnectionPublic === 'function' && isHeadIdConnectionPublic(head)) {
      chain[0] = `{{${head}}}`
    }
    const subArrays = expressionsChainToSubArrays(chain)
    const connection = JSON.stringify(subArrays)
      .replace(/"{{/g, '')
      .replace(/}}"/g, '')
    return `${connection},`
  }
  return ''
}

const getConnections = (ast, { shouldUseIdInConnections, isHeadIdConnectionPublic }) => {
  let result = ''
  walk.ancestor(ast, {
    ThisExpression(leaf, ancestors) {
      result += ancestorsToConnection(ancestors)
    },
    Identifier(leaf, ancestors) {
      result += ancestorsToConnection(ancestors, {
        shouldUseIdInConnections,
        isHeadIdConnectionPublic,
      })
    },
  })
  return `[${result.slice(0, -1)}]`
}

exports.parse = (code, {
  shouldBePrefixByThis = () => true,
  shouldUseIdInConnections = () => true,
  isHeadIdConnectionPublic = () => true,
  prefixIdsByThis = false,
  changeThisToSelf = false,
  suffixThisByTarget = false,
  prefixBy,
} = {}) => {
  const ast = acorn.parse(code)
  if (changeThisToSelf) {
    changeThisExpressionsToSelfIdentifier(ast)
  }
  if (prefixIdsByThis || typeof prefixBy === 'function') {
    changeNodes(ast, ['Identifier', 'Pattern'], (node) => {
      if (GLOBAL_KEYS.has(node.name)) return node
      if (changeThisToSelf && node.name === 'self') return node
      if (prefixIdsByThis) {
        if (shouldBePrefixByThis(node.name)) {
          return prefixByThis(node)
        }
      }
      const idToPut = prefixBy(node.name)
      if (idToPut) {
        return idToPut === 'this' ? prefixByThis(node) : prefixById(node, idToPut)
      }
      return node
    })
  }
  if (suffixThisByTarget) {
    changeNodes(ast, ['ThisExpression'], suffixByTarget)
  }
  return {
    hash: astring.generate(ast).trim().slice(0, -1),
    connections: getConnections(ast, { shouldUseIdInConnections, isHeadIdConnectionPublic }),
  }
}
