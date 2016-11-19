const { Renderer, assert, utils, signal } = Neft;
const { setPropertyValue } = Renderer.itemUtils;
const { emitSignal } = signal.Emitter

class TextInput extends Renderer.Native {}

TextInput.__name__ = 'DSTextInput';

TextInput.Initialize = (item) => {
    item.on('textChange', function (val) {
        setPropertyValue(this, 'text', val);
    });
};

TextInput.defineProperty({
    enabled: true,
    type: 'text',
    name: 'text',
    defaultValue: ''
});

TextInput.defineProperty({
    enabled: true,
    type: 'color',
    name: 'textColor'
});

module.exports = TextInput;
