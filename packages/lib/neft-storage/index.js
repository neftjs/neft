const { NativeClientBinding } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('Storage')

let nextUid = 0
const requests = Object.create(null)

onNativeEvent('response', (uid, error, value) => {
  const request = requests[uid]
  if (!request) return
  delete requests[uid]
  if (error) request.reject(error)
  else request.resolve(value)
})

exports.get = key => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction('get', String(nextUid), String(key))
})

exports.set = (key, value) => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction('set', String(nextUid), String(key), String(value))
})

exports.remove = key => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction('remove', String(nextUid), String(key))
})
