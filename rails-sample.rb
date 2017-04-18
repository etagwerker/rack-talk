# config/initializers/rack_tracker.rb

MyApp.config.middleware.use Rack::Tracker do
  handler :google_analytics, { tracker: 'U-1234-5' }
end
