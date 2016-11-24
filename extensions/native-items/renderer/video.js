const { Renderer, assert, utils } = Neft;

class Video extends Renderer.Native {
    start() {
        this.call('start');
    }
    stop() {
        this.call('stop');
    }
}

Video.__name__ = 'DSVideo';

Video.defineProperty({
    enabled: utils.isIOS,
    type: 'text',
    name: 'source'
});

Video.defineProperty({
    enabled: utils.isIOS,
    type: 'boolean',
    name: 'loop'
});

module.exports = Video
