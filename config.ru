require 'rack'
require 'rack/tracker'
require_relative 'rack/random_gif'

# config.ru

app = Rack::Builder.app do
  use Rack::Tracker do
    handler :google_analytics, { tracker: 'U-1234-5' }
  end

  run Proc.new { |env| # this is a hash
    req = Rack::Request.new(env)

    [
      # HTTP Response Code
      200,
      # Headers Hash
      {'Content-Type' => 'text/html'},
      # Response Body
      req.head? ? '' : ['<html><head></head><body>rack & roll</body></html>']
    ]
  }

  use RandomGif
end

run app
