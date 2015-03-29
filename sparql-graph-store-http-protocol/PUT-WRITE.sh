#! /bin/bash

# verify write access for user with write access only

initialize_repository --repository "${STORE_REPOSITORY}-write"

curl_graph_store_update -X PUT \
     -H "Content-Type: application/n-quads"  \
     -u "${STORE_TOKEN}-write:" \
     --repository "${STORE_REPOSITORY}-write" all <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object PUT1" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object PUT1" <${STORE_NAMED_GRAPH}-two> .
EOF

curl_graph_store_get \
     --repository "${STORE_REPOSITORY}-write" \
   | tr -s '\n' '\t' \
   | fgrep -v '"default object"' | fgrep -v '"named object"' | fgrep -v "<${STORE_NAMED_GRAPH}>" \
   | fgrep '"default object PUT1"' | fgrep '"named object PUT1"' \
   | fgrep  "<${STORE_NAMED_GRAPH}-two>" \
   | tr -s '\t' '\n' | wc -l | fgrep -q 2
