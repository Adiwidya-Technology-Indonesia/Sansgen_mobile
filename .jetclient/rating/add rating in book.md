```toml
name = 'add rating in book'
method = 'POST'
url = 'https://testimoni.contohdomain.com/api/books/0afb9a35-352c-4c88-b781-66a2f7e98356/ratings'
sortWeight = 1000000
id = '0ba319ef-802f-468c-8270-f9c8414c4a69'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[body]
type = 'JSON'
raw = '''
{
  "rate": 4.5,
}'''
```
