HELP_TEXT =<<HELP
Usage:

flattt new [project_name]
  -- Build a new flatt project in a directory which matches your project name

flattt generate [page|post|coffee|style]
  -- Generate CMS Sources files for a page, post, coffeescript or scss stylesheet

flattt build [site|html|pages|posts|assets|stylesheets|js]
 -- Convert CMS Source files to flat files which can be served from any static web server.
    site: Build entire site structure
    html: Build all HTML - pages & posts
    pages: Build HTML for pages only
    posts: Build HTML for posts only
    assets: Build all assets - CSS & Js
    stylesheets: Build CSS
    js: Build Js

flattt [-h|--help]
 -- Print this message
HELP

DEFAULT_GEMFILE =<<EOG
source 'https://rubygems.org'

gem 'flattt', github: 'granolocks/flattt', branch: 'master'"
EOG

DEFAULT_SITE_LAYOUT =<<LAYOUT
<!doctype html>
<html>
  <head>
    <title><%= title %></title>
  </head>
  <body>
    <h1><%= title %></h1>
    <%= content %>
  </body>
</html>
LAYOUT

