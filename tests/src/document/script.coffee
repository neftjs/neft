'use strict'

fs = require 'fs'
os = require 'os'
{assert, utils, unit, Document} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document script', ->
    it 'is not rendered', ->
        view = createView '''
            <script></script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), ''

    it 'context is shared between rendered views', ->
        view = createView '''
            <script>
                this.a = Math.random();
            </script>
        '''
        view = view.clone()

        renderParse view
        proto = view.context.__proto__
        assert.isFloat view.context.a

        view.revert()
        renderParse view
        assert.is view.context.__proto__, proto
        view.revert()

        view2 = view.clone()
        renderParse view2
        assert.is view2.context.__proto__, proto

    it 'is disabled if contains unknown attributes', ->
        view = createView '''
            <script type="text">
                this.a = Math.random();
            </script>
        '''
        view = view.clone()

        renderParse view
        proto = view.context.__proto__
        assert.is view.context.a, undefined

    describe 'this.onCreate()', ->
        it 'is called on a view clone', ->
            view = createView '''
                <attr name="x" value="1" />
                <script>
                    this.onCreate(function(){
                        this.b = 2;
                    });
                    this.a = 1;
                </script>
            '''
            view = view.clone()

            renderParse view
            {context} = view
            assert.is context.b, 2
            assert.is context.a, 1

            view.revert()
            renderParse view
            assert.is view.context, context

            view2 = view.clone()
            renderParse view2
            assert.isNot view2.context, context
            assert.is view2.context.b, 2
            assert.is view2.context.a, 1

        it 'is called with its prototype', ->
            view = createView '''
                <script>
                    this.onCreate(function(){
                        this.proto = this;
                        this.protoA = this.a;
                    });
                    this.a = 1;
                </script>
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.proto, view.context
            assert.is view.context.protoA, 1

        it 'is called with props in context', ->
            view = createView '''
                <script>
                    this.onCreate(function(){
                        this.a = this.props.a;
                    });
                </script>
                <attr name="a" value="1" />
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

        it 'is called with ids in context', ->
            view = createView '''
                <script>
                    this.onCreate(function(){
                        this.a = this.ids.x.attrs.a;
                    });
                </script>
                <b id="x" a="1" />
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

        it 'is called with root in context', ->
            view = createView '''
                <script>
                    this.onRender(function(){
                        this.a = this.root.a;
                    });
                </script>
            '''
            view = view.clone()

            renderParse view, storage: a: 1
            assert.is view.context.a, 1

        it 'is called with file node in context', ->
            view = createView '''
                <script>
                    this.onCreate(function(){
                        this.aNode = this.node;
                    });
                </script>
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.aNode, view.node

    describe.onServer '[filename]', ->
        it 'supports .coffee files', ->
            view = Document.fromHTML uid(), '''
                <script filename="a.coffee">
                    @a = 1
                </script>
            '''
            Document.parse view
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

    it 'predefined context properties are not enumerable', ->
        view = createView '''
            <script>
                var protoKeys = [];
                for (var key in this) {
                    protoKeys.push(key);
                }

                this.onCreate(function(){
                    var keys = [].concat(protoKeys);
                    this.keys = keys;
                    for (var key in this) {
                        keys.push(key);
                    }
                });
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.isEqual view.context.keys, ['keys']

    it 'further tags are properly called', ->
        view = createView '''
            <script>
                this.onCreate(function(){
                    this.aa = 1;
                });
                this.a = 1;
            </script>
            <script>
                this.onCreate(function(){
                    this.bb = 1;
                    this.bbaa = this.aa;
                });
                this.b = 1;
            </script>
        '''
        view = view.clone()

        renderParse view
        {context} = view
        assert.is context.a, 1
        assert.is context.aa, 1
        assert.is context.b, 1
        assert.is context.bb, 1
        assert.is context.bbaa, 1

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

    it.onServer 'accepts `src` attribute', ->
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

    it.onServer 'accepts relative `src` attribute', ->
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
                this.onCreate(function(){
                    this.events = [];
                });
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

        {events} = view.context
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]

    it 'does not call events for foreign context', ->
        view = createView """
            <script>
                this.onCreate(function(){
                    this.events = [];
                });
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

        {events} = view.context
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]
