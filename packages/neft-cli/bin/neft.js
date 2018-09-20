#!/usr/bin/env node

require('coffee-script/register')

process.env.NEFT_NODE = '1'
process.env.NEFT_SERVER = '1'
process.env.NEFT_PLATFORM = 'node'
require('../src')(process.argv.slice(2))
