require File.expand_path '../../spec_helper.rb', __FILE__

describe "Generators" do
  describe "Base" do

    let(:title){ "My Page" }
    let(:source_directory) {"/tmp/"}
    let(:test_base){Flattt::Generators::Base.new(title, source_directory)}
    let(:date){Time.now.to_s.split(' ')[0]}
    let(:meta_data_template){"#{Flattt::Generators::GENERATOR_TEMPLATE_DIR}/meta.yml.erb"}
    let(:content_template){"#{Flattt::Generators::GENERATOR_TEMPLATE_DIR}/content.md.erb"}

    it "converts a dirty string from the input title to someting saner for web URLs" do
      sadness = "N!!!;;;;;!!!iC*&%$*&#%)&#%e& &&AND}}{}{}{ Clean"
      test_base.sanitize_name(sadness).should == "nice_and_clean"
    end

    it "produces a date string" do
      test_base.date_string.should == date
    end

    it "generates a new directory name" do
      test_base.directory_name.should ==  "#{date}_my_page"
    end

    it "generates a new directory path" do
      test_base.directory_path.should == "/tmp/#{date}_my_page"
    end

    it "writes to a meta.yml file" do
      test_base.meta_data_file.should == "/tmp/#{date}_my_page/meta.yml"
    end

    it "writes to a content.md file" do
      test_base.content_file.should == "/tmp/#{date}_my_page/content.md"
    end

    it "has a meta.yml template" do
      test_base.meta_data_template.should == meta_data_template
    end

    it "has a content.md template" do
      test_base.content_template.should == content_template
    end

    it "has default erb options to pass to its templates" do
      default_options = { title: title, date: date }
      test_base.erb_options.should ==  default_options
    end

    it "can create a directory" do
      test_base.create_directory
      dir = "/tmp/#{date}_my_page"
      Dir.exists?(dir).should == true

      # cleanup
      Dir.rmdir dir
    end

    it "can create a file from a template" do
      dir = "/tmp/#{date}_my_page"
      file = File.join(dir, "content.md")

      # pre-cleanup
      File.delete(file) if File.exists? file
      Dir.rmdir(dir) if Dir.exists? dir

      # double check
      Dir.exists?(dir).should   == false
      File.exists?(file).should == false

      # create the file
      test_base.create_file_from_template test_base.content_file, test_base.content_template

      # check file status
      Dir.exists?(dir).should   == true
      File.exists?(file).should == true

      # cleanup
      File.delete(file) if File.exists? file
      Dir.rmdir(dir) if Dir.exists? dir
    end

    it "can generate a directory, content and meta data files" do
      dir            = "/tmp/#{date}_my_page"
      content_file   = File.join(dir, "content.md")
      meta_data_file = File.join(dir, "meta.yml")

      # pre-cleanup
      File.delete(content_file) if File.exists? content_file
      File.delete(meta_data_file) if File.exists? meta_data_file
      Dir.rmdir(dir) if Dir.exists? dir

      # double check
      Dir.exists?(dir).should             == false
      File.exists?(content_file).should   == false
      File.exists?(meta_data_file).should == false

      # generate that shizz
      test_base.generate!

      # check file status
      Dir.exists?(dir).should             == true
      File.exists?(content_file).should   == true
      File.exists?(meta_data_file).should == true

      # cleanup
      File.delete(content_file) if File.exists? content_file
      File.delete(meta_data_file) if File.exists? meta_data_file
      Dir.rmdir(dir) if Dir.exists? dir
    end
  end
end
