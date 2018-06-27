Import-Module .\Modules\common.psm1

# install .net core
if (-not (isNetCoreInstalled)) {
    $netSdkDownloadLink = "https://download.microsoft.com/download/D/0/4/D04C5489-278D-4C11-9BD3-6128472A7626/dotnet-sdk-2.1.301-win-gs-x64.exe"
    $tempFile = "C:\users\$env:username\downloads\dotnetsdk.exe"
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($netSdkDownloadLink, $tempFile)
    Start-Process $tempFile -Wait 
    Remove-Item $tempFile -Force 
}

# create mvc app 
Invoke-Expression "dotnet new mvc --name build2018" 

# draft 
Set-Location ".\build2018"
Invoke-Expression "..\util\draft\draft create"