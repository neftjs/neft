const fs = require('fs').promises
const { logger } = require('@neft/core')
const { parseArgv } = require('./argv-parser')
const { build } = require('./builder')
const { run } = require('./runner')
const { clean } = require('./cleaner')

module.exports = async (argv) => {
  const { operation, target, args } = parseArgv(argv)

  await fs.realpath('.') // show warning log first

  if (operation === 'build' || operation === 'run') {
    try {
      await build(target, args)
    } catch (error) {
      logger.error(error.constructor === Error ? error.message : error.stack)
      process.exit(1)
    }
  }

  if (operation === 'run') {
    run(target, args)
  }

  if (operation === 'clean') {
    clean()
  }
}
