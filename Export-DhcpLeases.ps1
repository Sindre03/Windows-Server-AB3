# Export-DhcpLeases.ps1
# Eksporterer alle DHCPv4 leases til CSV

$OutputPath = "C:\Temp\dhcp-leases.csv"

Get-DhcpServerv4Scope |
ForEach-Object {
    $scopeId = $_.ScopeId
    Get-DhcpServerv4Lease -ScopeId $scopeId |
    Select-Object `
        @{Name="ScopeId";      Expression={ $scopeId.ToString() }}, `
        @{Name="IPAddress";    Expression={ $_.IPAddress.ToString() }}, `
        @{Name="HostName";     Expression={ $_.HostName }}, `
        @{Name="ClientID";     Expression={ $_.ClientId }}, `
        @{Name="AddressState"; Expression={ $_.AddressState.ToString() }}
} | Export-Csv -Path $OutputPath -NoTypeInformation -Delimiter ';' -Encoding UTF8

Write-Host "CSV file created at $OutputPath"