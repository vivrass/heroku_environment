require 'spec_helper'

describe HerokuEnvironment::DevelopmentLoader do
  context "Given no configuration file" do
    before(:each) do
      HerokuEnvironment.config.stub!(:configuration_file).and_return("an_unknown_file.txt")
    end

    it "should raise an exception" do
      lambda { subject.load_environment }.should raise_error(HerokuEnvironment::MissingFileException)
    end
  end
end
