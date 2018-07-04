function isNetCoreInstalled () {
    try {
        $dotnetCmd = Get-Command dotnet 
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
        $azCmd = Get-Command az 
        if ($azCmd) {
            return Test-Path $azCmd.Source 
        }
    }
    catch {}
    return $false 
}