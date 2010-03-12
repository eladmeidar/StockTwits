require 'net/http'

module Stocktwits
  module PlainUser
    def self.included(base)
      base.class_eval do

      end

      base.extend Stocktwits::PlainUser::ClassMethods
    end

    module ClassMethods
      def verify_credentials#(login, password)
        true
      end

      def authenticate(login, password = nil)
        user = User.find_by_login(login)
      end
    end
  end
end

