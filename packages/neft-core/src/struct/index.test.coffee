'use strict'

Struct = require './'

struct = null

beforeEach ->
    struct = new Struct name: 'Bob'

it 'key is accessible', ->
    assert.is struct.name, 'Bob'

it 'key can be changed', ->
    struct.name = 'Max'
    assert.is struct.name, 'Max'

it 'new key cannot be added', ->
    error = null
    try
        struct.age = 12
    catch er
        error = er
    assert.ok error
    assert.is struct.age, undefined

it 'old key cannot be deleted', ->
    error = null
    try
        delete struct.name
    catch er
        error = er
    assert.ok error
    assert.is struct.name, 'Bob'

it 'onChange signal is emitted with old value', ->
    oldValues = []
    struct.onNameChange (oldValue) -> oldValues.push(oldValue)
    struct.name = 'Max'
    assert.isEqual oldValues, ['Bob']

it 'new value is available in onChange signal', ->
    newValue = null
    struct.onNameChange -> newValue = @name
    struct.name = 'Max'
    assert.is newValue, 'Max'

it 'only keys are enumerable', ->
    assert.isEqual Object.keys(struct), ['name']
