require 'pry'
desc "Symlink config files"
namespace :configs do
  task :link do
    on roles(:app) do |server|
      common_files = Dir.glob("./q2base/action/**/*").select{|i| File.file? i}
      shared_files = Dir.glob("./q2base/shared/**/*").select{|i| File.file? i}

      cleaned_common_files = common_files.map{|f| f.gsub("./q2base/", "")}
      cleaned_shared_files = shared_files.map{|f| f.gsub("./q2base/shared/", "")}
      binding.pry

      # COMMON
      cleaned_common_files.each do |file|
        execute "ln -nfs #{release_path}/files/#{file} #{server.properties.q2root}/#{file}"
      end

      # SHARED
      cleaned_shared_files.each do |file|
        execute "ln -nfs #{shared_path}/#{file} #{server.properties.q2root}/#{file}"
      end
    end
  end
end

after "deploy:symlink:release", "configs:link"
