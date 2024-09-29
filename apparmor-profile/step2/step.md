# Objective 2: Block chmod Execution

The second objective is to block the execution of `chmod` commands within the container. The custom AppArmor profile already denies this operation. You will now apply this profile to another Pod and verify that the `chmod` command is blocked.


<details>
  <summary>Solution</summary>

1. **Create the Pod Manifest**:
   Create a YAML file named `block-chmod-pod.yaml` with the following content:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: block-chmod-pod
     namespace: apparmor-test
     annotations:
       container.apparmor.security.beta.kubernetes.io/block-chmod-container: localhost/deny-write-profile
   spec:
     containers:
     - name: block-chmod-container
       image: busybox
       command: ["sh", "-c", "chmod 777 /tmp"]

</details>
