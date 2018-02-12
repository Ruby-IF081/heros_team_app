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

## Install Elasticsearch

Elasticsearch requires at least Java 8. Before you install Elasticsearch, please check your Java version first by running (and then install/upgrade accordingly if needed): `java -version`

Download the Elasticsearch 6.1.2 tar as follows:
`curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.2.tar.gz`

Then extract it as follows: `tar -xvf elasticsearch-6.1.2.tar.gz`

Go into the bin directory as follows: `cd elasticsearch-6.1.2/bin`

Start elasticsearch as follows: `./elasticsearch`

## API instructions

Simple API gives a possibility to receive a JSON of searched companies.

API endpoint: 

`GET api/companies`

Request should contain authorization header

`Authorization: Token token=*your_token_generated_in_profile*`

Response example
```json
companies:	
    0:	
            id: 	1
            name:  	"Example Company"
            url:  	"http://localhost:3000/account/companies/1/download.pdf"
```