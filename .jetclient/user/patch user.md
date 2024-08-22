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
token = '62b0619a-2c96-4ffd-adc8-3bc6da178fa4'

[body]
type = 'JSON'
raw = '''
{
//  "name": "rahmat",
//  "image" : "360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
//  "dateOfBirth": "2024-08-31 00:00:00.000",
////  "rangeAge": "18-24",
////  "gender": "Laki-laki",
//  "hobby": "hh",
//  "idCategory":[1,2,3,4,5,6]
}'''
```
