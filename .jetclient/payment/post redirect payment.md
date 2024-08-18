```toml
name = 'post redirect payment'
method = 'POST'
url = 'https://teknodipani.com/api/payment'
sortWeight = 2000000
id = '0d8b6bfd-3165-47ed-9110-000349856072'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '103d59ea-5395-4433-88a1-4d5a1e2e1cf1'

[body]
type = 'JSON'
raw = '''
{
  "account": "Dana",
  "details": "Pembayaran untuk update akun premiun",
  "referenceNum": "INV-20231207-001", // no.ref dari midtrans
  "price": 10000,
  "adminFee": 500,
  "totalPrice": 10500
}'''
```
