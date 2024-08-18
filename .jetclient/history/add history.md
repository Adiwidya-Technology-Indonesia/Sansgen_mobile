```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/a829c490-403e-407d-9791-b2b2e16b6d11/chapters/4'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '692880c6-e29d-426b-b8cd-793e1083484e'

[body]
type = 'JSON'
raw = '''
// users/current
{
  "isFinished" : false,
  "lastChapter" : 0,
//  "listChapter" : []
}'''
```
