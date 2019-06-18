const { cliEnv } = require('@neft/cli-env')

// parcel uses process.env for building files;
// to use neft with cli env (and not the target building by parcel) we need to mock them
const env = { ...process.env }
process.env = cliEnv
require('coffee-script/register')
require('@neft/core')
process.env = env
