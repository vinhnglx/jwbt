source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.6'
gem 'rails-api'

##### Database #####
gem 'sqlite3'

##### Environment Variable Management #####
gem 'figaro'

##### API Version Management #####
gem 'versionist'

##### JSON Generation #####
gem 'active_model_serializers'

##### Coding Style #####
gem 'brakeman'
gem 'bullet'
gem 'rails_best_practices'
gem 'rubocop'

##### Automated Code Review #####
gem 'saddler'
gem 'saddler-reporter-github'

##### Secure Password #####
gem 'bcrypt'

group :development, :test do
  ##### Debugging #####
  gem 'awesome_print'
  gem 'byebug'
  gem 'annotate'

  ##### Testing #####
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'spring'
  gem 'ffaker'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'webmock'
  gem 'simplecov', require: false
end
