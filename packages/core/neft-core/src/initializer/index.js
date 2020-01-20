if (process.env.NEFT_ANDROID) {
  require('./runtime/android')
}

if (process.env.NEFT_IOS) {
  require('./runtime/ios')
}

if (process.env.NEFT_MODE === 'universal') {
  exports.render = require('./render-universal')
}

if (process.env.NEFT_MODE === 'web') {
  exports.render = require('./render-web')
}
