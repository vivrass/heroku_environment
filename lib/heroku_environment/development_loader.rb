module HerokuEnvironment
  module DevelopmentLoader
    def self.load_environment
      environment_variables = HerokuEnvironment.config.read_configuration(HerokuEnvironment.config.configuration_file)

      if environment_variables.nil?
        environment_variables = HerokuEnvironment.config.read_configuration(HerokuEnvironment.config.production_configuration_file)

        if environment_variables.nil?
          raise MissingFileException.new("Missing configuration files (need at least 1):\nDevelopment: #{HerokuEnvironment.config.configuration_file}\nProduction: #{HerokuEnvironment.config.production_configuration_file}")
        end
      end

      environment_variables.each do |var, value|
        ENV[var] = value.to_s
      end
    end
  end
end
