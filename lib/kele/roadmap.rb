require_relative "session"
require_relative "helper"

module Roadmap
  extend self
  include HTTParty

  def get(id)
    @id = id
    p @id
    @roadmap = self.get("https://www.bloc.io/api/v1/roadmaps/#{@id}", body: {"id" => @id} headers: { "authorization" => Session.get_token })
  end

  def checkpoint(id)
    @id = id
    #@checkpoint_id = checkpoint_id.to_s
    @checkpoint = self.get("https://www.bloc.io/api/v1/checkpoints/#{@id}",  headers: { "authorization" => Session.get_token })
  end

  def remaining_checkpoints(id)
    @id = id
    #@chain_id = chain_id.to_s
    @remaining = self.get("https://www.bloc.io/api/v1/enrollment_chains/#{@id}/checkpoints_remaining_in_section", headers: { "authorization" => Session.get_token })
  end
end
