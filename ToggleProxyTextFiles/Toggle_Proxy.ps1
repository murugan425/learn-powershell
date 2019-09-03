# This function toggle between the following Internet Explorer Settings 
# Explicit Proxy Disabled and Automatically detect proxy set to ON 
# Explicit proxy Enabled and Automatically detect proxy set to OFF
# Provide your proxy in here 
$InfyProxyServer = "http://infypacsrv/pune.pac"

$regKeyIESettingsPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$regKeyConnectionsPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\"

Write-Host "Retrieve the proxy server ..."
$proxyServer = $(Get-ItemProperty $regKeyIESettingsPath).ProxyServer
$proxyEnable = $(Get-ItemProperty $regKeyIESettingsPath).ProxyEnable
$autoConfigURL = $(Get-ItemProperty $regKeyIESettingsPath).AutoConfigURL
$defaultConnectionSettings = $(Get-ItemProperty $regKeyConnectionsPath).DefaultConnectionSettings

Write-Host "Current Auto Config URL: " $autoConfigURL
Write-Host "Auto Config URL to Set: " $InfyProxyServer

# Bit inside the relevant flag which indicates whether or not to enable automatically detect proxy settings. 
$autoProxyFlag = 8

#Print the Default Connection settings
#Write-Host "Proxy Server: " $proxyServer  
#Write-Host "Proxy Enabled: " $proxyEnable
#Write-Host "Default Connection Settings: " $defaultConnectionSettings[4] $defaultConnectionSettings[8]
#Write-Host $defaultConnectionSettings[8] "AND" $autoProxyFlag" = "($($defaultConnectionSettings[8] -band $autoProxyFlag) -eq $autoProxyFlag)

if ($($defaultConnectionSettings[8] -band $autoProxyFlag) -eq $autoProxyFlag)
{
    Write-Host 'Automatically detect proxy settings is Enabled'
    Write-Host "Disabling 'Automatically detect proxy settings' and Using the Proxy Configuration script address."
    $mask = -bnot $autoProxyFlag
    $defaultConnectionSettings[8] = $defaultConnectionSettings[8] -band $mask
    $defaultConnectionSettings[4]++
    Set-ItemProperty -Path $regKeyConnectionsPath -Name DefaultConnectionSettings -Value $defaultConnectionSettings
    Set-ItemProperty -path $regKeyIESettingsPath AutoConfigURL -Value $InfyProxyServer
}
else {
    Write-Host 'Automatically detect proxy settings is Disabled'
    Write-Host "Enabling 'Automatically detect proxy settings' and Removing the Proxy Configuration script address."
    $defaultConnectionSettings[8] = $defaultConnectionSettings[8] -bor $autoProxyFlag
    $defaultConnectionSettings[4]++
    Set-ItemProperty -Path $regKeyConnectionsPath -Name DefaultConnectionSettings -Value $defaultConnectionSettings    
    Remove-ItemProperty -path $regKeyIESettingsPath -name AutoConfigURL
}
Read-Host "Press Enter to continue. Please Restart IE"
