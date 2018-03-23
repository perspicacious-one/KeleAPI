require_relative "session"
require_relative "mentor"
require_relative "roadmap"
require_relative "helper"

module User
  extend self
  include HTTParty

  attr_reader :user, :mentor_id, :threads, :thread_response

  def load
    if Session.open_status
      @user = self.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => Session.get_token })
      if Helper.check_code(@user.parsed_response[:code])
        load_threads
      else
        Helper.custom_parse(@user)
      end
    end
  end

  def response
    @user
  end

  def mentor_availability
    arr = ["current_enrollment", "mentor_id"]
    id = get_key_value(arr)
    Mentor.get_availability(id)
  end

  def get_roadmap
    arr = ["current_enrollment", "chain_id"]
    id = get_key_value(arr)
    Roadmap.get(id)
  end

  def get_checkpoints
    arr = ["current_enrollment", "chain_id"]
    id = get_key_value(arr)
    Roadmap.checkpoints(id)
  end

  def load_threads(page)
    begin
      @threads = []
      @thread_response = self.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => Session.get_token })
      count = @thread_response.parsed_response["count"]
      if page == nil
        max = ((count / 10).to_f).ceil.to_i
        (1...max).each do |i|
          @thread_response = self.get("https://www.bloc.io/api/v1/message_threads", body: { page: i.to_s }, headers: { "authorization" => Session.get_token })
          @threads.push(@thread_response.parsed_response["items"])
        end
      else
        @thread_response = self.get("https://www.bloc.io/api/v1/message_threads", body: { page: page.to_s }, headers: { "authorization" => Session.get_token })
        @thread_response.parsed_response["items"]
      end
      @threads
    rescue => e
      p e.message
    end
  end

  def send_message(subject, body, token = nil, to_id = nil)
    load_threads if !@threads

    if !to_id
      to_id = get_key_value(["current_enrollment", "mentor_id"])
    end

    sender = get_key_value(["email"])

    @send_response = self.post("https://www.bloc.io/api/v1/messages", body: {"sender" => sender, "recipient_id" => to_id, "token" => token, "subject" => subject, "stripped-text" => body }, headers: { "authorization" => Session.get_token } )
  end
  
  def get_key_value(array)
    begin
      if @user
        resource = @user
        array.each do |key|
          resource = resource[key]
        end
        resource
      else
        p "No user loaded."
      end
    rescue => e
      p e.message
    end
  end

end
