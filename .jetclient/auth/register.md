```toml
name = 'register'
method = 'POST'
url = 'https://testimoni.contohdomain.com/api/register'
sortWeight = 1000000
id = '67c6c34a-22ae-4e1b-9681-6ff92764aa44'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[body]
type = 'JSON'
raw = '''
{
  "email": "rahmat@gmail.com",
  "password": "R@h999ht",
  "name": "rahmat"
}'''
```
