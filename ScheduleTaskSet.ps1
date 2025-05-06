# Define a command to run (example: list Administrators)
$command = 'Get-LocalGroupMember -Group "Administrators"'

# Wrap the command and redirect errors to a log file
$wrappedCommand = "$command 2>&1 | Out-File -FilePath C:\AdminTaskLog.txt -Encoding UTF8"

# Create the task action
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `$cmd = '$wrappedCommand'; Invoke-Expression `$cmd"

# Create a dummy trigger (it’s required but won’t be used since we’ll trigger manually)
$trigger = New-ScheduledTaskTrigger -AtLogon

# Run as SYSTEM with highest privileges
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Create the task
$task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal

# Register the task
Register-ScheduledTask -TaskName "Admin Immediate Run" -InputObject $task

# Start the task immediately
Start-ScheduledTask -TaskName "Admin Immediate Run"

# Wait a moment to let it run (optional)
Start-Sleep -Seconds 2

# Output the result log
Write-Host "`n--- Task Output (if any) ---"
Get-Content "C:\AdminTaskLog.txt"

# Show all registered scheduled tasks (summary)
Write-Host "`n--- All Scheduled Tasks ---"
Get-ScheduledTask | Select-Object TaskName, State, LastRunTime
