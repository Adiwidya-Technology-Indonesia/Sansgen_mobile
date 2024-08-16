```toml
name = 'add rating in book'
method = 'POST'
url = 'https://teknodipani.com/api/books/5d08382b-cfc0-4ffa-b27a-9b9c94dee237/rate'
sortWeight = 1000000
id = '0ba319ef-802f-468c-8270-f9c8414c4a69'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '85b06f5e-274b-4623-bc9d-3168fe6de855'

[body]
type = 'JSON'
raw = '''
{
  "rate": 4.5,
}'''
```
