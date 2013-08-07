# flattt

Simple static site generator using Markdown, SCSS, ERB and Coffee Script.

I have taken some cues from projects like [jekyll](http://jekyllrb.com/) and [stasis](http://stasis.me/). I appreciate not reinventing the wheel but I have wanted to roll my own like this for a while.

I am keeping it simple by limiting the formats of the supported templates initially around what I want to use for my own site.

## Code Guide

```sh

# contents of lib directory
# generated with :r!tree lib/

lib
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

```

### Builders
These take in a source file like Scss or Coffee and write and output the finished code to a specified directory. These are used primarily in the final steps of converting CMS files into the static site.

### Generators
These are helpers to generate the structure and template of a Flattt project which the editor will use to actually make changes to content. 

### Renderers
Renderers convert a template such as ERB or Markdown and output _strings_, not write files as in the case of Builders or Generators which actually write out files
