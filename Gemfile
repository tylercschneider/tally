source "https://rubygems.org"

# Specify your gem's dependencies in tally.gemspec.
gemspec

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem "rubocop-rails-omakase", require: false

gem "the_local", github: "DYB-Development/the_local", ref: "e5ab947b194652d57d31f29231250a706755b9be"

group :development, :test do
  gem "puma"
  gem "sqlite3"
  gem "propshaft"
  gem "pry"
  gem "minitest", "~> 5.0"
end
