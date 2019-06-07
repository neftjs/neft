'use strict'

Resources = require './'

{Resource} = Resources

rscs = child = image = null

beforeEach ->
    rscs = new Resources
    child = rscs.child = new Resources
    image = child.image = new Resource

describe 'getResource()', ->
    it 'returns requested resource', ->
        assert.is rscs.getResource('child/image'), image

    it 'returns requested resources', ->
        assert.is rscs.getResource('child'), child

    it 'returns requested resource with separator in name', ->
        rsc = new Resource
        child['ab/cd'] = rsc
        assert.is rscs.getResource('child/ab/cd'), rsc

    it 'returns undefined for unknown path', ->
        assert.is rscs.getResource('abc123'), undefined

    it 'returns undefined for unknown child path', ->
        assert.is rscs.getResource('child/abc123'), undefined

    it 'returns undefined for unknown resource path', ->
        assert.is rscs.getResource('child/image/abc'), undefined

    it 'returns undefined for resource path with suffix', ->
        assert.is rscs.getResource('child/image_abc'), undefined

    it 'returns undefined for child path with suffix', ->
        assert.is rscs.getResource('child_abc'), undefined

describe 'resolve()', ->
    rscUri = uri = rsc = req = result = null

    beforeEach ->
        uri = ''
        req = {}
        rscs = Object.create Resources::
        rscs.getResource = (path) => rsc if path is uri
        result = 'requiredResult'
        rsc = Object.create Resource::
        rscUri = ''
        rsc.file = 'testFile'
        rsc.resolve = (path, localReq) => result if localReq is req and path is rscUri

    it 'returns resolved resource', ->
        rscUri = ".abc123"
        uri = "rsc://abc123/#{rsc.file}#{rscUri}"
        assert.is rscs.resolve(uri, req), result
