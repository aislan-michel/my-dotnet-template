param(
    [string]$path,
    [string]$solutionName = "Solution",
    [Parameter(Position = 0)]
    [ValidateSet('console', 'mvc')]
    [string]$Applicationtype = "console",
    [string]$ApplicationName = "Solution.App"
)

if($path -eq $null -or $path -eq "" -or $path -eq " ") {
    mkdir $solutionName

    Set-Location $solutionName
}

dotnet new sln -n $solutionName

mkdir src

Set-Location src

dotnet new $Applicationtype -n $ApplicationName

Set-Location ..

Write-Host "say cd " + $solutionName + " and start a coding"