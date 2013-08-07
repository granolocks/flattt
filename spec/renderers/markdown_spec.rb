require File.expand_path '../../spec_helper.rb', __FILE__

describe "Renderers" do
  describe "Markdown" do
    it "takes a file containing Markdown Text and generates HTML" do
      markdown_string = "# Header"
      tmp_file = '/tmp/markdown.md'
      File.write tmp_file, markdown_string
      @markdown = Flattt::Renderers::Markdown.new(tmp_file)
      (

        #TODO this test sucks and this rendered HTML sucks worse...
        #  <h1 id="label-Header">Header<span><a href="#label-Header">&para;</a> <a href="#documentation">&uarr;</a></span></h1>
        @markdown.to_html.scan(/<h1/).size>0
      ).should == true
    end
  end
end
