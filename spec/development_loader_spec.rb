require 'spec_helper'

describe HerokuEnvironment::DevelopmentLoader do
  ENVIRONMENT_VARIABLE_NAMES = [":var_1", "var_2"]

  context "Given no configuration file" do
    before do
      HerokuEnvironment.config.stub!(:configuration_file).and_return("an_unknown_file.txt")
    end

    it "should raise an exception" do
      lambda { subject.load_environment }.should raise_error(HerokuEnvironment::MissingFileException)
    end
  end

  context "Given a configuration file" do
    before do
      HerokuEnvironment.config.stub!(:configuration_file).and_return("#{File.dirname(__FILE__)}/fixtures/heroku_environment.yml")
      environment_variable_emtpy?
    end

    after do
      clean_environment_variables
    end

    it "should load the environment variables" do
      subject.load_environment

      ENV["var_1"].should == "first_var"
      ENV["var_2"].should == "2"
    end
  end

  private
  def environment_variable_emtpy?
    ENVIRONMENT_VARIABLE_NAMES.each do |var|
      ENV[var].should be_nil
    end
  end

  def clean_environment_variables
    ENVIRONMENT_VARIABLE_NAMES.each do |var|
      ENV[var] = nil
    end
  end

end
