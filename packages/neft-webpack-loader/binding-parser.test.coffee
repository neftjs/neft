parser = require './binding-parser'

isPublicId = (id) -> id is 'this'

assertParser = (binding, expected) ->
    result = parser.parse(binding, isPublicId)
    result.connections = eval result.connections
    assert.isEqual result, expected

it 'recognizes properties', ->
    assertParser 'this.object.deepObject.property',
        hash: 'this.object.deepObject.property'
        connections: [[['this', 'object'], 'deepObject'], 'property']

it 'recognizes inner properties', ->
    assertParser 'this.object[this.subObject.subProperty].property',
        hash: 'this.object[this.subObject.subProperty].property'
        connections: [['this', 'subObject'], 'subProperty']

it 'recognizes list element', ->
    assertParser 'this.list[0]',
        hash: 'this.list[0]'
        connections: [['this', 'list'], '0']

it 'omits array literals', ->
    assertParser '(this.dict ? this.dict.list : [])',
        hash: '(this.dict ? this.dict.list : [])'
        connections: [['this', 'dict'], 'list']
