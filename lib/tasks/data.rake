require 'active_support/core_ext/hash/indifferent_access'

namespace :data do

  desc 'Dump compressed data archive to DIR'
  task :dump do
    abort 'Usage: rake data:dump DIR=/path/to/data/dump' unless ENV['DIR'].present?

    # Save target directory
    if File.directory?(ENV['DIR'])
      data_dir = Dir.new(ENV['DIR']).path
    else
      abort "Abort: Target directory doesn't exist -- #{ENV['DIR']}"
    end

    # Dump data
    print  "mongo :: #{database} ... exporting ... "
    if username?
      system "echo #{password} | mongodump --quiet -u #{username} -p '' --authenticationDatabase #{auth_source} -d #{database} -o #{data_dir}"
    else
      system "mongodump --quiet -d #{database} -o #{data_dir}"
    end

    # Rename and compress
    print  'compressing ... '
    system "cd #{data_dir}; mv #{database} #{app_name}; tar czf #{app_name}.tgz #{app_name}; rm -rf #{app_name}"
    puts   'done.'
  end


  desc 'Load compressed data archive from DIR'
  task :load do
    abort 'Usage: rake data:load DIR=/path/to/source/data' unless ENV['DIR'].present?

    # Save recommended data directory
    if File.directory?(ENV['DIR'])
      data_dir = Dir.new(ENV['DIR']).path
    else
      abort "Abort: Source directory doesn't exist -- #{ENV['DIR']}"
    end

    # Confirm data files exist
    confirm_data_files(["#{data_dir}/#{app_name}.tgz"])

    # Create temporary directory
    temp_dir = `mktemp -d`

    # Decompress data
    print  "mongo :: #{database} ... decompressing ... "
    system "tar xfz #{data_dir}/#{app_name}.tgz --cd #{temp_dir}"

    # Load data
    print  'importing ... '
    if username?
      system "echo #{password} | mongorestore --quiet -u #{username} -p '' --authenticationDatabase #{auth_source} --drop -d #{database} #{temp_dir.strip}/#{app_name}"
    else
      system "mongorestore --quiet --drop -d #{database} #{temp_dir.strip}/#{app_name}"
    end

    # Remove temporary directory
    system "rm -rf #{temp_dir}"
    puts   'done.'
  end

private

  def mongoid
    @mongoid ||= ActiveSupport::HashWithIndifferentAccess.new(Rails.application.config_for(:mongoid))[:clients][:default]
  end

  def database
    mongoid[:database]
  end

  def username?
    mongoid[:options].try(:has_key?, :user)
  end

  def username
    mongoid[:options][:user]
  end

  def password
    mongoid[:options][:password]
  end

  def auth_source
    mongoid[:options][:auth_source]
  end

  def app_name
    Rails.application.class.module_parent.to_s.downcase
  end

  def confirm_data_files(files)
    files.each do |file|
      abort "Abort: Cannot find source file #{file}" unless File.exist?(file)
    end
  end

end
