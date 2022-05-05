# Spherus deployment
set :application, 'spherus'

# Repository
set :repo_url, "https://#{ENV['CAP_GITHUB_TOKEN']}:@github.com/davesouth/spherus.git"
set :branch, :main

# Directories
set :deploy_to, "/Users/ruby/spherus"
set :default_env, { path: "/usr/local/bin:$PATH" }
append :linked_files, 'config/master.key'
append :linked_dirs, 'log', 'public/system'

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# RBENV
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_custom_path, '/usr/local/var/rbenv'
set :rbenv_bin, '/usr/local/bin/rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_bin)} exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# Passenger
set :passenger_restart_with_touch, true

# Clean up assets
set :keep_assets, 3

# Default value for keep_releases is 5
set :keep_releases, 5
