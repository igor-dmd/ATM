# ATM
----
_Sample backend exercise to simulate ATM operations._

To run the tests, install the project dependencies with ```bundle install``` and run ```bundle exec rspec```.

## API Endpoints
----


### List Users

#### GET /users

Success Response:
```
  Code: 200
  Content: List of Users
```


### Create User

#### POST /users

Data Params:
```
{
    "full_name":[string],
    "cpf":[string],
    "address":[text],
    "birthday':[datetime],
    "gender":[integer],
    "password":[integer],
    "address" :[Address] {
        "street_name":[string],
        "city":[string],
        "state":[string],
        "country":[string],
    }
}

```
Success Response:
```
  Code: 200
  Content: User Information
```

### Show User

#### GET /users/:id

URL Params:
```
{
    "id":[integer]
}

```
Success Response:
```
  Code: 200
  Content: User Information
```


### Update User

#### PUT /users/:id

URL Params: id=[integer]

Data Params:
```
{
   "full_name":[string],
    "cpf":[string],
    "address":[text],
    "birthday':[datetime],
    "gender":[integer],
    "password":[integer],
    "address" :[Address] {
        "street_name":[string],
        "city":[string],
        "state":[string],
        "country":[string],
    }
}
```
Success Response:
```
  Code: 200
  Content: User Information
```


### Destroy User

#### POST /users/:id

URL Params: id=[integer]

Success Response:
```
  Code: 204
  Content: No Content
```


### Update Limit

#### PUT limits/:user_id

URL Params: user_id=[integer]

Data Params:
```
{
   "limit":[integer]
}
```
Success Response:
```
  Code: 200
  Content: User Account Information
```
Error Response:
```
  Code: 412
  Content: No Content
```


### Deposit

#### POST deposits/:user_id

URL Params: user_id=[integer]

Data Params:
```
{
   "target_acc_number":[integer],
   "target_branch":[integer],
   "amount":[integer]
}
```
Success Response:
```
  Code: 200
  Content: Transaction Information
```
Error Response:
```
  Code: 404, 412
  Content: No Content
```


### Transfer

#### POST transfers/:user_id

URL Params: user_id=[integer]

Data Params:
```
{
   "target_acc_number":[integer],
   "target_branch":[integer],
   "amount":[integer]
}
```
Success Response:
```
  Code: 200
  Content: Transaction Information
```
Error Response:
```
  Code: 404, 412
  Content: No Content
```


### Statement

#### GET accounts/:user_id/statement

URL Params: user_id=[integer]

Data Params:
```
{
   "number_of_days":[integer] (OPTIONAL)
}
```
Success Response:
```
  Code: 200
  Content: Transaction Information
```


### Balance

#### GET accounts/:user_id/balance

URL Params: user_id=[integer]

Success Response:
```
  Code: 200
  Content: Transaction Information
```


### Withdrawal Request

#### POST withdraws/:user_id/request

URL Params: user_id=[integer]

Data Params:
```
{
   "amount":[integer]
}
```
Success Response:
```
  Code: 200
  Content: Withdrawal Options
```
Error Response:
```
  Code: 412
  Content: No Content
```

### Withdraw

#### POST withdraws/:user_id/confirmation

URL Params: user_id=[integer]

Data Params:
```
{
   "withdrawal_request_id":[integer],
   "selected_option":[integer]
}
```
Success Response:
```
  Code: 200
  Content: Transaction Options
```
Error Response:
```
  Code: 403, 412
  Content: No Content
```