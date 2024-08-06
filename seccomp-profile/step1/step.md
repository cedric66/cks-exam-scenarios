# Step 1: Create a Seccomp Profile

Create a seccomp profile that restricts syscalls for a container. Apply the profile to the worker node only and save as `syscall-restrict.json`

Here is the seccomp profile. SSH to the respective node.

```json
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "syscalls": [
    {
      "names": [
        "accept",
        "bind",
        "connect",
        "listen",
        "recvfrom",
        "recvmsg",
        "sendmsg",
        "sendto",
        "socket"
      ],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
```



<details>
  <summary>Solution</summary>

* Copy this seccomp profile
```json
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "syscalls": [
    {
      "names": [
        "accept",
        "bind",
        "connect",
        "listen",
        "recvfrom",
        "recvmsg",
        "sendmsg",
        "sendto",
        "socket"
      ],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
```

* Copy the profile as `syscall-restrict.json` to the Kubernetes worker node.
```sh
sudo mkdir -p /var/lib/kubelet/seccomp
sudo cp syscall-restrict.json /var/lib/kubelet/seccomp/
```

</details>
