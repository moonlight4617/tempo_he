# -*- encoding: utf-8 -*-
# stub: public_uid 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "public_uid".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tomas Valent".freeze]
  s.date = "2020-06-10"
  s.description = "Automatic generates public unique identifier for model".freeze
  s.email = ["equivalent@eq8.eu".freeze]
  s.homepage = "https://github.com/equivalent/public_uid".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.9".freeze
  s.summary = "Automatic generates public UID column".freeze

  s.installed_by_version = "3.2.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, ["> 4.2"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5"])
    s.add_development_dependency(%q<rr>.freeze, ["~> 1.1.2"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4.1"])
    s.add_development_dependency(%q<activesupport>.freeze, ["> 4.2"])
  else
    s.add_dependency(%q<activerecord>.freeze, ["> 4.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5"])
    s.add_dependency(%q<rr>.freeze, ["~> 1.1.2"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.1"])
    s.add_dependency(%q<activesupport>.freeze, ["> 4.2"])
  end
end
