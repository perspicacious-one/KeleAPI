require "httparty"

module Kele

  class Session
    include HTTParty
    attr_accessor :token, :uri, :response

    def initialize(email, pass)
      begin
        @uri = "https://www.bloc.io/api/v1/sessions"
        @values = {
          body: {
                email: email,
                password: pass
          }
        }


        @token = self.class.post(@uri, @values)
      rescue => e
        p e.message
      end
      p Module.nesting
    end

    private

  end

end

# Kele::Session.new("nelsondcraig@gmail.com", "%7sCAqjH9c6a8ysB")
