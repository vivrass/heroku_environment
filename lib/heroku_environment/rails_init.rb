require 'rails'

class MyCoolRailtie < Rails::Railtie

  config.before_initialize do
    # Load the development environment
    HerokuEnvironment::DevelopmentLoader.load_environment
  end

  rake_tasks do
    load "#{File.dirname(__FILE__)}/tasks/heroku_environment.tasks"
  end
end
