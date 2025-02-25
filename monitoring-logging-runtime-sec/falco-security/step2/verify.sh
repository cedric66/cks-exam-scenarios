#!/bin/bash

# Trigger a Falco event by writing to /etc/passwd
touch /etc/passwd 2>/dev/null

# Wait for Falco to process the event
sleep 2

# Get the latest Falco log entry
LATEST_LOG=$(tail -n 1 /var/log/syslog | grep falco)

# Check if log contains only required fields
if [[ ! $LATEST_LOG =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*[[:space:]]+(Notice|Warning|Error)[[:space:]]+Rule=.*[[:space:]]+Output=.* ]]; then
    echo "Falco output format is incorrect. Expected format with only time, priority, rule, and output fields"
    exit 1
fi

# Check if log contains any unexpected fields
UNEXPECTED_FIELDS=("proc.name" "container.id" "k8s.ns" "fd.name")
for field in "${UNEXPECTED_FIELDS[@]}"; do
    if [[ $LATEST_LOG == *"$field="* ]]; then
        echo "Found unexpected field: $field in Falco output"
        exit 1
    fi
done

# Verify Falco config has correct output fields
if ! grep -q "output_fields:" /etc/falco/falco.yaml || \
   ! grep -q "  - time" /etc/falco/falco.yaml || \
   ! grep -q "  - priority" /etc/falco/falco.yaml || \
   ! grep -q "  - rule" /etc/falco/falco.yaml || \
   ! grep -q "  - output" /etc/falco/falco.yaml; then
    echo "Falco configuration is missing required output fields"
    exit 1
fi

exit 0