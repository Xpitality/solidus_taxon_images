# frozen_string_literal: true

require_relative 'lib/solidus_taxon_images/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_taxon_images'
  spec.version = SolidusTaxonImages::VERSION
  spec.authors = ['Marko Bošković']
  spec.email = 'bosskovic@gmail.com'

  spec.summary = 'Adds support for (multiple) taxon images (solidus)'
  spec.description = 'Adds support for (multiple) taxon images (solidus)'
  spec.homepage = 'https://github.com/Xpitality/solidus_taxon_images#readme'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Xpitality/solidus_taxon_images'
  spec.metadata['changelog_uri'] = 'https://github.com/Xpitality/solidus_taxon_images/blob/master/CHANGELOG.md'

  spec.required_ruby_version = Gem::Requirement.new('~> 2.5')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'solidus_core', ['>= 2.11.0', '< 3']
  spec.add_dependency 'solidus_support', '~> 0.5'

  spec.add_development_dependency 'solidus_dev_support', '~> 2.4'
end
