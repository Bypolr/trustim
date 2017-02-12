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

## Getting Started

### Setup

1. Install rbenv for ruby version management.
2. Run command `rbenv install 2.4.0` to install ruby.
3. Install postgres v9.6 by homebrew or from source code.
4. Run command `gem install bundler` to install bundler.
5. Check out the git repository.
6. Run command `bundle` in the project directory to install the dependencies.

DB creation

`rails server`

### Other

Setup smtp server and fill in smtp server info in production.rb

Services (job queues, cache servers, search engines, etc.)


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
