# Step 2: Test Network Policies by Deploying Pods

Deploy pods to test the network policies. Create a pod `test-pod-allowed` and `test-pod-denied` in the namespace `jumpbox` using image `nginx`. One pod with the label `app=jumpbox` and another pod without specifying any labels.

Try to access the pod from namespace `restricted` using both `test-pod-allowed` and `test-pod-denied` to verify the network policies.

Tips: Use kubernetes DNS to point to the Kubernetes service, something like this `<service name>.<namespace>.svc.cluster.local`