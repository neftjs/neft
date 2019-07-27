const cp = require('child_process')

module.exports = (...args) => new Promise((resolve, reject) => {
  const child = cp.spawn(...args)
  let stdout = ''
  let stderr = ''
  child.stdout.on('data', (data) => {
    stdout += data
  })
  child.stderr.on('data', (data) => {
    stderr += data
  })
  child.on('close', (code) => {
    if (code === 0) {
      resolve(stdout)
    } else {
      reject(stderr)
    }
  })
})
