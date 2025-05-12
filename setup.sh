#!/bin/bash

# Wait for Elasticsearch to be ready
until curl -s -u elastic:$ELASTIC_PASSWORD http://elasticsearch:9200/_cluster/health | grep -q '"status":"yellow"\|"status":"green"'; do
  echo "Waiting for Elasticsearch..."
  sleep 5
done

# Update kibana_system user password
curl -s -u elastic:$ELASTIC_PASSWORD -X PUT "http://elasticsearch:9200/_security/user/kibana_system/_password" \
  -H "Content-Type: application/json" \
  -d "{\"password\": \"$KIBANA_PASSWORD\"}"

echo "Kibana system user password updated."
