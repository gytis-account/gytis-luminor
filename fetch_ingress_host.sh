#!/bin/bash

sleep 60
# Fetch the external IP or DNS name of the ingress controller
INGRESS_IP=$(kubectl get svc nginx-ingress-ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Output the result in JSON format
jq -n --arg ingress_ip "$INGRESS_IP" '{"ingress_ip":$ingress_ip}'