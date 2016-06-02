source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Application settings
gem 'settingslogic', '~> 2.0.9'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# ActiveAdmin for cms interface
gem 'activeadmin', github: 'activeadmin'
# ActiveAdmin Flat Skin
gem 'active_admin_flat_skin'
# Font Awesome
gem 'font-awesome-rails'
# Acts as List
gem 'acts_as_list'
# gem 'active_admin-acts_as_list'
gem 'active_admin-sortable_tree'
# Devise for User Credential Managment
gem 'devise'
# CanCanCan
gem 'cancancan', '~> 1.10'
# Paperclip file uploader
gem 'paperclip'
# Use pry for console & debug
# pry debug supoport
gem 'pry-rails', '~> 0.3.4'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # bye shit
  gem 'pry-byebug'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Rspec
  gem 'rspec-rails', '~> 3.0'

  # Model Unit Validations
  gem 'shoulda-matchers', '~> 3.1'

  # Instance Factories
  gem 'factory_girl_rails', '~> 4.7.0'

  # clean db for every example
  gem 'database_cleaner', '~> 1.5.1'

  # capybara for integration tests
  gem 'capybara', '~> 2.7.0'
  # baaaaaaaaaaal gem 'capybara-webkit'

  # enable mocks within context examples
  gem 'webmock', '~> 1.24.3'

  # enable request mocks via cassets
  gem 'vcr'
end
