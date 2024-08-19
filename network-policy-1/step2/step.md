# Step 2: Test Network Policies by Deploying Pods

Deploy pods to test the network policies. Create a pod `test-pod-allowed` and `test-pod-denied` in the namespace `jumpbox` using image `nginx`. One pod with the label `app=jumpbox` and another pod without specifying any labels.

Try to access the pod from namespace `restricted` using both `test-pod-allowed` and `test-pod-denied` to verify the network policies.

Tips: Use kubernetes DNS to point to the Kubernetes service, something like this `<service name>.<namespace>.svc.cluster.local`

<details>
  <summary>Solution</summary>

* Create namespace: `kubectl create namespace jumpbox`

* Create pods:
```
kubectl run test-pod-allowed --image nginx -n jumpbox -l app=jumpbox
kubectl run test-pod-denied --image nginx -n jumpbox
```

* Test it:
```
kubectl exec -n jumpbox test-pod-allowed -- curl commerce-frontend.restricted.svc.cluster.local
kubectl exec -n jumpbox test-pod-denied -- curl commerce-frontend.restricted.svc.cluster.local
```

</details>