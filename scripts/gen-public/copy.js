const fs = require('fs-extra')
const glob = require('glob')
const path = require('path')
const { promisify } = require('util')

const { COPY } = require('./config')

module.exports = async () => {
  await Promise.all(COPY.map(async ({ cwd = '', in: inpath, out }) => {
    const filenames = await promisify(glob)(inpath, { cwd: path.join(process.cwd(), cwd) })
    await Promise.all(filenames.map((filename) => {
      const from = path.join(cwd, filename)
      const to = path.join(out, filename)
      return fs.copy(from, to)
    }))
  }))
}
