param (
    [string]$url,
    [string]$path
)

# Function to show usage
function Show-Usage {
    Write-Output "Usage: .\Apply-Kustomization.ps1 -url <AppBase-URL> -path <Example/path/here>"
    exit 1
}

# Check if both arguments are provided
if (-not $url -or -not $path) {
    Show-Usage
}

# Download the file
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sivakumar-devops/kustomization-improvement/mohamed/local/boldbi/kustomization.yaml" -OutFile "kustomization.yaml"

# Modify the file
(Get-Content -Path "kustomization.yaml") -replace '<AppBase-URL>', $url | Set-Content -Path "kustomization.yaml"
(Get-Content -Path "kustomization.yaml") -replace '<Example/path/here>', $path | Set-Content -Path "kustomization.yaml"

# Apply the kustomization
kubectl apply -k .

Write-Output "Kustomization applied successfully."
