code#read all the steps carefully before running the script  
#cloning the project of automation in your desktop 
#git clone git@gitlab.bluemint.ai:devops_bluemint/notary_deployment_automated.git  cd /notary_deployment_automated 
#chmod +x cluster.sh  create.sh
# ./cluster.sh   (before running you need to change some variables based on your case )
PROJECT_ID="projectsbm"
ZONE_NAME="bluemint"
DNS_NAME="gcp.bluemint.ai"
#gcloud auth login   #manually to login to google cloud 
#create your project on google cloud 
gcloud projects create $PROJECT_ID

#link it to billing account
gcloud beta billing projects link $PROJECT_ID --billing-account=01AC1C-B51CA2-B14879  #(you can see the billing id in billing section)


#make your  project the active one
gcloud config set project $PROJECT_ID

#to check 
gcloud config get-value project

#to make credentials.json to use for externaldns
gcloud iam service-accounts create my-service-account --display-name "My Service Account"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:my-service-account@$PROJECT_ID.iam.gserviceaccount.com"     --role="roles/dns.admin"
gcloud iam service-accounts keys create ~/.secrets/certbot/google.json --iam-account=my-service-account@$PROJECT_ID.iam.gserviceaccount.com     #you will use it in external dns this google.json credentials


#make a dns zone pointing to gcp.bluemint.ai 
#1-)enable "Google Cloud DNS API" for creating the dns zone
gcloud services enable dns.googleapis.com --project=$PROJECT_ID
# Set your project ID and DNS zone name


# Create the DNS zone
gcloud dns managed-zones create $ZONE_NAME \
    --dns-name=$DNS_NAME \
    --description="DNS Zone" \
    --project=$PROJECT_ID \
    --dnssec-state=on

#you need to register this domain in namecheap and pointing to the google cloud servers you can find it in the dns zone that you have created (type NS)





#for wildcardingress
#installation certbot
sudo dnf install certbot
sudo dnf install python3-certbot-dns-google
pip3 install certbot-nginx
#install the certificate for our domain
sudo certbot certonly --dns-google --dns-google-credentials ~/.secrets/certbot/google.json -d *.dev-notary.gcp.bluemint.ai
#cp certificate to a /tmp dir
mkdir /tmp/gcpbluemint/notarydev
sudo cp /etc/letsencrypt/live/dev-notary.gcp.bluemint.ai/privkey.pem /tmp/gcpbluemint/notarydev


sudo cp /etc/letsencrypt/live/dev-notary.gcp.bluemint.ai/fullchain.pem /tmp/gcpbluemint/notarydev

sudo chmod +rxw /tmp/gcpbluemint/notarydev/privkey.pem 
sudo chmod +rxw /tmp/gcpbluemint/notarydev/fullchain.pem 







chmod +x create.sh 
./create.sh










