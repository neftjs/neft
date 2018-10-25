const valueToString = function (value) {
  let result
  if (typeof value === 'object' && value !== null && !(value instanceof RegExp)) {
    try {
      result = JSON.stringify(value)
    } catch (error) {
      // NOP
    }
  }
  return result || String(value)
}

const inspect = function (args) {
  const strings = Array.prototype.map.call(args, valueToString)
  return Array.prototype.join.call(strings, ' ')
}

exports.console = handler => Object.preventExtensions({
  assert(assertion, msg) {
    if (!assertion) throw new Error(msg)
  },
  log() {
    handler('log', inspect(arguments), arguments)
  },
  info() {
    handler('info', inspect(arguments), arguments)
  },
  warn() {
    handler('warn', inspect(arguments), arguments)
  },
  error() {
    handler('error', inspect(arguments), arguments)
  },
  trace() {
    const err = new Error()
    err.name = 'Trace'
    err.message = inspect(arguments)
    Error.captureStackTrace(err, console.trace)
    console.error(err.stack)
  },
})
