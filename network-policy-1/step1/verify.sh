#!/bin/bash

res=$(kubectl get networkpolicy allow-specific-pods -n restricted -o json)

if [[ $(echo "$res" | jq -r .spec.podSelector.matchLabels.app) == "commerce-frontend" ]]; then
  exit 0
else
  exit 1
fi

if [[ $(echo "$res" | jq -r .spec.ingress[0].from[0].namespaceSelector.matchLabels.kubernetes.io/metadata.name) == "restricted" ]]; then
  exit 0
else
  exit 1
fi

if [[ $(echo "$res" | jq -r .spec.ingress[0].from[0].podSelector.matchLabels.app) == "jumpbox" ]]; then
  exit 0
else
  exit 1
fi