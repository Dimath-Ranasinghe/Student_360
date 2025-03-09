# API Documentation

## Create Notice (POST /api/notices)
- Request: `{ "title": "string", "content": "string" }`
- Response: `{ "message": "Notice created successfully", "notice": { ... } }`

## Get Notices (GET /api/notices)
- Response: `{ "message": "Notices fetched successfully", "data": [ ... ] }`