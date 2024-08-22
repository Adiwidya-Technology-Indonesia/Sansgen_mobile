```toml
name = 'put focus'
method = 'POST'
url = 'https://teknodipani.com/api/focus'
sortWeight = 2000000
id = 'f52e5358-20ee-4045-bf0e-fd4fe3e146f3'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = 'a462ab5e-4c01-4c8d-ac93-5ce91dff2d7d'

[body]
type = 'JSON'
raw = '''
{
  "readings" : "01:20:00",
  "manyBooks" : 10,
  "focus" : "00:30:00"
}
'''
```
