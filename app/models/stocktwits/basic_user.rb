require 'net/http'

module Stocktwits
  module BasicUser
    def self.included(base)
      base.class_eval do
        attr_protected :crypted_password, :salt
      end

      base.extend Stocktwits::BasicUser::ClassMethods
    end

    module ClassMethods
      def verify_credentials(login, password)
        response = Stocktwits.net.start { |http|
          request = Net::HTTP::Get.new('/account/verify_credentials.json')
          request.basic_auth login, password
          http.request(request)
        }

        if response.code == '200'
          JSON.parse(response.body)
        else
          false
        end
      end

      def authenticate(login, password)
        if stocktwits_hash = verify_credentials(login, password)
          user = identify_or_create_from_stocktwits_hash_and_password(stocktwits_hash, password)
          user
        else
          nil
        end
      end

      def identify_or_create_from_stocktwits_hash_and_password(stocktwits_hash, password)
        if user = User.find_by_stocktwits_id(stocktwits_hash['id'].to_s)
          user.login = stocktwits_hash['screen_name']
          user.assign_stocktwits_attributes(stocktwits_hash)
          user.password = password
          user.save
          user
        else
          user = User.new_from_stocktwits_hash(stocktwits_hash)
          user.password = password
          user.save
          user
        end
      end
    end
   
    def password=(new_password)
      encrypted = Stocktwits::Cryptify.encrypt(new_password)
      self.crypted_password = encrypted[:encrypted_data]
      self.salt = encrypted[:salt]
    end

    def password
      Stocktwits::Cryptify.decrypt(self.crypted_password, self.salt)
    end
  end
end

