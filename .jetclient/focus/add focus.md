```toml
name = 'add focus'
method = 'POST'
url = 'https://testimoni.contohdomain.com/api/focus'
sortWeight = 2000000
id = 'f52e5358-20ee-4045-bf0e-fd4fe3e146f3'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '19db9e85-c90b-4770-b207-a27a6ea3b748'

[body]
type = 'JSON'
raw = '''
{
  "readings" : "2023-12-07T10:30:00Z",
  "manyBooks" : "10",
  "focus" : "2023-12-14T15:00:00Z",
}'''
```
