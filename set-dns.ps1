# Set DNS server to on-prem AD DNS (192.168.10.155)

$dnsServer = "192.168.10.155"

# Get the active network interface
$nic = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

# Apply custom DNS server to the NIC
Set-DnsClientServerAddress -InterfaceAlias $nic.Name -ServerAddresses $dnsServer

# Confirm setting
Write-Host "DNS server set to $dnsServer on NIC $($nic.Name)"

# Optional: Validate domain resolution
try {
    $result = Resolve-DnsName -Name "yourdomain.local" -Server $dnsServer -ErrorAction Stop
    Write-Host "DNS resolution for domain successful:"
    $result
} catch {
    Write-Warning "DNS resolution failed: $_"
}
