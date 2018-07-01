az login
az account list --output table 
az account set --subscription xiaodoli

az group delete -n xdK8S - y

az group create --name xdK8S --location eastus
# this took >30 min!! Go grab a coffee.
az aks create \
    --resource-group xdK8S \
    --name xdK8SCluster \
    --generate-ssh-keys \
    --dns-name-prefix xdli \
    --node-count 3 \
    --node-vm-size Standard_DS1

# if see error No module named '_cffi_backend'
# run `brew link --overwrite python3`

# retrieves kubeconfig info from cluster and merges into current kubeconfig on local machine
# if you have vs code extension installed, you can browse into node/pod/service/rc (nice!)
az aks get-credentials -n xdK8SCluster -g xdK8S

# creates a proxy tunnel and open dashboard (note: it's using port 8001)
az aks browse -g xdK8S -n xdK8SCluster &

# set nodes count to desired number (this took ~10 min, super slow!!)
az aks scale -n xdK8SCluster -g xdK8S -c 10 
az aks scale -n xdK8SCluster -g xdK8S -c 2

# shows current control plane and agent pool version, available upgrade versions
# az aks get-versions -n xdK8SCluster -g xdK8S --location eastus

# upgrades
az aks upgrade -n xdK8SCluster -g xdK8S -k 1.9.6