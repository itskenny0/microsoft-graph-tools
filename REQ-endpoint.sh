#!/bin/bash
if [ ! -f authtoken ] || [ ! -f config.json ]; then
        echo "Either authtoken or config.json is missing. Please follow the README."
        exit 1
fi

TOKEN=$(cat authtoken)

GRAPH_URL=$(jq -r .endpoints.graph config.json)
curl -s $GRAPH_URL/$1 -H "Authorization: Bearer $TOKEN" | jq .
