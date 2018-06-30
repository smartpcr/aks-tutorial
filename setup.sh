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