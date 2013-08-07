require File.expand_path '../../spec_helper.rb', __FILE__

describe "Builders" do
  describe "CoffeeToJs" do
    it "converts coffee script to javascript and writes it to a file" do
      template_file = "/tmp/fakejs.js.coffee"
      File.write template_file, "alert 'hello world'"

      output_directory = "/tmp"
      expected_output_file = "/tmp/fakejs.js"

      coffee_to_js = Flattt::Builders::CoffeeToJs.new(template_file, output_directory)
      coffee_to_js.build!

      File.exists?(expected_output_file).should == true
      File.read(expected_output_file).should == "(function() {\n  alert('hello world');\n\n}).call(this);\n"

      File.delete(expected_output_file)
      File.delete(template_file)

    end
  end
end
