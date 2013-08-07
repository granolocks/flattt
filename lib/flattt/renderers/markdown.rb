module Flattt
  module Renderers
    # This pattern was inspired by a presentation by _zzak
    class Markdown
      def initialize(markdown_file)
        @text = File.read markdown_file
        @options = RDoc::Options.new
        @parser = RDoc::Markdown.new
      end

      def to_html
        @formatter = RDoc::Markup::ToHtml.new(@options, nil)
        @parser.parse(@text).accept(@formatter)
      end
      alias :render :to_html
    end
  end
end
