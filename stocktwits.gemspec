# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stocktwits}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elad Meidar"]
  s.date = %q{2010-03-20}
  s.description = %q{ Provide an OAuth, Basic HTTP authentication and plain interfaces to the StockTwits API.}
  s.email = %q{elad@eizesus.com}
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
     "app/controllers/sessions_controller.rb",
     "app/models/stocktwits/basic_user.rb",
     "app/models/stocktwits/generic_user.rb",
     "app/models/stocktwits/oauth_user.rb",
     "app/models/stocktwits/plain_user.rb",
     "app/views/sessions/_login.html.erb",
     "app/views/sessions/new.html.erb",
     "config/routes.rb",
     "generators/stocktwits/USAGE",
     "generators/stocktwits/stocktwits_generator.rb",
     "generators/stocktwits/templates/migration.rb",
     "generators/stocktwits/templates/stocktwits.yml",
     "generators/stocktwits/templates/user.rb",
     "lib/stocktwits.rb",
     "lib/stocktwits/controller_extensions.rb",
     "lib/stocktwits/cryptify.rb",
     "lib/stocktwits/dispatcher/basic.rb",
     "lib/stocktwits/dispatcher/oauth.rb",
     "lib/stocktwits/dispatcher/plain.rb",
     "lib/stocktwits/dispatcher/shared.rb",
     "rails/init.rb",
     "spec/application.rb",
     "spec/controllers/controller_extensions_spec.rb",
     "spec/controllers/sessions_controller_spec.rb",
     "spec/debug.log",
     "spec/fixtures/config/twitter_auth.yml",
     "spec/fixtures/factories.rb",
     "spec/fixtures/fakeweb.rb",
     "spec/fixtures/stocktwits.rb",
     "spec/models/stocktwits/basic_user_spec.rb",
     "spec/models/stocktwits/generic_user_spec.rb",
     "spec/models/stocktwits/oauth_user_spec.rb",
     "spec/schema.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/stocktwits/cryptify_spec.rb",
     "spec/stocktwits/dispatcher/basic_spec.rb",
     "spec/stocktwits/dispatcher/oauth_spec.rb",
     "spec/stocktwits/dispatcher/shared_spec.rb",
     "spec/stocktwits_spec.rb",
     "stocktwits.gemspec"
  ]
  s.homepage = %q{http://github.com/eladmeidar/stocktwits}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Stocktwits.com API wrapper}
  s.test_files = [
    "spec/application.rb",
     "spec/controllers/controller_extensions_spec.rb",
     "spec/controllers/sessions_controller_spec.rb",
     "spec/fixtures/factories.rb",
     "spec/fixtures/fakeweb.rb",
     "spec/fixtures/stocktwits.rb",
     "spec/models/stocktwits/basic_user_spec.rb",
     "spec/models/stocktwits/generic_user_spec.rb",
     "spec/models/stocktwits/oauth_user_spec.rb",
     "spec/schema.rb",
     "spec/spec_helper.rb",
     "spec/stocktwits/cryptify_spec.rb",
     "spec/stocktwits/dispatcher/basic_spec.rb",
     "spec/stocktwits/dispatcher/oauth_spec.rb",
     "spec/stocktwits/dispatcher/shared_spec.rb",
     "spec/stocktwits_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<ezcrypto>, [">= 0"])
      s.add_runtime_dependency(%q<oauth>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<ezcrypto>, [">= 0"])
      s.add_dependency(%q<oauth>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<ezcrypto>, [">= 0"])
    s.add_dependency(%q<oauth>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end

