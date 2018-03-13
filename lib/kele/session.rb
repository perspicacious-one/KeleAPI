class Session
  include HTTParty
  attr_reader :auth_token

  def initialize(email, pass)
    begin
      @uri = "https://www.bloc.io/api/v1/sessions"
      values = {
        body: {
              email: email,
              password: pass
        }
      }
      @response = self.class.post(@uri, values)
      set_token
    rescue => e
      p e.message
    end
  end

  def get_user
    user = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    user.body
  end

  private

  def set_token
    begin
      @response.inspect
      if @response.code != 200
        p @response.message
      else
        @auth_token = @response["auth_token"]
      end
    rescue => e
      puts "Rescued #{e.inspect}"
    end
  end

end
