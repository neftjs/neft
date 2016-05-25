'use strict'

fs = require 'fs'
os = require 'os'
{assert, utils, unit, Document} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document neft:script', ->
    it 'is not rendered', ->
        view = createView '''
            <neft:script></neft:script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), ''

    it 'context is shared between rendered views', ->
        view = createView '''
            <neft:script><![CDATA[
                this.a = Math.random();
            ]]></neft:script>
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

    describe '<script>', ->
        it 'works like <neft:script>', ->
            view = createView '''
                <script>
                    this.a = Math.random();
                </script>
            '''
            view = view.clone()

            renderParse view
            assert.isFloat view.context.a

        it 'is not rendered', ->
            view = createView '''
                <script></script>
            '''
            view = view.clone()

            renderParse view
            assert.is view.node.stringify(), ''

        it 'does not work if has attributes', ->
            view = createView '''
                <script src=""><![CDATA[
                    this.a = 1;
                ]]></script>
            '''
            view = view.clone()

            renderParse view
            assert.isNot view.node.stringify(), ''
            assert.is view.context?.a, undefined

    describe 'this.onCreate()', ->
        it 'is called on a view clone', ->
            view = createView '''
                <neft:attr name="x" value="1" />
                <neft:script><![CDATA[
                    this.onCreate(function(){
                        this.b = 2;
                    });
                    this.a = 1;
                ]]></neft:script>
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
                <neft:script><![CDATA[
                    this.onCreate(function(){
                        this.proto = this;
                        this.protoA = this.a;
                    });
                    this.a = 1;
                ]]></neft:script>
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.proto, view.context
            assert.is view.context.protoA, 1

        it 'is called with attrs in context', ->
            view = createView '''
                <neft:script><![CDATA[
                    this.onCreate(function(){
                        this.a = this.attrs.a;
                    });
                ]]></neft:script>
                <neft:attr name="a" value="1" />
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

        it 'is called with ids in context', ->
            view = createView '''
                <neft:script><![CDATA[
                    this.onCreate(function(){
                        this.a = this.ids.x.attrs.a;
                    });
                ]]></neft:script>
                <b id="x" a="1" />
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

        it 'is called with scope in context', ->
            view = createView '''
                <neft:script><![CDATA[
                    this.onRender(function(){
                        this.a = this.scope.a;
                    });
                ]]></neft:script>
            '''
            view = view.clone()

            renderParse view, storage: a: 1
            assert.is view.context.a, 1

        it 'is called with file node in context', ->
            view = createView '''
                <neft:script><![CDATA[
                    this.onCreate(function(){
                        this.aNode = this.node;
                    });
                ]]></neft:script>
            '''
            view = view.clone()

            renderParse view
            assert.is view.context.aNode, view.node

    describe.onServer '[filename]', ->
        it 'supports .coffee files', ->
            view = Document.fromHTML uid(), '''
                <neft:script filename="a.coffee"><![CDATA[
                    @a = 1
                ]]></neft:script>
            '''
            Document.parse view
            view = view.clone()

            renderParse view
            assert.is view.context.a, 1

    it 'predefined context properties are not enumerable', ->
        view = createView '''
            <neft:script><![CDATA[
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
            ]]></neft:script>
        '''
        view = view.clone()

        renderParse view
        assert.isEqual view.context.keys, ['keys']

    it 'further tags are properly called', ->
        view = createView '''
            <neft:script><![CDATA[
                this.onCreate(function(){
                    this.aa = 1;
                });
                this.a = 1;
            ]]></neft:script>
            <neft:script><![CDATA[
                this.onCreate(function(){
                    this.bb = 1;
                    this.bbaa = this.aa;
                });
                this.b = 1;
            ]]></neft:script>
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
            <neft:script><![CDATA[
                this.a = '<&&</neft:script>';
            ]]></neft:script>
            ${this.a}
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<&&</neft:script>'

    it '<script> can contains XML text with no CDATA', ->
        source = createView """
            <script>
                this.a = '<&&</neft:script>';
            </script>
            ${this.a}
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<&&</neft:script>'

    it.onServer 'accepts `src` attribute', ->
        filename = "tmp#{uid()}.js"
        path = "#{os.tmpdir()}/#{filename}"
        file = 'module.exports = function(){ this.a = 1; }'
        fs.writeFileSync path, file, 'utf-8'

        source = Document.fromHTML uid(), """
            <neft:script src="#{path}" />
            <neft:blank>${this.a}</neft:blank>
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
            <neft:script src="./#{scriptFilename}" />
            <neft:blank>${this.a}</neft:blank>
        """

        source = Document.fromHTML viewPath, viewStr
        Document.parse source
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'properly calls events', ->
        view = createView """
            <neft:script><![CDATA[
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
            ]]></neft:script>
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
            <neft:script><![CDATA[
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
            ]]></neft:script>
            <ul neft:each="[1,2]">${attrs.item}</ul>
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
