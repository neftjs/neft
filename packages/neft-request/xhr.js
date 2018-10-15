const getHeadersFromXhr = (xhr) => {
  const result = {}
  const headers = xhr.getAllResponseHeaders()
  const lines = headers.trim().split(/[\r\n]+/)
  lines.forEach((line) => {
    const parts = line.split(': ')
    const header = parts.shift()
    const value = parts.join(': ')
    result[header] = value
  })
  return result
}

exports.send = ({
  method, uri, headers, body, callback,
}) => {
  const xhr = new global.XMLHttpRequest()
  xhr.open(method, uri, true)
  Object.keys(headers).forEach((key) => {
    xhr.setRequestHeader(key, headers[key])
  })
  xhr.onload = () => {
    callback(null, {
      statusCode: xhr.status,
      body: xhr.response,
      headers: getHeadersFromXhr(xhr),
    })
  }
  xhr.onerror = () => { callback(`${xhr.status} ${xhr.response}`, {}) }
  xhr.send(body)
}
