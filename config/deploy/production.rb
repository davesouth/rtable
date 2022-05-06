# Production stage
set :stage,  :production

# Set target server in .ssh/config
set :server, 'spherus.production'

# Server roles
server fetch(:server), roles: %w[web app db]

# Server data utilities
namespace :data do
  server_ssh_name = fetch(:server)
  server_data_dir = shared_path.join('data')
  local_data_dir = 'db/data'

  desc 'Synchronize production data with local environment'
  task :sync do
    run_locally do
      Rake::Task['data:dump'].invoke
      Rake::Task['data:download'].invoke
      Rake::Task['data:load'].invoke
    end
  end

  desc 'Dump production database on server'
  task :dump do
    on roles(:db) do |host|
      within release_path do
        with rails_env: :production, path: '/usr/local/bin:$PATH' do
          execute :mkdir, "-p #{server_data_dir}"
          rake "data:dump DIR=#{server_data_dir}"
        end
      end
    end
  end

  desc 'Download production database to local environment'
  task :download do
    run_locally do
      system "rsync -rtvh #{server_ssh_name}:#{server_data_dir}/ #{local_data_dir}"
    end
  end

  desc 'Load local data into development database'
  task :load do
    run_locally do
      system "rake data:load DIR=#{local_data_dir}"
    end
  end

end

# Autorun data tasks
desc 'Synchronize production data with local environment'
task :data do
  run_locally do
    Rake::Task['data:dump'].invoke
    Rake::Task['data:download'].invoke
    Rake::Task['data:load'].invoke
  end
end
