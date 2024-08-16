```toml
name = 'add focus'
method = 'POST'
url = 'https://teknodipani.com/api/focus'
sortWeight = 2000000
id = 'f52e5358-20ee-4045-bf0e-fd4fe3e146f3'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '9510c38d-42bb-442c-bbf5-5755fe4dd6a5'

[body]
type = 'JSON'
raw = '''
//{
//  "readings" : "2023-12-07T10:30:00Z",
//  "manyBooks" : "10",
//  "focus" : "2023-12-14T15:00:00Z"
//}
// otomatis tertambah ketika login
{
  "readings" : "0 menit",
  "manyBooks" : 0,
  "focus" : "0 menit",
}'''
```
