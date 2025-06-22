In this step, we'll configure capability restrictions in our AppArmor profile to limit what privileged operations the container can perform.

1. Edit your AppArmor profile (usually located in /etc/apparmor.d/)
2. Add the following capability restrictions:

```bash
deny capability,
```

3. Optionally, you can allow specific capabilities while denying others:

```bash
capability net_bind_service,
deny capability,
```

4. Common capabilities to consider:
   - `net_bind_service`: Bind to privileged ports (<1024)
   - `sys_admin`: System administration operations
   - `sys_module`: Load/unload kernel modules
   - `dac_override`: Bypass file permission checks

5. Save the profile and reload AppArmor:
```bash
sudo apparmor_parser -r /etc/apparmor.d/your_profile
```

6. Verify the profile is loaded:
```bash
sudo aa-status
```

This configuration provides granular control over what privileged operations the container can perform.
