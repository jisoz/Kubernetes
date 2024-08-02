# Kubernetes
open-source Orchestration system for Docker Containers
features: 
automated scheduling 
healing capabilities
auto upgrade and auto roll-back
horizontal scaling 
storage orchestration


# kubernetes architecture:
Cluster: The basic unit of Kubernetes is a cluster, which is a set of nodes (physical or virtual machines) that run containerized applications.

Master Node  (or control plane) : responsible for management of kubernetes cluster 
Key Components of the Master Node
API Server (kube-apiserver):

Function: Acts as the central management point of the cluster. It exposes the Kubernetes API, which is used by all components to interact with the control plane.
Interaction: All operations (e.g., creating pods, scaling applications) are performed via API requests to the API server. It validates and configures data for the API objects, including pods, services, and replication controllers.


etcd:

Function: A consistent and highly-available key-value store used as Kubernetes' backing store for all cluster data.
Interaction: Stores the entire cluster state and configuration. All changes to the cluster are recorded in etcd, which makes it crucial for the functioning of the cluster.



Scheduler (kube-scheduler):

Function: Watches for newly created pods that have no node assigned and selects a node for them to run on.
Interaction: Considers resource requirements, hardware/software/policy constraints, affinity and anti-affinity specifications, data locality, and inter-workload interference.
Controller Manager (kube-controller-manager):

Function: Runs controller processes in the background to regulate the state of the cluster.
Types of Controllers:
Node Controller: Manages node status, ensuring that the nodes are available.
Replication Controller: Ensures the correct number of pod replicas are running.
Endpoints Controller: Manages endpoint objects.
Service Account & Token Controllers: Create default accounts and tokens for new namespaces.
Interaction: Monitors the state of the cluster via the API server and makes necessary adjustments to achieve the desired state.

Cloud Controller Manager:

Function: Integrates with cloud service providers to manage cloud-specific resources.
Interaction: Includes controllers for managing nodes, routing, and cloud storage. It allows the Kubernetes cluster to interact with the cloud provider’s API to manage resources like load balancers, storage, and compute instances.



.... Key Components of Worker Nodes
Kubelet:

Function: An agent that runs on each worker node and communicates with the Kubernetes control plane.
Interaction: The kubelet ensures that the containers described in the PodSpecs are running and healthy. It registers the node with the Kubernetes API server and reports the node's status.


pods: is a group of one ore more containers with shared storage/network and a specification for how to run the containers


Container Runtime:

Function: Responsible for running containers. Docker is a common choice, but Kubernetes also supports other container runtimes like containerd, CRI-O, and rkt.
Interaction: The container runtime pulls container images from a registry, starts and stops containers, and handles container networking.
Kube-Proxy:

Function: A network proxy that runs on each worker node and maintains network rules to allow network communication to pods.
Interaction: Kube-proxy handles traffic routing for services, ensuring that requests reach the correct pod. It can use various methods such as iptables or IPVS to manage network traffic.
cAdvisor:

Function: Collects and provides metrics about resource usage and performance of containers.
Interaction: cAdvisor monitors and analyzes resource usage on each worker node, providing data to the kubelet and other monitoring systems.



# kubernetes Installation
HA DEPLOYMENT (1 master | 2 workers )
suitable for production

single Node deployment (Minikube k8s cluster)
developement and practice



********** Install Docker CE Edition **********

1. Uninstall old versions

sudo apt-get remove docker docker-engine docker.io containerd runc



2. Update the apt package index

sudo apt-get update

sudo apt-get install \    apt-transport-https \    ca-certificates \    curl \    gnupg \    lsb-release


3. Add Docker’s official GPG key:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg



4. Use the following command to set up the stable repository

echo \  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


5. Install Docker Engine

sudo apt-get updatesudo apt-get install docker-ce docker-ce-cli containerd.io


6. verify Docker version

docker --version


********** Install KubeCtl **********

1. Download the latest release

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"



2. Install kubectl

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
3. Test to ensure the version you installed is up-to-date:

kubectl version --client





********** Install MiniKube **********

1. Download Binay

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64chmod +x minikube-linux-amd64
2. Install Minikube

sudo install minikube-linux-amd64 /usr/local/bin/minikube



3. Verify Installation

minikube version



4. Start Kubernetes Cluster

sudo apt install conntracksudo minikube start --vm-driver=none


5. Get Cluster Information

kubectl config view

