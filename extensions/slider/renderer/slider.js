const { Renderer, assert } = Neft;
const { setPropertyValue } = Renderer.itemUtils;

class Slider extends Renderer.Native {
    setValueAnimated(val) {
        assert.isBoolean(val);
        setPropertyValue(this, 'value', val);
        this.call('setValueAnimated', val);
    }
}

Slider.__name__ = 'Slider';

Slider.Initialize = (item) => {
    item.on('valueChange', function (val) {
        setPropertyValue(this, 'value', val);
    });
};

Slider.defineProperty({
    type: 'number',
    name: 'value',
    defaultValue: 0
});

Slider.defineProperty({
    type: 'color',
    name: 'thumbColor'
});

Slider.defineProperty({
    type: 'color',
    name: 'minTrackColor'
});

Slider.defineProperty({
    type: 'color',
    name: 'maxTrackColor'
});

Slider.defineProperty({
    type: 'number',
    name: 'minValue',
    defaultValue: 0
});

Slider.defineProperty({
    type: 'number',
    name: 'maxValue',
    defaultValue: 1
});

module.exports = Slider;
