require File.join(File.expand_path('..',__FILE__),'templates.rb')

module Flattt
  module Bin
    module Helpers


      def filepaths_in_dir(dir,file_extension)
        Dir.new(dir).entries
        .select!{|e| e.scan(/\.#{file_extension}$/).size > 0}
          .map{|file| File.join(dir, file)}
      end

      def required_paths
        REQUIRED_DIRS.map{|dir|File.join(CURRENT_DIRECTORY,dir)}
      end

      def verify_or_create_required_dirs(flattt_root=required_paths)
        REQUIRED_DIRS.each do |dir|
          path = File.join(flattt_root,dir)
          verify_or_create_dir(path)
        end
      end

      def verify_or_create_dir(dir_path)
        puts "[+] creating #{dir_path}"
        Dir.mkdir dir_path
      end

      def build_new_project name
        project_dir = File.join(CURRENT_DIRECTORY, name)
        puts "[+] Creating new flattt project in #{project_dir}"

        if Dir.exists? project_dir
          puts "[-] Looks like a directory already exists in #{ project_dir} "
          puts "[-] Please choose a different name."
          exit
        end

        Dir.mkdir project_dir
        puts "[+] Creating additional directories:"
        verify_or_create_required_dirs(project_dir)

        puts "[+] Creating Gemfile"
        target_gemfile  =  File.join(project_dir, "Gemfile")
        File.write(target_gemfile, DEFAULT_GEMFILE)

        puts "[+] Creating Layout"
        layout_file  =  File.join(project_dir, "layouts/site_layout.html.erb")
        File.write(layout_file, DEFAULT_SITE_LAYOUT)
      end

      def verify_flattt_root
        unless this_is_flattt_root?
          puts "[-] Please run this command from the root of a flattt project"
          exit
        end
      end

      def this_is_flattt_root?
        !(required_paths.map{|path| Dir.exists?(path) }.include?(false))
      end

      def string_to_file_path(str)
        str.downcase
        .split(' ')
        .join('_')
        .gsub(/[^a-z0-9_\-]/,'')[0..63]
      end

      def build_stylesheets
        stylesheets = filepaths_in_dir(PATHS[:source][:styles], "scss")
        stylesheets.each do |src_path|
          builder = ScssToCss.new( src_path, PATHS[:site][:styles])
          puts "[+] Building stylesheet from #{src_path }"
          puts "\t -> #{builder.output_file_path}"
          builder.build!
        end
      end

      def build_js
        scripts = filepaths_in_dir(PATHS[:source][:scripts], "coffee")
        scripts.each do |src_path|
          builder = CoffeeToJs.new( src_path, PATHS[:site][:js])
          puts "[+] Building Javascript from #{src_path }"
          puts "\t -> #{builder.output_file_path}"
          builder.build!
        end
      end

      def sub_entries_of(path)
        Dir.new(path)
        .entries
        .select!{|e|(e!='.')&&(e!='..')}
      end

      # this will probably want to change
      def site_layout
        File.join PATHS[:layouts], "site_layout.html.erb"
      end

      def load_yaml_from(directory, yaml_file='meta.yml')
        YAML.load(File.open(File.join(directory, yaml_file)))
      end

      def generate_html_from(path, markdown_file='content.md')
        Markdown.new(File.join(path, markdown_file)).to_html
      end

      def build_html_from_erb(layout,options)
        erb = Erb.new(options)
        erb.render_from_file(layout)
      end

      def output_html_from(source_path,directory,layout=site_layout)
        full_path = File.join(source_path, directory)
        erb_options = load_yaml_from(full_path)
        erb_options[:content] = generate_html_from(full_path)
        build_html_from_erb(layout,erb_options)
      end

      def build_pages
        puts "[+] Building all pages."

        # get a list of all pages in the pages source directory of the project
        sub_entries_of(PATHS[:source][:pages]).each do |directory|
          html = output_html_from(PATHS[:source][:pages], directory)
          target_dir = File.join(PATHS[:site][:pages], directory)
          unless Dir.exists? target_dir
            Dir.mkdir target_dir
          end
          target_file = directory == 'index' ? File.join(PATHS[:site][:pages], 'index.html') : File.join(target_dir, 'index.html')
          File.write(target_file, html)
        end
      end

      def build_posts
        puts "[+] Building all posts."
        # get a list of all posts in the posts source directory of the project
        sub_entries_of(PATHS[:source][:posts]).each do |directory|
          html = output_html_from(PATHS[:source][:posts], directory)
          target_dir = File.join(PATHS[:site][:posts], directory)
          unless Dir.exists? target_dir
            Dir.mkdir target_dir
          end
          target_file = File.join(target_dir, 'index.html')
          File.write(target_file, html)
        end
      end

      def build_assets
        puts "[+] Building all assets."
        build_stylesheets
        build_js
      end

      def build_html
        puts "[+] Building all HTML."
        build_pages
        build_posts
      end

      def build_site
        puts "[+] Building entire site."
        build_assets
        build_html
      end
    end
  end
end
