source "http://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 3.7.0'
  gem "puppet-lint"
  gem "rspec-puppet" 
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
  gem 'librarian-puppet'
end

group :development do
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem "travis"
  gem "travis-lint"
  gem 'beaker'
  gem "beaker-rspec", '5.0.2'
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end
