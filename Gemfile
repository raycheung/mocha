source 'https://rubygems.org'

ruby '2.1.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.3'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use mongodb for other persistence
gem "mongoid", "~> 4.0.0"

# Use Puma as the app server
gem 'puma'

# So we don't need a long-running worker
gem 'workless'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# We need delayed jobs
gem 'delayed_job_active_record'

# Third-Party integrations
gem 'nexmo'

group :development, :test do
  # Our test framework
  gem 'rspec-rails', '~> 3.3'
  gem 'factory_girl_rails'

  # Better Rails console
  gem 'pry-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec', '~> 2.1.0'
end
