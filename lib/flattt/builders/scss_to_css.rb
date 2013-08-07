module Flattt
  module Builders
    class ScssToCss < Base
      def render_template
        @sass = Sass::Engine.for_file(@template_file,{})
        return @sass.render
      end
    end
  end
end
