# frozen_string_literal: true

require File.expand_path('lib/meeting-scheduler-ext/version', __dir__)

Gem::Specification.new do |spec|
  spec.authors = ["Desmond O'Leary"]
  spec.email = ["desoleary@gmail.com"]
  spec.description = 'Optimized on-site/off-site meeting scheduler'
  spec.summary = 'Optimized on-site/off-site meeting scheduler'
  spec.homepage = "https://github.com/desoleary/meeting-scheduler-ext"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.name = "meeting-scheduler-ext"
  spec.require_paths = ["lib"]
  spec.version = MeetingSchedulerExt::VERSION
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.add_runtime_dependency 'activesupport', '~> 7.0.4.2'
  spec.add_runtime_dependency 'rordash', '~> 0.1.2' # Created myself recently.
  spec.add_runtime_dependency 'light-service-ext', '~> 0.1.4' # Created myself recently.

  spec.add_development_dependency("codecov", "~> 0.6.0")
  spec.add_development_dependency("rake", "~> 13.0.6")
  spec.add_development_dependency("rspec", "~> 3.12.0")
  spec.add_development_dependency("simplecov", "~> 0.21.2")
  spec.add_development_dependency("dry-validation-matchers", "~> 1.2", ">= 1.2.2")

  spec.metadata['rubygems_mfa_required'] = 'true'
end
