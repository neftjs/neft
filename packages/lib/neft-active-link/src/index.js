const { util, NativeClientBinding } = require('@neft/core')

const { callNativeFunction } = new NativeClientBinding('ActiveLink')

exports.web = (url) => {
  callNativeFunction('web', String(url))
}

exports.mailto = (opts) => {
  const isOpts = util.isObject(opts)
  const address = String(isOpts ? opts.address : opts)
  const subject = isOpts ? String(opts.subject) : null
  callNativeFunction('mailto', address, subject)
}

exports.tel = (number) => {
  callNativeFunction('tel', String(number))
}

exports.geo = (opts) => {
  const isOpts = util.isObject(opts)
  const latitude = parseFloat(isOpts ? isOpts.latitude : 0)
  const longitude = parseFloat(isOpts ? isOpts.longitude : 0)
  const address = String(isOpts ? isOpts.address : opts)
  callNativeFunction('geo', latitude, longitude, address)
}
