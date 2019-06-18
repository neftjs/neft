const {
  callNativeFunction, onNativeEvent, registerNativeFunction, publishNativeEvent,
} = require('@neft/core')

const NATIVE_PREFIX = 'NeftStorage'
const GET = `${NATIVE_PREFIX}/get`
const SET = `${NATIVE_PREFIX}/set`
const REMOVE = `${NATIVE_PREFIX}/remove`
const ON_RESPONSE = `${NATIVE_PREFIX}/response`

let nextUid = 0
const requests = Object.create(null)

onNativeEvent(ON_RESPONSE, (uid, error, value) => {
  const request = requests[uid]
  if (!request) return
  delete requests[uid]
  if (error) request.reject(error)
  else request.resolve(value)
})

registerNativeFunction(GET, (uid) => {
  publishNativeEvent(ON_RESPONSE, uid, 'Not implemented')
})

registerNativeFunction(SET, (uid) => {
  publishNativeEvent(ON_RESPONSE, uid, 'Not implemented')
})

registerNativeFunction(REMOVE, (uid) => {
  publishNativeEvent(ON_RESPONSE, uid, 'Not implemented')
})

exports.get = key => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction(GET, String(nextUid), String(key))
})

exports.set = (key, value) => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction(SET, String(nextUid), String(key), String(value))
})

exports.remove = key => new Promise((resolve, reject) => {
  nextUid += 1
  requests[nextUid] = { resolve, reject }
  callNativeFunction(REMOVE, String(nextUid), String(key))
})
