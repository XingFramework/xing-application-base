= Reference for MindSwarms

== Setup

=== Rails Config

* bundle
* create database.yml and config/initializers/*.example files

=== Main Database

Project starts from a dump of the old website - not from a bare database.

IMPORTANT: MIGRATIONS WON'T RUN WITHOUT THE DUMP. GET IT FROM JUDSON OR EVAN
BEFORE PROCEEDING!

* bundle exec rake db:create
* pg_restore -O -d mindswarms_dev latest.dump
* bundle exec rake db:migrate
* bundle exec rake db:test:prepare

=== Angular App

* ensure npm version >= 1.3 available
  (brew install npm) or (brew upgrade npm) on macs.
* cd angular
* npm install
* add node_modules/.bin to your path.  direnv recommended here.
* grunt watch


== Development Commands

=== Shared Fixtures

A set of fixture files in angular/test/fixtures represent JSON that both the Angular front end and the
Rails back and should be compatible with.  To copy the current version of the file to one or the other
project.

The presence of the authoritative fixtures means a FE or BE developer can update the fixtures without
immediately breaking the other end's specs.  When you make changes to your fixtures that satisfy you,
you should then copy those changes into the authoritative fixtures.  You should regularly run the
commands below to make sure you have pulled any updates to those fixtures made by developers working
on the other end of the projects, and update your specs to match them.

* bundle exec rake json_specs:update   # copies authoritative JSON to the Rails spec directory
* cd angular; grunt update-fixtures    # copies authoritative JSON to the AngularJS spec directory

=== Rails tests

* bundle exec rspec spec

=== Rails server

* bundle exec rails s

=== Angular tests

* cd angular
* grunt watch  (this will stay open and re-run the tests as things change)



