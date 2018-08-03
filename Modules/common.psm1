function isNetCoreInstalled () {
    try {
        $dotnetCmd = Get-Command dotnet -ErrorAction SilentlyContinue
        $isInstalled = $false
        if ($dotnetCmd) {
            $isInstalled = Test-Path($dotnetCmd.Source)
        }
        return $isInstalled
    }
    catch {
        return $false 
    }
}

function isAzureCliInstalled() {
    try {
        $azCmd = Get-Command az -ErrorAction SilentlyContinue
        if ($azCmd) {
            return Test-Path $azCmd.Source 
        }
    }
    catch {}
    return $false 
}

function isChocoInstalled() {
    try {
        $chocoVersion = Invoke-Expression "choco -v" -ErrorAction SilentlyContinue
        return ($chocoVersion -ne $null)
    }
    catch {}
    return $false 
}

function setupHyperVNetworkSwitch($newVirtualSwitchName) {
    $existingSwitchFound = Get-VMSwitch -Name $newVirtualSwitchName -ErrorAction SilentlyContinue
    if (!$existingSwitchFound) {
        New-VMSwitch -Name $newVirtualSwitchName -NetAdapterName "Ethernet" -AllowManagementOS $true 
    }
}

function Test-IsAdmin {
    $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp = new-object System.Security.Principal.WindowsPrincipal($wid)
    $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $isAdmin = $prp.IsInRole($adm)
    return $isAdmin
}
