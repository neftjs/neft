const log = require('../../../log')
const bridgeActions = require('../../actions')
const {
  EVENT_NULL_TYPE, EVENT_INTEGER_TYPE, EVENT_BOOLEAN_TYPE, EVENT_FLOAT_TYPE, EVENT_STRING_TYPE,
} = require('../../event-types')

module.exports = (bridge) => {
  const functions = {}

  const actions = []
  let actionsIndex = 0
  const booleans = []
  let booleansIndex = 0
  const integers = []
  let integersIndex = 0
  const floats = []
  let floatsIndex = 0
  const strings = []
  let stringsIndex = 0

  let readActionsIndex = 0
  let readBooleansIndex = 0
  let readIntegersIndex = 0
  let readFloatsIndex = 0
  let readStringsIndex = 0

  const startReading = () => {
    readActionsIndex = 0
    readBooleansIndex = 0
    readIntegersIndex = 0
    readFloatsIndex = 0
    readStringsIndex = 0
  }

  const readAction = () => {
    readActionsIndex += 1
    return actions[readActionsIndex - 1]
  }

  const readBoolean = () => {
    readBooleansIndex += 1
    return booleans[readBooleansIndex - 1]
  }

  const readInteger = () => {
    readIntegersIndex += 1
    return integers[readIntegersIndex - 1]
  }

  const readFloat = () => {
    readFloatsIndex += 1
    return floats[readFloatsIndex - 1]
  }

  const readString = () => {
    readStringsIndex += 1
    return strings[readStringsIndex - 1]
  }

  return {
    registerNativeFunction(name, func) {
      functions[name] = func
    },
    publishNativeEvent(name, ...args) {
      const outActions = [bridgeActions.in.EVENT]
      const outBooleans = []
      const outIntegers = [args.length]
      const outFloats = []
      const outStrings = [name]
      args.forEach((arg) => {
        if (arg == null) {
          outIntegers.push(EVENT_NULL_TYPE)
        } else if (typeof arg === 'boolean') {
          outIntegers.push(EVENT_BOOLEAN_TYPE)
          outBooleans.push(arg)
        } else if (typeof arg === 'number') {
          outIntegers.push(EVENT_FLOAT_TYPE)
          outFloats.push(arg)
        } else if (typeof arg === 'string') {
          outIntegers.push(EVENT_STRING_TYPE)
          outStrings.push(arg)
        } else {
          log.warn(`Event can be pushed with a null, boolean, number or string, but \`${arg}\` given`)
          outIntegers.push(EVENT_NULL_TYPE)
        }
      })
      bridge.onData(outActions, outBooleans, outIntegers, outFloats, outStrings)
    },
    sendData() {
      if (actionsIndex <= 0) return
      const length = actionsIndex

      actionsIndex = 0
      booleansIndex = 0
      integersIndex = 0
      floatsIndex = 0
      stringsIndex = 0

      startReading()

      for (let i = 0; i < length; i += 1) {
        const action = readAction()
        if (action === bridgeActions.out.CALL_FUNCTION) {
          const name = readString()
          const func = functions[name]
          const argsLength = readInteger()
          const args = []
          for (let j = 0; j < argsLength; j += 1) {
            const type = readInteger()
            switch (type) {
              case EVENT_NULL_TYPE:
                args.push(null)
                break
              case EVENT_BOOLEAN_TYPE:
                args.push(readBoolean())
                break
              case EVENT_INTEGER_TYPE:
                args.push(readInteger())
                break
              case EVENT_FLOAT_TYPE:
                args.push(readFloat())
                break
              case EVENT_STRING_TYPE:
                args.push(readString())
                break
              default:
            }
          }
          if (func == null) {
            log.warn(`Native function \`${name}\` not found`)
          } else {
            func(...args)
          }
        } else {
          log.warn(`Unknown event ${action} given`)
        }
      }
    },
    pushAction(val) {
      actions[actionsIndex] = val
      actionsIndex += 1
    },
    pushBoolean(val) {
      booleans[booleansIndex] = val
      booleansIndex += 1
    },
    pushInteger(val) {
      integers[integersIndex] = val
      integersIndex += 1
    },
    pushFloat(val) {
      floats[floatsIndex] = val
      floatsIndex += 1
    },
    pushString(val) {
      strings[stringsIndex] = val
      stringsIndex += 1
    },
  }
}
