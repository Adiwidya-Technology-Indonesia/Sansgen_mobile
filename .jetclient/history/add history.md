```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/7093883d-88c6-4a3c-a6bd-8e3734897eba/chapters/1'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = 'a6da7dd4-8c0f-4092-ba22-fba2cec196b4'

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
