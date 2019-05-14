const { Renderer, SignalsEmitter } = require('@neftio/core')

class GestureRecognizer extends Renderer.Native {}

SignalsEmitter.createSignal(GestureRecognizer, 'onPinch', (self) => {
  self.call('startRecognizingPinch')
  self.on('pinch', function (focusX, focusY, scale) {
    this.onPinch.emit({ focusX, focusY, scale })
  }, self)
})

module.exports = GestureRecognizer
