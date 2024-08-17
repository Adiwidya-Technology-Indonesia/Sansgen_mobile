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
token = '36e44165-6ebe-4ccd-bc9f-fe012a3f5fee'

[body]
type = 'JSON'
raw = '''
{
  "readings" : "00:30:00",
  "manyBooks" : 10,
  "focus" : "00:30:00"
}
'''
```
