const { NativeServerBinding } = require('@neft/core')
const xhr = require('./xhr')

const { onCall, pushEvent } = new NativeServerBinding('Request')

onCall('request', (uid, uri, method, headers, body, timeout) => {
  xhr.send({
    uri,
    method,
    headers: JSON.parse(headers),
    body,
    timeout,
  }, (err, resp) => {
    pushEvent('response', [
      uid,
      err,
      resp.statusCode || null,
      resp.body || null,
      JSON.stringify(resp.headers || '{}'),
    ])
  })
})
