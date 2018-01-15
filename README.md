**Welcome to Sales Assistant!**

# Sales Assistant

[![Build Status](https://travis-ci.org/Ruby-IF081/heroes_team_app.svg?branch=master)](https://travis-ci.org/Ruby-IF081/heroes_team_app)
[![Maintainability](https://api.codeclimate.com/v1/badges/c181493da3b58a3dfb39/maintainability)](https://codeclimate.com/github/Ruby-IF081/heroes_team_app/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c181493da3b58a3dfb39/test_coverage)](https://codeclimate.com/github/Ruby-IF081/heroes_team_app/test_coverage)

## To run application you need:
* Ruby `v.2.4.1`
* Redis server
* PostgreSQL

## Installation

* Run `bundle`
* Run `rails db:migrate`
* Run `rails db:seed`
* Start `redis-server`
* In project folder run `bundle exec sidekiq`
* Run `rails s`
* Simply run `gem install mailcatcher` then `mailcatcher` to get started

## Install Chrome plugin

To load plugin in Chrome, open up chrome://extensions/ in your browser and click “Developer mode” in the top right. Now click “Load unpacked extension…” and select the extension’s directory (heroes_team_app/chrome_extension). You should now see your extension in the list.
