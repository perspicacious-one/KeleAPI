class Session
  include HTTParty
  attr_accessor :uri, :response
  attr_reader :auth_token

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

  def get_user
    self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
  end
end
