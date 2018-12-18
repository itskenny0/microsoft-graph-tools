#!/bin/bash
TOKEN=$(cat authtoken)

GRAPH_URL=$(jq -r .endpoints.graph config.json)
curl -s $GRAPH_URL/$1 -H "Authorization: Bearer $TOKEN" | jq .
