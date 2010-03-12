# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stocktwits}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elad Meidar"]
  s.date = %q{2010-03-12}
  s.description = %q{ StockTwits API wrapper}
  s.email = %q{elad@nautilus6.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/stocktwits.rb",
     "test/helper.rb",
     "test/test_stocktwits.rb"
  ]
  s.homepage = %q{http://github.com/eladmeidar/stocktwits}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "test/helper.rb",
     "test/test_stocktwits.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency("json")
      s.add_dependency("oauth")
      s.add_dependenty("ezcrypto")
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency("json")
      s.add_dependency("oauth")
      s.add_dependenty("ezcrypto")
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency("json")
    s.add_dependency("oauth")
    s.add_dependenty("ezcrypto")
  end
end

