require 'pry'
desc "Symlink config files"
namespace :configs do
  desc "Link common files"
  task :link_common do
    on roles(:app) do |server|
      q2base_name          = "q2base"
      common_files         = Dir.glob("./#{q2base_name}/action/**/*").select{|i| File.file? i}
      cleaned_common_files = common_files.map{|f| f.gsub("./#{q2base_name}/", "")}

      # COMMON
      cleaned_common_files.each do |file|
        execute "ln -nfs #{release_path}/#{q2base_name}/#{file} #{server.properties.q2root}/#{file}"
      end
    end
  end

  desc "Link shared files"
  task :link_shared do
    on roles(:app) do |server|
      q2base_name          = "q2base"
      shared_files         = Dir.glob("./#{q2base_name}/shared/**/*").select{|i| File.file? i}
      cleaned_shared_files = shared_files.map{|f| f.gsub("./#{q2base_name}/shared/", "")}

      # SHARED
      cleaned_shared_files.each do |file|
        execute "ln -nfs #{shared_path}/#{file} #{server.properties.q2root}/action/#{file}"
      end
    end
  end
end

after "deploy:symlink:release", "configs:link_common"
after "deploy:symlink:release", "configs:link_shared"
