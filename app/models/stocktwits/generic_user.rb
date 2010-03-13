module Stocktwits
  class GenericUser < ActiveRecord::Base
    attr_protected :stocktwits_id, :remember_token, :remember_token_expires_at
    
    STOCKTWITS_FIELDS = ["avatar_url_thumb", 
                         "avatar_url_medium", 
                         #"profile", 
                         "following_count", 
                         #"id", 
                         "updates_count", 
                         "avatar_url_large", 
                         "last_name", 
                         "followers_count", 
                         "recommended", 
                         "bio", 
                         "login", 
                         "first_name"]
                         
    STOCKTWITS_PROFILE_FIELDS = ["approach",
                                 "location",
                                 "title",
                                 "risk_profile",
                                 "focus",
                                 #"id",
                                 "long_short",
                                 "qualifications",
                                 "user_id",
                                 "investment_style",
                                 "website",
                                 "asset_classes_traded",
                                 "bio",
                                 "capitalization_bias",
                                 "holding_period",
                                 "education",
                                 "industry",
                                 "personal_interests",
                                 "trading_experience"]
                                 
    # with_options :if => :utilize_default_validations do |v|
    #   v.validates_presence_of :login, :stocktwits_id
    #   v.validates_format_of :login, :with => /\A[a-z0-9_]+\z/i
    #   v.validates_length_of :login, :in => 1..15
    #   v.validates_uniqueness_of :login, :case_sensitive => false
    #   v.validates_uniqueness_of :stocktwits_id, :message => "ID has already been taken."
    #   v.validates_uniqueness_of :remember_token, :allow_blank => true
    # end
    
    def self.table_name; 'users' end

    def self.new_from_stocktwits_hash(hash)
      raise ArgumentError, 'Invalid hash: must include screen_name.' unless hash.key?('login')

      raise ArgumentError, 'Invalid hash: must include id.' unless hash.key?('id')

      user = User.new
      user.stocktwits_id = hash['id'].to_s
      user.login = hash['login']

      assign_stocktwits_attributes(hash)
      
      user
    end

    def self.from_remember_token(token)
      first(:conditions => ["remember_token = ? AND remember_token_expires_at > ?", token, Time.now])
    end
      
    def assign_stocktwits_attributes(hash)
      STOCKTWITS_FIELDS.each do |att|
        user.send("#{att}=", hash[att.to_s]) if user.respond_to?("#{att}=")
      end
      
      STOCKTWITS_PROFILE_FIELDS.each do |att|
        user.send("#{att}=", hash['profile'][att.to_s]) if user.respond_to?("#{att}=")
      end
    end

    def update_stocktwits_attributes(hash)
      assign_stocktwits_attributes(hash)
      save
    end

    if Stocktwits.oauth?
      include Stocktwits::OauthUser
    elsif Stocktwits.basic?
      include Stocktwits::BasicUser
    else
      include Stocktwits::PlainUser
    end

    def utilize_default_validations
      true
    end

    def stocktwits
      if Stocktwits.oauth?
        Stocktwits::Dispatcher::Oauth.new(self)
      elsif Stocktwits.basic?
        Stocktwits::Dispatcher::Basic.new(self)
      else
        Stocktwits::Dispatcher::Plain.new(self)
      end
    end

    def remember_me
      return false unless respond_to?(:remember_token)

      self.remember_token = ActiveSupport::SecureRandom.hex(10)
      self.remember_token_expires_at = Time.now + Stocktwits.remember_for.days
      
      save

      {:value => self.remember_token, :expires => self.remember_token_expires_at}
    end

    def forget_me
      self.remember_token = self.remember_token_expires_at = nil
      self.save
    end
  end
end
