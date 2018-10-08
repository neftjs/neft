const { util, callNativeFunction, onNativeEvent } = require('@neft/core')

const NATIVE_PREFIX = 'NeftRequest'
const REQUEST = `${NATIVE_PREFIX}/request`
const ON_RESPONSE = `${NATIVE_PREFIX}/response`
const METHODS = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']
const DEFAULT_TIMEOUT = 1000 * 30 // 30 seconds

const callbacks = Object.create(null)

onNativeEvent(ON_RESPONSE, (uid, error, statusCode, body, headers) => {
  const callback = callbacks[uid]
  if (callback) {
    delete callbacks[uid]
    callback(error, { statusCode, body, headers })
  }
})

const request = (optionsOrUri, optionsOrNull, defaultMethod) => new Promise((resolve, reject) => {
  let options = optionsOrUri
  if (typeof optionsOrUri === 'string') {
    options = { uri: optionsOrUri, ...optionsOrNull }
  }

  const uid = util.uid()
  const uri = String(options.uri || options.url)
  const method = String(options.method || defaultMethod).toUpperCase()
  let headers = util.isObject(options.headers) ? options.headers : {}
  let body = String(options.body == null ? '' : options.body)
  const json = Boolean(options.json || false)
  const timeout = Math.max(0, parseInt(options.timeout || DEFAULT_TIMEOUT, 10))

  if (json) {
    body = JSON.stringify(body)
    headers['Content-type'] = 'application/json'
  }
  headers = JSON.stringify(headers)

  callbacks[uid] = (error, { statusCode, body: resBody, headers: resHeaders }) => {
    if (error) {
      reject(new Error(error))
      return
    }
    resolve({
      statusCode,
      body: json && resBody ? JSON.parse(resBody) : resBody,
      headers: JSON.parse(resHeaders),
    })
  }

  callNativeFunction(REQUEST, uid, uri, method, headers, body, timeout)
})

module.exports = optionsOrUri => request(optionsOrUri, null, 'get')

METHODS.forEach((method) => {
  module.exports[method] = (optionsOrUri, options) => request(optionsOrUri, options, method)
})
