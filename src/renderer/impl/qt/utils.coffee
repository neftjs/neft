colorUtils = require '../../utils/color'

exports.DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

exports.createQmlObject = do ->
    components = {}

    createItemComponent = (type) ->
        qmlStr = "import QtQuick 2.3; Component { #{type} }"
        components[type] = Qt.createQmlObject qmlStr, __stylesHatchery

    (type, parent=null) ->
        component = components[type] or createItemComponent(type)
        component.createObject(parent)

exports.toQtColor = (color, defaultColor='transparent') ->
    hex = colorUtils.toRGBAHex color, defaultColor
    a = color & 0xFF
    b = color >>> 8 & 0xFF
    g = color >>> 16 & 0xFF
    r = color >>> 24 & 0xFF
    Qt.rgba r / 255, g / 255, b / 255, a / 255

exports.toUrl = (url) ->
    if typeof url isnt 'string' or ///^[a-zA-Z]+?:\/\////.test(url)
        url
    else
        if url[0] isnt '/'
            url = "/#{url}"
        require('renderer').serverUrl + url
