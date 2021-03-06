#! /bin/bash

# the protocol target is the default graph, the statements include quads and the content type is n-triples:
# - triples are added to the protocol (default) graph.
# - quads are added to the protocol (default) graph.
# - no statements are removed

curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/n-triples" \
     --data-binary @- \
     ${STORE_URL}/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?default\&auth_token=${STORE_TOKEN} <<EOF \
   | egrep -q "${POST_SUCCESS}"
<http://example.com/default-subject> <http://example.com/default-predicate> "default object POST1" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object POST1" <${STORE_NAMED_GRAPH}-two> .
EOF


curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     ${STORE_URL}/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"default object"' | fgrep '"named object"' | fgrep '"default object POST1"' | fgrep '"named object POST1"' \
   | fgrep "<${STORE_NAMED_GRAPH}>" \
   | if ($QUAD_DISPOSITION_BY_REQUEST) then fgrep -v "<${STORE_NAMED_GRAPH}-two>"; else fgrep "<${STORE_NAMED_GRAPH}-two>"; fi \
   | tr -s '\t' '\n' | wc -l | fgrep -q 4


initialize_repository | egrep -q "${POST_SUCCESS}"
