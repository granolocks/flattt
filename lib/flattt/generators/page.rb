module Flattt
  module Generators
    class Page < Base

      # lets ignore the date for pages...
      def directory_name
        sanitize_name(@title)
      end
    end
  end
end
