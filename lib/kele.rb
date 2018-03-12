require "kele/version"
require "httparty"

module Kele
  class User
    include HTTParty
    @url = "https://www.bloc.io/api/v1"

    def initialize(email, pass)
      begin
        @options = {
          body: {
            user: {
              email: email,
              password: pass
            }
          }
        }
        @token = HTTParty.post(@url, @options)
      rescue => e
        p e.message
      end
    end
  end
end
