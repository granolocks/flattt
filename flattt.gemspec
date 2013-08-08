require 'rake'
Gem::Specification.new do |s|
  s.name        = 'flattt'
  s.version     = '0.0.0'
  s.date        = '2013-08-07'
  s.summary     = "Flattt "
  s.description = "A simple static site generator"
  s.authors     = ["Gabe Koss"]
  s.email       = "gabe@gabekoss.com"
  s.files       = FileList[ 'lib/**/*', '[A-Z]*', 'spec/**/*' ].to_a
  s.homepage    = 'https://github.com/granolocks/flattt/'
  s.license     = 'MIT'

  # Note you will need a Javascript Runtime
  # so I am adding here for now, probably a good 
  # TODO to remove this 
  s.add_dependency('therubyracer')
  s.add_dependency('coffee-script')
  s.add_dependency('sass')

  s.add_development_dependency('rspec')
end