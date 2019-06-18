const less = require('less')
const fs = require('fs-extra')
const path = require('path')
const { promisify } = require('util')
const { STYLE } = require('./config')

/*
Generates one CSS file from LESS styles.
*/
module.exports = async () => {
  const file = await fs.readFile(STYLE.in, 'utf-8')

  const result = await promisify(less.render).call(less, file, {
    paths: [path.dirname(STYLE.in)],
    filename: path.basename(STYLE.in),
  })

  return fs.outputFile(STYLE.out, result.css)
}
