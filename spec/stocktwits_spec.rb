require File.dirname(__FILE__) + '/spec_helper'

describe Stocktwits do
  describe '.base_url' do
    it 'should have default to http://api.stocktwits.com' do
      Stocktwits.stub!(:config).and_return({})
      Stocktwits.base_url.should == 'http://api.stocktwits.com'
    end

    it 'should otherwise load from the config[base_url]' do
      Stocktwits.stub!(:config).and_return({'base_url' => 'https://example.com'})
      Stocktwits.base_url.should == 'https://example.com'
    end

    it 'should utilize oauth consumer settings' do
      @config = Stocktwits.config
      Stocktwits.stub!(:config).and_return(@config.merge('authorize_path' => '/somewhere_else'))
      Stocktwits.consumer.authorize_path.should == '/somewhere_else'
    end
  end

  describe ".path_prefix" do
    it 'should be blank if the base url does not have a path' do
      Stocktwits.stub!(:base_url).and_return("https://api.stocktwits.com:443")
      Stocktwits.path_prefix.should == ""
    end

    it 'should return the path prefix if one exists' do
      Stocktwits.stub!(:base_url).and_return("http://api.stocktwits.com/api/twitter")
      Stocktwits.path_prefix.should == "/api/twitter"
    end
  end

  describe '.api_timeout' do
    it 'should default to 10' do
      Stocktwits.stub!(:config).and_return({})
      Stocktwits.api_timeout.should == 10
    end

    it 'should be settable via config' do
      Stocktwits.stub!(:config).and_return({'api_timeout' => 15})
      Stocktwits.api_timeout.should == 15
    end
  end

  describe '.remember_for' do
    it 'should default to 14' do
      Stocktwits.stub!(:config).and_return({})
      Stocktwits.remember_for.should == 14
    end

    it 'should be settable via config' do
      Stocktwits.stub!(:config).and_return({'remember_for' => '7'})
      Stocktwits.remember_for.should == 7
    end
  end

  describe '.net' do
    before do
      stub_basic!
    end

    it 'should return a Net::HTTP object' do
      Stocktwits.net.should be_a(Net::HTTP)
    end

    it 'should be SSL if the base_url is' do
      Stocktwits.stub!(:config).and_return({'base_url' => 'http://api.stocktwits.com'})
      Stocktwits.net.use_ssl?.should be_false
      Stocktwits.stub!(:config).and_return({'base_url' => 'https://api.stocktwits.com'})
      Stocktwits.net.use_ssl?.should be_true
    end

    it 'should work from the base_url' do
      @net = Net::HTTP.new('example.com',80)
      Net::HTTP.should_receive(:new).with('example.com',80).and_return(@net)
      Stocktwits.stub!(:config).and_return({'base_url' => 'http://example.com'})
      Stocktwits.net
    end
  end 

  describe '#config' do
    before do
      Stocktwits.send(:instance_variable_set, :@config, nil)
      @config_file = File.open(File.dirname(__FILE__) + '/fixtures/config/stocktwits.yml')
      File.should_receive(:open).any_number_of_times.and_return(@config_file) 
    end

    it 'should load a hash from RAILS_ROOT/config/stocktwits.yml' do
      Stocktwits.config.should be_a(Hash)
    end

    it 'should be able to override the RAILS_ENV' do
      Stocktwits.config('development')['oauth_consumer_key'].should == 'devkey'
    end
  end

  describe '#consumer' do
    before do
      stub_oauth!
    end

    it 'should be an OAuth Consumer' do
      Stocktwits.consumer.should be_a(OAuth::Consumer)
    end

    it 'should use the credentials from #config' do
      Stocktwits.consumer.key.should == 'testkey'
      Stocktwits.consumer.secret.should == 'testsecret'
    end

    it 'should use the Stocktwits base_url' do
      Stocktwits.stub!(:base_url).and_return('https://example.com')
      Stocktwits.consumer.site.should == Stocktwits.base_url
      Stocktwits.consumer.site.should == 'https://example.com'
    end
  end

  describe '#strategy' do
    it 'should pull and symbolize from the config' do
      Stocktwits.stub!(:config).and_return({'strategy' => 'oauth'})
      Stocktwits.strategy.should == Stocktwits.config['strategy'].to_sym
    end
    
    it 'should raise an argument error if not oauth or basic' do
      Stocktwits.stub!(:config).and_return({'strategy' => 'oauth'}) 
      lambda{Stocktwits.strategy}.should_not raise_error(ArgumentError)

      Stocktwits.stub!(:config).and_return({'strategy' => 'basic'}) 
      lambda{Stocktwits.strategy}.should_not raise_error(ArgumentError)
      
      Stocktwits.stub!(:config).and_return({'strategy' => 'plain'}) 
      lambda{Stocktwits.strategy}.should_not raise_error(ArgumentError)
      
      Stocktwits.stub!(:config).and_return({'strategy' => 'invalid_strategy'}) 
      lambda{Stocktwits.strategy}.should raise_error(ArgumentError)
    end
  end

  it '#oauth? should be true if strategy is :oauth' do
    Stocktwits.stub!(:config).and_return({'strategy' => 'oauth'})
    Stocktwits.oauth?.should be_true
    Stocktwits.basic?.should be_false
    Stocktwits.plain?.should be_false
  end

  it '#basic? should be true if strategy is :basic' do
    Stocktwits.stub!(:config).and_return({'strategy' => 'basic'})
    Stocktwits.basic?.should be_true
    Stocktwits.oauth?.should be_false
    Stocktwits.plain?.should be_false
  end

  
  it '#plain? should be true if strategy is :basic' do
    Stocktwits.stub!(:config).and_return({'strategy' => 'plain'})
    Stocktwits.plain?.should be_true
    Stocktwits.oauth?.should be_false
    Stocktwits.basic?.should be_false
  end
  
  describe '#encryption_key' do
    it 'should raise a Cryptify error if none is found' do
      Stocktwits.stub!(:config).and_return({})
      lambda{Stocktwits.encryption_key}.should raise_error(Stocktwits::Cryptify::Error, "You must specify an encryption_key in config/stocktwits.yml")
    end

    it 'should return the config[encryption_key] value' do
      Stocktwits.stub!(:config).and_return({'encryption_key' => 'mickeymouse'})
      Stocktwits.encryption_key.should == 'mickeymouse'
    end
  end
end
