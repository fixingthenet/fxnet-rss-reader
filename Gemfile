source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rake','13.0.3'

gem 'seed-fu'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'attribute_normalizer'

# graphiti
gem 'graphiti'
gem 'graphiti-rails'
gem 'vandal_ui'
gem 'kaminari', '~> 1.1'
gem 'responders', '~> 3.0'
gem 'bcrypt-ruby'

# security
gem 'openid_connect'
gem 'rack-cors', require: 'rack/cors'
gem 'jwt'

#domain specific
gem 'simple-rss'

group "test","development" do
  gem "byebug"
  gem 'annotate'
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.5' # keep here for seeds.rb
  gem 'graphiti_spec_helpers'
  gem 'listen'
  gem "rspec-rails"
  gem "timecop"
  gem 'guard-rspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
