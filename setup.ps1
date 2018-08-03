Import-Module .\Modules\common.psm1 -Force

# install chocolatey 
if (-not (isChocoInstalled)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# install .net core
$ErrorAc
if (-not (isNetCoreInstalled)) {
    $netSdkDownloadLink = "https://download.microsoft.com/download/D/0/4/D04C5489-278D-4C11-9BD3-6128472A7626/dotnet-sdk-2.1.301-win-gs-x64.exe"
    $tempFile = "C:\users\$env:username\downloads\dotnetsdk.exe"
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($netSdkDownloadLink, $tempFile)
    Start-Process $tempFile -Wait 
    Remove-Item $tempFile -Force 
}

if (-not (isAzureCliInstalled)) {
    $azureCliDownloadLink = "https://aka.ms/installazurecliwindows"
    $tempFile = "C:\users\$env:username\downloads\azcli.msi"
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($azureCliDownloadLink, $tempFile)
    Start-Process $tempFile -Wait 
    Remove-Item $tempFile -Force 

    <# or use choco to install 
    choco install azure-cli -y
    #>
}

# install minikube
choco install minikube -y
choco install kubernetes-cli -y

# install docker
# follow .\modules\docker.psm1 and run step-by-step

# install heml
choco install kubernetes-helm -y

# create a hyper-v virtual network switch with name "Primary Virtual Switch" folling this link
# https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c

$env:MINIKUBE_HOME = "E:/"
minikube start --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch"

# create mvc app 
Invoke-Expression "dotnet new mvc --name build2018" 

# draft 
Set-Location ".\build2018"
Invoke-Expression "..\util\draft\draft init"
Invoke-Expression "..\util\draft\draft create"

<# 
    if 8080 connection refused, run 
    kubectl -n kube-system delete deploy tiller-deploy
    helm init --service-account default
#>
Invoke-Expression "helm init --service-account default"