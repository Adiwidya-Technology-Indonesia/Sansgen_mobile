```toml
name = 'add rating in book'
method = 'POST'
url = 'https://teknodipani.com/api/books/a829c490-403e-407d-9791-b2b2e16b6d11/rate'
sortWeight = 1000000
id = '0ba319ef-802f-468c-8270-f9c8414c4a69'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '692880c6-e29d-426b-b8cd-793e1083484e'

[body]
type = 'JSON'
raw = '''
{
  "rate": 4.5,
}'''
```
