# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wukong/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'wukong'
  gem.homepage    = 'https://github.com/infochimps-labs/wukong'
  gem.licenses    = ["Apache 2.0"]
  gem.email       = 'coders@infochimps.org'
  gem.authors     = ['Infochimps', 'Philip (flip) Kromer', 'Travis Dempsey']
  gem.version     = Wukong::VERSION

  gem.summary     = 'Hadoop Streaming for Ruby. Wukong makes Hadoop so easy a chimpanzee can use it, yet handles terabyte-scale computation with ease.'
  gem.description = <<-EOF
  Treat your dataset like a:

      * stream of lines when it's efficient to process by lines
      * stream of field arrays when it's efficient to deal directly with fields
      * stream of lightweight objects when it's efficient to deal with objects

  Wukong is friends with Hadoop the elephant, Pig the query language, and the cat on your command line.
EOF

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = [] # gem.files.grep(/^bin/).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = ['lib']

  gem.add_dependency('configliere',             '~> 0.4')
  gem.add_dependency('multi_json',              '>= 1.3.6')
  gem.add_dependency('vayacondios-client',      '>= 0.0.3')
  gem.add_dependency('gorillib',                '>= 0.4.2')
  gem.add_dependency('forgery')
  gem.add_dependency('uuidtools')

  gem.add_development_dependency('bundler',     '~> 1.1')
  gem.add_development_dependency('rake',        '>= 0.9')
  gem.add_development_dependency('rspec',       '>= 2.8')
  gem.add_development_dependency('guard',       '>= 1.0')
  gem.add_development_dependency('guard-rspec', '>= 0.6')
  gem.add_development_dependency('simplecov',   '>= 0.5')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('redcarpet')
  gem.add_development_dependency('addressable')
  gem.add_development_dependency('htmlentities')

end
