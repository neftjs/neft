/* eslint-disable no-restricted-syntax */
/* eslint-disable no-template-curly-in-string */
const parser = require('./')

it('variable', () => {
  const result = parser.parse('name', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.name',
    connections: '[["this","name"]]',
  })
})

it('properties', () => {
  const result = parser.parse('object.deepObject.property', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.object.deepObject.property',
    connections: '[[[["this","object"],"deepObject"],"property"]]',
  })
})

it('inner property', () => {
  const result = parser.parse('object[subObject].property', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.object[this.subObject].property',
    connections: '[["this","object"],["this","subObject"]]',
  })
})

it('inner properties', () => {
  const result = parser.parse('object[subObject.subProperty].property', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.object[this.subObject.subProperty].property',
    connections: '[["this","object"],[["this","subObject"],"subProperty"]]',
  })
})

it('list element', () => {
  const result = parser.parse('list[0]', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.list[0]',
    connections: '[["this","list"]]',
  })
})

it('and', () => {
  const result = parser.parse('a && !b', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.a && !this.b',
    connections: '[["this","a"],["this","b"]]',
  })
})

it('binary operation', () => {
  const result = parser.parse('a + " " + b', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.a + " " + this.b',
    connections: '[["this","a"],["this","b"]]',
  })
})

it('string template', () => {
  const result = parser.parse('`1${a}2`', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: '`1${this.a}2`',
    connections: '[["this","a"]]',
  })
})

it('conditions', () => {
  const result = parser.parse('a.b === !c.d["e"]', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.a.b === !this.c.d["e"]',
    connections: '[[["this","a"],"b"],[["this","c"],"d"]]',
  })
})

it('left assignment', () => {
  // connections in left side of assignment needs to be omitted
  // to not let bindings update without a break
  const result = parser.parse('counter += 1', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.counter += 1',
    connections: '[]',
  })
})

it('right assignment', () => {
  const result = parser.parse('counter = sum', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.counter = this.sum',
    connections: '[["this","sum"]]',
  })
})

it('complex right assignment', () => {
  const result = parser.parse('form.disabled = !form.name || !form.gender', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.form.disabled = !this.form.name || !this.form.gender',
    connections: '[[["this","form"],"name"],[["this","form"],"gender"]]',
  })
})

it('comparement', () => {
  const result = parser.parse('counter > 1', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.counter > 1',
    connections: '[["this","counter"]]',
  })
})

it('new keyboard', () => {
  const result = parser.parse('new Constructor', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'new this.Constructor()',
    connections: '[["this","Constructor"]]',
  })
})

it('new class', () => {
  const result = parser.parse('new Sth(user.name)', {
    prefixIdsByThis: true,
    shouldUseIdInConnections: () => false,
  })
  assert.isEqual(result, {
    hash: 'new this.Sth(this.user.name)',
    connections: '[["this","Sth"],[["this","user"],"name"]]',
  })
})

it('new keyboard\'s arguments', () => {
  const result = parser.parse('new Constructor(name, age)', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'new this.Constructor(this.name, this.age)',
    connections: '[["this","Constructor"],["this","name"],["this","age"]]',
  })
})

it('passes in object', () => {
  const result = parser.parse('user.format({ age: user.currentAge })', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.user.format({\n  age: this.user.currentAge\n})',
    connections: '[[["this","user"],"format"],[["this","user"],"currentAge"]]',
  })
})

it('passes as object shorthand', () => {
  const result = parser.parse('user.format({ age })', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.user.format({\n  age: this.age\n})',
    connections: '[[["this","user"],"format"],["this","age"]]',
  })
})

it('ternary operator', () => {
  const result = parser.parse('(dict ? dict.list : error)', {
    prefixIdsByThis: true,
  })
  assert.isEqual(result, {
    hash: 'this.dict ? this.dict.list : this.error',
    connections: '[["this","dict"],[["this","dict"],"list"],["this","error"]]',
  })
})

it('arrow functions', () => {
  const result = parser.parse('changeX(event => user)', {
    prefixIdsByThis: true,
    shouldUseIdInConnections: () => false,
  })
  assert.isEqual(result, {
    hash: 'this.changeX(event => this.user)',
    connections: '[["this","changeX"]]',
  })
})

it('arrow functions with method calls', () => {
  const result = parser.parse('changeX(event => doSth(user))', {
    prefixIdsByThis: true,
    shouldUseIdInConnections: () => false,
  })
  assert.isEqual(result, {
    hash: 'this.changeX(event => this.doSth(this.user))',
    connections: '[["this","changeX"]]',
  })
})

it('arrow function arguments are omitted', () => {
  const testCases = [
    {
      test: 'changeX(event => doSth(event, user))',
      hash: 'this.changeX(event => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(({ event }) => doSth(event, user))',
      hash: 'this.changeX(({event}) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(({ user: event }) => doSth(event, user))',
      hash: 'this.changeX(({user: event}) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(({ ...event }) => doSth(event, user))',
      hash: 'this.changeX(({...event}) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(({ some: { event } }) => doSth(event, user))',
      hash: 'this.changeX(({some: {event}}) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(([event]) => doSth(event, user))',
      hash: 'this.changeX(([event]) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX(([...event]) => doSth(event, user))',
      hash: 'this.changeX(([...event]) => this.doSth(event, this.user))',
    },
    {
      test: 'changeX((...event) => doSth(event, user))',
      hash: 'this.changeX((...event) => this.doSth(event, this.user))',
    },
  ]

  for (const testCase of testCases) {
    const result = parser.parse(testCase.test, {
      prefixIdsByThis: true,
      shouldUseIdInConnections: () => false,
    })
    assert.isEqual(result, {
      hash: testCase.hash,
      connections: '[["this","changeX"]]',
    })
  }
})

it('changes this to self', () => {
  const result = parser.parse('(this.dict ? this.dict.list : error)', {
    prefixIdsByThis: true,
    changeThisToSelf: true,
    shouldUseIdInConnections: () => false,
  })
  assert.isEqual(result, {
    hash: 'self.dict ? self.dict.list : this.error',
    connections: '[["this","error"]]',
  })
})

it('suffix this by target', () => {
  const result = parser.parse('name', {
    prefixIdsByThis: true,
    suffixThisByTarget: true,
  })
  assert.isEqual(result, {
    hash: 'this.target.name',
    connections: '[[["this","target"],"name"]]',
  })
})

it('discovers custom ids in connections', () => {
  const result = parser.parse('name.deep', {
    shouldUseIdInConnections: id => id === 'name',
    isHeadIdConnectionPublic: id => id === 'name',
  })
  assert.isEqual(result, {
    hash: 'name.deep',
    connections: '[[name,"deep"]]',
  })
})
