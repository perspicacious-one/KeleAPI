require_relative "session"
require_relative "helper"
module Roadmap
  extend self
  include HTTParty

  def get(id)
    @id = id
    @roadmap = self.get("https://www.bloc.io/api/v1/roadmaps/#{@id}", headers: { "authorization" => Session.get_token })
    Helper.custom_parse(@roadmap)
  end

  def checkpoints(enrollment_id)
    @enrollment_id = enrollment_id
    @checkpoints = self.get("https://www.bloc.io/api/v1/enrollment_chains/#{@enrollment_id}/checkpoints_remaining_in_section", headers: { "authorization" => Session.get_token })
    Helper.custom_parse(@checkpoints)
  end

end
