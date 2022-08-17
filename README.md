# README

* Ruby version
  - 3.0.3

* System dependencies
  - rails 7.0.3
  - postgresql


* Project Setup
  - Create 'master.key' file in '/config' directory
  - Add following key in 'master.key' file
  - 470b7b2ebf1b8007d9df4fd3f7212e25

* Run these commands(In payment-system directory)
```
gem install bundler
bundle install
```
* Database Setup
  - Create '.env' file at project root
  - Add your postgresql username and password in .env
```
  Example:
    DB_USER_NAME = user
    DB_PASSWORD = password
```
* Database Creation
```
rails db:create
rails db:migrate
```

* To seed Admin and Merchant
```
rake import:users
```

* How to run the test suite
```
  bundle exec rspec
```
