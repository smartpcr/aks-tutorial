# brew update
brew update 

# manually install the following
# 1. jdk
# 2. docker
# 3. python3
# 4. nodejs
# 5. dotnet sdk

echo "installing azure cli"
brew install azure-cli
az -v  

echo "installing kubernetes-cli"
brew install kubectl

echo "installing virtualbox"
brew cask install virtualbox

echo "installing minikube"
brew cask install minikube 

echo "verifying..."
docker --version 
docker-compose --version 
docker-machine --version 
vboxManage --version
minikube version 
kubectl version --client 

echo "starting minikue..."
minikube start 
kubectl cluster-info 
kubectl get nodes 
kubectl get pods
kubectl get deployments
kubectl get services

echo "running http through deployment/pod"
kubectl run http --image=httpd
kubectl get pods 
kubectl port-forward http-78bcd64d6c-t2m7r 8002:80 &
kubectl describe pods http-78bcd64d6c-t2m7r
curl http://localhost:8002
kubectl get deployments
kubectl delete deployments http

echo "running http through service"
kubectl run http --image=httpd
kubectl expose deployment http --port=80 --type=NodePort
kubectl get service http -o yaml
curl http://192.168.99.100:32586 
kubectl delete services http 

echo "working with DNS"
minikube ssh 
# run the following in minikube
docker ps -a | grep "dns"
exit
kubectl get pods
kubectl exec busybox cat /etc/resolv.conf
# ingress
minikube addons enable ingress
kubectl create -f ./src/configs/ingress.yaml 

echo "installing helm"
brew install kubernetes-helm

echo "installing draft"
brew tap azure/draft && brew install draft
draft init 
eval $(minikube docker-env)

kubectl create -f ./helm-rbac.yaml 
helm init --service-account tiller
helm search
helm repo update

echo "installing wordpress..."
helm install stable/wordpress