const { Renderer, Resources, log } = Neft
const { setPropertyValue } = Renderer.itemUtils
const { Impl } = Renderer

class AmbientSound extends Renderer.Native {}

AmbientSound.Initialize = (item) => {
  item.on('stop', function () {
    setPropertyValue(this, 'running', false)
  })
}

AmbientSound.defineProperty({
  type: 'text',
  name: 'source',
  implementationValue(val) {
    if (Resources.testUri(val)) {
      const res = Renderer.getResource(val)
      if (res) {
        return res.resolve()
      }
      log.warn(`Unknown resource given \`${val}\``)
      return ''
    }
    return val
  },
})

AmbientSound.defineProperty({
  type: 'boolean',
  name: 'loop',
})

AmbientSound.defineProperty({
  type: 'boolean',
  name: 'running',
})

if (process.env.NEFT_BROWSER) {
  Impl.addTypeImplementation('AmbientSound', require('./impl/browser/ambientSound'))
}

module.exports = AmbientSound
