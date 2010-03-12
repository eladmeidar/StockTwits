module Stocktwits
  class Error < StandardError; end
  
  def self.config(environment=RAILS_ENV)
    @config ||= {}
    @config[environment] ||= YAML.load(File.open(RAILS_ROOT + '/config/stocktwits.yml').read)[environment]
  end

  def self.base_url
    config['base_url'] || 'https://api.stocktwits.com'    
  end
  
  def self.path_prefix
    URI.parse(base_url).path
  end

  def self.api_timeout
    config['api_timeout'] || 10
  end
  
  def self.encryption_key
    raise TwitterAuth::Cryptify::Error, 'You must specify an encryption_key in config/stocktwits.yml' if config['encryption_key'].blank?
    config['encryption_key'] 
  end
  
  def self.oauth_callback?
    config.key?('oauth_callback')
  end
  
  def self.oauth_callback
    config['oauth_callback']
  end

  def self.remember_for
    (config['remember_for'] || 14).to_i
  end
  
  def self.strategy
    strat = config['strategy']
    raise ArgumentError, 'Invalid StockTwits Strategy: Valid strategies are oauth and basic.' unless %w(oauth basic plain).include?(strat)
    strat.to_sym
  rescue Errno::ENOENT
    :basic
  end
  
  def self.oauth?
    strategy == :oauth
  end
  
  def self.basic?
    strategy == :basic
  end
  
  def self.plain?
    strategy == :plain
  end
  
  def self.consumer
    options = {:site => Stocktwits.base_url}
    [ :authorize_path, 
      :request_token_path,
      :access_token_path,
      :scheme,
      :signature_method ].each do |oauth_option|
      options[oauth_option] = Stocktwits.config[oauth_option.to_s] if Stocktwits.config[oauth_option.to_s]
    end

    OAuth::Consumer.new(
      config['oauth_consumer_key'],          
      config['oauth_consumer_secret'],
      options 
    )
  end
  
  def self.net
    uri = URI.parse(Stocktwits.base_url)
    net = Net::HTTP.new(uri.host, uri.port)
    net.use_ssl = uri.scheme == 'https'
    net.read_timeout = Stocktwits.api_timeout
    net
  end

  def self.authorize_path
    config['authorize_path'] || '/oauth/authorize'
  end
end

require 'stocktwits/controller_extensions'
require 'stocktwits/cryptify'
require 'stocktwits/dispatcher/oauth'
require 'stocktwits/dispatcher/shared'

module Stocktwits
  module Dispatcher
    class Error < StandardError; end
    class Unauthorized < Error; end
  end
end
