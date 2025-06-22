# Customize Falco Output Fields

In this step, you will modify Falco's default output fields to include only specific information in the logs.

## Task

Modify the Falco output format to only include the following fields in syslog:
- time
- priority
- rule
- output

## Instructions

1. Create a custom config file at `/etc/falco/falco.yaml` with these settings:

```yaml
# Output section should look like:
time_format_iso_8601: true

outputs:
  syslog:
    enabled: true
    keep_alive: false
    priority: notice
    output_fields:
      - time
      - priority 
      - rule
      - output
```

2. Restart the Falco service to apply changes:
```bash
systemctl restart falco
```{EXEC}

3. Verify the changes are applied by checking syslog:
```bash
tail -f /var/log/syslog | grep falco
```{EXEC}

The output should now only show the specified fields. For example:
```
2024-02-25T08:30:00.000000000+0000 Notice Rule=File below /etc opened for writing Output=File /etc/passwd opened for writing by process true (user=root command=touch /etc/passwd)
```

Note: The actual format may vary slightly, but should only contain the specified fields.