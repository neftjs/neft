const { util, callNativeFunction } = require('@neft/core')

const NATIVE_PREFIX = 'NeftActiveLink'
const MAILTO = `${NATIVE_PREFIX}/mailto`
const TEL = `${NATIVE_PREFIX}/tel`
const GEO = `${NATIVE_PREFIX}/geo`

exports.mailto = (opts) => {
  const isOpts = util.isObject(opts)
  const address = String(isOpts ? opts.address : opts)
  const subject = isOpts ? String(opts.subject) : null
  callNativeFunction(MAILTO, address, subject)
}

exports.tel = (number) => {
  callNativeFunction(TEL, String(number))
}

exports.geo = (opts) => {
  const isOpts = util.isObject(opts)
  const latitude = parseFloat(isOpts ? isOpts.latitude : 0)
  const longitude = parseFloat(isOpts ? isOpts.longitude : 0)
  const address = String(isOpts ? isOpts.address : opts)
  callNativeFunction(GEO, latitude, longitude, address)
}
