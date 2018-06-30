az login
az account list --output table 
az account set --subscription xiaodoli

az group delete -n xdK8S - y

az group create --name xdK8S --location eastus
# this can take 30 min!! Go grab a coffee.
az aks create \
    --resource-group xdK8S \
    --name xdK8SCluster \
    --generate-ssh-keys \
    --dns-name-prefix xdli \
    --node-count 3 \
    --node-vm-size Standard_DS1

# if see error No module named '_cffi_backend'
# run `brew link --overwrite python3`

az aks get-credentials --resource-group
