const { Renderer, assert, utils, signal } = Neft;
const { setPropertyValue } = Renderer.itemUtils;
const { emitSignal } = signal.Emitter

class Scrollable extends Renderer.Native {}

Scrollable.__name__ = 'DSScrollable';

Scrollable.Initialize = (item) => {
    item.on('contentXChange', function (val) {
        setPropertyValue(this, 'contentX', val);
    });

    item.on('contentYChange', function (val) {
        setPropertyValue(this, 'contentY', val);
    });
};

Scrollable.defineProperty({
    enabled: true,
    type: 'item',
    name: 'contentItem',
    defaultValue: null,
    setter: function (_super) {
        return function (val) {
            if (val != null) {
                val.parent = null;
                val._parent = this;
                emitSignal(val, 'onParentChange', null);
            }
            _super.call(this, val);
        };
    }
});

Scrollable.defineProperty({
    enabled: true,
    type: 'number',
    name: 'contentX',
    defaultValue: 0
});

Scrollable.defineProperty({
    enabled: true,
    type: 'number',
    name: 'contentY',
    defaultValue: 0
});

module.exports = Scrollable;
