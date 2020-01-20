const ObservableArray = require('./')

let array
let pushed
let popped
let lengthChange

beforeEach(() => {
  pushed = []
  popped = []
  lengthChange = []
  array = new ObservableArray('a', 'b')
  array.onPush.connect((...args) => { pushed.push(args) })
  array.onPop.connect((...args) => { popped.push(args) })
  array.onLengthChange.connect((...args) => { lengthChange.push(args) })
})

it('is an array', () => {
  assert(Array.isArray(array))
})

it('elements get be read', () => {
  assert.is(array[0], 'a')
  assert.is(array[1], 'b')
})

it('push() emits signals', () => {
  array.push('c', 'd')
  assert.isEqual(pushed, [['c', 2], ['d', 3]])
  assert.isEqual(popped, [])
  assert.isEqual(lengthChange, [[2, undefined]])
})

it('pop() emits signals', () => {
  array.pop()
  assert.isEqual(pushed, [])
  assert.isEqual(popped, [['b', 1]])
  assert.isEqual(lengthChange, [[2, undefined]])
})

it('shift() emits signals', () => {
  array.shift()
  assert.isEqual(pushed, [])
  assert.isEqual(popped, [['a', 0]])
  assert.isEqual(lengthChange, [[2, undefined]])
})

it('unshift() emits signals', () => {
  array.unshift('c', 'd')
  assert.isEqual(pushed, [['c', 0], ['d', 1]])
  assert.isEqual(popped, [])
  assert.isEqual(lengthChange, [[2, undefined]])
})

describe('splice() emits signals', () => {
  it('on delete and add', () => {
    array.splice(1, 1, 'c', 'd')
    assert.isEqual(popped, [['b', 1]])
    assert.isEqual(pushed, [['c', 1], ['d', 2]])
    assert.isEqual(lengthChange, [[2, undefined]])
  })

  it('on delete', () => {
    array.splice(0, 1)
    assert.isEqual(popped, [['a', 0]])
    assert.isEqual(pushed, [])
    assert.isEqual(lengthChange, [[2, undefined]])
  })

  it('on add', () => {
    array.splice(0, 0, 'c', 'd')
    assert.isEqual(popped, [])
    assert.isEqual(pushed, [['c', 0], ['d', 1]])
    assert.isEqual(lengthChange, [[2, undefined]])
  })
})

it('reverse() emits signals', () => {
  array.reverse()
  assert.isEqual(popped, [['a', 0], ['b', 1]])
  assert.isEqual(pushed, [['b', 0], ['a', 1]])
  assert.isEqual(lengthChange, [])
})

it('sort() emits signals', () => {
  array.sort(item => (item === 'a' ? 1 : -1))
  assert.isEqual(popped, [['a', 0], ['b', 1]])
  assert.isEqual(pushed, [['b', 0], ['a', 1]])
  assert.isEqual(lengthChange, [])
})
