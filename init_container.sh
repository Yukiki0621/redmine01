#!/usr/bin/env bash
service ssh start

/docker-entrypoint.sh rake
RAILS_ENV=production bundle exec rake db:migrate
rails server -b 0.0.0.0
