# RTable deployment
set :application, 'rtable'

# Repository
set :repo_url, "https://#{ENV['CAP_GITHUB_TOKEN']}:@github.com/davesouth/rtable.git"
set :branch, :main

# Directories
set :deploy_to, "/Users/ruby/rtable"
set :default_env, { path: "/opt/homebrew/bin:/usr/local/bin:$PATH" }
append :linked_files, 'config/master.key', 'config/app.yml', 'config/mongoid.yml'
append :linked_dirs, 'log', 'public/system'

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Passenger
set :passenger_restart_with_touch, true

# Clean up assets
set :keep_assets, 3

# Default value for keep_releases is 5
set :keep_releases, 5
