assert = require('assert')
module.paths.push('lib')
merge = require('object_merge')

describe "objectMerge", ->

  it "is undefined for no parameters", ->
    assert.strictEqual merge(), undefined

  describe "given an empty object", ->

    o = merge(i = {})

    it "is an empty object", ->
      assert.deepEqual o, {}

    it "is a new object", ->
      assert.notStrictEqual o, i

    it "does not mutate the given object", ->
      assert.deepEqual i, {}

  describe "given a series of empty objects", ->

    o = merge(i1 = {}, i2 = {}, i3 = {})

    it "is an empty object", ->
      assert.deepEqual o, {}

    it "is a different object from any of the given objects", ->
      assert.notStrictEqual o, i for i in [i1, i2, i3]

    it "does not mutate any of the given objects", ->
      assert.deepEqual i, {} for i in [i1, i2, i3]

  describe "given an object with properties", ->

    f = -> 'ccc'
    o = merge(i = {a: 111, b: 'bbb', c: f})

    it "is a copy of the given object", ->
      assert.deepEqual o, i

    it "is a different object from the given object", ->
      assert.notStrictEqual o, i

    it "does not mutate the given object", ->
      assert.deepEqual i, {a: 111, b: 'bbb', c: f}

  describe "given a series of objects with complimentary properties", ->

    f = -> 'ccc'
    o = merge(i1 = {a: 111}, i2 = {b: 'bbb'}, i3 = {c: f})

    it "has all and only the properties of the given objects", ->
      assert.deepEqual o, {a: 111, b: 'bbb', c: f}

    it "is a different object from any of the given objects", ->
      assert.notStrictEqual o, i for i in [i1, i2, i3]

    it "does not mutate any of the given objects", ->
      assert.deepEqual i1, {a: 111}
      assert.deepEqual i2, {b: 'bbb'}
      assert.deepEqual i3, {c: f}

  describe "given a series of objects with a common property", ->

    o = merge(i1 = {p: 'i1'}, i2 = {p: 'i2'}, i3 = {p: 'i3'})

    it "takes the value of the common property from the last object that has it", ->
      assert.deepEqual o, i3

  describe "given a series of objects that ends with an empty object", ->

    o = merge(i1 = {p: 'i1'}, i2 = {p: 'i2'}, i3 = {})

    it "takes the value of the common property from the last object that has it", ->
      assert.deepEqual o, {p: 'i2'}
