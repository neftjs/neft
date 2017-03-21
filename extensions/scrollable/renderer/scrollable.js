const { Renderer, assert, utils, signal } = Neft;
const { setPropertyValue } = Renderer.itemUtils;
const { emitSignal } = signal.Emitter;
const { Impl } = Renderer;

const PREVENT_CLICK_MIN_PX = 10;

class Scrollable extends Renderer.Native {}

Scrollable.__name__ = 'Scrollable';

Scrollable.Initialize = (item) => {
    item.on('contentXChange', function (val) {
        setPropertyValue(this, 'contentX', val);
    });

    item.on('contentYChange', function (val) {
        setPropertyValue(this, 'contentY', val);
    });

    let pressX = 0, pressY = 0, prevented = false;

    item.pointer.onPress((event) => {
        pressX = event.x;
        pressY = event.y;
        prevented = false;
    });

    item.pointer.onMove((event) => {
        if (prevented) {
            return;
        }
        const dx = Math.abs(pressX - event.x);
        const dy = Math.abs(pressY - event.y);
        if (Math.sqrt(dx * dx + dy * dy) > PREVENT_CLICK_MIN_PX) {
            event.preventClick = true;
            prevented = true;
        }
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

if (utils.isBrowser) {
    Impl.addTypeImplementation('Scrollable', require('./impl/css/scrollable'));
}

if (!utils.isBrowser && !utils.isAndroid && !utils.isIOS) {
    Impl.addTypeImplementation('Scrollable', require('./impl/base/scrollable'));
}

module.exports = Scrollable;
