require File.expand_path '../../spec_helper.rb', __FILE__

describe "Generators" do
  describe "Page" do

    let(:title){ "My Page" }
    let(:source_directory) {"/tmp/"}
    let(:page){Flattt::Generators::Page.new(title, source_directory)}
    let(:date){Time.now.to_s.split(' ')[0]}

    it "behaves just like Base except directory_name does not include the date." do
      page.directory_name.should_not == "#{date}_my_page"
      page.directory_name.should     == "my_page"
    end

  end
end
