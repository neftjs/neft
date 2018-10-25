if (process.env.NEFT_ANDROID) require('./runtime/android')
if (process.env.NEFT_IOS) require('./runtime/ios')

exports.render = require('./render')
