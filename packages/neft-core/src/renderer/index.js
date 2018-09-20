const signal = require('../signal')
const assert = require('../assert')

signal.create(exports, 'onReady')
signal.create(exports, 'onWindowItemChange')
signal.create(exports, 'onLinkUri')

const Impl = require('./impl')(exports)

exports.Impl = {
  addTypeImplementation: Impl.addTypeImplementation,
  Types: Impl.Types,
  onWindowItemReady: Impl.onWindowItemReady,
  utils: Impl.utils,
}

const itemUtils = require('./utils/item')(exports, Impl)

exports.itemUtils = itemUtils

exports.sizeUtils = require('./utils/size')(exports)

exports.colorUtils = require('./utils/color')

exports.Screen = require('./types/namespace/screen')(exports, Impl, itemUtils)

exports.Device = require('./types/namespace/device')(exports, Impl, itemUtils)

exports.Navigator = require('./types/namespace/navigator')(exports, Impl, itemUtils)

exports.Extension = require('./types/extension')(exports, Impl, itemUtils)

exports.Class = require('./types/extensions/class')(exports, Impl, itemUtils)

exports.Animation = require('./types/extensions/animation')(exports, Impl, itemUtils)

exports.PropertyAnimation = require('./types/extensions/animation/types/property')(exports, Impl, itemUtils)

exports.NumberAnimation = require('./types/extensions/animation/types/property/types/number')(exports, Impl, itemUtils)

exports.SequentialAnimation = require('./types/extensions/animation/types/sequential')(exports, Impl, itemUtils)

exports.ParallelAnimation = require('./types/extensions/animation/types/parallel')(exports, Impl, itemUtils)

exports.Transition = require('./types/extensions/transition')(exports, Impl, itemUtils)

exports.Item = require('./types/basics/item')(exports, Impl, itemUtils)

exports.Image = require('./types/basics/image')(exports, Impl, itemUtils)

exports.Text = require('./types/basics/text')(exports, Impl, itemUtils)

exports.Native = require('./types/basics/native')(exports, Impl, itemUtils)

exports.Rectangle = require('./types/shapes/rectangle')(exports, Impl, itemUtils)

exports.Grid = require('./types/layout/grid')(exports, Impl, itemUtils)

exports.Column = require('./types/layout/column')(exports, Impl, itemUtils)

exports.Row = require('./types/layout/row')(exports, Impl, itemUtils)

exports.Flow = require('./types/layout/flow')(exports, Impl, itemUtils)

exports.ResourcesLoader = require('./types/loader/resources')(exports, Impl, itemUtils)

exports.FontLoader = require('./types/loader/font')(exports, Impl, itemUtils)

exports.setWindowItem = function (val) {
  assert.instanceOf(val, exports.Item)
  Impl.setWindow(val)
  exports.onWindowItemChange.emit(null)
}

exports.setServerUrl = function (val) {
  Impl.serverUrl = val
}

exports.setResources = function (val) {
  Impl.resources = val
}

exports.getResource = function (path) {
  let ref
  return (ref = Impl.resources) != null ? ref.getResource(path) : void 0
}

exports.onReady.emit()
