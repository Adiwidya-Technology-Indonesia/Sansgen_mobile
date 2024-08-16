```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/5d08382b-cfc0-4ffa-b27a-9b9c94dee237/chapters/2'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '85b06f5e-274b-4623-bc9d-3168fe6de855'

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
