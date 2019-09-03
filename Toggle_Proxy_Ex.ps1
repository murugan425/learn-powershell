# This function toggle between the following Internet Explorer Settings 
# Explicit Proxy Disabled and automatically detect proxy set to ON 
# Explicit proxy Enabled and automatically detect proxy set to OFF
#provide your proxy here 
$proxyServerToDefine = "indpunsbd6intpxy01.ad.infosys.com:80"
function Set-AutomaticallyDetectProxySettings ($enable) 
{
    # Read connection settings from Internet Explorer. 
    $regKeyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\"
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
  
    # Index into DefaultConnectionSettings where the relevant flag resides. 
    $flagIndex = 8 
  
    # Bit inside the relevant flag which indicates whether or not to enable automatically detect proxy settings. 
    $autoProxyFlag = 8 
  
    if ($enable) 
    { 
         if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
        {
        }
        else
        {
            Write-Host "Enabling 'Automatically detect proxy settings'."
             $conSet[$flagIndex] = $conSet[$flagIndex] -bor $autoProxyFlag
            $conSet[4]++ 
            Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
         }
    }
    else
    {
        if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
        {
            # 'Automatically detect proxy settings' was enabled, adding one disables it. 
            Write-Host "Disabling 'Automatically detect proxy settings'."
            $mask = -bnot $autoProxyFlag
             $conSet[$flagIndex] = $conSet[$flagIndex] -band $mask
            $conSet[4]++
            Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
        }
    
     $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
        if ($($conSet[$flagIndex] -band $autoProxyFlag) -ne $autoProxyFlag)
        {
            Write-Host "'Automatically detect proxy settings' is disabled."
        }
         else
        {
            Write-Host "'Automatically detect proxy settings' is enabled."
        }
    }
}

$regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$proxyServer = ""
Write-Host "Retrieve the proxy server ..."
$proxyServer = Get-ItemProperty -path $regKey ProxyServer -ErrorAction SilentlyContinue
Write-Host $proxyServer
if([string]::IsNullOrEmpty($proxyServer))
{ 
Write-Host "Proxy is actually disabled"
    Set-AutomaticallyDetectProxySettings ($false)
    
    Set-ItemProperty -path $regKey ProxyEnable -value 1
    Set-ItemProperty -path $regKey ProxyServer -value $proxyServerToDefine
    Write-Host "Proxy is now enabled"
}
else
{

Write-Host "Proxy is actually enabled"
Set-AutomaticallyDetectProxySettings ($true)
Set-ItemProperty -path $regKey ProxyEnable -value 0
Remove-ItemProperty -path $regKey -name ProxyServer
Write-Host "Proxy is now disabled"

}









# This function toggle between the following Internet Explorer Settings 
# Explicit Proxy Disabled and automatically detect proxy set to ON 
# Explicit proxy Enabled and automatically detect proxy set to OFF
#provide your proxy here 
$proxyServerToDefine = "indpunsbd6intpxy01.ad.infosys.com:80"
function Set-AutomaticallyDetectProxySettings ($enable) 
{
    Write-Host "Hello, world"
    # Read connection settings from Internet Explorer. 
    $regKeyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\"
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
  
    # Index into DefaultConnectionSettings where the relevant flag resides. 
    $flagIndex = 8
  
    # Bit inside the relevant flag which indicates whether or not to enable automatically detect proxy settings. 
    $autoProxyFlag = 8
  
    if($enable)
    {
        if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
        {
        }
        else
        {
            Write-Host "Enabling 'Automatically detect proxy settings'."
            $conSet[$flagIndex] = $conSet[$flagIndex] -bor $autoProxyFlag
            $conSet[4]++ 
            Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
        }
    }
    else
    {
        if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
        {
            # 'Automatically detect proxy settings' was enabled, adding one disables it. 
            Write-Host "Disabling 'Automatically detect proxy settings'."
            $mask = -bnot $autoProxyFlag
            $conSet[$flagIndex] = $conSet[$flagIndex] -band $mask
            $conSet[4]++
            Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
        }
        $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
        if ($($conSet[$flagIndex] -band $autoProxyFlag) -ne $autoProxyFlag)
        {
            Write-Host "'Automatically detect proxy settings' is disabled."
        }
        else
        {
           Write-Host "'Automatically detect proxy settings' is enabled."
        }
    }
}

$regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$proxyServer = ""
Write-Host "Retrieve the proxy server ..."
$proxyServer = Get-ItemProperty -path $regKey ProxyServer -ErrorAction SilentlyContinue
Write-Host $proxyServer
if([string]::IsNullOrEmpty($proxyServer))
{
    Write-Host "Proxy is actually disabled"
    Set-AutomaticallyDetectProxySettings ($false)
    Set-ItemProperty -path $regKey ProxyEnable -value 1
    Set-ItemProperty -path $regKey ProxyServer -value $proxyServerToDefine
    Write-Host "Proxy is now enabled"
}
else
{
    Write-Host "Proxy is actually enabled"
    Set-AutomaticallyDetectProxySettings ($true)
    Set-ItemProperty -path $regKey ProxyEnable -value 0
    Remove-ItemProperty -path $regKey -name ProxyServer
    Write-Host "Proxy is now disabled"
}