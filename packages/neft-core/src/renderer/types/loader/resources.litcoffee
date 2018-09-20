# ResourcesLoader

Access it with:
```javascript
ResourcesLoader {}
```

Example:

```javascript
Item {
    ResourcesLoader {
        id: loader
        resources: app.resources
    }
    Text {
        text: 'Progress: ' + loader.progress * 100 + '%'
    }
}
```

    'use strict'

    assert = require '../../../assert'
    utils = require '../../../util'
    log = require '../../../log'
    signal = require '../../../signal'
    Resources = require '../../../resources'

    log = log.scope 'Renderer', 'ResourcesLoader'

    module.exports = (Renderer, Impl, itemUtils) -> class ResourcesLoader extends itemUtils.FixedObject
        @__name__ = 'ResourcesLoader'
        @__path__ = 'Renderer.ResourcesLoader'

        FONT_FORMATS =
            ttf: true
            otf: true
            woff: true

        IMAGE_FORMATS =
            png: true
            jpg: true
            jpeg: true

        matchFormats = (formats, rscFormats) ->
            for format in rscFormats
                if formats[format]
                    return true
            false

        onLoadEnd = (loader) ->
            loader.progress = ++loader._loaded / loader._length
            return

        loadResource = (loader, resource, uri) ->
            loader._length += 1

            onLoadedChange = ->
                onLoadEnd loader

            # load font
            if matchFormats(FONT_FORMATS, resource.formats)
                if resource.name
                    fontLoader = Renderer.FontLoader.New()
                    fontLoader.onLoadedChange onLoadedChange
                    fontLoader.name = resource.name
                    fontLoader.source = uri
                else
                    onLoadEnd loader
                    log.warn """
                        ResourcesLoader cannot load font #{uri} because of missed name;
                        specify name for each font resource in config file and \
                        remove unnecessary FontLoader's
                    """

            # load image
            else if matchFormats(IMAGE_FORMATS, resource.formats)
                imageLoader = Renderer.Image.New()
                imageLoader.onLoadedChange onLoadedChange
                imageLoader.source = uri

            # unknown type
            else
                onLoadEnd loader
                log.warn """
                    ResourcesLoader cannot detect resource #{uri} with formats #{resource.formats}
                """
            return

        loadResources = (loader, resources, uri = 'rsc:') ->
            loader._length += 1
            for key, val of resources when resources.hasOwnProperty(key)
                rscUri = "#{uri}/#{key}"
                if val instanceof Resources.Resource
                    loadResource loader, val, rscUri
                else
                    loadResources loader, val, rscUri
            onLoadEnd loader
            return

## *ResourcesLoader* ResourcesLoader.New([*Object* options])

        @New = (opts) ->
            item = new ResourcesLoader
            itemUtils.Object.initialize item, opts
            item

        constructor: ->
            super()
            @_resources = null
            @_progress = 0
            @_length = 0
            @_loaded = 0

## *Resources* ResourcesLoader::resources

        utils.defineProperty @::, 'resources', null, ->
            @_resources
        , (val) ->
            assert.isNotDefined @_resources, """
                ResourcesLoader.resources is already set and cannot be changed
            """
            if typeof val is 'string'
                val = Impl.resources.getResource val
            assert.instanceOf val, Resources
            @progress = 0
            @_length = 0
            @_loaded = 0
            @_resources = val
            loadResources @, val
            return

## ReadOnly *Float* ResourcesLoader::progress = `0`

## *Signal* ResourcesLoaded::onProgressChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'progress'
            developmentSetter: (val) ->
                assert.isFloat val
