module HerokuEnvironment
  module DevelopmentLoader
    def self.load_environment
      raise MissingFileException.new("Missing file for development: #{HerokuEnvironment.config.configuration_file}") unless File.exists?(HerokuEnvironment.config.configuration_file)
    end
  end
end
