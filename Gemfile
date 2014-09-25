source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.6'

gem 'active_model_serializers', '~> 0.8.0'
gem 'dotenv'
gem 'kaminari'
gem 'pg'
gem 'raddocs'
gem 'thin'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'foreman'
  gem 'pry-rails'
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
end

group :test do
  gem 'json_spec'
end
