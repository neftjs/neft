const { Renderer, assert, utils } = Neft;
const { setPropertyValue } = Renderer.itemUtils;

class Switch extends Renderer.Native {
    setSelectedAnimated(val) {
        assert.isBoolean(val);
        setPropertyValue(this, 'selected', val);
        this.call('setSelectedAnimated', val);
    }
}

Switch.__name__ = 'DSSwitchItem';

Switch.Initialize = (item) => {
    item.on('selectedChange', function (val) {
        setPropertyValue(this, 'selected', val);
    });
};

Switch.defineProperty({
    enabled: utils.isIOS || utils.isAndroid,
    type: 'boolean',
    name: 'selected',
});

Switch.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'borderColor',
});

Switch.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'selectedColor',
});

Switch.defineProperty({
    enabled: utils.isIOS,
    type: 'color',
    name: 'thumbColor',
});

module.exports = Switch;
