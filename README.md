# About AndreBadi
This is a sample app that will be used (for real) to track:

* customers
* sales
* payments

for a hobby job that my wife has.


## Reasons for this app
* Build something useful to help track all things mentioned above
* Play with Rails and Backbone.js
* Discovered Marionette.js while developing and wanted to play with it


## Developer Setup
* `$ cp config/database.yml.example config/database.yml` and adjust it to your local environment


### For Linux/Ubuntu
For a successful `bundle install`, you'll need to `sudo apt-get install libpq-dev`.

```
$ bundle install



# give a password to the main db user

$ sudo -u postgres psql postgres
postgres=# \password postgres
\q


# create a superadmin user for easier testing

$ sudo -u postgres createuser --superuser andre_badi
$ sudo -u postgres psql
postgres=# \password andre_badi


* uncomment `listen_addresses = 'localhost'` in `postgresql.conf`

$ rake db:setup
```

## API
#### How it works
The application has an API to let you build your own client and use the application.
Just point all your requests to the `/api` namespace and you'll be good to go.
Example: `http://127.0.0.1/api/customers.json?token=y1ckhL3mB1GW985qaKRn`.

__Note:__ The API requires a user token to validate requests. Examples using the authentication token.

* using a browser:
  * `http://127.0.0.1/api/customers.json?token=y1ckhL3mB1GW985qaKRn`
* using curl:
  * `$ curl http://127.0.0.1/api/customers.json?token=y1ckhL3mB1GW985qaKRn`
  * `$ curl --header "X-AUTH-TOKEN: y1ckhL3mB1GW985qaKRn" http://127.0.0.1/api/customers.json`

Once a user exists, a unique authentication token is generated. All data requests to the API should use the token.

All data responses are scoped to the authentication token owner. That is, users don't have access to overall and other users data and related models.

The front-end code of the app, actually uses the API to retrieve all data presented to the user. This way we ensure that any data that can be displayed to the application user in a browser is also available to API clients.

#### Sign up
__Registration__

* Route: `/api/registration.json`
* Method: POST
* Example: `curl -X POST --data "user[email]=johndoe@example.com&user[password]=password" http://localhost:3000/api/registration.json`

```json
{
  "id":1,
  "email":"johndoe@example.com",
  "authentication_token":"B43v36B7dQ1oaN6K9jRs",
  "created_at":"2013-06-25T07:44:46Z",
  "updated_at":"2013-06-25T07:44:46Z"
}
```


#### Customers
Customers are scoped to the user account making the request.

__List all customers__

* Route: `/api/customers.json`
* Method: GET
* Example: `http://127.0.0.1/api/customers.json?token=y1ckhL3mB1GW985qaKRn`.

```json
[
  {
    "id":8,
    "name":"Dandre Satterfield",
    "email":"cecile_dooley@gmail.com",
    "phone":"1-801-142-8780 x5237",
    "balance":9000.0,
    "created_at":"2013-02-26T23:02:55Z",
    "updated_at":"2013-02-27T02:20:17Z"
  },
  …
]
```

__Show one customer__

* Route: `/api/customers/:id.json`
* Method: GET
* Example: `http://127.0.0.1/api/customers/1.json?token=y1ckhL3mB1GW985qaKRn`

```json
{
  "id":1,
  "name":"Ms. Westley Shields",
  "email":"gage.wuckert@hotmail.com",
  "phone":"314-564-0035",
  "balance":0.0,
  "created_at":"2013-02-26T23:02:54Z",
  "updated_at":"2013-02-27T02:20:17Z",
  "transactions":[
    {
      "id":5,
      "type":"Purchase",
      "amount":12000.0,
      "created_at":"2013-06-21T01:08:30Z",
      "updated_at":"2013-06-21T01:09:13Z"
    },
    {
      "id":4,
      "type":"Payment",
      "amount":4000.0,
      "created_at":"2013-06-21T00:54:34Z",
      "updated_at":"2013-06-21T00:54:34Z"
    },
    …
  ]
}
```

__Create a customer__

* Route: `/api/customers.json`
* Method: POST
* Required fields: __TODO__
* Example: __TODO__

__Update a customer__

* Route: `/api/customers/:id.json`
* Method: PUT/PATCH
* Required fields: __TODO__
* Example: __TODO__



#### Payments
Payments are scoped to the user account making the request.

