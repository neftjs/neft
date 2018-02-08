'use strict'

fs = require 'fs'
os = require 'os'
{utils, Document} = Neft
{createView, renderParse, uid} = require './utils.server'

describe 'Document script', ->
    it 'is not rendered', ->
        view = createView '''
            <script></script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), ''

    it 'is disabled if contains unknown HTML attributes', ->
        view = createView '''
            <script type="text">
                this.a = Math.random();
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.scope.a, undefined

    it 'is called on a view clone', ->
        view = createView '''
            <script>
                this.a = 1;
            </script>
        '''
        view = view.clone()

        renderParse view
        {scope} = view
        assert.is scope.a, 1

        view.revert()
        renderParse view
        assert.is view.scope, scope

        view2 = view.clone()
        renderParse view2
        assert.isNot view2.scope, scope
        assert.is view2.scope.a, 1

    it 'is called with props in beforeRender', ->
        view = createView '''
            <script>
                this.onBeforeRender(() => {
                    this.a = this.props.a;
                });
            </script>
        '''
        view = view.clone()

        renderParse view,
            props:
                a: 1
        assert.is view.scope.a, 1

    it 'is called with refs in scope', ->
        view = createView '''
            <script>
                this.a = this.refs.x.props.a;
            </script>
            <b n-ref="x" a="1" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.scope.a, 1

    it 'is called with file node in scope', ->
        view = createView '''
            <script>
                this.aNode = this.node;
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.scope.aNode, view.node

    describe '[filename]', ->
        it 'supports .coffee files', ->
            view = Document.fromHTML uid(), '''
                <script filename="a.coffee">
                    @a = 1
                </script>
            '''
            Document.parse view
            view = view.clone()

            renderParse view
            assert.is view.scope.a, 1

    it 'predefined scope properties are not enumerable', ->
        view = createView '''
            <script>
                var keys = [];
                this.keys = keys;
                for (var key in this) {
                    keys.push(key);
                }
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.isEqual view.scope.keys, ['keys']

    it 'further tags are properly called', ->
        view = createView '''
            <script>
                this.aa = 1;
            </script>
            <script>
                this.bb = 1;
                this.bbaa = this.aa;
            </script>
        '''
        view = view.clone()

        renderParse view
        {scope} = view
        assert.is scope.aa, 1
        assert.is scope.bb, 1
        assert.is scope.bbaa, 1

    it 'can contains XML text', ->
        source = createView """
            <script>
                this.a = '<&&</b>';
            </script>
            ${this.a}
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<&&</b>'

    it 'accepts `src` attribute', ->
        filename = "tmp#{uid()}.js"
        path = "#{os.tmpdir()}/#{filename}"
        file = 'module.exports = function(){ this.a = 1; }'
        fs.writeFileSync path, file, 'utf-8'

        source = Document.fromHTML uid(), """
            <script src="#{path}"></script>
            <blank>${this.a}</blank>
        """
        Document.parse source
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'accepts relative `src` attribute', ->
        scriptFilename = "tmp#{uid()}.js"
        scriptPath = "#{os.tmpdir()}/#{scriptFilename}"
        file = 'module.exports = function(){ this.a = 1; }'
        fs.writeFileSync scriptPath, file, 'utf-8'

        viewFilename = "tmp#{uid()}"
        viewPath = "#{os.tmpdir()}/#{viewFilename}"
        fs.writeFileSync viewPath, viewStr = """
            <script src="./#{scriptFilename}"></script>
            <blank>${this.a}</blank>
        """

        source = Document.fromHTML viewPath, viewStr
        Document.parse source
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'properly calls events', ->
        view = createView """
            <script>
                this.events = [];
                this.onBeforeRender(function(){
                    this.events.push('onBeforeRender');
                });
                this.onRender(function(){
                    this.events.push('onRender');
                });
                this.onBeforeRevert(function(){
                    this.events.push('onBeforeRevert');
                });
                this.onRevert(function(){
                    this.events.push('onRevert');
                });
            </script>
        """
        view = view.clone()

        {events} = view.scope
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]

    it 'onBeforeRender is called with context in scope', ->
        view = createView '''
            <script>
                this.onBeforeRender(() => {
                    this.a = this.context.a;
                });
            </script>
        '''
        view = view.clone()

        renderParse view, storage: a: 1
        assert.is view.scope.a, 1

    it 'does not call events for foreign scope', ->
        view = createView """
            <script>
                this.events = [];
                this.onBeforeRender(function(){
                    this.events.push('onBeforeRender');
                });
                this.onRender(function(){
                    this.events.push('onRender');
                });
                this.onBeforeRevert(function(){
                    this.events.push('onBeforeRevert');
                });
                this.onRevert(function(){
                    this.events.push('onRevert');
                });
            </script>
            <ul n-each="[1,2]">${props.item}</ul>
        """
        view = view.clone()

        {events} = view.scope
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]

    describe 'propsSchema', ->
        N_EACH_HTML = """
            <blank n-each="[1, 2]">
                ${props.item}
            </blank>
            <script>
                this.propsSchema = {
                    id: {
                        type: 'string'
                    }
                };
            </script>
        """

        warnPropSchema = Document::_warnPropSchema

        beforeEach ->
            @prepareView = (html) ->
                @view = createView(html).clone()

                @errors = []
                Document::_warnPropSchema = (error) => @errors.push error

            @prepareView """
                <script>
                    this.propsSchema = {
                        id: {
                            type: 'string'
                        }
                    };
                </script>
            """

        afterEach ->
            Document::_warnPropSchema = warnPropSchema

        it 'passes on valid props', ->
            @view.render id: 'abc'
            assert.lengthOf @errors, 0

        it 'fails on invalid prop', ->
            @view.render id: 2
            assert.lengthOf @errors, 1

        it 'fails on unknown prop', ->
            @view.render()
            assert.lengthOf @errors, 1

        it 'passes on valid props in n-each', ->
            @prepareView N_EACH_HTML
            @view.render id: 'abc'
            assert.lengthOf @errors, 0

    describe 'defaultState', ->
        beforeEach ->
            @view = createView """
                <script>
                    this.defaultState = {
                        abc: 123
                    };
                    this.onBeforeRender(() => {
                        this.savedState = this.state;
                    });
                </script>
            """
            @view = @view.clone()

        it 'is not applied on created document', ->
            assert.notOk @view.inputState.abc

        it 'is applied on rendered document', ->
            @view.render()
            assert.is @view.inputState.abc, 123

        it 'is not applied on reverted document', ->
            @view.render()
            @view.revert()
            assert.notOk @view.inputState.abc

        it 'is applied in onBeforeRender signal', ->
            @view.render()
            assert.is @view.scope.savedState.abc, 123

    describe 'defaultProps', ->
        beforeEach ->
            @view = createView """
                <script>
                    this.defaultProps = {
                        abc: 123
                    };
                    this.onBeforeRender(() => {
                        this.savedProps = this.props;
                    });
                </script>
            """
            @view = @view.clone()

        it 'is not applied on created document', ->
            assert.notOk @view.inputProps.abc

        it 'is applied on rendered document', ->
            @view.render()
            assert.is @view.inputProps.abc, 123

        it 'is applied in onBeforeRender signal', ->
            @view.render()
            assert.is @view.scope.savedProps.abc, 123
