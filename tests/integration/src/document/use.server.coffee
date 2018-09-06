'use strict'

{Document} = Neft
{createView, renderParse, uid} = require './utils.server'

describe 'Document n-use', ->
    it 'is replaced by component', ->
        view = createView '''
            <n-component name="a"><b></b></n-component>
            <n-use n-component="a" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'is replaced in component', ->
        source = createView '''
            <n-component name="b">1</n-component>
            <n-component name="a"><n-use n-component="b" /></n-component>
            <n-use n-component="a" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'can be rendered recursively', ->
        source = createView '''
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
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1111'

    it 'can be rendered using short syntax', ->
        view = createView '''
            <n-component name="a-b"><b></b></n-component>
            <a-b />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'does not render hidden component', ->
        view = createView '''
            <script>
            exports.default = {
                logs: null,
                onBeforeRender() {
                    this.logs = []
                },
            }
            </script>
            <n-component name="a-b">
                <script>
                exports.default = {
                    onRender() {
                        this.logs.push(this.name);
                    },
                }
                </script>
                <n-props logs name />
            </n-component>
            <a-b logs="${this.logs}" name="fail" n-if="${false}" />
            <a-b logs="${this.logs}" name="ok" />
        '''
        view = view.clone()
        renderParse view
        assert.isEqual view.exported.logs, ['ok']

    it 'does not render component inside hidden element', ->
        view = createView '''
            <script>
            exports.default = {
                logs: null,
                onBeforeRender() {
                    this.logs = []
                },
            }
            </script>
            <n-component name="a-b">
                <script>
                exports.default = {
                    onRender() {
                        this.logs.push(this.name);
                    },
                }
                </script>
                <n-props logs name />
            </n-component>
            <div n-if="${false}">
                <a-b logs="${this.logs}" name="fail" />
            </div>
            <a-b logs="${this.logs}" name="ok" />
        '''
        view = view.clone()
        renderParse view
        assert.isEqual view.exported.logs, ['ok']

    it 'is reverted when comes invisible', ->
        view = createView '''
            <n-component name="abc">
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
                onBeforeRender() {
                    this.visible = true
                },
            }
            </script>
            <div n-ref="container" n-if="${visible}">
                <abc n-ref="abc" />
            </div>
        '''
        view = view.clone()
        view.render()
        {exported} = view
        {abc} = exported.refs

        assert.is abc.reverted, 0
        exported.visible = false
        assert.is abc.reverted, 1
        assert.is exported.refs.abc, null
