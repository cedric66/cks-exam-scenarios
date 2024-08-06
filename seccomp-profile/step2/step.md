# Step 2: Apply the Seccomp Profile to a Pod

Create a Pod named `seccomp-pod` in the namespace `seccomp-test`. Use `busybox:1.35.0` as the container image and add a `sleep` command to avoid pod being into completed state. Apply the seccomp profile to the Pod.

Of course, you need to ensure that the Pod scheduled in the respective nodes, which is having seccomp installed there.


<details>
  <summary>Solution</summary>

* Get the worker node to be used as node selector to schedule the pod: `kubectl get node --show-labels`

* Create the Pod manifest using the seccomp profile:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-pod
  namespace: seccomp-test
spec:
  nodeSelector:
    app.kubernetes.io/name: <node-name>
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: syscall-restrict.json
  containers:
  - name: secure-container
    image: busybox:1.35.0
    command: ["sh", "-c", "sleep 1d"]
```

* Apply the Pod manifest: `kubectl apply -f seccomp-pod.yaml`

* Attempt to execute a restricted syscall within the container:
```sh
kubectl exec -n seccomp-test seccomp-pod -- sh -c "cat /proc/self/status | grep Seccomp"
kubectl exec -n seccomp-test seccomp-pod -- sh -c "unshare -p"
```

</details>
