# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile

# https://github.com/capistrano/rbenv
require 'capistrano/rbenv'

# https://github.com/capistrano/bundler
require 'capistrano/bundler'

# https://github.com/capistrano/rails
require 'capistrano/rails/assets'

# https://github.com/capistrano/passenger
require 'capistrano/passenger'

# https://github.com/capistrano/maintenance
require 'capistrano/maintenance'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
