#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1
# bundle exec rake db:migrate
bundle exec rake db:seed
