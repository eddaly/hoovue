whoactually.com
===============

# Hosting
The app is currently hosted on Heroku.

# Staging
To deploy to the staging site you need to add the app to git on your machine if you haven't already done so:
```
$ git remote add heroku-staging git@heroku.com:hoovue-staging.git
```

Deploy the branch that you want staging to run with (replace staging with your branch if different):
```
$ git push heroku-staging staging:master
```

# Database
Database is Postgresql. 

To get a copy of the live database run `heroku pg:info --app hoovue` to get the database URL
```
$ heroku pg:pull HEROKU_POSTGRESQL_BLACK whoactually_development --app hoovue
```

Add `config/database.yml` with something like the following:
```YAML
development: &default
  adapter: postgresql
	encoding: unicode
	database: whoactually_development
	pool: 200
	username: username
	password:

test:
  <<: *default
	database: whoactually_test
```

# Do you want to use docker as your development environment?
If you are interested in using docker then here are the steps to set up your dev environment using VirtualBox, Vagrant, docker-osx and fig.

First follow the install instructions to install VirtualBox, Vagrant and [docker-osx](https://github.com/noplay/docker-osx) if they are not already installed on your system already.

Once these are all installed you will need to start the docker-osx VM as currently docker doesn't run on Mac natively

```
$ docker-osx start
```

Next install fig

```
$ curl -L https://github.com/orchardup/fig/releases/download/0.5.1/darwin > /usr/local/bin/fig
$ chmod +x /usr/local/bin/fig
```

Create a `config/database.yml` file that looks like this:

```YAML
development: &default
  adapter: postgresql
  encoding: unicode
  database: whoactually_development
  pool: 5
  username: docker
  password: docker
  host: <%= ENV.fetch('DB_1_PORT_5432_TCP_ADDR', 'localhost') %>
  port: <%= ENV.fetch('DB_1_PORT_5432_TCP_PORT', 'localhost') %>
  template: template0

test:
  <<: *default
  database: whoactually_test
```

Now it's time to build the web image that the app will run on and bring up the database image. This can take some time if this is the first time you've
run docker as it'll download all the relevant images and have to build the web image which includes doing a bundle install

```
$ fig build
```

Next we need to populate the database with some data, to make it easier you can add the Postgresql credentials to your environment like so:

```
$ export PGHOST=localdocker
$ export PGUSER=docker
$ export PGPASSWORD=docker
```

Get the latest PG Backup from Heroku and restore it to your Postgresql container:

```
$ curl -o latest.dump `heroku pgbackups:url --app hoovue`
$ fig run web bundle exec rake db:create
$ fig start db
$ pg_restore --verbose --clean --no-acl --no-owner -d whoactually_development latest.dump
```

Finally bring up the app using fig:

```
$ fig up
```
