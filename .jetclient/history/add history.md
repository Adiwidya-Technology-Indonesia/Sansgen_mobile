```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/d0f02260-4c1f-47ec-bb27-25054df30b92/chapters/1'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '4a8ce1e3-5d74-432d-9c0b-186d877f0cd0'

[body]
type = 'JSON'
raw = '''
// users/current
{
  "isFinished" : false,
  "lastChapter" : 0,
}'''
```
