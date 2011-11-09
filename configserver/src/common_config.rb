# This file has configs than both rack and rspec need that
# it seems we cannot put in the same file

root_dir = File.dirname(__FILE__)
version = ENV['AEOLUS_CONFSERVER_VERSION'] || '@VERSION@'
storage_dir = ENV['STORAGE_DIR'] || '/tmp/audrey'
instance_config_rng = ENV['INSTANCE_CONFIG_RNG'] ||
    '/var/lib/aeolus-configserver/schema/instance-config.rng'

proxy_type=ENV['PROXY_TYPE']
# when apache is handling auth
proxy_auth_file = ENV['PROXY_AUTH_FILE']

require 'configserver'
set :app_log,             ENV['APPLICATION_LOG']
set :storage_dir,         storage_dir
set :instance_config_rng, instance_config_rng
set :root,                root_dir
set :version,             version
set :proxy_type,          proxy_type
set :proxy_auth_file,     proxy_auth_file
set :app_file,            File.join(root_dir, 'hello.rb')
ConfigServer::Model.storage_dir = settings.storage_dir
disable :run

LOGGER = Logger.new(ENV['APPLICATION_LOG'])
