# Step 1: Create a Network Policy to Allow Traffic from Specific Pods

Create a Network Policy called `allow-specific-pods` in the namespace `restricted`. 

There is a deployment in that namespace. The network policy should define that each Pods from that deployment can be accessed from Pods with labels `app=jumpbox` from namespace `jumpbox`. Create the namespace if necessary.

(Tips) Use this command to show pod labels: 

    ```bash
    kubectl get pod --show-labels
    ```