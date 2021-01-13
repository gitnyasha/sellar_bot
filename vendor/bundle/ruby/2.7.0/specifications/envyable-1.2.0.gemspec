# -*- encoding: utf-8 -*-
# stub: envyable 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "envyable".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Phil Nash".freeze]
  s.date = "2016-11-08"
  s.description = "The simplest yaml to ENV config loader".freeze
  s.email = ["philnash@gmail.com".freeze]
  s.executables = ["envyable".freeze]
  s.files = ["bin/envyable".freeze]
  s.homepage = "https://github.com/philnash/envyable".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "The simplest yaml to ENV config loader".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<thor>.freeze, [">= 0.18.1", "< 2.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<thor>.freeze, [">= 0.18.1", "< 2.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
