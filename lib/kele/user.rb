require_relative "session"
require_relative "mentor"
require_relative "roadmap"

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

  def get_roadmap
    begin
      @roadmap = @user["current_enrollment"]["chain_id"]
      if @roadmap
        Roadmap.retrieve(@roadmap)
      else
        p "Could not find roadmap for user."
      end
    rescue => e
      p e.message
    end
  end

  def get_checkpoints
    begin
      @checkpoints = @user["current_enrollment"]["chain_id"]
      if @checkpoints
        Roadmap.retrieve(@checkpoints)
      else
        p "Could not find checkpoints for user."
      end
    rescue => e
      p e.message
    end
  end
  # def get_resource(parent, key, &block)
  #   begin
  #     resource = @user[parent][key]
  #     if resource
  #       yield
  #     else
  #       p "Could not find resource at #{parent}, #{key}."
  #     end
  #   rescue => e
  #     p e.message
  #   end
  # end
end
