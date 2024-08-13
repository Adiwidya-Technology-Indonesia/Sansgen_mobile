```toml
name = 'add like'
method = 'POST'
url = 'http://192.168.1.6/api/books/0afb9a35-352c-4c88-b781-66a2f7e98356/likes'
sortWeight = 1000000
id = '66f15234-0e89-4b6f-bf91-cf0801dc7e98'

[[headers]]
key = 'Content-Type'
value = 'multipart/form-data'

[auth.bearer]
token = '81bc451c-dcaf-476c-8e0b-079521e6e604'

[[body.formData]]
key = 'idBook'
value = '2'
disabled = true

[[body.formData]]
key = 'idUser'
value = '2'
disabled = true
```
