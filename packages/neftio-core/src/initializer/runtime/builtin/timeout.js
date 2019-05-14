const shots = Object.create(null)

exports.registerTimeoutCallback = (callback) => {
  callback((id) => {
    const timer = shots[id]
    if (timer) {
      delete shots[id]
      timer()
    }
  })
}

exports.setTimeout = shot => (func, delay, arg1, arg2, arg3) => {
  if (typeof func !== 'function') {
    throw new TypeError('callback argument must be a function')
  }

  let numberDelay = delay
  if (typeof delay !== 'number') {
    numberDelay = parseInt(delay, 10)
  }
  if (isNaN(numberDelay)) {
    numberDelay = 4
  }

  const argc = arguments.length
  let callFunc
  switch (argc) {
    case 1:
    case 2:
      callFunc = func
      break
    case 3:
      callFunc = function () {
        func(arg1)
      }
      break
    case 4:
      callFunc = function () {
        func(arg1, arg2)
      }
      break
    case 5:
      callFunc = function () {
        func(arg1, arg2, arg3)
      }
      break
    default: {
      const args = new Array(argc - 2)
      for (let i = 2; i < argc; i += 1) {
        args[i - 2] = arguments[i]
      }
      callFunc = function () {
        func.apply(this, args)
      }
    }
  }

  const id = shot(numberDelay)
  shots[id] = callFunc
  return id
}

exports.clearTimeout = (id) => {
  delete shots[id]
}
