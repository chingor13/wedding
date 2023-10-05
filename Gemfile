source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.1.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.8'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.0.4'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '>= 2.5.4'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'stripe'
gem 'uuid'
gem 'slim'
gem 'simple_form', '>= 4.0.0'
gem 'rqrcode_png'

gem 'aws-sdk', '~> 2.0', '>= 2.0.22'

gem 'omniauth'
gem 'omniauth-facebook'

gem 'carrierwave'
gem 'fog'

gem 'prawn'
gem 'prawn-rails', '>= 1.0.0'

group :production do
  gem 'rails_12factor'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.1', '>= 2.1.3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'dotenv-rails'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'webmock'
  gem 'mocha', require: false
end
