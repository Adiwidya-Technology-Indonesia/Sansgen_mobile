```toml
name = 'patch user'
method = 'PATCH'
url = 'https://teknodipani.com/api/users/current'
sortWeight = 2000000
id = '9fb69c1d-e569-4011-8398-4a593d374e4c'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = 'e7be7303-22e8-4976-8910-8967b4b9d704'

[body]
type = 'JSON'
raw = '''
{
//  "name": "rahmat",
//  "image" : "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"
//  "dateOfBirth": null,
  "rangeAge": "18-24",
  "gender": "Laki-laki",
//  "hobby": null,
  "idCategory":[1,2,3,4,5,6]
}'''
```
