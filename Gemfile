source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'unicorn'
gem 'pg'
# gem 'backbone-on-rails', '1.0.0.0'
gem 'twitter-bootstrap-rails', '~> 2.1.0'

# client side helper gems
gem 'rabl'
gem 'oj'
gem 'gon'
gem 'js-routes'
gem 'active_model_serializers', '~> 0.8.1'
gem 'foreman'


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'compass-rails'
gem 'handlebars_assets'
gem 'eco'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'libv8', '~> 3.11.8'
gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :test, :development do
  gem 'rspec-rails', '2.12.0'
  gem 'pry-rails'
  gem 'factory_girl_rails', '4.1.0'
  gem 'timecop'
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '1.4.2'
  gem 'capybara', '2.0.1'
end

group :doc do
  gem 'sdoc', require: false
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
