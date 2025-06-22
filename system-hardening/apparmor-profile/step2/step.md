Create an AppArmor profile that controls network access and apply it to a Kubernetes pod with the following configuration:

```
#include <tunables/global>

profile restrict-network {
   #include <abstractions/base>
   /bin/sleep ix,
   /bin/ping ix,

   # Block IPv4 and IPv6 networking
   deny network inet,
   deny network inet6,

   # Block raw socket access
   deny network raw,
}
```

Create a pod with these details:
- Pod name: `restrict-network-pod`
- Namespace: `apparmor`
- Image: `busybox`
- Command: `sleep 1d`

You will need to apply the apparmor profile to the pod and verify that the container has no network connectivty.

<details>
  <summary>Solution</summary>

1. **Create the AppArmor profile**:

```bash
sudo tee /etc/apparmor.d/restrict-network-profile <<EOF
#include <tunables/global>

profile restrict-network {
  #include <abstractions/base>
  /bin/sleep ix,
  /bin/ping ix,

  # Block IPv4 and IPv6 networking
  deny network inet,
  deny network inet6,

  # Block raw socket access
  deny network raw,
}
EOF
```{{exec}}

2. **Load the AppArmor profile**:

```bash
sudo apparmor_parser -r /etc/apparmor.d/restrict-network-profile
```{{exec}}

3. **Create a Kubernetes pod with the profile**:

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: restrict-network-pod
  namespace: apparmor
spec:
  securityContext:
    appArmorProfile:
      type: Localhost
      localhostProfile: restrict-network
  containers:
  - name: restrict-network-container
    image: busybox
    command: ["sh", "-c", "sleep 1d"]
EOF
```{{exec}}

4. **Verify Pod Status**:
```bash
kubectl get pod -n apparmor restrict-network-pod
```{{exec}}

5. **Check AppArmor Profile Status**:
```bash
sudo apparmor_status restrict-network
```{{exec}}

6. **Test Network Access**:
```bash
kubectl exec -n apparmor restrict-network-pod -- ping -c 1 google.com
```{{exec}}

7. **Check Network Access Logs**:
```bash
kubectl logs -n apparmor restrict-network-pod
```{{exec}}

</details>
