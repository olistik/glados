source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '1.1.0.rc1'
gem 'hanami-model', '1.1.0.rc1'

gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
