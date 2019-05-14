const log = require('@neftio/core/src/log')
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
  log.log('**Neftio CLI**\n')
  log.log('npx neftio <u>operation</u> <u>target</u>')
  log.log(`           <u>operation</u> = ${listToLog(possibleOperations)}`)
  log.log(`           <u>target</u> = ${listToLog(possibleTargets)}\n`)
  log.log('<u>operation:</u>')
  log.log('init       creates basic files inside your project')
  log.log('build      builds given target without running it')
  log.log('run        builds given target and runs it')
  log.log('clean      removes temporary files and built targets\n')
  log.log('<u>arguments:</u>')
  log.log('--production       creates production build')
  log.log('')
}

exports.parseArgv = ([operation, target, ...rest]) => {
  if (!operations[operation]) {
    if (operation) {
      log.error(`Unknown operation ${operation} given; expected ${listToLog(possibleOperations)}`)
    } else {
      printHelp()
    }
    log.log('Example: `npx neftio run html`')
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
