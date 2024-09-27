## Task 8/40


In this exercise, you will create a Deployment with multiple replicas. After inspecting the Deployment, you will update its Pod template. You will also be able to use the rollout history to roll back to a previous revision.

> [!NOTE]
> If you do not already have a Kubernetes cluster, you can create a local Kubernetes cluster by following [Day06 Video](https://youtu.be/RORhczcOrWs)


## Replicaset
### Create a new Replicaset based on the nginx image with 3 replicas
-  create nginx-replicaset.yaml
 ```YAML
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
  labels:
    app: nginx
spec:
  replicas: 3  # Specifies 3 replicas
  selector:
    matchLabels:
      app: nginx  # Ensure this matches the pod template labels
  template:
    metadata:
      labels:
        app: nginx  # Label of the pods
    spec:
      containers:
      - name: nginx
        image: nginx:latest  # Nginx image
        ports:
        - containerPort: 80

  ```
####  Update the replicas to 4 from the YAML
- Edit the nginx-replicaset.yaml file and change the replicas field from 3 to 4:
  ```YAML
   spec:
  replicas: 4  # Change replicas from 3 to 4



  ```

#### Update the replicas to 6 from the command line  
```CMD
 kubectl scale rs/nginx-replicaset --replicas=6


```
  


## Deployment
###  Create a Deployment named `nginx` with 3 replicas. The Pods should use the `nginx:1.23.0` image and the name `nginx`. The Deployment uses the label `tier=backend`. The Pod template should use the label `app=v1`.

```YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx  # Deployment name
  labels:
    tier: backend  # Label for the Deployment
spec:
  replicas: 3  # Number of pod replicas
  selector:
    matchLabels:
      app: v1  # Label used for selecting pods
  template:
    metadata:
      labels:
        app: v1  # Pod template label
    spec:
      containers:
      - name: nginx  # Container name
        image: nginx:1.23.0  # Nginx container image version
        ports:
        - containerPort: 80  # Expose port 80
```

### List the Deployment and ensure the correct number of replicas is running.

```
kubectl get deployments
kubectl get rs

```

### Update the image to `nginx:1.23.4`

- Directly from yaml file
- from cmd -> kubectl set image deployment/nginx nginx=nginx:1.23.4
check the update :
- Check rollout status:
1. kubectl rollout status deployment/nginx
2. Verify pods: kubectl get pods -l app=v1 -o wide
3. Inspect a pod: kubectl describe pod <pod-name>
4. Check rollout history (optional): kubectl rollout history deployment/nginx


### Assign the change cause "Pick up patch version" to the revision.
``` 
kubectl annotate deployment nginx kubernetes.io/change-cause="Pick up patch version"
kubectl rollout history deployment/nginx

 ```

###  Scale the Deployment to 5 replicas.

```  kubectl scale deployment/nginx --replicas=5 ```

### Have a look at the Deployment rollout history.

``` kubectl rollout history deployment/nginx ```


### Revert the Deployment to revision 1.
```
kubectl rollout undo deployment/nginx --to-revision=1

```


### Ensure that the Pods use the image `nginx:1.23.0`.
kubectl get pods -l app=v1 -o wide















## Blog Post Focus 📝

- **Clarity is essential**: Write your blog post clearly and concisely, making it easy for anyone to grasp the concepts, regardless of their prior Kubernetes experience.

