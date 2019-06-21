const { Renderer } = require('@neft/core')

const { setPropertyValue } = Renderer.itemUtils

class Stepper extends Renderer.Native {}

Stepper.Initialize = (item) => {
  item.on('valueChange', function (val) {
    setPropertyValue(this, 'value', val)
  })
}

Stepper.defineProperty({
  type: 'number',
  name: 'value',
})

Stepper.defineProperty({
  type: 'color',
  name: 'color',
})

Stepper.defineProperty({
  type: 'number',
  name: 'minValue',
})

Stepper.defineProperty({
  type: 'number',
  name: 'maxValue',
  defaultValue: 100,
})

Stepper.defineProperty({
  type: 'number',
  name: 'stepValue',
  defaultValue: 1,
})

module.exports = Stepper