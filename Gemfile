
source 'https://rubygems.org'
ruby '2.5.3'
gem 'sinatra', require: 'sinatra/base'
gem 'pg'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'json'
gem 'fast_jsonapi'
gem 'sinatra-contrib'

group :development, :test do
  gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
  gem 'shotgun'
  gem 'rspec'
  gem 'rspec-core'
  gem 'tux'
  gem 'capybara'
  gem 'launchy'
  gem 'rack-test'
  gem 'rake'
  gem 'faraday'
  gem 'pry'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov'
end
