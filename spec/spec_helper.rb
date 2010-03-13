begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

require File.dirname(__FILE__) + '/../app/models/stocktwits/generic_user'

class Stocktwits::GenericUser
  def self.table_name; 'stocktwits_users' end
end

class User < Stocktwits::GenericUser; end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'remarkable'
require File.dirname(__FILE__) + '/fixtures/factories'
require File.dirname(__FILE__) + '/fixtures/fakeweb'
require File.dirname(__FILE__) + '/fixtures/stocktwits'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

load(File.dirname(__FILE__) + '/schema.rb')

def define_basic_user_class!
  Stocktwits::GenericUser.send :include, Stocktwits::BasicUser 
end

def define_oauth_user_class!
  Stocktwits::GenericUser.send :include, Stocktwits::OauthUser  
end

def define_plain_user_class!
  Stocktwits::GenericUser.send :include, Stocktwits::PlainUser  
end

def stub_oauth!
  Stocktwits.stub!(:config).and_return({
    'strategy' => 'oauth',
    'oauth_consumer_key' => 'testkey',
    'oauth_consumer_secret' => 'testsecret'
  })
  define_oauth_user_class!
end

def stub_basic!
  Stocktwits.stub!(:config).and_return({
    'strategy' => 'basic',
    'encryption_key' => 'secretcode'
  })
  define_basic_user_class!
end

def stub_plain!
  Stocktwits.stub!(:config).and_return({
    'strategy' => 'plain'
  })
  define_plain_user_class!
end

define_oauth_user_class!
