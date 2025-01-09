# Objective 3: Deny all Network Access

Create an AppArmor profile that controls network access and apply it to a Kubernetes pod with the following configuration:

```
#include <tunables/global>

profile restrict-network {
   #include <abstractions/base>

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

      # Block IPv4 and IPv6 networking
      deny network inet,
      deny network inet6,

      # Block raw socket access
      deny network raw,
   }
   EOF
   ```{{COPY}}

2. **Load the AppArmor profile**:

   ```bash
   sudo apparmor_parser -r /etc/apparmor.d/restrict-network-profile
   ```{{COPY}}

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
   ```{{COPY}}

4. **Test network access**:

   ```bash
   kubectl exec -n apparmor restrict-network-pod -- ping -c 1 google.com
   ```{{COPY}}

</details>