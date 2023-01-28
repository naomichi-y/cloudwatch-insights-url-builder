Gem::Specification.new do |spec|
  spec.name          = 'cloudwatch_logs_insights_url_builder'
  spec.version       = '0.0.7'
  spec.authors       = ['naomichi-y']
  spec.email         = ['n.yamakita@gmail.com']

  spec.summary       = 'Generate AWS Console URL for Amazon CloudWatch Insights.'

  spec.description   = +'Specify log groups and filters to generate CloudWatch Logs Insights URL '
  spec.description  << 'accessible to AWS Console.'

  spec.homepage      = 'https://github.com/naomichi-y/cloudwatch_logs_insights_url_builder'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'

  spec.add_dependency 'url'
end
