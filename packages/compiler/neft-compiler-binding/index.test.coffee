parser = require './'

isPublicId = (id) -> id is 'this'

assertParser = (binding, expected) ->
    result = parser.parse(binding, isPublicId)
    result.connections = eval result.connections
    assert.isEqual result, expected

it 'properties', ->
    assertParser 'this.object.deepObject.property',
        hash: 'this.object.deepObject.property'
        connections: [[[['this', 'object'], 'deepObject'], 'property']]

it 'inner properties', ->
    assertParser 'this.object[this.subObject.subProperty].property',
        hash: 'this.object[this.subObject.subProperty].property'
        connections: [['this', 'object'], [['this', 'subObject'], 'subProperty']]

it 'list element', ->
    assertParser 'this.list[0]',
        hash: 'this.list[0]'
        connections: [[['this', 'list'], '0']]

it 'and', ->
    assertParser 'this.a && !this.b',
        hash: 'this.a && !this.b'
        connections: [['this', 'a'], ['this', 'b']]

it 'conditions', ->
    assertParser 'this.a.b === !this.c.d["e"]',
        hash: 'this.a.b === !this.c.d["e"]'
        connections: [[['this', 'a'], 'b'], [['this', 'c'], 'd']]

it 'omits array literals', ->
    assertParser '(this.dict ? this.dict.list : [])',
        hash: '(this.dict ? this.dict.list : [])'
        connections: [['this', 'dict'], [['this', 'dict'], 'list']]
