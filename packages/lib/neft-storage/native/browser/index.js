/* global localStorage */

const { NativeServerBinding } = require('@neft/core')

const { onCall, pushEvent } = new NativeServerBinding('Storage')

onCall('get', (uid, key) => {
  pushEvent('response', [uid, null, localStorage.getItem(key)])
})

onCall('set', (uid, key, value) => {
  localStorage.setItem(key, value)
  pushEvent('response', [uid])
})

onCall('remove', (uid, key) => {
  localStorage.removeItem(key)
  pushEvent('response', [uid])
})
