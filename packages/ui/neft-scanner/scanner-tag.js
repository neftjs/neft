const { CustomTag } = require('@neft/core')

class ScannerTag extends CustomTag {}

ScannerTag.registerAs('scanner')

ScannerTag.defineStyleSignal({
  signalName: 'onScanned',
})

module.exports = ScannerTag
