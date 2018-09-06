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
        assert.is view.exported.a, undefined

    it 'is called on a view clone', ->
        view = createView '''
            <script>
            exports.default = {
                a: 1,
            }
            </script>
        '''
        view = view.clone()

        renderParse view
        {exported} = view
        assert.is exported.a, 1

        view.revert()
        renderParse view
        assert.is view.exported, exported

        view2 = view.clone()
        renderParse view2
        assert.isNot view2.exported, exported
        assert.is view2.exported.a, 1

    it 'is called with props in beforeRender', ->
        view = createView '''
            <n-props a />
            <script>
            exports.default = {
                b: null,
                onBeforeRender() {
                    this.b = this.a
                },
            }
            </script>
        '''
        view = view.clone()

        renderParse view,
            props:
                a: 1
        assert.is view.exported.b, 1

    it 'is called with refs in exported', ->
        view = createView '''
            <script>
            exports.default = {
                a: null,
                onCreate() {
                    this.a = this.refs.x.props.a
                }
            }
            </script>
            <b n-ref="x" a="1" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.exported.a, 1

    it 'is called with file node in exported', ->
        view = createView '''
            <script>
            exports.default = {
                aNode: null,
                onCreate() {
                    this.aNode = this.node
                }
            }
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.is view.exported.aNode, view.node

    it 'predefined exported properties are not enumerable', ->
        view = createView '''
            <script>
            exports.default = {
                keys: null,
                onCreate() {
                    var keys = [];
                    this.keys = keys;
                    for (var key in this) {
                        keys.push(key);
                    }
                },
            }
            </script>
        '''
        view = view.clone()

        renderParse view
        assert.isEqual view.exported.keys, ['keys', 'onCreate']

    it 'further tags are properly called', ->
        view = createView '''
            <script>
            exports.default = {
                aa: 1,
            }
            </script>
            <script>
            exports.default = {
                bb: 1,
            }
            </script>
        '''
        view = view.clone()

        renderParse view
        {exported} = view
        assert.is exported.aa, 1
        assert.is exported.bb, 1

    it 'can contains XML text', ->
        source = createView """
            <script>
            exports.default = {
                a: null,
                onCreate() {
                    this.a = '<&&</b>'
                },
            }
            </script>
            ${this.a}
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<&&</b>'

    it 'accepts `src` attribute', ->
        filename = "tmp#{uid()}.js"
        path = "#{os.tmpdir()}/#{filename}"
        file = 'exports.default = { a: 1 }'
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
        file = 'exports.default = { a: 1 }'
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
            exports.default = {
                events: [],
                onBeforeRender() {
                    this.events.push('onBeforeRender');
                },
                onRender() {
                    this.events.push('onRender');
                },
                onBeforeRevert() {
                    this.events.push('onBeforeRevert');
                },
                onRevert() {
                    this.events.push('onRevert');
                },
            }
            </script>
        """
        view = view.clone()

        {events} = view.exported
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]

    it 'onBeforeRender is called with context in exported', ->
        view = createView '''
            <script>
            exports.default = {
                a: null,
                onBeforeRender() {
                    this.a = this.context.a
                },
            }
            </script>
        '''
        view = view.clone()

        renderParse view, storage: a: 1
        assert.is view.exported.a, 1

    it 'does not call events for foreign exported', ->
        view = createView """
            <script>
            exports.default = {
                events: [],
                onBeforeRender() {
                    this.events.push('onBeforeRender');
                },
                onRender() {
                    this.events.push('onRender');
                },
                onBeforeRevert() {
                    this.events.push('onBeforeRevert');
                },
                onRevert() {
                    this.events.push('onRevert');
                },
            }
            </script>
            <ul n-each="[1,2]">${item}</ul>
        """
        view = view.clone()

        {events} = view.exported
        assert.isEqual events, []

        view.render()
        assert.isEqual events, ['onBeforeRender', 'onRender']

        view.revert()
        assert.isEqual events, [
            'onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert'
        ]
