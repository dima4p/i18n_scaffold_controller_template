# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: i18n_scaffold_controller_template 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "i18n_scaffold_controller_template".freeze
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dmitri Koulikoff".freeze]
  s.date = "2020-01-05"
  s.description = "Scaffold controller template expoiting i18n and aware of cancan and WiceGrid".freeze
  s.email = "dima@koulikoff.ru".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "i18n_scaffold_controller_template.gemspec",
    "lib/i18n_scaffold_controller_template.rb",
    "lib/i18n_scaffold_controller_template/generators/rails/scaffold_controller_generator.rb",
    "lib/i18n_scaffold_controller_template/generators/rails/templates/api_controller.rb",
    "lib/i18n_scaffold_controller_template/generators/rails/templates/controller.rb",
    "lib/i18n_scaffold_controller_template/railtie.rb",
    "spec/i18n_scaffold_controller_template_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/dima4p/i18n_scaffold_controller_template".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Scaffold controller template expoiting i18n and aware of cancan and WiceGrid".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 4.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 4.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 4.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.0"])
  end
end

