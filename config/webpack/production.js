process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
process.env.ROOT_API = process.env.ROOT_API || 'https://myclassr00m.herokuapp.com/api'

module.exports = environment.toWebpackConfig()
