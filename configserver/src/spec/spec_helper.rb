require 'test/spec'
require 'rack/test'

require 'common_config'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
end
