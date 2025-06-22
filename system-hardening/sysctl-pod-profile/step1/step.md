# Create Pod with Sysctl Parameters

## Objective
Create a new Pod named `sysctl-pod` with the image `nginx:1.23.1`. Set the sysctl parameters:
- `net.core.somaxconn` to 1024.

You may need to configure kubelet to allow the unsafe syctl.

After creating the pod, check its status.

## Configuration
- Pod Name: sysctl-pod
- Namespace: default
- Image: nginx:1.23.1
- Sysctl Parameters:
  - net.core.somaxconn: 1024

## Solution
<details>
<summary>Click to expand solution</summary>

1. Configure the kubelet to allow the unsafe sysctl by editing its config:
```bash
# Add or update allowedUnsafeSysctls in kubelet config
sudo echo 'allowedUnsafeSysctls: ["net.core.somaxconn"]' >> /var/lib/kubelet/config.yaml
```{{exec}}

Wait 60 seconds for the kubelet to restart (check with `systemctl status kubelet`)

2. Create a pod YAML file with the required sysctl parameters:

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: sysctl-pod
spec:
  securityContext:
    sysctls:
    - name: net.core.somaxconn
      value: "1024"
  containers:
  - name: nginx
    image: nginx:1.23.1
EOF
```{{exec}}

3. Verify the pod status:

```bash
kubectl get pod sysctl-pod
```{{exec}}

4. Check the sysctl parameters inside the pod:

```bash
kubectl exec sysctl-pod -- apt-get update && apt-get install -y procps; sysctl net.core.somaxconn
```{{exec}}

</details>
