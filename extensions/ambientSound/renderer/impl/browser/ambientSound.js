// when=NEFT_BROWSER

const { Renderer, signal } = Neft;
const { Item } = Renderer.Impl.Types;

exports.create = function (data) {
    const elem = document.createElement('audio');
    data.elem = elem;
    data.elem.setAttribute('preload', 'auto');
    data.elem.addEventListener('ended', () => {
        data.onStop.emit();
    })
    Item.create.call(this, data);
};

exports.createData = function () {
    const data = Item.createData();
    data.onStop = signal.create();
    return data;
};

exports.setAmbientSoundSource = function(val) {
    this._impl.elem.setAttribute('src', val);
};

exports.setAmbientSoundLoop = function(val) {
    this._impl.elem.setAttribute('loop', val);
};

exports.setAmbientSoundRunning = function(val) {
    const { elem } = this._impl;
    if (val) {
        elem.play();
        if (elem.readyState === elem.HAVE_ENOUGH_DATA) {
            elem.currentTime = 0;
        }
    } else {
        elem.pause();
    }
};
