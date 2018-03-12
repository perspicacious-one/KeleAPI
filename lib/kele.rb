require "httparty"

class Kele

  include HTTParty
  attr_accessor :auth_token, :uri, :response

  def initialize(email, pass)
    begin
      @uri = "https://www.bloc.io/api/v1/sessions"
      @values = {
        body: {
              email: email,
              password: pass
        }
      }
      @response = self.class.post(@uri, @values)
      @auth_token = @response["auth_token"]
    rescue => e
      p e.message
    end
  end
end
