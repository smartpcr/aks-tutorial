Import-Module .\Modules\common.psm1 -Force

if (-not (Test-IsAdmin)) {
    throw "You need to run this script as administrator"
}

# install chocolatey 
if (-not (isChocoInstalled)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    choco install firacode -Y
}

# install .net core
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

# kubectl must be installed before minikube
choco install kubernetes-cli -y

# install minikube
choco install minikube -y --force


# install docker
# follow .\modules\docker.psm1 and run step-by-step

# install heml
choco install kubernetes-helm -y

# create a hyper-v virtual network switch with name "Primary Virtual Switch" folling this link
# https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c
# stop wasting time on windows, obviously this is not worked out!
$minikubeHomeDir = "E:\minikube_home"
New-Item -Path $minikubeHomeDir -ItemType Directory -Force
$kubeExeDir = "E:\k8s"
New-Item -Path $kubeExeDir -ItemType Directory -Force
Copy-Item "C:\ProgramData\chocolatey\bin\minikube.exe" -Destination $kubeExeDir -Force
Copy-Item "C:\ProgramData\chocolatey\bin\kubectl.exe" -Destination $kubeExeDir -Force
Copy-Item "C:\ProgramData\chocolatey\bin\helm.exe" -Destination $kubeExeDir -Force
$env:Path = $env:Path + ";$kubeExeDir;"

$switchName = "Primary Virtual Switch"
setupHyperVNetworkSwitch -newVirtualSwitchName $switchName
<# Found the following command do not work well within cmder #>
$env:MINIKUBE_HOME = $minikubeHomeDir

# minikube config set WantReportErrorPrompt false (it hangs in cmder)
minikube start --vm-driver hyperv --hyperv-virtual-switch $switchName --memory=2048 --cpus=1

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