const log = require('@neft/core/src/log')
const assert = require('@neft/core/src/assert')
const Renderer = require('@neft/core/src/renderer')

const { setPropertyValue } = Renderer.itemUtils
const { Impl } = Renderer

const PREVENT_CLICK_MIN_PX = 10

class Scrollable extends Renderer.Native {
  scrollTo(x, y, opts) {
    const animate = opts ? opts.animate : false
    assert.isFloat(x)
    assert.isFloat(y)
    assert.isBoolean(animate)
    if (animate) {
      this.call('animatedScrollTo', x, y)
    } else {
      this.contentX = x
      this.contentY = y
    }
  }
}

Scrollable.Initialize = (item) => {
  item.on('contentXChange', function (val) {
    const { contentItem } = this
    setPropertyValue(this, 'contentX', val)
    if (contentItem) contentItem._x = -val
  })

  item.on('contentYChange', function (val) {
    const { contentItem } = this
    setPropertyValue(this, 'contentY', val)
    if (contentItem) contentItem._y = -val
  })

  let pressX = 0; let pressY = 0; let
    prevented = false

  item.pointer.onPress.connect((event) => {
    pressX = event.x
    pressY = event.y
    prevented = false
  })

  item.pointer.onMove.connect((event) => {
    if (prevented) {
      return
    }
    const dx = Math.abs(pressX - event.x)
    const dy = Math.abs(pressY - event.y)
    if (Math.sqrt(dx * dx + dy * dy) > PREVENT_CLICK_MIN_PX) {
      event.preventClick = true
      prevented = true
    }
  })
}

Scrollable.defineProperty({
  enabled: true,
  type: 'item',
  name: 'contentItem',
  defaultValue: null,
  setter(_super) {
    function onPositionChange() {
      log.warn('Scrollable::contentItem position cannot be changed manually')
      this.x = 0
      this.y = 0
    }

    return function (val) {
      const oldVal = this.contentItem
      if (oldVal != null) {
        oldVal.parent = null
        oldVal.onXChange.disconnect(onPositionChange, oldVal)
        oldVal.onYChange.disconnect(onPositionChange, oldVal)
      }
      if (val != null) {
        // put item as a most bottom child to support pointer events and bindings
        val.parent = this
        val.previousSibling = null
        val.x = 0
        val.y = 0
        val.onXChange.connect(onPositionChange, val)
        val.onYChange.connect(onPositionChange, val)
      }
      _super.call(this, val)
    }
  },
})

Scrollable.defineProperty({
  type: 'boolean',
  name: 'clip',
  defaultValue: true,
  setter: null,
})

Scrollable.defineProperty({
  type: 'number',
  name: 'contentX',
  defaultValue: 0,
  setter(_super) {
    return function (val) {
      const { contentItem } = this
      _super.call(this, val)
      if (contentItem) contentItem._x = -val
    }
  },
})

Scrollable.defineProperty({
  type: 'number',
  name: 'contentY',
  defaultValue: 0,
  setter(_super) {
    return function (val) {
      const { contentItem } = this
      _super.call(this, val)
      if (contentItem) contentItem._y = -val
    }
  },
})

Scrollable.defineProperty({
  type: 'boolean',
  name: 'horizontalScrollBar',
  defaultValue: true,
})

Scrollable.defineProperty({
  type: 'boolean',
  name: 'verticalScrollBar',
  defaultValue: true,
})

Scrollable.defineProperty({
  type: 'boolean',
  name: 'horizontalScrollEffect',
  defaultValue: true,
})

Scrollable.defineProperty({
  type: 'boolean',
  name: 'verticalScrollEffect',
  defaultValue: true,
})

if (process.env.NEFT_HTML) {
  Impl.addTypeImplementation('Scrollable', require('./impl/css/scrollable'))
}

if (process.env.NEFT_WEBGL) {
  Impl.addTypeImplementation('Scrollable', require('./impl/base/scrollable'))
}

module.exports = Scrollable
