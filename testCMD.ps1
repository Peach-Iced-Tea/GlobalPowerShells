$User = "download"
$Password = "nirsoft123!" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# Create a session to store cookies
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# First request with credentials
Invoke-WebRequest -Uri "https://www.nirsoft.net/protected_downloads/passreccommandline.zip" `
    -Credential $Credential `
    -WebSession $session `
    -OutFile "passreccommandline.zip"

# Now $session contains the cookies, and you can reuse it for subsequent requests without needing credentials again.
