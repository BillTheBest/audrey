env = ENV['RACK_ENV'].to_sym

require 'common_config'

set :environment,         env

if env == :development
  require 'ruby-debug'
end

run Sinatra::Application
