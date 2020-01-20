const { Struct } = require('@neft/core')
const { createView } = require('./utils')

test('context can be accessed', () => {
  const view = createView(`
    <n-component name="User">
      <n-use-context name="configContext" as="configValue" />
      <h1>{configValue.ok}</h1>
    </n-component>

    <n-prop name="config" />
    <n-provide-context name="configContext" value={config}>
      <User />
    </n-provide-context>
  `)
  const config = { ok: 'yes' }
  view.render({ props: { config } })
  assert.is(view.element.stringify(), '<h1>yes</h1>')
})

test('context can be accessed through n-slot ', () => {
  const view = createView(`
    <n-component name="Store">
      <n-prop name="config" />
      <div class="store">
        <n-provide-context name="configContext" value={config}>
          <n-slot />
        </n-provide-context>
      </div>
    </n-component>

    <n-component name="User">
      <n-use-context name="configContext" as="configValue" />
      <h1>{configValue.counter}</h1>
    </n-component>

    <n-prop name="config" />
    <Store config={config}>
      <User />
    </Store>
  `)
  const config = new Struct({ counter: 4 })
  view.render({ props: { config } })
  assert.is(view.element.stringify(), '<div class="store"><h1>4</h1></div>')

  config.counter = 5
  assert.is(view.element.stringify(), '<div class="store"><h1>5</h1></div>')
})
