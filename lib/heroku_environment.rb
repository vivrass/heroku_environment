require "heroku_environment/version"

require "heroku_environment/config"
require "heroku_environment/exceptions"

require "heroku_environment/development_loader"

module HerokuEnvironment
  def self.config
    @config ||= Config.new
  end
end
