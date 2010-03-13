require 'net/http'

module Stocktwits
  module Dispatcher
    class Plain
      include Stocktwits::Dispatcher::Shared

      attr_accessor :user

      def initialize(user)
        raise Stocktwits::Error, 'Dispatcher must be initialized with a User.' unless user.is_a?(Stocktwits::PlainUser)
        self.user = user
      end

      def request(http_method, path, body=nil, *arguments)
        path = Stocktwits.path_prefix + path
        path = append_extension_to(path)
        response = Stocktwits.net.start{ |http|
          req = "Net::HTTP::#{http_method.to_s.capitalize}".constantize.new(path, *arguments)
          req.set_form_data(body) unless body.nil?
          http.request(req)
        }
        
        handle_response(response)      
      end

      def get(path, *arguments)
        request(:get, path, *arguments)
      end

      def post(path, body='', *arguments)
        request(:post, path, body, *arguments)
      end

      def put(path, body='', *arguments)
        request(:put, path, body, *arguments)
      end

      def delete(path, *arguments)
        request(:delete, path, *arguments)
      end
    end
  end
end
