# kong-response-transformer-jq
jq response transformer for kong

Superceeded by kong-jq-transformer
(https://github.com/tibbycat/kong-jq-transformer)

## Prerequisites
1. Kong 0.12, or 0.14
2. Requires lua-jq which you can get from https://github.com/tibbycat/lua-jq
## Installing
Install response-transformer-jq
```
1. git clone https://github.com/tibbycat/kong-response-transformer-jq.git
2. sudo mkdir /usr/local/share/lua/5.1/kong/plugins/response-transformer-jq
3. sudo cp kong-response-transfer-jq/* /usr/local/share/lua/5.1/kong/plugins/response-transformer-jq
4. Add response-transformer-jq to /etc/kong/kong.conf custom_plugins
5. restart kong
```
