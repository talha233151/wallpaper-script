
$imageUrl = "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1920&q=80"
$imagePath = Join-Path $env:TEMP "wallpaper.jpg"

Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SystemParametersInfo(
        int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$result = [Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 3)

if ($result) {
    Write-Host "Wallpaper changed successfully!"
} else {
    Write-Host "Failed to change wallpaper."
}
