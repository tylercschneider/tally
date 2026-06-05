require_relative "lib/tally/version"

Gem::Specification.new do |spec|
  spec.name        = "tally"
  spec.version     = Tally::VERSION
  spec.authors     = [ "tylercschneider" ]
  spec.email       = [ "tylercschneider@gmail.com" ]
  spec.homepage    = "https://github.com/tylercschneider/tally"
  spec.summary     = "Source-agnostic aggregation engine: measures, rollups, sketches"
  spec.description = "Turn facts into numbers. Tally declares measures, rolls them up by time grain and dimension, and recomputes idempotently. Source-agnostic — feed it any facts (dimensions + measures); it does not depend on any particular event source."
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/tylercschneider/tally/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/tylercschneider/tally/issues"
  spec.metadata["documentation_uri"] = "https://github.com/tylercschneider/tally#readme"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.add_dependency "rails", ">= 7.1.6", "< 9"
end
