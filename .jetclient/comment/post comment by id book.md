```toml
name = 'post comment by id book'
method = 'POST'
url = 'http://192.168.1.6/api/books/05c10d3d-a1be-46ea-8820-846e23d8d3ee/comments'
sortWeight = 2000000
id = '4fc3298b-18cd-4247-ad46-1805a88d57d0'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '123'

[body]
type = 'JSON'
raw = '''
{
  "comment": "buku yang sangat bagus"
}'''
```
