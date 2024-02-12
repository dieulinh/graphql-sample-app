Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'iclass-fe.herokuapp.com', 'http://localhost:3000', 'www.bikiin.com', 'i-work.info', ENV['NEW_APP_ENDPOINT']
    resource '/public/*', headers: :any, methods: :get

    # Only allow a request for a specific host
    resource '/api/*',
        headers: :any,
        methods: [:get,
          :post,
          :put,
          :delete,
          :options,
          :head
        ]
  end
end
