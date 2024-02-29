# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 3.2.0, you can install with rvm or rbenv

* System dependencies

* Configuration -  check configuration in config/databse.yml and update the username & password
* bundle install - execute the command bundle install on terminal, 

* Database creation - execute `rails db:create`
* Sees the data - execute `rails db:seed`
* start the rails app - `rails s -p 3001`
* How to run the test suite - `RAILS_ENV=test rspec spec/`


currently webpage of user event is not working, as it totally new ui conigurations for me. I have created the API to create different type of user events. 
please use the postman collection from the repo, file has name `event_management_postman_collection.json`

to use the api, you will need the authorization key so, you can create that from raiils console.
`JsonWebToken.encode({used_id: 1})`, copy that token from rails console to postman and you can play with the app now.
* ...
