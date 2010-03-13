require 'net/http'

module Stocktwits
  module PlainUser
    def self.included(base)
      base.class_eval do

      end

      base.extend Stocktwits::PlainUser::ClassMethods
    end

    module ClassMethods
      def verify_credentials(login, password)
        response = Stocktwits.net.start { |http|
          request = Net::HTTP::Get.new("/user/#{login}.json")
          http.request(request)
        }

        if response.code == '200'
          JSON.parse(response.body)
        else
          false
        end
      end

      def authenticate(login, password = nil)
        if stocktwits_hash = verify_credentials(login, password)
          user = identify_or_create_from_stocktwits_hash_and_password(stocktwits_hash, password)
          user
        else
          nil
        end
      end
      
      def identify_or_create_from_stocktwits_hash_and_password(stocktwits_hash, password)
        if user = User.find_by_stocktwits_id(stocktwits_hash['id'].to_s)
          user.login = stocktwits_hash['login']
          user.assign_stocktwits_attributes(stocktwits_hash)
          user.save
          user
        else
          user = User.new_from_stocktwits_hash(stocktwits_hash)
          user.save
          user
        end
      end
      
    end
  end
end

