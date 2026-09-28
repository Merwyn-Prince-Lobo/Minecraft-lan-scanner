$udp = New-Object System.Net.Sockets.UdpClient(4445)
$udp.JoinMulticastGroup([System.Net.IPAddress]::Parse("224.0.2.60"))

Write-Host "Listening for Minecraft LAN worlds..."

while ($true) {
    $remote = New-Object System.Net.IPEndPoint(
        [System.Net.IPAddress]::Any, 0
    )

    $data = $udp.Receive([ref]$remote)
    $msg = [System.Text.Encoding]::UTF8.GetString($data)

    if ($msg -match "\[AD\](\d+)\[/AD\]") {
        $port = $matches[1]

        if ($msg -match "\[MOTD\](.*?)\[/MOTD\]") {
            $motd = $matches[1]
        } else {
            $motd = "Unknown"
        }

        Write-Host ""
        Write-Host "Minecraft LAN found!"
        Write-Host "IP:   $($remote.Address)"
        Write-Host "Port: $port"
        Write-Host "MOTD: $motd"
        Write-Host "Join: $($remote.Address):$port"
    }
}