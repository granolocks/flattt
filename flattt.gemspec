require 'rake'
Gem::Specification.new do |s|
  s.name        = 'flattt'
  s.version     = '0.0.1'
  s.date        = '2013-08-09'
  s.summary     = "Flattt "
  s.description = "A simple static site generator"
  s.authors     = ["Gabe Koss"]
  s.email       = "gabe@gabekoss.com"
  s.files       = FileList[ 'bin/**/*', 'lib/**/*', '[A-Z]*', 'spec/**/*' ].to_a
  s.homepage    = 'https://github.com/granolocks/flattt/'
  s.license     = 'MIT'

  # include flattt bin file with handy commands
  s.executables << 'flattt'

  # Note you will need a Javascript Runtime
  # so I am adding here for now, probably a good 
  # TODO to remove this 
  s.add_dependency('therubyracer')
  s.add_dependency('coffee-script')
  s.add_dependency('sass')
  s.add_dependency('slop')

  s.add_development_dependency('rspec')
end
