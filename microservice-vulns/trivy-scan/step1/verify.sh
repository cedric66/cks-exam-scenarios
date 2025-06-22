#!/bin/bash
if [[ ! -f /root/trivy-report.json ]]; then
    echo "Error: Scan report missing"
    exit 1
fi

if ! grep -q '"Severity": "HIGH"' /root/trivy-report.json; then
    echo "Error: No HIGH severity vulnerabilities found"
    exit 1
fi

exit 0