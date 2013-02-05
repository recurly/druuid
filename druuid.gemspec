Gem::Specification.new do |s|
  s.name = 'druuid'
  s.version = '1.0.0'
  s.summary = 'Date-relative UUID generation'
  s.description = 'Druuid generates 64-bit, time-sortable UUIDs.'

  s.require_path = '.'
  s.files = 'druuid.rb'
  s.test_file = 'spec/druuid_spec.rb'

  s.author = 'Stephen Celis'
  s.email = 'stephen@recurly.com'
  s.homepage = 'https://github.com/recurly/druuid'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.required_ruby_version = '>= 1.9'

  s.license = 'MIT'
end
