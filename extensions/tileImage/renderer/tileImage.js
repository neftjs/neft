const { Renderer, assert, utils, Resources } = Neft;
const { Impl } = Renderer;

const log = Neft.log.scope('Extensions', 'TileImage');

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
            if (Resources.testUri(val)) {
                const res = Renderer.getResource(val);
                if (res) {
                    const path = res.resolve(RESOURCE_REQUEST);
                    this.set('resolution', getResourceResolutionByPath(res, path));
                    return path;
                } else {
                    log.warn(`Unknown resource given \`${val}\``);
                    return '';
                }
            }
            return val;
        }
    }())
});

if (process.env.NEFT_HTML) {
    Impl.addTypeImplementation('TileImage', require('./impl/css/tileImage'));
}

module.exports = TileImage
