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
    "Connection" = "keep-alive"
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
