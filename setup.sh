#!/bin/sh
curl -X 'PUT' \
  'http://localhost:8000/v1/models/hello-world' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 100
}'

curl -X 'PUT' \
  'http://localhost:8000/v1/models/resnet' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 200
}'

curl -X 'PUT' \
  'http://localhost:8001/v1/models/hello-world' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 300
}'

curl -X 'PUT' \
  'http://localhost:8001/v1/models/resnet' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "price_per_request": 100
}'

curl -X 'POST' \
  'http://localhost:9944' \
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
  'http://localhost:9944' \
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
