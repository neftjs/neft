const { logger } = require('@neft/core')
const {
  operations, operationsWithoutTarget, targets, args,
} = require('./config')

const possibleOperations = Object.keys(operations)
const possibleTargets = Object.keys(targets)

const listToLog = list => list.reduce((result, element, index) => {
  let suffix = ', '
  if (index === list.length - 1) suffix = ''
  if (index === list.length - 2) suffix = ' or '
  return `${result}${element}${suffix}`
}, '')

const printHelp = () => {
  logger.log('**Neft CLI**\n')
  logger.log('npx neft <u>operation</u> <u>target</u>')
  logger.log(`         <u>operation</u> = ${listToLog(possibleOperations)}`)
  logger.log(`         <u>target</u> = ${listToLog(possibleTargets)}\n`)
  logger.log('<u>operation:</u>')
  logger.log('build      builds given target without running it')
  logger.log('run        builds given target and runs it')
  logger.log('clean      removes temporary files and built targets\n')
  logger.log('<u>arguments:</u>')
  logger.log('--production       creates production build')
  logger.log('')
}

exports.parseArgv = ([operation, target, ...rest]) => {
  if (!operations[operation]) {
    if (operation) {
      logger.error(`Unknown operation ${operation} given; expected ${listToLog(possibleOperations)}`)
    } else {
      printHelp()
    }
    logger.log('Example: `npx neft run html`')
    process.exit(1)
  }

  if (!operationsWithoutTarget[operation] && !targets[target]) {
    logger.error(`Unknown target ${target} given; expected ${listToLog(possibleTargets)}`)
    logger.info(`Example: \`neft ${operation} html\``)
    process.exit(1)
  }

  const foundArgs = { [operation]: true }
  rest.forEach((arg) => {
    if (!arg.startsWith('--')) {
      logger.warning(`Argument \`${arg}\` must starts with --`)
      return
    }
    if (!args[arg.slice(2)]) {
      logger.warning(`Unknown argument \`${arg}\``)
      return
    }
    foundArgs[arg.slice(2)] = true
  })

  return { operation, target, args: foundArgs }
}
