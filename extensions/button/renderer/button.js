const { Renderer, assert, utils } = Neft;
const { Impl } = Renderer;

class Button extends Renderer.Native {}

Button.__name__ = 'Button';

Button.defineProperty({
    type: 'text',
    name: 'text'
});

Button.defineProperty({
    type: 'color',
    name: 'textColor'
});

if (process.env.NEFT_HTML) {
    Impl.addTypeImplementation('Button', require('./impl/css/button'));
}

module.exports = Button
