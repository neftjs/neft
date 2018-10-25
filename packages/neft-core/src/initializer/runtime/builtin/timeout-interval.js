let lastId = 0
const timers = Object.create(null)

exports.setInterval = function (func) {
  const intervalArguments = Array.prototype.slice.call(arguments)
  const id = lastId
  lastId += 1

  intervalArguments[0] = function (callArgs) {
    timers[id] = setTimeout.apply(this, intervalArguments)
    func.apply(this, callArgs)
  }

  timers[id] = setTimeout.apply(this, intervalArguments)

  return id
}

exports.clearInterval = function (id) {
  clearTimeout(timers[id])
  delete timers[id]
}
