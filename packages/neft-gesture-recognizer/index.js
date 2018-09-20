const { Renderer, signal } = Neft

class GestureRecognizer extends Renderer.Native {}

signal.Emitter.createSignal(GestureRecognizer, 'onPinch', (self) => {
  self.call('startRecognizingPinch')
  self.on('pinch', function (focusX, focusY, scale) {
    this.onPinch.emit({ focusX, focusY, scale })
  }, self)
})

module.exports = GestureRecognizer
