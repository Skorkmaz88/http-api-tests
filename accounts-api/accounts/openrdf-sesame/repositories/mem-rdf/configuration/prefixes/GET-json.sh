#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

${CURL}  -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/configuration/prefixes?auth_token=${STORE_TOKEN} \
  | json_reformat -m \
  | fgrep 'prefixes' \
  | fgrep -q "/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}"


