/* global ios */

const { console } = require('./builtin/console')
const nativeConsole = global.console
global.console = console((type, msg, args) => {
  const body = `[${type.toUpperCase()}] ${msg}`
  ios.log(body)
  nativeConsole[type].apply(nativeConsole, args)
})

const { registerTimeoutCallback, setTimeout, clearTimeout } = require('./builtin/timeout')
registerTimeoutCallback((callback) => { ios.timerCallback = callback })
global.setTimeout = setTimeout(delay => ios.timerShot(delay))
global.clearTimeout = clearTimeout

const { setInterval, clearInterval } = require('./builtin/timeout-interval')
global.setInterval = setInterval
global.clearInterval = clearInterval

const { requestAnimationFrame } = require('./builtin/request-animation-frame')
global.requestAnimationFrame = requestAnimationFrame((callback) => {
  ios.animationFrameCallback = callback
})

const { setImmediate } = require('../../event-loop')
global.setImmediate = setImmediate
