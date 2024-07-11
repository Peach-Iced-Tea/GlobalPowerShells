param (
  [string]$var1
)

Write-Output "Hello, $Env:ComputerName!"
$IP = Invoke-WebRequest("ifconfig.me")
Write-Output "IP: $IP"
Write-Output "Variable: $var1"
