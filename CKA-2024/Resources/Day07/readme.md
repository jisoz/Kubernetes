## Check out the task.md file for day07 task details

## Different ways of creating a Kubernetes object
- Imperative way ( Through command or API calls)
- Declarative way ( By creating manifest files)

![image](https://github.com/piyushsachdeva/CKA-2024/assets/40286378/b038c4d3-87b7-474d-a3aa-5983d978f885)


## Below is the sample pod YAML used in the video:

```YAML
# This is a sample pod yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    env: demo
    type: frontend
spec:
  containers:
  - name: nginx-container
    image: nginx
    ports:
    - containerPort: 80
```

## kubectl  explain pod -> explain
## kubectl delete pod nginx-pod -> delete the pod
## kubectl apply -f pod.yaml -> apply the yaml file 
## kubectl get pods -> get all pods 
## kubectl describe pod nginx-pod  -> get more info and troubleshoot 
## kubectl edit pod nginx-pod
## kubectl exec -it nginx-pod  --sh -> ener inside the pod 
## kubectl get pods --show-labels
## kubeectl get pods -o wide 
## kubectl get nodes 
