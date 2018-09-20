const { util, callNativeFunction } = require('@neft/core')

exports.mailto = (opts) => {
  const isOpts = util.isObject(opts)
  const address = String(isOpts ? opts.address : opts)
  const subject = isOpts ? String(opts.subject) : null
  callNativeFunction('extensionActiveLinkMailto', address, subject)
}

exports.tel = (number) => {
  callNativeFunction('extensionActiveLinkTel', String(number))
}
