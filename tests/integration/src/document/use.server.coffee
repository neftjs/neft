'use strict'

{Document} = Neft
{createView, renderParse, uid} = require './utils.server'

describe 'Document n-use', ->
    it 'is replaced by component', ->
        view = createView '''
            <n-component n-name="a"><b></b></n-component>
            <n-use n-component="a" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'is replaced in component', ->
        source = createView '''
            <n-component n-name="b">1</n-component>
            <n-component n-name="a"><n-use n-component="b" /></n-component>
            <n-use n-component="a" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'can be rendered recursively', ->
        source = createView '''
            <n-component n-name="a">
                1
                <n-use
                  n-component="a"
                  n-if="${props.loops > 0}"
                  loops="${props.loops - 1}"
                />
            </n-component>
            <n-use n-component="a" loops="3" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1111'

    it 'can be rendered using short syntax', ->
        view = createView '''
            <n-component n-name="a-b"><b></b></n-component>
            <a-b />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'does not render hidden component', ->
        view = createView '''
            <script>
            this.onBeforeRender(function () {
                this.logs = [];
            });
            </script>
            <n-component n-name="a-b">
                <script>
                this.onRender(function () {
                    this.props.logs.push(this.props.name);
                });
                </script>
            </n-component>
            <a-b logs="${this.logs}" name="fail" n-if="${false}" />
            <a-b logs="${this.logs}" name="ok" />
        '''
        view = view.clone()
        renderParse view
        assert.isEqual view.scope.logs, ['ok']

    it 'does not render component inside hidden element', ->
        view = createView '''
            <script>
            this.onBeforeRender(function () {
                this.logs = [];
            });
            </script>
            <n-component n-name="a-b">
                <script>
                this.onRender(function () {
                    this.props.logs.push(this.props.name);
                });
                </script>
            </n-component>
            <div n-if="${false}">
                <a-b logs="${this.logs}" name="fail" />
            </div>
            <a-b logs="${this.logs}" name="ok" />
        '''
        view = view.clone()
        renderParse view
        assert.isEqual view.scope.logs, ['ok']

    it 'is reverted when comes invisible', ->
        view = createView '''
            <n-component n-name="abc">
                <script>
                this.onRevert(function () {
                    this.reverted = (this.reverted + 1) || 1;
                });
                </script>
            </n-component>
            <script>
            this.onBeforeRender(function () {
                this.state.set('visible', true);
            });
            </script>
            <div n-ref="container" n-if="${state.visible}">
                <abc n-ref="abc" />
            </div>
        '''
        view = view.clone()
        view.render()
        {scope} = view
        {abc} = scope.refs

        assert.is abc.reverted, undefined
        scope.state.set 'visible', false
        assert.is abc.reverted, 1
        assert.instanceOf scope.refs.abc, Document.Element
