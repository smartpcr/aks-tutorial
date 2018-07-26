# Enable-WindowsOptionalFeature -Online -FeatureName containers -All
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Invoke-WebRequest https://dl.bintray.com/docker-compose/master/docker-compose-Windows-x86_64.exe -UseBasicParsing -OutFile $env:ProgramFiles\docker\docker-compose.exe
Restart-Computer -Force

function Set-DockerDataFolder {
    param (
        [string] $newDockerDataFolder = "E:\ProgramData\docker"
    )
    # move docker image folder to E drive
    Stop-Service Docker

    $defaultDockerDataFolder = "C:\ProgramData\docker"
    New-Item $newDockerDataFolder -ItemType Directory -Force
    if (Test-Path $defaultDockerDataFolder) {
        # some files are locked, may need to manually copy over
        Copy-Item -Path $defaultDockerDataFolder -Destination $newDockerDataFolder -Force -Recurse
        Move-Item $defaultDockerDataFolder "C:\ProgramData\docker.old"
    }
    New-Item -Path $defaultDockerDataFolder -ItemType SymbolicLink -Value $newDockerDataFolder

    Restart-Service Docker
}

Set-DockerDataFolder

Write-Host "Pull common base images..."
Docker pull microsoft/windowsservercore

Write-Host "Remove any nat settings, which causes docker-compose HNS errors..."
Get-NetNat | Remove-NetNat -Confirm