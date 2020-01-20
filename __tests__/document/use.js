const { Struct, eventLoop } = require('@neft/core')
const { createView, renderParse } = require('./utils')

describe('Document n-use', () => {
  it('is replaced by component', () => {
    const view = createView(`
      <n-component name="a"><b></b></n-component>
      <n-use n-component="a" />
    `)
    renderParse(view)
    assert.is(view.element.stringify(), '<b></b>')
  })

  it('is replaced in component', () => {
    const view = createView(`
      <n-component name="b">1</n-component>
      <n-component name="a"><n-use n-component="b" /></n-component>
      <n-use n-component="a" />
    `)
    renderParse(view)
    assert.is(view.element.stringify(), '1')
  })

  it('can be rendered recursively', () => {
    const view = createView(`
      <n-component name="a">
        1
        <n-use
          n-component="a"
          n-if="{loops > 0}"
          loops="{loops - 1}"
        />
        <n-prop name="loops" />
      </n-component>
      <n-use n-component="a" loops={3} />
    `)
    renderParse(view)
    assert.is(view.element.stringify(), '1111')
  })

  it('can be rendered using short syntax', () => {
    const view = createView(`
      <n-component name="Abc"><b></b></n-component>
      <Abc />
    `)
    renderParse(view)
    assert.is(view.element.stringify(), '<b></b>')
  })

  it('does not render hidden component', () => {
    const view = createView(`
      <script>
      exports.default = () => ({
        data: null,
        logs: [],
      })
      </script>
      <n-component name="Abc">
        <n-prop name="logs" />
        <n-prop name="name" />
        <script>
        exports.default = {
          onRender() {
            this.logs.push(this.name);
          },
        }
        </script>
      </n-component>
      <Abc logs="{logs}" name="fail" n-if={data} />
      <Abc logs="{logs}" name="ok" n-else />
    `)
    renderParse(view)
    assert.isEqual(view.exported.logs, ['ok'])
  })

  it('renders unhidden component with ready props', () => {
    const view = createView(`
      <script>
      exports.default = () => ({
        logs: [],
      })
      </script>
      <n-component name="Abc">
        <n-prop name="logs" />
        <n-prop name="status" />
        {status}
        <script>
        exports.default = {
          onRender() {
            this.logs.push(this.status);
          },
        }
        </script>
      </n-component>
      <Abc logs="{logs}" status={$context.status} n-if={$context.status} />
      <Abc logs="{logs}" status="fail" n-else />
    `)
    const context = new Struct({
      status: null,
    })
    renderParse(view, {
      context,
    })
    eventLoop.callInLock(() => { context.status = 'ok' })
    assert.isEqual(view.exported.logs, ['fail', 'ok'])
    assert.is(view.element.stringify(), 'ok')
  })

  it('does not render component inside hidden element', () => {
    const view = createView(`
      <script>
      exports.default = () => ({
        logs: [],
      })
      </script>
      <n-component name="Abc">
        <script>
        exports.default = {
          onRender() {
            this.logs.push(this.name);
          },
        }
        </script>
        <n-prop name="logs" />
        <n-prop name="name" />
      </n-component>
      <div n-if="{false}">
        <Abc logs="{logs}" name="fail" />
      </div>
      <Abc logs="{logs}" name="ok" />
    `)
    renderParse(view)
    assert.isEqual(view.exported.logs, ['ok'])
  })

  it('is reverted when comes invisible', () => {
    const view = createView(`
      <n-component name="Abc">
        <script>
        exports.default = {
          reverted: 0,
          onRevert() {
            this.reverted = (this.reverted + 1) || 1
          },
        }
        </script>
      </n-component>
      <script>
      exports.default = {
        visible: false,
        onRender() {
          this.visible = true
        },
      }
      </script>
      <div n-ref="container" n-if="{visible}">
        <Abc n-ref="abc" />
      </div>
    `)
    view.render()
    const { exported } = view
    const { abc } = exported.$refs
    assert.is(abc.reverted, 0)
    exported.visible = false
    assert.is(abc.reverted, 1)
    assert.is(exported.$refs.abc, view.element.children[0].children[0])
  })
})
