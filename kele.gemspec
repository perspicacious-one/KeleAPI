

Gem::Specification.new do |s|
  s.name          = "kele"
  s.version       = "0.0.1"
  s.authors       = ["Nelson"]
  s.email         = ["nelsondcraig@gmail.com"]

  s.homepage    = "http://rubygems.org/gems/kele"
  s.summary     = "Kele API Client."
  s.description = "A client for the Bloc API"
  s.add_runtime_dependency 'httparty', '~> 0.13'
  s.files         = ['lib/kele.rb', 'lib/kele/session.rb', 'lib/kele/user.rb', 'lib/kele/version.rb']
  s.require_paths = ["lib"]
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

end
