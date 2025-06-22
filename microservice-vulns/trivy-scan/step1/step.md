# Trivy Vulnerability Scanning Exercise

## Objective
Scan a vulnerable container image using the pre-installed Trivy scanner and identify high-severity vulnerabilities.

## Configuration
1. Image to scan: `nginx:1.16.0`
2. Scan type: Container image vulnerability assessment 
3. Output format: JSON report saved to `/root/trivy-report.json`

<details>
<summary>Solution</summary>

1. ** Perform vulnerability scan: **
```bash
trivy image --severity HIGH,CRITICAL -f json -o /root/trivy-report.json nginx:1.16.0
```{{exec}}

2. ** View scan results: **
```bash
jq . /root/trivy-report.json | less
```{{exec}}
</details>