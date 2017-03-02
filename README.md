[![Build Status](https://travis-ci.org/Bypolr/trustim.svg?branch=master)](https://travis-ci.org/Bypolr/trustim)

# README

Trust IM sample app.
This demo tends to implement features using as pure Rails as possible.

## Table of Contents

* [**Project Details**](#project-details)
  * [Requirements](#requirements)
* [**Getting Started**](#getting-started)
  * [Setup](#setup)
  * [Other](#other)
  * [Run the test suite](#run-the-test-suite)
  * [Yarn installation](#yarn-installation)

## Project Details

Learn more about the **trustim** project requirements, licensing, and contributions.

### Requirements

- Ruby v2.4.0
- Postgres v9.6
- redis v3.2.8

## Getting Started

### Dev Setup

1. Install rbenv for ruby version management.

2. Run command `rbenv install 2.4.0` to install ruby.

3. Install postgres.

4. Install redis.

5. Install yarn.

6. Run command `gem install bundler` to install bundler.

7. Check out the git repository.

8. Run command `bundle` in the project directory to install the dependencies.

9. Create db schema by `bin/rails db:create`.

10. Run `bin/yarn install` to install javascript dependencies.

11. Run `bin/webpack-dev-server` to provide live assets reloading.

12. Run `foreman start` to start.

13. Have fun.


### Additional steps for production setup:

1. Run `rails webpacker:compile`
2. Run `rails assets:precompile`
3. export following env variables:
   - MAIL_HOST - hostname for 'send from' entry
   - MAIL_SMTP_ADDR - your smtp server address
   - MAIL_PORT - your smtp server port
   - MAIL_USER_NAME - your smtp server username
   - MAIL_PASSWORD - your smtp server password



### Other

Setup smtp server and fill in smtp server info in production.rb

Services (job queues, cache servers, search engines, etc.)

- sidekiq & redis for job queue

- postgres for RDBMS

### Run the test suite

```bash
rails test
```

### Yarn installation

Please use `bin/yarn` command instead of the global `yarn` command.
because global `yarn` command will install dependencies in the project root
instead of `vendor` directory.

Run following command to install dependencies.

```bash
bin/yarn
```

To add a npm package:

```bash
bin/yarn add <package-name>
```

To add a npm package for development environment:

```bash
bin/yarn add -D <package-name>
```

### webpacker

Put your common js code in `app/javascript/packs/common.js`.

For example, if you have a `app/javascript/packs/message.js` file:

```js
import Rx from 'rxjs/Rx';

Rx.Observable.of(1,2,3);
```

this is a entry file, you can put it in your `message.html.erb` file:

`<%= javascript_pack_tag 'message' %>`

### Start webpack dev server

```bash
bin/webpack-dev-server
```
