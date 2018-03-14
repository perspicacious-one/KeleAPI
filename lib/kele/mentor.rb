require_relative "session"

module Mentor
  extend self
  include HTTParty

  attr_reader :id

  def get_availability(id)
    @id = id
    @response = self.get("https://www.bloc.io/api/v1/mentors/#{@id}/student_availability", headers: { "authorization" => Session.get_token })
    if @response.code == 200
      availability = []
      @response.parsed_response.map { |hash| hash.each { |key, value| availability.push({key => value}) } }
      availability
    else
      p @response.code + "\n" + @response.parsed_response
    end
  end
end
