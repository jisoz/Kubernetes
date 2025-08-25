# Day 29/40 Kubernetes Volume Simplified | Persistent Volume, Persistent Volume Claim & Storage Class

## Check out the video below for Day29 👇

[![Day 29/40 Kubernetes Volume Simplified | Persistent Volume, Persistent Volume Claim & Storage Class ](https://img.youtube.com/vi/2NzYX8_lX_0/sddefault.jpg)](https://youtu.be/2NzYX8_lX_0)

### How they are related to each other

![image](https://github.com/user-attachments/assets/dfe93e1e-e5d2-447a-a3da-ee2391b1b73a)

### Example snippet of non-persistent volume , type:emptydir

```yaml
volumeMounts:
    - name: redis-storage
      mountPath: /data/redis
  volumes:
  - name: redis-storage
    emptyDir: {}
```
In Kubernetes, PersistentVolumes (PVs) support different access modes that define how a volume can be mounted by Pods. These modes are important because they control whether multiple Pods can read/write from the same storage and whether those Pods can be on the same or different nodes.

Here are the main Access Modes:

1. ReadWriteOnce (RWO)

📌 Definition: The volume can be mounted as read-write by a single node.

✅ Use case: Most common mode for databases like MySQL, PostgreSQL, MongoDB.

⚠️ Limitation: Only one node can mount it at a time, but multiple pods on the same node can share it.

2. ReadOnlyMany (ROX)

📌 Definition: The volume can be mounted as read-only by many nodes simultaneously.

✅ Use case: Shared configuration files, reference data, ML model weights that don’t need modification.

⚠️ Limitation: No writes allowed, only reading.

3. ReadWriteMany (RWX)

📌 Definition: The volume can be mounted as read-write by many nodes at the same time.

✅ Use case: Shared file systems like NFS, CephFS, or cloud storage (e.g., Azure Files, EFS in AWS).

⚠️ Limitation: Requires storage backend that supports multi-writer mounts.

4. ReadWriteOncePod (RWOP) (Kubernetes v1.22+)

📌 Definition: The volume can be mounted as read-write by a single pod only (even if multiple pods are on the same node).

✅ Use case: Strong isolation — useful for workloads where data corruption risks exist if multiple pods write simultaneously.

⚠️ Limitation: Stricter than RWO.

Quick Summary Table
Mode	Multiple Pods on Same Node?	Across Multiple Nodes?	Read/Write
RWO	Yes	No	RW
ROX	Yes	Yes	Read-only
RWX	Yes	Yes	RW
RWOP	No (1 Pod only)	No	RW



### Sample pv used in the demo

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: standard
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/home/ubuntu/day28-storage-k8s"
```

### Sample PVC used in the demo

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
```

### Sample pod yaml used in the demo

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage
```


