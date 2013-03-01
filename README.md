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

### API
We have an API to let you build your own client and use the application.

#### Customers
Customers are scoped to the user account making the requests.
`http://saletracker.herokuapp.com/api/customers.json?token=y1ckhL3mB1GW985qaKRn`

retrieves the list of customers for the user with token `y1ckhL3mB1GW985qaKRn`.

```json

[
  {
    "created_at":"2013-02-26T23:02:54Z",
    "email":"gage.wuckert@hotmail.com",
    "id":1,
    "name":"Ms. Westley Shields",
    "phone":"314-564-0035",
    "updated_at":"2013-02-27T02:20:17Z",
    "user_id":1,
    "last_payment":{
      "amount":4000,
      "created_at":"2013-02-27T02:20:17Z",
      "customer_id":1,
      "id":94,
      "payment_date":"2013-02-27",
      "updated_at":"2013-02-27T02:20:17Z"
    }
  },
  …
]
```

#### Purchases
Purchases are scoped from the user account making the request to a specific customer belonging to that account. Example:
`http://saletracker.herokuapp.com/api/customers/1/purchases/15.json?token=y1ckhL3mB1GW985qaKRn`

```json

{
  "created_at":"2013-03-01T19:12:58Z",
  "customer_id":1,
  "id":15,
  "purchase_date":"2013-03-01",
  "updated_at":"2013-03-01T19:12:58Z",
  "total":4700,
  "items":[
    {
      "created_at":"2013-03-01T19:19:53Z",
      "id":27,
      "item_total":1900,
      "name":"French Coat",
      "purchase_id":15,
      "qty":1,
      "updated_at":"2013-03-01T19:19:53Z"
    },
    {
      "created_at":"2013-03-01T19:19:53Z",
      "id":28,
      "item_total":1900,
      "name":"French Coat",
      "purchase_id":15,
      "qty":1,
      "updated_at":"2013-03-01T19:19:53Z"
    },
    {
      "created_at":"2013-03-01T19:19:53Z",
      "id":29,
      "item_total":900,
      "name":"Turtle Neck Sweater",
      "purchase_id":15,
      "qty":1,
      "updated_at":"2013-03-01T19:19:53Z"
    }
  ]
}
```
