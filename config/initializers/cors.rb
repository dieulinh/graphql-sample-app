Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/public/*', headers: :any, methods: :get

    # Only allow a request for a specific host
    resource '/api/*',
        headers: :any,
        methods: [:get,
          :post,
          :put,
          :delete
        ], if: proc { |env| env['HTTP_HOST'] == 'https://iclass-fe.herokuapp.com' }
  end
end