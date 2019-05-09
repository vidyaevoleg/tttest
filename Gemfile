source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

# TRB
gem 'dry-validation'
gem 'trailblazer', '~> 2.0.4'
gem 'trailblazer-rails', '~> 1.0.3'
gem 'reform'
gem 'reform-rails'

# devise
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'

gem 'active_interaction', '~> 3.6' # lite version of TRB operation

group :development, :test do
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot'
  gem 'database_cleaner', '>=1.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