__List all paymentss__

* Route: `/api/payments.json`
* Method: GET
* Example: `http://127.0.0.1/api/payments.json?token=y1ckhL3mB1GW985qaKRn`.

```json
[
  {
    "id":4,
    "type":"Payment",
    "amount":4000.0,
    "created_at":"2013-06-21T00:54:34Z",
    "updated_at":"2013-06-21T00:54:34Z",
    "customer":{
      "id":1,
      "name":"Ms. Westley Shields",
      "email":"gage.wuckert@hotmail.com",
      "phone":"314-564-0035",
      "balance":0.0,
      "created_at":"2013-02-26T23:02:54Z",
      "updated_at":"2013-02-27T02:20:17Z"
    }
  },
  …
]
```

__Show one payment__

* Route: `/api/payments/:id.json`
* Method: GET
* Example: `http://127.0.0.1/api/payments/1.json?token=y1ckhL3mB1GW985qaKRn`

```json
{
  "id":1,
  "type":"Payment",
  "amount":4000.0,
  "created_at":"2013-06-21T00:54:34Z",
  "updated_at":"2013-06-21T00:54:34Z",
  "customer":{
    "id":1,
    "name":"Ms. Westley Shields",
    "email":"gage.wuckert@hotmail.com",
    "phone":"314-564-0035",
    "balance":0.0,
    "created_at":"2013-02-26T23:02:54Z",
    "updated_at":"2013-02-27T02:20:17Z"
  }
}
```

__Create a payment__

* Route: `/api/payments.json`
* Method: POST
* Required fields: __TODO__
* Example: __TODO__

__Update a payment__

* Route: `/api/payments/:id.json`
* Method: PUT/PATCH
* Required fields: __TODO__
* Example: __TODO__


#### Purchases
Purchases are scoped to the user account making the request.

__List all purchases__

* Route: `/api/purchases.json`
* Method: GET
* Example: `http://127.0.0.1/api/purchases.json?token=y1ckhL3mB1GW985qaKRn`.

```json
[
  {
    "id":5,
    "type":"Purchase",
    "amount":12000.0,
    "created_at":"2013-06-21T01:08:30Z",
    "updated_at":"2013-06-21T01:09:13Z",
    "customer":{
      "id":1,
      "name":"Ms. Westley Shields",
      "email":"gage.wuckert@hotmail.com",
      "phone":"314-564-0035",
      "balance":0.0,
      "created_at":"2013-02-26T23:02:54Z",
      "updated_at":"2013-02-27T02:20:17Z"
    },
    "line_items":[
      {
        "id":335,
        "name":"French Coat",
        "color":"Gray",
        "size":"38",
        "cost":800.0,
        "qty":1,
        "price":1200.0,
        "item_total":1200.0,
        "created_at":"2013-06-21T01:40:44Z",
        "updated_at":"2013-06-21T01:43:32Z"
      },
      ...
    ]
  },
  ...
]
```

__Show one purchase__

* Route: `/api/purchases/:id.json`
* Method: GET
*Example: `http://127.0.0.1/api/purchases/1.json?token=y1ckhL3mB1GW985qaKRn`

```json
{
  "id":1,
  "type":"Purchase",
  "amount":12000.0,
  "created_at":"2013-06-21T01:08:30Z",
  "updated_at":"2013-06-21T01:09:13Z",
  "customer":{
    "id":1,
    "name":"Ms. Westley Shields",
    "email":"gage.wuckert@hotmail.com",
    "phone":"314-564-0035",
    "balance":0.0,
    "created_at":"2013-02-26T23:02:54Z",
    "updated_at":"2013-02-27T02:20:17Z"
  },
  "line_items":[
    {
      "id":335,
      "name":"French Coat",
      "color":"Gray",
      "size":"38",
      "cost":800.0,
      "qty":1,
      "price":1200.0,
      "item_total":1200.0,
      "created_at":"2013-06-21T01:40:44Z",
      "updated_at":"2013-06-21T01:43:32Z"
    },
    ...
  ]
}
```
__Create a purchase__

* Route: `/api/purchases.json`
* Method: POST
* Required fields: __TODO__
* Example: __TODO__

__Update a purchase__

* Route: `/api/purchases/:id.json`
* Method: PUT/PATCH
* Required fields: __TODO__
* Example: __TODO__
