process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.ROOT_API = 'https://www.i-class.info/api'
const dotenv = require('dotenv')
dotenv.config();
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
