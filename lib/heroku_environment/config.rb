module HerokuEnvironment
  class Config
    def configuration_file
      if defined?(Rails)
        "#{Rails.root}/config/heroku_environment.yml"
      end
    end

    def production_configuration_file
      if defined?(Rails)
        "#{Rails.root}/config/production_heroku_environment.yml"
      end
    end

    def read_configuration(configuration_file)
      if File.exists?(configuration_file)
        YAML.load(File.read(configuration_file))
      else
        nil
      end
    end
  end
end
