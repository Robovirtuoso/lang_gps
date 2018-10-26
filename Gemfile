source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'rails', '~> 5.2.1'

# Database
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

# Assets
# CSS
gem 'sass-rails', '~> 5.0'
gem 'bootstrap', '~> 4.1.3'

# JS
gem 'coffee-rails'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.5'
gem 'jquery-rails'
gem 'lodash-rails'
gem 'sprockets-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Authentication
gem 'devise'

group :development, :test do
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'awesome_print'

  # JS Test Runner
  gem 'teaspoon-mocha'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem "selenium-webdriver"
  gem 'capybara'

  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
