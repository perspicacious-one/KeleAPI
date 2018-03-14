require_relative "session"
require_relative "mentor"

module User
  extend self
  include HTTParty

  attr_reader :user, :mentor_id

  def load
    if Session.open_status
      @user = self.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => Session.get_token })
      if @user.code == 200
        @user.parsed_response
      else
        p @user.code + "\n" + @user.parsed_response
      end
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

  def mentor_availability
    begin
      @mentor_id = @user["current_enrollment"]["mentor_id"]
      if @mentor_id
        Mentor.get_availability(@mentor_id)
      else
        p "Could not find mentor id for user."
      end
    rescue => e
      p e.message
    end
  end
end
