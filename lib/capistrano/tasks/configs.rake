desc "Symlink config files"
namespace :configs do
  task :link do
    on roles(:app) do |server|
      fulldir_files = Dir.glob("./files/**/*").select{|i| File.file? i}
      files         = fulldir_files.map{|f| f.gsub("./files/", "")}

      files.each do |file|
        run "ln -nfs #{release_path}/files/#{file} #{server.properties.q2root}/#{file}"
      end
    end
  end
end

after "deploy:symlink:release", "configs:link"
