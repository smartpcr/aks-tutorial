# Enable-WindowsOptionalFeature -Online -FeatureName containers -All
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Invoke-WebRequest https://dl.bintray.com/docker-compose/master/docker-compose-Windows-x86_64.exe -UseBasicParsing -OutFile $env:ProgramFiles\docker\docker-compose.exe
Restart-Computer -Force


Stop-Service Docker
$dockerDataRoot = "E:\ProgramData\docker"
$linkDir = "C:\ProgramData\docker"
New-Item $dockerDataRoot -ItemType Directory -Force

if (Test-Path $linkDir) {
    Copy-Item -Path $linkDir -Destination $dockerDataRoot -Force -Recurse
    Move-Item $linkDir "C:\ProgramData\docker.old"
}

New-Item -Path $linkDir -ItemType SymbolicLink -Value $dockerDataRoot

Restart-Service Docker

Write-Host "Pull common base images..."
Docker pull microsoft/windowsservercore

Write-Host "Remove any nat settings, which causes docker-compose HNS errors..."
Get-NetNat | Remove-NetNat -Confirm