module Flattt
  module Renderers
    class Erb < OpenStruct
      def render(erb_template_string)
        ERB.new(erb_template_string).result(binding)
      end

      def render_from_file(erb_template_file)
        render File.read(erb_template_file)
      end
    end
  end
end
