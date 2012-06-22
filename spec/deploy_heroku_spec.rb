require 'spec_helper'

describe HerokuEnvironment::DeployHeroku do
  let :dev_var do
    {
      "var_1" => "first_variable",
      "var_2" => 2,
    }
  end

  let :prod_var do
    {
      "var_1" => "first_prod_variable",
      "var_2" => "prod_2",
    }
  end

  context "#verify_config_files" do
    before do
      HerokuEnvironment.config.should_receive(:read_configuration).with(HerokuEnvironment.config.configuration_file).and_return(dev_var)
      HerokuEnvironment.config.should_receive(:read_configuration).with(HerokuEnvironment.config.production_configuration_file).and_return(prod_var)
    end

    context "Given dev and prod with same variables" do

      it "should not raise exception" do
        lambda { subject.verify_config_files }.should_not raise_error
      end
    end

    context "Given a missing production variable" do
      before do
        prod_var.delete("var_1")
      end

      it "should raise exception with missing variable name" do
        lambda { subject.verify_config_files }.should raise_error(HerokuEnvironment::MissingEnvironmentVariableException, /Production.*var_1/)
      end
    end

    context "Given a missing development variable" do
      before do
        dev_var.delete("var_2")
      end

      it "should raise exception with missing variable name" do
        lambda { subject.verify_config_files }.should raise_error(HerokuEnvironment::MissingEnvironmentVariableException, /Development.*var_2/)
      end
    end

    context "Given a missing development and production variable" do
      before do
        prod_var.delete("var_1")
        dev_var.delete("var_2")
      end

      it "should raise exception with missing variable name" do
        lambda { subject.verify_config_files }.should raise_error(HerokuEnvironment::MissingEnvironmentVariableException, /Development.*var_2.*Production.*var_1/m)
      end
    end
  end

  context "#load_environment" do
    context "Given prod variables" do
      before do
        HerokuEnvironment.config.should_receive(:read_configuration).with(HerokuEnvironment.config.production_configuration_file).and_return(prod_var)
      end

      it "should execute heroku script" do
        subject.should_receive(:'`').with("heroku config:add var_1=first_prod_variable var_2=prod_2")

        begin
          stdout, $stdout = $stdout, StringIO.new # Silence put
          subject.load_environment
        ensure
          $stdout = stdout
        end
      end
    end
  end
end
