#!/bin/bash
# Verify Trivy exists and report contains HIGH severity findings
if ! command -v trivy &> /dev/null; then
    echo "Error: Trivy not installed"
    exit 1
fi

if [[ ! -f /home/candidate/trivy-report.json ]]; then
    echo "Error: Scan report missing"
    exit 1
fi

if ! grep -q '"Severity": "HIGH"' /home/candidate/trivy-report.json; then
    echo "Error: No HIGH severity vulnerabilities found"
    exit 1
fi

exit 0