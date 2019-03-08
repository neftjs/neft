const { util, callNativeFunction, onNativeEvent } = require('@neft/core')
const xhr = process.env.NEFT_BROWSER ? require('./xhr') : null

const NATIVE_PREFIX = 'NeftRequest'
const REQUEST = `${NATIVE_PREFIX}/request`
const ON_RESPONSE = `${NATIVE_PREFIX}/response`
const METHODS = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']
const DEFAULT_TIMEOUT = 1000 * 30 // 30 seconds

const callbacks = Object.create(null)

if (process.env.NEFT_NATIVE) {
  onNativeEvent(ON_RESPONSE, (uid, error, statusCode, body, headers) => {
    const callback = callbacks[uid]
    if (callback) {
      delete callbacks[uid]
      callback(error, { statusCode, body, headers: JSON.parse(headers) })
    }
  })
}

const createCallback = ({
  json, resolveWithFullResponse, resolve, reject,
}) => (error, { statusCode, body, headers }) => {
  if (error) {
    reject(new Error(error))
    return
  }
  let finalBody = body
  if (json) {
    try {
      finalBody = JSON.parse(body)
    } catch (parseError) {
      // NOP
    }
  }
  if (resolveWithFullResponse) {
    resolve({
      statusCode,
      body: finalBody,
      headers,
    })
  } else if (statusCode >= 200 && statusCode < 300) {
    resolve(finalBody)
  } else {
    reject(finalBody)
  }
}

const request = (optionsOrUri, optionsOrNull, defaultMethod) => new Promise((resolve, reject) => {
  let options = optionsOrUri
  if (typeof optionsOrUri === 'string') {
    options = { uri: optionsOrUri, ...optionsOrNull }
  }

  const uid = util.uid()
  const uri = String(options.uri || options.url)
  const method = String(options.method || defaultMethod).toUpperCase()
  let headers = util.isObject(options.headers) ? options.headers : {}
  let body = options.body == null ? '' : options.body
  const json = Boolean(options.json || false)
  const timeout = Math.max(0, parseInt(options.timeout || DEFAULT_TIMEOUT, 10))
  const resolveWithFullResponse = options.resolveWithFullResponse || false

  if (json) {
    body = JSON.stringify(body)
    headers['Content-type'] = 'application/json'
  }
  body = String(body)

  const callback = createCallback({ json, resolveWithFullResponse, resolve, reject })

  if (process.env.NEFT_NATIVE) {
    callbacks[uid] = callback
    headers = JSON.stringify(headers)
    callNativeFunction(REQUEST, uid, uri, method, headers, body, timeout)
  } else {
    xhr.send({
      method, uri, headers, body, callback,
    })
  }
})

module.exports = optionsOrUri => request(optionsOrUri, null, 'get')

METHODS.forEach((method) => {
  module.exports[method] = (optionsOrUri, options) => request(optionsOrUri, options, method)
})
