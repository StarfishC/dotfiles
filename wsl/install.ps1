if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) {
    Exit
}

$cpath = Split-Path $MyInvocation.MyCommand.Path
$file_name = "wslconfig"
$wslconfig_path = (Get-Item "C:\Users\$env:UserName\")
$wslconfig_file = Join-Path $wslconfig_path ".$file_name"
Remove-Item $wslconfig_file 2>$null
Copy-Item (Join-Path $cpath $file_name) -Destination $wslconfig_file

wsl --shutdown
Write-Output "Wait for 8 seconds...wsl close"
Start-Sleep -Seconds 8

$distros = Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | ForEach-Object { (Get-ItemProperty -Path $_.PSPath).DistributionName }

foreach ($distro in $distros) {
    $name = $distro.ToLower()
    $path = Join-Path $cpath $name
    $install_sh = Join-Path $path "install.sh"
    if (Test-Path $install_sh) {
        $script = wsl wslpath -u $install_sh.Replace("\", "/")
        wsl --set-version $name 2
        wsl --distribution $name $script
    }
}
