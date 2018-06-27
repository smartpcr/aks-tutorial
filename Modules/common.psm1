function isNetCoreInstalled () {
    $dotnetCmd = Get-Command dotnet 
    $isInstalled = $false
    if ($dotnetCmd) {
        $isInstalled = Test-Path($dotnetCmd.Source)
    }
    return $isInstalled
}