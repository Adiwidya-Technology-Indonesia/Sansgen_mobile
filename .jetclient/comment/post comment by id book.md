```toml
name = 'post comment by id book'
method = 'POST'
url = 'https://testimoni.contohdomain.com/api/books/0afb9a35-352c-4c88-b781-66a2f7e98356/comments'
sortWeight = 2000000
id = '4fc3298b-18cd-4247-ad46-1805a88d57d0'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '81bc451c-dcaf-476c-8e0b-079521e6e604'

[body]
type = 'JSON'
raw = '''
{
  "comment": "buku yang sangat bagus"
}'''
```
