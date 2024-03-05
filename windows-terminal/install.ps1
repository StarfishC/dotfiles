if (-not (Get-Command wt -ErrorAction SilentlyContinue)) {
    Exit
}

$cpath = Split-Path $MyInvocation.MyCommand.Path
$file_name = "settings.json"
$settings_path = (Get-Item "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.WindowsTerminal_*\LocalState\")
$settings_file = Join-Path $settings_path $file_name
Remove-Item $settings_file 2>$null
New-Item -ItemType HardLink -Path $settings_file -Target (Join-Path $cpath $file_name) *>$null
