require File.expand_path '../../spec_helper.rb', __FILE__

describe "Renderers" do
  describe "Erb" do
    before(:each) do
      @options  = { word: "hello" }
      @template = "<%= word %> world"
      @file     = "/tmp/erb_template.erb"
    end

    it "can process an erb template string" do
      erb = Flattt::Renderers::Erb.new(@options)
      erb.render(@template).should == 'hello world'
    end

    it "can process and erb template file" do
      File.write(@file, @template)

      erb = Flattt::Renderers::Erb.new(@options)
      erb.render_from_file(@file).should == 'hello world'

      File.delete(@file)
    end
  end
end
