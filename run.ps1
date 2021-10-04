$LASTEXITCODE = 0
$ErrorActionPreference = "Stop"

Push-Location $psscriptroot
Write-Host $psscriptroot
try {
    $pathExists = Test-Path "$psscriptroot/.venv/"
    if ($pathExists -eq $False) {
        Write-Host "Creating virtual environment"
        python -m pip install --upgrade virtualenv
        python -m venv .venv
        if ($LASTEXITCODE -ne 0) { throw "Python failed" }
    }
    Get-ChildItem .

    if ($PSVersionTable.Platform -eq "Unix") {
        &.\.venv\bin\Activate.ps1
    }
    else {
        &.\.venv\Scripts\Activate.ps1
    }
    if ($LASTEXITCODE -ne 0) { throw "Venv activate failed" }

    python -m pip install --upgrade pip setuptools wheel twine bandit sphinx pytest pytest-mock pytest-cov black
    if ($LASTEXITCODE -ne 0) { throw "python pip install failed" }

    pip install -r ./requirements.txt
    if ($LASTEXITCODE -ne 0) { throw "python pip requirements install failed" }
}
finally {
    Pop-Location
}