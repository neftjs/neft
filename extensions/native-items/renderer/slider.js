const { Renderer, assert, utils } = Neft;
const { setPropertyValue } = Renderer.itemUtils;

class Slider extends Renderer.Native {
    setValueAnimated(val) {
        assert.isBoolean(val);
        setPropertyValue(this, 'value', val);
        this.call('setValueAnimated', val);
    }
}

Slider.__name__ = 'DSSlider';

Slider.Initialize = (item) => {
    item.on('valueChange', function (val) {
        setPropertyValue(this, 'value', val);
    });
};

Slider.defineProperty({
    enabled: utils.isIOS || utils.isAndroid,
    type: 'number',
    name: 'value',
    defaultValue: 0
});

Slider.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'thumbColor'
});

Slider.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'minTrackColor'
});

Slider.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'maxTrackColor'
});

Slider.defineProperty({
    enabled: utils.isIOS || utils.isAndroid,
    type: 'number',
    name: 'minValue',
    defaultValue: 0
});

Slider.defineProperty({
    enabled: utils.isIOS || utils.isAndroid,
    type: 'number',
    name: 'maxValue',
    defaultValue: 1
});

module.exports = Slider;
