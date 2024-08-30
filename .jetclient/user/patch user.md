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
token = 'a13f3abe-7a72-4ae2-ba2a-5a20179a61ca'

[body]
type = 'JSON'
raw = '''
{
//  "name": "rahmat",
  "image" : "ecf2a5257c2873630379.png",
//  "dateOfBirth": "2024-08-31",
////  "rangeAge": "18-24",
////  "gender": "Laki-laki",
//  "hobby": "hh",
//  "idCategory":[1,2,]
}'''
```
