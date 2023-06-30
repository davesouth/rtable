source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

# Ruby [https://docs.ruby-lang.org/en/3.0/]
ruby '3.2.2'

# Security placeholder
gem 'uri', '>= 0.12.2'

# Ruby on Rails [https://api.rubyonrails.org]
gem 'rails', '7.0.6'

# Mongoid [https://www.mongodb.com/docs/mongoid/current/]
gem "mongoid", "~> 8.1.0"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Bootstrap 5 [https://github.com/twbs/bootstrap-rubygem]
gem 'bootstrap', '~> 5.1'

# HAML template language [https://haml.info/docs.html]
gem 'haml'

# Carrierwave file uploader [https://github.com/carrierwaveuploader/carrierwave-mongoid]
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'

# Image manipulation library [https://github.com/minimagick/minimagick]
gem 'mini_magick'

# Authorization [https://github.com/CanCanCommunity/cancancan]
gem 'cancancan'

# Enable SASS support [https://sass-lang.com/documentation/syntax]
gem 'sassc-rails'

# Software monitor [https://docs.sentry.io/platforms/ruby/guides/rails/]
gem 'sentry-ruby'
gem 'sentry-rails'

group :development, :test do
  # Rspec works best for Mongoid [https://github.com/rspec/rspec-rails]
  gem 'rspec-rails', '6.0.0.rc1'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Use the Puma web server [https://github.com/puma/puma]
  gem 'puma', '~> 5.0'

  # HAML template generators [https://github.com/haml/haml-rails]
  gem 'haml-rails'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'

  # Capistrano deployment [https://capistranorb.com]
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-maintenance', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false

  # SSH gems needed for ed25519 ssh keys in capistrano deployments
  gem 'ed25519', require: false
  gem 'bcrypt_pbkdf', require: false

end

group :test do
  # Helpful mongoid specific spec helpers [https://github.com/mongoid/mongoid-rspec]
  gem 'mongoid-rspec'

  # Create test objects on-the-fly [https://fabricationgem.org]
  gem 'fabrication'

  # Generate valid test data [https://github.com/faker-ruby/faker]
  gem 'faker'
end
