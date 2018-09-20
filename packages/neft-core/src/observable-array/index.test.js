const ObservableArray = require('./')

let array
let pushed
let popped

beforeEach(() => {
  pushed = []
  popped = []
  array = new ObservableArray('a', 'b')
  array.onPush.connect((...args) => { pushed.push(args) })
  array.onPop.connect((...args) => { popped.push(args) })
})

it('is an array', () => {
  assert(Array.isArray(array))
})

it('elements get be read', () => {
  assert.is(array[0], 'a')
  assert.is(array[1], 'b')
})

it('push() emits signal', () => {
  array.push('c', 'd')
  assert.isEqual(pushed, [['c', 2], ['d', 3]])
})

it('pop() emits signal', () => {
  array.pop()
  assert.isEqual(popped, [['b', 1]])
})

it('shift() emits signal', () => {
  array.shift()
  assert.isEqual(popped, [['a', 0]])
})

it('unshift() emits signal', () => {
  array.unshift('c', 'd')
  assert.isEqual(pushed, [['c', 0], ['d', 1]])
})

describe('splice() emits signal', () => {
  it('on delete and add', () => {
    array.splice(1, 1, 'c', 'd')
    assert.isEqual(popped, [['b', 1]])
    assert.isEqual(pushed, [['c', 1], ['d', 2]])
  })

  it('on delete', () => {
    array.splice(0, 1)
    assert.isEqual(popped, [['a', 0]])
    assert.isEqual(pushed, [])
  })

  it('on add', () => {
    array.splice(0, 0, 'c', 'd')
    assert.isEqual(popped, [])
    assert.isEqual(pushed, [['c', 0], ['d', 1]])
  })
})

it('reverse() emits signal', () => {
  array.reverse()
  assert.isEqual(popped, [['a', 0], ['b', 1]])
  assert.isEqual(pushed, [['b', 0], ['a', 1]])
})

it('sort() emits signal', () => {
  array.sort(() => 1)
  assert.isEqual(popped, [['a', 0], ['b', 1]])
  assert.isEqual(pushed, [['b', 0], ['a', 1]])
})
