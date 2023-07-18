# README
Sample demo
https://www.i-class.dev

API
======
- Grape API
- GraphQL
- Postgresql
- Sidekiq
- Amazon-S3
- Amazon-SES (that is a cool one for sending messages)
- Sendgrid API (sendgrid-ruby gem) (no longer use, n)

#### Set up these environment keys properly

`AWS_ACCESS_KEY_ID`
`AWS_REGION`
`AWS_S3_BUCKET`
`AWS_SECRET_KEY`
`APP_JWT_AUD`
`APP_JWT_ISSUER`
`ROOT_API`
`SENDGRID_API_KEY`
`SENDGRID_SENDER`
`RESET_PASSWORD_TEMPLATE_ID`
`...`

Frontend
======

Vuex



Development
===========

To start a new development env, run the following:

1.  bundle exec rails s
2.  bundle exec sidekiq
2.  yarn
3.  ./bin/webpack-dev-server



Dependencies

1.  aws-sdk
2.  webpack (bundler for vuejs)
3.  Postgresql
4.  GraphQL
