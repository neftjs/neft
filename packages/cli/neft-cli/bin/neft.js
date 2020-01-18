#!/usr/bin/env node

process.env.NEFT_NODE = '1'
process.env.NEFT_SERVER = '1'
process.env.NEFT_PLATFORM = 'node'
process.env.NEFT_MODE = 'universal'

require('coffee-script/register')

try {
  require('@neft/cli')(process.argv.slice(2))
} catch (error) {
  console.error(error)
  process.exit(1)
}
