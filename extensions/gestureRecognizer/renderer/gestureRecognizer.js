const { Renderer, signal } = Neft;

class GestureRecognizer extends Renderer.Native {}

GestureRecognizer.__name__ = 'GestureRecognizer';

signal.Emitter.createSignal(GestureRecognizer, 'onPinch', function(self) {
    self.call('startRecognizingPinch')
    self.on('pinch', function (focusX, focusY, scale) {
        this.onPinch.emit({ focusX, focusY, scale })
    }, self)
})

module.exports = GestureRecognizer;
