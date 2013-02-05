begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
  task default: :spec
rescue LoadError
  warn "RSpec unavailable; run `bundle'."
end
