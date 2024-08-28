```toml
name = 'put focus'
method = 'POST'
url = 'https://teknodipani.com/api/focus'
sortWeight = 2000000
id = 'f52e5358-20ee-4045-bf0e-fd4fe3e146f3'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = 'a13f3abe-7a72-4ae2-ba2a-5a20179a61ca'

[body]
type = 'JSON'
raw = '{readings: "00:02:24", manyBooks: 1, focus: "00:00:00"}'
```
