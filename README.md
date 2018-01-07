**Welcome to Sales Assistant!**

# Sales Assistant

[![Build Status](https://travis-ci.org/Ruby-IF081/heroes_team_app.svg?branch=master)](https://travis-ci.org/Ruby-IF081/heroes_team_app)

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
