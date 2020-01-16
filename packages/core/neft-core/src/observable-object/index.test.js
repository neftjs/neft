const ObservableObject = require('./index')

let observable

beforeEach(() => {
  observable = ObservableObject.from({ name: 'Bob', age: 32 })
})

it('returns all given keys', () => {
  expect(observable.name).toBe('Bob')
  expect(observable.age).toBe(32)
})

it('keeps access to the given object prototype', () => {
  observable = ObservableObject.from(Object.create({
    a: 1,
  }))
  expect(observable.a).toBe(1)
})

it('only given keys are enumerable', () => {
  expect(Object.keys(observable)).toEqual(['name', 'age'])
})

it('each given key has its signal dispatcher', () => {
  const calls = []
  observable.onNameChange.connect(function (...args) {
    calls.push({ args, value: this.name })
  }, observable)
  observable.name = 'Max'
  observable.name = 'Max'
  observable.name = 'Jenny'
  expect(calls).toEqual([
    { args: ['Bob', undefined], value: 'Max' },
    { args: ['Max', undefined], value: 'Jenny' },
  ])
})

it('property can be defined in runtime', () => {
  observable.set('surname', 'Smith')
  expect(observable.surname).toBe('Smith')
  expect(typeof observable.onSurnameChange).toBe('object')
})
