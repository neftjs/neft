const log = require('@neftio/core/src/log')
const { parseArgv } = require('./argv-parser')
const { initialize } = require('./initializer')
const { build } = require('./builder')
const { run } = require('./runner')
const { clean } = require('./cleaner')

module.exports = async (argv) => {
  const { operation, target, args } = parseArgv(argv)
  if (operation === 'init') {
    initialize()
  }

  if (operation === 'build' || operation === 'run') {
    try {
      await build(target, args)
    } catch (error) {
      log.error(error.constructor === Error ? error.message : error.stack)
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
