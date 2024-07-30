# change the specific variables based on your project
GKE_PID="projectsbm"
CLUSTER_NAME="notary-cluster"
ZONE="europe-west1-b"
REGION="europe-west1"
CLUSTER_VERSION="1.27.3-gke.100"
MACHINE_TYPE="e2-standard-2"
DISK_SIZE="100"
NUM_NODES="4"
#enable gke api
gcloud services enable container.googleapis.com --project=$GKE_PID
#creating the cluster in the project
gcloud beta container --project $GKE_PID clusters create $CLUSTER_NAME --zone $ZONE --no-enable-basic-auth --cluster-version $CLUSTER_VERSION --release-channel "None" --machine-type $MACHINE_TYPE --image-type "COS_CONTAINERD" --disk-type "pd-standard" --disk-size $DISK_SIZE --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --max-pods-per-node "110" --num-nodes $NUM_NODES --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias --network "projects/$GKE_PID/global/networks/default" --subnetwork "projects/$GKE_PID/regions/$REGION/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations $ZONE

sleep 5

#configure the local kubectl command-line tool to access a Google Kubernetes Engine (GKE) cluster.
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE


#create namespace named notar-dev and make a secret for storing the credentials of our docker registrey
kubectl create ns notary-dev
kubectl create secret docker-registry regcrednotary --docker-server=registry.do.bluemint.ai --docker-username=whjazzar --docker-password=bluemint123 -n notary-dev
#create secret on kubernetes for wildcard ingress
kubectl create secret tls tls-secret-wildstar-front --key /tmp/gcpbluemint/notarydev/privkey.pem --cert /tmp/gcpbluemint/notarydev/fullchain.pem -n notary-dev

cp ~/.secrets/certbot/google.json helm/external-dns/credentials.json  



cd helm/external-dns

# sed -i 's/gcp\.bluemint\.ai/bst\.bluemint\.ai/g' values.yaml

chmod +x setup.sh process.sh create.sh
./setup.sh
./process.sh
./create.sh

#need to change 
cd -

cd helm/ingress-nginx
chmod +x setup.sh certmanager.sh create.sh
./setup.sh
./certmanager.sh
./create.sh 
cd -



cd kubernetes-dashboard
chmod +x dashbord.sh              
./dashbord.sh
# #_
cd -


cd deployments/dev/back
kubectl apply -f deployment.yaml -n notary-dev
kubectl apply -f services.yaml -n notary-dev
kubectl apply -f ingress.yaml -n notary-dev   #websocket

cd -

cd deployments/dev/front
kubectl apply -f deployment.yaml -n notary-dev
kubectl apply -f services.yaml -n notary-dev
# kubectl apply -f ingress.yaml -n notary-dev 
kubectl apply -f wildcardingress.yaml  -n notary-dev  

cd -
cd deployments/dev/selinon
kubectl apply -f deployment1.yaml -n notary-dev                                     
kubectl apply -f deplyment2.yaml -n notary-dev

cd -

cd helm/argo-cd/
chmod +x create.sh setup.sh apply-apps.sh
./setup.sh
./create.sh
./apply-apps.sh                  

cd -

cd helm/postgres
chmod +x setup.sh create.sh
./setup.sh
./create.sh


cd -

cd helm/rabbitmq
chmod +x create.sh  setup.sh
./setup.sh
./create.sh

cd - 

cd helm/redis
chmod +x create.sh  setup.sh
./setup.sh
./create.sh

cd helm/minio