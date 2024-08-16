```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/0034d983-aad7-4db8-929d-739989e1419d/chapters/2'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '9510c38d-42bb-442c-bbf5-5755fe4dd6a5'

[body]
type = 'JSON'
raw = '''
// users/current
{
  "isFinished" : false,
  "lastChapter" : 1,
//  "listChapter" : []
}'''
```
