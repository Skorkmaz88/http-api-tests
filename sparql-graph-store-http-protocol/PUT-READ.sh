#! /bin/bash

# verify NO write access for user with read access only

curl_graph_store_update -X PUT -w "%{http_code}\n" \
     -H "Content-Type: application/n-quads"  \
     -u "${STORE_TOKEN}-read:" \
     --repository "${STORE_REPOSITORY}-write" all <<EOF\
  | test_unauthorized_success
<http://example.com/default-subject> <http://example.com/default-predicate> "default object PUT1" .
EOF

