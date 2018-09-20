const fs = require('fs')
const pathUtils = require('path')
const { promisify } = require('util')
const moduleCache = require('../module-cache')
const acorn = require('acorn')
const walk = require('acorn/dist/walk')

const NODE_MODULES = process.binding('natives')
const NEFT_BASEPATH = pathUtils.resolve(__dirname, '../../')
const EXTENSIONS = ['.js', '.litcoffee', '.coffee', '.nml']
const EXTENSIONS_TEST = { '.js': true, '.litcoffee': true, '.coffee': true, '.nml': true }
const IGNORE_SCAN_RE = /\.lib\.(?:js|coffee|litcoffee)$/
const RULE_LINE_RE = /^\s*\/\/\s*when\s*=\s*(!)?\s*([A-Z_]+);?$/
const INDEX_PATH = 'index'
const PACKAGE_JSON_PATH = 'package.json'
const NODE_MODULES_PATH = 'node_modules'
const BUILD_PATH = 'build'
const NEFT_NODE_MODULES_PATH = pathUtils.join(NEFT_BASEPATH, NODE_MODULES_PATH)
const ACORN_OPTIONS = { ecmaVersion: 9 }

module.exports = async function(opts) {
    const { path, basepath, env, verbose } = opts
    const result = {}
    const promises = []
    const errors = []
    const pathsCache = Object.create(null)

    function catchPromise(promise) {
        return promise.catch(error => errors.push(error))
    }

    function async(promise) {
        promises.push(catchPromise(promise))
    }

    function passesRuleLine([_, negation, prop]) {
        const isNegated = negation === '!'
        const valueExists = prop in env
        return isNegated ? !valueExists : valueExists
    }

    async function validateRuleLine(path) {
        const file = await moduleCache.getFile(path)
        for (const line of file.split('\n', 3)) {
            const match = RULE_LINE_RE.exec(line)
            if (match) {
                if (passesRuleLine(match)) {
                    if (verbose) {
                        console.log(`Rule line passed for file '${path}'`)
                    }
                } else {
                    const rule = (match[1] || '') + match[2]
                    throw new Error(
                        `Cannot require '${path}'; the rule says '${rule}' but ` +
                        `current value of process.env['${match[2]}'] is ${env[match[2]]}`
                    )
                }
                return
            }
        }
    }

    function isRequireNode(node) {
        return node.callee.name === 'require'
    }

    function getProcessEnvNodeProperty(node) {
        if (node.type === 'UnaryExpression') return getProcessEnvNodeProperty(node.argument)
        if (node.type === 'BinaryExpression') return getProcessEnvNodeProperty(node.left)
        if (node.type !== 'MemberExpression') return
        if (node.object.type !== 'MemberExpression') return
        if (node.object.object.type !== 'Identifier') return
        if (node.object.object.name !== 'process') return
        if (node.object.property.name !== 'env') return
        if (node.property.type !== 'Identifier') return

        return node.property.name
    }

    const EqualsOperator = { reversed() { return NotEqualsOperator } }
    const NotEqualsOperator = { reversed() { return EqualsOperator } }
    const ExistsOperator = { reversed() { return NotExistsOperator } }
    const NotExistsOperator = { reversed() { return ExistsOperator } }

    function getNodeOperator(node) {
        if (node.type === 'UnaryExpression' && node.operator === '!') {
            return getNodeOperator(node.argument).reversed()
        }
        if (node.type === 'BinaryExpression') {
            const { operator } = node
            if (operator === '===' || operator === '==') return EqualsOperator
            if (operator === '!==' || operator === '!=') return NotEqualsOperator
        }
        if (node.type === 'MemberExpression') return ExistsOperator
    }

    function getProcessEnvExpectedValue(node) {
        if (node.type === 'UnaryExpression') return getProcessEnvExpectedValue(node.argument)
        if (node.type === 'BinaryExpression' && node.right.type === 'Literal') {
            return node.right.value
        }
    }

    function isRequireNodeAvailable(ancestors) {
        let result = true
        for (const ancestor of ancestors) {
            if (ancestor.type === 'SwitchStatement') return false
            if (ancestor.type !== 'IfStatement') continue
            const property = getProcessEnvNodeProperty(ancestor.test)
            const operator = getNodeOperator(ancestor.test)
            const expected = getProcessEnvExpectedValue(ancestor.test)

            switch (operator) {
                case EqualsOperator:
                    result = env[property] === expected
                    break
                case NotEqualsOperator:
                    result = env[property] !== expected
                    break
                case ExistsOperator:
                    result = env[property]
                    break
                case NotExistsOperator:
                    result = !env[property]
                    break
            }
        }
        return result
    }

    function isRequireNodeOptional(ancestors) {
        for (const ancestor of ancestors) {
            if (ancestor.type === 'TryStatement') return true
        }
        return false
    }

    async function resolvePath(path) {
        if (!shouldIncludePath(path)) return

        if (result[path]) return
        result[path] = {}

        if (!shouldProceedPath(path)) return

        const extname = pathUtils.extname(path)
        if (!EXTENSIONS_TEST[extname]) return

        try {
            var file = await moduleCache.getFile(path)
        } catch (error) {
            throw new Error(`Cannot load file '${path}': ${error.message}`)
        }

        try {
            var ast = acorn.parse(file, ACORN_OPTIONS)
        } catch (error) {
            throw new Error(`Cannot parse file '${path}': ${error.message}`)
        }

        walk.ancestor(ast, {
            CallExpression(node, ancestors) {
                if (!isRequireNode(node)) return
                if (!isRequireNodeAvailable(ancestors)) return
                if (node.arguments.length !== 1) return

                const [argument] = node.arguments
                if (argument.type !== 'Literal') return
                const promise = resolveRequest(path, argument.value)
                if (isRequireNodeOptional(ancestors)) {
                    async(new Promise(resolve => promise.then(resolve).catch(resolve)))
                } else {
                    async(promise)
                }
            }
        })
    }

    function shouldIncludePath(path) {
        return !path.startsWith(NEFT_NODE_MODULES_PATH)
    }

    function shouldProceedPath(path) {
        return !IGNORE_SCAN_RE.test(path) && shouldIncludePath(path)
    }

    async function resolveRequest(path, request) {
        // resolve internal node modules by names
        if (NODE_MODULES[request]) {
            result[path][request] = request
            return
        }

        const resolved = await resolve(path, request)
        result[path][request] = resolved
        await resolvePath(resolved)
    }

    async function tryPath(path) {
        try {
            const stat = await promisify(fs.stat)(path)
            return stat ? stat.isFile() : false
        } catch (error) {
            return false
        }
    }

    async function tryPaths(paths) {
        for (const path of paths) {
            if (typeof path === 'function') {
                const result = await tryPaths(await path())
                if (result) return result
                continue
            }
            const cached = pathsCache[path]
            if (cached === false) {
                continue
            }
            if (cached === true) {
                return path
            }
            if (await tryPath(path)) {
                pathsCache[path] = true
                return path
            }
            pathsCache[path] = false
        }
    }

    function getPathsWithExtensions(path) {
        const result = [path]
        for (const ext of EXTENSIONS) {
            result.push(path + ext)
        }
        return result
    }

    async function resolve(path, request) {
        const paths = []
        const addPath = (...parts) =>
            paths.push(...getPathsWithExtensions(pathUtils.join(...parts)))

        if (request[0] === '.') {
            const pathDirname = pathUtils.dirname(path)
            addPath(pathDirname, request)
            addPath(pathDirname, request, INDEX_PATH)
        } else if (pathUtils.isAbsolute(request)) {
            addPath(request)
            addPath(request, INDEX_PATH)
        } else {
            addPath(basepath, BUILD_PATH, request)
            addPath(basepath, request)
            addPath(basepath, NODE_MODULES_PATH, request)
            addPath(basepath, BUILD_PATH, request, INDEX_PATH)
            addPath(basepath, request, INDEX_PATH)
            addPath(basepath, NODE_MODULES_PATH, request, INDEX_PATH)
            addPath(NEFT_BASEPATH, request)
            addPath(NEFT_NODE_MODULES_PATH, request)
            addPath(NEFT_BASEPATH, request, INDEX_PATH)
            addPath(NEFT_NODE_MODULES_PATH, request, INDEX_PATH)
            paths.push(async function() {
                try {
                    const modulePath = pathUtils.join(basepath, NODE_MODULES_PATH, request)
                    const modulePackage = JSON.parse(await moduleCache.getFile(
                        pathUtils.join(modulePath, PACKAGE_JSON_PATH)
                    ))
                    return [
                        ...getPathsWithExtensions(pathUtils.join(modulePath, modulePackage.main)),
                        ...getPathsWithExtensions(pathUtils.join(modulePath, modulePackage.main, INDEX_PATH))
                    ]
                } catch (error) {
                    return []
                }
            })
        }

        const resolved = await tryPaths(paths)
        if (!resolved) {
            throw new Error(`Cannot resolve require '${request}' in file '${path}'`)
        }

        if (shouldProceedPath(resolved)) {
            await validateRuleLine(resolved)
        }

        return resolved
    }

    async(resolvePath(path))

    while (promises.length > 0) {
        await promises.shift()
    }

    if (errors.length > 0) {
        throw errors
    }

    return result
}
