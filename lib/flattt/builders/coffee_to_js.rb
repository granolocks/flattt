module Flattt
  module Builders
    class CoffeeToJs < Base
      def render_template
        CoffeeScript.compile File.read(@template_file)
      end
    end
  end
end
