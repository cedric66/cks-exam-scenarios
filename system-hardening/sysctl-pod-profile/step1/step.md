# Create Pod with Sysctl Parameters

## Objective
Create a new Pod named `sysctl-pod` with the image `nginx:1.23.1`. Set the sysctl parameters:
- `net.core.somaxconn` to 1024

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

1. Create a pod YAML file with the required sysctl parameters:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sysctl-pod
spec:
  securityContext:
    sysctls:
    - name: net.core.somaxconn
      value: "1024"
    - name: debug.iotrace
      value: "1"
  containers:
  - name: nginx
    image: nginx:1.23.1
```

2. Apply the pod configuration:

```bash
kubectl apply -f sysctl-pod.yaml
```{{EXEC}}

3. Verify the pod status:

```bash
kubectl get pod sysctl-pod
```{{EXEC}}

4. Check the sysctl parameters inside the pod:

```bash
kubectl exec sysctl-pod -- sysctl net.core.somaxconn debug.iotrace
```
</details>
