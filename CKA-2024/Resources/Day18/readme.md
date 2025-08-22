# Day 18/40 - Health Probes in Kubernetes

## Check out the video below for Day18 👇

[![Day 18/40 - Health Probes in kubernetes](https://img.youtube.com/vi/x2e6pIBLKzw/sddefault.jpg)](https://youtu.be/x2e6pIBLKzw)



In Kubernetes, health probes are mechanisms the kubelet uses to check the health of your containers and ensure they’re working properly. If a container is unhealthy, Kubernetes can restart it or stop sending traffic to it until it’s ready again.


### What are probes?
- To investigate or monitor something and to take necessary actions

### What are health probes in Kubernetes?
- Health probes monitor your Kubernetes applications and take necessary actions to recover from failure
- To ensure your application is highly available and self-healing

### Type of health probes in Kubernetes
- Readiness ( Ensure application is ready)
- Liveness ( Restart the application if health checks fail)
- Startup ( Probes for legacy applications that need a lot of time to start)


  Liveness Probe

Purpose: Checks if the container is still running correctly.

If it fails → Kubernetes restarts the container.

Example use: If your app hangs or deadlocks, the liveness probe will catch it.




Readiness Probe

Purpose: Checks if the container is ready to serve requests.

If it fails → Kubernetes removes the pod from the Service endpoints, so it won’t receive traffic.

Example use: Your app might take time to load configs or connect to a DB before serving traffic.


Startup Probe

Purpose: Checks if the application has started successfully.

Useful for slow-starting apps (e.g., large Java apps).

Until it succeeds, Kubernetes won’t run liveness or readiness probes.




### Types of health checks they perform?
- HTTP/TCP/command

### Health probes

![image](https://github.com/user-attachments/assets/95f34a79-4956-4555-b33d-aeddf86653c5)

### Sample YAML

#### liveness-http and readiness-http
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/e2e-test-images/agnhost:2.40
    args:
    - liveness
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 3
    readinessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 10
```

#### liveness command

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-exec
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/busybox
    args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600
    livenessProbe:
      exec:
        command:
        - cat 
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```

#### liveness-tcp

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: tcp-pod
  labels:
    app: tcp-pod
spec:
  containers:
  - name: goproxy
    image: registry.k8s.io/goproxy:0.1
    ports:
    - containerPort: 8080
    livenessProbe:
      tcpSocket:
        port: 3000
      initialDelaySeconds: 10
      periodSeconds: 5
```
