const log = require('@neft/core/src/log')
const {
  operations, operationsWithoutTarget, targets, args,
} = require('./config')

const possibleOperations = Object.keys(operations)
const possibleTargets = Object.keys(targets)

const listToLog = list => list.reduce((result, element, index) => {
  let suffix = ', '
  if (index === list.length - 1) suffix = ''
  if (index === list.length - 2) suffix = ' or '
  return `${result}\`${element}\`${suffix}`
}, '')

exports.parseArgv = ([operation, target, ...rest]) => {
  if (!operations[operation]) {
    if (operation) {
      log.error(`Unknown operation ${operation} given; expected ${listToLog(possibleOperations)}`)
    } else {
      log.error(`No operation specified; try ${listToLog(possibleOperations)}`)
    }
    log.log('Example: `neft run html`')
    process.exit(1)
  }

  if (!operationsWithoutTarget[operation] && !targets[target]) {
    log.error(`Unknown target ${target} given; expected ${listToLog(possibleTargets)}`)
    log.info(`Example: \`neft ${operation} html\``)
    process.exit(1)
  }

  const foundArgs = { [operation]: true }
  rest.forEach((arg) => {
    if (!arg.startsWith('--')) {
      log.warning(`Argument \`${arg}\` must starts with --`)
      return
    }
    if (!args[arg.slice(2)]) {
      log.warning(`Unknown argument \`${arg}\``)
      return
    }
    foundArgs[arg.slice(2)] = true
  })

  return { operation, target, args: foundArgs }
}
