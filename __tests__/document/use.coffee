'use strict'

{createView, renderParse} = require './utils'

describe 'Document n-use', ->
    it 'is replaced by component', ->
        view = createView '''
            <n-component name="a"><b></b></n-component>
            <n-use n-component="a" />
        '''
        renderParse view
        assert.is view.element.stringify(), '<b></b>'

    it 'is replaced in component', ->
        view = createView '''
            <n-component name="b">1</n-component>
            <n-component name="a"><n-use n-component="b" /></n-component>
            <n-use n-component="a" />
        '''
        renderParse view
        assert.is view.element.stringify(), '1'

    it 'can be rendered recursively', ->
        view = createView '''
            <n-component name="a">
                1
                <n-use
                  n-component="a"
                  n-if="${loops > 0}"
                  loops="${loops - 1}"
                />
                <n-props loops />
            </n-component>
            <n-use n-component="a" loops="3" />
        '''
        renderParse view
        assert.is view.element.stringify(), '1111'

    it 'can be rendered using short syntax', ->
        view = createView '''
            <n-component name="Abc"><b></b></n-component>
            <Abc />
        '''

        renderParse view
        assert.is view.element.stringify(), '<b></b>'

    it 'does not render hidden component', ->
        view = createView '''
            <script>
            module.exports = {
                logs: null,
                onBeforeRender() {
                    this.logs = []
                },
            }
            </script>
            <n-component name="Abc">
                <script>
                module.exports = {
                    onRender() {
                        this.logs.push(this.name);
                    },
                }
                </script>
                <n-props logs name />
            </n-component>
            <Abc logs="${this.logs}" name="fail" n-if="${false}" />
            <Abc logs="${this.logs}" name="ok" />
        '''
        renderParse view
        assert.isEqual view.exported.logs, ['ok']

    it 'does not render component inside hidden element', ->
        view = createView '''
            <script>
            module.exports = {
                logs: null,
                onBeforeRender() {
                    this.logs = []
                },
            }
            </script>
            <n-component name="Abc">
                <script>
                module.exports = {
                    onRender() {
                        this.logs.push(this.name);
                    },
                }
                </script>
                <n-props logs name />
            </n-component>
            <div n-if="${false}">
                <Abc logs="${this.logs}" name="fail" />
            </div>
            <Abc logs="${this.logs}" name="ok" />
        '''
        renderParse view
        assert.isEqual view.exported.logs, ['ok']

    it 'is reverted when comes invisible', ->
        view = createView '''
            <n-component name="Abc">
                <script>
                module.exports = {
                    reverted: 0,
                    onRevert() {
                        this.reverted = (this.reverted + 1) || 1
                    },
                }
                </script>
            </n-component>
            <script>
            module.exports = {
                visible: false,
                onBeforeRender() {
                    this.visible = true
                },
            }
            </script>
            <div n-ref="container" n-if="${visible}">
                <Abc n-ref="abc" />
            </div>
        '''
        view.render()
        {exported} = view
        {abc} = exported.refs

        assert.is abc.reverted, 0
        exported.visible = false
        assert.is abc.reverted, 1
        assert.is exported.refs.abc, view.element.children[0].children[0]
