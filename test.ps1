Write-Output "Hello, $Env:ComputerName!"
$IP = Invoke-WebRequest("ifconfig.me")
Write-Output "IP: $IP"
