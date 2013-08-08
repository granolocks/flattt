module Flattt
  module Generators
    GENERATOR_TEMPLATE_DIR = File.expand_path "../templates", __FILE__

    class Base
      def initialize(title, source_directory)
        @source_directory = source_directory
        @title = title
        @erb = Flattt::Renderers::Erb.new(erb_options)
      end

      def generate!
        create_directory
        create_meta_file
        create_content_file
      end

      def create_directory
        unless Dir.exists? directory_path
          Dir.mkdir(directory_path)
        end
      end

      def create_meta_file
        create_file_from_template(meta_data_file, meta_data_template)
      end

      def create_content_file
        create_file_from_template(content_file, content_template)
      end

      def create_file_from_template(file, template)
        unless Dir.exists? directory_path
          create_directory
        end

        unless File.exists? file
          File.write(file, @erb.render_from_file(template))
        end
      end

      def erb_options
        {
          title: @title,
          date: date_string
        }
      end

      def content_template
        File.join GENERATOR_TEMPLATE_DIR, "content.md.erb"
      end

      def meta_data_template
        File.join GENERATOR_TEMPLATE_DIR, "meta.yml.erb"
      end

      def content_file
        File.join directory_path, "content.md"
      end

      def meta_data_file
        File.join directory_path, "meta.yml"
      end

      def directory_path
       File.join @source_directory, directory_name
      end

      def directory_name
       "#{date_string}_#{sanitize_name(@title)}"
      end

      def date_string
        date = Time.now.to_s.split(' ')[0]
      end

      def sanitize_name(name)
       name.downcase
           .split(' ')
           .join('_')
           .gsub(/[^a-z0-9_\-]/,'')[0..63]
      end
    end
  end
end
