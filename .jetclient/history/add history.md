```toml
name = 'add history'
method = 'POST'
url = 'https://testimoni.contohdomain.com/api/history/{book:0afb9a35-352c-4c88-b781-66a2f7e98356}'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[pathVariables]]
key = 'book:0afb9a35-352c-4c88-b781-66a2f7e98356'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '81bc451c-dcaf-476c-8e0b-079521e6e604'

[body]
type = 'JSON'
raw = '''
{
  "isFinished" : false,
  "lastChapter" : "10"
}'''
```
