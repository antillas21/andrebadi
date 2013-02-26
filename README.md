# About AndreBadi
This is a sample app that will be used (for real) to track:
* customers
* sales
* payments

for a hobby job that my wife has.

## Reasons for this app
* Build something useful to help track all things mentioned above
* Play with Rails and Backbone.js

## Developer Setup
* `cp config/database.yml.example config/database.yml` and adjust it to your local environment

### For Linux/Ubuntu
For a successful `bundle install`, you'll need to `sudo apt-get install libpq-dev`.

```console
bundle install

# give a password to the main db user
sudo -u postgres psql postgres
postgres=# \password postgres
\q
# create a superadmin user for easier testing
sudo -u postgres createuser --superuser andre_badi
sudo -u postgres psql
postgres=# \password andre_badi

# uncomment `listen_addresses = 'localhost'` in `postgresql.conf`

rake db:setup
```

