# Step 1: Create a Seccomp Profile

Create a seccomp profile that audit all activities from a container. Apply the profile to the controlplane node and save as `seccomp-audit.json` under the seccomp profile directory `/var/lib/kubelet/seccomp/profiles`

Here is the seccomp profile. SSH to the respective node.

```
{
    "defaultAction": "SCMP_ACT_LOG"
}
```{{copy}}

<details>
  <summary>Solution</summary>

* Copy the profile as `seccomp-audit.json` to the Kubernetes worker node.
```bash
sudo mkdir -p /var/lib/kubelet/seccomp/profiles
sudo cp seccomp-audit.json /var/lib/kubelet/seccomp/profiles/
```{{exec}}

</details>
