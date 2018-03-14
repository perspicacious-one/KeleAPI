
module Session
  include HTTParty
  extend self

  attr_reader :auth_token, :is_open

  def start(email, pass)
    begin
      @uri = "https://www.bloc.io/api/v1/sessions"
      values = {
        body: {
              email: email,
              password: pass
        }
      }
      @response = self.post(@uri, values)
      set_token
    rescue => e
      close
      p e.message
    end
  end

  def get_token
    auth_token
  end

  def open_status
    @is_open
  end

  private

  def set_token
    begin
      if @response.code != 200
        p @response.message
        close
      else
        @auth_token = @response["auth_token"]
        open
      end
    rescue => e
      close
      puts "Rescued #{e.inspect}"
    end
  end

  def open
    @is_open = true
    ["Session open", is_open]
  end

  def close
    @is_open = false
    ["Session closed", is_open]
  end

end
