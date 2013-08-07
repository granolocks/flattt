require File.expand_path '../../spec_helper.rb', __FILE__

describe "Builders" do
  describe "ScssToCss" do
    it "can render scss into css" do
      template_file = "/tmp/fakecss.css.scss"
      File.write template_file, "p{color:black;em{color:blue;}}"
      output_directory = "/tmp"
      expected_output_file = "/tmp/fakecss.css"

      scss_to_css = Flattt::Builders::ScssToCss.new(template_file, output_directory)
      scss_to_css.build!

      File.exists?(expected_output_file).should == true
      File.read(expected_output_file).should == "p {\n  color: black; }\n  p em {\n    color: blue; }\n"

      File.delete(expected_output_file)
      File.delete(template_file)
    end
  end
end
