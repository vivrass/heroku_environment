module HerokuEnvironment
  module DeployHeroku
    def self.verify_config_files
      dev_environment_variables  = HerokuEnvironment.config.read_configuration(HerokuEnvironment.config.configuration_file)
      return if dev_environment_variables.nil? # Development file doesn't exist, so production config file is valid
      prod_environment_variables = HerokuEnvironment.config.read_configuration(HerokuEnvironment.config.production_configuration_file)

      missing_dev_variables = []
      missing_prod_variables = dev_environment_variables.keys
      prod_environment_variables.keys.each do |var|
        missing_dev_variables << var if missing_prod_variables.delete(var).nil?
      end

      if missing_dev_variables.any? || missing_prod_variables.any?
        error_message = "Missing environmment variable for: "
        error_message += "\nDevelopment: #{missing_dev_variables.join(", ")}"  if missing_dev_variables.any?
        error_message += "\nProduction:  #{missing_prod_variables.join(", ")}" if missing_prod_variables.any?

        raise MissingEnvironmentVariableException.new(error_message)
      end
    end

    def self.load_environment
      prod_environment_variables = HerokuEnvironment.config.read_configuration(HerokuEnvironment.config.production_configuration_file)

      puts "Updating keys: #{prod_environment_variables.keys.join(", ")}"
      `heroku config:add #{prod_environment_variables.map{|var, value| "#{var}=#{value}"}.join(" ")}`
    end
  end
end
