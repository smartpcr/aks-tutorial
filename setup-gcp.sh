
curl https://sdk.cloud.google.com | bash
source ~/.bash_profile 
gcloud init 

gcloud beta container \
    --project "xiaodong-li" clusters create "cluster-1" \
    --zone "us-west1-a" \
    --username "admin" \
    --cluster-version "1.10.5-gke.0" \
    --machine-type "n1-standard-1" \
    --image-type "COS" \
    --disk-type "pd-standard" \
    --disk-size "100" \
    --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --num-nodes "3" \
    --enable-stackdriver-kubernetes \
    --network "default" \
    --subnetwork "default" \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing \
    --no-enable-autoupgrade \
    --enable-autorepair

k get nodes -o wide
k describe nodes gke-cluster-1-default-pool-31c2e698-44zt 

k run kubia --image=smartpcr/kubia --port=8001 --generator=run/v1
k get pods
k expose rc kubia --type=LoadBalancer --name kubia-http 
k get services
curl http://35.203.141.102:8001
k scale rc kubia --replicas=3
k get pods -o wide
k get rc kubia

gcloud container clusters describe cluster-1 | grep -E "(username:|password:|dashboard)"
k cluster-info | grep dashboard



gcloud container clusters delete "cluster-1"