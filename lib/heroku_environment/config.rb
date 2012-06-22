module HerokuEnvironment
  class Config
    def configuration_file
      "#{Rails.root}/config/heroku_environment.yml"
    end
  end
end
