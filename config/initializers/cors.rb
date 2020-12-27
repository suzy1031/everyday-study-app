# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'http://localhost:8080', 'http://localhost:3000', 'http://localhost:5000', 'https://still-dusk-87527.herokuapp.com/'

#     resource '*',
#       headers: :any,
#       credentials: true,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end