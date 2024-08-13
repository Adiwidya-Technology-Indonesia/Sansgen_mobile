```toml
name = 'patch user'
method = 'PATCH'
url = 'https://testimoni.contohdomain.com/api/users/current'
sortWeight = 2000000
id = '9fb69c1d-e569-4011-8398-4a593d374e4c'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '81bc451c-dcaf-476c-8e0b-079521e6e604'

[body]
type = 'JSON'
raw = '''
{
//  "gender": "Laki-laki",
//  "rangeAge": "18-24",
//  "category": "Pengembangan diri"
  "image" : "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"
}'''
```
