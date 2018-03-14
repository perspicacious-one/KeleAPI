require_relative "session"

module User
  extend self
  include HTTParty

  def load
    if Session.open_status
      @user = self.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => Session.get_token })
    else
      p "No active session."
    end
  end

  def response
    @user
  end

  def get_value(key)
    if @user
      begin
        @user[key]
      rescue => e
        p e.message
      end
    else
      p "No user loaded."
    end
  end

end
