param(
    [string]$path,
    [string]$solutionName = "Solution",
    [string]$applicationName = "Solution.App",
    [Parameter(Position = 0)]
    [ValidateSet('console', 'mvc')]
    [string]$applicationtype = "console"
)

if($path -eq $null -or $path -eq "" -or $path -eq " ") {
    mkdir $solutionName

    Set-Location $solutionName
}else{
    Set-Location $path

    mkdir $solutionName

    Set-Location $solutionName
}

git init

dotnet new sln -n $solutionName

mkdir src

Set-Location src

dotnet new $applicationtype -n $applicationName

Set-Location ..

Write-Host "say cd " $solutionName " and start a coding"