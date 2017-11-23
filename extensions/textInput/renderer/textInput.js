const { Renderer, assert, utils, signal } = Neft;
const { setPropertyValue } = Renderer.itemUtils;
const { emitSignal } = signal.Emitter
const { Impl } = Renderer;

class TextInput extends Renderer.Native {}

TextInput.__name__ = 'TextInput';

TextInput.Initialize = (item) => {
    item.on('textChange', function (val) {
        setPropertyValue(this, 'text', val);
    });
};

TextInput.defineProperty({
    type: 'text',
    name: 'text',
    defaultValue: ''
});

TextInput.defineProperty({
    type: 'color',
    name: 'textColor'
});

if (process.env.NEFT_HTML) {
    Impl.addTypeImplementation('TextInput', require('./impl/css/textInput'));
}

module.exports = TextInput;
