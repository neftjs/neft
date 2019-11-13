const { NativeStyleItem, SignalsEmitter } = require('@neft/core')

class Scanner extends NativeStyleItem {}

Scanner.__name__ = 'Scanner'

SignalsEmitter.createSignal(Scanner, 'onScanned')

Scanner.Initialize = (item) => {
  item.on('scanned', function (value) {
    this.emit('onScanned', String(value))
  })
}

module.exports = Scanner
