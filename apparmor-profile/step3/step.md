# Step 3: Configure Network Access in AppArmor Profile

In this step, we'll configure network access permissions in our AppArmor profile.

1. Edit your AppArmor profile (usually located in /etc/apparmor.d/)
2. Add the following network-related permissions:

```bash
network inet,
network inet6,
```

3. These permissions allow:
   - IPv4 network access (inet)
   - IPv6 network access (inet6)

4. Save the profile and reload AppArmor:
```bash
sudo apparmor_parser -r /etc/apparmor.d/your_profile
```

5. Verify the profile is loaded:
```bash
sudo aa-status
```

This configuration provides basic network access while still maintaining security through AppArmor's mandatory access controls.
