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
token = '19db9e85-c90b-4770-b207-a27a6ea3b748'

[body]
type = 'JSON'
raw = '''
{
  "gender": "Laki-laki",
  "rangeAge": "18-24",
  "category": "Pengembangan diri"
}'''
```
