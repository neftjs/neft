const { setImmediate, callInLock } = require('../../../event-loop')
const { sendDataInLock } = require('../../../native/bridge')

const queue = []
let requested = false

const callRequests = () => {
  for (let i = 0, n = queue.length; i < n; i += 1) {
    callInLock(queue.shift())
  }
}

const onAnimationFrame = () => {
  if (!requested) return
  requested = false
  setImmediate(callRequests)
  sendDataInLock()
}

exports.requestAnimationFrame = nativeRequestAnimationFrame => function (callback) {
  if (typeof callback !== 'function') return
  if (!requested) {
    nativeRequestAnimationFrame(onAnimationFrame)
    requested = true
  }
  queue.push(callback)
}
