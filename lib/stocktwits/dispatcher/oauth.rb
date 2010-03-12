require 'oauth'

module Stocktwits
  module Dispatcher
    class Oauth < OAuth::AccessToken
      include Stocktwits::Dispatcher::Shared

      attr_accessor :user

      def initialize(user)
        raise Stocktwits::Error, 'Dispatcher must be initialized with a User.' unless user.is_a?(Stocktwits::OauthUser) 
        self.user = user
        super(Stocktwits.consumer, user.access_token, user.access_secret)
      end

      def request(http_method, path, *arguments)
        path = Stocktwits.path_prefix + path
        path = append_extension_to(path)

        response = super

        handle_response(response)
      end
    end
  end
end
