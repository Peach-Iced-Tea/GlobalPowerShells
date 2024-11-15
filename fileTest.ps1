# Webhook URL
$webhookUrl = "https://discordapp.com/api/webhooks/1276442521689395220/CnXvgEAYbwkbYIOC1ZOkG_wmf-2my3mRSQv7Xip6WM3FCRfrjYOctTAe3FKtI8uEs9HS"

# File to upload
$filePath = "C:\temp\test.txt"

# Construct multipart form data
$boundary = [System.Guid]::NewGuid().ToString()
$headers = @{
    "Content-Type" = "multipart/form-data; boundary=$boundary"
}

# Body to send the file
$body = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="$(Split-Path -Leaf $filePath)"
Content-Type: application/octet-stream

$(Get-Content -Raw $filePath)
--$boundary--
"@

# Send the POST request to the webhook
Invoke-RestMethod -Uri $webhookUrl -Method Post -Headers $headers -Body $body
