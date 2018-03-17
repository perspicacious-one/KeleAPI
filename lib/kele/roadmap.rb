require_relative "session"

module Roadmap
  extend self
  include HTTParty

  def retrieve(id)
    @id = id
    @roadmap = self.get("https://www.bloc.io/api/v1/roadmaps/#{@id}", headers: { "authorization" => Session.get_token })
    parse_response(@roadmap)
  end

  def checkpoints(enrollment_id)
    @id = enrollment_id
    @checkpoints = self.get("https://www.bloc.io/api/v1/enrollment_chains/#{@id}/checkpoints_remaining_in_section", headers: { "authorization" => Session.get_token })
    parse_response(@checkpoints)
  end

  def parse_response(response)
    begin
      if response.code == 200
        result = []
        response.parsed_response.map { |hash| hash.each { |key, value| result.push({key => value}) } }
        result
      else
        p response.code + "\n" + response.parsed_response
      end
    rescue => e
      p e.message
    end
  end
end
