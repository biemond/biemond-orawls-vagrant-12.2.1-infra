#!/bin/bash

source ~/.profile
source ~/.rvm/scripts/rvm

rvm --version

rvm install ruby-2.0.0
rvm use ruby-2.0.0

set -e

ruby -v
echo "gem version"
gem --version
gem install bundler --no-rdoc --no-ri
bundle install --without development
bundle --version
gem update --system 2.1.11

bundle exec rake syntax
bundle exec rake lint

# Release the Puppet module, doing a clean, build, tag, push, bump_commit
rake module:clean
rake build

rake module:push
rake module:tag
rake module:bump_commit  # Bump version and git commit

