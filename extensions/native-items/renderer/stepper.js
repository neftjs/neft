const { Renderer, assert, utils } = Neft;
const { setPropertyValue } = Renderer.itemUtils;

class Stepper extends Renderer.Native {}

Stepper.__name__ = 'DSStepper';

Stepper.Initialize = (item) => {
    item.on('valueChange', function (val) {
        setPropertyValue(this, 'value', val);
    });
};

Stepper.defineProperty({
    enabled: utils.isIOS,
    type: 'number',
    name: 'value',
});

Stepper.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'color',
});

Stepper.defineProperty({
    enabled: utils.isIOS,
    type: 'number',
    name: 'minValue',
});

Stepper.defineProperty({
    enabled: utils.isIOS,
    type: 'number',
    name: 'maxValue',
    defaultValue: 100,
});

Stepper.defineProperty({
    enabled: utils.isIOS,
    type: 'number',
    name: 'stepValue',
    defaultValue: 1,
});

module.exports = Stepper;
