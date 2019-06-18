/* global _neft */

const { console } = require('./builtin/console')
global.console = console((type, msg) => { _neft.console[type](msg) })

const { registerTimeoutCallback, setTimeout, clearTimeout } = require('./builtin/timeout')
registerTimeoutCallback(_neft.timers.registerCallback)
global.setTimeout = setTimeout(_neft.timers.shot)
global.clearTimeout = clearTimeout

const { setInterval, clearInterval } = require('./builtin/timeout-interval')
global.setInterval = setInterval
global.clearInterval = clearInterval

const { requestAnimationFrame } = require('./builtin/request-animation-frame')
global.requestAnimationFrame = requestAnimationFrame(global.requestAnimationFrame)

const { setImmediate } = require('../../event-loop')
global.setImmediate = setImmediate
