param(
    [string]$path,
    [string]$solutionName = "Solution",
    [string]$applicationName = "Solution.App",
    [Parameter(Position = 0)]
    [ValidateSet('console', 'mvc', 'webapp', 'classlib')]
    [string]$applicationType = "console",
    [switch]$sqlFolder,
    [switch]$gitignore,
    [switch]$help
)

try {
    if($help.IsPresent){
        write-host "
        ### parameters

        -path, the local of project is created
        -solutionName, name of solution the default value is Solution
        -applicationName, name of application the default value is Solution.App
        -applicationType, type of application (mvc, console ...)
        -sqlFolder, create sql folder in src
        -gitignore, execute 'dotnet new gitignore' in solution folder

        -help / -h for this
        "

        return
    }

    if(![string]::IsNullOrWhiteSpace($path)) {
        Set-Location $path
    }
    
    mkdir $solutionName
    
    Set-Location $solutionName
    
    git init
    
    dotnet new sln -n $solutionName
    
    mkdir src
    
    if($sqlFolder.IsPresent){
        mkdir sql
    }
    
    Set-Location src
    
    dotnet new $applicationType -n $applicationName
    
    Set-Location ..
    
    $csprojFilePath = "src/${applicationName}/${applicationName}.csproj"
    dotnet sln add $csprojFilePath
    
    if($gitignore.IsPresent){
        git rm -r --cached .
    
        dotnet new gitignore
    }
    
    git add .
    git commit -m 'create solution'
}
catch {
    Write-Host "An error occurred:"
    Write-Host $_.ScriptStackTrace
    #todo: log errors
}
finally {
    write-host "`r`npress any key to continue.."
    [Console]::ReadKey()
}
