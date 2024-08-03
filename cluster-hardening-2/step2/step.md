# Step 2: Assign ClusterRole and RoleBinding to the Service Account

Create a Cluster Role with name `secret-list` to the resources `secrets` and verb `get, list`. Bind the ClusterRole to the `api-call` service account that only allows the operation needed by the Pod. 

Check the logs of the `service-list` Pod again to verify. You shall see a changes in the logs against the previous step.

<details>
  <summary>Solution</summary>

* Create a ClusterRole that allows listing services:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: list-services
rules:
- apiGroups: [""]
  resources: ["services"]
  verbs: ["get", "list"]
```

* Create a RoleBinding to bind the ClusterRole to the service account:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: list-services-binding
  namespace: t23
subjects:
- kind: ServiceAccount
  name: api-call
  namespace: t23
roleRef:
  kind: ClusterRole
  name: list-services
  apiGroup: rbac.authorization.k8s.io
```

* Apply the ClusterRole and RoleBinding manifests:
```sh
kubectl apply -f list-services-clusterrole.yaml
kubectl apply -f list-services-rolebinding.yaml
```

* Check the logs of the `service-list` Pod again: `kubectl logs -f secret-list -n secure-api`

After applying the correct permissions, the curl command in the Pod should list all secrets in the default namespace without authorization errors.
</details>