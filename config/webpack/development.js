process.env.NODE_ENV = process.env.NODE_ENV || 'development'
// process.env.ROOT_API = process.env.ROOT_API || 'http://localhost:3000/api'
const dotenv = require('dotenv')
dotenv.config();

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
