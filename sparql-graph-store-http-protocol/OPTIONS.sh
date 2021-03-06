#! /bin/bash
set -o errexit

# executed for varied service endpoint and content/accept media types,
# with expected variations in the available options
# nb. -D - means no data

# gsp
curl_graph_store_get -D - -X OPTIONS \
   | fgrep "Allow" | fgrep GET | fgrep -q DELETE

# there are no restrictions on request media type
curl_graph_store_get -D - -f -s -X OPTIONS \
     -H "Content-Type: application/sparql-query" \
   | fgrep "Allow" | fgrep GET | fgrep PUT | fgrep POST | fgrep -q DELETE

# there are no restrictions on response media type
curl_graph_store_get -D - -f -s -X OPTIONS \
     -H "Accept: application/sparql-results+xml" \
   | fgrep "Allow" | fgrep PUT | fgrep POST | fgrep -q DELETE
