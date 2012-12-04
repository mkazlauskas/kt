source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem "therubyracer", '0.10.2', :require => 'v8'
gem 'bootstrap-sass', '2.0.4'
gem 'jquery-rails', '2.0.2'
gem 'paperclip', '3.3.1'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'spork', '1.0.0rc3'
  gem 'minitest', '2.0.0'
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'simplecov', :require => false, :group => :test
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'

  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  gem 'pg', '>=0.12.2'
end