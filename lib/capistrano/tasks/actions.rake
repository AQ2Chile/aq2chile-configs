namespace :server do
  desc "Open SSH session"
  task :ssh do
    on roles (:app) do |server|
      return if server != roles(:app)[ARGV[2].to_i] # you can call server:ssh 1|2|3|etc
      cmd = "ssh #{server.user}@#{server.hostname} -p #{server.port}"
      puts "Opening ssh session `#{cmd}`"
      exec cmd
    end
  end

  desc "Start all servers"
  task :startall do
    on roles (:app) do |server|
      execute "#{server.properties.q2root}/gs_starter.sh startall"
    end
  end

  desc "Stop all servers"
  task :stopall do
    on roles (:app) do |server|
      execute "#{server.properties.q2root}/gs_starter.sh stopall"
    end
  end

  desc "Stop/Restart <server_number_in_gs_starter>"
  task :stop do
    on roles (:app) do |server|
      execute "#{server.properties.q2root}/gs_starter.sh stop #{ARGV[2]}"
    end
  end

  desc "Soft recycle servers <screen_name>"
  task :soft_recycle do
    on roles (:app) do |server|
      execute "screen -S #{ARGV[2]} -X stuff 'sv_recycle 2\n'"
    end
  end

  desc "Hard recycle servers <screen_name>"
  task :hard_recycle do
    on roles (:app) do |server|
      execute "screen -S #{ARGV[2]} -X stuff recycle\n"
    end
  end

  desc "Start watcher"
  task :start_watcher do
    on roles (:app) do |server|
      execute "cd #{server.properties.q2root}; screen -dmS watcher ./gs_starter.sh startwatch"
    end
  end

  desc "Stop watcher"
  task :stop_watcher do
    on roles (:app) do |server|
      execute "screen -X -S watcher kill;rm -rf #{server.properties.q2root}/gs_starter.run"
    end
  end
end
