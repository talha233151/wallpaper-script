
# Allowed client IP addresses
$AllowedIPs = @(
    "10.120.170.106",
    "10.120.149.201"
)

# Get this computer's IPv4 address
$MyIP = Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object {
        $_.IPAddress -notlike "127.*" -and
        $_.InterfaceAlias -notlike "*Loopback*"
    } |
    Select-Object -First 1 -ExpandProperty IPAddress

if ($MyIP -notin $AllowedIPs) {
    Write-Host "This computer is not authorized."
    exit 1
}

Write-Host "Authorized client: $MyIP"

# Download and set wallpaper
$ImagePath = Join-Path $env:TEMP "wallpaper.jpg"
$ImageURL = "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1920&q=80"

Invoke-WebRequest -Uri $ImageURL -OutFile $ImagePath

Add-Type @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SystemParametersInfo(
        int action, int param, string path, int flags);
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, $ImagePath, 3) | Out-Null
Write-Host "Wallpaper updated."
