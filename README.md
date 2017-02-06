# README
Trust IM sample web app.
This Demo tend to implement features using as pure Rails as possible.

* Ruby version

    2.4.0
  
* System dependencies

    Postgres 9.6

* Configuration
  
* Database creation
```
create user trust
create database -Otrust trust_development
create database -Otrust trust_test
create database -Otrust trust_production
```

* Database initialization

* How to run the test suite

    rails test
  
* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

1. install rbenv for ruby version management
2. `rbenv install 2.4.0`
3. install postgres v9.6 by homebrew or from source code
4. `gem install bundler`
5. check out the git repository
6. `bundle`
7. DB creation
8. `rails s`
9. setup smtp server and fill in smtp server info in production.rb