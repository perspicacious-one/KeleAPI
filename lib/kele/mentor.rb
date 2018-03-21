require_relative "session"
require_relative "helper"

module Mentor
  extend self
  include HTTParty

  attr_reader :id

  def get_availability(id)
    @id = id
    @response = self.get("https://www.bloc.io/api/v1/mentors/#{@id}/student_availability", headers: { "authorization" => Session.get_token })
    @response.parsed_response
  end

end
