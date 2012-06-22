namespace :heroku_environment do
  desc "Save prodution environment variable to heroku server"
  task :update do
    HerokuEnvironment::DeployHeroku.verify_config_files
    HerokuEnvironment::DeployHeroku.load_environment
  end
end

