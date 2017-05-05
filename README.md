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

```
Success Response:
```
  Code: 200
  Content: deposit data
```