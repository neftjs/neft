'use strict'

assert = require '../../assert'

WIDTH_PROPS = ['width', 'anchors.fill', 'anchors.fillWidth', 'layout.fillWidth']
HEIGHT_PROPS = ['height', 'anchors.fill', 'anchors.fillHeight', 'layout.fillHeight']

module.exports = (Renderer) ->
    hasOneOfProps = (item, props) ->
        assert.instanceOf item, Renderer.Item
        for ext in item._extensions
            unless ext instanceof Renderer.Class
                continue
            attributes = ext.changes._attributes
            bindings = ext.changes._bindings
            for prop in props
                if attributes[prop]? or bindings[prop]?
                    return true
        false

    isAutoWidth: (item) ->
        not hasOneOfProps(item, WIDTH_PROPS)

    isAutoHeight: (item) ->
        not hasOneOfProps(item, HEIGHT_PROPS)
