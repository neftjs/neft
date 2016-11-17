const { Renderer, assert, utils } = Neft;

class Button extends Renderer.Native {}

Button.__name__ = 'DSButtonItem';

Button.defineProperty({
    enabled: utils.isIOS || utils.isBrowser || utils.isAndroid,
    type: 'text',
    name: 'text'
});

Button.defineProperty({
    enabled: utils.isIOS || utils.isBrowser || utils.isAndroid,
    type: 'color',
    name: 'textColor'
});

module.exports = Button
