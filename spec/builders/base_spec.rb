require File.expand_path '../../spec_helper.rb', __FILE__

describe "Builders" do
  describe "Base" do

    let(:base_instance) {
      Flattt::Builders::Base.new("fake_file.html.md", "/fake/path")
    }

    it "can extract the output file name " do
      base_instance.output_file_name.should == "fake_file.html"
    end

    it "can provide the output file path " do
      base_instance.output_file_path.should == "/fake/path/fake_file.html"
    end

    it "does not allow build! or render_template to be called" do
      %i{ build! render_template}.each do |illegal_method|
        begin
          base_instance.send(illegal_method)
        rescue StandardError => error
          error.message.should == "No Rendering from Flattt::Builders:Base!\nCreate an inherited class and overwrite this method."
        end
      end
    end
  end
end
