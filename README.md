An NCS Signup page
==================

This is the National Children's Study signup page used by the Greater
Chicago Study Center. It is a simple Ruby on Rails app which provides
a form to allow potential participants to express interest in the
study.

It uses Rails 3 and a PostgreSQL database.  It is currently [in production][prod].

[prod]: https://signup.greaterchicagoncs.org

For questions or comments, please contact r-sutphin@northwestern.edu.

Use at other centers
--------------------

The GCSC published this application to provide an example for other
centers. If you want to deploy it for your center, you'll need to
customize the visual design. We recommend that you [fork][] the
[project on GitHub][project] and apply your changes in the fork. This
will make it easier for you to merge in any changes we make after you
start your modifications. It will also give you a repo at which to point
Capistrano for deployment.

Deployment
----------

As noted in the previous section `ncs_signup` supports [Capistrano][]
for deployment. With Capistrano, you check out the code on a
workstation and then run a script which deploys it on one or more
target servers. (Just one for this application.)

[Capistrano]: https://github.com/capistrano/capistrano/wiki/

### Prerequisites

On the deployment workstation:

* Ruby 1.8.7
* RubyGems
* [Bundler][] (install as a gem)
* A [git][] client

On the application server:

* Ruby 1.8.7 ([Ruby Enterprise Edition][ree] is what GCSC uses)
* RubyGems
* [Bundler][] (install as a gem)
* [Passenger][] (install as a gem)
* A [git][] client
* Access to a PostgreSQL server
* Apache configured to do SSL with an appropriate certificate

[Bundler]: http://gembundler.com/
[git]: http://git-scm.com/
[Passenger]: http://modrails.com/
[ree]: http://www.rubyenterpriseedition.com/

### Setup on the application server

#### Configure Passenger

Passenger is an Apache module. Read [its manual][passenger-docs] for
information on configuring it.

[passenger-docs]: http://www.modrails.com/documentation.html

Part of deploying with Passenger is deciding on a location where the
application files are going to sit on the server. For the remainder of
this document, we'll assume that this directory is `/var/www/apps`.

#### Configure database

`ncs_signup` uses a single PostgreSQL database. It looks for the
connection information for this database using
[bcdatabase][]. Specifically, it looks for bcdatabase group
`ncsdb_prod` and configuration name `ncs_signup`. This means you need
to create a file `/etc/nubic/db/ncsdb_prod.yml` with contents
following this pattern:

    defaults:
      host: ncsdb.myinst.edu
      port: 5432
      adapter: postgresql
    ncs_signup:
      database: ncs_pii # only needed if not the same as the name, i.e. "ncs_signup"
      username: ncsapps # similarly only needed if not the same as the name
      password: foo

(If you are setting up a staging instance, the the group name and the
filename should be `ncs_staging` instead of `ncs_prod`.)

This file is [YAML][], so whitespace is important. Be sure to indent
everything the same amount using spaces (not tabs).

After you create this file, you can optionally obscure the
password. See the documentation for [bcdatabase][] for more
information. If you want to do this, you'll first need to install the
bcdatabase gem using the system's rubygems.

[bcdatabase]: https://github.com/NUBIC/bcdatabase/README.md
[YAML]: http://yaml.org/

### Setup on the deployment workstation

#### Clone & install dependencies

* Clone the repository onto the workstation using git.
* Run `bundle install` to install the necessary gems.

#### Deployment attributes configuration

The [cap][Capistrano] script for `ncs_signup` is parameterized. It
reads the parameters from a [bcdatabase][] file, group `ncs_deploy`
and name `ncs_signup`. You'll need to create a file
`/etc/nubic/db/ncs_deploy.yml` on the workstation with contents along
these lines:

    defaults:
      # the app directory implied by your Passenger conf
      deploy_to: /var/www/apps
    ncs_signup:
      # If you have your own fork, use its read-only URL here
      repo: git://github.com/NUBIC/ncs_signup.git
      # The servers to deploy to
      staging_app_server: ncsapps-staging.myinst.edu
      production_app_server: ncsapps.myinst.edu

### Finally, deployment

Once everything is configured, you're ready to deploy. On the
workstation, run this line:

    $ bundle exec cap production deploy:migrations

That should be it. Notes:

* This will deploy the code from the git repository onto the
  server. Uncommitted/unpushed changes in the local workstation copy
  will not be deployed.
* This will automatically create or update the database schema as
  needed.

Exporting
---------

Once your signup page is approved and collecting participant interest,
you'll want to extract the participants so they can be evaluated for
eligibility and possibly contacted. `ncs_signup` includes two rake
tasks to assist you with this.

* `participants:full_export` creates a CSV containing all the
  participants that have ever signed up.
* `participants:new_participants` creates a CSV containing the
  information for any participants who have signed up since the last
  time you ran it. I.e., `ncs_signup` keeps track of the participants
  that are exported using this task and only ever exports them once.

To run either, SSH into the application server and switch to the
application directory:

    $ cd /var/www/apps/ncs_signup/current
    $ rake participants:new_particpants

The CSV for either command is written to `exports/participants_{kind
of export}_{timestamp}.csv`.
