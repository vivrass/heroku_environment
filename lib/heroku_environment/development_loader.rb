module HerokuEnvironment
  module DevelopmentLoader
    def self.load_environment
      raise MissingFileException.new("Missing file for development: #{HerokuEnvironment.config.configuration_file}") unless File.exists?(HerokuEnvironment.config.configuration_file)

      environment_variables = YAML.load(File.read(HerokuEnvironment.config.configuration_file))

      environment_variables.each do |var, value|
        ENV[var] = value.to_s
      end
    end
  end
end
