#!/bin/sh

host=${1:-localhost}
echo Setting up host: "$host"

echo Setup wingman-bob
curl -X 'PUT' \
  "http://$host:8000/v1/models/hello-world" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 10000,
  "url": "http://cog-hello-world:5000"
}'

curl -X 'PUT' \
  "http://$host:8000/v1/models/resnet" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 20000,
  "url": "http://cog-resnet:5000"
}'

curl -X 'PUT' \
  "http://$host:8000/v1/models/health" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 30000,
  "url": "http://cog-health-server:5000"
}'

echo Setup wingman-charlie
curl -X 'PUT' \
  "http://$host:8001/v1/models/hello-world" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 30000,
  "url": "http://cog-hello-world:5000"
}'

curl -X 'PUT' \
  "http://$host:8001/v1/models/resnet" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 10000,
  "url": "http://cog-resnet:5000"
}'

curl -X 'PUT' \
  "http://$host:8001/v1/models/health" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 40000,
  "url": "http://cog-health-server:5000"
}'

echo Test Dx network
curl -X 'POST' \
  "http://$host:9944" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 1,
  "jsonrpc": "2.0",
  "method": "dx_upload",
  "params": [
    "0x415c5b6ebf7beeb13c7e4c46b19e6466be41df527a9d9f4879f53b347dda9790",
    "0x010203"
  ]
}'

sleep 5s

curl -X 'POST' \
  "http://$host:9944" \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 2,
  "jsonrpc": "2.0",
  "method": "dx_download",
  "params": [
    "0x415c5b6ebf7beeb13c7e4c46b19e6466be41df527a9d9f4879f53b347dda9790"
  ]
}'

echo Setup blockchain network
cd setup && cargo run -- "$host"

