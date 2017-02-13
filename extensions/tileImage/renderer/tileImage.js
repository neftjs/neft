const { Renderer, assert, utils } = Neft;
const { Impl } = Renderer;

class TileImage extends Renderer.Native {}

TileImage.__name__ = 'TileImage';

function getResourceResolutionByPath(rsc, path) {
    for (const format of rsc.formats) {
        const paths = rsc.paths[format];
        if (!paths) {
            continue;
        }
        for (const resolution in paths) {
            if (paths[resolution] === path) {
                return parseFloat(resolution);
            }
        }
    }
    return 1;
}

TileImage.defineProperty({
    type: 'text',
    name: 'source',
    implementationValue: (function () {
        const RESOURCE_REQUEST = {
            resolution: 1
        };
        if (typeof requestAnimationFrame === 'function') {
            requestAnimationFrame(() => {
                RESOURCE_REQUEST.resolution = Renderer.Device.pixelRatio;
            });
        }
        return function (val) {
            const { resources } = Renderer;
            const res = resources && resources.getResource(val);
            if (res) {
                const path = res.resolve(RESOURCE_REQUEST);
                this.set('resolution', getResourceResolutionByPath(res, path));
                return path;
            }
            return val;
        }
    }())
});

if (utils.isBrowser) {
    Impl.addTypeImplementation('TileImage', require('./impl/css/tileImage'));
}

module.exports = TileImage
