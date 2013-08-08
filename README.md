# flattt

Simple static site generator using Markdown, SCSS, ERB and Coffee Script.

I have taken some cues from projects like [jekyll](http://jekyllrb.com/) and [stasis](http://stasis.me/). I appreciate not reinventing the wheel but I have wanted to roll my own like this for a while.

I am keeping it simple by limiting the formats of the supported templates initially around what I want to use for my own site.

## Commands
Once this is installed as a gem you have a few options you can run with the flattt command:

```sh
flattt new [project_name]
```
Build a new flatt project in a directory which matches your project name

```sh
flattt generate [page|post|coffee|style]
```
Generate CMS Sources files for a page, post, coffeescript or scss stylesheet

```sh
flattt build [site|html|pages|posts|assets|stylesheets|js]
```
Convert CMS Source files to flat files which can be served from any static web server.
* site: Build entire site structure 
* html: Build all HTML - pages & posts
* pages: Build HTML for pages only
* posts: Build HTML for posts only
* assets: Build all assets - CSS & Js
* stylesheets: Build CSS
* js: Build Js

```sh
flatt [-h|--help]
 -- Print help message
 ```

## Code Guide

```sh

# contents of lib directory
# generated with :r!tree lib/

lib/
├── flattt
│   ├── builders
│   │   ├── base.rb
│   │   ├── coffee_to_js.rb
│   │   ├── init.rb
│   │   └── scss_to_css.rb
│   ├── generators
│   │   ├── base.rb
│   │   ├── init.rb
│   │   ├── page.rb
│   │   ├── post.rb
│   │   └── templates
│   │       ├── content.md.erb
│   │       └── meta.yml.erb
│   └── renderers
│       ├── erb.rb
│       ├── init.rb
│       └── markdown.rb
└── flattt.rb

5 directories, 14 files
```

### Builders
These take in a source file like Scss or Coffee and write and output the finished code to a specified directory. These are used primarily in the final steps of converting CMS files into the static site.

### Generators
These are helpers to generate the structure and template of a Flattt project which the editor will use to actually make changes to content. 

### Renderers
Renderers convert a template such as ERB or Markdown and output _strings_, not write files as in the case of Builders or Generators which actually write out files
