require 'oauth'
require 'oauth/request_proxy/rack_request'
require 'lib/model/consumer'

module ApplicationHelper
  def logger
    LOGGER
  end

  def configs
    ConfigServer::Model.instance_config_schema_location =
      settings.instance_config_rng

    @configs ||= ConfigServer::InstanceConfigs.new(settings, LOGGER)
  end

  def app_version
    settings.version
  end

  def api_version
    "1"
  end

  def app_log_file
    settings.app_log
  end

  def api_version_valid?(request, version)
    root_path = request.path[0, (request.path.index('/', 1) + 1)]
    if ["/params/", "/configs/"].include? root_path
      return api_version == version.to_s
    end
    return true
  end

  def authenticate!
    if not authenticated?
      throw :halt, [401, "Not Authorized\n"]
    end
  end

  def authenticated?
    OAuth::Signature.verify(request) do |request_proxy|
      consumer = ConfigServer::Model::Consumer.find(request_proxy.consumer_key)
      if not consumer.nil?
        [nil, consumer.secret]
      else
        [nil, ""]
      end
    end
  end
end
