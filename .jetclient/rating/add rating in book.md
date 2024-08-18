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
token = 'c947ee77-0868-4753-a917-7cebb0faf219'

[body]
type = 'JSON'
raw = '''
{
  "rate": 4.5,
}'''
```
