module Flattt
  module Builders
    class Base
      def initialize(template_file, output_directory)
        @template_file = template_file
        @output_directory = output_directory
      end

      def build!
        File.write(output_file_path, render_template)
      end

      def output_file_path
        File.join @output_directory, output_file_name
      end

      def output_file_name
        @template_file       # => /path/to/file.txt.erb
          .split('/')[-1]    # => file.txt.erb
          .split('.')[0..-2] # => ["file","txt"]
          .join('.')         # => file.txt
      end

      def render_template
        raise StandardError, "No Rendering from Flattt::Builders:Base!\nCreate an inherited class and overwrite this method."
      end
    end
  end
end
