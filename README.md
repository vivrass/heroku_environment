# HerokuEnvironment

This gem let you easily configure and manage your environment variables for Heroku

## Installation

Add this line to your application's Gemfile:

    gem 'heroku_environment', :git => "git://github.com/vivrass/heroku_environment.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku_environment

## Usage

Create config/production_heroku_environment.yml and add as a YAML hash your environment variables.

    FACEBOOK_APP_ID: 1234567
    FACEBOOK_SECRET: this_is_really_secret

Add config/production_heroku_environment.yml to your .gitignore file (you don't want to commit it)

    echo "config/production_heroku_environment.yml" >> .gitignore

Push your environment variables to Heroku

    bundle exec heroku_environment:update

The gem will automatically load your production environment variables during development. If you have different development variables, you can create a file name `config/heroku_environment.yml` with the same variables as config/production_heroku_environment.yml and this new file will be loaded during development.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
