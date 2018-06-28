# brew update
brew update 

echo "installing azure cli"
brew install azure-cli
az version 

echo "installing kubernetes-cli"
brew install kubectl

echo "installing minikube"
brew cask install minikube 
minikube version 
minikube start 
kubectl get pods

echo "installing helm"
brew install kubernetes-helm